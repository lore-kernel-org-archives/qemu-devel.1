Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710DCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 361A520786
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="p1GdErfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361A520786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0M5U-0001uI-DW
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 05:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0M4s-0001Od-Cb; Tue, 28 Jul 2020 05:39:18 -0400
Received: from mail-eopbgr50105.outbound.protection.outlook.com
 ([40.107.5.105]:5382 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0M4p-0002h3-Ow; Tue, 28 Jul 2020 05:39:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idDh7botI9aj836YOla6dL2M2lUa15HiOIECH5wmlwneJhc/9wVQIcXcECmPZZx/nfyu9bFNvC2ce+l7IdmdC6yYL9koQ3yCxY04klkNlmH55GLsj0Aqcs4/ngsPyAaLsE1lGVYEf0OHOdr5cjpBl0Bf57nCUa7naquFV7An7DOwVuXhuglOQoBbRlgYheEZmqzJJd4LjVQMWGZ9z+qOrIePofoC8WEBSKuC/CBo2/wMqiVWRWMEB/7EiXCzVtOyHygZ1BWDd2gSsy2F+DUcmAK2HPWqWKtIi6veXnKB/lnjdURUACMn72OtKBOIrnR4dA/ScoRdxjXlsKHwSQD5Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unWYz6u4AEC2XzMtl4hYaJNz8sG6Nem/RR0HkGiViCc=;
 b=f6Wd4wCMaTcVl994N5jnbNXSx5Mb5u7VVXgZe+mCM/j+YIMYlhw2aRmd3hV0TEAhQl1IVFalKX0zWRMjQWU9UkLhcUIXGGr7cRqRZMvyG+CvjYjoo2Wzapd/iaSMPMWc4RvUm2UVFAFBoFI7GJUWRS4vFsuWZKarknIViWC8KGCqAwA3FX7PCwUBFa1lfpxtXp8riRYg0F52hhOFn3hRluoU2JFOLoAzNS4ySWGjBoPLz7D2Kxx1VcMVDGLd8/Sr4U/MGaUUERhIPTWNXytvLcl5S/0+CPAoZcV/U0lAlQXafVH/5apBQjYO6qatQ/KGaK3jOEHO3WZ2f8wxHckjbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unWYz6u4AEC2XzMtl4hYaJNz8sG6Nem/RR0HkGiViCc=;
 b=p1GdErfcZ9S9D3pj+g3Hs+vVrSM4Wgpg7uq5O8VHC6l/p30Cl6ipSVxaeiv8x3YjxgKG4siwU0Njaeq2UzzNQBUcRmQ4XtUliavkR3rsRIFMbMtPk+QWYI5zLehrQrtkdfo+E5sH/rRqAJBqvV0Qm7fpJ1MzLXc6tqFEIEb03FQ=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3446.eurprd08.prod.outlook.com (2603:10a6:20b:45::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Tue, 28 Jul
 2020 09:39:12 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 09:39:12 +0000
Subject: Re: [PATCH v11 03/11] qcow2_format.py: change Qcow2BitmapExt
 initialization method
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594973699-781898-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594973699-781898-4-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <afdea87d-a4fa-d0c5-ec54-5b2ee1602a5f@virtuozzo.com>
Date: Tue, 28 Jul 2020 12:39:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1594973699-781898-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0014.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.158) by
 AM0PR10CA0014.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend
 Transport; Tue, 28 Jul 2020 09:39:12 +0000
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3524bf6d-111e-4930-1540-08d832da15fa
X-MS-TrafficTypeDiagnostic: AM6PR08MB3446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3446A771904126777785E2BBC1730@AM6PR08MB3446.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zs5LClVAHpATlfzQR9E6fgvIDP4+uw2kmIzPiA2cHR2+rMf+WoaN7WzsvkD+0Q2fRWpOlh233FQCCnSqpb8XBP1pqBDs41dgkSfWB+1Hxae7YW+VmcbqxbDwKRyg2kSf2RcWzybndo0HRUM8w3mXIIxpLtnKseZV32yCSzuy/GK0724Fu4Ti4odebsFFdrxA16I8kqYPhYZ9v/ywjSMZe02evIoOQnsHZ62d1F709dA7p1+Nnb1FA0Q8LVK6YYDjYZ7nWPtY2Rex5HooUHwOCSp9zBq3C35rx7pzaUfTI78ZJwCQ1upBrk/RIVkQRH4BmoTHQt4RPo/W0HZyOKBQ/77FSTnpJe6eMC7/K2BzWbkrttQQih1cF3aUNB1oPHwo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(396003)(39840400004)(366004)(346002)(86362001)(83380400001)(31686004)(316002)(107886003)(8676002)(16576012)(4326008)(478600001)(36756003)(2906002)(6486002)(66946007)(956004)(66476007)(66556008)(52116002)(26005)(2616005)(186003)(31696002)(5660300002)(4744005)(8936002)(16526019)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: LYHNrTU8hENPTmzVb5SwXWo/ZwZmu9lqthc7ek15xN0n0+GN/Rh7nxYEfEzAbEwhfgn4ZjpYqBFsX/rZeZI4GHCriDnzai8UD+R/Fh3+ILtFAIJVzCa4CTaJAu1jTTCAo/XXJooQIscFgb5Wb1I7uBDwwNTHdSnQ4iMwn0wrJq3GFU/jCYxVh91batCnv/RAjL7nUI1bsitHiDu8PvbNW1OqXvyDazWN3ugqdFUckc5ATyiHNWT9222HPE8dmTq0z/HqgfeJNs3/So+SVn/FaMEsH6tiC+rHOWudAcurfjKWRVYNk+5HPspCBgCqesCm9w/sufG5cCd4kVyOPtBKf+vvE3h7zS/YfG7O/75iriJlxlKYlOY0rql9d/nLH8+/mlZlIZhsfkidElxcNLckFA4PesPvFTzPTkde7EoIuBebeuomJSlQwx8C/10Jhx1rCcXIsEepbDwHIB74UEAg0Bqnb9r9bSScUpcTAasMyOFKFbr9BwaMnWaQp5gBoWmn
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3524bf6d-111e-4930-1540-08d832da15fa
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 09:39:12.7070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmCyVhLzqcKuDI3bp9WCiIfAPof20m2JJ0hzNiuU0mVMP0xxL31OPxNWRLnT8T39RpmVedx67LSFDiC4jSIS4uEKpNptdDRipN3J+R0H6D0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3446
Received-SPF: pass client-ip=40.107.5.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 05:39:13
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.07.2020 11:14, Andrey Shinkevich wrote:
> There are two ways to initialize a class derived from Qcow2Struct:
> 1. Pass a block of binary data to the constructor.
> 2. Pass the file descriptor to allow reading the file from constructor.
> Let's change the Qcow2BitmapExt initialization method from 1 to 2 to
> support a scattered reading in the initialization chain.
> The implementation comes with the patch that follows.
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich<andrey.shinkevich@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir


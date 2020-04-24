Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FF9C55186
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 17:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B1120774
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 17:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fjunO8wG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B1120774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS2RB-0002R1-DA
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 13:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jS2Q4-0001jF-NA
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 13:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jS2Q0-00004t-5H
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 13:47:19 -0400
Received: from mail-eopbgr70124.outbound.protection.outlook.com
 ([40.107.7.124]:6003 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jS2Px-0008Mu-Jn
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 13:47:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAlTfYXSlU84dfjRJysiqY/NdRl+hTIued4wxlJSeT3k5W+dMyD9Y/4AWjREBsyuuk+xpxfK8XRFiV6S7SE0+6aW+skfPamWqZyhMEgBnwvzznOQSoKIXqkPvitE22hZ0t/KhPe5NJe+t7eUuayTWG5DCdulTmI0QuVDJv9DIg9njQVTwryM/zBO+TqkpBJDr+kpCFQ6vlecrZo+C+Blejq8PyepKIXw5c733uaIMKqNVQBt0zP4R5yysckKHBJGtmWg9HFzSQw426jg4ZAO/dW/cKqfWA6+ZamcuOXfEManhucsNBSjZ3gmhrTBroz/K0KpYkUs6ZO1aKguPvgXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScxtjwDEcwhyL/2ENzgb95i4th8up0CBD7Dnp+um3c4=;
 b=ITNLCp7FP2gTe1NQMZh++/nTcuL0X/mWzQwyKLRbjviCsmAn969y4aVSUPS8ZbAXaG0GE70DtJ0HW6U+qIplpORQzHBx2qsEceL7qG4nuhpxiju6HgkG5DEcj9qGBydMJXtcHSslZ4/MCCQHS4WU9H0IeFXRBXDpHITpC1cyoF3ipMO2qosY4Ap0xMQVaabDGCDeASw5PBtnNMljzWWo/iLKaHw6HfU1qkTjxDtqzmfbqJn+uddNSFMcekSDOntS2JupvF/BnJ+VTL+lQx3EVBt+fX27kM1/O4TPRLjgVziAfuyjvYesnu8FV8xoB2lMSeNPS1hsiSD4FrOPEAh3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScxtjwDEcwhyL/2ENzgb95i4th8up0CBD7Dnp+um3c4=;
 b=fjunO8wG0Cm1ligvDXfDihUDeVguEQc94koOzkwZzoyDa6LeMsALuwHwfCZfTXLWuam0CmqmWvq3iFUPReOzWODEuSUPYFJlKYuZeSh7I1xKAnunP/W7iWjf11dcInzJrNpehspfTv19HdKSmE1yqBXQ19C6//I5TGW5f4vbE5s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5510.eurprd08.prod.outlook.com (2603:10a6:20b:109::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 17:47:09 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 17:47:09 +0000
Subject: Re: [RFC patch v1 1/3] qemu-file: introduce current buffer
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <1586776334-641239-1-git-send-email-dplotnikov@virtuozzo.com>
 <1586776334-641239-2-git-send-email-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200424204707763
Message-ID: <9da701d0-09f3-bdff-fa94-cfcfc3f9d716@virtuozzo.com>
Date: Fri, 24 Apr 2020 20:47:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <1586776334-641239-2-git-send-email-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0101CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::11) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.181) by
 AM4PR0101CA0043.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Fri, 24 Apr 2020 17:47:08 +0000
X-Tagtoolbar-Keys: D20200424204707763
X-Originating-IP: [185.215.60.181]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecd77112-c034-4631-c18a-08d7e87782f3
X-MS-TrafficTypeDiagnostic: AM7PR08MB5510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5510295FEC6D3C63E3C421A3C1D00@AM7PR08MB5510.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39840400004)(16526019)(31686004)(52116002)(16576012)(5660300002)(8936002)(81156014)(26005)(478600001)(316002)(36756003)(6486002)(8676002)(31696002)(2906002)(86362001)(956004)(2616005)(186003)(4744005)(66476007)(4326008)(66946007)(66556008);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xWnZ6ky5zPwCj/zTg7oDNtQsgVDOCPmmMopHn9wE2sNdfI3xZkTdtchbACEquLCbN6iqETTTRk0fsAB2xNHA+2YXzl18/VAPQxkOlMhJw0pCuCAoYUhP+g7o4HHxK9OcWfhbZCOgvGdj01Y4Dw/s+8/hw+QCXwoSX9xtEP32Zpf1NhKQNz7LETnlo2rzGzwMsSrVIO9CZO0y/YXKwVWd5RmcP2MeED1fVCbxqKBzVlQFloF6RACwrcLt6BkUEz5FMF3pUJqAuIN7enUO3iKpYwcflVD15WIF1g8ruv9wWx3eVS+isr6F9rm9VEeN+FPy2KNPMfwp9o6VzVViUbQTbs3erDi1suizp9cryDnR8BFt5+f1sIDjTmEJaVB+9MY1PkXfzSX7TVkjjb9mMUwqgtdt6p5IgDJrFzM/gQHkvqApzY/QceOLlLUAI81oFOcG
X-MS-Exchange-AntiSpam-MessageData: 6NmvAuOVpie8Q4671QYYvWFlQ/YZHbYWL6ZIxTEhCtOX88naUhHbkiAc4hKovqIVrbup1x/BC2187IA4m5YAAXjNQw4TNZMYOpKHrurC2fdX/OeleAZI6rYO2PFOCrOEkoA3mY7Wn9NNKnComZ6VvQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd77112-c034-4631-c18a-08d7e87782f3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 17:47:09.5086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Ce1YzARldi7lpiAoWLr+xarRcH36/7MhuW6zPeNzEhMpr/bzl370rcgZH6dsV9YtxPGE5WteME45risA8TLfJz7T/xRPQdzGBYslMA+eAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5510
Received-SPF: pass client-ip=40.107.7.124;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 13:47:10
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.124
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
Cc: den@openvz.org, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.04.2020 14:12, Denis Plotnikov wrote:
> To approach async wrtiting in the further commits, the buffer
> allocated in QEMUFile struct is replaced with the link to the
> current buffer. We're going to use many buffers to write the
> qemu file stream to the unerlying storage asynchronously. The
> current buffer points out to the buffer is currently filled
> with data.
> 
> This patch doesn't add any features to qemu-file and doesn't
> change any qemu-file behavior.
> 
> Signed-off-by: Denis Plotnikov<dplotnikov@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir


Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3ECC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:57:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1452206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FpFfQdda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1452206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssmK-0000Fa-98
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jssdW-0000y9-BQ; Tue, 07 Jul 2020 14:48:10 -0400
Received: from mail-eopbgr80131.outbound.protection.outlook.com
 ([40.107.8.131]:51585 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jssdT-0007gA-9A; Tue, 07 Jul 2020 14:48:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cc/5GsC2i4PcAsNyCJXfmcO9F2Zw8QHQNerajVGyxBbXkTj8WCGOTC1dHPXH2CaAM2hJwUros+hLAfLkPDn2xnCWHca35rb7I+eYt3jSfdony085Jw0a0CVdeaVmyErQjX3WU1j0cmYv8cGz0eCNzJAAKSk5eJhUv/SgdHcLCWILg53TF3yLuv65kuG1b0i3RX4gxbu2mD+u8czKUPJUJbX8Wfvihf4Ca1yGmlm+4bgBdkyfapds9DnBigGu2aHIghWm7/j5kSDPthQuu5LDWuEq8wUnvO7jxfxfcrwoZR8lj7kEXAGc+meJ1fnOmAV6KrrKxoNHpznV6LLvKnqtIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOacSb4oX/N+euakjpkVsJbdOajqWcZuGY9DL710w6c=;
 b=CtaAH06D0oZMDc8/ma3Jpe1ZVLt2Lj4sBkzfsWJ0E6aPOIGyOntkWOeEriDQLfI/eaMa0Boadyi5il5VfekUe5LB2aovqkmMSD2PNGGh93KzPBxhPmLc04lRUiqpxhSQWg71ZB0LGu0illDcIQRpPnOFQ0ebv6IsdjnXzkmnkbLRzMbdhBCJXeN567s+u109U0UBtvyGs7DIamiScqoOU46zkrvyXihpMD7JoZPLm0SMzVmACnaIs0pVLHAHw/M5YoY/p6k2/9Sm0ellBI541UyxyjqctT1fmbhTz0R2/nemoWqmUih32f6RViax68/sbVsgJ2EMX/TPomiwJWgYkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOacSb4oX/N+euakjpkVsJbdOajqWcZuGY9DL710w6c=;
 b=FpFfQddas2Tz8yUWtaW2zVczE/irtIDWTytLuu/bshf1K6OPuY6i9AwWc7xpc2uwX+whZdHHF05uDmFrrSsZWFSabnKM+fE9x3MAy7+IKpY4NtqRfxD9sIu7WmmjVlf/BzBt85PoHZusDJ4II4n5RZ2bdZwdArJAo1dP/JMFH0k=
Authentication-Results: linux.vnet.ibm.com; dkim=none (message not signed)
 header.d=none;linux.vnet.ibm.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR0801MB1982.eurprd08.prod.outlook.com (2603:10a6:800:83::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Tue, 7 Jul
 2020 18:48:02 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%5]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 18:48:02 +0000
Subject: Re: [PATCH v12 0/8] error: auto propagated local_err part I
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200707165037.1026246-1-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9aec78ec-058c-37a9-4fdc-05f0613880b7@virtuozzo.com>
Date: Tue, 7 Jul 2020 21:47:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200707165037.1026246-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0141.eurprd05.prod.outlook.com
 (2603:10a6:207:3::19) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.58) by
 AM3PR05CA0141.eurprd05.prod.outlook.com (2603:10a6:207:3::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.27 via Frontend Transport; Tue, 7 Jul 2020 18:48:00 +0000
X-Originating-IP: [185.215.60.58]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e38c8d3b-020c-47ce-0d7b-08d822a6469b
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1982:
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1982D4DE4E4FF8CFC5E90B9FC1660@VI1PR0801MB1982.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VO+ttkIpBnsq9+iQ3jcFFzNWsyt8PQI9EIkiGbps6NGnqpJnIFirfQ+WVDl38SztfeQeWizod/Y332HrJcQ+PCuomUvOOj+KvQErS8jBGY6kCsMOH37gsM9wReyvhi6pXlhYWqy+VaIBN5clIYTyrQbWZqCRt8+uxA7JZhdZFzfMPIUrIubwF9un4e5SSRsMThYAGQENXtjA/qWQq1DOWd4pPdmYA8uZJXpenpvizVpAozt3Q7GYKSy7NpkL6D+/YNKVSF2/Bzhxx13r5K/uUqwgbaaO0xkL8zXkFlZampuhBODOZlpgyX0if/va/+yXu7YHeSMAmRuRXh2icnBVYJoqoAgaeBc9+uosk677dzVh81f8ybhKl1Hhp4MCPUkQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(39840400004)(136003)(366004)(396003)(7416002)(2906002)(36756003)(8676002)(8936002)(31686004)(31696002)(2616005)(956004)(4744005)(26005)(86362001)(16526019)(186003)(478600001)(4326008)(54906003)(66946007)(66476007)(66556008)(316002)(16576012)(6486002)(5660300002)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: lxpB24rJ3lu2hNbV+N/3UjDemjLtW36cTPUo1nRQZn7kep1b6ZNs1iNKmbS3D35kwEgRkUc1vf5W6k9eNx7PHmcGFG8TGBibLSeff5jg/k+Oi/8ci0A419ryFGM6vlPmgps+T1SRhzdOgzyNh+GvLVC+Hy3fvdNjTXIHQjUclZaQ4FuPVCW+DFr9AGH23kmylT0fj9wD0qKkz0TA9XNQd+k+nOprTKhYm3DoP147ntjsg/hR485eys5fBBkAiN29Dpc2VIvHBnZ3S1DINpnf1KM57NfXYoDgCdEuYU2R88XbOeElK5/tjXmp6l6hJh+QVXHz7Tgutlz6wvEAVyVJyE+2a5XNSLpAHU/Wk/JWWehfmncOIvzgkfiKDWLDhfgayiTfFNze5BnapzFNOTsHFXf3N5d6tnWKXO6oggNs8Y+l8KXPSujWUMHfB9QamITWHKTEb1UveBICDWaFAnI9mT2p9SeS5Gh8UbXW5iDd0Zo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38c8d3b-020c-47ce-0d7b-08d822a6469b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB5503.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 18:48:01.8631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: isIu3/EOtpaZKJvfN+zNS1VKgSiuv2YKnu3hcZ3npJq4mZA/jOK54RCMtyQMdJ1sFlsKRcP/94DiqQo+0yr22Lymw1KrUOfniEdgLp/0TLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1982
Received-SPF: pass client-ip=40.107.8.131;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 14:48:03
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laszlo Ersek <lersek@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, groug@kaod.org,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.07.2020 19:50, Markus Armbruster wrote:
> To speed things up, I'm taking the liberty to respin Vladimir's series
> with my documentation amendments.

Thank you!

> 
> After my documentation work, I'm very much inclined to rename
> ERRP_AUTO_PROPAGATE() to ERRP_GUARD().  The fact that it propagates
> below the hood is detail.  What matters to its users is that it lets
> them use @errp more freely.  Thoughts?

No objections, if we are making error-propagation to be internal implementation detail, no reason to shout about it in the macro name.


-- 
Best regards,
Vladimir


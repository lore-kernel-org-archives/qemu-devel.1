Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61340C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:05:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B88D20838
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PXw87HA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B88D20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJFe4-0004KH-Ao
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 08:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJFcu-00035O-Lf
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJFcs-0004Vo-Kl
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:04:16 -0400
Received: from mail-eopbgr40120.outbound.protection.outlook.com
 ([40.107.4.120]:30643 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJFcl-0004PO-M2; Tue, 31 Mar 2020 08:04:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSYRE5+chrXkyqPHfPut4V2GBaCE1VhxrlkpIERcuaRtFxcKklJaP2PozEAOSKyjeEGXKgkUEqNRy/XOZhYYMTB699pqKtVH+qkMoohuxBQ38IBYHekS8Y/ClPEpY0aA4i6QtfPxILr62NSAafhS3/mPIkQ8yNmx7sUv8CXKT95vsnvGJDDVtUoSplbVuGgbpGBG5GZQgxAsOS2MtnnPGCraAzQOpFTxf7gWU7YinysvOgijNo1ls73Fb3Qge2NiPMO7iegthsm2X88mmaSALlz5npzTqadyEpToyFJytU09c4ZycdmMB4uHgJjBXj3W2sLHBMejesapCkciVIjkvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5z//KLEhx5Pv7YLIm1jyeDMwKubyG6uXMtmLuhOjfrw=;
 b=NEHA2mo4Hc0poQTLZnbt067SACtRD/34ybLJWuZiGFPw900wjfSC+f0Kvg90uMTEd3YCQNB1eq8Up1EcalaP7oF9MkJsDWfmVPHEYT9dT39C0nEJ18ZqlwC1CvIhn+A0ONFGOkdcHrBV1bn95eFSlUu9kGUaqvIMM6Mvsd/Ry0RC2FoRHhQ3H5KymwgCBFhUsNBdMXeSCFbZJ9MVwa/C82Mmbz6Tlucc4WPQJQvzbl5liZctDUQtDY9g5+rW0OzQSh4pWTVgJRMeOFk9wlR6DKou4b6zgOUVYaEsBpV5xpLMskapFgGPudbTUpeqRCkNuD6wnTSGPFZ30qphRAnyQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5z//KLEhx5Pv7YLIm1jyeDMwKubyG6uXMtmLuhOjfrw=;
 b=PXw87HA1l/UVf3iCwOkPLY0Giz3fLYFDmI59NCOWessdtJv1eIby7NRe5KgY5fBoE/m8695r9rZE3WZbD4f/yBchBxwnWaXP49sR4ZVgZUpWY7oXqx3vuhWmyaFG7DKxQ3jFrvmiJHmW2wFvdzHPaLD+r1uxr/kLw2089G3pddY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5320.eurprd08.prod.outlook.com (10.141.171.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18; Tue, 31 Mar 2020 12:04:04 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%9]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 12:04:04 +0000
Subject: Re: [PATCH 6/6] qga/commands-posix: fix use after free of local_err
To: Markus Armbruster <armbru@redhat.com>
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
 <20200324153630.11882-7-vsementsov@virtuozzo.com>
 <012d4cf0-e168-a9ea-273a-a683e50ef7a0@redhat.com>
 <3e28eab6-a7c8-a9b3-84bf-b98e241139cc@virtuozzo.com>
 <87tv24ycfd.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200331150402221
Message-ID: <cdae9609-f04f-9518-86f6-2259196379b5@virtuozzo.com>
Date: Tue, 31 Mar 2020 15:04:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87tv24ycfd.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0078.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::19) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.2) by
 AM0PR06CA0078.eurprd06.prod.outlook.com (2603:10a6:208:fa::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15 via Frontend Transport; Tue, 31 Mar 2020 12:04:03 +0000
X-Tagtoolbar-Keys: D20200331150402221
X-Originating-IP: [185.215.60.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fbe2520-9378-484f-93c2-08d7d56b9ba7
X-MS-TrafficTypeDiagnostic: AM7PR08MB5320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5320102093173DCB6D0AB97BC1C80@AM7PR08MB5320.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0359162B6D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(376002)(346002)(39840400004)(396003)(136003)(316002)(66556008)(7416002)(66946007)(6916009)(4326008)(2906002)(66476007)(86362001)(31696002)(5660300002)(6486002)(31686004)(4744005)(16576012)(478600001)(26005)(186003)(8676002)(81156014)(2616005)(8936002)(956004)(52116002)(16526019)(36756003)(81166006);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oh0YV+iEg6fRAdRgSSSRv0l7athEG7+d+3QieDs7AS3OZL4wovDVMGYZJNDZFYclZkR7Us6yI36KxZC/NN/ViVbX55gMF7n2ihXA7KzHXlarR/toDf3li4v5o5AKA608s0wjylFm85OeAQkpKBc2/dAu6Jztnksev9quKQCWRjXHZUk/62o1eEKuFSvktAB/Ibk8RbmpTvWnouh82iRq22oHuHphki0p+SydKi4JV6Q7pranw28zLbMVtMi0vwXXiPTnFdlSlH4XU5VrhT/B9+Y/N+OxKGUUJk+mv3Pqbwu25QY94wkwDn4lK/QKgrkPazFeBTKoKi1+N53N8LjvCFTTynSYs8zcS1aoaw3js8yNCybZopjOcCJ8fDn1gaXBp6ohBQN2K0ILZWuLL9yn1MAg0XtOE8d/Y94FjpBbbDcekyScG07DLLm7eQLtTlfP
X-MS-Exchange-AntiSpam-MessageData: +0bf13TsUi0YhYRWi+ECEJBigKsnEXmWB1dSV7O4kvTZlbOrM9KCCUGm/5T17dsNglGVIGeX+/JZTqrnsVFCtw5nJYHv1j8GXPTY8jKxD5TVJR0olOSFA61b37WZp4XRuUWXl+mozfJkLOWcWVRCkQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbe2520-9378-484f-93c2-08d7d56b9ba7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2020 12:04:04.8251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJlZ2TM9stfmz01ZDNgXQ7WZ4VJcAnC9KzQV3A6h1YMnsbcPNDRVFa/mxjDjp52ekKDTTYAuIYsXGBI1OqDeRK7rtl+W3aCLtpyYLfEGozs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5320
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.120
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
Cc: kwolf@redhat.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 quintela@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, den@openvz.org, marcandre.lureau@redhat.com,
 mreitz@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

31.03.2020 14:46, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
> 
> [...]
>> I agree that this is a strange function and its logic is weird. But I
>> don't know what the logic should be. My patch is still valid to just
>> fix obvious use-after-free and possible leak. It doesn't fix the
>> logic.
> 
> I sketched improved logic elsewhere in this thread, and I can turn that
> into a patch.
> 
> I can either make it replace Vladimir's patch, or make it go on top.  If
> the latter, we can apply just Vladimir's patch for 5.0, and punt mine to
> 5.1
> 
> Got a preference?
> 

I don't.

-- 
Best regards,
Vladimir


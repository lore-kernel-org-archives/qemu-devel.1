Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7C5C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 19:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01B772076A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 19:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sTOmGm+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B772076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtyf9-0007Ve-5G
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 15:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jtyeT-00075W-Vu
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 15:25:42 -0400
Received: from mail-am6eur05on2109.outbound.protection.outlook.com
 ([40.107.22.109]:36833 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jtyeR-0004jF-4x
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 15:25:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqJxo4X+AoH0X57rDKh7UaEHuItaDZ0fXTahm9qsA4unH6E64zqdljCn8RpvSGw+bOsjoK9dzscCLYappLpp2ACuvRMLDdhRdJeMiDXY6imv7c6606lzn0IbgtMCEGYaRvTyX8Q7LmDGtoeXU1q7ZqnRj1vLX5PHL0XchhEJFfqObN0T/AZrD5smVWEOw5qFyF2nxyPVNnOFRoq/bLHVXZscPM+TnX4oz9gb8ZEk1bPTAycwckDGdbXFH4LiOZpGHqGVfDRdANHbfAAg60I1ZL1V6ZDbkzAjScyzjZZ0stFpf4KAgmfCiHpYL4PVty5i0lyQYZOVx6Bl3W/tZ6k6yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbL12O8KcASqx9Ef8Uxq8Of7u2sEx5JITVLGcgMDB5I=;
 b=U4CEbOAkhGNr5RKqtybB1EAO6Bm4kigm/KDl/VOP5FmAo1nXV8x9SbzNmnB5c0aj4ReSEhPgf91kCPcOG53eFzNdg1t6DtQEA4FE9tLnqpWH8KuARSU2+sla4j9oS1MW2hDdxNwQIDN62+7DL9Nv+ex2fuRM3Wk6V/LDjgutAxaG4tj26VPQrfeIT3zBhWna/pdPb8OUdPlsGBxTbSWZft6FQBKzxShV08/c/h8spwxSjuIVYi0n+P5AUEEXe6sPrjpulZHwBrV7buOM2amrsP4D5uSFFPLQVfq0vQFDbyZQmbrU7rgCNN/yURvmoqqRIOtCx2N7cxh2Uwp0w/KYsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbL12O8KcASqx9Ef8Uxq8Of7u2sEx5JITVLGcgMDB5I=;
 b=sTOmGm+lDcp1ahlFOCsPrXoNuiCXHKYdKZMIspVYdzYE1mqetmAuLk9LFplvgFHpAEu+uj+QCMoJIAlA1JJdidxCiO4Na2N+MjUTgN2ZF9Zqn3+auOSk53gji/FmGQtxMcHUFN/OLoIUe1ftZh1m6ZspXV5/Tfk3bJtcAtLn4Gw=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4690.eurprd08.prod.outlook.com (2603:10a6:20b:cd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 10 Jul
 2020 19:25:35 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.021; Fri, 10 Jul 2020
 19:25:35 +0000
Subject: Re: [PATCH 0/2] keepalive default
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20200708191540.28455-1-vsementsov@virtuozzo.com>
 <20200709083510.GF3753300@redhat.com>
 <daa7864d-8979-1987-caf7-cca3cb9849ca@redhat.com>
 <436ac597-c25d-16a8-31bc-a895938af807@virtuozzo.com>
Message-ID: <7c775f5c-e748-a638-c814-4c41832b523d@virtuozzo.com>
Date: Fri, 10 Jul 2020 22:25:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <436ac597-c25d-16a8-31bc-a895938af807@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR07CA0022.eurprd07.prod.outlook.com
 (2603:10a6:205:1::35) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.189) by
 AM4PR07CA0022.eurprd07.prod.outlook.com (2603:10a6:205:1::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.11 via Frontend Transport; Fri, 10 Jul 2020 19:25:34 +0000
X-Originating-IP: [185.215.60.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78dad175-6fdf-40d3-5cf4-08d825070502
X-MS-TrafficTypeDiagnostic: AM6PR08MB4690:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4690C750924C4D2B961C1B73C1650@AM6PR08MB4690.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jQFwq08G2DDIy6LDz4f4Fn8V79HDwAsQj+PMEWEG6TqwqnVFRIEwRGFqOertnqmYl94m+ToRcKXgx/0eLJgsx8UM5zrFWPogBuPtUg8xcwDMASHkbdSNgYQyvtpWFif2mP3MKwsINouRUIKuYNe14Ij2AQwMcLM8uac8/LLPVgoSqCbsEiHLh/ViMOamJQ8di9OTqbWudF5wMVYVz7QwP3UIUxwg0mP7RVDiWm9ELBG5FhdZEB4n1H1k8tlxJXBw/9+hcY7RYJ/N6BeI5CsTmvGAS6meP/xnyammtCgg8VeCPPV4xU5dtDbjQlXqkgy7+yYhnMJqaNafHprLe2v0TBi5eWLySX2UsnyVVyKiid2XIDarXrqYdA9Fau9KpHSW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39840400004)(136003)(346002)(396003)(376002)(316002)(4326008)(16576012)(2616005)(53546011)(186003)(16526019)(26005)(478600001)(956004)(31686004)(31696002)(83380400001)(107886003)(8676002)(52116002)(8936002)(110136005)(66946007)(2906002)(86362001)(66476007)(66556008)(36756003)(6486002)(5660300002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: RvFA6Ja4yyfKSJNVO3lRnvxeg2De9SM4tL/uKexv31cTw+635r7aHyUBoEulaJ8AXlvAUnBFTXxVCy8neixiUiOid4e0xr+SVvwMg9ueYb12HrCKVI/hHV82Tgqa+hWrDc6ZBdXFKy8tLAqCdAVB5IThRpopD+XX38IcrgDGMrKDTFJsVwM8t/4qy7yI4fLvXpOlYEgQOMUIDE/twLr4HaGhcIY/Gt5bmygLIIur4AYivqgbFs2oVakoqWburYlOjdwZgnVguSYa6TELVJvxCHV+YVxP1BK9yay1J3m1NARIeVHKltBtlEOGsSxwaEURqmKvnmyqd1BSSKl2ZwSCUu4lsNJkZXrSWzyJ6SaCY/NUXhP5vMz1Dk3dHdH0LsfzAF/pYm8aYn/xwsXRqEJMy/El5CKbikZfUvq0zNOtfpF9mf+r5BtDZFFwnRyPM12JCrw/8XdqCJ8xtZcYL80wELOWshCBQuxEkNWYI3hkpQZRXcXy5k60/BMUysVDT1N5
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78dad175-6fdf-40d3-5cf4-08d825070502
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 19:25:35.3169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y4uMOUIWUzQOaIUIbRpupMSwqElekdxOx7tqHB2mkCq81aukgMBa3aMXKVd9v+pBEKsUg3YMYOBb4GgduzDl9zvUpdhvC52xjhoMt3EkYtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4690
Received-SPF: pass client-ip=40.107.22.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 15:25:36
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: den@openvz.org, kraxel@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

09.07.2020 20:14, Vladimir Sementsov-Ogievskiy wrote:
> 09.07.2020 18:34, Eric Blake wrote:
>> On 7/9/20 3:35 AM, Daniel P. Berrangé wrote:
>>> On Wed, Jul 08, 2020 at 10:15:37PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> Hi all!
>>>>
>>>> We understood, that keepalive is almost superfluous with default 2 hours
>>>> in /proc/tcp_keepalive_time. Forcing user to setup keepalive for the
>>>> whole system doesn't seem right, better setup it per-socket.
>>>
>>> Adding the ability to explicitly configure the keepalive settings makes
>>> sense for QEMU. Completely ignoring system defaults when no explicit
>>> settings are given though is not valid IMHO.
>>
>> We already have the ability to add per-socket keepalive (see commit aec21d3175, in 4.2).  I guess what you are trying to further do is determine whether the default value for that field, when not explicitly specified by the user, can have saner semantics (default off for chardev sockets, default on for nbd clients where retry was enabled).  But since you already have to explicitly opt-in to nbd retry, what's so hard about opting in to keepalive at the same time, other than more typing?  Given that the easiest way to do this is via a machine-coded generation of the command line or QMP command, it doesn't seem that hard to just keep things as they are with explicit opt-in to per-socket keepalive.
>>
> 
> Hmm. Looking at the code, I remember that reconnect is not optional, it works by default now. The option we have is "reconnect-delay" which only specify, after how much seconds we'll automatically fail the requests, not retrying them (0 seconds by default). Still, NBD tries to reconnect in background anyway.
> 
> In our downstream we have now old version of nbd-reconnect interface and enabled non-zero "delay" by default.
> 


And now we need to migrate to upstream code. Hmm. So I have several options:

1. Set a downstream default for reconnect-delay to be something like 5min. [most simple thing to do]
2. Set an upstream default to 5min. [needs a discussion, but may be useful]
3. Force all users (not customers I mean, but other teams (and even one another company)) to set reconnect-delay option. [just for completeness, I will not go this way]


So, what do you think about [2]? This includes:

  - non-zero reconnect-delay by default, so requests will wait some time for reconnect and retry
  - enabled keep-alive and some keep-alive default parameters, to not hang in recvmsg for a long time


Some other related ideas:

  - non-blocking nbd_open
    - move open to the coroutine
    - use non-blocking socket connect (for example use qio_channel_socket_connect_async, which runs connect in thread). Currently, if you try to blockdev-add some unavailable nbd host, vm hangs during connect() call which may be about a minute
  - make blockdev-add to be async qmp command (Kevin's series)
  - allow reconnect on open

also, recently I noted, that bdrv_close may hang due to reconnect: it does bdrv_flush, which waits for NBD to reconnect.. This seems not convenient, probably we should disable reconnect before bdrv_drained_begin() in bdrv_close().

-- 
Best regards,
Vladimir



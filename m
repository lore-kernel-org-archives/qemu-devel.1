Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B230C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 06:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D77AD206F5
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 06:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="A5Bso6+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77AD206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJtYi-0007XO-2K
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 02:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJtXi-0006Qc-TZ
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 02:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJtXg-0002sI-J5
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 02:41:34 -0400
Received: from mail-eopbgr140120.outbound.protection.outlook.com
 ([40.107.14.120]:60993 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJtXZ-0002aq-8t; Thu, 02 Apr 2020 02:41:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/BBn/S9Q1Z+8PC5twIKP55DbucUzxOm+wuYoF/IwkjqujDUT/qQ6Zg3I1KaYo47Quade4rOt4YBCmHyVFN7qzeHhoDt7AngUL9/htaTGyzbOHvIT48TtGkagvnMWQn9jubuIzFJDworkj9VJiYd0nGZp4NcG4Dl0yl+vuqAPP+nSLAOe6Ccdpy5X9xzTadcXEqVax6LY9iQstFYka2KbKB+frEEdMPgQIBUCR/TSRmbXDzQZrJ2m183HRLTI84JdtSZ9NXp4sXlmsXGV+iTCZ2huPjbLR0yHlLPOnyVn+/pWPro1NgRKmYeEi41sqEOTgxLH0ME7Cskja3xfAeRAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8D9mJ+CihvR23st0bXqxg85+/4bGfS9QMiBVjQrzMoI=;
 b=n/s/EWRkCfTLQLVWZVKf626ZIF9JDPZ0y+zE745rM0X+WphSJ9I/YRwcOBF7JhyxLSCP7XtY8salEr6RDvYCvX5FpU4TLvyxjn9WAiQl5Opa36jWCHYIjxYWTS4csY/l2pysAxup/8B5qdmP8qZ8kexk7iR/ZCJ64deEc+k/QL1rNmn2cTJokPzrEraBDxb4gBc8b06/bFZuQ4Nc+PrV00du50S+DoxRNNzlnYsxXiW5pR2BfSCv4t4hPKX2xpv5uJ8uC42YwjGU0pbEDeIq5Ka/VL7w9+pjHWnFBNBApA/L/bSxy6vuCurFV+SbsBpbRXWSPotxb1TGCRDQKmnBIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8D9mJ+CihvR23st0bXqxg85+/4bGfS9QMiBVjQrzMoI=;
 b=A5Bso6+2I10vQRHlibAYqOQF6rC06q1CTbRFDcI8yH+ZDh6t9RaXoD8yIK/D6tooZ1waEL1Mh52hsNjxZ6jmCeYwAVf74LX6T6y6Oduph0Oe7051WoFkSxmwLdnkaZy/sO4Z+kZ6xD30eh5Wn5BI2cPTsW4rh8sDpFOoJA5Zi2M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5496.eurprd08.prod.outlook.com (10.141.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Thu, 2 Apr 2020 06:41:23 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.016; Thu, 2 Apr 2020
 06:41:23 +0000
Subject: Re: [PATCH for-5.0?] nbd: Attempt reconnect after server error of
 ESHUTDOWN
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200401223841.312793-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200402094121413
Message-ID: <46a13f15-fab5-1742-5bd3-30fa59b4b430@virtuozzo.com>
Date: Thu, 2 Apr 2020 09:41:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200401223841.312793-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR05CA0007.eurprd05.prod.outlook.com (2603:10a6:205::20)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.23) by
 AM4PR05CA0007.eurprd05.prod.outlook.com (2603:10a6:205::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Thu, 2 Apr 2020 06:41:22 +0000
X-Tagtoolbar-Keys: D20200402094121413
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7b60ffb-88c7-4476-2c1f-08d7d6d0dc10
X-MS-TrafficTypeDiagnostic: AM7PR08MB5496:
X-Microsoft-Antispam-PRVS: <AM7PR08MB54968C80693CF7D4250B8B49C1C60@AM7PR08MB5496.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(396003)(346002)(366004)(39840400004)(376002)(966005)(5660300002)(81156014)(81166006)(31696002)(16576012)(26005)(8676002)(16526019)(2906002)(478600001)(31686004)(86362001)(186003)(66556008)(36756003)(66476007)(316002)(956004)(2616005)(52116002)(6486002)(66946007)(54906003)(4326008)(8936002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QGmyA+R6EbyEC3Cx2bLO8F5QE6/fUNm7OQDzUNNFKQ1nNsnoxMyMqzzuOSRtQBGOrXfZ9jan+u1kUYDtpYONNfZ1cpWT7wx7qeXA/6+o4iBb1yBxuYQqDn9r5675ma4j53L1bvBQyza8SHld7g8FQKRbUk1Uctwh3JDcpRz3mkINuIdTqAJBMjYlz24NC7j16xLBy3tM6N9ifznNrWRFbHFKncwp4Bhx3cdDheB2XTq8z3xxq+egJRK8kI7clZK4IyPb4SDmn9nS2p4zLQ/KzQ7zUMvJmE7RmmYqjj5aLk6NXz1lvk1bKOI3r2uop48yuo9LB24GWYpKymDGQF5rLVBAU+mjkCZjTgHQUOyXnrx7rBWa2Ow8jvuZGmEFLO8fzsD6cijRiEDMTRlA4+vSkdlmWxXxYxYDBBT3CWPrGzwW2eEqRGTR8XUWgI9oNruWIwTW7PVpxEBDiaQlTLP3fbW3d5MLC8uMKW/JrHpp8SeoSUut2140jccq47XR5rqAc1YLForhyYg6rMYeff9B2w==
X-MS-Exchange-AntiSpam-MessageData: tL8f9G3wZKRy+2BT15C1d5qxmKs9/t7WzEpGozYcQsjDx72TNOhFNMKBCkr2lzIafrDnB1yjNb9J4r79tMfl87KLC2yiiDWnM/pxa9VjBfVQx8epcu/AEp8+BiTgm/DswPrl36+WRDLxO0mbZnky7A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b60ffb-88c7-4476-2c1f-08d7d6d0dc10
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 06:41:23.0948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmoENYSRbQgcNBrXA4oY4fzwKMzhJbDv7lyzxAV3QTsOlZ8rSceUjAZsFBbrTBF5AVUKAnkbiiyEZW2dsljsyob4C2WDbg5o02DBmPckvoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5496
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.14.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.04.2020 1:38, Eric Blake wrote:
> I was trying to test qemu's reconnect-delay parameter by using nbdkit
> as a server that I could easily make disappear and resume.  A bit of
> experimenting shows that when nbdkit is abruptly killed (SIGKILL),
> qemu detects EOF on the socket and manages to reconnect just fine; but
> when nbdkit is gracefully killed (SIGTERM), it merely fails all
> further guest requests with NBD_ESHUTDOWN until the client disconnects
> first, and qemu was blindly failing the I/O request with ESHUTDOWN
> from the server instead of attempting to reconnect.
> 
> While most NBD server failures are unlikely to change by merely
> retrying the same transaction, our decision to not start a retry loop
> in the common case is correct.  But NBD_ESHUTDOWN is rare enough, and
> really is indicative of a transient situation, that it is worth
> special-casing.
> 
> Here's the test setup I used: in one terminal, kick off a sequence of
> nbdkit commands that has a temporary window where the server is
> offline; in another terminal (and within the first 5 seconds) kick off
> a qemu-img convert with reconnect enabled.  If the qemu-img process
> completes successfully, the reconnect worked.
> 
> $ #term1
> $ MYSIG=    # or MYSIG='-s KILL'
> $ timeout $MYSIG 5s ~/nbdkit/nbdkit -fv --filter=delay --filter=noextents \
>    null 200M delay-read=1s; sleep 5; ~/nbdkit/nbdkit -fv --filter=exitlast \
>    --filter=delay --filter=noextents null 200M delay-read=1s
> 
> $ #term2
> $ MYCONN=server.type=inet,server.host=localhost,server.port=10809
> $ qemu-img convert -p -O raw --image-opts \
>    driver=nbd,$MYCONN,,reconnect-delay=60 out.img
> 
> See also: https://bugzilla.redhat.com/show_bug.cgi?id=1819240#c8
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> This is not a regression, per se, as reconnect-delay has been unchanged
> since 4.2; but I'd like to consider this as an interoperability bugfix
> worth including in the next rc.
> 
>   block/nbd.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index 2906484390f9..576b95fb8753 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -863,6 +863,15 @@ static coroutine_fn int nbd_co_receive_one_chunk(
>       if (ret < 0) {
>           memset(reply, 0, sizeof(*reply));
>           nbd_channel_error(s, ret);
> +    } else if (s->reconnect_delay && *request_ret == -ESHUTDOWN) {
> +        /*
> +         * Special case: if we support reconnect and server is warning
> +         * us that it wants to shut down, then treat this like an
> +         * abrupt connection loss.
> +         */
> +        memset(reply, 0, sizeof(*reply));
> +        *request_ret = 0;
> +        nbd_channel_error(s, -EIO);
>       } else {
>           /* For assert at loop start in nbd_connection_entry */
>           *reply = s->reply;
> 

Interesting. I see, that prior to this patch we don't handle ESHUTDOWN at all in nbd client..

What does spec say?

 > On a server shutdown, the server SHOULD wait for inflight requests to be serviced prior to initiating a hard disconnect. A server MAY speed this process up by issuing error replies. The error value issued in respect of these requests and any subsequently received requests SHOULD be NBD_ESHUTDOWN.
 > If the client receives an NBD_ESHUTDOWN error it MUST initiate a soft disconnect.
 > The client MAY issue a soft disconnect at any time, but SHOULD wait until there are no inflight requests first.
 > The client and the server MUST NOT initiate any form of disconnect other than in one of the above circumstances.

Hmm. So, actually we MUST initiate a soft disconnect, which means that we must send NBD_CMD_DISC..

Then, what about "SHOULD wait until no inflight requests"? We don't do it either.. Should we?

-- 
Best regards,
Vladimir


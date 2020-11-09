Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F19C4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:57:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC5420789
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YzZYDuA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC5420789
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3vB-0005wJ-92
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kc3tY-0004Zs-7t; Mon, 09 Nov 2020 04:55:28 -0500
Received: from mail-eopbgr70122.outbound.protection.outlook.com
 ([40.107.7.122]:28128 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kc3tU-0006Qc-N6; Mon, 09 Nov 2020 04:55:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaDWw6NNjlTts+fE2fqKa6tWFknco7T8CzHTSQnzUbF1T60FcXWhNbdd43o4ZOMBQZovfKm09Tix5pop9cCRZEpDMMPACEfygpBGm/nUGs8WaE1EYPUPM1/sS+dtHmFv3M8pPbUby1L1O2JbKjYD61sAZbElTeCMWsh7VUr2VWfbyjBCkGspWJsQWXANrJ/5nRpmCyUOB9JFR7yJQACUaoYc8MKAW8xjXQoNsOJky7plATPbhP0BgOW6ZVZOKUl0CBt0iDWKjFJWs1+TNst/4yDbTb3htaymk5zKJWAIKUEBlGYE8bp+DLrCFYUIzwB68gsAxaYiqjCEirl/9xT8kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izPqQz+wvf+hI41lPUNzRs7z7t3CJ9RJnQWfSvVCfEQ=;
 b=AIWY/maAli2+8IA+mmPDz9FRHfYuZj/puaiDxsdj8F7fznoZk7T6w8B5PWjjIkIUiCEG9Xww9jhCuR3WenEMi8SIOmPUzh+S7cGZ4PHLNP/ipb+VULVQvAnEpN10y8AEAm9sp1c2+tGuK34n5i/xAZ/0N1s6AnetC3N0dOCIwUcjrbTepfR4sQqE+TFZJ4yta04MVKbLgnbMm1hD/YpfG+0vt3AwB4Dl7PrPDpFS8kUfAkPbDbSuvYMt1rCX88EL+L1hhvFuRoO8ptdJ0UubJtykPWJxveBarNYVKnb82sSxM4HvF0XXTp9zi8iLJibCX1yCj48wu4A5nzIBLFpQhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izPqQz+wvf+hI41lPUNzRs7z7t3CJ9RJnQWfSvVCfEQ=;
 b=YzZYDuA8B1PpQTXrPT+9FytyekB6PsaMR0AwSfZ5wAInFapkDeXlMmEioRn+wvpHr8vgKt6AxqD37EaJbjULeDcjBz4VPYfvrNqf0wlYE7m123saQx22Biw6K0259phee4Poz65ZgC+bTP97S13EeeWqhUbh48ShWPx+IeOdTzc=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4916.eurprd08.prod.outlook.com (2603:10a6:20b:ca::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 09:55:21 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 09:55:21 +0000
Subject: Re: [PATCH 2/2] monitor: increase amount of data for monitor to read
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jcody@redhat.com, kwolf@redhat.com,
 mreitz@redhat.com, armbru@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, marcandre.lureau@redhat.com,
 den@openvz.org
References: <1604666522-545580-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1604666522-545580-3-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f50a09b6-06b1-499a-8aeb-abb0cc52f729@virtuozzo.com>
Date: Mon, 9 Nov 2020 12:55:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <1604666522-545580-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.85]
X-ClientProxiedBy: AM0PR04CA0062.eurprd04.prod.outlook.com
 (2603:10a6:208:1::39) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.85) by
 AM0PR04CA0062.eurprd04.prod.outlook.com (2603:10a6:208:1::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 09:55:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ec58041-e462-4670-f336-08d8849591fe
X-MS-TrafficTypeDiagnostic: AM6PR08MB4916:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4916790390AB52FE5D0CB3CDC1EA0@AM6PR08MB4916.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ngaSn1mQTnPEsduKUWsM9U149WgjzoyomcPMF34f+pmv2cgmHoobZeVni/8oPGlhYHP1HbgrBf48JN64lheI5UVthr6Xg5H/ZcXD1HMylt74/NHO0Eh8neqMpL7v0pg2DSRBt/MVXx4ak8/B4b8Yp3H0yqUW1cI1z337nKAFpd0kafMhKiyjBYNqn1fpwglUksAHNr4Pti/dQPEzidEvefXOo9+HNd3isJrjpdIla3+IwAKXroSoWCqxMKJSVlZ+FrQHUvn1LKUKFlEFAofwBug8Dx9kMCtypkWqFCGBj8yOvdZkenSo7CB/1M3J60Rx3iaTFR8JKybzwLqCeDaaAW88C3JghSujInx+eLKDk9qDECFUfeRGpvIhqTh+6Q68
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39840400004)(366004)(396003)(376002)(136003)(83380400001)(8936002)(31686004)(107886003)(6486002)(478600001)(26005)(186003)(16526019)(4326008)(52116002)(7416002)(8676002)(2616005)(956004)(66946007)(66476007)(66556008)(316002)(36756003)(2906002)(30864003)(31696002)(16576012)(86362001)(5660300002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: jG1wJTrbaTkfX2SFHMa2KkRvqeovhe8cla0poTQwHB21y1LcFGI3YuWT1TCGH1pE503nuH9lFEGKWcitlquQ2rG+BwSAbiXuQDr7Mus/bLwnh2xSC6OBUFpkbhOHdMiAKjiKYpOi/TwoysoOuE6LbZ4A1QQI6bH561Alc5k5dPoz5+IZgTTFzWET290ABevY4ZXBRBl0ch2QCBXpmaXEoqGb/zgHsV4qK/J0L5Ku7I7GV/GD21d9QyjRQobLdvGlOi0x8OujK4vG2qcqtX6+la+S4uBrxK70O3/W5E0h/jiUlzxiE8237XFX4qATiUvMvd5H0VlbzRztyjli4BJhYtjF+lfVW4i9vrKfKRuwXOcKi8ak3euzinogBZ+CS2DlmQBsmCZZA6xSkO4yIohrTSvsVd3dlDRopE1ZTxd2K4CJmlHibGCNLII3JCDWwh1AdNayafzX6JxZEtdqLkcfF/SlCPmOHBGgsG8fugFT4QNTyJXr4mLM0jbHUlIMAqRTOCi+bFOJEhYHNTKXstAjYtaHL10rL5UHLLVN6HC9W02R1ijR7lQoGEecr49swq660D/x+2FHttPbHA6j20xEwrROIsxh2kpNctCqZawAm3DUC7vQ+puxqDbbDrwrUS4mAdLyhkSojdJV8klTK4cnjw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec58041-e462-4670-f336-08d8849591fe
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 09:55:20.9503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D76VsAMmJ6QaPE93TPIxGmQbOsRQQDlqCHw0KeM6FARU5t7Z4/rd4kWBSVro987VAjt2lR4ocHoU6myHQ44uYdHzJvBIPJK6IMPEu0rYQz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4916
Received-SPF: pass client-ip=40.107.7.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 04:55:22
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

06.11.2020 15:42, Andrey Shinkevich wrote:
> QMP and HMP monitors read one byte at a time from the socket or stdin,
> which is very inefficient. With 100+ VMs on the host, this results in
> multiple extra system calls and CPU overuse.
> This patch increases the amount of read data up to 4096 bytes that fits
> the buffer size on the channel level.
> 
> Suggested-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   chardev/char-fd.c          | 64 +++++++++++++++++++++++++++++++++++++++++++++-
>   chardev/char-socket.c      | 54 +++++++++++++++++++++++++++-----------
>   chardev/char.c             | 40 +++++++++++++++++++++++++++++
>   include/chardev/char.h     | 15 +++++++++++
>   monitor/monitor.c          |  2 +-
>   tests/qemu-iotests/247.out |  2 +-
>   6 files changed, 159 insertions(+), 18 deletions(-)

Please, add

[diff]
     orderFile = /path/to/qemu/scripts/git.orderfile

to your git config, to keep files in good order in the patch.

> 
> diff --git a/chardev/char-fd.c b/chardev/char-fd.c
> index 1cd62f2..6194fe6 100644
> --- a/chardev/char-fd.c
> +++ b/chardev/char-fd.c
> @@ -33,6 +33,8 @@
>   #include "chardev/char-fd.h"
>   #include "chardev/char-io.h"
>   
> +#include "monitor/monitor-internal.h"
> +
>   /* Called with chr_write_lock held.  */
>   static int fd_chr_write(Chardev *chr, const uint8_t *buf, int len)
>   {
> @@ -41,7 +43,7 @@ static int fd_chr_write(Chardev *chr, const uint8_t *buf, int len)
>       return io_channel_send(s->ioc_out, buf, len);
>   }
>   
> -static gboolean fd_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
> +static gboolean fd_chr_read_hmp(QIOChannel *chan, void *opaque)
>   {
>       Chardev *chr = CHARDEV(opaque);
>       FDChardev *s = FD_CHARDEV(opaque);
> @@ -71,6 +73,66 @@ static gboolean fd_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
>       return TRUE;
>   }
>   
> +static gboolean fd_chr_read_qmp(QIOChannel *chan, void *opaque)
> +{
> +    static JSONthrottle thl = {0};

Hmm static cache? I don't think that is good idea. What if function called with another chan?

On the other hand, we shouldn't have more than one QMP monitor, and function is used only for qmp monitor. Still, could it be reopened or somehow switched, and we'll have outdated cache? I don't know..

> +    uint8_t *start;
> +    Chardev *chr = CHARDEV(opaque);
> +    FDChardev *s = FD_CHARDEV(opaque);
> +    int len, size, pos;
> +    ssize_t ret;
> +
> +    if (!thl.load) {
> +        len = sizeof(thl.buf);
> +        if (len > s->max_size) {
> +            len = s->max_size;
> +        }
> +        if (len == 0) {
> +            return TRUE;
> +        }
> +
> +        ret = qio_channel_read(
> +            chan, (gchar *)thl.buf, len, NULL);
> +        if (ret == 0) {
> +            remove_fd_in_watch(chr);
> +            qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
> +            thl = (const JSONthrottle){0};
> +            return FALSE;
> +        }
> +        if (ret < 0) {
> +            return TRUE;
> +        }

large code chunk is shared with fd_chr_read_hmp(). Would be not bad to avoid duplication..

> +        thl.load = ret;
> +        thl.cursor = 0;
> +    }
> +
> +    size = thl.load;
> +    start = thl.buf + thl.cursor;

you may use uint8_t* pointer type for thl.curser and get rid of size and start variables.

> +    pos = qemu_chr_end_position((const char *) start, size, &thl);

Why should we stop at paired bracked? What's wrong if we pass more data? This is the
main thing of the patch, would be good to describe it in the commit message.

> +    if (pos >= 0) {
> +        size = pos + 1;
> +    }
> +
> +    qemu_chr_be_write(chr, start, size);
> +    thl.cursor += size;
> +    thl.load -= size;
> +
> +    return TRUE;
> +}
> +
> +static gboolean fd_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
> +{
> +    Chardev *chr = CHARDEV(opaque);
> +    CharBackend *be = chr->be;
> +    Monitor *mon = (Monitor *)be->opaque;
> +
> +    if (monitor_is_qmp(mon)) {
> +        return fd_chr_read_qmp(chan, opaque);
> +    }
> +
> +    return fd_chr_read_hmp(chan, opaque);
> +}
> +
>   static int fd_chr_read_poll(void *opaque)
>   {
>       Chardev *chr = CHARDEV(opaque);
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 213a4c8..8335e8c 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -520,30 +520,54 @@ static void tcp_chr_disconnect(Chardev *chr)
>   
>   static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
>   {
> +    static JSONthrottle thl = {0};
> +    uint8_t *start;
>       Chardev *chr = CHARDEV(opaque);
>       SocketChardev *s = SOCKET_CHARDEV(opaque);
> -    uint8_t buf[CHR_READ_BUF_LEN];
> -    int len, size;
> +    int len, size, pos;
>   
>       if ((s->state != TCP_CHARDEV_STATE_CONNECTED) ||
>           s->max_size <= 0) {
>           return TRUE;
>       }
> -    len = sizeof(buf);
> -    if (len > s->max_size) {
> -        len = s->max_size;
> -    }
> -    size = tcp_chr_recv(chr, (void *)buf, len);
> -    if (size == 0 || (size == -1 && errno != EAGAIN)) {
> -        /* connection closed */
> -        tcp_chr_disconnect(chr);
> -    } else if (size > 0) {
> -        if (s->do_telnetopt) {
> -            tcp_chr_process_IAC_bytes(chr, s, buf, &size);
> +
> +    if (!thl.load) {
> +        len = sizeof(thl.buf);
> +        if (len > s->max_size) {
> +            len = s->max_size;
> +        }
> +        size = tcp_chr_recv(chr, (void *)thl.buf, len);
> +        if (size == 0 || (size == -1 && errno != EAGAIN)) {
> +            /* connection closed */
> +            tcp_chr_disconnect(chr);
> +            thl = (const JSONthrottle){0};
> +            return TRUE;
>           }
> -        if (size > 0) {
> -            qemu_chr_be_write(chr, buf, size);
> +        if (size < 0) {
> +            return TRUE;
>           }
> +        thl.load = size;
> +        thl.cursor = 0;
> +    }
> +
> +    size = thl.load;
> +    start = thl.buf + thl.cursor;
> +    pos = qemu_chr_end_position((const char *) start, size, &thl);
> +    if (pos >= 0) {
> +        size = pos + 1;
> +    }
> +    len = size;
> +
> +    if (s->do_telnetopt) {
> +        tcp_chr_process_IAC_bytes(chr, s, start, &size);
> +    }
> +    if (size > 0) {
> +        qemu_chr_be_write(chr, start, size);
> +        thl.cursor += size;
> +        thl.load -= size;
> +    } else {
> +        thl.cursor += len;
> +        thl.load -= len;
>       }
>   
>       return TRUE;
> diff --git a/chardev/char.c b/chardev/char.c
> index aa42821..251c97c 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -1178,6 +1178,46 @@ GSource *qemu_chr_timeout_add_ms(Chardev *chr, guint ms,
>       return source;
>   }
>   
> +/*
> + * Split the incoming buffered stream so that the QMP monitor queue is not
> + * overwhelmed with requests. The function looks for the last paired
> + * brace/bracket in a JSON command.
> + */
> +int qemu_chr_end_position(const char *buf, int size, JSONthrottle *thl)
> +{
> +    int i;
> +
> +    for (i = 0; i < size; i++) {
> +        switch (buf[i]) {
> +        case ' ':
> +        case '\n':
> +        case '\r':
> +            continue;
> +        case '{':
> +            thl->brace_count++;
> +            break;
> +        case '}':
> +            thl->brace_count--;
> +            break;
> +        case '[':
> +            thl->bracket_count++;
> +            break;
> +        case ']':
> +            thl->bracket_count--;

I don't think you need to care about square brackets, as QMP queries and answers are always json objects, i.e. in pair of '{' and '}'.

> +            break;
> +        default:
> +            break;
> +        }
> +        /* The same condition as it is in the json_message_process_token() */
> +        if ((thl->brace_count > 0 || thl->bracket_count > 0)
> +            && thl->brace_count >= 0 && thl->bracket_count >= 0) {
> +            continue;
> +        }
> +        return i;
> +    }
> +    return -1;
> +}
> +
>   void qemu_chr_cleanup(void)
>   {
>       object_unparent(get_chardevs_root());
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index db42f0a..5f02731 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -70,6 +70,14 @@ struct Chardev {
>       DECLARE_BITMAP(features, QEMU_CHAR_FEATURE_LAST);
>   };
>   
> +typedef struct {
> +    uint8_t buf[CHR_READ_BUF_LEN];
> +    int load;
> +    int cursor;
> +    int brace_count;
> +    int bracket_count;
> +} JSONthrottle;
> +
>   /**
>    * qemu_chr_new_from_opts:
>    * @opts: see qemu-config.c for a list of valid options
> @@ -141,6 +149,13 @@ Chardev *qemu_chr_new_mux_mon(const char *label, const char *filename,
>   void qemu_chr_change(QemuOpts *opts, Error **errp);
>   
>   /**
> + * Split the incoming buffered stream so that the QMP monitor queue is not
> + * overwhelmed with requests. The function looks for the last paired
> + * brace/bracket in a JSON command.
> + */
> +int qemu_chr_end_position(const char *buf, int size, JSONthrottle *thl);
> +
> +/**
>    * qemu_chr_cleanup:
>    *
>    * Delete all chardevs (when leaving qemu)
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 84222cd..43d2d3b 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -566,7 +566,7 @@ int monitor_can_read(void *opaque)
>   {
>       Monitor *mon = opaque;
>   
> -    return !qatomic_mb_read(&mon->suspend_cnt);
> +    return !qatomic_mb_read(&mon->suspend_cnt) ? CHR_READ_BUF_LEN : 0;
>   }
>   
>   void monitor_list_append(Monitor *mon)
> diff --git a/tests/qemu-iotests/247.out b/tests/qemu-iotests/247.out
> index 13d9547..2758662 100644
> --- a/tests/qemu-iotests/247.out
> +++ b/tests/qemu-iotests/247.out
> @@ -12,12 +12,12 @@ QMP_VERSION
>   {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
>   {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
>   {"return": {}}
> +{"return": {"status": "running", "singlestep": false, "running": true}}
>   {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job0"}}
>   {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job0"}}
>   {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job0", "len": 134217728, "offset": 134217728, "speed": 0, "type": "commit"}}
>   {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
>   {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
> -{"return": {"status": "running", "singlestep": false, "running": true}}
>   {"return": {}}
>   {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
>   *** done
> 


-- 
Best regards,
Vladimir


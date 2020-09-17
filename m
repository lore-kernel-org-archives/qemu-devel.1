Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53EBC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42619221EE
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42619221EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIyr2-0004Bu-5u
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 14:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kIyoC-0001RQ-Rw; Thu, 17 Sep 2020 14:39:07 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:53899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kIyo9-00029f-M8; Thu, 17 Sep 2020 14:39:04 -0400
Received: from [192.168.100.1] ([82.252.129.222]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M4rD7-1kJFea03Oh-001yXx; Thu, 17 Sep 2020 20:38:55 +0200
Subject: Re: [PATCH V3 05/10] util/: fix some comment spelling errors
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
References: <20200917075029.313-1-zhaolichang@huawei.com>
 <20200917075029.313-6-zhaolichang@huawei.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f2db53c5-1594-17f7-1b31-a140b1ab86d4@vivier.eu>
Date: Thu, 17 Sep 2020 20:38:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200917075029.313-6-zhaolichang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:z5uqCskpwY6hKnfaqnTvhX+WY2OVcAJb0x1Ol8ajlN/kX5kvJBr
 S2rNaVQpV7vk13hzr2m20dFpD4LxHqKsm1OkyJRyzITT79/BTfNSEdjqbuGgnqRVg/h6t2l
 SFADfNgqCgICp2Eci2Wgg9RnHTh6AyOOnxPXhdjlNyXEPfdN82OFM1mp2pryrXMChlKBRfl
 KhIieKeIwqQQ7dTuxl63A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S3Yk10nr7DE=:IcQI2jLlPaC71tHowf6wz8
 r/hcKBnZYzYU9pAYJjWhT8L7Cyjtb2/KDiwHnHyA51F6CKYihOHeyJTMBKsbWZKlMjWfB1YRh
 9TxMBLEfZH7I2fE+reLKH0JQDEd3udHR1OoG3Svt7fYqhbiuIY6BIXa2dauKVc9WLxNmhGL1F
 DbkAPwB5AUDI3TZiMUlzWgqOCQllwgoUZboEFxwMqDqCld1lnO+oIfh91TjCDbGl7kYjcOVNP
 kyKJ9YdIYYBNeLeb3f72gGddi5eBPxy7A4Ab0FH6rlBVUPJ8dZ58RV1S8hOamTOsNB00/6e1G
 C7erZlNTEo+xi+8EzBKW2DUbq8N+j13cNjYBS10HP0uWEgWVqczspuKnffT8gL6ofka3Mw5Az
 xdVlceG8pf72ayYD3Wf9xcbo+kmdBnG3tSOGOwHLITqWVWxTA3fKchOpu+zRHhQbHLC5m5qLv
 YJxKLUHeIwh65Zixg5v5j538W1139xc7jfkaMXkWk+jfkdk7qW31m9WpSqU8TIxJkkrcp8tlP
 daY20tNl8cgOgGJi76Q8wuzLfzEnLBOcavQEUm+s+SzWArp8xndWnq3nGXuQZTGqYI7nXfheG
 EjpjJ4/6Y1nTgdR37zEwHd5QnknHB/Z4X8spUWLsQ1aoARZVGgSqSb5oqlLjJpox4vEX4lAh3
 /d2Uh5+4BkPcbJjsKVDQHmw/jBZEZWnvjez5ca4OdwL8Yfuwfzf/yG7d/8CAT1Gd/JfRkFEQf
 WCFrRWx4Qr11Q8R5pnRpvn9pemapV9s8WSm9wQ/dVDx1vKPXGZC7Ujpslu+SQ/suSJPmPK2u6
 11t4DVNjie5aA7FEajApPxjhRnxI0yAQF51jxJAZl5pDHx2XIUPRBKBn3HlZvzBetsvutls
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 14:37:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Alex Bennee <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 17/09/2020 à 09:50, zhaolichang a écrit :
> I found that there are many spelling errors in the comments of qemu,
> so I used the spellcheck tool to check the spelling errors
> and finally found some spelling errors in the util folder.
> 
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
> Reviewed-by: Alex Bennee <alex.bennee@linaro.org>
> ---
>  util/osdep.c             | 2 +-
>  util/qemu-progress.c     | 2 +-
>  util/qemu-sockets.c      | 2 +-
>  util/qemu-thread-win32.c | 2 +-
>  util/qht.c               | 2 +-
>  util/trace-events        | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/util/osdep.c b/util/osdep.c
> index 4829c07ff6..e50dc2214e 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -392,7 +392,7 @@ int qemu_unlink(const char *name)
>   * Set errno if fewer than `count' bytes are written.
>   *
>   * This function don't work with non-blocking fd's.
> - * Any of the possibilities with non-bloking fd's is bad:
> + * Any of the possibilities with non-blocking fd's is bad:
>   *   - return a short write (then name is wrong)
>   *   - busy wait adding (errno == EAGAIN) to the loop
>   */
> diff --git a/util/qemu-progress.c b/util/qemu-progress.c
> index 3c2223c1a2..20d51f8c12 100644
> --- a/util/qemu-progress.c
> +++ b/util/qemu-progress.c
> @@ -131,7 +131,7 @@ void qemu_progress_end(void)
>  /*
>   * Report progress.
>   * @delta is how much progress we made.
> - * If @max is zero, @delta is an absolut value of the total job done.
> + * If @max is zero, @delta is an absolute value of the total job done.
>   * Else, @delta is a progress delta since the last call, as a fraction
>   * of @max.  I.e. the delta is @delta * @max / 100. This allows
>   * relative accounting of functions which may be a different fraction of
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index b37d288866..99ce2fd5e6 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -416,7 +416,7 @@ static struct addrinfo *inet_parse_connect_saddr(InetSocketAddress *saddr,
>  
>      /* At least FreeBSD and OS-X 10.6 declare AI_V4MAPPED but
>       * then don't implement it in their getaddrinfo(). Detect
> -     * this and retry without the flag since that's preferrable
> +     * this and retry without the flag since that's preferable
>       * to a fatal error
>       */
>      if (rc == EAI_BADFLAGS &&
> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> index 56a83333da..d207b0cb58 100644
> --- a/util/qemu-thread-win32.c
> +++ b/util/qemu-thread-win32.c
> @@ -289,7 +289,7 @@ void qemu_event_wait(QemuEvent *ev)
>              ResetEvent(ev->event);
>  
>              /* Tell qemu_event_set that there are waiters.  No need to retry
> -             * because there cannot be a concurent busy->free transition.
> +             * because there cannot be a concurrent busy->free transition.
>               * After the CAS, the event will be either set or busy.
>               */
>              if (atomic_cmpxchg(&ev->value, EV_FREE, EV_BUSY) == EV_SET) {
> diff --git a/util/qht.c b/util/qht.c
> index 67e5d5b916..b2e020c398 100644
> --- a/util/qht.c
> +++ b/util/qht.c
> @@ -49,7 +49,7 @@
>   * it anymore.
>   *
>   * Writers check for concurrent resizes by comparing ht->map before and after
> - * acquiring their bucket lock. If they don't match, a resize has occured
> + * acquiring their bucket lock. If they don't match, a resize has occurred
>   * while the bucket spinlock was being acquired.
>   *
>   * Related Work:
> diff --git a/util/trace-events b/util/trace-events
> index 4e894aa9c3..24c31803b0 100644
> --- a/util/trace-events
> +++ b/util/trace-events
> @@ -28,7 +28,7 @@ qemu_file_monitor_add_watch(void *mon, const char *dirpath, const char *filename
>  qemu_file_monitor_remove_watch(void *mon, const char *dirpath, int64_t id) "File monitor %p remove watch dir='%s' id=%" PRId64
>  qemu_file_monitor_new(void *mon, int fd) "File monitor %p created fd=%d"
>  qemu_file_monitor_enable_watch(void *mon, const char *dirpath, int id) "File monitor %p enable watch dir='%s' id=%u"
> -qemu_file_monitor_disable_watch(void *mon, const char *dirpath, int id) "Fle monitor %p disable watch dir='%s' id=%u"
> +qemu_file_monitor_disable_watch(void *mon, const char *dirpath, int id) "File monitor %p disable watch dir='%s' id=%u"
>  qemu_file_monitor_event(void *mon, const char *dirpath, const char *filename, int mask, unsigned int id) "File monitor %p event dir='%s' file='%s' mask=0x%x id=%u"
>  qemu_file_monitor_dispatch(void *mon, const char *dirpath, const char *filename, int ev, void *cb, void *opaque, int64_t id) "File monitor %p dispatch dir='%s' file='%s' ev=%d cb=%p opaque=%p id=%" PRId64
>  
> 

Applied to my trivial-patches branch.

Thanks,
Laurent



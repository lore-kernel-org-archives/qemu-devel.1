Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F43C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 19:46:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B639206BB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 19:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B639206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5xiY-0000WA-SI
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 15:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i5xhd-0008W1-Ci
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 15:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i5xha-0007G5-EE
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 15:45:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34452)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i5xha-0007F9-6V
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 15:45:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 582A310A8122;
 Thu,  5 Sep 2019 19:45:52 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A3675D6A3;
 Thu,  5 Sep 2019 19:45:50 +0000 (UTC)
To: Yury Kotov <yury-kotov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
References: <20190826103726.25538-1-yury-kotov@yandex-team.ru>
 <20190826103726.25538-2-yury-kotov@yandex-team.ru>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
 xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
 xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
 TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
 GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
 sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
 AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
 CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
 RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
 wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
 Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
 gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
 pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
 zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
 pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
 3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
 NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
 cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
 SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
 I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
 mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
 Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
 2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <79c7fa75-063b-700f-fcc8-4f71781f9664@redhat.com>
Date: Thu, 5 Sep 2019 14:45:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826103726.25538-2-yury-kotov@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Thu, 05 Sep 2019 19:45:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 1/3] qemu-thread: Add qemu_cond_timedwait
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
Cc: "open list:Overall" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/26/19 5:37 AM, Yury Kotov wrote:
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> ---

Rather sparse on the commit message details.

>  include/qemu/thread.h    | 18 ++++++++++++++++++
>  util/qemu-thread-posix.c | 40 ++++++++++++++++++++++++++++------------
>  util/qemu-thread-win32.c | 16 ++++++++++++++++
>  util/qsp.c               | 18 ++++++++++++++++++
>  4 files changed, 80 insertions(+), 12 deletions(-)
> 

> +++ b/util/qemu-thread-posix.c
> @@ -36,6 +36,18 @@ static void error_exit(int err, const char *msg)
>      abort();
>  }
>  
> +static void compute_abs_deadline(struct timespec *ts, int ms)
> +{
> +    struct timeval tv;
> +    gettimeofday(&tv, NULL);
> +    ts->tv_nsec = tv.tv_usec * 1000 + (ms % 1000) * 1000000;
> +    ts->tv_sec = tv.tv_sec + ms / 1000;
> +    if (ts->tv_nsec >= 1000000000) {
> +        ts->tv_sec++;
> +        ts->tv_nsec -= 1000000000;
> +    }

I don't know if any named constants would make this easier or harder to
read (such as USEC_PER_SEC 1000000 or NSEC_PER_SEC 1000000000), but the
conversion from relative ms to absolute timespec looks correct. [1]

> +void qemu_cond_timedwait_impl(QemuCond *cond, QemuMutex *mutex, int ms,
> +                              const char *file, const int line)
> +{
> +    int err;
> +    struct timespec ts;
> +
> +    assert(cond->initialized);
> +    trace_qemu_mutex_unlock(mutex, file, line);
> +    compute_abs_deadline(&ts, ms);
> +    err = pthread_cond_timedwait(&cond->cond, &mutex->lock, &ts);
> +    trace_qemu_mutex_locked(mutex, file, line);
> +    if (err && err != ETIMEDOUT) {
> +        error_exit(err, __func__);
> +    }
> +}

However, this function returning void looks odd.  Although ETIMEDOUT is
the one error that guarantees that mutex is reobtained (all other errors
occur before the mutex is given up in the first place), and even though
the man page warns that you MUST recheck the condition variable in a
while loop regardless of success or failure (it might be a spurious
successful wake-up due to a broadcast where neither the condition nor
the timeout has actually been reached yet; or it might be a race where
the function reports a timeout immediately before the condition variable
became available after all), it still seems like callers might like to
know if a timeout happened, without having to calculate an ending
absolute time themselves.


>  
> -static void compute_abs_deadline(struct timespec *ts, int ms)
> -{
> -    struct timeval tv;

[1] Oh, you mixed code motion with new code, but the commit message
didn't mention that.  It's not necessarily worth splitting the patch,
but at least mentioning it would be worthwhile.

> +++ b/util/qemu-thread-win32.c
> @@ -145,6 +145,22 @@ void qemu_cond_wait_impl(QemuCond *cond, QemuMutex *mutex, const char *file, con
>      qemu_mutex_post_lock(mutex, file, line);
>  }
>  
> +void qemu_cond_timedwait_impl(QemuCond *cond, QemuMutex *mutex, int ms,
> +                              const char *file, const int line)
> +{
> +    int rc = 0;
> +
> +    assert(cond->initialized);
> +    trace_qemu_mutex_unlock(mutex, file, line);
> +    if (!SleepConditionVariableSRW(&cond->var, &mutex->lock, ms, 0)) {
> +        rc = GetLastError();
> +    }
> +    trace_qemu_mutex_locked(mutex, file, line);
> +    if (rc && rc != ERROR_TIMEOUT) {
> +        error_exit(rc, __func__);
> +    }
> +}

I am less certain that this implementation is correct, but on the
surface it seems okay.


>  
> +static void
> +qsp_cond_timedwait(QemuCond *cond, QemuMutex *mutex, int ms,
> +                   const char *file, int line)
> +{
> +    QSPEntry *e;
> +    int64_t t0, t1;
> +
> +    t0 = get_clock();
> +    qemu_cond_timedwait_impl(cond, mutex, ms, file, line);
> +    t1 = get_clock();
> +
> +    e = qsp_entry_get(cond, file, line, QSP_CONDVAR);
> +    qsp_entry_record(e, t1 - t0);
> +}

Another function where a bool or int return (to distinguish success from
timeout) might be worthwhile to some callers.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


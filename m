Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9210C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B6A420730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6A420730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iywpC-0007ok-MG
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 06:57:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iywoc-0007Lm-Nt
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:56:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iywob-00058t-Iw
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:56:26 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:44695)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iywob-0004o5-92
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:56:25 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N6svJ-1jbnWg238J-018J6O; Tue, 04 Feb 2020 12:55:53 +0100
To: Josh Kunz <jkz@google.com>
References: <20200201122746.1478003-1-laurent@vivier.eu>
 <CADgy-2uVp2hyqFncFa2T7m8W5vPt=kigdiqosLQFgdB8Df81Gw@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 0/4] linux-user: fix use of SIGRTMIN
Message-ID: <187a66d8-5afd-b3d6-81df-6b99468bff19@vivier.eu>
Date: Tue, 4 Feb 2020 12:55:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CADgy-2uVp2hyqFncFa2T7m8W5vPt=kigdiqosLQFgdB8Df81Gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OAAIozs9dIx4B7q0DO710OLoh6LQwITER2R9Gbx9iKT+AsywIZi
 /1jFLAWbCsvzZdAL8X8hnwwaVtGLvde5tgAN4/ArfL1gNaoKd5qpmLdE0cn/0gNINU3QQ3o
 AGbhBymjPu3mh9LgJOGEQHbAT6689zqEMhWeWmW/sT8+TBoNxLEENGsJbWN6rWbaTvPsJb7
 jG+PuBZGQ55mqSRa42uRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S+9QpRhUAzU=:e6uqupngV2Zd+8gU3Mn6RO
 m20SNyNkphCxrHgByr3cOz5c6aVM2iNsdaNAkm91KI2HgKt7unckZP0Lt+BONmjice66Gj3dc
 xrVi2s83S9KNdjHKAHfaIMc2CiD5qMKJTQnJwtz/k7U3U8uy/zURFFdpKKvKz7aJLuwfRE6eS
 wKA5A12sTW5R8prmd5L8atcLjUp78Qbd9RkaJKOrEh94Nai8Gs8DlBIzo9mjRvdiLdjHBTQBG
 wPSyzi9ozDI7Gbv0SB+kLTM2OQ2sLcfZjil+2NA9VtJY5bWcrrKZnRRdeKqROyCJNFEmW5Olx
 h1jXPv+C38cU23JFqriLIdfCyqjKf3E8Kg+mrrl0XnLAziJbpRnDoTN5or2jtMqhNgMpOxXiw
 nFVDlyrL7WDjFkA6loBjdVRT+EBc9P1qgIKQYi7oiXrkEP8xRYTkXRSMHAqyakqEieSq4soC+
 esrcar1ie/1c+AIUjVviwUbjmDgsLd+IiO55XopHyB/ZEwpheBuY1GLfAt5Jw6STVnOM0OoX0
 5ybeHNMmL753zsjcCFFmAUXXHrVqj2YpOLBBElYDr2nMXGb6NH7lYfoKIuj/b7uezPrdeknXn
 4rUALt8yKfYXtga6H6VWBYREO2wrLkf9qIwKL7yh/WXsvKsgBPk4Saxc2WhBYbvQD/d5iNpZA
 hkVl53yGiibakp2gokBckaCIxZ6rhZ7tIAvoCFuG2cb6obRtlnaxkRTlB5aNDIYNIt7EpSjJW
 Era9wgRX+A++V6t+007SaW8Ak4Mpuc5wTEnkpP+7TIdaz5hsKCODfM6eV97dJh8qDOzUf0OBn
 eiGV7cE2FNS8UYs33SFha+dk6WbEUe5tCpIymSx9U7JonYyrV/UY5DFGtkVdWusv/o8ye/L
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Marlies Ruck <marlies.ruck@gmail.com>, Taylor Simpson <tsimpson@quicinc.com>,
 Matus Kysel <mkysel@tachyum.com>, milos.stojanovic@rt-rk.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/02/2020 à 01:03, Josh Kunz a écrit :
> On Sat, Feb 1, 2020 at 4:27 AM Laurent Vivier <laurent@vivier.eu> wrote:
>> This has been tested with Go (golang 1.10.1 linux/arm64, bionic) on x86_64
>> fedora 31. We can avoid the failure in this case allowing the unsupported
>> signals when we don't provide the "act" parameters to sigaction, only the
>> "oldact" one. I have also run the LTP suite with several target and debian
>> based distros.
> 
> This breaks with go1.13+ (I also verified at hash 753d56d364)[1]. I
> tested using an aarch64 guest on an x86 system, but this should
> manifest on any architecture when the guest/host have the same number
> of signals (and glibc reserves some host signals). From the traceback,
> you can see it dies in `initsig` which is called at startup. Any Go
> program should fail.

I reproduced the problem with aarch64/eoan, go1.12.10. Thank you.

> Since go does not use a libc, it assumes that all signals from
> [1.._NSIG) are available[2], and will panic if it cannot do an
> rt_sigaction for all of them. Go already has some special handling for
> QEMU where it silently discards failing rt_sigaction calls to signals
> 32, 33, and 64 [3]. Since this patch reserves an extra signal for
> __SIGRTMIN+1 as well, it blocks out guest signal 63 and Go fails to
> initialize.

We should add signal 63 here, but it's becoming not very clean.

> While I personally support this patch series (current handling of
> guest glibc signals is broken), it *will* break Go binaries. I don't
> know of a way to avoid this while supporting guest __SIGRTMIN+1,
> without either doing true signal multiplexing, or patching Go.

I think we could also simply ignore the error. As returning an error is
generally an abort condition even if the signal is never used, and it's
what we would do in go to avoid the problem. We will have problem later
with programs that really want to use the signal but I don't think we
can do better (do we know programs using 31 RT signals? or starting by
the end of the list?).

something like:

diff --git a/linux-user/signal.c b/linux-user/signal.c
index c4abacde49a0..169a84afe90b 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -866,8 +866,8 @@ int do_sigaction(int sig, const struct
target_sigaction *act,
         trace_signal_do_sigaction_host(host_sig, TARGET_NSIG);
         if (host_sig > SIGRTMAX) {
             /* we don't have enough host signals to map all target
signals */
-            qemu_log_mask(LOG_UNIMP, "Unsupported target signal #%d\n",
sig);
-            return -TARGET_EINVAL;
+            qemu_log_mask(LOG_UNIMP, "Unsupported target signal #%d,
ignored", sig);
+            return 0;
         }


Thanks,
Laurent






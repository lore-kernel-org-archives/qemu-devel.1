Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B07CC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:18:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EAFC2081C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EAFC2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54062 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMEPx-0000SO-Ax
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 12:18:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMEM9-0005Mo-4g
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMEM8-0002vS-4v
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:14:45 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:59689)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hMEM7-0002uy-Sf
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:14:44 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MKKpV-1h2mBx0UJz-00LlcE; Thu, 02 May 2019 18:14:34 +0200
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <877eb86hcf.fsf@zen.linaroharston>
	<20190502145846.26226-1-alex.bennee@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <765fa2ab-2803-1945-61ea-2e80b2da6072@vivier.eu>
Date: Thu, 2 May 2019 18:14:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190502145846.26226-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:A3KEGNr7iTl/i34T0xwfZpvBMlfEUcXFK3epCgEzq7m0kLH8DlW
	Xs/alMlaJREqShL2DydRZRvWhQtyar6aSzhQGge50fDy6cI8BGt4O+Z3060ktvO4frB8MC+
	rEnGL2cVaQO+e9ua14GCP3XabIZAHy01KD5m8IDaxJ8JHKhxl4m4eh+QhlQb2bKPJ+jV1PD
	HlJdBeXJnFzQa+fTBNerg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SBDtjpnqfoI=:z87g363o4ZRd50ZtMVZ5N8
	odq/t/CTMjULCA89JXfDl4BRZGQmmPeyGnI5R0T3V+LScsrSX2zf1K1oyzSH5qyc1Be4xyJxX
	HKB1+otBWtnAzakNI7BSly81bF4+IoSxDiMX+HLPJoiYrDSG/uEOyoEYg4+mNu54FYkiUtkET
	dVXyoWpUp0ChHT6hYUVPXap6xU1i0LVE7UtpBfEkjFCC4Qawh+K3zZoomOjiQ5tr+UD8qJ+Lr
	iNnFqzYRotO1GlOJbjNno2KtaWId3KFClsOqxMNDnjfWgLyH29eQxQ6d8NiElMXhC9F4Wg+tE
	n5o/gF7qCNn5BcDvR6mF5XxPw3qo+Ps8k39Np8FtsGbk7E9xt/hTbqA2xQDWAMmkNee/Car3f
	7FXoQ4bznBmADIQTEjrIK2z27WIRB/2r6TYErbf2YONcXAevk9WcQ1wY4H8sNEfMPCkW1m2d4
	GDtpv+2OF16NgTwFyBm7skGmkNQjm0Q2T49AHtd7ch1j67I/f2sZV9uGVhYvcQm2a6KQzsxq7
	fUNroPM0xseCwlJ0S2wrVvS/VnZHv5hsifnm/WaYxcYHPPrQTEB909XhFNHqU9ZZf4kUzBTD1
	KzeJPeNOqMgm0i2G0FNu8OT4M4eMViipmu5hwNO/VnFBjkDqTKskL54E0tC4OnaTQKnPrhNs+
	SJvvu8eJ18ckB4X4TM00FKQrkZrDCbdGpHVGQIZGlaDMeULcYDA2RNq5DVdhTuPzhCsepQeOl
	//4G5mtXojJJ8psN/xHZbhFVoO606k6o3z/49xDgaB3QjGpdmIuxOy51yOM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: Re: [Qemu-devel] [PATCH] linux-user: avoid treading on gprof's
 SIGPROF signals
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502161432.1gB-UUPP6Dr0MMqoLu7ic9SZh4hI9Zl5F3msSDpKbAs@z>

On 02/05/2019 16:58, Alex Bennée wrote:
> The guest tends to get confused when it receives signals it doesn't
> know about. Given the gprof magic has also set up it's own handler we
> would do well to avoid stomping on it as well.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  linux-user/signal.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index e2c0b37173..44b2d3b35a 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -508,6 +508,11 @@ void signal_init(void)
>      act.sa_flags = SA_SIGINFO;
>      act.sa_sigaction = host_signal_handler;
>      for(i = 1; i <= TARGET_NSIG; i++) {
> +#ifdef TARGET_GPROF
> +        if (i == SIGPROF) {
> +            continue;
> +        }
> +#endif
>          host_sig = target_to_host_signal(i);
>          sigaction(host_sig, NULL, &oact);
>          if (oact.sa_sigaction == (void *)SIG_IGN) {
> 

Perhaps merge this with the previous one and send a v2: it will ease
bisecting.

Thanks,
Laurent


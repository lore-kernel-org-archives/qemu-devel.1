Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F415EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 14:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C47DD214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 14:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47DD214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwSE8-000878-Vw
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 09:52:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iwSDT-0007ba-O1
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:51:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iwSDS-0000Ch-Kl
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:51:47 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:36613)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iwSDS-00006V-BV
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:51:46 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MElhb-1imJzT1BbX-00GJIo; Tue, 28 Jan 2020 15:51:32 +0100
To: Josh Kunz <jkz@google.com>, qemu-devel@nongnu.org
References: <20200117192808.129398-1-jkz@google.com>
 <20200117192808.129398-2-jkz@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v2 1/4] linux-user: Use `qemu_log' for non-strace logging
Message-ID: <295472c5-4378-4ae1-1e9f-854b15075cf6@vivier.eu>
Date: Tue, 28 Jan 2020 15:51:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200117192808.129398-2-jkz@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SMElex6Dtpln9Q8h9unWjBNuB9paOSsX8msUEdA9F3zZwbM4uXB
 Cpvx0kcfYVAcx9kgA5ZiaLu841wPZbHEHnAI2T8ciScY8jyYpiqPmMf9Ew1s1pLCLWGVajI
 Obykkw7otedYW0X9dt9IE7vHEmnlQ44cL/LMav6OQa7kyWGgzmaRww5FPEtC0CL1VQk6ugu
 u6+N/EOEZD2unzy2LqcnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/sYmbq9xXGg=:CeGxgi+GtfA9Yq69NBHukL
 f6/7D2NqCBWh7NhY/BPUasuzXTtyveK5C4YhKpvNPK5+njcUJFFFhG8r5hcX+9rDkmsNdhgBB
 nYCq+SJmm18GRm+9iCxloTssR+C5JqDsOSTGF6jq7G4BnYPU0rkErggrXQr4CdsxzLWETXmLz
 FjuyXE4w+TNYzKl9Cl+RVpqBue8AomhduEU4AFwMtSAlB1eJcanAzQa5TfV4/1K8ZtSnsImdH
 Bs5scPEMqIBEAuhE1nieJAlCj8IjZb37PItnMUifNyVg7VaZWc52ujXZaNsPelaqpHLyW/z2c
 aNNM/MLQVG5vs5m9OU97LnXR80soDGxyhAP5VAiTzZGtZqrQ6xGlv3Cp3bE4K2Zei35oWgQYP
 eht7uxaBnm9zGDpabEUqsiPWe7xFaoek+ydDOXV5EdMC/8P0DPmvFKg0txDV/H49ENjUtGWz7
 E4lgVlrCkZnPum8lbDSlcucDpXZtuf1iHuTSHOY5ICFI84LkuvbZ7XiPJY1ajE0Cot/WTgKA8
 HwwgbKEMLbTbN0AVR0s+KbRgLj9Q6xzVep06zDnLFQ5sQ9uDJvfOMXoYahHrx8fhNQH19K1Pj
 opEXvg6ALrtnWGe3+6Qam3jC0BIIKWkcXfmeCDZvs0kJ7HnAbELRgGajmfk6uw6UIH1XHqplS
 YEUmGq6U95BrPP6tXk1DNqbxyTdlBRhLo2iC73vnM++jdWDsdna02ZJnK/6wQu/2jxKesDP/T
 kEHpN2OuiHYKQ7W6epzaTnAoGrLP4+kYWl88dzlq9OY2tw863vYIjNNR4LFgwIQblnGNjIWYu
 DHki07RPG5A1t8tRmxkoeTiPu3yaC22c8jAcGLiT5scDPjFZrJ4bNZyfWq/Fg4EJK7I8R6S
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
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
Cc: riku.voipio@iki.fi, alex.bennee@linaro.org, armbru@redhat.com,
 imp@bsdimp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 17/01/2020 à 20:28, Josh Kunz a écrit :
> Since most calls to `gemu_log` are actually logging unimplemented features,
> this change replaces most non-strace calls to `gemu_log` with calls to
> `qemu_log_mask(LOG_UNIMP, ...)`.  This allows the user to easily log to
> a file, and to mask out these log messages if they desire.
> 
> Note: This change is slightly backwards incompatible, since now these
> "unimplemented" log messages will not be logged by default.

This is a good incompatibility as these messages were unexpected by  the
tools catching stderr. They don't happen on "real" systems.

...
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 249e4b95fc..629f3a21b5 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1545,20 +1545,18 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
>              - sizeof(struct target_cmsghdr);
>  
>          space += CMSG_SPACE(len);
> -        if (space > msgh->msg_controllen) {
> -            space -= CMSG_SPACE(len);
> -            /* This is a QEMU bug, since we allocated the payload
> -             * area ourselves (unlike overflow in host-to-target
> -             * conversion, which is just the guest giving us a buffer
> -             * that's too small). It can't happen for the payload types
> -             * we currently support; if it becomes an issue in future
> -             * we would need to improve our allocation strategy to
> -             * something more intelligent than "twice the size of the
> -             * target buffer we're reading from".
> -             */
> -            gemu_log("Host cmsg overflow\n");
> -            break;
> -        }
> +
> +        /*
> +         * This is a QEMU bug, since we allocated the payload
> +         * area ourselves (unlike overflow in host-to-target
> +         * conversion, which is just the guest giving us a buffer
> +         * that's too small). It can't happen for the payload types
> +         * we currently support; if it becomes an issue in future
> +         * we would need to improve our allocation strategy to
> +         * something more intelligent than "twice the size of the
> +         * target buffer we're reading from".
> +         */
> +        assert(space > msgh->msg_controllen && "Host cmsg overflow");
>  
>          if (tswap32(target_cmsg->cmsg_level) == TARGET_SOL_SOCKET) {
>              cmsg->cmsg_level = SOL_SOCKET;

Could you move this to a separate patch: you are not using qemu_log()
here and I'm not convinced that crashing is better than ignoring the
remaining part of the buffer.

For the other changes:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Lauren


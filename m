Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6D7C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:09:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C91A2084B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C91A2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58122 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL6xu-00043C-Cs
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 10:09:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL6x4-0003hL-D0
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:08:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL6wy-0004UP-Tj
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:08:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hL6ww-0004Ov-Is
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:08:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id k16so16276434wrn.5
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=NnB+7Fe/bWKy2oL1S8rkMjv1OJabmYV3r9bg6a8LEB0=;
	b=IyTkRwRogRcIJXq/rr9Qa3/J2/XaHO7uNdhZq4LJP4Wft0zUUisrhs64yJMhLJV0Z6
	2tMZt3XK/Ui/XM9BNcCkcmI3qC2mUWkhHjA+XLEvGW9qvh20s96VDJXPKs5FG71Dv6kk
	ngZnyw/DVv7TdyWhPcqeZJ6Rrymc9RMWzusWzV50CQCWjyQqHva+c2JRgDK/Uy3JZ+YN
	pkL6yvdhf3RGM6zNPmIqMQtD2LFTWw3RT8AOFVAYKm5+g6c5RmL5GPAIiZJg+2/LurIn
	K8CwTqAAFYFk271YiwTkncnK3qpqXOz0K5QmLNNikgzMAJVt0dLljaBifSCF2VmVrMTT
	ptiQ==
X-Gm-Message-State: APjAAAWvNW97/DcBlLCjkNIdRUwyYerJpE/tcwmh0sbqA5lLB8p1i7rl
	ploxi+RoLhquBHnonBkl6GIEig==
X-Google-Smtp-Source: APXvYqw4QxllvMzuAgpAOqIAnV/G9+92omiqivO3o2TmGU5Sy4BCgCEPh2R2MfWt2VvFkRJD2qPw2g==
X-Received: by 2002:a5d:6542:: with SMTP id z2mr37243740wrv.217.1556546884087; 
	Mon, 29 Apr 2019 07:08:04 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	m17sm15742039wrq.27.2019.04.29.07.08.03
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 07:08:03 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	qemu-devel@nongnu.org
References: <20190429134757.13570-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c20eda65-a2db-97bf-3439-73f7e6c0f400@redhat.com>
Date: Mon, 29 Apr 2019 16:08:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429134757.13570-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] vl: fix -sandbox parsing crash when
 seccomp support is disabled
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
Cc: otubo@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429140802.zZlb0NOJdGZ6-Y9DAzZSmVn4Nk1L_1fgl-_y9awVElw@z>

On 4/29/19 3:47 PM, Marc-André Lureau wrote:
> $ ./x86_64-softmmu/qemu-system-x86_64 -sandbox off
> qemu-system-x86_64: -sandbox off: There is no option group 'sandbox'
> Segmentation fault
> 
> Commit 5780760f5e ("seccomp: check TSYNC host capability") wrapped one
> use of the sandbox option group to produce a sensible error, it didn't
> do the same for another call to qemu_opts_parse_noisily():
> 
> (gdb) bt
>     at util/qemu-option.c:829
>  #0  0x00000000105b36d8 in opts_parse (list=0x0, params=0x3ffffffffab5 "off", permit_abbrev=true, defaults=false, errp=0x3ffffffff080)
>      at util/qemu-option.c:829
>  #1  0x00000000105b3b74 in qemu_opts_parse_noisily (list=<optimized out>, params=<optimized out>, permit_abbrev=<optimized out>) at util/qemu-option.c:890
>  #2  0x0000000010024964 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:3589
> 
> Fixes: 5780760f5ea6163939a5dabe7427318b4f07d1a2
> Cc: david@gibson.dropbear.id.au
> Cc: otubo@redhat.com
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  vl.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index 4019a4387d..5fc4994d3c 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3866,17 +3866,19 @@ int main(int argc, char **argv, char **envp)
>                  qtest_log = optarg;
>                  break;
>              case QEMU_OPTION_sandbox:
> -#ifdef CONFIG_SECCOMP
> -                opts = qemu_opts_parse_noisily(qemu_find_opts("sandbox"),
> -                                               optarg, true);
> +                olist = qemu_find_opts("sandbox");
> +                if (!olist) {
> +#ifndef CONFIG_SECCOMP
> +                    error_report("-sandbox support is not enabled "
> +                                 "in this QEMU binary");
> +#endif
> +                    exit(1);
> +                }
> +
> +                opts = qemu_opts_parse_noisily(olist, optarg, true);
>                  if (!opts) {
>                      exit(1);
>                  }
> -#else
> -                error_report("-sandbox support is not enabled "
> -                             "in this QEMU binary");
> -                exit(1);
> -#endif
>                  break;
>              case QEMU_OPTION_add_fd:
>  #ifndef _WIN32
> 


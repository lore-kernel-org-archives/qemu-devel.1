Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D16C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 16:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5181206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 16:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5181206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn44l-0000E3-JZ
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 12:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35631)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hn44b-0008H8-8c
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 12:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hn44Z-0004oV-5x
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 12:43:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40980)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hn44Y-0004n4-W0
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 12:43:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so14649154wrm.8
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 09:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FfG+S4I8E8DQY+bs8juKC6XD7DK0eV8oYKmVF5Pr1qo=;
 b=kb+cFNbfQRfvx8BheJji/2f5DJ3L5t5TknhXIwIgy82NqMRtpAnjFtalmDAWUs3Msy
 L8ZLajBuEOf4kx83grI/Kx/VoawjDBETHgycpcYmzht1r0S/nLeLmdhVxzVFuga8osns
 ZAlCBy+2mAqbm3hCUZxFYAbdwn8uBUSgDFpilLurwnCvRrCvHRMKaKhgZqu3e2H39sLE
 4q/GsZ3H3ZMFn3Jemz5JdwbvNxqc6EexxqHUeVe8AAGr62iiCOaErySrbC3r4RTHiECY
 fI7sATRiwM+fFcheK3SKaJzF+qapEVGmz0EwUk7lPU0+OjNBqTe8a39hFkxqeG0+shiU
 TrCg==
X-Gm-Message-State: APjAAAVr+LY7lRPCiZFgxuDc8TGrHZ7ZjPiSrl3MUpAmW8Gghhp8tdkv
 3rU9c0m9TrnFSPXzsMsMTeWjtA==
X-Google-Smtp-Source: APXvYqyXBNsOvRRMmbDENHXdq9lmIzj3OJbpqIrVu3HBYXOwD9LCHLK81Mfe6BzIRxdoyj9jO+1DYw==
X-Received: by 2002:a5d:4b50:: with SMTP id w16mr23027098wrs.132.1563209009765; 
 Mon, 15 Jul 2019 09:43:29 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id w67sm20575378wma.24.2019.07.15.09.43.28
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jul 2019 09:43:29 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20190713143311.17620-1-marcandre.lureau@redhat.com>
 <20190713143311.17620-2-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <fa376ceb-6d24-bdca-6152-fd1f4b72ffa7@redhat.com>
Date: Mon, 15 Jul 2019 18:43:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190713143311.17620-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v3 1/6] docker.py: add --run-as-current-user
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
Cc: Fam Zheng <fam@euphon.net>, pbonzini@redhat.com, berrange@redhat.com,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/13/19 4:33 PM, Marc-André Lureau wrote:
> Podman will need further tweaks.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/docker/Makefile.include | 2 +-
>  tests/docker/docker.py        | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index aaf5396b85..f4226b79d0 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -212,7 +212,7 @@ docker-run: docker-qemu-src
>  			"  COPYING $(EXECUTABLE) to $(IMAGE)"))
>  	$(call quiet-command,						\
>  		$(DOCKER_SCRIPT) run 					\
> -			$(if $(NOUSER),,-u $(shell id -u)) 		\
> +			$(if $(NOUSER),,--run-as-current-user) 		\
>  			--security-opt seccomp=unconfined		\
>  			$(if $V,,--rm) 					\
>  			$(if $(DEBUG),-ti,)				\
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 53a8c9c801..f15545aeea 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -333,8 +333,13 @@ class RunCommand(SubCommand):
>      def args(self, parser):
>          parser.add_argument("--keep", action="store_true",
>                              help="Don't remove image when command completes")
> +        parser.add_argument("--run-as-current-user", action="store_true",
> +                            help="Run container using the current user's uid")
>  
>      def run(self, args, argv):
> +        if args.run_as_current_user:
> +            uid = os.getuid()
> +            argv = [ "-u", str(uid) ] + argv
>          return Docker().run(argv, args.keep, quiet=args.quiet)
>  

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


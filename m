Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F41C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 22:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC3920873
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 22:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC3920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39284 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS7k6-0005VZ-Jt
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 18:23:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hS7jM-0005CK-DZ
	for qemu-devel@nongnu.org; Sat, 18 May 2019 18:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hS7jL-000295-Fn
	for qemu-devel@nongnu.org; Sat, 18 May 2019 18:23:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54701)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hS7jL-00028M-9V
	for qemu-devel@nongnu.org; Sat, 18 May 2019 18:23:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id i3so9869335wml.4
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 15:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=1PT0+rqw6VpExOWckF1oplUHXPeQx6Ld4KHU33b0LE0=;
	b=kXbpZmB9F5TWJlb8zgo7JXUzyEWBh20aoIdG8WZE4Mc39Q1virnCa/Zkv6FHcstN8j
	aREIeiH58KpdldFXzBxgvy5xwBQNTLjbz3YnwPKwU7aXmU7eaW4tLPovzuHnvsMXMwg4
	2ZFXs34kLkypFOqYrKTrsWePfY5bqSb+VS+oDXTLg/BWQ7zVQh7fmTfqct/sTfdvJ5Dy
	8euZoHlmwpZviXaecYFfTUp3fiebGjx/dLVCOrsJkd1o86mK+7I1o1yZWrT8PFzczCO7
	rFjlzB3mpk0pXcWssE8q9ygrC4PyUyLHR2CurnN/KErT7q16hOQ5mp7y9fPikVfx6lri
	9zkQ==
X-Gm-Message-State: APjAAAUH2W/AXZ66IUSpLSmQH3rMcPWSoYNE8J0dMg7RvpljqSCloJvL
	4cTSycrOxhcpz4zT71vVGMCLAQ==
X-Google-Smtp-Source: APXvYqxA/FAwlY0IoCJzFIredmKmZP/nWAYnJ86mfdieXWg4mrssq+1oIE9GBxFLvQ01OmdEvrsqNg==
X-Received: by 2002:a1c:c910:: with SMTP id f16mr7237546wmb.47.1558218181960; 
	Sat, 18 May 2019 15:23:01 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id u11sm4270023wrn.1.2019.05.18.15.23.00
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 15:23:01 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190510104633.9428-1-kraxel@redhat.com>
	<20190510104633.9428-8-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <13ff85ac-6804-129f-dcec-4146130daa27@redhat.com>
Date: Sun, 19 May 2019 00:23:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510104633.9428-8-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v2 07/13] tests/vm: add DEBUG=1 to help text
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	Kamil Rytarowski <kamil@netbsd.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

On 5/10/19 12:46 PM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  tests/vm/Makefile.include | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index 47084d5717c6..8714b5947958 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -25,6 +25,8 @@ vm-test:
>  	@echo "  vm-boot-ssh-<guest>             - Boot guest and login via ssh"
>  	@echo
>  	@echo "Special variables:"
> +	@echo "    DEBUG=1			 - be verbose, also start interactive"
> +	@echo "					   shell on build failures"

Can you replace <tabs> by <spaces>? See:

Special variables:
    DEBUG=1                      - be verbose, also start interactive
                                           shell on build failures
    BUILD_TARGET=foo             - override the build target
    TARGET_LIST=a,b,c            - Override target list in builds.
    EXTRA_CONFIGURE_OPTS="..."

Using spaces:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  	@echo "    BUILD_TARGET=foo		 - override the build target"
>  	@echo "    TARGET_LIST=a,b,c    	 - Override target list in builds."
>  	@echo '    EXTRA_CONFIGURE_OPTS="..."'
> 




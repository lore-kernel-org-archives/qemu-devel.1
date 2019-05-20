Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF779C46460
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 18:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32B4205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 18:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32B4205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40506 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSnTi-0003vg-9E
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 14:57:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSnSl-0003Hn-OS
	for qemu-devel@nongnu.org; Mon, 20 May 2019 14:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSnSk-0001xQ-BH
	for qemu-devel@nongnu.org; Mon, 20 May 2019 14:56:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hSnSk-0001vj-5j
	for qemu-devel@nongnu.org; Mon, 20 May 2019 14:56:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id r7so15740449wrr.13
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 11:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=bNoukarGBLG3RitxEM5IxPayMQEoaZCfRwRKXFP0DQk=;
	b=cijlDWRRZdYdi0+FfcJkZZ5gOAZ9+4GtQ/f9NNpl+AEmCsCnFKl2PdPYbocJJ0alBr
	/dBRm2epvnYHC+v+KFIuq3DC+8cjy75YWImS/dR7OmqsHDiFOIGjJYVYRCUWVGWANgze
	iIU6Hj8Ziu9CIIxkFz+vax/kH3/JLx7aDg4tFFXbZBZYHyiNaH4rYJx5lOVF8/SAqGvV
	FnIZaSWzixvIF/tcST/LIiN/V892V5JxkMZM8A2h06orstU8zsoeOGYMejXSOOgqXXYx
	iTEiS0hreLFxP/+6f0nQAhMFks02Xjub2wt5faaIoz2qbse9Vzfv6cE0T/aRQsqKTek7
	cCjw==
X-Gm-Message-State: APjAAAVVc01l/HGol6BurBA4/nrS6NbddA335gwV0gu42WC3+XQVCDRE
	a28p27NGFwcxLuNOAHN5cND3Bg==
X-Google-Smtp-Source: APXvYqxUfzTeD/uBA5/Beb8Qo1kDG990xosK7YQizs4W1Qw584gos9uNWfbt+reZHWeGbUHewvbTIg==
X-Received: by 2002:adf:ce8e:: with SMTP id r14mr34586867wrn.289.1558378599527;
	Mon, 20 May 2019 11:56:39 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id u7sm765181wmg.25.2019.05.20.11.56.38
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 11:56:38 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190520124716.30472-1-kraxel@redhat.com>
	<20190520124716.30472-8-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d6230444-5064-cece-8f11-edfb359dd386@redhat.com>
Date: Mon, 20 May 2019 20:56:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520124716.30472-8-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v3 07/14] tests/vm: add vm-boot-{ssh,
 serial}-<guest> targets
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

On 5/20/19 2:47 PM, Gerd Hoffmann wrote:
> For testing/troubleshooting convinience.

"convenience"

> 
> make vm-boot-serial-<guest>
>   Boot guest, with the serial console on stdio.
> 
> make vm-boot-ssh-<guest>
>   Boot guest, login via ssh.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/vm/Makefile.include | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index d628e0a986f6..47084d5717c6 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -20,6 +20,10 @@ vm-test:
>  	@echo "  vm-build-all                    - Build QEMU in all VMs"
>  	@echo "  vm-clean-all                    - Clean up VM images"
>  	@echo
> +	@echo "For trouble-shooting:"
> +	@echo "  vm-boot-serial-<guest>          - Boot guest, serial console on stdio"
> +	@echo "  vm-boot-ssh-<guest>             - Boot guest and login via ssh"
> +	@echo
>  	@echo "Special variables:"
>  	@echo "    BUILD_TARGET=foo		 - override the build target"
>  	@echo "    TARGET_LIST=a,b,c    	 - Override target list in builds."
> @@ -59,3 +63,18 @@ vm-build-%: $(IMAGES_DIR)/%.img
>  		$(if $(EXTRA_CONFIGURE_OPTS),$(EXTRA_CONFIGURE_OPTS)), \
>  		"  VM-BUILD $*")
>  
> +vm-boot-serial-%: $(IMAGES_DIR)/%.img
> +	qemu-system-x86_64 -enable-kvm -m 4G -smp 2 -nographic \
> +		-drive if=none,id=vblk,cache=writeback,file="$<" \
> +		-netdev user,id=vnet \
> +		-device virtio-blk-pci,drive=vblk \
> +		-device virtio-net-pci,netdev=vnet \
> +	|| true
> +
> +vm-boot-ssh-%: $(IMAGES_DIR)/%.img
> +	$(call quiet-command, \
> +		$(SRC_PATH)/tests/vm/$* \
> +		--image "$<" \
> +		--interactive \
> +		false, \
> +		"  VM-BOOT-SSH $*")
> 

We might want the '|| true' here too:

$ exit
Shutdown NOW!
poweroff: [pid 769]
make: *** [tests/vm/Makefile.include:78: vm-boot-ssh-freebsd] Error 3

Anyway thanks, this will be surely useful!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>


Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96CBC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:54:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F64320652
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F64320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49538 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcutP-0007WX-UM
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 12:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46850)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hcuDv-0004DU-RD
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hcuDu-0005L9-Rr
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:11:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44000)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hcuDu-0005Ke-Ky
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:11:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so10583610wru.10
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G5TrB2OVFfvoH5Xv1v4so9wbEXs4dFfnvo/38k4oEyo=;
 b=fhjRCdKN+Xks46aHFp6sSahJeKvrw+67ETOXeoGI6f5UlAsx34+6PQ31YYCiZeoBns
 phfr0id8XXkIwU8VFljwIXYcRDV27BLey5sUMuwp7tx3AiSX4SDBrCuL/nLvsmKnhsA6
 JneVi+B/FTSPyDsJzX9Cne+EibcbXBwpqMELoS5+fgYk0PdB8mTl0M79ttjA+uMKC8to
 uD3sFzO5KU4NYklVnVy/YpuGYYv2FjaRzjHcZUIMeDPwjU4uGNLj0rYnbmfpA5pFRxzs
 GLOaofs9qSo0z6kwOKw9e92xYMYYCjEbwxELzQUsazvqXA7eHli7y/XgoEJp+DZF4fdL
 Yo1Q==
X-Gm-Message-State: APjAAAVSdg5C5UKPOMDWesX07A/t8I5WqomwBD9a1cjRcO97zbmQl/Xb
 Oxy2egNqcvz+3uRG7GMYlbtzbw==
X-Google-Smtp-Source: APXvYqyCViyHHQxghQ5w9wfZWiTlD/0wtMR/4xTMtVhRA7AhQGsketoC4Px5z3CzsQDPGyoq30/eIA==
X-Received: by 2002:adf:f1d1:: with SMTP id z17mr20412783wro.190.1560787869692; 
 Mon, 17 Jun 2019 09:11:09 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id a8sm9222372wmf.28.2019.06.17.09.11.08
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 09:11:09 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190617043858.8290-1-kraxel@redhat.com>
 <20190617043858.8290-6-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ffa8e326-70c7-84fc-2a5d-c61bfbc1ed5b@redhat.com>
Date: Mon, 17 Jun 2019 18:11:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190617043858.8290-6-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v4 05/11] tests/vm: add vm-boot-{ssh,
 serial}-<guest> targets
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/19 6:38 AM, Gerd Hoffmann wrote:
> For testing/troubleshooting convinience.

"convenience" (v3)

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
> index 276b870216c4..e329129bd658 100644
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
>  	@echo "    BUILD_TARGET=foo		 - Override the build target"
>  	@echo "    TARGET_LIST=a,b,c    	 - Override target list in builds"
> @@ -63,3 +67,18 @@ vm-build-%: $(IMAGES_DIR)/%.img
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

From v3:

We might want the '|| true' here too:

$ exit
Shutdown NOW!
poweroff: [pid 769]
make: *** [tests/vm/Makefile.include:78: vm-boot-ssh-freebsd] Error 3

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>



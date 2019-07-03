Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0893C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A8321882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A8321882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hibjc-0000mf-SZ
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52794)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiat1-0002FV-Oe
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiat0-0007CM-R4
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:45:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34986)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiat0-0007AX-Kz
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:45:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id c27so1790684wrb.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WInNSCjqC7qkEv3gjxExZW1ipgoTKOlaseoZa9uT2cw=;
 b=jvcuI4Wz78JNjGLzUIEOL/ZFnoZV05YJYJkhZWb8oguEJSc/FC3I6nNAPCsstURIZK
 uOOoX6R3cEMViQfcloQkkfdHfdhdzKkdHHsJyqkpiXlp2iNrf2k0905r3lQBsI5ZcfwB
 pthinvCQYIAmmQWZdLEEqLMQWw+lYB5K/YRe5mhfqfulhGbMdwQPcbLetmyDCML3c+Ws
 w7wYTEhcyqziLDOmokwRJ6Ks/ChZ3XV7WLsyU9ZaH5CXi6NyZjIRnIbT5GCFrdelkXPY
 6yu/Rr6awTF2nT8uuTdbXn5lYjA1C81o271hOkcvYxUJTjIAvGIbrBrpkB+FYYGkm33p
 Fftg==
X-Gm-Message-State: APjAAAWZLCQ76JLQjUZ+5dtTzvIzm2FBBnkt4T6OQtJZGKEGe/q6C1HV
 2bjIItr6rypcqpS+KhJMGWXadyO8OjY=
X-Google-Smtp-Source: APXvYqzlfprKCorae/+JB6jDtB7aWJS6Hm0T9w0gXO8uXVyYjROt97USomSzhQMazCi614teLpa8cA==
X-Received: by 2002:adf:e442:: with SMTP id t2mr28943874wrm.286.1562143505596; 
 Wed, 03 Jul 2019 01:45:05 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id c1sm2324175wrh.1.2019.07.03.01.45.04
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 01:45:05 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190703045212.31039-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <230938b3-e2dc-23ad-82a0-af56f27836e9@redhat.com>
Date: Wed, 3 Jul 2019 10:45:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703045212.31039-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] Add ati vgabios to INSTALL_BLOBS.
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
Cc: BROGERS@suse.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/19 6:52 AM, Gerd Hoffmann wrote:
> Fixes: 0cca7e7bfd6c81cc3c29ec2b3a0a98954c4ba71a
> Reported-by: Bruce Rogers <BROGERS@suse.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index cfb18f152544..452f63dc8429 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -746,7 +746,7 @@ bepo    cz
>  ifdef INSTALL_BLOBS
>  BLOBS=bios.bin bios-256k.bin sgabios.bin vgabios.bin vgabios-cirrus.bin \
>  vgabios-stdvga.bin vgabios-vmware.bin vgabios-qxl.bin vgabios-virtio.bin \
> -vgabios-ramfb.bin vgabios-bochs-display.bin \
> +vgabios-ramfb.bin vgabios-bochs-display.bin vgabios-ati.bin \
>  ppc_rom.bin openbios-sparc32 openbios-sparc64 openbios-ppc QEMU,tcx.bin QEMU,cgthree.bin \
>  pxe-e1000.rom pxe-eepro100.rom pxe-ne2k_pci.rom \
>  pxe-pcnet.rom pxe-rtl8139.rom pxe-virtio.rom \
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


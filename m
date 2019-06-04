Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF337C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 18:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB93220848
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 18:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uizvNHHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB93220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56325 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYEH5-00052s-Ul
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 14:35:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hYEGD-0004k4-Pw
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 14:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hYEGC-0006aD-L6
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 14:34:13 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hYEGC-0006Ti-F6
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 14:34:12 -0400
Received: by mail-wr1-x444.google.com with SMTP id f9so2166710wre.12
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 11:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=xWZmk+BD6U/Ihkq553JF8vJyhLol2/PBy+yfXTaDGsg=;
	b=uizvNHHyRN66XerfatJRqMTYwoLHhfQzTu+DRDCy+c5gOiBFtRW+5/BJfzhrDZbqR1
	McUxEU0DUlP+kdHO6q+v6IshL1kuyREQklV3h21Ac1MzBckJ4cE4WlJ4DiEFlFU3a0wx
	iijvRaRud80KzFHv2+269cSwuQ+5QoEmqZgl3+ZHsE/5C5KoVwDyzuJIuAXhTN2u26eB
	Oh4yNpvdT1nu+iSxQMHId3WnxY1d8I6e7JCyBYIawK11bf6nulww6z85M+WobVsjC935
	0lFdtSjXgz1GsDOTMSZkS6MgkyGkyIOzUM0WkzMphjiTPwy8QMYtJOGTSuun3lCJ0jkR
	ENTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=xWZmk+BD6U/Ihkq553JF8vJyhLol2/PBy+yfXTaDGsg=;
	b=FK8dyqW7GVP3O5A2GVpkiUc+Lmgosz5VgDAbN0E9w/KP6hao8yTC0gmVZf6RnP6eDT
	9OvDrOr4cx8oL1blkKgnydwmAZErob3vePYENC71+cW62IJf7muhvmvwX74aAvmr/VW4
	pnp9uHk0F/E0z2zl9TcWgNh73uCCoqnszEQtn9It5UzGaXr8u9kiQkUzXuk6Y17mc4Q9
	Iqjlmyqi5PU2QKNsTRw2M+x24IUAramhbDiyMK+M+HVFEprIpPXGAB88rTbxcov50jLf
	Hvo4PcI9lsXySxU3OKRrUE11q4rBXh8w2ujwQzeOOcAa4RQIpddVkTyljsOsTSGRq1SR
	Wbng==
X-Gm-Message-State: APjAAAV0KkhxVHj74QylZb44HDSS7tPyfkyAzVIUPCPdshCscv+7m2nO
	eQPe71/u1Mn9eNkW16bFRHchWQ==
X-Google-Smtp-Source: APXvYqy5r9TDDKRYSbALhMz+9FbNWPMZj//HswMnZ/o/r6iNvWMZYFY0AQTro5XgAk+bdReQi/plXA==
X-Received: by 2002:adf:f00d:: with SMTP id j13mr22299698wro.178.1559673250202;
	Tue, 04 Jun 2019 11:34:10 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	65sm35143517wro.85.2019.06.04.11.34.09
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 04 Jun 2019 11:34:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 2EEC01FF87;
	Tue,  4 Jun 2019 19:34:09 +0100 (BST)
References: <87va0vgad2.fsf@zen.linaroharston>
	<20190311092956.woo6mfecw3qyxxet@steredhat>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefano Garzarella <sgarzare@redhat.com>
In-reply-to: <20190311092956.woo6mfecw3qyxxet@steredhat>
Date: Tue, 04 Jun 2019 19:34:09 +0100
Message-ID: <87y32hryhq.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] Booting kernels with PVHVM documentation?
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
Cc: Paolo Bonzini <bonzini@gnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Stefano Garzarella <sgarzare@redhat.com> writes:

> Hi Alex,
> sorry for the big delay, but I was traveling without my PC.
>
> On Wed, Mar 06, 2019 at 05:51:05PM +0000, Alex Benn=C3=A9e wrote:
>>
>> Hi,
>>
>> I've been looking at using PVH as an alternative to a long bios boot
>> sequence to boot some x86_64 test kernels for tests/tcg. I'm finding it
>> hard to piece together all the bits but I naively thought it would just
>> be a case of adding a few ELF NOTES to my boot.S with something like:
>>
>>           ELFNOTE(Xen, XEN_ELFNOTE_VIRT_BASE,      _ASM_PTR 0x100000)
>>           ELFNOTE(Xen, XEN_ELFNOTE_ENTRY,          _ASM_PTR _start)
>>           ELFNOTE(Xen, XEN_ELFNOTE_PHYS32_ENTRY,   _ASM_PTR 0)    /* ent=
ry =3D=3D virtbase */
>>           ELFNOTE(Xen, XEN_ELFNOTE_PADDR_OFFSET,   _ASM_PTR 0)
>>
>>           .code64
>
> Can you try to use .code32?
> The pvh.bin optionrom will jump to the image in 32-bit mode.
> I don't have a lot of experience, but looking at arch/x86/platform/pvh/he=
ad.S
> (Linux), I saw that entry point is under .code32, than it will switch to
> 64-bit mode.

That doesn't seem to make any difference:

./qemu-system-x86_64 -monitor none -display none -chardev stdio,id=3Dout -d=
evice isa-debugcon,chardev=3Dout -device isa-debug-exit,iobase=3D0xf4,iosiz=
e=3D0x4 -kernel ./tests/hello -vga none
qemu-system-x86_64: Error loading uncompressed kernel without PVH ELF Note


<snip>
>
>>   * are they any special linker rules required for the Xen.notes?
>
> I don't know, but I'll investigate on it.
>
>>
>> And finally:
>>
>>   * is this idea of mine a weird abuse of the PVHVM boot protocol or
>>     does it make sense?
>
> IMHO it isn't an abuse and make sense to boot a bare-metal application
> directly in 32-bit mode using the PVH loader.
>
> If you want to share with me a part of your code, I'll try to play with
> it.

My current hacking branch is:

  https://github.com/stsquad/qemu/tree/testing/next-with-x86-64-tests

--
Alex Benn=C3=A9e


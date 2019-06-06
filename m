Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA8AC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 09:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F24B020684
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 09:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24B020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57106 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYogi-0008Nl-5A
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 05:28:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYof2-0007NT-BR
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 05:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYof1-0004WQ-Ay
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 05:26:16 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:44609)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hYof0-0004V1-T5; Thu, 06 Jun 2019 05:26:15 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1MNtCi-1hAWVv32Ua-00OGi4; Thu, 06 Jun 2019 11:25:55 +0200
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
References: <20190529140504.21580-1-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
	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
Message-ID: <e980d325-c692-1700-2bdd-805f582900e0@vivier.eu>
Date: Thu, 6 Jun 2019 11:25:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529140504.21580-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pq+yJ0DLBtmJd5HQDDdQH/axA9Th2lGAm4ZNeJ5e7Ch/Qr7GjkB
	Wyz7OMnfcbjlJvicS3Rgh/gV/Y2D60PQ51zemCViv9Urvh3WXl/C1rqDJWWbkHOTclEd4uW
	ej12aOfjtYZbyhuIHLt51pcYC+aYgrxSyd3eCQqN6Wh5FKQl0gKE/8twZixYMsTZIjLKwY6
	6EvyuaZzyOD+eNtIDg9/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bPeRM/QIHoY=:mVIS6hb19Eq4sRXxB57BAj
	SU6X3hN4xDuxGlXJFJG3fAfR4409iniEL4qtzCl5IFxI1gPm4T4v2OgDkzlK3+R4ct6Ylyreq
	xZWE85W1lG06K0OooZ3RvJeYWwHW/9aFj05w7aF1cV7qZ7shU6ukiw1BEmOIVbfm4FBwn3yeB
	w5bXeOvG6P33TTB2tb/WrJyHUc3cu3MY/7I5K+SGrsZFT+VZqFnApjApvEwUC5bISnYg1AYKQ
	vgDt3w9vEz6hMyYPJTri+HZfa/bwGy1P1+BW6ErwZRApAWXqt7mI4ZZBtojMFkEPGFLoGHQzr
	JAgWjdJWueezLK3fHfcES+/Y6/viNxURdokelkf4QdV6JqxMXotyyoDkx8KPsP2mK60Abd0nK
	v3xKfQvRTlJ1/+QoTXuBn2gi+JuUeWm9/2oFW/S4ft0HwuPdjbYCrBW+ah1LZ6K8poocrAHuC
	Hg0ZvZkmYf8hmIZ6fNMxWJ2S3R8AMzsxgaWC+30tJddV4X9VDTXK8qrWIHgLdbnqpuhDhjmcu
	SbX5QUdODcwjm7jEsSEQGosx/NCODnRSpbSXTmkjraJUPZghMNhQPiAvoyQxzed6RR2X8sW0y
	lFAuV5kqFXQCt6lh/OslqQw5xLU+Dn8DjzTRWlUi/qDq2Awz8pC2/o/2NNiN1laMQrpTd+k51
	ZY4Hqgp5+/Dask9hslInRwnRE4crkFWShPiTdNqnr9f7MQGaC3ktpfGYxDoD2rzakRslNPKWK
	z4dR2xJYh5/rk3hot4Hz5GimZb4Dcg1O0hBehQBaHOHw6hwQ8BBhZIk8CZw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2] docs/devel/build-system:
 Update an example
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	=?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 29/05/2019 à 16:05, Philippe Mathieu-Daudé a écrit :
> The default-configs/ example added in 717171bd2025 is no
> more accurate since fa212a2b8b60 (and various further other
> commits).
> 
> The Kconfig build system is now in place.
> Use the aarch64-softmmu config as example.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v2: rephrased the sentence using Thomas suggestion
> ---
>  docs/devel/build-system.txt | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/docs/devel/build-system.txt b/docs/devel/build-system.txt
> index addd274eeb..41bd08ea3a 100644
> --- a/docs/devel/build-system.txt
> +++ b/docs/devel/build-system.txt
> @@ -413,18 +413,13 @@ context.
>  - default-configs/*.mak
>  
>  The files under default-configs/ control what emulated hardware is built
> -into each QEMU system and userspace emulator targets. They merely
> -contain a long list of config variable definitions. For example,
> -default-configs/x86_64-softmmu.mak has:
> -
> -  include sound.mak
> -  include usb.mak
> -  CONFIG_QXL=$(CONFIG_SPICE)
> -  CONFIG_VGA_ISA=y
> -  CONFIG_VGA_CIRRUS=y
> -  CONFIG_VMWARE_VGA=y
> -  CONFIG_VIRTIO_VGA=y
> -  ...snip...
> +into each QEMU system and userspace emulator targets. They merely contain
> +a list of config variable definitions like the machines that should be
> +included. For example, default-configs/aarch64-softmmu.mak has:
> +
> +  include arm-softmmu.mak
> +  CONFIG_XLNX_ZYNQMP_ARM=y
> +  CONFIG_XLNX_VERSAL=y
>  
>  These files rarely need changing unless new devices / hardware need to
>  be enabled for a particular system/userspace emulation target
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


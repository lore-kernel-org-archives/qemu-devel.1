Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F55EC46460
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 12:57:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CCED21670
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 12:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CCED21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46887 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLSJs-0004Gf-Lc
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 08:57:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLSJ0-0003lB-PH
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLSIz-00084I-Kd
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:56:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLSIz-000838-Ev
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:56:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so3724307wmc.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 05:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=nMvjiBkqPwi6uDpjxjFX6U8qdIid1UlA7caIcK7Xf6c=;
	b=JQYPkCd6DxOHbFt7XdhnxPQE0TKFnqpEQ448ISf7rOPDb8URStasHmp3dB3ecn7Xg/
	6mPVmcjSO4TaHqS6r2PdZGYmCD5fKRDIRzYvYSEqr9TKiqWNmh0sQRQvRIngg9QIRmBS
	7EDHJYIruz3YEOjSzCFeyD6YA4heRudHQJN8reWc/ppL7Ocnh8XlP4iCDvHcje9MuTb8
	dy3el6AthM+CQIzulViaYzgVAhQb6PJGLu1+BvtIf5j1kX4mKqliUBaUqDv2w8KRO5Ek
	+HeUSFOPRJ4axuSf/SxA4NstCvAEMCyiKbKwrGcd+aVlFsjC56UxumgIKHAY0yGPOnod
	Xp2A==
X-Gm-Message-State: APjAAAUffEsgrZ1sJpCHKpHWV6xhteHEzVxAeQDYHD48f0btUxXrkTTN
	xJ86P8AF1WJSSBtvURn5JdD2NA==
X-Google-Smtp-Source: APXvYqxzaJ7OxaYKgYlBBu9/WCXplRKMpd6DYAP2kZtn8dudIIjCxMMW+VyEFpvuVYVcCTFggT1+rg==
X-Received: by 2002:a1c:d7:: with SMTP id 206mr3305341wma.69.1556628975508;
	Tue, 30 Apr 2019 05:56:15 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	e16sm45132991wrs.0.2019.04.30.05.56.14
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 05:56:14 -0700 (PDT)
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
References: <20190430115404.18483-1-pl@kamp.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1667a919-9d20-14ca-fd72-e4d3074fd4a0@redhat.com>
Date: Tue, 30 Apr 2019 14:56:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430115404.18483-1-pl@kamp.de>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH RESEND] megasas: fix mapped frame size
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
Cc: fam@euphon.net, pbonzini@redhat.com, hare@suse.com, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430125613.YGxbpR3JOviUyXteY0-GOggPDHZtgPg9fSD7HLAPJ4c@z>

On 4/30/19 1:54 PM, Peter Lieven wrote:
> the current value of 1024 bytes (16 * MFI_FRAME_SIZE) we map is not enough to hold
> the maximum number of scatter gather elements we advertise. We actually need a
> maximum of 2048 bytes. This is 128 max sg elements * 16 bytes (sizeof (union mfi_sgl)).

Looking at megasas_map_sgl(), we indeed accept up to MEGASAS_MAX_SGE
iov_count. Broken since ever then?

Fixes: e8f943c3bcc2
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>
> Reviewed-by: Hannes Reinecke <hare@suse.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/scsi/megasas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index a56317e026..5ad762de23 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -477,7 +477,7 @@ static MegasasCmd *megasas_enqueue_frame(MegasasState *s,
>  {
>      PCIDevice *pcid = PCI_DEVICE(s);
>      MegasasCmd *cmd = NULL;
> -    int frame_size = MFI_FRAME_SIZE * 16;
> +    int frame_size = MEGASAS_MAX_SGE * sizeof(union mfi_sgl);
>      hwaddr frame_size_p = frame_size;
>      unsigned long index;
>  
> 


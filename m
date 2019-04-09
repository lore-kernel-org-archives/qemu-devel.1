Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ED3C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 13:04:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D7720830
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 13:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D7720830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41290 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDqQC-0002fT-D1
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 09:04:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDqPG-0002Cw-08
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDqPE-0004IC-Uk
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:03:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDqPE-0004GE-LZ
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:03:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so3401934wmf.5
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 06:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=iyLKpZkZIdLwRSb9DaGhfIlNYAo3Ec10rEoJVuust3Y=;
	b=T5IJiwKW87Bw/fXx6bjgL8MO27Kvwsdocv0JI+MKlbd9FuB6VfMvQYISsITTuTkZSI
	Auo7Z5W6ppSGV91vfPnNuY2xVQoACggAPc/CXVbGDC0E+22/yr0vfo1bzWFCgBOXZ2Ss
	Qo0q4I6EJbYzdUGwdWJb/j4yOZNR1sBRWhxP/KRlkant+96IvLRUe4th/ciuAevizNzx
	AqEtbqvW4Eqdyx5Rs8eLBgYAfeFy8Q5PPJYv9KZEsV4RFkrutzkZ6E5srjiOwrih/wUu
	YOwIipwItgryWMFR63AXFfo1kNDSWGShtaHvncvmxuAJijZJsevywNTTOAf7PCdE5y0p
	D3Kw==
X-Gm-Message-State: APjAAAUYLFsiZ1Mlj12iyY9CZkMkz4kRqMKw12PEp5LjVzbMZX07E9CE
	1UDEtVgEXGn/wRWZTnpy068rrQ==
X-Google-Smtp-Source: APXvYqwgTz/QRYkDWgH7duhP7b2Af7KQi88IzCZOsdtLX58BoYiD3n3M+Ce2k/blyIc9AdjSLK05wQ==
X-Received: by 2002:a1c:20c1:: with SMTP id
	g184mr21993076wmg.137.1554814995526; 
	Tue, 09 Apr 2019 06:03:15 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	o15sm28516795wrj.59.2019.04.09.06.03.14
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 06:03:14 -0700 (PDT)
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <20190409110732.5C5FF7465DB@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <08d40ec6-be36-f2e1-d216-6dd9deb5c1e0@redhat.com>
Date: Tue, 9 Apr 2019 15:03:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409110732.5C5FF7465DB@zero.eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH] ati-vga: Fix check for blt outside vram
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Andrew Randrianasulu <randrianasulu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409130313.pL7G3yhHUWBvG4ir_EZK5PX1SNzyUeDhiUOtYYs9ooQ@z>

This patch looks 4.0 worthwhile.

On 4/9/19 12:56 PM, BALATON Zoltan wrote:
> Fix the check preventing calling pixman functions that would access
> memory outside allocated vram. The r128 X driver sometimes seem to try
> blits that span outside vram, this check prevents crashing QEMU in
> that case. (The r128 X driver may have problems even on real hardware
> so I'm not sure if it's a client bug or emulation problem but at least
> QEMU should survive.)
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Tested-by: Andrew Randrianasulu <randrianasulu@gmail.com>
> ---
>  hw/display/ati_2d.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index bc98ba6eeb..fe3ae14864 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -79,10 +79,10 @@ void ati_2d_blt(ATIVGAState *s)
>                  s->regs.dst_width, s->regs.dst_height);
>          end = s->vga.vram_ptr + s->vga.vram_size;
>          if (src_bits >= end || dst_bits >= end ||
> -            src_bits + (s->regs.src_y + s->regs.dst_height) * src_stride +
> -            s->regs.src_x >= end ||
> -            dst_bits + (s->regs.dst_y + s->regs.dst_height) * dst_stride +
> -            s->regs.dst_x >= end) {
> +            src_bits + s->regs.src_x + (s->regs.src_y + s->regs.dst_height) *
> +            src_stride * sizeof(uint32_t) >= end ||
> +            dst_bits + s->regs.dst_x + (s->regs.dst_y + s->regs.dst_height) *
> +            dst_stride * sizeof(uint32_t) >= end) {
>              qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
>              return;
>          }
> @@ -140,8 +140,8 @@ void ati_2d_blt(ATIVGAState *s)
>                  filler);
>          end = s->vga.vram_ptr + s->vga.vram_size;
>          if (dst_bits >= end ||
> -            dst_bits + (s->regs.dst_y + s->regs.dst_height) * dst_stride +
> -            s->regs.dst_x >= end) {
> +            dst_bits + s->regs.dst_x + (s->regs.dst_y + s->regs.dst_height) *
> +            dst_stride * sizeof(uint32_t) >= end) {
>              qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
>              return;
>          }
> 


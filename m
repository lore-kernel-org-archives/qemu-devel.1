Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FCDC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:40:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B6C206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B6C206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAGWb-0000Fs-8X
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 12:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAGSA-0004Rm-Ug
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAGS9-0002Fn-D2
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:35:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57350)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAGS9-0002FT-5B
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:35:45 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 290AA37E88
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 16:35:44 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id n3so1524047wrt.9
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 09:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M90/9OazXVb0sRG6je51Qkw7bHLspARRGeQQDFL+khk=;
 b=K8xDlI+GYSpliJwBlSII4m6Zf9Ruw1Of0phQHiB36Z+zeureLZFjm+vXf3PL5fBsTC
 /k+Q6B4BJxwYveTc9NBDybud4RyaM4LpNVzeics1jop1JAVp89D3k0CQ/66tXzOd/9sd
 yhD//id2ogy2KK0q28Y4mOl3wt5WW2Exqbnxwx7fpEuveb1ObXXWAKqI+sZOToBOSp49
 HTk1m6enWHX4fNSdFsy5bLY4ppA5hPsDUDiZumye1/wFzj3eIWDkguLTlJMpDdRUKqWj
 4ErFp6oJ28kMhuby3/XKBshd1JVZy1fjXsK3WMYnyIyjELCKVIV7xZha6oYZ43Sd34/z
 uOpQ==
X-Gm-Message-State: APjAAAXEfiDAho85oe7rS5wcZLV65mQjdOpLl/Q+iWglcb7uGlhu0lYq
 ym++Dc9edqSVo+NKrHeFFJzgOiwS8ONp4VHcCqHy03XP4kSoZIXQfjYHNDh05XtfiVfPLHjowmj
 KGF4fyBJdNCyV57Y=
X-Received: by 2002:a5d:4350:: with SMTP id u16mr3493883wrr.289.1568738142920; 
 Tue, 17 Sep 2019 09:35:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx7g2x22/L1E915Vhfg+lq4GTEuim5URUQIS66IbxqFjuYdwBxXgw28sbIaE729ycEEEpftrA==
X-Received: by 2002:a5d:4350:: with SMTP id u16mr3493870wrr.289.1568738142708; 
 Tue, 17 Sep 2019 09:35:42 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id v64sm3669495wmf.12.2019.09.17.09.35.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2019 09:35:42 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190917111441.27405-1-kraxel@redhat.com>
 <20190917111441.27405-2-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1d75be76-93b4-c14c-0347-bdaacf31b1f5@redhat.com>
Date: Tue, 17 Sep 2019 18:35:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190917111441.27405-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/2] vga: move access helpers to
 separate include file
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
Cc: flier_m@outlook.com, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/19 1:14 PM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/vga-access.h  | 49 ++++++++++++++++++++++++++++++++++++++++
>  hw/display/vga-helpers.h | 26 ---------------------
>  hw/display/vga.c         |  1 +
>  3 files changed, 50 insertions(+), 26 deletions(-)
>  create mode 100644 hw/display/vga-access.h
>=20
> diff --git a/hw/display/vga-access.h b/hw/display/vga-access.h
> new file mode 100644
> index 000000000000..c0fbd9958b2e
> --- /dev/null
> +++ b/hw/display/vga-access.h
> @@ -0,0 +1,49 @@
> +/*
> + * QEMU VGA Emulator templates
> + *
> + * Copyright (c) 2003 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> + * of this software and associated documentation files (the "Software"=
), to deal
> + * in the Software without restriction, including without limitation t=
he rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> + * copies of the Software, and to permit persons to whom the Software =
is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> + * THE SOFTWARE.
> + */
> +
> +static inline uint8_t vga_read_byte(VGACommonState *vga, uint32_t addr=
)
> +{
> +    return vga->vram_ptr[addr & vga->vbe_size_mask];
> +}
> +
> +static inline uint16_t vga_read_word_le(VGACommonState *vga, uint32_t =
addr)
> +{
> +    uint32_t offset =3D addr & vga->vbe_size_mask & ~1;
> +    uint16_t *ptr =3D (uint16_t *)(vga->vram_ptr + offset);
> +    return lduw_le_p(ptr);
> +}
> +
> +static inline uint16_t vga_read_word_be(VGACommonState *vga, uint32_t =
addr)
> +{
> +    uint32_t offset =3D addr & vga->vbe_size_mask & ~1;
> +    uint16_t *ptr =3D (uint16_t *)(vga->vram_ptr + offset);
> +    return lduw_be_p(ptr);
> +}
> +
> +static inline uint32_t vga_read_dword_le(VGACommonState *vga, uint32_t=
 addr)
> +{
> +    uint32_t offset =3D addr & vga->vbe_size_mask & ~3;
> +    uint32_t *ptr =3D (uint32_t *)(vga->vram_ptr + offset);
> +    return ldl_le_p(ptr);
> +}
> diff --git a/hw/display/vga-helpers.h b/hw/display/vga-helpers.h
> index 5a752b3f9efd..10e9cfd40a04 100644
> --- a/hw/display/vga-helpers.h
> +++ b/hw/display/vga-helpers.h
> @@ -95,32 +95,6 @@ static void vga_draw_glyph9(uint8_t *d, int linesize=
,
>      } while (--h);
>  }
> =20
> -static inline uint8_t vga_read_byte(VGACommonState *vga, uint32_t addr=
)
> -{
> -    return vga->vram_ptr[addr & vga->vbe_size_mask];
> -}
> -
> -static inline uint16_t vga_read_word_le(VGACommonState *vga, uint32_t =
addr)
> -{
> -    uint32_t offset =3D addr & vga->vbe_size_mask & ~1;
> -    uint16_t *ptr =3D (uint16_t *)(vga->vram_ptr + offset);
> -    return lduw_le_p(ptr);
> -}
> -
> -static inline uint16_t vga_read_word_be(VGACommonState *vga, uint32_t =
addr)
> -{
> -    uint32_t offset =3D addr & vga->vbe_size_mask & ~1;
> -    uint16_t *ptr =3D (uint16_t *)(vga->vram_ptr + offset);
> -    return lduw_be_p(ptr);
> -}
> -
> -static inline uint32_t vga_read_dword_le(VGACommonState *vga, uint32_t=
 addr)
> -{
> -    uint32_t offset =3D addr & vga->vbe_size_mask & ~3;
> -    uint32_t *ptr =3D (uint32_t *)(vga->vram_ptr + offset);
> -    return ldl_le_p(ptr);
> -}
> -
>  /*
>   * 4 color mode
>   */
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index 573d223d46f0..82ebe5361096 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -1009,6 +1009,7 @@ void vga_mem_writeb(VGACommonState *s, hwaddr add=
r, uint32_t val)
>  typedef void vga_draw_line_func(VGACommonState *s1, uint8_t *d,
>                                  uint32_t srcaddr, int width);
> =20
> +#include "vga-access.h"
>  #include "vga-helpers.h"
> =20
>  /* return true if the palette was modified */
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


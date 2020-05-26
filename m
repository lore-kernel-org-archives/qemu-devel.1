Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E534EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC4F20776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udSGiwpT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC4F20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdcxP-0002OE-Ru
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 13:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdcpB-0004Fy-JL; Tue, 26 May 2020 12:53:09 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:38542)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdcp7-0001KX-1b; Tue, 26 May 2020 12:53:09 -0400
Received: by mail-il1-x144.google.com with SMTP id q18so19006ilm.5;
 Tue, 26 May 2020 09:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tYo9sYUc1YcmN8vha8IZg/Ov6XqShz9MUm0+3EOHego=;
 b=udSGiwpT3+ivgeCGVVSz0LAp6D+LhL5y3c3XLKEALfo3k8Op26sIkr/D7MouEpmS7i
 Om0dvoTeUO4ZGGETIPqpBcZwzS5wxC7VF9v2WQMrG1hAGCv0rfDGSuURrjopxgVkGNyT
 tzXwKCC0w2Vhj3vmYDXdDbsnIzeizDuciVR7xQJvCxZYj/xibbXz5ba+/0w2RKifLvjX
 dgYBxK1aN5Ss+B63dCibr1ua/z1wWC6+FIs5N0YX5n4yt561caXbugduVShXdQMfQfca
 tdEASVkLczwvd2zSK8b5Z52ykaG71jHHiPXCPLbKGdD/CeJql2ozUcXgNHB8LkMYWAIi
 6o5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tYo9sYUc1YcmN8vha8IZg/Ov6XqShz9MUm0+3EOHego=;
 b=Fy6fIJSHujsH3Cm4iF41/qlcaIaZWS/z8eF+Aores9pf1rWNolXXGn7nSQ3fJ1KS29
 bdYcOZwrazw+ClFV2GKTL2NLb7YcSCHp/gIfE/K9Sc5PtSJPtOo2xZ3ASEjCq5PRdj0D
 hk2IuMXp11QIMevmLq60s9e2unJIBWIQ88n8AG9bF/zK/WYcHe1S3JDe9+BuFks14qJS
 HaNudCTLBwGvabewxVJLe7LXD9bdwv45tso5k0DN9n1rINtKDV0JXibLD3ju2obuZrL7
 vh4rc7AFZ4uaYYhW+nV1eexVrtvE67sCRAFkPcKHkGfejpmep8ehhRJzGiAdbTJ1Kc2M
 70YQ==
X-Gm-Message-State: AOAM531Stazui7OE1heu1LFNhqLtXSBsDP2wamE5m7IYeVNOCpa+Pgg8
 37ub7ifKPOfBsP0Z6c8PqA6md8lUwbaMwkKCYUE=
X-Google-Smtp-Source: ABdhPJxS+7LEAonIaL+W2E68c1efq6PXsk/hvvK1fJXIJ4nOBnxLXyXK+qSNxX/51Ulivx36rLLl2o+NtlFm2TucXps=
X-Received: by 2002:a92:de02:: with SMTP id x2mr2073022ilm.267.1590511983065; 
 Tue, 26 May 2020 09:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200526062252.19852-1-f4bug@amsat.org>
 <20200526062252.19852-6-f4bug@amsat.org>
In-Reply-To: <20200526062252.19852-6-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2020 09:44:04 -0700
Message-ID: <CAKmqyKPkLpPYYjXF9NfQ3hOvNj9EAEYzp+MKFjF1B2viRaycCg@mail.gmail.com>
Subject: Re: [PATCH 05/14] hw/display/cirrus_vga: Use qemu_log_mask(ERROR)
 instead of debug printf
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 25, 2020 at 11:27 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> Replace some debug printf() calls by qemu_log_mask(LOG_GUEST_ERROR).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/display/cirrus_vga.c | 77 ++++++++++++++++++-----------------------
>  1 file changed, 33 insertions(+), 44 deletions(-)
>
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index f9f837b850..76e2dc5bb6 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -978,9 +978,8 @@ static void cirrus_bitblt_start(CirrusVGAState * s)
>         s->cirrus_blt_pixelwidth =3D 4;
>         break;
>      default:
> -#ifdef DEBUG_BITBLT
> -       printf("cirrus: bitblt - pixel width is unknown\n");
> -#endif
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cirrus: bitblt - pixel width is unknown\n");
>         goto bitblt_ignore;
>      }
>      s->cirrus_blt_mode &=3D ~CIRRUS_BLTMODE_PIXELWIDTHMASK;
> @@ -1037,7 +1036,9 @@ static void cirrus_bitblt_start(CirrusVGAState * s)
>          } else {
>             if (s->cirrus_blt_mode & CIRRUS_BLTMODE_TRANSPARENTCOMP) {
>                 if (s->cirrus_blt_pixelwidth > 2) {
> -                   printf("src transparent without colorexpand must be 8=
bpp or 16bpp\n");
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "cirrus: src transparent without colorexpand "
> +                          "must be 8bpp or 16bpp\n");
>                     goto bitblt_ignore;
>                 }
>                 if (s->cirrus_blt_mode & CIRRUS_BLTMODE_BACKWARDS) {
> @@ -1135,10 +1136,9 @@ static uint32_t cirrus_get_bpp16_depth(CirrusVGASt=
ate * s)
>         ret =3D 16;
>         break;                  /* XGA HiColor */
>      default:
> -#ifdef DEBUG_CIRRUS
> -       printf("cirrus: invalid DAC value %x in 16bpp\n",
> -              (s->cirrus_hidden_dac_data & 0xf));
> -#endif
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cirrus: invalid DAC value 0x%x in 16bpp\n",
> +                      (s->cirrus_hidden_dac_data & 0xf));
>         ret =3D 15;               /* XXX */
>         break;
>      }
> @@ -1307,11 +1307,9 @@ static int cirrus_vga_read_sr(CirrusVGAState * s)
>  #endif
>         return s->vga.sr[s->vga.sr_index];
>      default:
> -#ifdef DEBUG_CIRRUS
> -       printf("cirrus: inport sr_index %02x\n", s->vga.sr_index);
> -#endif
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cirrus: inport sr_index 0x%02x\n", s->vga.sr_inde=
x);
>         return 0xff;
> -       break;
>      }
>  }
>
> @@ -1400,10 +1398,9 @@ static void cirrus_vga_write_sr(CirrusVGAState * s=
, uint32_t val)
>          cirrus_update_memory_access(s);
>          break;
>      default:
> -#ifdef DEBUG_CIRRUS
> -       printf("cirrus: outport sr_index %02x, sr_value %02x\n",
> -               s->vga.sr_index, val);
> -#endif
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cirrus: outport sr_index 0x%02x, sr_value 0x%02x\=
n",
> +                      s->vga.sr_index, val);
>         break;
>      }
>  }
> @@ -1501,9 +1498,8 @@ static int cirrus_vga_read_gr(CirrusVGAState * s, u=
nsigned reg_index)
>      if (reg_index < 0x3a) {
>         return s->vga.gr[reg_index];
>      } else {
> -#ifdef DEBUG_CIRRUS
> -       printf("cirrus: inport gr_index %02x\n", reg_index);
> -#endif
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cirrus: inport gr_index 0x%02x\n", reg_index);
>         return 0xff;
>      }
>  }
> @@ -1590,10 +1586,9 @@ cirrus_vga_write_gr(CirrusVGAState * s, unsigned r=
eg_index, int reg_value)
>         cirrus_write_bitblt(s, reg_value);
>         break;
>      default:
> -#ifdef DEBUG_CIRRUS
> -       printf("cirrus: outport gr_index %02x, gr_value %02x\n", reg_inde=
x,
> -              reg_value);
> -#endif
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cirrus: outport gr_index 0x%02x, gr_value 0x%02x\=
n",
> +                      reg_index, reg_value);
>         break;
>      }
>  }
> @@ -1648,9 +1643,8 @@ static int cirrus_vga_read_cr(CirrusVGAState * s, u=
nsigned reg_index)
>         return s->vga.ar_index & 0x3f;
>         break;
>      default:
> -#ifdef DEBUG_CIRRUS
> -       printf("cirrus: inport cr_index %02x\n", reg_index);
> -#endif
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cirrus: inport cr_index 0x%02x\n", reg_index);
>         return 0xff;
>      }
>  }
> @@ -1721,10 +1715,9 @@ static void cirrus_vga_write_cr(CirrusVGAState * s=
, int reg_value)
>         break;
>      case 0x25:                 // Part Status
>      default:
> -#ifdef DEBUG_CIRRUS
> -       printf("cirrus: outport cr_index %02x, cr_value %02x\n",
> -               s->vga.cr_index, reg_value);
> -#endif
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cirrus: outport cr_index 0x%02x, cr_value 0x%02x\=
n",
> +                      s->vga.cr_index, reg_value);
>         break;
>      }
>  }
> @@ -1834,9 +1827,8 @@ static uint8_t cirrus_mmio_blt_read(CirrusVGAState =
* s, unsigned address)
>         value =3D cirrus_vga_read_gr(s, 0x31);
>         break;
>      default:
> -#ifdef DEBUG_CIRRUS
> -       printf("cirrus: mmio read - address 0x%04x\n", address);
> -#endif
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cirrus: mmio read - address 0x%04x\n", address);
>         break;
>      }
>
> @@ -1946,10 +1938,9 @@ static void cirrus_mmio_blt_write(CirrusVGAState *=
 s, unsigned address,
>         cirrus_vga_write_gr(s, 0x31, value);
>         break;
>      default:
> -#ifdef DEBUG_CIRRUS
> -       printf("cirrus: mmio write - addr 0x%04x val 0x%02x (ignored)\n",
> -              address, value);
> -#endif
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cirrus: mmio write - addr 0x%04x val 0x%02x (igno=
red)\n",
> +                      address, value);
>         break;
>      }
>  }
> @@ -2047,9 +2038,8 @@ static uint64_t cirrus_vga_mem_read(void *opaque,
>         }
>      } else {
>         val =3D 0xff;
> -#ifdef DEBUG_CIRRUS
> -       printf("cirrus: mem_readb " TARGET_FMT_plx "\n", addr);
> -#endif
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cirrus: mem_readb 0x" TARGET_FMT_plx "\n", addr);
>      }
>      return val;
>  }
> @@ -2112,10 +2102,9 @@ static void cirrus_vga_mem_write(void *opaque,
>             cirrus_mmio_blt_write(s, addr & 0xff, mem_value);
>         }
>      } else {
> -#ifdef DEBUG_CIRRUS
> -        printf("cirrus: mem_writeb " TARGET_FMT_plx " value 0x%02" PRIu6=
4 "\n", addr,
> -               mem_value);
> -#endif
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cirrus: mem_writeb 0x" TARGET_FMT_plx " "
> +                      "value 0x%02" PRIu64 "\n", addr, mem_value);
>      }
>  }
>
> --
> 2.21.3
>
>


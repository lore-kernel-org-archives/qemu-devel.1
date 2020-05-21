Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A968CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:23:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 724AD2072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724AD2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbouV-0002Ui-JV
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1jbol7-0006RX-JY
 for qemu-devel@nongnu.org; Thu, 21 May 2020 13:13:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53604)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1jbol5-0004G1-BE
 for qemu-devel@nongnu.org; Thu, 21 May 2020 13:13:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id u1so6196421wmn.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 10:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=77TpdNg49b0UVh1z+kxGvXfBXeChZQ6bf0ksI56Tomk=;
 b=VgPOtFpeIc2xAMENuaMX3TPIQLI5W/GaL75lM4U4auJW9OEh/h7T5IliaIaR1tifHj
 3IzhCcDdPaRkhCder9KXwrn+P6aJSPznnxgLMkGEd62RFCJzSYXjzOn/HJObheyOpxBl
 u3Qd3+/+u5fqgVGGHc9irhICGLfVt+T1B8iHHS+py4YhX/1fHJfCn8u/mncUOPOl2yAz
 j8NYzcrvpWxM7ixl7RrLakZ/lEJEuC10YnPPbFKACTuekFHtpbSIFt3XqwuiENDPsFK2
 p5k4KKyuqeaYqNe59TeuaTbqAdm/M0998VuXOa6e4tQikUrjMmeAE26hOM/+fJh9r4KN
 2ZUg==
X-Gm-Message-State: AOAM532FULRDSL8noE/hcdgW35MGdDPkyb2lkZ+2yGGJlB5dSQWWciCP
 rdXnyigMZsLBAVJBqKPDIl4=
X-Google-Smtp-Source: ABdhPJw6BYG4+7138dpZ2B2f0l2V6sP9Hqs7w0UZ9fN8D2fpNstgKFWA+waL7Afjsa42NVOMCAKIbw==
X-Received: by 2002:a7b:c5cc:: with SMTP id n12mr9577685wmk.69.1590081203142; 
 Thu, 21 May 2020 10:13:23 -0700 (PDT)
Received: from thl530 (pd95ce791.dip0.t-ipconnect.de. [217.92.231.145])
 by smtp.gmail.com with ESMTPSA id t14sm6593803wrb.56.2020.05.21.10.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 10:13:22 -0700 (PDT)
Date: Thu, 21 May 2020 19:13:18 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 1/2] hw/m68k/mcf5206: Reduce m5206_mbar_read/write()
 offset arg to 16-bit
Message-ID: <20200521191318.0567bc65@thl530>
In-Reply-To: <20200518173859.16520-2-f4bug@amsat.org>
References: <20200518173859.16520-1-f4bug@amsat.org>
 <20200518173859.16520-2-f4bug@amsat.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.128.65; envelope-from=th.huth@gmail.com;
 helo=mail-wm1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 13:13:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am Mon, 18 May 2020 19:38:58 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>:

> All calls to m5206_mbar_read/m5206_mbar_write are used with
> 'offset =3D hwaddr & 0x3ff', so we are sure the offset fits
> in 16-bit.
>=20
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/m68k/mcf5206.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
> index b155dd8170..45f44c43f0 100644
> --- a/hw/m68k/mcf5206.c
> +++ b/hw/m68k/mcf5206.c
> @@ -273,7 +273,7 @@ static void m5206_mbar_reset(m5206_mbar_state *s)
>  }
> =20
>  static uint64_t m5206_mbar_read(m5206_mbar_state *s,
> -                                uint64_t offset, unsigned size)
> +                                uint16_t offset, unsigned size)
>  {
>      if (offset >=3D 0x100 && offset < 0x120) {
>          return m5206_timer_read(s->timer[0], offset - 0x100);
> @@ -306,11 +306,11 @@ static uint64_t
> m5206_mbar_read(m5206_mbar_state *s, case 0x170: return s->uivr[0];
>      case 0x1b0: return s->uivr[1];
>      }
> -    hw_error("Bad MBAR read offset 0x%x", (int)offset);
> +    hw_error("Bad MBAR read offset 0x%x", offset);
>      return 0;
>  }
> =20
> -static void m5206_mbar_write(m5206_mbar_state *s, uint32_t offset,
> +static void m5206_mbar_write(m5206_mbar_state *s, uint16_t offset,
>                               uint64_t value, unsigned size)
>  {
>      if (offset >=3D 0x100 && offset < 0x120) {
> @@ -360,7 +360,7 @@ static void m5206_mbar_write(m5206_mbar_state *s,
> uint32_t offset, s->uivr[1] =3D value;
>          break;
>      default:
> -        hw_error("Bad MBAR write offset 0x%x", (int)offset);
> +        hw_error("Bad MBAR write offset 0x%x", offset);

Isn't the correct format string for short ints (i.e. 16-bit) rather %hx
instead of %x ? ... I think it does not matter on x86, but IIRC there
are other architectures where this could be a problem. I'd say, let's
simply use "int" for offset instead, that's likely the best solution.
(I can do the change when picking up the patch in case you don't want
to respin, just let me know)

 Thomas


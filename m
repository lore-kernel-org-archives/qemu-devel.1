Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F82C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:01:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A49B20721
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A49B20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdc0o-0001hF-Md
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>)
 id 1jdbz9-0000cW-Jx; Tue, 26 May 2020 11:59:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>)
 id 1jdbz7-000473-4D; Tue, 26 May 2020 11:59:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so65631wmj.0;
 Tue, 26 May 2020 08:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aejmtGAVwrEf4TFhu6yPwg4dq99qmOFZ2tjTMfJwwB4=;
 b=cn09GDdwTtX5I1lZNTbR6QBVEflFCfjz47gN7i7CGw3qtaho1wxEoiV9xbLHE/QSmj
 LKhU0c5LvrlLMQDKCuVc04B/y3Hrapz3WL3mSXJUqUY91THgDgrhEE+h3QT/VeFsN4LX
 5NjBu9/Xh9f+1q79AyduDF96hv960jl9rKhugD6bGiH+xD0kDNx/QtKBdRPYGxEWrvpz
 t5XXMuJQlGQPpTUA8Ums8eVc9zt4KngrsYhTZvF6JCj25tHtklIFUZtLAMpQM4O/iGJa
 6ezlUQm1yeU5fr6SqKDhOS2CA2GN2QQ3ElP2zZKlmthI23Pt6/n2rGKVHwWX7MOE2P3h
 +iSg==
X-Gm-Message-State: AOAM532Q1Ji31TPULhoiwBo668M2TCCZstJBkotyWkSYo7Fg7CDs0gcp
 N1z3HU6wDsIMXl5xUW8Sr8I=
X-Google-Smtp-Source: ABdhPJySorQQU/qBa8tB5jIgkUjxHe2oNBvTHdWHAP6xu/59Kxca55joaQ34s+gI4U5j/LGflOJwGg==
X-Received: by 2002:a1c:bc0a:: with SMTP id m10mr1929893wmf.173.1590508758988; 
 Tue, 26 May 2020 08:59:18 -0700 (PDT)
Received: from thl530 (x590feeb5.dyn.telefonica.de. [89.15.238.181])
 by smtp.gmail.com with ESMTPSA id z12sm296194wrg.9.2020.05.26.08.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 08:59:18 -0700 (PDT)
Date: Tue, 26 May 2020 17:59:14 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH v3 1/2] hw/m68k/mcf5206: Reduce m5206_mbar_read/write()
 offset arg to 16-bit
Message-ID: <20200526175914.7e3ed350@thl530>
In-Reply-To: <20200526094052.1723-2-f4bug@amsat.org>
References: <20200526094052.1723-1-f4bug@amsat.org>
 <20200526094052.1723-2-f4bug@amsat.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.128.68; envelope-from=th.huth@gmail.com;
 helo=mail-wm1-f68.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 11:59:19
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
Cc: qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am Tue, 26 May 2020 11:40:51 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>:

> All calls to m5206_mbar_read/m5206_mbar_write are used with
> 'offset =3D hwaddr & 0x3ff', so we are sure the offset fits
> in 16-bit.
>=20
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v3: Use PRIx16
> ---
>  hw/m68k/mcf5206.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
> index b155dd8170..187291e1f6 100644
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
> +    hw_error("Bad MBAR read offset 0x%"PRIx16, offset);
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
> +        hw_error("Bad MBAR write offset 0x%"PRIx16, offset);
>          break;
>      }
>  }

Reviewed-by: Thomas Huth <huth@tuxfamily.org>



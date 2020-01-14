Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1D8C33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 02:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B07D20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 02:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldG5Kb8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B07D20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irBWh-0003zK-DE
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 21:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1irBUW-000285-QH
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 20:59:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1irBUV-0000cN-P9
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 20:59:36 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:39109)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1irBUV-0000bG-Hv; Mon, 13 Jan 2020 20:59:35 -0500
Received: by mail-lf1-x141.google.com with SMTP id y1so8463465lfb.6;
 Mon, 13 Jan 2020 17:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5OXR1lgWAptLKU3W0CQIZNE+hOvlwc8nHcCeOKgikCc=;
 b=ldG5Kb8Xh6+ISy/6M54NdrAwwDLsh66IGzfYLcVVU4QSsBHgAHo3KU4OxzOD/8Ic68
 plq1yDtgwqyTzATD/ld0jlxwDkm3v2+KbGdHf4Rn1TTntg2f3e+dJ+A4cQKDUOUqj/K2
 T806kS52ldq6cOCKN0qXiNVZlgN/pBHxiUl4S5P9mnt5JJcg/pXSCUUxzqOTGqbZMuXo
 WTPo8k2HjXHyWns5E4e8rN64JFSPmYm87BxhTbq0cCuUX6EJt1aCp7GyAlQ80J9O29dd
 KRtoMDGxeDhgZqImrxAZAvW8Px3NHISp3unhudz/I1Iyn+tp16qmBO9+FA9NUBIGKkkf
 U9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5OXR1lgWAptLKU3W0CQIZNE+hOvlwc8nHcCeOKgikCc=;
 b=ufcQQ1uoG5mjl++lhszdR6TIo9+2ih3RAtDK//vUVIEBmTTTl1mZW4NWCrQUYei7F/
 c7QVL+PiOUaLGgrkb+2fHg8ndgHYEvfRay9p3WF587fJwdpPFMmL9YuduXlbVEtd/MWp
 P3UJUS35vyiWBHuOn17YcVio/kRKfvu1KqCko7ANEkkE9XJKqwb9OmRM/w/RFwj46jxH
 d32y5jLEb+qyF62cKUu1CA/6BpqOMAJj3upCRI226K+58W3x49/dwJDn2gH713N7Oc43
 we/94+/gPHHeKaqdmZy6rxvCHnU6npo0HH0PhBQF1Z0P0pou+O1XT2L+aURe3TGNBxMJ
 0cdg==
X-Gm-Message-State: APjAAAXTpgdpEuH2XNyOlNio1LMzEC5tN9zo+W49Fnau/5wd+Yzi7HXA
 v6apJE5j2Tmt6VrBsb2ZEJUgGR25FA83A8++LQ8=
X-Google-Smtp-Source: APXvYqyc60nAVZIP/khaHSKFSbqDkQ8o2ZT3rRwZZiRCLs8WEvt5bZycEm1x0HSBiWNbIlCrFwD/SlCWkEpEDF8sqQQ=
X-Received: by 2002:ac2:46dc:: with SMTP id p28mr235710lfo.23.1578967174451;
 Mon, 13 Jan 2020 17:59:34 -0800 (PST)
MIME-Version: 1.0
References: <20200109152133.23649-1-philmd@redhat.com>
 <20200109152133.23649-13-philmd@redhat.com>
In-Reply-To: <20200109152133.23649-13-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 Jan 2020 11:59:07 +1000
Message-ID: <CAKmqyKNrNKGiwVzubZjJtBj+=7vCs6tMN+7jGx6Zme=8sgLPZg@mail.gmail.com>
Subject: Re: [PATCH 12/15] accel: Introduce the current_accel() method
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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
 Eduardo Habkost <ehabkost@redhat.com>,
 "open list:Overall" <kvm@vger.kernel.org>, Juan Quintela <quintela@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 10, 2020 at 1:27 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> We want to remove the global current_machine. The accel/
> code access few times current_machine->accelerator. Introduce
> the current_accel() method first, it will then be easier to
> replace 'current_machine' by MACHINE(qdev_get_machine()).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/sysemu/accel.h | 2 ++
>  accel/accel.c          | 5 +++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
> index d4c1429711..47e5788530 100644
> --- a/include/sysemu/accel.h
> +++ b/include/sysemu/accel.h
> @@ -70,4 +70,6 @@ int accel_init_machine(AccelState *accel, MachineState =
*ms);
>  /* Called just before os_setup_post (ie just before drop OS privs) */
>  void accel_setup_post(MachineState *ms);
>
> +AccelState *current_accel(void);
> +
>  #endif
> diff --git a/accel/accel.c b/accel/accel.c
> index 1c5c3a6abb..cb555e3b06 100644
> --- a/accel/accel.c
> +++ b/accel/accel.c
> @@ -63,6 +63,11 @@ int accel_init_machine(AccelState *accel, MachineState=
 *ms)
>      return ret;
>  }
>
> +AccelState *current_accel(void)
> +{
> +    return current_machine->accelerator;
> +}
> +
>  void accel_setup_post(MachineState *ms)
>  {
>      AccelState *accel =3D ms->accelerator;
> --
> 2.21.1
>
>


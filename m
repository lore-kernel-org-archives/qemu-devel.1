Return-Path: <SRS0=tUBQ=3B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EA5C32771
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2020 09:47:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47BC72187F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2020 09:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsExOqT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BC72187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqZpn-0004Bs-FJ
	for qemu-devel@archiver.kernel.org; Sun, 12 Jan 2020 04:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iqZny-0002nL-Bb
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 04:45:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iqZnx-0005GG-Cp
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 04:45:10 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:35182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iqZnx-0005A1-4b; Sun, 12 Jan 2020 04:45:09 -0500
Received: by mail-lf1-x143.google.com with SMTP id 15so4727461lfr.2;
 Sun, 12 Jan 2020 01:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mvEyv8WsHK+y4lyiLI8T8Cwz0UxNsAP1n8oZu5GDpas=;
 b=EsExOqT+WaKoepgqT7oBU0FbwwVcObGIbJj0xCQa354MC9I0rlak12h/IOaCdVNjOM
 TS9B4peK4Wy1n3LNE7VUeZeAiNxuJMTDtOlZkmLlTMxebjdYlkuArnnwDHlyNP/IgbIY
 NE+3m9HIEl6y3exSWSEKN+obmsDn4n6eauER6SWszp2tmiqxez40m7fCaai4EScYBfzI
 CzshAOOXWob9ahNuiw+zOgiUw5FULJnXuY+LvF6XF9nIkmJCenbXBL9D1p8t4YMmXDdC
 hm93ccuX8jC1DQoRT3nOGwRFAxnKTMb6OsT7WPYMCJ9Rrtsmll0xv1zh+fKXXf/vNghk
 2iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mvEyv8WsHK+y4lyiLI8T8Cwz0UxNsAP1n8oZu5GDpas=;
 b=Xj/UNwCgAHzkf3UdHgMML2oSS18SHzMc/kPYuqQzUnB4kZebR9WXboCfpeQTaPTi70
 rgdelGppT/+xU7fpQhGuNOGq1j4pabmtW0vSBpIK4cDrJr0WwZAdNM9+eIwBBpHebeoL
 zXIfWNnTj8bNmTsXX2Fq8pv62P+JLp22MOuBehAE0vs14tgdVXHpi7XeSgCtUwG7XQrH
 jIz9SfnYfUMV/8WOIXijl1jpg/D9Kj4Iedgb0MdZEKsCxUKRyZCpRTsvTRCe4VThg38k
 Rzh2ph4Nmx2hMZ39mMf3IxgEmsbKwu8G6IM0r3XoeflUVpEF6P6zyFD+v7JwTIoSjqQF
 tMMQ==
X-Gm-Message-State: APjAAAVSBr/jl0nrP4MCFHZwMzVjrvyL5tOj0cqR/ClRVetKd+2F43dh
 oHGcPgnQril0kh3vOREwTCi1VvJCufUTHILJmh4iJho6
X-Google-Smtp-Source: APXvYqxBsmT3/S/ksEIf8xngcs0t6C+b9DJlHarA6JCrshF+M3Qvub4y4aPAefRQPsUZqr5EcjM401Rlfz38uhniS/w=
X-Received: by 2002:ac2:5498:: with SMTP id t24mr7132155lfk.84.1578822307837; 
 Sun, 12 Jan 2020 01:45:07 -0800 (PST)
MIME-Version: 1.0
References: <20200109152133.23649-1-philmd@redhat.com>
 <20200109152133.23649-8-philmd@redhat.com>
In-Reply-To: <20200109152133.23649-8-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sun, 12 Jan 2020 17:44:40 +0800
Message-ID: <CAKmqyKNbbkBeoVTfvyLt_krei-nCP_sGY_70GSiLFrQVOdd1Ag@mail.gmail.com>
Subject: Re: [PATCH 07/15] hw/core/machine-qmp-cmds: Replace current_machine
 by qdev_get_machine()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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

On Thu, Jan 9, 2020 at 11:30 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> As we want to remove the global current_machine,
> replace MACHINE_GET_CLASS(current_machine) by
> MACHINE_GET_CLASS(qdev_get_machine()).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/core/machine-qmp-cmds.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> index eed5aeb2f7..5a04d00e4f 100644
> --- a/hw/core/machine-qmp-cmds.c
> +++ b/hw/core/machine-qmp-cmds.c
> @@ -280,9 +280,9 @@ void qmp_cpu_add(int64_t id, Error **errp)
>  {
>      MachineClass *mc;
>
> -    mc =3D MACHINE_GET_CLASS(current_machine);
> +    mc =3D MACHINE_GET_CLASS(qdev_get_machine());
>      if (mc->hot_add_cpu) {
> -        mc->hot_add_cpu(current_machine, id, errp);
> +        mc->hot_add_cpu(MACHINE(qdev_get_machine()), id, errp);
>      } else {
>          error_setg(errp, "Not supported");
>      }
> --
> 2.21.1
>
>


Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789A1C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4457C20659
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WkiqGwBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4457C20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3zXn-0005Zp-FB
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:51:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j3zWV-0003CS-PA
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:50:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j3zWU-0000ul-NM
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:50:35 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44153
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j3zWT-0000t8-L2
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582019433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R3AO3tmIG7efoBv5HijqT2xz+05at74+b9OgZQ+Bdw8=;
 b=WkiqGwBArbJha3vf228aVuJGdyjjf0zvu4ao0z6TyDJkskoDn+XJIlylnWYpdBJmn+GXjm
 TOsp25NNT4BDKJGIysGRAE3qkPHHAKP2r0ZhjAJr1105GYLPKZrGAn7uGXx6CixJyLym00
 vIZjBodpoSQnvTGF9aV0QGGYUTaKmg0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-0dQR3SJTMIixBS1HsBx3qw-1; Tue, 18 Feb 2020 04:50:31 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 228DA8010EB;
 Tue, 18 Feb 2020 09:50:29 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D7951BC6D;
 Tue, 18 Feb 2020 09:50:08 +0000 (UTC)
Date: Tue, 18 Feb 2020 09:50:06 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH RESEND 02/13] audio/alsaaudio: Remove superfluous
 semicolons
Message-ID: <20200218095006.GD3080@work-vm>
References: <20200218094402.26625-1-philmd@redhat.com>
 <20200218094402.26625-3-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200218094402.26625-3-philmd@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 0dQR3SJTMIixBS1HsBx3qw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <DirtY.iCE.hu@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Julia Suvorova <jusual@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=C3=A9 (philmd@redhat.com) wrote:
> Fixes: 286a5d201e4
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
> Cc: "K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <DirtY.iCE.hu@gmail.com>
> ---
>  audio/alsaaudio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> index a23a5a0b60..a8e62542f9 100644
> --- a/audio/alsaaudio.c
> +++ b/audio/alsaaudio.c
> @@ -819,7 +819,7 @@ static size_t alsa_read(HWVoiceIn *hw, void *buf, siz=
e_t len)
>              switch (nread) {
>              case 0:
>                  trace_alsa_read_zero(len);
> -                return pos;;
> +                return pos;
> =20
>              case -EPIPE:
>                  if (alsa_recover(alsa->handle)) {
> @@ -835,7 +835,7 @@ static size_t alsa_read(HWVoiceIn *hw, void *buf, siz=
e_t len)
>              default:
>                  alsa_logerr(nread, "Failed to read %zu frames to %p\n",
>                              len, dst);
> -                return pos;;
> +                return pos;
>              }
>          }
> =20
> --=20
> 2.21.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



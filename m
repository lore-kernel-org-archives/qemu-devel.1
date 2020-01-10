Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47296C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 08:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0247C2072E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 08:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUVyzszo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0247C2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ippl3-0000YO-3J
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 03:35:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ippkN-0008SD-TZ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 03:34:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ippkL-000870-Uu
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 03:34:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34341
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ippkL-000821-Mn
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 03:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578645260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=2j1tSaVthOH/PDYiuaDpGld+JvMgnu0aX2pOj16hHV4=;
 b=dUVyzszo7hMGe34A5cfizJwFM+SD/Vl3p2wNdxJ/fPgJ7Pa+U8paht5C2Ng12CzVP3OV1y
 4BjmW34/z4ur0phZ2eLMDtmJ99k2R6AH+01W8cudGBxFSui/DlNbq5pRN8bH7QjYYiIMpX
 T4T/YX62qoyg4LCUGcSNKgh5wMmp5eA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-_N0305g9PvCD-5PzsvOiqg-1; Fri, 10 Jan 2020 03:34:19 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77C69107ACC4;
 Fri, 10 Jan 2020 08:34:18 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-154.ams2.redhat.com [10.36.116.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40966272D3;
 Fri, 10 Jan 2020 08:34:14 +0000 (UTC)
Subject: Re: [PATCH 3/4] Makefile: Restrict system emulation and tools objects
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200109153939.27173-1-philmd@redhat.com>
 <20200109153939.27173-4-philmd@redhat.com>
 <fbc4e5a3-afb2-1a6e-5c22-30d2b91cd8db@redhat.com>
 <CAAdtpL7DQrs1OtkNax9tohOWo4Wabt-SASY1O0eCU7brU0SSNQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <32471d5b-037d-6e8c-52a8-17fe5140b3b6@redhat.com>
Date: Fri, 10 Jan 2020 09:34:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAAdtpL7DQrs1OtkNax9tohOWo4Wabt-SASY1O0eCU7brU0SSNQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: _N0305g9PvCD-5PzsvOiqg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/01/2020 09.25, Philippe Mathieu-Daud=C3=A9 wrote:
> Le ven. 10 janv. 2020 09:18, Thomas Huth <thuth@redhat.com
> <mailto:thuth@redhat.com>> a =C3=A9crit=C2=A0:
>=20
>     On 09/01/2020 16.39, Philippe Mathieu-Daud=C3=A9 wrote:
>     > Restrict all the system emulation and tools objects with a
>     > Makefile IF (CONFIG_SOFTMMU OR CONFIG_TOOLS) check.
>     >
>     > Using the same description over and over is not very helpful.
>     > Use it once, just before the if() block.
>     >
>     > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     > ---
>     >=C2=A0 Makefile.objs | 19 +++++++------------
>     >=C2=A0 1 file changed, 7 insertions(+), 12 deletions(-)
>     >
>     > diff --git a/Makefile.objs b/Makefile.objs
>     > index 5aae561984..395dd1e670 100644
>     > --- a/Makefile.objs
>     > +++ b/Makefile.objs
>     > @@ -4,16 +4,15 @@ stub-obj-y =3D stubs/
>     >=C2=A0 util-obj-y =3D crypto/ util/ qobject/ qapi/
>     >=C2=A0 qom-obj-y =3D qom/
>     >=C2=A0
>     >
>     +####################################################################=
###
>     > +# code used by both qemu system emulation and qemu-img
>     > +
>     > +ifeq ($(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS)),y)
>=20
>     That ",y" at the end looks wrong?
>=20
>=20
> It's the result of the logical OR.

-ENOTENOUGHCOFFEEYET

Your code is fine, of course.

Reviewed-by: Thomas Huth <thuth@redhat.com>



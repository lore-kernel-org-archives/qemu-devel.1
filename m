Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03994C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 08:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE802080C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 08:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE802080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2ARZ-0005Y4-RM
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 04:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i2APP-0004Hd-5l
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 04:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i2APN-0004na-Jf
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 04:31:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50518)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1i2APN-0004mW-CC
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 04:31:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 92B3636887;
 Mon, 26 Aug 2019 08:31:23 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B24DC600C4;
 Mon, 26 Aug 2019 08:31:16 +0000 (UTC)
Message-ID: <6cb92688caf6514197e82f09b63d74da008b9a6f.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: =?UTF-8?Q?K=C5=91v=C3=A1g=C3=B3=2C_Zolt=C3=A1n?=
 <dirty.ice.hu@gmail.com>,  qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 11:31:15 +0300
In-Reply-To: <cd692232ed7a6158e5b77a483cb1d082108a9e45.1566779143.git.DirtY.iCE.hu@gmail.com>
References: <cover.1566779143.git.DirtY.iCE.hu@gmail.com>
 <cd692232ed7a6158e5b77a483cb1d082108a9e45.1566779143.git.DirtY.iCE.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 26 Aug 2019 08:31:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] audio: omitting audiodev= parameter is
 only deprecated
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
Cc: "reviewer:Incompatible changes" <libvir-list@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-08-26 at 02:29 +0200, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n wro=
te:
> Unfortunately, changes introduced in af2041ed2d "audio: audiodev=3D
> parameters no longer optional when -audiodev present" breaks backward
> compatibility.  This patch changes the error into a deprecation warning=
.
>=20
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.c=
om>
> ---
>  qemu-deprecated.texi | 7 +++++++
>  audio/audio.c        | 8 ++++----
>  2 files changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 00a4b6f350..9d74a1cfc0 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -72,6 +72,13 @@ backend settings instead of environment variables.  =
To ease migration to
>  the new format, the ``-audiodev-help'' option can be used to convert
>  the current values of the environment variables to ``-audiodev'' optio=
ns.
> =20
> +@subsection Creating sound card devices and vnc without audiodev=3D pr=
operty (since 4.2)
> +
> +When not using the deprecated legacy audio config, each sound card
> +should specify an @code{audiodev=3D} property.  Additionally, when usi=
ng
> +vnc, you should specify an @code{audiodev=3D} propery if you plan to
> +transmit audio through the VNC protocol.
> +
>  @subsection -mon ...,control=3Dreadline,pretty=3Don|off (since 4.1)
> =20
>  The @code{pretty=3Don|off} switch has no effect for HMP monitors, but =
is
> diff --git a/audio/audio.c b/audio/audio.c
> index 7d715332c9..e13addf922 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1412,8 +1412,9 @@ static AudioState *audio_init(Audiodev *dev, cons=
t char *name)
>          drvname =3D AudiodevDriver_str(dev->driver);
>      } else if (!QTAILQ_EMPTY(&audio_states)) {
>          if (!legacy_config) {
> -            dolog("You must specify an audiodev=3D for the device %s\n=
", name);
> -            exit(1);
> +            dolog("Device %s: audiodev default parameter is deprecated=
, please "
> +                  "specify audiodev=3D%s\n", name,
> +                  QTAILQ_FIRST(&audio_states)->dev->id);
>          }
>          return QTAILQ_FIRST(&audio_states);
>      } else {
> @@ -1548,8 +1549,7 @@ CaptureVoiceOut *AUD_add_capture(
> =20
>      if (!s) {
>          if (!legacy_config) {
> -            dolog("You must specify audiodev when trying to capture\n"=
);
> -            return NULL;
> +            dolog("Capturing without setting an audiodev is deprecated=
\n");
>          }
>          s =3D audio_init(NULL, NULL);
>      }


This allowed me to boot th VM with single audiodev without specifying the=
 audiodev in the device,
but on shutdown qemu crashes with heap corruption sadly.

 -audiodev pa,id=3Dsnd1,server=3D/run/user/103992/pulse/native
 -device ich9-intel-hda,id=3Dsound0,msi=3Don
 -device hda-micro,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0

In qemu output:
free(): invalid next size (fast)


Best regards,
	Maxim Levitsky



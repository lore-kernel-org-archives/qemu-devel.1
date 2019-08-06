Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D7DC433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 09:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 669C120651
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 09:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669C120651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huwFy-0000mN-MQ
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 05:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38479)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1huwFZ-0000MK-Ch
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 05:59:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1huwFY-0007XT-2J
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 05:59:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55290)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1huwFX-0007Wk-GJ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 05:59:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4B82B30FB8E9;
 Tue,  6 Aug 2019 09:59:21 +0000 (UTC)
Received: from work-vm (ovpn-117-206.ams2.redhat.com [10.36.117.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D77810018F9;
 Tue,  6 Aug 2019 09:59:18 +0000 (UTC)
Date: Tue, 6 Aug 2019 10:59:15 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Message-ID: <20190806095915.GD3066@work-vm>
References: <cover.1564925486.git.DirtY.iCE.hu@gmail.com>
 <ff28a2d4a61be1e7150556342a5fb83aa818c439.1564925486.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ff28a2d4a61be1e7150556342a5fb83aa818c439.1564925486.git.DirtY.iCE.hu@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 06 Aug 2019 09:59:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 03/14] audio: add audiodev property to
 vnc and wav_capture
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n (dirty.ice.hu@gmail.com) wrote:
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.c=
om>
> ---
>=20
> Notes:
>     Changes from v2:
>    =20
>     * audiodev parameter for wavcapture is now mandatory.
>     * removed some unnecessary qdict_haskey calls from hmp_wavcapture
>=20
>  ui/vnc.h        |  2 ++
>  monitor/misc.c  | 22 +++++++++++-----------
>  ui/vnc.c        | 15 ++++++++++++++-
>  hmp-commands.hx | 11 ++++++-----
>  qemu-options.hx |  6 ++++++
>  5 files changed, 39 insertions(+), 17 deletions(-)

For HMP this looks reasonable


Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> diff --git a/ui/vnc.h b/ui/vnc.h
> index 2f84db3142..6f54653455 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -183,6 +183,8 @@ struct VncDisplay
>  #ifdef CONFIG_VNC_SASL
>      VncDisplaySASL sasl;
>  #endif
> +
> +    AudioState *audio_state;
>  };
> =20
>  typedef struct VncTight {
> diff --git a/monitor/misc.c b/monitor/misc.c
> index e393333a0e..bdf857555f 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -1142,21 +1142,21 @@ static void hmp_stopcapture(Monitor *mon, const=
 QDict *qdict)
>  static void hmp_wavcapture(Monitor *mon, const QDict *qdict)
>  {
>      const char *path =3D qdict_get_str(qdict, "path");
> -    int has_freq =3D qdict_haskey(qdict, "freq");
> -    int freq =3D qdict_get_try_int(qdict, "freq", -1);
> -    int has_bits =3D qdict_haskey(qdict, "bits");
> -    int bits =3D qdict_get_try_int(qdict, "bits", -1);
> -    int has_channels =3D qdict_haskey(qdict, "nchannels");
> -    int nchannels =3D qdict_get_try_int(qdict, "nchannels", -1);
> +    int freq =3D qdict_get_try_int(qdict, "freq", 44100);
> +    int bits =3D qdict_get_try_int(qdict, "bits", 16);
> +    int nchannels =3D qdict_get_try_int(qdict, "nchannels", 2);
> +    const char *audiodev =3D qdict_get_str(qdict, "audiodev");
>      CaptureState *s;
> +    AudioState *as =3D audio_state_by_name(audiodev);
> +
> +    if (!as) {
> +        monitor_printf(mon, "Audiodev '%s' not found\n", audiodev);
> +        return;
> +    }
> =20
>      s =3D g_malloc0 (sizeof (*s));
> =20
> -    freq =3D has_freq ? freq : 44100;
> -    bits =3D has_bits ? bits : 16;
> -    nchannels =3D has_channels ? nchannels : 2;
> -
> -    if (wav_start_capture(NULL, s, path, freq, bits, nchannels)) {
> +    if (wav_start_capture(as, s, path, freq, bits, nchannels)) {
>          monitor_printf(mon, "Failed to add wave capture\n");
>          g_free (s);
>          return;
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 140f364dda..24f9be5b5d 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1222,7 +1222,7 @@ static void audio_add(VncState *vs)
>      ops.destroy =3D audio_capture_destroy;
>      ops.capture =3D audio_capture;
> =20
> -    vs->audio_cap =3D AUD_add_capture(NULL, &vs->as, &ops, vs);
> +    vs->audio_cap =3D AUD_add_capture(vs->vd->audio_state, &vs->as, &o=
ps, vs);
>      if (!vs->audio_cap) {
>          error_report("Failed to add audio capture");
>      }
> @@ -3369,6 +3369,9 @@ static QemuOptsList qemu_vnc_opts =3D {
>          },{
>              .name =3D "non-adaptive",
>              .type =3D QEMU_OPT_BOOL,
> +        },{
> +            .name =3D "audiodev",
> +            .type =3D QEMU_OPT_STRING,
>          },
>          { /* end of list */ }
>      },
> @@ -3806,6 +3809,7 @@ void vnc_display_open(const char *id, Error **err=
p)
>      const char *saslauthz;
>      int lock_key_sync =3D 1;
>      int key_delay_ms;
> +    const char *audiodev;
> =20
>      if (!vd) {
>          error_setg(errp, "VNC display not active");
> @@ -3991,6 +3995,15 @@ void vnc_display_open(const char *id, Error **er=
rp)
>      }
>      vd->ledstate =3D 0;
> =20
> +    audiodev =3D qemu_opt_get(opts, "audiodev");
> +    if (audiodev) {
> +        vd->audio_state =3D audio_state_by_name(audiodev);
> +        if (!vd->audio_state) {
> +            error_setg(errp, "Audiodev '%s' not found", audiodev);
> +            goto fail;
> +        }
> +    }
> +
>      device_id =3D qemu_opt_get(opts, "display");
>      if (device_id) {
>          int head =3D qemu_opt_get_number(opts, "head", 0);
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index bfa5681dd2..cfcc044ce4 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -819,16 +819,17 @@ ETEXI
> =20
>      {
>          .name       =3D "wavcapture",
> -        .args_type  =3D "path:F,freq:i?,bits:i?,nchannels:i?",
> -        .params     =3D "path [frequency [bits [channels]]]",
> +        .args_type  =3D "path:F,audiodev:s,freq:i?,bits:i?,nchannels:i=
?",
> +        .params     =3D "path audiodev [frequency [bits [channels]]]",
>          .help       =3D "capture audio to a wave file (default frequen=
cy=3D44100 bits=3D16 channels=3D2)",
>          .cmd        =3D hmp_wavcapture,
>      },
>  STEXI
> -@item wavcapture @var{filename} [@var{frequency} [@var{bits} [@var{cha=
nnels}]]]
> +@item wavcapture @var{filename} @var{audiodev} [@var{frequency} [@var{=
bits} [@var{channels}]]]
>  @findex wavcapture
> -Capture audio into @var{filename}. Using sample rate @var{frequency}
> -bits per sample @var{bits} and number of channels @var{channels}.
> +Capture audio into @var{filename} from @var{audiodev}, using sample ra=
te
> +@var{frequency} bits per sample @var{bits} and number of channels
> +@var{channels}.
> =20
>  Defaults:
>  @itemize @minus
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 9621e934c0..a308e5f5aa 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1978,6 +1978,12 @@ can help the device and guest to keep up and not=
 lose events in case
>  events are arriving in bulk.  Possible causes for the latter are flaky
>  network connections, or scripts for automated testing.
> =20
> +@item audiodev=3D@var{audiodev}
> +
> +Use the specified @var{audiodev} when the VNC client requests audio
> +transmission. When not using an -audiodev argument, this option must
> +be omitted, otherwise is must be present and specify a valid audiodev.
> +
>  @end table
>  ETEXI
> =20
> --=20
> 2.22.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


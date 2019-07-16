Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06420C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 10:03:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED6D20665
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 10:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED6D20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnKIp-0004Sa-Pl
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 06:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39866)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hnKIY-0003bC-T9
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hnKIX-0007aD-8d
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:03:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44664)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hnKIW-0007ZW-W0
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:03:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 935DC22388B;
 Tue, 16 Jul 2019 10:02:59 +0000 (UTC)
Received: from work-vm (ovpn-117-169.ams2.redhat.com [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 135B15DAA4;
 Tue, 16 Jul 2019 10:02:53 +0000 (UTC)
Date: Tue, 16 Jul 2019 11:02:51 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190716100251.GB2770@work-vm>
References: <cover.1563224628.git.DirtY.iCE.hu@gmail.com>
 <8245dab2e59b99b55f3f7773fd39dc920ae48951.1563224628.git.DirtY.iCE.hu@gmail.com>
 <878ssyqyyu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878ssyqyyu.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 16 Jul 2019 10:02:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 03/14] audio: add audiodev property to
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> "K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <dirty.ice.hu@gmail.com> writes:
>=20
> > Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail=
.com>
> > ---
> >  ui/vnc.h        |  2 ++
> >  monitor/misc.c  | 12 +++++++++++-
> >  ui/vnc.c        | 15 ++++++++++++++-
> >  hmp-commands.hx | 13 ++++++++-----
> >  qemu-options.hx |  6 ++++++
> >  5 files changed, 41 insertions(+), 7 deletions(-)
> >
> > diff --git a/ui/vnc.h b/ui/vnc.h
> > index 2f84db3142..6f54653455 100644
> > --- a/ui/vnc.h
> > +++ b/ui/vnc.h
> > @@ -183,6 +183,8 @@ struct VncDisplay
> >  #ifdef CONFIG_VNC_SASL
> >      VncDisplaySASL sasl;
> >  #endif
> > +
> > +    AudioState *audio_state;
> >  };
> > =20
> >  typedef struct VncTight {
> > diff --git a/monitor/misc.c b/monitor/misc.c
> > index e393333a0e..f97810d370 100644
> > --- a/monitor/misc.c
> > +++ b/monitor/misc.c
> > @@ -1148,7 +1148,17 @@ static void hmp_wavcapture(Monitor *mon, const=
 QDict *qdict)
> >      int bits =3D qdict_get_try_int(qdict, "bits", -1);
> >      int has_channels =3D qdict_haskey(qdict, "nchannels");
> >      int nchannels =3D qdict_get_try_int(qdict, "nchannels", -1);
> > +    const char *audiodev =3D qdict_get_try_str(qdict, "audiodev");
> >      CaptureState *s;
> > +    AudioState *as =3D NULL;
> > +
> > +    if (audiodev) {
> > +        as =3D audio_state_by_name(audiodev);
> > +        if (!as) {
> > +            monitor_printf(mon, "Invalid audiodev specified\n");
> > +            return;
> > +        }
> > +    }
>=20
> Note for later: if "audiodev" is specified, it must name an existing
> AudioState.
>=20
> > =20
> >      s =3D g_malloc0 (sizeof (*s));
> > =20
> > @@ -1156,7 +1166,7 @@ static void hmp_wavcapture(Monitor *mon, const =
QDict *qdict)
> >      bits =3D has_bits ? bits : 16;
> >      nchannels =3D has_channels ? nchannels : 2;
> > =20
> > -    if (wav_start_capture(NULL, s, path, freq, bits, nchannels)) {
> > +    if (wav_start_capture(as, s, path, freq, bits, nchannels)) {
> >          monitor_printf(mon, "Failed to add wave capture\n");
> >          g_free (s);
> >          return;
>=20
> Note for later: this is the only other failure mode.
>=20
> > diff --git a/ui/vnc.c b/ui/vnc.c
> > index 140f364dda..24f9be5b5d 100644
> > --- a/ui/vnc.c
> > +++ b/ui/vnc.c
> > @@ -1222,7 +1222,7 @@ static void audio_add(VncState *vs)
> >      ops.destroy =3D audio_capture_destroy;
> >      ops.capture =3D audio_capture;
> > =20
> > -    vs->audio_cap =3D AUD_add_capture(NULL, &vs->as, &ops, vs);
> > +    vs->audio_cap =3D AUD_add_capture(vs->vd->audio_state, &vs->as, =
&ops, vs);
> >      if (!vs->audio_cap) {
> >          error_report("Failed to add audio capture");
> >      }
> > @@ -3369,6 +3369,9 @@ static QemuOptsList qemu_vnc_opts =3D {
> >          },{
> >              .name =3D "non-adaptive",
> >              .type =3D QEMU_OPT_BOOL,
> > +        },{
> > +            .name =3D "audiodev",
> > +            .type =3D QEMU_OPT_STRING,
> >          },
> >          { /* end of list */ }
> >      },
> > @@ -3806,6 +3809,7 @@ void vnc_display_open(const char *id, Error **e=
rrp)
> >      const char *saslauthz;
> >      int lock_key_sync =3D 1;
> >      int key_delay_ms;
> > +    const char *audiodev;
> > =20
> >      if (!vd) {
> >          error_setg(errp, "VNC display not active");
> > @@ -3991,6 +3995,15 @@ void vnc_display_open(const char *id, Error **=
errp)
> >      }
> >      vd->ledstate =3D 0;
> > =20
> > +    audiodev =3D qemu_opt_get(opts, "audiodev");
> > +    if (audiodev) {
> > +        vd->audio_state =3D audio_state_by_name(audiodev);
> > +        if (!vd->audio_state) {
> > +            error_setg(errp, "Audiodev '%s' not found", audiodev);
> > +            goto fail;
> > +        }
> > +    }
>=20
> Note for later: if "audiodev" is specified, it must name an existing
> AudioState.
>=20
> I like this error message better than the one in hmp_wavcapture().  Use
> it there, too?
>=20
> Move it into audio_state_by_name() by giving it an Error **errp
> parameter?  Matter of taste, up to you.
>=20
> > +
> >      device_id =3D qemu_opt_get(opts, "display");
> >      if (device_id) {
> >          int head =3D qemu_opt_get_number(opts, "head", 0);
> > diff --git a/hmp-commands.hx b/hmp-commands.hx
> > index bfa5681dd2..fa7f009268 100644
> > --- a/hmp-commands.hx
> > +++ b/hmp-commands.hx
> > @@ -819,16 +819,19 @@ ETEXI
> > =20
> >      {
> >          .name       =3D "wavcapture",
> > -        .args_type  =3D "path:F,freq:i?,bits:i?,nchannels:i?",
> > -        .params     =3D "path [frequency [bits [channels]]]",
> > +        .args_type  =3D "path:F,freq:i?,bits:i?,nchannels:i?,audiode=
v:s?",
> > +        .params     =3D "path [frequency [bits [channels [audiodev]]=
]]",
> >          .help       =3D "capture audio to a wave file (default frequ=
ency=3D44100 bits=3D16 channels=3D2)",
> >          .cmd        =3D hmp_wavcapture,
> >      },
> >  STEXI
> > -@item wavcapture @var{filename} [@var{frequency} [@var{bits} [@var{c=
hannels}]]]
> > +@item wavcapture @var{filename} [@var{frequency} [@var{bits} [@var{c=
hannels} [@var{audiodev}]]]]
> >  @findex wavcapture
> > -Capture audio into @var{filename}. Using sample rate @var{frequency}
> > -bits per sample @var{bits} and number of channels @var{channels}.
> > +Capture audio into @var{filename} from @var{audiodev}, using sample =
rate
> > +@var{frequency} bits per sample @var{bits} and number of channels
> > +@var{channels}. When not using an -audiodev argument on command line=
,
> > +@var{audiodev} must be omitted, otherwise is must specify a valid
> > +audiodev.
>=20
> I can see the code for "must specify a valid audiodev" in
> hmp_wavcapture().  Where is "must be omitted" checked?

Isn't that just that there wont be any named devices so you wont
be able to specify a valid one?

Dave

> Preexisting: the list "sample rate @var{frequency} bits per sample
> @var{bits} and number of channels @var{channels}" lacks a comma after
> @var{frequency}, please fix that.  I'd put one after @var{bits} as well=
,
> but that's a matter of taste[*]
>=20
> The sentence is of the form "if not COND then A else B".  The
> less-negated form "if COND then B else A" is commonly easier to read.
>=20
> Documentation says "from @var{audiodev}".  But when "not using an
> -audiodev argument on command line, +@var{audiodev} must be omitted".
> Where does it sample from then?  I figure from some default audio
> device.  Where is that default audio device explained?  I skimmed the
> -audiodev documentation in qemu-options.hx, but couldn't see it there.
>=20
> Suggest to say "an -audiodev command line option" instead of "an
> -audiodev argument on command line".
>=20
> Double-checking:
>=20
> * -audiodev is the only way to create an audio backend.
>=20
> * If the user creates no audio backend, QEMU supplies a default audio
>   backend.
>=20
> Correct?
>=20
> Other kinds of backends can also be created at run-time with the
> monitor.  I'm not asking you provide that for audio.  I'm just wonderin=
g
> whether it could conceivably be useful.
>=20
> If yes, you might want to avoid the narrow "if using -audiodev", and
> instead say "if the default audio device is in use".
>=20
> > =20
> >  Defaults:
> >  @itemize @minus
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 9621e934c0..a308e5f5aa 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -1978,6 +1978,12 @@ can help the device and guest to keep up and n=
ot lose events in case
> >  events are arriving in bulk.  Possible causes for the latter are fla=
ky
> >  network connections, or scripts for automated testing.
> > =20
> > +@item audiodev=3D@var{audiodev}
> > +
> > +Use the specified @var{audiodev} when the VNC client requests audio
> > +transmission. When not using an -audiodev argument, this option must
> > +be omitted, otherwise is must be present and specify a valid audiode=
v.
> > +
> >  @end table
> >  ETEXI
>=20
> Same as for wavcapture, basically.
>=20
>=20
> [*] https://en.wikipedia.org/wiki/Serial_comma
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B643C32755
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03ECD20835
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03ECD20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCO68-00008S-2u
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 09:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCO4q-0007fy-Nf
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:08:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCO4o-0005Nh-FL
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:08:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56424)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCO4o-0005NZ-7h
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:08:26 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7936AA2667F;
 Mon, 23 Sep 2019 13:08:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65AA210016EB;
 Mon, 23 Sep 2019 13:08:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E59FE113864E; Mon, 23 Sep 2019 15:08:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Subject: Re: [PATCH v4 15/24] audio: add mixing-engine option (documentation)
References: <cover.1568927990.git.DirtY.iCE.hu@gmail.com>
 <68c4b4bd438e9cb5c97aed32ee31e3dabd96cbf6.1568927990.git.DirtY.iCE.hu@gmail.com>
Date: Mon, 23 Sep 2019 15:08:20 +0200
In-Reply-To: <68c4b4bd438e9cb5c97aed32ee31e3dabd96cbf6.1568927990.git.DirtY.iCE.hu@gmail.com>
 (=?utf-8?B?IkvFkXbDoWfDsywgWm9sdMOhbiIncw==?= message of "Thu, 19 Sep 2019
 23:24:23 +0200")
Message-ID: <87sgonma7v.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Mon, 23 Sep 2019 13:08:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <dirty.ice.hu@gmail.com> writes:

> This will allow us to disable mixeng when we use a decent backend.
>
> Disabling mixeng have a few advantages:
> * we no longer convert the audio output from one format to another, when
>   the underlying audio system would just convert it to a third format.
>   We no longer convert, only the underlying system, when needed.
> * the underlying system probably has better resampling and sample format
>   converting methods anyway...
> * we may support formats that the mixeng currently does not support (S24
>   or float samples, more than two channels)
> * when using an audio server (like pulseaudio) different sound card
>   outputs will show up as separate streams, even if we use only one
>   backend
>
> Disadvantages:
> * audio capturing no longer works (wavcapture, and vnc audio extension)
> * some backends only support a single playback stream or very picky
>   about the audio format.  In this case we can't disable mixeng.
>
> However mixeng is not removed, only made optional, so this shouldn't be
> a big concern.
>
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com>
> ---
>
> Notes:
>     Changes from v1:
>=20=20=20=20=20
>     * renamed mixeng to mixing-engine
>
>  qapi/audio.json | 5 +++++
>  qemu-options.hx | 6 ++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/qapi/audio.json b/qapi/audio.json
> index 9fefdf5186..0535eff794 100644
> --- a/qapi/audio.json
> +++ b/qapi/audio.json
> @@ -11,6 +11,10 @@
>  # General audio backend options that are used for both playback and
>  # recording.
>  #
> +# @mixing-engine: use QEMU's mixing engine to mix all streams inside QEM=
U. When
> +#                 set to off, fixed-settings must be also off. Not every=
 backend
> +#                 compatible with the off setting (default on, since 4.2)
> +#

Last sentence no verb.

Which backends are compatible?

What happens when you try the off setting with incompatible backends?

>  # @fixed-settings: use fixed settings for host input/output. When off,
>  #                  frequency, channels and format must not be
>  #                  specified (default true)
> @@ -31,6 +35,7 @@
>  ##
>  { 'struct': 'AudiodevPerDirectionOptions',
>    'data': {
> +    '*mixing-engine':  'bool',
>      '*fixed-settings': 'bool',
>      '*frequency':      'uint32',
>      '*channels':       'uint32',
> diff --git a/qemu-options.hx b/qemu-options.hx
> index bbfd936d29..395427422a 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -433,6 +433,7 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
>      "                specifies the audio backend to use\n"
>      "                id=3D identifier of the backend\n"
>      "                timer-period=3D timer period in microseconds\n"
> +    "                in|out.mixing-engine=3D use mixing engine to mix st=
reams inside QEMU\n"
>      "                in|out.fixed-settings=3D use fixed settings for hos=
t audio\n"
>      "                in|out.frequency=3D frequency to use with fixed set=
tings\n"
>      "                in|out.channels=3D number of channels to use with f=
ixed settings\n"
> @@ -503,6 +504,11 @@ Identifies the audio backend.
>  Sets the timer @var{period} used by the audio subsystem in microseconds.
>  Default is 10000 (10 ms).
>=20=20
> +@item in|out.mixing-engine=3Don|off
> +Use QEMU's mixing engine to mix all streams inside QEMU.  When off,
> +@var{fixed-settings} must be off too.  Not every backend is fully
> +compatible with the off setting.  Default is on.
> +
>  @item in|out.fixed-settings=3Don|off
>  Use fixed settings for host audio.  When off, it will change based on
>  how the guest opens the sound card.  In this case you must not specify


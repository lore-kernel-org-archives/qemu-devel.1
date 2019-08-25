Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA68CC3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 22:16:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CDD5206E0
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 22:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDD5206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i20oE-0003kG-S9
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 18:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i20nU-0003L2-Ha
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 18:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i20nT-00018P-10
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 18:15:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44532)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1i20nS-00017o-QF
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 18:15:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7867B59451;
 Sun, 25 Aug 2019 22:15:37 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E4B41001B13;
 Sun, 25 Aug 2019 22:15:32 +0000 (UTC)
Message-ID: <813e5200e860b3615e5e827bb3a761b503ef1702.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: =?UTF-8?Q?Zolt=C3=A1n_K=C5=91v=C3=A1g=C3=B3?= <dirty.ice.hu@gmail.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 01:15:31 +0300
In-Reply-To: <cc1b515e-de9b-8bb0-d1e1-94f038420853@gmail.com>
References: <20190821084113.1840-1-kraxel@redhat.com>
 <20190821084113.1840-8-kraxel@redhat.com>
 <01aadba9669734bfde832a01bb62f7746a57f905.camel@redhat.com>
 <cc1b515e-de9b-8bb0-d1e1-94f038420853@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Sun, 25 Aug 2019 22:15:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 07/15] audio: audiodev= parameters no longer
 optional when -audiodev present
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
Cc: "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Walle <michael@walle.cc>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 2019-08-25 at 20:05 +0200, Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3 wrot=
e:
> On 2019-08-25 11:44, Maxim Levitsky wrote:
> > On Wed, 2019-08-21 at 10:41 +0200, Gerd Hoffmann wrote:
> > > From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>
> > >=20
> > > This means you should probably stop using -soundhw (as it doesn't a=
llow
> > > you to specify any options) and add the device manually with -devic=
e.
> > > The exception is pcspk, it's currently not possible to manually add=
 it.
> > > To use it with audiodev, use something like this:
> > >=20
> > >     -audiodev id=3Dfoo,... -global isa-pcspk.audiodev=3Dfoo -soundh=
w pcspk
> >=20
> > Hi!
>=20
> Hi,
>=20
> > There is one corner case this breaks.
> > In qemu 4.1.0, there is no way to specify audiodev for a sound device=
, specifying it
> > fails with error.
> > So some of my machines have audiodev (which is miles better that usin=
g old env variables)
> > but also have sound devices without audiodev reference since this was=
n't supported.
> >=20
> >=20
> > In what will be qemu 4.2, you must specify it, thus this kind of brea=
ks backward compatibility.
> > Maybe we can have audiodev reference optional for a version or two?
> >=20
> > This is just a minor itch, as otherwise the sound improvements are re=
ally good. The days
> > of installing that old realtek driver are finally gone :-)
>=20
> Hmm, this is what happens when you split a patch series.  We could
> either revert this patch, or alternatively turn the error messages into
> warnings about using deprecated behavior.
Warning would be great in this case!
>=20
> > Another thing I noted, that there is no way for pulseaudio audiodev t=
o specify the 'client name',
> > it always shows up in pavucontrl as the socket path to the server.=20
> > Thus if I added two PA audiodevs, I can't really distinguish between =
them.
> > The in|out.name=3D seems to specify the pulseaudio source/sink to con=
nect to, which is not the same.
>=20
> We currently supply the constant "qemu" as a name to pa_stream_new.
> While it's still not ideal, shouldn't this end up as a client name in
> pulseaudio instead of a socket path?

Actually it seems that pulseaudio has two names supplied for each stream
Maybe stream name and application name?

This is how chromium playback looks versus qemu in pavucontrol and in gno=
me volume control.

https://imgur.com/a/I8HZhgx

I do notice that 'qemu' now, in pavucontrol though.

Best regards,
	Maxim Levitsky

>=20
> Regards,
> Zoltan




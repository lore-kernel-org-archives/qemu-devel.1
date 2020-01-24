Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE38C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB80320718
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4MAh8Jr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB80320718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuvdt-0006YJ-Q1
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 04:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iuvc1-0004UG-3b
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iuvbz-00043X-DO
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:50:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26870
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iuvbz-000436-96
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579859447;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=psCmyVvj912t2AYjaRoKtJzzrooJP0iYLVnRHIsFElo=;
 b=b4MAh8JrN/qrM1M6AYtx4p8KSkNQpkI0wutZZfp5aGJgS/QxQu7z/6qdwUqqpDCnuvh/q3
 SE4cPegiTRGAs/VI7JNagkGPhrywrbLEq4OBYDDsnfi6gnVVLhayYgMstOuDRBVD0I/vVC
 Qy/hprg9XiW7y8OMEeLSaXNO9+TBKVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-S2rSNH1_OFGOiTo6rq9nSw-1; Fri, 24 Jan 2020 04:50:43 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3BB3106BAAE;
 Fri, 24 Jan 2020 09:50:41 +0000 (UTC)
Received: from redhat.com (ovpn-112-52.ams2.redhat.com [10.36.112.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B940B5C1BB;
 Fri, 24 Jan 2020 09:50:30 +0000 (UTC)
Date: Fri, 24 Jan 2020 09:50:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200124095027.GA824327@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
 <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: S2rSNH1_OFGOiTo6rq9nSw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 23, 2020 at 04:07:09PM -0500, John Snow wrote:
>=20
>=20
> On 1/23/20 2:01 PM, Daniel P. Berrang=C3=A9 wrote:
> > IOW, the difficulty with configuring QEMU via JSON is not the fault
> > of JSON itself, it is the lack of knowledge amongst users and docs,
> > compounded by our never ending "improvements" to the human syntax.
> > There are other factors too, such as our only partial coverage of
> > config using JSON - some is only possible via the CLI still.
> >=20
>=20
> I'm fine with getting rid of HMP entirely, I think. It's a weird
> interface with bizarre behavior that's hard to support.
>=20
> There's a few commands in there we just don't support at all, but maybe
> it's time to start deprecating one-by-one any of the individual commands
> that are better served by QMP these days, to send the message that HMP's
> days are numbered.
>=20
> Bye-bye!
>=20
> As for the CLI, well, that's part of the discussion at hand...
>=20
> >=20
> > I guess my point is that with a scrap & startover view point, we
> > should arguably completely ignore the design question of how to
> > flatten JSON for humans/command line, as it is the wrong problem.
> > Instead focus on the problem of making use of JSON the best way
> > to deal with QEMU both functionally and practically, for humans
> > and machines alike.
> >=20
>=20
> Well, sure. The context of this email was qmp-shell though, which is
> meant to help facilitate the entry of JSON commands so that you *can*
> indeed just forego the CLI/HMP entirely.
>=20
> If you are of the opinion that every user of QEMU should be copy/pasting
> JSON straight into a socket and we should delete qmp-shell, that's
> certainly a fine opinion.

I think part of the pain of qmp-shell comes from the very fact that
it is trying to be an interactive shell. This points people towards
interactively typing in the commands, which is horrific when you get
anywhere near the JSON, or even dot-notation traditional commands.

If it was just a qmp-client that was single shot, we'd encourage
people to create the JSON in a sensible way - vim/emacs/whatever.

Bash/dash/zsh/$whatever is their interactive shell, with massively
more features than qmp-shell. You have command history, autocomplete,
conditional and looping constructs, and everything a normal shell
offers.

The only strong reason for qmp-shell to be interactive would be if
the initial protoocl handshake was too slow. I can't see that being
a problem with QMP.=20

> I'm coming from the side that I love qmp-shell; I find it useful, but it
> has some syntax problems. How do I solve them? Is there a way to solve
> them? QAPI is here to stay, and QAPI involves hierarchical data. That
> data is usually best represented by something like json or yaml, but
> those are hard to type in a shell.
>=20
> What do we do about that?

Here's one conceptual vision of how a better QEMU might look:

  * qemu-runtime-$TARGET

    A binary that contains the implementation for the machine
    emulator for $TARGET.

    This has no command line arguments except for a UNIX
    socket path which is a QMP server


  * qemu-launcher-$TARGET

    A binary that is able to launch qemu-runtime-$TARGET
    with jailers active.

    This has no command line arguments except for a pair
    of UNIX socket paths. One is a QMP server, the other
    is the path for the QMP of qemu-runtime-$TARGET.

    Commands it processes will be in automatically proxied
    through to the qemu-runtime-$TARGET QMP, with appropriate
    jailer updates being done in between.


  * qemu-client

    A binary that speaks QMP, connects, runs a single command,
    disconnects.

    It is used to talk to either qemu-runtime-$TARGET or
    qemu-launcher-$TARGET, depending on whether the mgmt app
    or user wants to be making use of the jailer facilities
    or not. =20


  * qemu-system-$TARGET

    The current binaries that exist today.

    qemu-system-$TARGET should not be part of our formal
    stability promise. We won't gratuitously / knowingly
    break without good reason, but we will accept that
    breakage can happen. Stability is only offered by
    the qemu-{runtime,launcher}-$TARGET.

    Several choices for their future in long term:

      - Leave them as-is and basically ignore them
        whereever practical going forward, so we
=09minimally worry about backcompat breakage

      - Plan to re-write them so that they are simply
        a shim the forks+execs qemu-runtime-$TARGET
=09and does syntax translation from CLI/HMP/QMP.

      - Deprecate them with a view to deletion entirely
        in $NNN years. For some large-ish value of NNN,
=09given how well known they are


Example usage:

1. Launch the QEMU runtime for the desired target

     $ qemu-runtime-x86_64 myvm.sock

2. Load the configuration to define the VM

   $ cat myvm.yaml
   commands:
     - machine_declare:
         name: pc-q35-5.0
=09 ...
     - blockdev_add:
         ...
     - device_add:
         ...
     - blockdev_add:
         ...
     - device_add:
         ...
   $ qemu-client myvm.sock myvm.yaml


3. Hotplug a disk

   $ cat mynewdisk.yaml
   commands:
     - blockdev_add:
         ...
     - device_add:
         ...
   $ qemu-client myvm.sock mynewdisk.yaml


3. Hotunplug a disk

   $ cat myolddisk.yaml
   commands:
     - device_del:
         ...
     - blockdev_del:
         ...
   $ qemu-client myvm.sock myolddisk.yaml

Using jailers, just means adding in a use of qemu-launcher-$TARGET
at the start.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|



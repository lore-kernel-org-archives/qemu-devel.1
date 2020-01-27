Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147C0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 20:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEBF624679
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 20:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbFUGw/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEBF624679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwB1p-0004Es-SY
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 15:30:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iwB0z-0003WB-0L
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 15:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iwB0w-0008G8-NB
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 15:29:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54784
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iwB0w-0008EN-Bq
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 15:29:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580156981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JQtyl5QfRv5O+WIfpypjVjy31T+Hsn0R6JOndK3Fo+g=;
 b=KbFUGw/UmgXkFPgyc4MQlaC3KoVHCVTliZ0uZtFLx5MoXhGRJSwH5UTA3pczU04QPjPfFT
 CEUBYdkvUSX/EbZHWpQx0Zix8q98q7PApnQQnvAly+vB/sewZeXmPXOhtTywC020HW5UaI
 asE2NZejJW3Wj0p2iDvAUXmhpSVCbRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-P89q2AsWPGuT9RVPvQjb0A-1; Mon, 27 Jan 2020 15:29:39 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDE788010C5;
 Mon, 27 Jan 2020 20:29:37 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2C6E1001B23;
 Mon, 27 Jan 2020 20:29:27 +0000 (UTC)
Date: Mon, 27 Jan 2020 20:29:25 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200127202925.GE3419@work-vm>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
 <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <20200124095027.GA824327@redhat.com>
 <20200127143505.GD5669@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200127143505.GD5669@linux.fritz.box>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: P89q2AsWPGuT9RVPvQjb0A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Kevin Wolf (kwolf@redhat.com) wrote:
> Am 24.01.2020 um 10:50 hat Daniel P. Berrang=E9 geschrieben:
> > On Thu, Jan 23, 2020 at 04:07:09PM -0500, John Snow wrote:
> > > Well, sure. The context of this email was qmp-shell though, which is
> > > meant to help facilitate the entry of JSON commands so that you *can*
> > > indeed just forego the CLI/HMP entirely.
> > >=20
> > > If you are of the opinion that every user of QEMU should be copy/past=
ing
> > > JSON straight into a socket and we should delete qmp-shell, that's
> > > certainly a fine opinion.
> >=20
> > I think part of the pain of qmp-shell comes from the very fact that
> > it is trying to be an interactive shell. This points people towards
> > interactively typing in the commands, which is horrific when you get
> > anywhere near the JSON, or even dot-notation traditional commands.
> >=20
> > If it was just a qmp-client that was single shot, we'd encourage
> > people to create the JSON in a sensible way - vim/emacs/whatever.
>=20
> I don't see how this is sensible. QMP commands are something that I
> reuse even less than VM configurations, so creating a one-off file for
> each would take me a lot more time and I would still have to type the
> same JSON code that I have to type with -qmp stdio.
>=20
> The reason it is and should be an interactive shell is that I'm
> interacting with it. Switching back and forth between a text editor and
> a shell to actually send the command to QEMU would make things only even
> more cumbersome than they already are.
>=20
> > Bash/dash/zsh/$whatever is their interactive shell, with massively
> > more features than qmp-shell. You have command history, autocomplete,
> > conditional and looping constructs, and everything a normal shell
> > offers.
>=20
> If I wanted to program a QMP client, I would use Python. For me,
> conditionals and loops are completely out of scope for a QMP shell. I
> just want an easy way to tell QEMU to do something specific.
>=20
> A command history already exists for qmp-shell. It's better than bash
> because it doesn't mix QMP history with whatever else I do on my
> computer.
>=20
> Autocomplete in qmp-shell doesn't exist, as far as I know, but if
> implemented, it could be a lot more useful than bash completion because
> it could offer key completion based on the QMP schema.
>=20
> This is in fact a big part of the problem that qmp-shell really needs to
> solve before it can replace HMP: How to make writing commands at least
> almost as simple as with HMP. If I can just press tab a few times to
> cycle through the available options for the command, that would already
> be a massive improvement over writing JSON manually (which you would
> still have to do with your text-file based approach, without any
> QMP-specific support).

Doing all that in a python process (i.e. an actual python shell with a
bunch of qemu commands added) seems easyish.

> The other part that it needs to solve is how to be available by default
> without specifying anything on the command line. Basically, if I press
> Ctrl-Alt-2, I want to get to a monitor shell. If that shell is
> implemented internally or by an external Python process, I don't mind.

That is a harder part. (I rarely use Ctrl-Alt-2 actually; I mostly
use HMP on stdin).

Dave

> > The only strong reason for qmp-shell to be interactive would be if
> > the initial protoocl handshake was too slow. I can't see that being
> > a problem with QMP.
>=20
> Speed would be the least of my concerns. This is about manual use, and
> it already takes me a while to type in my commands.
>=20
> > Example usage:
> >=20
> > 1. Launch the QEMU runtime for the desired target
> >=20
> >      $ qemu-runtime-x86_64 myvm.sock
> >=20
> > 2. Load the configuration to define the VM
> >=20
> >    $ cat myvm.yaml
> >    commands:
> >      - machine_declare:
> >          name: pc-q35-5.0
> > =09 ...
> >      - blockdev_add:
> >          ...
> >      - device_add:
> >          ...
> >      - blockdev_add:
> >          ...
> >      - device_add:
> >          ...
> >    $ qemu-client myvm.sock myvm.yaml
> >=20
> >=20
> > 3. Hotplug a disk
> >=20
> >    $ cat mynewdisk.yaml
> >    commands:
> >      - blockdev_add:
> >          ...
> >      - device_add:
> >          ...
> >    $ qemu-client myvm.sock mynewdisk.yaml
> >=20
> >=20
> > 3. Hotunplug a disk
> >=20
> >    $ cat myolddisk.yaml
> >    commands:
> >      - device_del:
> >          ...
> >      - blockdev_del:
> >          ...
> >    $ qemu-client myvm.sock myolddisk.yaml
>=20
> Just to compare, this is what the human user oriented flow looks like
> today:
>=20
> 1. qemu-system-x86_64 -M pc-q35-5.0 -drive if=3Dvirtio,... -cdrom ...
>=20
> 2. <Press Ctrl-Alt-2 to get to the HMP shell>
>    (qemu) drive_add ...
>    <Press Ctrl-Alt-1 to get back to the guest>
>=20
> 3. <Press Ctrl-Alt-2 to get to the HMP shell>
>    (qemu) device_del ...
>    <Press Ctrl-Alt-1 to get back to the guest>
>=20
> This is what we're competing with, and honestly I don't see how your
> qemu-runtime-*/qemu-client based flow comes even close to it in terms of
> usability.
>=20
> QMP, JSON and YAML may be nice machine interfaces, but having nice
> machine interfaces doesn't mean that you shouldn't also have something
> that is suitable for humans. qmp-shell is trying to be that, and while
> it leaves much to be desired in its current state, replacing it with
> even more machine-friendly stuff that is cumbersome for humans isn't the
> right answer.
>=20
> Kevin
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



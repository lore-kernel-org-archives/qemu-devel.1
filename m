Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5851C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F38024684
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXELHI0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F38024684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwOcf-0007ap-PF
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 06:01:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iwOb0-0005oT-80
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:59:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iwOaz-0001B6-AR
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:59:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22999
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iwOaz-0001Ah-6H
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580209188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zkBmLB/JJN+ZEUKVcBSlwaA4CVInlGKUEFyoXzxOk0c=;
 b=fXELHI0QLMHmwO8z0I78NWTFrVuERDWLLoP9IF1iPnLp7cyJLThfC44oBPxh2a1+WW5mS5
 iKlSNy6DjhuLOSbhrEokvoDY/A+LpQMqwGu+IzdNUw7YXv3kjBwtGHLhSFepiMGZ9lLCVu
 9KxRvOeB4G5GuSrHq58xB7vX+safwtg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-tIEVltOqNAaIXhAAJWjV1w-1; Tue, 28 Jan 2020 05:59:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FCC213E1;
 Tue, 28 Jan 2020 10:59:45 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-106.ams2.redhat.com [10.36.117.106])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BC5360BFB;
 Tue, 28 Jan 2020 10:59:33 +0000 (UTC)
Date: Tue, 28 Jan 2020 11:59:32 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200128105932.GC6431@linux.fritz.box>
References: <87h81unja8.fsf@dusky.pond.sub.org>
 <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <20200124095027.GA824327@redhat.com>
 <20200127143505.GD5669@linux.fritz.box>
 <20200127202925.GE3419@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200127202925.GE3419@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: tIEVltOqNAaIXhAAJWjV1w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

Am 27.01.2020 um 21:29 hat Dr. David Alan Gilbert geschrieben:
> * Kevin Wolf (kwolf@redhat.com) wrote:
> > A command history already exists for qmp-shell. It's better than bash
> > because it doesn't mix QMP history with whatever else I do on my
> > computer.
> >=20
> > Autocomplete in qmp-shell doesn't exist, as far as I know, but if
> > implemented, it could be a lot more useful than bash completion because
> > it could offer key completion based on the QMP schema.
> >=20
> > This is in fact a big part of the problem that qmp-shell really needs t=
o
> > solve before it can replace HMP: How to make writing commands at least
> > almost as simple as with HMP. If I can just press tab a few times to
> > cycle through the available options for the command, that would already
> > be a massive improvement over writing JSON manually (which you would
> > still have to do with your text-file based approach, without any
> > QMP-specific support).
>=20
> Doing all that in a python process (i.e. an actual python shell with a
> bunch of qemu commands added) seems easyish.

It does. Polishing everything for the perfect experience could be a bit
more work, but just querying the schema and providing some
autocompletion from it sounds easy enough.

> > The other part that it needs to solve is how to be available by default
> > without specifying anything on the command line. Basically, if I press
> > Ctrl-Alt-2, I want to get to a monitor shell. If that shell is
> > implemented internally or by an external Python process, I don't mind.
>=20
> That is a harder part. (I rarely use Ctrl-Alt-2 actually; I mostly
> use HMP on stdin).

I don't think it would be that hard, actually.

If you have a -qmp-shell option that takes a chardev and defaults to vc,
you've solved the part with both stdio and Ctrl-Alt-2. Now all you need
to do is launch the Python child process, pass it a pair of pipes for
communication and forward everything between the pipes and the chardev.

(That's the theory anyway.)

Kevin



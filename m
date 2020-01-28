Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B44C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 10:30:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023CE24693
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 10:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LObAPnrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023CE24693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwO8D-0005GC-4Z
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 05:30:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iwO7O-0004fH-SS
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:29:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iwO7M-0005at-DF
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:29:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26789
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iwO7M-0005Ys-2f
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580207350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0WRlafOtzdRzq1cH1YL0Bv+Tv10kY0hQOUvw3qrR160=;
 b=LObAPnrQUj0q22Y/E+E26vnBK991TEAcDv52hz9S3iNqRpg+UBLPcdphHPPaXPZ4iqoFFr
 DMDzTi+y+PS8ys4rNE4Kx2fozyOKxEtWGvQpeZ4Lc0w4ytq8QhdkGwjJNiv3ZHL+VrmfH2
 Xix+sg7YKuVQm4y1whvW95NfWcgOGkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-uKwCSp2oPIqyseZvkmTkzw-1; Tue, 28 Jan 2020 05:29:08 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6D7118C35A0;
 Tue, 28 Jan 2020 10:29:06 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-106.ams2.redhat.com [10.36.117.106])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6205A60BE0;
 Tue, 28 Jan 2020 10:28:56 +0000 (UTC)
Date: Tue, 28 Jan 2020 11:28:55 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200128102855.GA6431@linux.fritz.box>
References: <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <871rrp474i.fsf@dusky.pond.sub.org>
 <20200124102743.GB824327@redhat.com>
 <20200124143841.GG4732@dhcp-200-226.str.redhat.com>
 <87sgk3x2im.fsf@dusky.pond.sub.org>
 <20200127115606.GA5669@linux.fritz.box>
 <1c65b678-7bb4-a4cc-5fa6-03d6d27cf381@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1c65b678-7bb4-a4cc-5fa6-03d6d27cf381@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: uKwCSp2oPIqyseZvkmTkzw-1
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 27.01.2020 um 21:11 hat John Snow geschrieben:
> On 1/27/20 6:56 AM, Kevin Wolf wrote:
> > Am 25.01.2020 um 11:18 hat Markus Armbruster geschrieben:
> >> Kevin Wolf <kwolf@redhat.com> writes:
> >>> basically just a pretty-printed version of it with the consequence th=
at
> >>> it needs to be stored in an external file and there is no reasonable =
way
> >>> to keep it in my shell history.
> >>
> >> There is a reasonable way to keep it in my file system, though.  I fin=
d
> >> that decidedly superior.
> >=20
> > That depends a lot on your use case.
> >=20
> > If you have a long-lived production VM that you always run with the sam=
e
> > configuration, then yes, having a config file for it in the file system
> > is what you probably want. Currently, for this case, people directly
> > using QEMU tend to write a script that contains the command line. I
> > think I do have such scripts somewhere, but their number is very small.
> >=20
> > My common case is short-lived VMs with configurations that change very
> > often between QEMU invocations. Here the command line is decidedly
> > superior.
> >=20
> > Requiring me to create a file in the file system each time and to
> > remember deleting it after I'm done feels about as convenient as a *nix
> > shell that doesn't accept parameters for commands on the command line,
> > but instead requires you to write a one-off script first and then run
> > that.
> >=20
> > Kevin
> >=20
>=20
> > ./qemu-core <<EOF
> {
>     "machine": "Q35",
>     "memory": "2GiB",
>     "accel": "kvm"
> }
> EOF

I'm not sure why everybody is trying to come up with crude workarounds
when all I said is that keeping things in a file is not always
"decidedly superior".

Of course, I would have points to make about that workaround (like that
I often want to use stdin for an interactive monitor, or that I don't
see how this is superior to --machine Q35 --memory 2GiB --accel kvm),
but that's all beside the point.

> No file required, cooperates with readline, avoids crunchy,
> hard-to-maintain CLI syntax. Directly and easily translatable to a
> stored-file configuration. All configuration and documentation is
> centralized via QAPI.
>=20
> A little worse to type manually, yes. Maybe not bad /enough/ for me to
> want to rescue the CLI which prevents full QAPI-fication and a working
> configuration file.
>=20
> Arguably, a well documented configuration schema will be much easier to
> browse, discover, and use than a labyrinthine CLI with many stub
> definitions whose options are not exposed in the documentation.
>=20
> (The argument here is: It's a little harder and a little longer to type,
> but the benefits from the schema organization may improve productivity
> of using QEMU directly instead of harming it.)

I think this is a false dichotomy.

You can have everything defined by the schema and properly documented
and still have a non-JSON command line. Translating the QAPI schema to
a command line option is a solved problem, this is exactly how
-blockdev works.

The unsolved part is how to compatibly convert the existing options. If
you're willing to sacrifice compatibility, great. Then we can just
define stuff in the QAPI schema and still keep a command line syntax
that is usable for humans. The code for mapping a QAPI type to the
argument of an option is basically already there.

The only question is "is compatibility important"? If the answer is no,
then we'll be there in no time.

Kevin



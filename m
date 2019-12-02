Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD04C432C3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 20:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 245392071E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 20:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+L5EVq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245392071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibsfE-0001ss-1t
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 15:51:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1ibse7-0000hu-9s
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:50:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1ibse4-0000zf-Eq
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:50:15 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50900
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ibse4-0000wx-9D
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:50:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575319810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8TeX0Z5aUgA1I+bsdE7QnCaU3O19MJYx4eBf1qVcjTQ=;
 b=i+L5EVq5zN8L5cafe0wXnOViHjUO1LlsphY+R1WLieM1mS29Z9gek6/XTX0k5si+lzif7S
 EI9cjJVj7oRfqMdzPRhY2gIsdQiFezwWwYS8zrzPuok0Ueb1ooiv6/kLxyXCos3ir7AuKE
 yI194kXrZaUFt/pelMgWgVg9QGvL+gE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-MlQflNJCMguCQ8O3-8-_Jg-1; Mon, 02 Dec 2019 15:50:05 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E04E486A067;
 Mon,  2 Dec 2019 20:50:01 +0000 (UTC)
Received: from localhost (ovpn-116-90.gru2.redhat.com [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F5E65D6AE;
 Mon,  2 Dec 2019 20:50:00 +0000 (UTC)
Date: Mon, 2 Dec 2019 17:49:58 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [PATCH 2/5] mips: malta: Renovate coding style
Message-ID: <20191202204958.GP14595@habkost.net>
References: <1574687098-26689-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1574687098-26689-3-git-send-email-Filip.Bozuta@rt-rk.com>
 <CAL1e-=jeECJRjOR+Mo79D5VA8q0gSZsf__MOtRhiU0fgDF1DRA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jeECJRjOR+Mo79D5VA8q0gSZsf__MOtRhiU0fgDF1DRA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: MlQflNJCMguCQ8O3-8-_Jg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "pburton@wavecomp.com" <pburton@wavecomp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Filip Bozuta <Filip.Bozuta@rt-rk.com>,
 "hpoussin@reactos.org" <hpoussin@reactos.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>,
 Cleber Rosa <crosa@redhat.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Dec 01, 2019 at 12:46:12AM +0100, Aleksandar Markovic wrote:
> On Monday, November 25, 2019, Filip Bozuta <Filip.Bozuta@rt-rk.com> wrote=
:
>=20
> > The script checkpatch.pl located in scripts folder was
> > used to detect all errors and warrnings in files:
> >     hw/mips/mips_malta.c
> >     hw/mips/gt64xxx_pci.c
> >     tests/acceptance/linux_ssh_mips_malta.py
> >
> > All these mips malta machine files were edited and
> > all the errors and warrings generated by the checkpatch.pl
> > script were corrected and then the script was
> > ran again to make sure there are no more errors and warnings.
> >
> > Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
> > ---
> >  hw/mips/mips_malta.c                     | 139
> > ++++++++++++++++---------------
> >  tests/acceptance/linux_ssh_mips_malta.py |   6 +-
> >  2 files changed, 75 insertions(+), 70 deletions(-)
> >
> >
> Very good cleanup!
>=20
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> I think this snippet is good, but I am just in case cc-ing Cleber and
> Eduardo to check if it is in accordance with any applicable guidelines of
> our test framework:

Thanks for CCing us.

>=20
>=20
> > diff --git a/tests/acceptance/linux_ssh_mips_malta.py
> > b/tests/acceptance/linux_ssh_mips_malta.py
> > index fc13f9e..44e1118 100644
> > --- a/tests/acceptance/linux_ssh_mips_malta.py
> > +++ b/tests/acceptance/linux_ssh_mips_malta.py
> > @@ -99,10 +99,12 @@ class LinuxSSH(Test):
> >      def ssh_command(self, command, is_root=3DTrue):
> >          self.ssh_logger.info(command)
> >          result =3D self.ssh_session.cmd(command)
> > -        stdout_lines =3D [line.rstrip() for line in
> > result.stdout_text.splitlines()]
> > +        stdout_lines =3D [line.rstrip() for line
> > +        in result.stdout_text.splitlines()]
> >          for line in stdout_lines:
> >              self.ssh_logger.info(line)
> > -        stderr_lines =3D [line.rstrip() for line in
> > result.stderr_text.splitlines()]
> > +        stderr_lines =3D [line.rstrip() for line
> > +        in result.stderr_text.splitlines()]

If you really want to split those lines, please indent them
properly.  e.g.:

        stdout_lines =3D [line.rstrip() for line
                        in result.stdout_text.splitlines()]

See PEP 8 [1] for additional examples.

Personally, I would just keep the existing
linux_ssh_mips_malta.py code as is.  I don't think splitting
those lines improves readability.

[1] https://www.python.org/dev/peps/pep-0008/#indentation

--=20
Eduardo



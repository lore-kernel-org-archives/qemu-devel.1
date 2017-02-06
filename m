Received: from eggs.gnu.org ([2001:4830:134:3::10]:56812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cagf0-0007Ep-W5
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cagex-0000n0-96
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:36:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cagex-0000mm-46
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:36:35 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5037D7E9EF
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 10:36:35 +0000 (UTC)
Date: Mon, 6 Feb 2017 10:36:30 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170206103630.GF3029@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170204143245.15974-1-famz@redhat.com> <87inop8tse.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87inop8tse.fsf@frigg.lan>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Makefile: Make "install" depend on
 "trace-events-all"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com

On Sun, Feb 05, 2017 at 12:39:45AM +0200, Llu=C3=ADs Vilanova wrote:
> Fam Zheng writes:
>=20
> > We install this file to data dir but since 0ab8ed18 it's no longer
> > required by any objects during "make". List it explicitly as a depend=
ed
> > target of install and fix the broken "make install" command.
>=20
> I'm probably wrong, but I remember someone worked on making traces
> self-descriptive, so that simpletrace would no longer need access to th=
e
> generated trace-events-all file.
>=20
> If the file is really never used, then all stray rules to generate it s=
hould be
> removed, as well as its installation.

It is used at runtime when analysing a simpletrace file. While it would
be nice if they were self-descriptive, that isn't the case today, so we
must install this file.

Regards,
Daniel
--=20
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange=
/ :|
|: http://libvirt.org              -o-             http://virt-manager.or=
g :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr=
/ :|

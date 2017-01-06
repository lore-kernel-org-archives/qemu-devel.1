Received: from eggs.gnu.org ([2001:4830:134:3::10]:38955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPY9o-0006tJ-8O
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:18:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPY9k-0000ks-6d
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:18:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPY9k-0000km-0T
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:18:20 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 027868124B
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 17:18:19 +0000 (UTC)
Date: Fri, 6 Jan 2017 17:18:13 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170106171813.GV31112@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-41-berrange@redhat.com>
	<87r34g2k03.fsf@ac.upc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r34g2k03.fsf@ac.upc.edu>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 40/47] trace: switch target/s390x/
 directory to modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Jan 06, 2017 at 06:09:16PM +0100, Llu=C3=ADs Vilanova wrote:
> Daniel P Berrange writes:
>=20
> > Switch files in the target/s390x/ directory to include the
> > target/s390x/trace.h file instead of the global trace.h
> > file.
>=20
> > The make rules for gen-features.{h,c} need to be moved
> > out into the top level Makefile.objs, otherwise make
> > complains about the rules being defined multiple times
> > due to target/s390x/Makefile.objs being included
> > multiple times when expanding different subdir object
> > lists.
>=20
> If the problem is re-definition, you can instead add a guard around the=
 rules in
> target/s390x/Makefile.objs. This avoids defining the rules multiple tim=
es but
> still keeps the target-specific rules in the target-specific makefile.

What kind of guard to you mean ? What's happening is that the top
level Makefile.target is including target/s390x/Makefile.objs
multiple times to expand multiple vars. I don't see a way to
distinguish which include we're being called from.

Regards,
Daniel
--=20
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange=
/ :|
|: http://libvirt.org              -o-             http://virt-manager.or=
g :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr=
/ :|

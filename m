Received: from eggs.gnu.org ([2001:4830:134:3::10]:40714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dKg90-0004rZ-PZ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 03:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dKg8x-0006ee-K8
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 03:21:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dKg8x-0006eP-Eh
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 03:21:39 -0400
Date: Tue, 13 Jun 2017 15:21:31 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170613072131.GC6083@lemon.lan>
References: <149704225756.3762.13513524448853635568@84b42461e25a>
	<1497336167.2975.17.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1497336167.2975.17.camel@oracle.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] Unit test+fix for problem with QEMU
 handling of multiple bind()s to the same port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Knut Omang <knut.omang@oracle.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com

On Tue, 06/13 08:42, Knut Omang wrote:
> > =A0 GTESTER tests/test-qht-par
> > ** Failed to assign a port to thread 0 (errno =3D 111)
> > **
> > ERROR:/tmp/qemu-test/src/tests/test-listen.c:103:listen_compete_nthr:=
 assertion failed:
> > (strstr(thr[i].errstr, "Failed to listen on socket") !=3D NULL)
> > GTester: last random seed: R02S7bbaabe0e7d7cadb4b06bd43593754ef
> > ** Failed to assign a port to thread 0 (errno =3D 111)
> > **
> > ERROR:/tmp/qemu-test/src/tests/test-listen.c:103:listen_compete_nthr:=
 assertion failed:
> > (strstr(thr[i].errstr, "Failed to listen on socket") !=3D NULL)
> > GTester: last random seed: R02S3ef87a7625dc47c6cabe0aeaf2636fd2
> > make: *** [check-tests/test-listen] Error 1
> > make: *** Waiting for unfinished jobs....
>=20
> This is a bit odd - an environment issue/limitation with the docker ima=
ge?
> (I do create a lot of threads and parallel calls here to provoke the or=
iginal error..)
>=20
> According to my man pages neither of the system calls involved ( bind()=
, listen(),
> getaddrinfo() or socket() ) may return ECONNREFUSED (=3D 111)  ?
>=20
> I'll fix v2 to get some more details from the test here..
>=20
> > Broken pipe
> > GTester: last random seed: R02Sb1267c89d00d2ed82064ff85f35be761
> > Could not access KVM kernel module: No such file or directory
> > failed to initialize KVM: No such file or directory
> > Back to tcg accelerator.
>=20
> I gather this is just a consequence of the failing test, or another env=
ironment issue?

Please ignore the KVM warnings, it's not available in the docker env and
triggers on all patches for now.

Fam

Received: from eggs.gnu.org ([2001:4830:134:3::10]:53829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fDWOV-0006MZ-Ic
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fDWOR-0002al-KH
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:36:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44650 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fDWOR-0002a3-FT
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:36:35 -0400
Date: Tue, 1 May 2018 15:36:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180501143632.GE32129@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20171106153342.24147-1-berrange@redhat.com>
	<20171106153342.24147-3-berrange@redhat.com>
	<1525183235.2540.664.camel@oracle.com>
	<20180501140744.GD32129@redhat.com>
	<1525184461.2540.675.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1525184461.2540.675.camel@oracle.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v1 2/2] tests: Add test-listen - a stress
 test for QEMU socket listen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Knut Omang <knut.omang@oracle.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Tue, May 01, 2018 at 04:21:01PM +0200, Knut Omang wrote:
> On Tue, 2018-05-01 at 15:07 +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, May 01, 2018 at 04:00:35PM +0200, Knut Omang wrote:
> > > Hi Peter,
> > >=20
> > > Seems this test was lost along the way?
> > >=20
> > > I thought it got merged with Daniel's fix to the potential leak=20
> > > that the test exposed in your build, but it seems not?
> >=20
> > I've never been able to get this test, nor another one of my own
> > to succesfully pass automated testing in all the various test
> > envs Peter and our many CI systems use.
>=20
> Ok, that explains it - no big deal from my side, I just thought=20
> it was "value lost" against future errors.
>=20
> Would it make sense to let the test check for environment and just=20
> really run in cases where it reliably passes?

That's why I've actually been trying to do - I hacked some checks into th=
e
start of the test suite that were supposed to detect if it can run
reliably but it still got failures. Because of the large number of
socketss it opens it was hitting FD resource limits at times IIRC

FWIW, I still have the patch on my local queue and hope one day I'll have
an insight to fix it enough to merge...

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

Received: from eggs.gnu.org ([2001:4830:134:3::10]:49440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1fDW9Z-0003qT-EX
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1fDW9W-00025n-5w
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:21:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1fDW9V-00024K-Sw
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:21:10 -0400
Message-ID: <1525184461.2540.675.camel@oracle.com>
From: Knut Omang <knut.omang@oracle.com>
Date: Tue, 01 May 2018 16:21:01 +0200
In-Reply-To: <20180501140744.GD32129@redhat.com>
References: <20171106153342.24147-1-berrange@redhat.com>
	<20171106153342.24147-3-berrange@redhat.com>
	<1525183235.2540.664.camel@oracle.com>
	<20180501140744.GD32129@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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
To: "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Tue, 2018-05-01 at 15:07 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Tue, May 01, 2018 at 04:00:35PM +0200, Knut Omang wrote:
> > Hi Peter,
> >=20
> > Seems this test was lost along the way?
> >=20
> > I thought it got merged with Daniel's fix to the potential leak=20
> > that the test exposed in your build, but it seems not?
>=20
> I've never been able to get this test, nor another one of my own
> to succesfully pass automated testing in all the various test
> envs Peter and our many CI systems use.

Ok, that explains it - no big deal from my side, I just thought=20
it was "value lost" against future errors.

Would it make sense to let the test check for environment and just=20
really run in cases where it reliably passes?=20

That will also serve as documentation as to where there might be=20
additional issues hidden?

Knut=20

Received: from eggs.gnu.org ([2001:4830:134:3::10]:56343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dng2P-0003M6-Cj
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 03:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dng2M-0008TY-8U
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 03:06:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dng2M-0008RW-28
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 03:06:42 -0400
Date: Fri, 1 Sep 2017 15:06:38 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170901070638.GB4330@lemon.lan>
References: <20170831112210.19921-1-famz@redhat.com>
	<20170831112210.19921-4-famz@redhat.com>
	<20170831161835.GQ17315@redhat.com>
	<5f9a3540-2c90-5ded-9581-d1098070f40e@redhat.com>
	<1f59ff98-f5cb-b185-bca1-657ed6e2f807@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1f59ff98-f5cb-b185-bca1-657ed6e2f807@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On Thu, 08/31 13:36, Philippe Mathieu-Daud=E9 wrote:
> On 08/31/2017 01:21 PM, Eric Blake wrote:
> > On 08/31/2017 11:18 AM, Daniel P. Berrange wrote:
> > >=20
> > > 'qcow' (v1) was also passing last time I checked, though it is
> > > waaaaaay slow to run compared to qcow2, so I'd understand if you
> > > were reluctant to turn that on due to speed
> >=20
> > Even './check -qcow -g quick' might be nicer than nothing, but that i=
s
> > also slooooooow
>=20
> What about having a daily job running it on /master? Better than runnin=
g it
> once before each release :)
>=20

Can Shippable or Travis cover that?

Fam

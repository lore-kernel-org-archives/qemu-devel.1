Received: from eggs.gnu.org ([2001:4830:134:3::10]:43348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ctblJ-0000xR-W0
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ctblF-00052T-1R
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:13:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ctblE-00051a-Rf
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:13:16 -0400
Date: Thu, 30 Mar 2017 18:13:13 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170330181243-mutt-send-email-mst@kernel.org>
References: <1490694017-7532-1-git-send-email-peter.maydell@linaro.org>
	<a08258bf-9da9-7d90-bcfd-5e4156805557@amsat.org>
	<CAFEAcA_VSavXRVr=z1kDuxUu6Jy3OG6DKQJ_xrify_OMT7TeEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA_VSavXRVr=z1kDuxUu6Jy3OG6DKQJ_xrify_OMT7TeEA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] tests/bios-tables-test: Don't
 pass addresses of packed struct fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On Thu, Mar 30, 2017 at 04:08:59PM +0100, Peter Maydell wrote:
> On 28 March 2017 at 14:30, Philippe Mathieu-Daud=E9 <f4bug@amsat.org> w=
rote:
> > should we add some comment like /* local variable used to avoid align=
ment
> > issues */ in case later one find it clever to save few bytes on stack
> > without reading git history?
>=20
> Hmm. There's no obvious single place where that could be put,
> and I tend to think that if you're going to use packed structures
> then "caution needed" is implicit. When we have these bug fixes
> in then the plan is to add sparc to the set of standard merge
> build tests, which will catch accidental reversions of this
> fix (and eventually clang 4 will be more widespread which will
> warn about this.)
>=20
> thanks
> -- PMM

Let's apply this for now but I really don't remember why did we
make it packed in the 1st place.

--=20
MST

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXMlY-0005wZ-1A
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXMlT-00054r-SG
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:17:55 -0400
Date: Tue, 18 Jul 2017 09:14:52 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170718071452.4hlhpelfposv6eye@aurel32.net>
References: <20170718045540.16322-1-f4bug@amsat.org>
	<20170718045540.16322-4-f4bug@amsat.org>
	<628617ba-12f6-97ad-6818-1d7d0c63f558@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <628617ba-12f6-97ad-6818-1d7d0c63f558@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v5 03/10] target/arm: optimize aarch64
 rev16() using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On 2017-07-17 20:25, Richard Henderson wrote:
> On 07/17/2017 06:55 PM, Philippe Mathieu-Daud=E9 wrote:
> > Aurelien Jarno denoted this function could be implemented more effectiv=
ely using
> > the aarch32 rev16() pattern.
> >    [http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg03180.ht=
ml]
> >=20
> > Done with the Coccinelle semantic patch from commit 58daf05d07dd
> >      (see scripts/coccinelle/tcg_gen_extract.cocci)
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> I'm dropping this patch and replacing it with the much smaller code
> mentioned in the message quoted above.

In that case, could you also get the corresponding aarch32 patch:
http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg03887.html

It has already been reviewed.

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net

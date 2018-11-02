Received: from eggs.gnu.org ([2001:4830:134:3::10]:59244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gIazF-0000jv-HG
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gIazB-00075A-Gk
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:03:49 -0400
Received: from mail-co1nam04on0725.outbound.protection.outlook.com
	([2a01:111:f400:fe4d::725]:19166
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gIaz1-00070d-9Y
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:03:38 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 2 Nov 2018 15:03:23 +0000
Message-ID: <BN6PR2201MB12515D71ED36B637045DA6D2C6CF0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <BN6PR2201MB125116B5479010DB326DCCFCC6CE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<51a26700-5da5-0a15-0e0e-6405ce5e65d4@redhat.com>
	<20181101172353.GA2316@sx9>
	<BN6PR2201MB12512B92322BFB8965848215C6CF0@BN6PR2201MB1251.namprd22.prod.outlook.com>,
	<20181102143119.GA2274@sx9>
In-Reply-To: <20181102143119.GA2274@sx9>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Correction needed for R5900 instruction decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>
Cc: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, "Emilio G.
	Cota" <cota@braap.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi, Fredrik.

> From: Fredrik Noring <noring@nocrew.org>
> Subject: Re: [Qemu-devel] Correction needed for R5900 instruction decodin=
g
>=20
> Hi Aleksandar,
>=20
> > It is now code freeze before 3.1, the code base is being stabilized, an=
d
> > only important fixes are allowed to be integrated - so, in that light, =
a
> > separate patch, or a small series, that addresses only concerns from th=
e
> > original mail of this thread is needed. Such series should not contain =
any
> > additional features (like your v2 of the series "Amend..." does), and i=
ts
> > patch titles should look like "Fix decoding mechanism of ..." or such.
> >
> > Could you please provide those appropriate changes in that format?
>=20
> I certainly could, but why not simply apply patch 1 and 2 in the posted
> v2 series and leave the rest for later?

How do you know patches 1 and 2 will and should be applied? You jump to con=
clusions. Also, a basic rule while analyzing problems and their solutions i=
s to avoid and omit irrelevant parts.

> The only difference in a repost would be the cover letter.

Not true, I asked for different titles, and I may ask for something else - =
a lot of things can change. For example, I think a separate decode_opc_spec=
ial_legacy() for R5900 is needed, I don't see that in your series.

Thanks,
Aleksandar

> The two patches would be identical reposts that apply since yesterday.
>=20
> The patch series is ordered with "crucial patches as the first ones",
> as you wanted it according to:
>=20
> http://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg04946.html
>=20
> Fredrik

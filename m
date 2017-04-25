Received: from eggs.gnu.org ([2001:4830:134:3::10]:52525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1d316y-0006GK-WB
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1d316u-0002kZ-0k
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:06:36 -0400
Received: from 2.mo6.mail-out.ovh.net ([46.105.76.65]:53764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1d316t-0002jS-QD
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:06:31 -0400
Received: from player696.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 3242CCB8C7
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 16:06:29 +0200 (CEST)
References: <1493103101-25165-1-git-send-email-clg@kaod.org>
	<1493103101-25165-3-git-send-email-clg@kaod.org>
	<CAFEAcA9Y0C_byA8KsiMXdzsMDE73ZKmMcQZaMc7uwAF2bZC+hg@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d48c2177-ad8e-a820-c640-898075110ee3@kaod.org>
Date: Tue, 25 Apr 2017 16:06:17 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Y0C_byA8KsiMXdzsMDE73ZKmMcQZaMc7uwAF2bZC+hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] ipmi: don't try to open a NULL filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>

On 04/25/2017 03:31 PM, Peter Maydell wrote:
> On 25 April 2017 at 07:51, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>> Currenlty, the code relies on the fact that open() handles NULL
>> filenames but that can cause an error with new clang:
>>
>>   hw/core/loader.c:67:15: runtime error: null pointer passed as argume=
nt 1,
>>   which is declared to never be null
>=20
> This isn't "new clang", incidentally, it's just clang with the
> runtime-static-analysis enabled, which causes warnings to be
> printed at runtime for undefined behaviours. You can enable
> this by passing configure --extra-cflags=3D-fsanitize=3Dundefined .
> (I have clang 3.8.0 here.)

OK. So I have now reproduced the issue on a f24. That made be=20
realize that the IPMI tests check for the arch they are being=20
run on and that more changes are required for them to run on=20
ppc64.=20

We can drop patch 1/2. Tell me if you want a resend.

Thanks,

C. =20

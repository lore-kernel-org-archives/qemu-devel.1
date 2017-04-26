Received: from eggs.gnu.org ([2001:4830:134:3::10]:53946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1d3GeP-00010N-6Y
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 02:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1d3GeK-00009G-2z
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 02:42:09 -0400
Received: from 8.mo1.mail-out.ovh.net ([178.33.110.239]:35407)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1d3GeJ-000096-Se
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 02:42:04 -0400
Received: from player691.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 11B956E642
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 08:42:02 +0200 (CEST)
References: <1493103101-25165-1-git-send-email-clg@kaod.org>
	<1493103101-25165-3-git-send-email-clg@kaod.org>
	<CAFEAcA9Y0C_byA8KsiMXdzsMDE73ZKmMcQZaMc7uwAF2bZC+hg@mail.gmail.com>
	<d48c2177-ad8e-a820-c640-898075110ee3@kaod.org>
	<20170426024321.GL16882@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b1ab7bd4-7ec5-c94c-5050-736ad4b13c72@kaod.org>
Date: Wed, 26 Apr 2017 08:41:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170426024321.GL16882@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>

On 04/26/2017 04:43 AM, David Gibson wrote:
> On Tue, Apr 25, 2017 at 04:06:17PM +0200, C=E9dric Le Goater wrote:
>> On 04/25/2017 03:31 PM, Peter Maydell wrote:
>>> On 25 April 2017 at 07:51, C=E9dric Le Goater <clg@kaod.org> wrote:
>>>> Currenlty, the code relies on the fact that open() handles NULL
>>>> filenames but that can cause an error with new clang:
>>>>
>>>>   hw/core/loader.c:67:15: runtime error: null pointer passed as argu=
ment 1,
>>>>   which is declared to never be null
>>>
>>> This isn't "new clang", incidentally, it's just clang with the
>>> runtime-static-analysis enabled, which causes warnings to be
>>> printed at runtime for undefined behaviours. You can enable
>>> this by passing configure --extra-cflags=3D-fsanitize=3Dundefined .
>>> (I have clang 3.8.0 here.)
>>
>> OK. So I have now reproduced the issue on a f24. That made be=20
>> realize that the IPMI tests check for the arch they are being=20
>> run on and that more changes are required for them to run on=20
>> ppc64.=20
>>
>> We can drop patch 1/2. Tell me if you want a resend.
>=20
> No, that's fine.  A patch to enable the tests on ppc properly ASAP
> would be great, though.

Yes, it would. I need to understand what is behind :=20

	qtest_irq_intercept_in(...)

C.

Received: from eggs.gnu.org ([209.51.188.92]:58674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <casasfernando@outlook.com>) id 1h1nEp-0000Bm-OF
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:14:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <casasfernando@outlook.com>) id 1h1nEo-0000qH-RQ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:14:43 -0500
Received: from mail-oln040092068025.outbound.protection.outlook.com
	([40.92.68.25]:33629
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <casasfernando@outlook.com>)
	id 1h1nEn-0000pf-TX
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:14:42 -0500
From: =?iso-8859-1?Q?Fernando_Casas_Sch=F6ssow?= <casasfernando@outlook.com>
Date: Thu, 7 Mar 2019 07:14:38 +0000
Message-ID: <AM5PR0602MB3236ECE150DE9625C67547A4A44C0@AM5PR0602MB3236.eurprd06.prod.outlook.com>
References: <VI1PR0602MB32452A8FD128F63FFAC0CEADA4920@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<VI1PR0602MB324516419266A934FE7759C6A47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<VI1PR0602MB324516419266A934FE7759C6A47E0@VI1PR0602MB3245.eurprd06.prod.outlo>
	<VI1PR0602MB32454C17192EFA863E29CC49A47E0@VI1PR0602MB3245.eurprd06.prod.outlo>
	<VI1PR0602MB324547F72DA9EDEB1613C888A47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QUg=cq3tCSLidQ9BR2hxAo3K6gA6LKtpx5Rjb=_6XgJ6Q@mail.gmail.com>
	<28e6b4ed-9afd-3a79-6267-86c7385c23ce@redhat.com>
	<VI1PR0602MB324578F91F1AF9390D03022FA47F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QWouR43wVi0guTuASP9gc24_CPucbBvtfE5_htkDkmsrQ@mail.gmail.com>
	<20190223165523.1d674224@ncopa-desktop.copa.dup.pw>
	<CAFEAcA8kOEJe-Ax_SFOCa49og-N7gpO-ptsANdvXPhKthrpb8A@mail.gmail.com>
	<20190225112424.2dd535a1@ncopa-desktop.copa.dup.pw>
	<CAFEAcA-nfqk9+x1F4nUC0djYRnAgGZL4d9X6rYLBJPvuKCdjbQ@mail.gmail.com>
	<20190225132156.477faf18@ncopa-desktop.copa.dup.pw>
	<CAFEAcA_F1yxx8Z_8Pc_QOMZ3i9vJLZ8uRze1fTbGfSDs4NAhLg@mail.gmail.com>
	<CAFEAcA9g42CzcV3n-ONQ=sD5O_gPpQGACArtzg7_TJ82Oq7DzQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9g42CzcV3n-ONQ=sD5O_gPpQGACArtzg7_TJ82Oq7DzQ@mail.gmail.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] Guest unresponsive after Virtqueue
 size exceeded error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Natanael Copa <ncopa@alpinelinux.org>, Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

After two weeks of running the new QEMU package everything is fine.
Moreover I migrated the rest of the guests (both Windows and Linux) to virt=
io-scsi and no issues so far.
I will monitor for another week but this issue seems pretty much fixed!

Kudos to each and everyone of you that helped finding and solving this issu=
e.

Fer

On jue, feb 28, 2019 at 10:58 AM, Peter Maydell <peter.maydell@linaro.org> =
wrote:
On Mon, 25 Feb 2019 at 13:06, Peter Maydell <peter.maydell@linaro.org<mailt=
o:peter.maydell@linaro.org>> wrote:
On Mon, 25 Feb 2019 at 12:22, Natanael Copa <ncopa@alpinelinux.org<mailto:n=
copa@alpinelinux.org>> wrote: > > On Mon, 25 Feb 2019 10:34:23 +0000 > Pete=
r Maydell <peter.maydell@linaro.org<mailto:peter.maydell@linaro.org>> wrote=
: > > The short term fix is to fix your toolchain/compilation > > environme=
nt options so that it isn't trying to override > > the definition of memcpy=
(). > > The easiest workaround is to simply disable FORTIY_SOURCE, but that=
 > will weaken the security for all implemented string functions, strcpy, >=
 memmove etc, so I don't want to do that. > > Is it only lduw_he_p that nee=
ds to be atomic or are the other functions > in include/qemu/bswap.h using =
memcpy also required to be atomic? Hard to say, since we haven't done the "=
audit all the callers" step that Stefan mentioned. If you're going to repla=
ce memcpy with __builtin_memcpy then the safest thing is to do it for all t=
hose uses (this will also give you much better generated code for performan=
ce purposes).
I mentioned this to Richard on IRC the other day, but I think there's a goo=
d argument for making upstream QEMU use __builtin_memcpy in these helpers: =
* it makes us robust against things like this fortify library in the short =
term (until we fix QEMU to have an equivalent set of functions for doing at=
omic accesses to AddressSpaces) * in the longer term it will mean that we d=
on't end up with these functions being really badly-performing even if the =
semantics of the out-of-line memcpy() are correct thanks -- PMM

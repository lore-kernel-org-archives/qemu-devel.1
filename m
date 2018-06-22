Received: from eggs.gnu.org ([2001:4830:134:3::10]:46090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@mips.com>) id 1fWNDm-0003pm-BE
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@mips.com>) id 1fWNDj-0001z9-5M
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:39:30 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:56955)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Aleksandar.Markovic@mips.com>)
	id 1fWNDi-0001yq-VC
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:39:27 -0400
From: Aleksandar Markovic <Aleksandar.Markovic@mips.com>
Date: Fri, 22 Jun 2018 14:39:07 +0000
Message-ID: <5d9fc1151a1045eab8c6ace71b772f94@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>,
	<263756cc-6869-de24-3f9b-140d24025829@amsat.org>
In-Reply-To: <263756cc-6869-de24-3f9b-140d24025829@amsat.org>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/35] nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Yongbok Kim <Yongbok.Kim@mips.com>, James Hogan <James.Hogan@mips.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paul Burton <Paul.Burton@mips.com>, Stefan Markovic <Stefan.Markovic@mips.com>, Matthew Fortune <Matthew.Fortune@mips.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>

> From: Philippe Mathieu-Daud=E9 <philippe.mathieu.daude@gmail.com> on beha=
lf of Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Sent: Friday, June 22, 2018 6:26 AM
> To: Yongbok Kim; James Hogan
> Cc: qemu-devel@nongnu.org; Aleksandar Markovic; Paul Burton; Stefan Marko=
vic; Matthew Fortune; aurelien@aurel32.net; Paul Burton
> Subject: Re: [Qemu-devel] [PATCH 00/35] nanoMIPS
>
> Hi Yongbok,
>
> On 06/20/2018 09:05 AM, Yongbok Kim wrote:
> > This series of patches is implementing recently announced nanoMIPS on Q=
EMU.
> > nanoMIPS is a variable length ISA containing 16, 32 and 48 bit wide
> > instructions. It is designed to be portable at assembly level with othe=
r MIPS
> > and microMIPS code, but contains a number of changes which enhance code=
 density
> > and efficiency.
> [...]
>
> I noticed various patches use the imgtec.com domain.
>
> In commit 94d973bdaac Paul Burton wrote:
>
>     MIPS will soon no longer be a part of Imagination Technologies
>     & as such the @imgtec.com address will soon cease to function.
>
> Your's got updated in 0eb4e1f33a4, and James in a7a2d7d2a04.
>
> Assuming this is rebase using previous internal patches, shouldn't you
> update those addresses to your new domain? Else the checkpatch.pl script
> will continue to extract imgtec.com addresses from commits.

Thanks for spotting this, Philippe! It probably slipped through the cracks.

If nobody objects, while integrating/applying, I am going to change all ins=
tances of "@imgtec.com" to "@mips.com" for this series.

Some of the patches might have been developed while the company was part of=
 Imagination Technologies - however, I think it is reasonable to use email =
addresses at the moment of submitting changes to this list. This gets compl=
icated if, for example, a person leaves the company before his/her email ad=
dress changes, but I think, in this case, using "@mips.com" is appropriate =
for all involved persons.

Regards,

Aleksandar

>
> Regards,
>
> Phil.

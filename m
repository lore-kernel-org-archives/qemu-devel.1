Received: from eggs.gnu.org ([2001:4830:134:3::10]:51686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cQdA6-0006YU-V6
	for Qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:51:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cQdA3-0000IZ-0m
	for Qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:51:11 -0500
Received: from mail-wj0-x22e.google.com ([2a00:1450:400c:c01::22e]:33281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ilg@livius.net>) id 1cQdA2-0000Hu-QI
	for Qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:51:06 -0500
Received: by mail-wj0-x22e.google.com with SMTP id kq3so22707030wjc.0
	for <Qemu-devel@nongnu.org>; Mon, 09 Jan 2017 08:51:05 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <CAFEAcA_CDpXqAAJNdSQpk4MKOorDXqUi_AwsevrHk=pnbrS0NQ@mail.gmail.com>
Date: Mon, 9 Jan 2017 18:51:01 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <277E72EB-288A-498F-9208-99EBF09218A6@livius.net>
References: <6205DF8A-7643-432F-88FF-12B1E9DEF5D8@livius.net>
	<CAFEAcA_CDpXqAAJNdSQpk4MKOorDXqUi_AwsevrHk=pnbrS0NQ@mail.gmail.com>
Subject: Re: [Qemu-devel] CMSIS SVD based peripheral definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developer <Qemu-devel@nongnu.org>


> On 9 Jan 2017, at 18:16, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On 28 December 2016 at 18:49, Liviu Ionescu <ilg@livius.net> wrote:
>> The latest release of GNU ARM Eclipse QEMU (2.8.0-20161227) =
introduced
>> a new technology for implementing peripherals, based on standard
>> CMSIS SVD definitions
>> (http://www.keil.com/pack/doc/CMSIS/SVD/html/index.html).
>>=20
>> The SVD files are large XML files produced by the silicon vendors,
>> and generally are considered the final hardware reference for
>> the Cortex-M devices, so they are expected to provide the most
>> accurate peripheral emulation.
>=20
> This certainly seems like a good idea in principle, if there's
> enough information in the SVD files to reliably create a
> complete board model.

the general answer is that this information should be there.

in practice, it mostly is. however, the SVD specs are quite lax and each =
vendor understands them slightly differently.

to compensate for these differences, my workflow added an extra step of =
patching the original content. the patch files are minimal compared to =
the original files, and the effort to create them is perfectly =
acceptable.

> The obvious issue that comes to mind
> is licensing, though -- what licenses are the SVD files under,
> and would those be compatible with QEMU's GPLv2 ?

that's a common question with cmsis files. I could not find any specific =
license applying to svd files, so, since these files are provided as =
part of the arm cmsis packs, I would consider the generic license, =
which, starting with the latest cmsis release, was changed to Apache.

anyway, in my opinion, after experimenting both with classical (switch =
based) implementations and table based (peripheral/register/bitfield) =
implementations, if I would have to deal with a device which does not =
have the vendor SVD files, I would probably prefer to write the JSON =
file by hand and allow the automated tools to handle the rest.

actually I'll have to do this when I'll rewrite the Cortex-M system =
peripherals, not included in the vendor provided SVDs.


regards,

Liviu

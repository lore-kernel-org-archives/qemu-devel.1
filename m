Received: from eggs.gnu.org ([2001:4830:134:3::10]:40791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccF8s-0002jt-UB
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 12:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccF8s-0004Ml-1f
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 12:37:54 -0500
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:33868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ccF8r-0004MJ-Ft
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 12:37:53 -0500
Received: by mail-wr0-x236.google.com with SMTP id o16so113309452wra.1
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 09:37:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_G8ns3orbxcPpXGaHvk7z-W7DYfshugYTgsiYiOv98Vg@mail.gmail.com>
References: <20170207183356.17840-1-laurent@vivier.eu>
	<CAFEAcA_XuEA01Cnsdd7Wq-ueH0zqjcinNasW-wkJ-Us3M_MkRg@mail.gmail.com>
	<5d8f2613-4f41-0780-059a-3f5cb4bef83c@vivier.eu>
	<CAFEAcA_G8ns3orbxcPpXGaHvk7z-W7DYfshugYTgsiYiOv98Vg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 17:37:31 +0000
Message-ID: <CAFEAcA839SUFaNpF10FhXDXNZC9c5d-UO7JmPFuk31BBd3NRuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] risu: add m68k target support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

On 10 February 2017 at 17:32, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
> On 10 February 2017 at 15:33, Laurent Vivier <laurent@vivier.eu> wrote:
>> Le 10/02/2017 =C3=A0 16:25, Peter Maydell a =C3=A9crit :
>>> Thanks for this; I think patches 1-3 are good, and have
>>> applied them to risu master. For 4 I wonder if we can
>>> find a better way of handling variable-length instruction
>>> sets than !post, and I haven't yet looked at 5.
>>
>> I think it should be possible but I don't know perl well enough to
>> propose a better solution.
>
> Yeah; I'll have a think about it.
>
> I got bored with the repetition between all the CPU backends,
> by the way, so I've created a risugen_common.pm and moved
> a bunch of the identical utility functions too it. (We can
> probably share more, but this seemed like a good start.)

PS: I've been just writing and pushing code because this is
just a test program and it doesn't seem like it merits the
overhead of getting my own patches codereviewed here; but
if people would prefer to see the changes I make here first
let me know.

thanks
-- PMM

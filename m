Received: from eggs.gnu.org ([2001:4830:134:3::10]:38957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccF4K-0006tS-2q
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 12:33:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccF4I-0002hY-Vi
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 12:33:12 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ccF4I-0002hN-PN
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 12:33:10 -0500
Received: by mail-wm0-x231.google.com with SMTP id r141so54599098wmg.1
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 09:33:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5d8f2613-4f41-0780-059a-3f5cb4bef83c@vivier.eu>
References: <20170207183356.17840-1-laurent@vivier.eu>
	<CAFEAcA_XuEA01Cnsdd7Wq-ueH0zqjcinNasW-wkJ-Us3M_MkRg@mail.gmail.com>
	<5d8f2613-4f41-0780-059a-3f5cb4bef83c@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 17:32:49 +0000
Message-ID: <CAFEAcA_G8ns3orbxcPpXGaHvk7z-W7DYfshugYTgsiYiOv98Vg@mail.gmail.com>
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

On 10 February 2017 at 15:33, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 10/02/2017 =C3=A0 16:25, Peter Maydell a =C3=A9crit :
>> Thanks for this; I think patches 1-3 are good, and have
>> applied them to risu master. For 4 I wonder if we can
>> find a better way of handling variable-length instruction
>> sets than !post, and I haven't yet looked at 5.
>
> I think it should be possible but I don't know perl well enough to
> propose a better solution.

Yeah; I'll have a think about it.

I got bored with the repetition between all the CPU backends,
by the way, so I've created a risugen_common.pm and moved
a bunch of the identical utility functions too it. (We can
probably share more, but this seemed like a good start.)

thanks
-- PMM

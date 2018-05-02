Received: from eggs.gnu.org ([2001:4830:134:3::10]:33224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fDpCY-0003gA-SK
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fDpCV-0008U2-P8
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:41:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42038 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fDpCV-0008TU-LG
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:41:31 -0400
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<d50e3a40-d7f3-4c9b-e930-4c2f4d6c8a53@redhat.com>
	<CAFEAcA8wJuJ9464LadgjJOo-7ttdGYcfDQWALbkxBRJCr_knkg@mail.gmail.com>
	<20180427210120.03d037b0@naga.suse.cz>
	<70cb944b-269c-2969-4727-b889298ece30@linaro.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <987b683f-e05e-780a-40cf-68b6b8d0641f@redhat.com>
Date: Wed, 2 May 2018 12:41:21 +0200
MIME-Version: 1.0
In-Reply-To: <70cb944b-269c-2969-4727-b889298ece30@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>, Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 04/29/18 16:56, Richard Henderson wrote:
> On 04/27/2018 02:01 PM, Michal Such=C3=A1nek wrote:
>> Is there any reason why the 64bit emulator would not run on 32bit
>> system? The emulated 64bit system is .. emulated after all.
>=20
> It does run, but it requires that the 32-bit host perform double-word
> arithmetic to emulate the 64-bit guest.  When the 64-bit guest is reall=
y a
> 32-bit guest in disguise, this carries a performance penalty.
>=20
> If we ever stop caring about 32-bit hosts, the question becomes moot.

What about guest RAM size (more precisely, guest-phys address space)?

The x86_64 target might want to use tens of GBs of guest-phys address
space, e.g. for cold-plugged RAM, for DIMM hotplug, for 64-bit PCI MMIO
aperture. To my understanding, all of those have to be expressed with
host virtual addresses in the QEMU process (regardless of TCG vs. KVM).
But on a 32-bit host, the QEMU process only has 4GB HVA space.

Thanks
Laszlo

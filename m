Received: from eggs.gnu.org ([209.51.188.92]:52686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.weil@weilnetz.de>) id 1gpCNB-0005wx-Ou
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:27:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.weil@weilnetz.de>) id 1gpCN9-0000Za-DN
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:27:17 -0500
Received: from mail.weilnetz.de ([37.120.169.71]:55874
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.weil@weilnetz.de>)
	id 1gpCN9-0000Y5-6s
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:27:15 -0500
References: <CAChFQ9RNaHyROB47QeLwc6cLCCnFx4SmXKV7rbs1MYjk7S0sbw@mail.gmail.com>
	<20190131104911.GF19982@redhat.com>
	<CAFEAcA_TYKmG+gfm1gUw-xjM3VFXUebCD22rGSPyBuZ9ugWVPQ@mail.gmail.com>
	<20190131112853.GG19982@redhat.com>
From: Stefan Weil <stefan.weil@weilnetz.de>
Message-ID: <c3cbd206-62f9-9e40-142e-d9fec01b82ba@weilnetz.de>
Date: Thu, 31 Jan 2019 14:27:11 +0100
MIME-Version: 1.0
In-Reply-To: <20190131112853.GG19982@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] NSIS - including DLL dependencies for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Adam Baxter <voltagex@voltagex.org>, QEMU Developers <qemu-devel@nongnu.org>

On 31.01.19 12:28, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Jan 31, 2019 at 11:19:04AM +0000, Peter Maydell wrote:
>> On Thu, 31 Jan 2019 at 10:50, Daniel P. Berrang=C3=A9 <berrange@redhat=
.com> wrote:
>>>
>>> On Thu, Jan 31, 2019 at 02:45:13PM +1100, Adam Baxter wrote:
>>>> Hi,
>>>> How do I gather and include the required DLLs (SDL, zlib etc) in the=
 NSIS
>>>> installer? (and also in a standalone build to be zipped up, but that=
's less
>>>> important)
>>>>
>>>> I noticed the wiki doesn't really mention bundling dependencies anyw=
here.
>>>>
>>>> The official unofficial windows builds are documented at
>>>> https://qemu.weilnetz.de/FAQ but this doesn't cover building the act=
ual
>>>> installer.
>>>
>>> Yeah, this is a pretty major ommision in QEMU's build rules for the N=
SIS
>>> installer making it pretty much useless as is. We really need to expa=
nd
>>> it so that it can resolve the dlls that qemu .exe's need, locate them
>>> on the host and bundle them into the installer automatically.


The current code already automatically includes all DLL files found in
dll/w32 or dll/w64 in the root source directory.

I had chosen that very simple solution because I am afraid that a
general rule to find the right DLL files for Windows native and cross
builds with all kinds of cross build hosts (Debian, Fedora, ...) is
impossible to maintain.

So currently every developer has to select and provide the DLL files
needed. That's how I=E2=80=8C do it for my installers, too. Each time whe=
n I
update Debian or the Cygwin packages which I use for the cross build, I
also have to update the DLL set.

Regards,
Stefan Weil

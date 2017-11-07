Received: from eggs.gnu.org ([2001:4830:134:3::10]:40515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asierra@xes-inc.com>) id 1eC5kk-0001SY-Ff
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:25:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asierra@xes-inc.com>) id 1eC5ka-0001w9-V2
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:25:26 -0500
Received: from xes-mad.com ([216.165.139.220]:51198 helo=mail.xes-mad.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asierra@xes-inc.com>) id 1eC5ka-0001uu-Iz
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:25:16 -0500
Date: Tue, 7 Nov 2017 09:25:16 -0600 (CST)
From: Aaron Sierra <asierra@xes-inc.com>
Message-ID: <1590616620.194475.1510068316265.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <CAFEAcA8kXjH5dSM6KCGX5gfgJWJMAymz=D3BTMxjLwZQ7_s5hg@mail.gmail.com>
References: <492245211.936616.1510023015797.JavaMail.zimbra@xes-inc.com>
	<03986f7a-f1f8-751a-4967-ab7d1a5093fd@vivier.eu>
	<CAFEAcA8kXjH5dSM6KCGX5gfgJWJMAymz=D3BTMxjLwZQ7_s5hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user: Support explicit targets for
 PowerPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, qemu-devel <qemu-devel@nongnu.org>

----- Original Message -----
> From: "Peter Maydell" <peter.maydell@linaro.org>
> Sent: Tuesday, November 7, 2017 3:29:21 AM

> On 7 November 2017 at 06:57, Laurent Vivier <laurent@vivier.eu> wrote:
>> Le 07/11/2017 =E0 03:50, Aaron Sierra a =E9crit :
>>> Enable building PowerPC targets supporting a specific CPU, without
>>> having to set QEMU_CPU via the environment. For example these build
>>> targets (and many more) become available:
>>>
>>>     qemu-ppc.e500mc
>>>     qemu-ppc.e500v2
>>>     qemu-ppc.e5500
>>>     qemu-ppc.e600
>>>     qemu-ppc.e6500
>>>
>>> These (statically compiled) binaries have proven useful for emulating
>>> PowerPC CPUs within Docker containers, where it's hard to reliably
>>> define environment variables that are available for every process.
>>
>> I agree with you.
>>
>> I have patches to do that for years, perhaps we can merge our both
>> solutions to have something working:
>>
>> linux-user: define default cpu model in configure instead of
>> linux-user/main.c
>> https://github.com/vivier/qemu-m68k/commit/1488df8c9fa3a5b099bbc4f41c077=
a6c69305cc2
>>
>> linux-user: specify the cpu model during configure
>> https://github.com/vivier/qemu-m68k/commit/496f804fd97d5f0ef26da1090e1d9=
5ad15bcc50e
>>
>> The part missing in my series is to rename the qemu binaries with the
>> suffix of the default CPU.
>=20
> I don't really like this -- it means we'll end up with a huge
> extra range of executables, and every time a new CPU type is
> added a new binary has to be plumbed in to our own 'make
> install' machinery and into every distro's packaging.

Peter,

Yes, there is a huge new range of binaries (there's actually no practical
upper bound), but I don't really anticipate this feature being used en mass=
e
by distributions. I do see it as a very useful tool for developers to be
able to leverage when the situation arises.

-Aaron S.

> The 'look at argv[0]' approach is perhaps a bit more
> palatable. Or you could just write and use wrapper
> scripts.
>=20
> I take it there's no good "-cpu any" option for PPC that
> would run all these binaries?
>=20
> thanks
> -- PMM

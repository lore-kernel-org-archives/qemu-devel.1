Received: from eggs.gnu.org ([2001:4830:134:3::10]:40421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dLZDA-00081s-Nd
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 14:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dLZD7-0005nr-I4
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 14:09:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dLZD7-0005na-BJ
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 14:09:37 -0400
References: <20170614105547.Horde.Qq_wt1XJCR6spCHFrm8xE9K@www.quantumachine.net>
	<CAFEAcA8idTcunTM61VVOnHSgryo1ZS5wK+MkZgCnn5C0h4+KuA@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8abfe17b-3fed-81c9-aad4-f99f31243c31@redhat.com>
Date: Thu, 15 Jun 2017 14:09:34 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8idTcunTM61VVOnHSgryo1ZS5wK+MkZgCnn5C0h4+KuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] DragonFly BSD support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Antonio_Huete_Jim=c3=a9nez?= <tuxillo@quantumachine.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>



On 06/15/2017 06:15 AM, Peter Maydell wrote:
> On 14 June 2017 at 11:55, Antonio Huete Jim=C3=A9nez
> <tuxillo@quantumachine.net> wrote:
>> According to 2.9 changelog page, DragonFly BSD will be listed as unsup=
ported
>> with the possibility of dropping support completely in the future:
>>
>> http://wiki.qemu.org/ChangeLog/2.9
>>
>> I'd like to volunteer so that qemu can keep DragonFly BSD as a support=
ed
>> platform.
>> Could you please let me know the requirements needed to do so?
>=20
> Thanks for volunteering!
>=20
> So, what we need comes in two parts:
>  (1) a machine we can use for our build tests (ie which I can have
> an ssh account on; we may set up more formal continuous-integration
> later). Since I don't know the BSDs somebody else needs to be
> handling sysadmin work for it.
> At a pinch, detailed instructions on how to set up a VM on
> Linux running DragonFly BSD would do; we have those for some
> of the BSDs here: http://wiki.qemu.org/Hosts/BSD
>=20
>  (2) somebody who's prepared to list themselves as the maintainer
> for the host OS, and respond to problems/patches relating to it.
> In particular the first thing will be to ensure that QEMU actually
> builds and passes 'make check' on this OS and submit any patches
> needed to fix problems. If there are any non-upstream patches
> lurking around in a ports system, then you'll also want to start
> cleaning those up and getting them upstream.
>=20
> When we get to the point where we have a machine in our
> standard build-and-test setup which passes 'make && make check'
> then we can drop the "this is unsupported" note from configure.
>=20
> thanks
> -- PMM
>=20

Peter, do we have a wiki page detailing what it takes to get an
operating system considered "supported" with hints and tips for
prospective maintainers?

Perhaps we could and include a link to the deprecation warnings.

(Then again, how many times will this be useful again in the future? How
many operating systems could there be that care about QEMU? ...)

--js

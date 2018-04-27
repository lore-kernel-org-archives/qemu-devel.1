Received: from eggs.gnu.org ([2001:4830:134:3::10]:40056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fC647-0003FH-55
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 12:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fC644-0003on-0m
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 12:17:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55132 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fC643-0003oB-SH
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 12:17:39 -0400
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d50e3a40-d7f3-4c9b-e930-4c2f4d6c8a53@redhat.com>
Date: Fri, 27 Apr 2018 18:17:27 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>

On 27.04.2018 17:51, Peter Maydell wrote:
> Hi; I usually let people forget about releases for a month or
> so before bringing this topic up, but:
>=20
> (1) do we want to call the next release 2.13, or something else?
> There's no particular reason to bump to 3.0 except some combination of
>  * if we keep going like this we'll get up to 2.42, which starts to
>    get silly
>  * Linus-style "avoid being too predictable"
>  * triskaidekaphobia

and maybe:

 * Celebrate 15 years of QEMU
 * Use 3.x to sympathize with Python3 and GTK3
 * Avoid that users mix up 2.13 with 2.1.3 and think that their
   QEMU 2.9 is way newer than 2.13
 * Celebrate that we could get rid of the -net vlan stuff
 * Finally stop me from sending stupid I-want-v3.0 mails

By the way, just another crazy idea for v3.0 (i.e. feel free to turn it
down immediately ;-)): Since compilation and testing time for QEMU is
really huge, what do you think if we got rid of some QEMU binaries?
qemu-system-aarch64 is a superset of qemu-system-arm, qemu-system-x86_64
is a superset of qemu-system-i386 and qemu-system-ppc64 is a superset of
qemu-system-ppc (and qemu-system-ppcemb). Would be feasible to get rid
of the subset binaries with some work? (I think they were especially
useful on 32-bit machines in the past, but most people are using 64-bit
machines nowadays, aren't they?).

 Happy Friday,
  Thomas

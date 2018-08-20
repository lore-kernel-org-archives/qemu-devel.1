Received: from eggs.gnu.org ([2001:4830:134:3::10]:59248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frilo-0002pq-Ky
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 07:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frilk-0007B6-Of
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 07:54:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49754 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1frilk-0007Av-JI
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 07:54:48 -0400
References: <1513160272-15921-1-git-send-email-christian.ehrhardt@canonical.com>
	<CAATJJ0+snukR5zqeL4v3B+YfcVP8jwxjgjfV6pupeJpoGCeHfA@mail.gmail.com>
	<CAATJJ0KK3Ya1RMyAjPDyYOQHbo+2xoWDbnVNup1Yop8Og00eBw@mail.gmail.com>
	<d0b421e2-2c0b-db08-5f6e-d05e11bbc007@amsat.org>
	<791e86e2-c278-13cf-0c3a-05b53e30aa08@amsat.org>
	<CAATJJ0+6X4YLLGq-wLCwTOx2sOKjEPqi+Gj71MgoXUR8Y79DXA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <baecd528-2372-5f81-c9b7-c20744420166@redhat.com>
Date: Mon, 20 Aug 2018 13:54:43 +0200
MIME-Version: 1.0
In-Reply-To: <CAATJJ0+6X4YLLGq-wLCwTOx2sOKjEPqi+Gj71MgoXUR8Y79DXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-guest-agent: freeze-hook to ignore
 dpkg files as well
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>, f4bug@amsat.org
Cc: qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, alex.bennee@linaro.org

On 20/08/2018 12:54, Christian Ehrhardt wrote:
>=20
>=20
> On Thu, May 10, 2018 at 8:47 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org
> <mailto:f4bug@amsat.org>> wrote:
>=20
>     Hi Paolo,
>=20
>     On 04/24/2018 10:01 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>     > Hi Christian,
>     >
>     > On 04/09/2018 04:18 AM, Christian Ehrhardt wrote:
>     >> Re-Ping for consideration?
>     >>
>     >> On Mon, Jan 22, 2018 at 3:03 PM, Christian Ehrhardt <
>     >> christian.ehrhardt@canonical.com
>     <mailto:christian.ehrhardt@canonical.com>> wrote:
>     >>
>     >>> Hi,
>     >>> maybe I missed a formal thing on this submission, but I don't
>     see it right
>     >>> away.
>     >
>     > You missed to Cc the maintainer of this file:
>     >
>     > $ ./scripts/get_maintainer.pl <http://get_maintainer.pl> -f
>     scripts/qemu-guest-agent/fsfreeze-hook
>     > Michael Roth <mdroth@linux.vnet.ibm.com
>     <mailto:mdroth@linux.vnet.ibm.com>> (maintainer:QEMU Guest Agent)
>     >
>     > (I Cc'ed him).
>     >
>     > See
>     https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_relevant_maint=
ainer
>     >
>     >>> So for now just a ping on any updates in regard to accept this?
>     >>>
>     >>> On Wed, Dec 13, 2017 at 11:17 AM, Christian Ehrhardt
>     >>> <christian.ehrhardt@canonical.com
>     <mailto:christian.ehrhardt@canonical.com>> wrote:
>     >>>> The hook already skips a set of rpm upgrade artifacts.
>     >>>> Do the same with such files that might be created by dpkg.
>     >>>>
>     >>>> Fixes: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/148=
4990
>     >>>>
>     >>>> Signed-off-by: Christian Ehrhardt
>     <christian.ehrhardt@canonical.com
>     <mailto:christian.ehrhardt@canonical.com>>
>     >
>     > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
>     <mailto:f4bug@amsat.org>>
>=20
>     Can you take this patch via your MISC tree?
>=20
>=20
> Even after Philippe=C2=A0back then helped to make sure CCs are better n=
othing
> happened.
> Therefore kindly re-ping for this to be included.
Queued, thanks.

Paolo

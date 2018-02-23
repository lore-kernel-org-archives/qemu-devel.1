Received: from eggs.gnu.org ([2001:4830:134:3::10]:40867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ep8nQ-0000qV-Lr
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 03:33:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ep8nN-0006Ff-Ii
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 03:33:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41048 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ep8nN-0006Ek-Dq
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 03:33:33 -0500
Date: Fri, 23 Feb 2018 16:33:15 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180223083315.GC31530@lemon.usersys.redhat.com>
References: <20180216164620.GA53727@humpty.home.comstyle.com>
	<c4407146-8ec6-c317-9ec8-a47ab909fb94@amsat.org>
	<85dc7f9f-95e1-c666-ee17-8f04d008d21b@gmx.com>
	<e625c026-2fa4-f3ea-d85e-080c65a4885f@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e625c026-2fa4-f3ea-d85e-080c65a4885f@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] maintainers: Add myself as a OpenBSD
 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Kamil Rytarowski <n54@gmx.com>, Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org

On Fri, 02/16 14:44, Philippe Mathieu-Daud=E9 wrote:
> On 02/16/2018 02:41 PM, Kamil Rytarowski wrote:
> > On 16.02.2018 18:30, Philippe Mathieu-Daud=E9 wrote:
> >> But before announcing the host OS being supported again, I'd rather =
see
> >> reproducible build/tests logs, in a (public - if possible) continuou=
s
> >> integration system. Else it is hard to notice when it get broken.
> >>
> >=20
> > This is already done for FreeBSD, NetBSD and OpenBSD.
>=20
> We have the ability to run those, but afaik no CI are using them.

That's right. I can try enabling them on patchew, but my gut feeling is t=
hat
these still need to be optimized (especially, enabling persisted ccache l=
ike our
docker tests, so it is reasonably efficient for our limited resources).

Fam

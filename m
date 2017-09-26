Received: from eggs.gnu.org ([2001:4830:134:3::10]:44364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <daniel@loffgren.org>) id 1dwhMM-0002bI-7S
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:20:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <daniel@loffgren.org>) id 1dwhMJ-0001h0-2t
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:20:38 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Daniel Loffgren <daniel@loffgren.org>
In-Reply-To: <b99306b2-2e53-7b0f-933c-c549c54b07b7@redhat.com>
Date: Mon, 25 Sep 2017 21:20:24 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <BFEFA6ED-21D2-44EF-AD78-12DF3F47A6A4@loffgren.org>
References: <40DEFE92-410B-4FED-B0A5-56C186627134@loffgren.org>
	<b99306b2-2e53-7b0f-933c-c549c54b07b7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] fprintf-fn.h uses GCC_FMT,
 but doesn't include the definition of it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

I am working on getting ppc-darwin-user working again, and this was one =
of the many things preventing it from compiling. Your explanation sounds =
correct. I believe it was the lack of osdep.h in the right .c files, =
since I added osdep.h to the tops of all of the necessary files well =
after this change (I was fixing things in order of compiler failures). I =
dropped this commit from my branch and it didn=E2=80=99t break. So, feel =
free to disregard this.

> On Sep 25, 2017, at 9:18 AM, Eric Blake <eblake@redhat.com> wrote:
>=20
> On 09/24/2017 08:02 PM, Daniel Loffgren wrote:
>>=20
>> Signed-off-by: Daniel Loffgren <daniel@loffgren.org>
>=20
> Hmm - you've identified a file with no listed maintainer.  But
> qemu-trivial does seem like the right place to include it.
>=20
> Generally, we like patches to call out the topic that it is touching;
> also, the subject line should focus on the what, while the body =
focuses
> on the why.  So a better commit message might be:
>=20
> maint: Make fprintf-fn.h self-contained
>=20
> Include the necessary headers so that GCC_FMT_ATTR is defined =
regardless
> of what client files use fprintf-fn.h.
>=20
>=20
> However, after saying that, I think your patch is not needed.  Per
> HACKING, _all_ .c files must include osdep.h first, and osdep.h =
already
> includes compiler.h, therefore, any .c file that uses fprintf-fn.h
> already has GCC_FMT_ATTR in scope by the time it gets to the
> fprintf_function typedef.  If you ran into a situation where you had a
> compile failure, please post more details of what failed for you, in
> case the problem was you forgetting to use osdep.h.
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>=20

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e5UqI-0004fQ-85
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e5UqE-0005RH-8L
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:47:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1e5UqE-0005PD-1c
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:47:50 -0400
Date: Fri, 20 Oct 2017 12:38:49 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171020103849.GB27352@stefanha-x1.localdomain>
References: <1508443483-5429-1-git-send-email-alindsay@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1508443483-5429-1-git-send-email-alindsay@codeaurora.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] build: Don't force preserving permissions
 on config-devices.mak.old
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>, Paul Brook <paul@codesourcery.com>

On Thu, Oct 19, 2017 at 04:04:43PM -0400, Aaron Lindsay wrote:
> I get the following error when building on an NFSv3 filesystem:
>=20
> % make -j8
>   GEN     aarch64-softmmu/config-devices.mak.tmp
>   GEN     config-host.h
> [snip]
>   GEN     qmp-marshal.c
>   GEN     aarch64-softmmu/config-devices.mak
> cp: preserving permissions for =E2=80=98aarch64-softmmu/config-devices.=
mak.old=E2=80=99: Operation not supported
> make: *** Deleting file `aarch64-softmmu/config-devices.mak'
>   GEN     qapi-types.c
> [snip]
>   CC      scsi/qemu-pr-helper.o
> make: *** No rule to make target `config-all-devices.mak', needed by `s=
ubdir-aarch64-softmmu'.  Stop.
> make: *** Waiting for unfinished jobs....
>=20
> Ideally you would only build on a filesystem with proper support, but I=
 haven't
> been able to find a reason why preserving exact permissions is importan=
t in
> this case.
>=20
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I cannot see a reason why $@.old must preserve timestamp/mode/ownership
either:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

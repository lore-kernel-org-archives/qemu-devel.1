Received: from eggs.gnu.org ([2001:4830:134:3::10]:56160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dZ6Nb-0004hQ-5O
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 22:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dZ6NX-0000nA-UG
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 22:12:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dZ6NX-0000mw-KF
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 22:12:19 -0400
Date: Sun, 23 Jul 2017 05:12:17 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170723045300-mutt-send-email-mst@kernel.org>
References: <1500614191-13392-1-git-send-email-wangyunjian@huawei.com>
	<CAJ+F1CJ2FWZdY3xN2NOgQxZKYPOE4ykLXhcke+hFt6YDKuYiSw@mail.gmail.com>
	<20170722033348-mutt-send-email-mst@kernel.org>
	<CAJ+F1CJCwH==79Sxp_=XegqJMoMnRN=+7gvS3RihZqgnXbKxZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJCwH==79Sxp_=XegqJMoMnRN=+7gvS3RihZqgnXbKxZA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost-user: fix watcher need be removed
 when vhost-user hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: w00273186 <wangyunjian@huawei.com>, qemu-devel@nongnu.org, jasowang@redhat.com, caihe@huawei.com

On Sat, Jul 22, 2017 at 09:24:27AM +0000, Marc-Andr=E9 Lureau wrote:
>=20
>=20
> On Sat, Jul 22, 2017 at 2:35 AM Michael S. Tsirkin <mst@redhat.com> wro=
te:
>=20
>     On Fri, Jul 21, 2017 at 11:19:04AM +0000, Marc-Andr=E9 Lureau wrote=
:
>     > Hi
>     >
>     > On Fri, Jul 21, 2017 at 7:18 AM w00273186 <wangyunjian@huawei.com=
> wrote:
>     >
>     >=A0 =A0 =A0From: Yunjian Wang <wangyunjian@huawei.com>
>     >
>     >=A0 =A0 =A0"nc" is freed after hotplug vhost-user, but the watcher=
 don't be
>     removed.
>     >=A0 =A0 =A0The QEMU crash when the watcher access the "nc" on sock=
et disconnect.
>     >
>     >
>     >
>     > This is actually your 3rd iteration on the patch
>     >
>     > Could your describe your changes since:
>     > "[PATCH v2] vhost-user: fix watcher need be removed when vhost-us=
er
>     hotplug"
>     >
>     > Thanks
>=20
>     Yes but it's a 3-liner. That's way below the limit where you need
>     detailed change history. Does the patch make sense to you?
>=20
>=20
>=20
> That's not all, the fact that he didn't come up with the same solution =
in the
> first place, and I didn't notice a problem either with the previous app=
roach is
> enough to ask from some clarification on which approach is best, and I =
bet
> there is something to say.

I'm rather confused.  Looks like you were the one who asked for the chang=
e.
Really we want to attract new contributors and a small bugfix like this
seems like a very good way to start contributing. Changelog is already
3 times the size of the patch here. So I think we should just get the pat=
ch
reviewed and applied if correct. Do you plan to review it?

> Furthermore, we would really benefit from having repeatable cases for t=
his kind
> of fixes.

I agree disconnect path is but tested adequately but I don't think we
are at a point where we should be asking for testcases for every use
after free bug that gets fixed.

> =A0
>=20
>     >
>     >=A0 =A0 =A0=A0 =A0 Program received signal SIGSEGV, Segmentation f=
ault.
>     >=A0 =A0 =A0=A0 =A0 #0=A0 object_get_class (obj=3Dobj@entry=3D0x2) =
at qom/object.c:750
>     >=A0 =A0 =A0=A0 =A0 #1=A0 0x00007f9bb4180da1 in qemu_chr_fe_disconn=
ect (be=3D<optimized
>     out>)
>     >=A0 =A0 =A0at chardev/char-fe.c:372
>     >=A0 =A0 =A0=A0 =A0 #2=A0 0x00007f9bb40d1100 in net_vhost_user_watc=
h (chan=3D<optimized
>     out>,
>     >=A0 =A0 =A0cond=3D<optimized out>, opaque=3D<optimized out>) at ne=
t/vhost-user.c:188
>     >=A0 =A0 =A0=A0 =A0 #3=A0 0x00007f9baf97f99a in g_main_context_disp=
atch () from /usr/
>     lib64/
>     >=A0 =A0 =A0libglib-2.0.so.0
>     >=A0 =A0 =A0=A0 =A0 #4=A0 0x00007f9bb41d7ebc in glib_pollfds_poll (=
) at util/
>     main-loop.c:213
>     >=A0 =A0 =A0=A0 =A0 #5=A0 os_host_main_loop_wait (timeout=3D<optimi=
zed out>) at util/
>     >=A0 =A0 =A0main-loop.c:261
>     >=A0 =A0 =A0=A0 =A0 #6=A0 main_loop_wait (nonblocking=3Dnonblocking=
@entry=3D0) at util/
>     >=A0 =A0 =A0main-loop.c:515
>     >=A0 =A0 =A0=A0 =A0 #7=A0 0x00007f9bb3e266a7 in main_loop () at vl.=
c:1917
>     >=A0 =A0 =A0=A0 =A0 #8=A0 main (argc=3D<optimized out>, argv=3D<opt=
imized out>, envp=3D
>     <optimized
>     >=A0 =A0 =A0out>) at vl.c:4786
>     >
>     >=A0 =A0 =A0Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
>     >=A0 =A0 =A0---
>     >=A0 =A0 =A0=A0net/vhost-user.c | 4 ++++
>     >=A0 =A0 =A0=A01 file changed, 4 insertions(+)
>     >
>     >=A0 =A0 =A0diff --git a/net/vhost-user.c b/net/vhost-user.c
>     >=A0 =A0 =A0index 36f32a2..c23927c 100644
>     >=A0 =A0 =A0--- a/net/vhost-user.c
>     >=A0 =A0 =A0+++ b/net/vhost-user.c
>     >=A0 =A0 =A0@@ -151,6 +151,10 @@ static void vhost_user_cleanup(Net=
ClientState
>     *nc)
>     >=A0 =A0 =A0=A0 =A0 =A0 =A0 =A0s->vhost_net =3D NULL;
>     >=A0 =A0 =A0=A0 =A0 =A0}
>     >=A0 =A0 =A0=A0 =A0 =A0if (nc->queue_index =3D=3D 0) {
>     >=A0 =A0 =A0+=A0 =A0 =A0 =A0 if (s->watch) {
>     >=A0 =A0 =A0+=A0 =A0 =A0 =A0 =A0 =A0 g_source_remove(s->watch);
>     >=A0 =A0 =A0+=A0 =A0 =A0 =A0 =A0 =A0 s->watch =3D 0;
>     >=A0 =A0 =A0+=A0 =A0 =A0 =A0 }
>     >=A0 =A0 =A0=A0 =A0 =A0 =A0 =A0qemu_chr_fe_deinit(&s->chr, true);
>     >=A0 =A0 =A0=A0 =A0 =A0}
>     >
>     >=A0 =A0 =A0--
>     >=A0 =A0 =A01.8.3.1
>     >
>     >
>     >
>     >
>     > --
>     > Marc-Andr=E9 Lureau
>=20
> --
> Marc-Andr=E9 Lureau


Why do you even bother including the patch if you use a client that
corrupts both the patch and the commit log formatting? It's not a good
example to give to new contributors and it doesn't align well
with nit-picking about same commit log, in my eyes.

--=20
MST

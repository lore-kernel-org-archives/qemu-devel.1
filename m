Received: from eggs.gnu.org ([209.51.188.92]:33542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gqejN-0007HS-WA
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:56:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gqejM-0002ye-Nj
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:56:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gqejM-0002xx-Fk
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:56:12 -0500
Date: Mon, 4 Feb 2019 13:56:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190204135608.GN1905@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190123172740.32452-1-berrange@redhat.com>
	<20190123172740.32452-2-berrange@redhat.com>
	<CAMxuvayRb9_FjR--Y9enzyh40TrkynfyXnx_860xtnkFevNb1Q@mail.gmail.com>
	<CAJ+F1C+pYc9_M0PBNXFd9SSHoOu_4nV4jKCYB+YqgJ1Jom0r_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+pYc9_M0PBNXFd9SSHoOu_4nV4jKCYB+YqgJ1Jom0r_Q@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/16] io: store reference to thread
 information in the QIOTask struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Yongji Xie <elohimes@gmail.com>

On Mon, Feb 04, 2019 at 11:40:55AM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi
> On Mon, Feb 4, 2019 at 11:38 AM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > On Wed, Jan 23, 2019 at 6:27 PM Daniel P. Berrang=C3=A9 <berrange@red=
hat.com> wrote:
> > >
> > > Currently the struct QIOTaskThreadData is only needed by the worker
> > > thread, but a subsequent patch will need to access it from another
> > > context.
> > >
> > > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> nack:
>=20
>=20
> $ tests/test-char
> /char/null: OK
> /char/invalid: OK
> /char/ringbuf: OK
> /char/mux: OK
> /char/stdio: OK
> /char/pipe: OK
> /char/file: OK
> /char/file-fifo: OK
> /char/udp: OK
> /char/serial: OK
> /char/hotswap: OK
> /char/websocket: OK
> /char/socket/basic: OK
> /char/socket/reconnect:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D22150=3D=3DERROR: AddressSanitizer: heap-use-after-free on addres=
s
> 0x606000004198 at pc 0x5618a22be8d3 bp 0x7fffa43d8a80 sp
> 0x7fffa43d8a70
> READ of size 8 at 0x606000004198 thread T0
>     #0 0x5618a22be8d2 in qio_task_thread_result
> /home/elmarco/src/qemu/io/task.c:91
>     #1 0x7f111f08397a  (/lib64/libglib-2.0.so.0+0x4b97a)
>     #2 0x7f111f08706c in g_main_context_dispatch
> (/lib64/libglib-2.0.so.0+0x4f06c)
>     #3 0x5618a23969b7 in glib_pollfds_poll
> /home/elmarco/src/qemu/util/main-loop.c:215
>     #4 0x5618a23969b7 in os_host_main_loop_wait
> /home/elmarco/src/qemu/util/main-loop.c:238
>     #5 0x5618a23969b7 in main_loop_wait
> /home/elmarco/src/qemu/util/main-loop.c:497
>     #6 0x5618a2299786 in main_loop /home/elmarco/src/qemu/tests/test-ch=
ar.c:27
>     #7 0x5618a229b651 in char_socket_test_common
> /home/elmarco/src/qemu/tests/test-char.c:355
>     #8 0x7f111f0aefc9  (/lib64/libglib-2.0.so.0+0x76fc9)
>     #9 0x7f111f0aee83  (/lib64/libglib-2.0.so.0+0x76e83)
>     #10 0x7f111f0aee83  (/lib64/libglib-2.0.so.0+0x76e83)
>     #11 0x7f111f0af281 in g_test_run_suite (/lib64/libglib-2.0.so.0+0x7=
7281)
>     #12 0x7f111f0af2a4 in g_test_run (/lib64/libglib-2.0.so.0+0x772a4)
>     #13 0x5618a2293859 in main /home/elmarco/src/qemu/tests/test-char.c=
:971
>     #14 0x7f111de11412 in __libc_start_main (/lib64/libc.so.6+0x24412)
>     #15 0x5618a2295c1d in _start
> (/home/elmarco/src/qemu/build/tests/test-char+0x23ac1d)
>=20
> 0x606000004198 is located 56 bytes inside of 64-byte region
> [0x606000004160,0x6060000041a0)
> freed by thread T0 here:
>     #0 0x7f111f2f0480 in free (/lib64/libasan.so.5+0xef480)
>     #1 0x7f111f08ced1 in g_free (/lib64/libglib-2.0.so.0+0x54ed1)
>     #2 0x5618a243759f  (/home/elmarco/src/qemu/build/tests/test-char+0x=
3dc59f)
>=20
> previously allocated by thread T0 here:
>     #0 0x7f111f2f0a50 in __interceptor_calloc (/lib64/libasan.so.5+0xef=
a50)
>     #1 0x7f111f08ce1d in g_malloc0 (/lib64/libglib-2.0.so.0+0x54e1d)
>=20
> SUMMARY: AddressSanitizer: heap-use-after-free
> /home/elmarco/src/qemu/io/task.c:91 in qio_task_thread_result
> Shadow bytes around the buggy address:

FWIW, valgrind reports the same problem

Needs this change squashed in to fix it

diff --git a/io/task.c b/io/task.c
index d100a754d3..396866b10f 100644
--- a/io/task.c
+++ b/io/task.c
@@ -66,6 +66,18 @@ QIOTask *qio_task_new(Object *source,
=20
 static void qio_task_free(QIOTask *task)
 {
+    if (task->thread) {
+        if (task->thread->destroy) {
+            task->thread->destroy(task->thread->opaque);
+        }
+
+        if (task->thread->context) {
+            g_main_context_unref(task->thread->context);
+        }
+
+        g_free(task->thread);
+    }
+
     if (task->destroy) {
         task->destroy(task->opaque);
     }
@@ -88,17 +100,6 @@ static gboolean qio_task_thread_result(gpointer opaqu=
e)
     trace_qio_task_thread_result(task);
     qio_task_complete(task);
=20
-    if (task->thread->destroy) {
-        task->thread->destroy(task->thread->opaque);
-    }
-
-    if (task->thread->context) {
-        g_main_context_unref(task->thread->context);
-    }
-
-    g_free(task->thread);
-    task->thread =3D NULL;
-
     return FALSE;
 }



Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

Received: from eggs.gnu.org ([209.51.188.92]:40244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gqbgk-0000EB-Vv
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gqbgh-0005xY-0b
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:41:18 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gqbgg-0005py-AQ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:41:14 -0500
Received: by mail-wm1-x341.google.com with SMTP id z5so4629749wmf.0
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 02:41:08 -0800 (PST)
MIME-Version: 1.0
References: <20190123172740.32452-1-berrange@redhat.com>
	<20190123172740.32452-2-berrange@redhat.com>
	<CAMxuvayRb9_FjR--Y9enzyh40TrkynfyXnx_860xtnkFevNb1Q@mail.gmail.com>
In-Reply-To: <CAMxuvayRb9_FjR--Y9enzyh40TrkynfyXnx_860xtnkFevNb1Q@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 4 Feb 2019 11:40:55 +0100
Message-ID: <CAJ+F1C+pYc9_M0PBNXFd9SSHoOu_4nV4jKCYB+YqgJ1Jom0r_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Yongji Xie <elohimes@gmail.com>

Hi
On Mon, Feb 4, 2019 at 11:38 AM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> On Wed, Jan 23, 2019 at 6:27 PM Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> >
> > Currently the struct QIOTaskThreadData is only needed by the worker
> > thread, but a subsequent patch will need to access it from another
> > context.
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

nack:


$ tests/test-char
/char/null: OK
/char/invalid: OK
/char/ringbuf: OK
/char/mux: OK
/char/stdio: OK
/char/pipe: OK
/char/file: OK
/char/file-fifo: OK
/char/udp: OK
/char/serial: OK
/char/hotswap: OK
/char/websocket: OK
/char/socket/basic: OK
/char/socket/reconnect:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D22150=3D=3DERROR: AddressSanitizer: heap-use-after-free on address
0x606000004198 at pc 0x5618a22be8d3 bp 0x7fffa43d8a80 sp
0x7fffa43d8a70
READ of size 8 at 0x606000004198 thread T0
    #0 0x5618a22be8d2 in qio_task_thread_result
/home/elmarco/src/qemu/io/task.c:91
    #1 0x7f111f08397a  (/lib64/libglib-2.0.so.0+0x4b97a)
    #2 0x7f111f08706c in g_main_context_dispatch
(/lib64/libglib-2.0.so.0+0x4f06c)
    #3 0x5618a23969b7 in glib_pollfds_poll
/home/elmarco/src/qemu/util/main-loop.c:215
    #4 0x5618a23969b7 in os_host_main_loop_wait
/home/elmarco/src/qemu/util/main-loop.c:238
    #5 0x5618a23969b7 in main_loop_wait
/home/elmarco/src/qemu/util/main-loop.c:497
    #6 0x5618a2299786 in main_loop /home/elmarco/src/qemu/tests/test-char.c=
:27
    #7 0x5618a229b651 in char_socket_test_common
/home/elmarco/src/qemu/tests/test-char.c:355
    #8 0x7f111f0aefc9  (/lib64/libglib-2.0.so.0+0x76fc9)
    #9 0x7f111f0aee83  (/lib64/libglib-2.0.so.0+0x76e83)
    #10 0x7f111f0aee83  (/lib64/libglib-2.0.so.0+0x76e83)
    #11 0x7f111f0af281 in g_test_run_suite (/lib64/libglib-2.0.so.0+0x77281=
)
    #12 0x7f111f0af2a4 in g_test_run (/lib64/libglib-2.0.so.0+0x772a4)
    #13 0x5618a2293859 in main /home/elmarco/src/qemu/tests/test-char.c:971
    #14 0x7f111de11412 in __libc_start_main (/lib64/libc.so.6+0x24412)
    #15 0x5618a2295c1d in _start
(/home/elmarco/src/qemu/build/tests/test-char+0x23ac1d)

0x606000004198 is located 56 bytes inside of 64-byte region
[0x606000004160,0x6060000041a0)
freed by thread T0 here:
    #0 0x7f111f2f0480 in free (/lib64/libasan.so.5+0xef480)
    #1 0x7f111f08ced1 in g_free (/lib64/libglib-2.0.so.0+0x54ed1)
    #2 0x5618a243759f  (/home/elmarco/src/qemu/build/tests/test-char+0x3dc5=
9f)

previously allocated by thread T0 here:
    #0 0x7f111f2f0a50 in __interceptor_calloc (/lib64/libasan.so.5+0xefa50)
    #1 0x7f111f08ce1d in g_malloc0 (/lib64/libglib-2.0.so.0+0x54e1d)

SUMMARY: AddressSanitizer: heap-use-after-free
/home/elmarco/src/qemu/io/task.c:91 in qio_task_thread_result
Shadow bytes around the buggy address:

> > ---
> >  io/task.c | 53 ++++++++++++++++++++++++++++-------------------------
> >  1 file changed, 28 insertions(+), 25 deletions(-)
> >
> > diff --git a/io/task.c b/io/task.c
> > index 2886a2c1bc..d100a754d3 100644
> > --- a/io/task.c
> > +++ b/io/task.c
> > @@ -24,6 +24,14 @@
> >  #include "qemu/thread.h"
> >  #include "trace.h"
> >
> > +struct QIOTaskThreadData {
> > +    QIOTaskWorker worker;
> > +    gpointer opaque;
> > +    GDestroyNotify destroy;
> > +    GMainContext *context;
> > +};
> > +
> > +
> >  struct QIOTask {
> >      Object *source;
> >      QIOTaskFunc func;
> > @@ -32,6 +40,7 @@ struct QIOTask {
> >      Error *err;
> >      gpointer result;
> >      GDestroyNotify destroyResult;
> > +    struct QIOTaskThreadData *thread;
> >  };
> >
> >
> > @@ -72,31 +81,23 @@ static void qio_task_free(QIOTask *task)
> >  }
> >
> >
> > -struct QIOTaskThreadData {
> > -    QIOTask *task;
> > -    QIOTaskWorker worker;
> > -    gpointer opaque;
> > -    GDestroyNotify destroy;
> > -    GMainContext *context;
> > -};
> > -
> > -
> >  static gboolean qio_task_thread_result(gpointer opaque)
> >  {
> > -    struct QIOTaskThreadData *data =3D opaque;
> > +    QIOTask *task =3D opaque;
> >
> > -    trace_qio_task_thread_result(data->task);
> > -    qio_task_complete(data->task);
> > +    trace_qio_task_thread_result(task);
> > +    qio_task_complete(task);
> >
> > -    if (data->destroy) {
> > -        data->destroy(data->opaque);
> > +    if (task->thread->destroy) {
> > +        task->thread->destroy(task->thread->opaque);
> >      }
> >
> > -    if (data->context) {
> > -        g_main_context_unref(data->context);
> > +    if (task->thread->context) {
> > +        g_main_context_unref(task->thread->context);
> >      }
> >
> > -    g_free(data);
> > +    g_free(task->thread);
> > +    task->thread =3D NULL;
> >
> >      return FALSE;
> >  }
> > @@ -104,22 +105,23 @@ static gboolean qio_task_thread_result(gpointer o=
paque)
> >
> >  static gpointer qio_task_thread_worker(gpointer opaque)
> >  {
> > -    struct QIOTaskThreadData *data =3D opaque;
> > +    QIOTask *task =3D opaque;
> >      GSource *idle;
> >
> > -    trace_qio_task_thread_run(data->task);
> > -    data->worker(data->task, data->opaque);
> > +    trace_qio_task_thread_run(task);
> > +
> > +    task->thread->worker(task, task->thread->opaque);
> >
> >      /* We're running in the background thread, and must only
> >       * ever report the task results in the main event loop
> >       * thread. So we schedule an idle callback to report
> >       * the worker results
> >       */
> > -    trace_qio_task_thread_exit(data->task);
> > +    trace_qio_task_thread_exit(task);
> >
> >      idle =3D g_idle_source_new();
> > -    g_source_set_callback(idle, qio_task_thread_result, data, NULL);
> > -    g_source_attach(idle, data->context);
> > +    g_source_set_callback(idle, qio_task_thread_result, task, NULL);
> > +    g_source_attach(idle, task->thread->context);
> >
> >      return NULL;
> >  }
> > @@ -138,17 +140,18 @@ void qio_task_run_in_thread(QIOTask *task,
> >          g_main_context_ref(context);
> >      }
> >
> > -    data->task =3D task;
> >      data->worker =3D worker;
> >      data->opaque =3D opaque;
> >      data->destroy =3D destroy;
> >      data->context =3D context;
> >
> > +    task->thread =3D data;
> > +
> >      trace_qio_task_thread_start(task, worker, opaque);
> >      qemu_thread_create(&thread,
> >                         "io-task-worker",
> >                         qio_task_thread_worker,
> > -                       data,
> > +                       task,
> >                         QEMU_THREAD_DETACHED);
> >  }
> >
> > --
> > 2.20.1
> >
>


--=20
Marc-Andr=C3=A9 Lureau

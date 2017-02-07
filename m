Received: from eggs.gnu.org ([2001:4830:134:3::10]:44928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cbF3k-0006YW-GJ
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cbF3i-000062-Tt
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:20:28 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:36663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1cbF3i-00005O-NP
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:20:26 -0500
Received: by mail-io0-x244.google.com with SMTP id q20so14319129ioi.3
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 15:20:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAAo6VWOEk5e+ny52ZExUA8_0P7nX5mBjmUX2fLYqi0ddjCikxQ@mail.gmail.com>
References: <1471149312-28148-1-git-send-email-ashish.mittal@veritas.com>
	<20160815102046.GC13261@redhat.com>
	<CAAo6VWONzyoHE49CoQyAm4mqumNQmC3vh4KG1AV=x2Lj-c1HwQ@mail.gmail.com>
	<23ea8348-7ed9-7e45-1079-235614dc90c2@redhat.com>
	<CAAo6VWMOHsKZ-8wKTX5=zZqOda9_GtBP-PEptR2R__FLMKyNMg@mail.gmail.com>
	<CAAo6VWNYwRO5BO-qmQdzsp0R981CcXEQOBdHGYzQaVGzBZaZMw@mail.gmail.com>
	<20160823215803.GA24259@stefanha-x1.localdomain>
	<CAAo6VWNF-dBmUBV2N4jNQFNHyUAMfpyeO_qt+e7ZW1XGsUG6+Q@mail.gmail.com>
	<CAAo6VWNXwZrTt+cQeBhTP9kM=b-UVe7r_9Rh2dJJb62fGXoUgA@mail.gmail.com>
	<20161115204852.GA6784@stefanha-x1.localdomain>
	<CAAo6VWOEk5e+ny52ZExUA8_0P7nX5mBjmUX2fLYqi0ddjCikxQ@mail.gmail.com>
From: ashish mittal <ashmit602@gmail.com>
Date: Tue, 7 Feb 2017 15:20:25 -0800
Message-ID: <CAAo6VWOC78FuQ-kgxU0ASeEvP0V8wZ3mnn1zzq3LYBsmrX3r3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 RFC] block/vxhs: Initial commit to add
 Veritas HyperScale VxHS block device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Ashish Mittal <ashish.mittal@veritas.com>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, Jeff Cody <jcody@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

Hi Stefan,

Patch V7, which I plan to submit soon,  will have fixes to all the
issues you pointed out in reply to -
[PATCH v6 1/2] block/vxhs.c: Add support for a new block device type
called "vxhs"


It will also have the QEMUBH patch you provided.

Thanks,
Ashish


On Tue, Nov 15, 2016 at 12:51 PM, ashish mittal <ashmit602@gmail.com> wrote:
> Thank you. Will work with this.
>
> On Tue, Nov 15, 2016 at 12:48 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> On Tue, Nov 15, 2016 at 11:02:34AM -0800, ashish mittal wrote:
>>> I had replied to the QEMUBH suggestion in the email below.
>>>
>>> Regards,
>>> Ashish
>>>
>>> On Tue, Aug 23, 2016 at 3:22 PM, ashish mittal <ashmit602@gmail.com> wrote:
>>> > Thanks Stefan, I will look at block/quorum.c.
>>> >
>>> > I have sent V4 of the patch with a reworked parsing logic for both
>>> > JSON and URI. Both of them are quite compact now.
>>> >
>>> > URI parsing now follows the suggestion given by Kevin.
>>> > /================/
>>> > However, you should use the proper interfaces to implement this, which
>>> > is .bdrv_parse_filename(). This is a function that gets a string and
>>> > converts it into a QDict, which is then passed to .bdrv_open(). So it
>>> > uses exactly the same code path in .bdrv_open() as if used directly with
>>> > QAPI.
>>> > /================/
>>> >
>>> > Additionally, I have fixed all the issues pointed out by you on V1 of
>>> > the patch. The only change I haven't done is to replace pipes with
>>> > QEMUBH. I am hoping this will not hold up the patch from being
>>> > accepted, and I can make this transition later with proper dev and
>>> > testing.
>>
>> Sorry, I forgot about this email.  I still think the QEMUBH approach
>> makes sense.  Please try the following patch.
>>
>> I have compiled but not run it.  You are welcome to squash it into your
>> next patch.
>>
>> The following is Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>.
>>
>> ---8<---
>>
>> diff --git a/block/vxhs.c b/block/vxhs.c
>> index 8913e8f..22fd989 100644
>> --- a/block/vxhs.c
>> +++ b/block/vxhs.c
>> @@ -60,9 +60,6 @@ typedef struct VXHSvDiskHostsInfo {
>>   * Structure per vDisk maintained for state
>>   */
>>  typedef struct BDRVVXHSState {
>> -    int fds[2];
>> -    int event_reader_pos;
>> -    VXHSAIOCB *qnio_event_acb;
>>      VXHSvDiskHostsInfo vdisk_hostinfo; /* Per host info */
>>      char *vdisk_guid;
>>  } BDRVVXHSState;
>> @@ -73,12 +70,33 @@ static QNIOLibState qniolib;
>>  /* vdisk prefix to pass to qnio */
>>  static const char vdisk_prefix[] = "/dev/of/vdisk";
>>
>> +static void vxhs_complete_aio_bh(void *opaque)
>> +{
>> +    VXHSAIOCB *acb = opaque;
>> +    BlockCompletionFunc *cb = acb->common.cb;
>> +    void *cb_opaque = acb->common.opaque;
>> +    int ret = 0;
>> +
>> +    if (acb->err != 0) {
>> +        trace_vxhs_complete_aio(acb, acb->err);
>> +        /*
>> +         * We mask all the IO errors generically as EIO for upper layers
>> +         * Right now our IO Manager uses non standard error codes. Instead
>> +         * of confusing upper layers with incorrect interpretation we are
>> +         * doing this workaround.
>> +         */
>> +        ret = (-EIO);
>> +    }
>> +
>> +    qemu_aio_unref(acb);
>> +    cb(cb_opaque, ret);
>> +}
>> +
>> +/* Called from a libqnio thread */
>>  static void vxhs_iio_callback(int32_t rfd, uint32_t reason, void *ctx,
>>                                uint32_t error, uint32_t opcode)
>>  {
>>      VXHSAIOCB *acb = NULL;
>> -    BDRVVXHSState *s = NULL;
>> -    ssize_t ret;
>>
>>      switch (opcode) {
>>      case IRP_READ_REQUEST:
>> @@ -91,7 +109,6 @@ static void vxhs_iio_callback(int32_t rfd, uint32_t reason, void *ctx,
>>           */
>>          if (ctx) {
>>              acb = ctx;
>> -            s = acb->common.bs->opaque;
>>          } else {
>>              trace_vxhs_iio_callback(error, reason);
>>              goto out;
>> @@ -104,8 +121,8 @@ static void vxhs_iio_callback(int32_t rfd, uint32_t reason, void *ctx,
>>              trace_vxhs_iio_callback(error, reason);
>>          }
>>
>> -        ret = qemu_write_full(s->fds[VDISK_FD_WRITE], &acb, sizeof(acb));
>> -        g_assert(ret == sizeof(acb));
>> +        aio_bh_schedule_oneshot(bdrv_get_aio_context(acb->common.bs),
>> +                                vxhs_complete_aio_bh, acb);
>>          break;
>>
>>      default:
>> @@ -223,53 +240,6 @@ static void vxhs_qnio_iio_close(BDRVVXHSState *s)
>>      vxhs_qnio_close();
>>  }
>>
>> -static void vxhs_complete_aio(VXHSAIOCB *acb, BDRVVXHSState *s)
>> -{
>> -    BlockCompletionFunc *cb = acb->common.cb;
>> -    void *opaque = acb->common.opaque;
>> -    int ret = 0;
>> -
>> -    if (acb->err != 0) {
>> -        trace_vxhs_complete_aio(acb, acb->err);
>> -        /*
>> -         * We mask all the IO errors generically as EIO for upper layers
>> -         * Right now our IO Manager uses non standard error codes. Instead
>> -         * of confusing upper layers with incorrect interpretation we are
>> -         * doing this workaround.
>> -         */
>> -        ret = (-EIO);
>> -    }
>> -
>> -    qemu_aio_unref(acb);
>> -    cb(opaque, ret);
>> -}
>> -
>> -/*
>> - * This is the HyperScale event handler registered to QEMU.
>> - * It is invoked when any IO gets completed and written on pipe
>> - * by callback called from QNIO thread context. Then it marks
>> - * the AIO as completed, and releases HyperScale AIO callbacks.
>> - */
>> -static void vxhs_aio_event_reader(void *opaque)
>> -{
>> -    BDRVVXHSState *s = opaque;
>> -    char *p;
>> -    ssize_t ret;
>> -
>> -    do {
>> -        p = (char *)&s->qnio_event_acb;
>> -        ret = read(s->fds[VDISK_FD_READ], p + s->event_reader_pos,
>> -                   sizeof(s->qnio_event_acb) - s->event_reader_pos);
>> -        if (ret > 0) {
>> -            s->event_reader_pos += ret;
>> -            if (s->event_reader_pos == sizeof(s->qnio_event_acb)) {
>> -                s->event_reader_pos = 0;
>> -                vxhs_complete_aio(s->qnio_event_acb, s);
>> -            }
>> -        }
>> -    } while (ret < 0 && errno == EINTR);
>> -}
>> -
>>  static QemuOptsList runtime_opts = {
>>      .name = "vxhs",
>>      .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
>> @@ -468,7 +438,6 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
>>                       int bdrv_flags, Error **errp)
>>  {
>>      BDRVVXHSState *s = bs->opaque;
>> -    AioContext *aio_context;
>>      int qemu_qnio_cfd = -1;
>>      int qemu_rfd = -1;
>>      int ret = 0;
>> @@ -481,32 +450,7 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
>>
>>      s->vdisk_hostinfo.qnio_cfd = qemu_qnio_cfd;
>>      s->vdisk_hostinfo.vdisk_rfd = qemu_rfd;
>> -
>> -    /*
>> -     * Create a pipe for communicating between two threads in different
>> -     * context. Set handler for read event, which gets triggered when
>> -     * IO completion is done by non-QEMU context.
>> -     */
>> -    ret = qemu_pipe(s->fds);
>> -    if (ret < 0) {
>> -        trace_vxhs_open_epipe(ret);
>> -        ret = -errno;
>> -        goto errout;
>> -    }
>> -    fcntl(s->fds[VDISK_FD_READ], F_SETFL, O_NONBLOCK);
>> -
>> -    aio_context = bdrv_get_aio_context(bs);
>> -    aio_set_fd_handler(aio_context, s->fds[VDISK_FD_READ],
>> -                       false, vxhs_aio_event_reader, NULL, s);
>>      return 0;
>> -
>> -errout:
>> -    /*
>> -     * Close remote vDisk device if it was opened earlier
>> -     */
>> -    vxhs_qnio_iio_close(s);
>> -    trace_vxhs_open_fail(ret);
>> -    return ret;
>>  }
>>
>>  static const AIOCBInfo vxhs_aiocb_info = {
>> @@ -596,14 +540,7 @@ static void vxhs_close(BlockDriverState *bs)
>>      BDRVVXHSState *s = bs->opaque;
>>
>>      trace_vxhs_close(s->vdisk_guid);
>> -    close(s->fds[VDISK_FD_READ]);
>> -    close(s->fds[VDISK_FD_WRITE]);
>>
>> -    /*
>> -     * Clearing all the event handlers for oflame registered to QEMU
>> -     */
>> -    aio_set_fd_handler(bdrv_get_aio_context(bs), s->fds[VDISK_FD_READ],
>> -                       false, NULL, NULL, NULL);
>>      g_free(s->vdisk_guid);
>>      s->vdisk_guid = NULL;
>>      vxhs_qnio_iio_close(s);
>> @@ -650,23 +587,6 @@ static int64_t vxhs_getlength(BlockDriverState *bs)
>>      return vdisk_size;
>>  }
>>
>> -static void vxhs_detach_aio_context(BlockDriverState *bs)
>> -{
>> -    BDRVVXHSState *s = bs->opaque;
>> -
>> -    aio_set_fd_handler(bdrv_get_aio_context(bs), s->fds[VDISK_FD_READ],
>> -                       false, NULL, NULL, NULL);
>> -}
>> -
>> -static void vxhs_attach_aio_context(BlockDriverState *bs,
>> -                                   AioContext *new_context)
>> -{
>> -    BDRVVXHSState *s = bs->opaque;
>> -
>> -    aio_set_fd_handler(new_context, s->fds[VDISK_FD_READ],
>> -                       false, vxhs_aio_event_reader, NULL, s);
>> -}
>> -
>>  static BlockDriver bdrv_vxhs = {
>>      .format_name                  = "vxhs",
>>      .protocol_name                = "vxhs",
>> @@ -677,8 +597,6 @@ static BlockDriver bdrv_vxhs = {
>>      .bdrv_getlength               = vxhs_getlength,
>>      .bdrv_aio_readv               = vxhs_aio_readv,
>>      .bdrv_aio_writev              = vxhs_aio_writev,
>> -    .bdrv_detach_aio_context      = vxhs_detach_aio_context,
>> -    .bdrv_attach_aio_context      = vxhs_attach_aio_context,
>>  };
>>
>>  static void bdrv_vxhs_init(void)

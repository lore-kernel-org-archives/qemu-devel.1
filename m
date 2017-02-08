Received: from eggs.gnu.org ([2001:4830:134:3::10]:33727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cbb2D-00030F-P8
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 17:48:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cbb2A-00037B-DN
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 17:48:21 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:35401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1cbb2A-000371-5P
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 17:48:18 -0500
Received: by mail-it0-x244.google.com with SMTP id 203so582872ith.2
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 14:48:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54FB3FB1-1B68-44C5-B243-A1206831CB2A@veritas.com>
References: <1486527494-3387-1-git-send-email-Ashish.Mittal@veritas.com>
	<20170208222142.GM30111@localhost.localdomain>
	<54FB3FB1-1B68-44C5-B243-A1206831CB2A@veritas.com>
From: ashish mittal <ashmit602@gmail.com>
Date: Wed, 8 Feb 2017 14:48:16 -0800
Message-ID: <CAAo6VWNZpnnUW8s58t7cy+6BSm7JD5e0qnrZR-EZEvO5s_VFjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ketan Nilangekar <Ketan.Nilangekar@veritas.com>
Cc: Jeff Cody <jcody@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, "famz@redhat.com" <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, "stefanha@gmail.com" <stefanha@gmail.com>, "jferlan@redhat.com" <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Abhijit Dey <Abhijit.Dey@veritas.com>

On Wed, Feb 8, 2017 at 2:35 PM, Ketan Nilangekar
<Ketan.Nilangekar@veritas.com> wrote:
>
>
> On 2/8/17, 2:21 PM, "Jeff Cody" <jcody@redhat.com> wrote:
>
>     On Tue, Feb 07, 2017 at 08:18:13PM -0800, Ashish Mittal wrote:
>     > From: Ashish Mittal <ashish.mittal@veritas.com>
>     >
>     > Source code for the qnio library that this code loads can be downlo=
aded from:
>     > https://github.com/VeritasHyperScale/libqnio.git
>     >
>
>     What branch does this use for libqnio?  I was under the impression th=
at v7
>     of this series was going to work and test against the latest SSL bran=
ch
>     upstream, but that doesn't appear to be the case - there are API diff=
erences
>     and this code can't compile against the 'securify' branch on
>     https://github.com/VeritasHyperScale/libqnio.git
>
>     So some questions and thoughts around this:
>
>     1. If the target libqnio library version is essentially what it is on=
 the
>        libqnio 'securify' branch, then obviously this patch series can't =
be in a
>        merge-ready state, since its API usage is (at the very least) stal=
e;
>
>     2. It is getting very late (compared to feature freeze) to have patch=
es that
>        can't be tested or compiled against the intended libqnio release. =
 Do you
>        know exactly what the API differences are and the impact this has =
on this
>        series?  If so, can you list what that is, and/or maybe post a qui=
ck v8?
>
> [Ketan]
> There is only one API (iio_init) in libqnio that that was under review ba=
sed on comments from Stefan.
> Iio_init is now changed to pass an instance id. This instance Id will be =
used to lookup local credentials for the instance. This was also supposed t=
o be used for extra level of authorization on VxHS server. But that seems r=
edundant based on Stefan's inputs.
> So we have decided retan the API change that is proposed in 'securify' br=
anch and have the QEMU driver use that.
> Change suggested by Stefan will be done without changing the API in the '=
securify' branch.
>
> Ashish, please post a v8 patch based on securify branch so Jeff can compl=
ete the review.
>

Qemu changes to work with the libqnio securify branch are not very
many - only a few lines. The configure script has some changes to
account for the library name change (libvxhs now) and the new
iio_init() interface. I will post another patch.

>     3. Or, perhaps the API on the 'securify' libqnio branch is not stable=
.  If
>        that is the case, I guess there is no choice but to wait for that =
to
>        stabilize before posting a v8+ patch series that uses the API.
>
>
>     I'll go ahead and review this series on its own merits against the li=
bqnio
>     master branch, but I wanted to point that out now in case you are abl=
e to do
>     anything in point 2.  The rest of my review will be in subsequent ema=
il(s).
>
>
>     -Jeff
>
>     > Sample command line using JSON syntax:
>     > ./x86_64-softmmu/qemu-system-x86_64 -name instance-00000008 -S -vnc=
 0.0.0.0:0
>     > -k en-us -vga cirrus -device virtio-balloon-pci,id=3Dballoon0,bus=
=3Dpci.0,addr=3D0x5
>     > -msg timestamp=3Don
>     > 'json:{"driver":"vxhs","vdisk-id":"c3e9095a-a5ee-4dce-afeb-2a59fb38=
7410",
>     > "server":{"host":"172.172.17.4","port":"9999"}}'
>     >
>     > Sample command line using URI syntax:
>     > qemu-img convert -f raw -O raw -n
>     > /var/lib/nova/instances/_base/0c5eacd5ebea5ed914b6a3e7b18f1ce734c38=
6ad
>     > vxhs://192.168.0.1:9999/c6718f6b-0401-441d-a8c3-1f0064d75ee0
>     >
>     > Signed-off-by: Ashish Mittal <ashish.mittal@veritas.com>
>     > ---
>     > TODO:
>     > (1) valgrind report to follow soon.
>     > (2) Security implementation for libqnio present in branch "securify=
".
>     >     QEMU patch will use this once it gets merged to libqnio master.
>     >     Please use master for building libqnio and testing with this pa=
tch.
>     > (3) Rename libqnio to libvxhs. Changes ready in branch "securify".
>     >
>     > v7 changelog:
>     > (1) IO failover code has moved out to the libqnio library.
>     > (2) Fixes for issues reported by Stefan on v6.
>     > (3) Incorporated the QEMUBH patch provided by Stefan.
>     >     This is a replacement for the pipe mechanism used earlier.
>     > (4) Fixes to the buffer overflows reported in libqnio.
>     > (5) Input validations in vxhs.c to prevent any buffer overflows for
>     >     arguments passed to libqnio.
>     >
>     > v6 changelog:
>     > (1) Added qemu-iotests for VxHS as a new patch in the series.
>     > (2) Replaced release version from 2.8 to 2.9 in block-core.json.
>     >
>     > v5 changelog:
>     > (1) Incorporated v4 review comments.
>     >
>     > v4 changelog:
>     > (1) Incorporated v3 review comments on QAPI changes.
>     > (2) Added refcounting for device open/close.
>     >     Free library resources on last device close.
>     >
>     > v3 changelog:
>     > (1) Added QAPI schema for the VxHS driver.
>     >
>     > v2 changelog:
>     > (1) Changes done in response to v1 comments.
>     >
>     >  block/Makefile.objs  |   2 +
>     >  block/trace-events   |  16 ++
>     >  block/vxhs.c         | 488 +++++++++++++++++++++++++++++++++++++++=
++++++++++++
>     >  configure            |  40 +++++
>     >  qapi/block-core.json |  20 ++-
>     >  5 files changed, 564 insertions(+), 2 deletions(-)
>     >  create mode 100644 block/vxhs.c
>     >
>     > diff --git a/block/Makefile.objs b/block/Makefile.objs
>     > index c6bd14e..75675b4 100644
>     > --- a/block/Makefile.objs
>     > +++ b/block/Makefile.objs
>     > @@ -19,6 +19,7 @@ block-obj-$(CONFIG_LIBNFS) +=3D nfs.o
>     >  block-obj-$(CONFIG_CURL) +=3D curl.o
>     >  block-obj-$(CONFIG_RBD) +=3D rbd.o
>     >  block-obj-$(CONFIG_GLUSTERFS) +=3D gluster.o
>     > +block-obj-$(CONFIG_VXHS) +=3D vxhs.o
>     >  block-obj-$(CONFIG_ARCHIPELAGO) +=3D archipelago.o
>     >  block-obj-$(CONFIG_LIBSSH2) +=3D ssh.o
>     >  block-obj-y +=3D accounting.o dirty-bitmap.o
>     > @@ -39,6 +40,7 @@ rbd.o-cflags       :=3D $(RBD_CFLAGS)
>     >  rbd.o-libs         :=3D $(RBD_LIBS)
>     >  gluster.o-cflags   :=3D $(GLUSTERFS_CFLAGS)
>     >  gluster.o-libs     :=3D $(GLUSTERFS_LIBS)
>     > +vxhs.o-libs        :=3D $(VXHS_LIBS)
>     >  ssh.o-cflags       :=3D $(LIBSSH2_CFLAGS)
>     >  ssh.o-libs         :=3D $(LIBSSH2_LIBS)
>     >  archipelago.o-libs :=3D $(ARCHIPELAGO_LIBS)
>     > diff --git a/block/trace-events b/block/trace-events
>     > index 0bc5c0a..d5eca93 100644
>     > --- a/block/trace-events
>     > +++ b/block/trace-events
>     > @@ -110,3 +110,19 @@ qed_aio_write_data(void *s, void *acb, int ret=
, uint64_t offset, size_t len) "s
>     >  qed_aio_write_prefill(void *s, void *acb, uint64_t start, size_t l=
en, uint64_t offset) "s %p acb %p start %"PRIu64" len %zu offset %"PRIu64
>     >  qed_aio_write_postfill(void *s, void *acb, uint64_t start, size_t =
len, uint64_t offset) "s %p acb %p start %"PRIu64" len %zu offset %"PRIu64
>     >  qed_aio_write_main(void *s, void *acb, int ret, uint64_t offset, s=
ize_t len) "s %p acb %p ret %d offset %"PRIu64" len %zu"
>     > +
>     > +# block/vxhs.c
>     > +vxhs_iio_callback(int error) "ctx is NULL: error %d"
>     > +vxhs_iio_callback_chnfail(int err, int error) "QNIO channel failed=
, no i/o %d, %d"
>     > +vxhs_iio_callback_unknwn(int opcode, int err) "unexpected opcode %=
d, errno %d"
>     > +vxhs_aio_rw_invalid(int req) "Invalid I/O request iodir %d"
>     > +vxhs_aio_rw_ioerr(char *guid, int iodir, uint64_t size, uint64_t o=
ff, void *acb, int ret, int err) "IO ERROR (vDisk %s) FOR : Read/Write =3D =
%d size =3D %lu offset =3D %lu ACB =3D %p. Error =3D %d, errno =3D %d"
>     > +vxhs_get_vdisk_stat_err(char *guid, int ret, int err) "vDisk (%s) =
stat ioctl failed, ret =3D %d, errno =3D %d"
>     > +vxhs_get_vdisk_stat(char *vdisk_guid, uint64_t vdisk_size) "vDisk =
%s stat ioctl returned size %lu"
>     > +vxhs_qnio_iio_open(const char *ip) "Failed to connect to storage a=
gent on host-ip %s"
>     > +vxhs_complete_aio(void *acb, uint64_t ret) "aio failed acb %p ret =
%ld"
>     > +vxhs_parse_uri_filename(const char *filename) "URI passed via bdrv=
_parse_filename %s"
>     > +vxhs_qemu_init_vdisk(const char *vdisk_id) "vdisk-id from json %s"
>     > +vxhs_parse_uri_hostinfo(int num, char *host, int port) "Host %d: I=
P %s, Port %d"
>     > +vxhs_qemu_init(char *of_vsa_addr, int port) "Adding host %s:%d to =
BDRVVXHSState"
>     > +vxhs_close(char *vdisk_guid) "Closing vdisk %s"
>     > diff --git a/block/vxhs.c b/block/vxhs.c
>     > new file mode 100644
>     > index 0000000..997474b
>     > --- /dev/null
>     > +++ b/block/vxhs.c
>     > @@ -0,0 +1,488 @@
>     > +/*
>     > + * QEMU Block driver for Veritas HyperScale (VxHS)
>     > + *
>     > + * This work is licensed under the terms of the GNU GPL, version 2=
 or later.
>     > + * See the COPYING file in the top-level directory.
>     > + *
>     > + */
>     > +
>     > +#include "qemu/osdep.h"
>     > +#include <qnio/qnio_api.h>
>     > +#include <sys/param.h>
>     > +#include "block/block_int.h"
>     > +#include "qapi/qmp/qerror.h"
>     > +#include "qapi/qmp/qdict.h"
>     > +#include "qapi/qmp/qstring.h"
>     > +#include "trace.h"
>     > +#include "qemu/uri.h"
>     > +#include "qapi/error.h"
>     > +#include "qemu/uuid.h"
>     > +
>     > +#define VXHS_OPT_FILENAME           "filename"
>     > +#define VXHS_OPT_VDISK_ID           "vdisk-id"
>     > +#define VXHS_OPT_SERVER             "server"
>     > +#define VXHS_OPT_HOST               "host"
>     > +#define VXHS_OPT_PORT               "port"
>     > +
>     > +static int lib_init_failed;
>     > +
>     > +typedef enum {
>     > +    VDISK_AIO_READ,
>     > +    VDISK_AIO_WRITE,
>     > +} VDISKAIOCmd;
>     > +
>     > +/*
>     > + * HyperScale AIO callbacks structure
>     > + */
>     > +typedef struct VXHSAIOCB {
>     > +    BlockAIOCB common;
>     > +    int err;
>     > +    QEMUIOVector *qiov;
>     > +} VXHSAIOCB;
>     > +
>     > +typedef struct VXHSvDiskHostsInfo {
>     > +    void *dev_handle; /* Device handle */
>     > +    char *host; /* Host name or IP */
>     > +    int port; /* Host's port number */
>     > +} VXHSvDiskHostsInfo;
>     > +
>     > +/*
>     > + * Structure per vDisk maintained for state
>     > + */
>     > +typedef struct BDRVVXHSState {
>     > +    VXHSvDiskHostsInfo vdisk_hostinfo; /* Per host info */
>     > +    char *vdisk_guid;
>     > +} BDRVVXHSState;
>     > +
>     > +static void vxhs_complete_aio_bh(void *opaque)
>     > +{
>     > +    VXHSAIOCB *acb =3D opaque;
>     > +    BlockCompletionFunc *cb =3D acb->common.cb;
>     > +    void *cb_opaque =3D acb->common.opaque;
>     > +    int ret =3D 0;
>     > +
>     > +    if (acb->err !=3D 0) {
>     > +        trace_vxhs_complete_aio(acb, acb->err);
>     > +        ret =3D (-EIO);
>     > +    }
>     > +
>     > +    qemu_aio_unref(acb);
>     > +    cb(cb_opaque, ret);
>     > +}
>     > +
>     > +/*
>     > + * Called from a libqnio thread
>     > + */
>     > +static void vxhs_iio_callback(void *ctx, uint32_t opcode, uint32_t=
 error)
>     > +{
>     > +    VXHSAIOCB *acb =3D NULL;
>     > +
>     > +    switch (opcode) {
>     > +    case IRP_READ_REQUEST:
>     > +    case IRP_WRITE_REQUEST:
>     > +
>     > +        /*
>     > +         * ctx is VXHSAIOCB*
>     > +         * ctx is NULL if error is QNIOERROR_CHANNEL_HUP
>     > +         */
>     > +        if (ctx) {
>     > +            acb =3D ctx;
>     > +        } else {
>     > +            trace_vxhs_iio_callback(error);
>     > +            goto out;
>     > +        }
>     > +
>     > +        if (error) {
>     > +            if (!acb->err) {
>     > +                acb->err =3D error;
>     > +            }
>     > +            trace_vxhs_iio_callback(error);
>     > +        }
>     > +
>     > +        aio_bh_schedule_oneshot(bdrv_get_aio_context(acb->common.b=
s),
>     > +                                vxhs_complete_aio_bh, acb);
>     > +        break;
>     > +
>     > +    default:
>     > +        if (error =3D=3D QNIOERROR_HUP) {
>     > +            /*
>     > +             * Channel failed, spontaneous notification,
>     > +             * not in response to I/O
>     > +             */
>     > +            trace_vxhs_iio_callback_chnfail(error, errno);
>     > +        } else {
>     > +            trace_vxhs_iio_callback_unknwn(opcode, error);
>     > +        }
>     > +        break;
>     > +    }
>     > +out:
>     > +    return;
>     > +}
>     > +
>     > +static QemuOptsList runtime_opts =3D {
>     > +    .name =3D "vxhs",
>     > +    .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
>     > +    .desc =3D {
>     > +        {
>     > +            .name =3D VXHS_OPT_FILENAME,
>     > +            .type =3D QEMU_OPT_STRING,
>     > +            .help =3D "URI to the Veritas HyperScale image",
>     > +        },
>     > +        {
>     > +            .name =3D VXHS_OPT_VDISK_ID,
>     > +            .type =3D QEMU_OPT_STRING,
>     > +            .help =3D "UUID of the VxHS vdisk",
>     > +        },
>     > +        { /* end of list */ }
>     > +    },
>     > +};
>     > +
>     > +static QemuOptsList runtime_tcp_opts =3D {
>     > +    .name =3D "vxhs_tcp",
>     > +    .head =3D QTAILQ_HEAD_INITIALIZER(runtime_tcp_opts.head),
>     > +    .desc =3D {
>     > +        {
>     > +            .name =3D VXHS_OPT_HOST,
>     > +            .type =3D QEMU_OPT_STRING,
>     > +            .help =3D "host address (ipv4 addresses)",
>     > +        },
>     > +        {
>     > +            .name =3D VXHS_OPT_PORT,
>     > +            .type =3D QEMU_OPT_NUMBER,
>     > +            .help =3D "port number on which VxHSD is listening (de=
fault 9999)",
>     > +            .def_value_str =3D "9999"
>     > +        },
>     > +        { /* end of list */ }
>     > +    },
>     > +};
>     > +
>     > +/*
>     > + * Parse the incoming URI and populate *options with the host info=
rmation.
>     > + * URI syntax has the limitation of supporting only one host info.
>     > + * To pass multiple host information, use the JSON syntax.
>     > + */
>     > +static int vxhs_parse_uri(const char *filename, QDict *options)
>     > +{
>     > +    URI *uri =3D NULL;
>     > +    char *hoststr, *portstr;
>     > +    char *port;
>     > +    int ret =3D 0;
>     > +
>     > +    trace_vxhs_parse_uri_filename(filename);
>     > +    uri =3D uri_parse(filename);
>     > +    if (!uri || !uri->server || !uri->path) {
>     > +        uri_free(uri);
>     > +        return -EINVAL;
>     > +    }
>     > +
>     > +    hoststr =3D g_strdup(VXHS_OPT_SERVER".host");
>     > +    qdict_put(options, hoststr, qstring_from_str(uri->server));
>     > +    g_free(hoststr);
>     > +
>     > +    portstr =3D g_strdup(VXHS_OPT_SERVER".port");
>     > +    if (uri->port) {
>     > +        port =3D g_strdup_printf("%d", uri->port);
>     > +        qdict_put(options, portstr, qstring_from_str(port));
>     > +        g_free(port);
>     > +    }
>     > +    g_free(portstr);
>     > +
>     > +    if (strstr(uri->path, "vxhs") =3D=3D NULL) {
>     > +        qdict_put(options, "vdisk-id", qstring_from_str(uri->path)=
);
>     > +    }
>     > +
>     > +    trace_vxhs_parse_uri_hostinfo(1, uri->server, uri->port);
>     > +    uri_free(uri);
>     > +
>     > +    return ret;
>     > +}
>     > +
>     > +static void vxhs_parse_filename(const char *filename, QDict *optio=
ns,
>     > +                                Error **errp)
>     > +{
>     > +    if (qdict_haskey(options, "vdisk-id") || qdict_haskey(options,=
 "server")) {
>     > +        error_setg(errp, "vdisk-id/server and a file name may not =
be specified "
>     > +                         "at the same time");
>     > +        return;
>     > +    }
>     > +
>     > +    if (strstr(filename, "://")) {
>     > +        int ret =3D vxhs_parse_uri(filename, options);
>     > +        if (ret < 0) {
>     > +            error_setg(errp, "Invalid URI. URI should be of the fo=
rm "
>     > +                       "  vxhs://<host_ip>:<port>/<vdisk-id>");
>     > +        }
>     > +    }
>     > +}
>     > +
>     > +static int vxhs_open(BlockDriverState *bs, QDict *options,
>     > +                     int bdrv_flags, Error **errp)
>     > +{
>     > +    BDRVVXHSState *s =3D bs->opaque;
>     > +    void *dev_handlep =3D NULL;
>     > +    QDict *backing_options =3D NULL;
>     > +    QemuOpts *opts, *tcp_opts;
>     > +    char *of_vsa_addr =3D NULL;
>     > +    Error *local_err =3D NULL;
>     > +    const char *vdisk_id_opt;
>     > +    const char *server_host_opt;
>     > +    char *str =3D NULL;
>     > +    int ret =3D 0;
>     > +
>     > +    if (lib_init_failed) {
>     > +        return -ENODEV;
>     > +    }
>     > +    opts =3D qemu_opts_create(&runtime_opts, NULL, 0, &error_abort=
);
>     > +    qemu_opts_absorb_qdict(opts, options, &local_err);
>     > +    if (local_err) {
>     > +        ret =3D -EINVAL;
>     > +        goto out;
>     > +    }
>     > +
>     > +    /* vdisk-id is the disk UUID */
>     > +    vdisk_id_opt =3D qemu_opt_get(opts, VXHS_OPT_VDISK_ID);
>     > +    if (!vdisk_id_opt) {
>     > +        error_setg(&local_err, QERR_MISSING_PARAMETER, VXHS_OPT_VD=
ISK_ID);
>     > +        ret =3D -EINVAL;
>     > +        goto out;
>     > +    }
>     > +
>     > +    /* vdisk-id may contain a leading '/' */
>     > +    if (strlen(vdisk_id_opt) > UUID_FMT_LEN + 1) {
>     > +        error_setg(errp, "vdisk-id cannot be more than %d characte=
rs",
>     > +                   UUID_FMT_LEN);
>     > +        ret =3D -EINVAL;
>     > +        goto out;
>     > +    }
>     > +
>     > +    s->vdisk_guid =3D g_strdup(vdisk_id_opt);
>     > +    trace_vxhs_qemu_init_vdisk(vdisk_id_opt);
>     > +
>     > +    str =3D g_strdup_printf(VXHS_OPT_SERVER".");
>     > +    qdict_extract_subqdict(options, &backing_options, str);
>     > +
>     > +    /* Create opts info from runtime_tcp_opts list */
>     > +    tcp_opts =3D qemu_opts_create(&runtime_tcp_opts, NULL, 0, &err=
or_abort);
>     > +    qemu_opts_absorb_qdict(tcp_opts, backing_options, &local_err);
>     > +    if (local_err) {
>     > +        qdict_del(backing_options, str);
>     > +        qemu_opts_del(tcp_opts);
>     > +        ret =3D -EINVAL;
>     > +        goto out;
>     > +    }
>     > +
>     > +    server_host_opt =3D qemu_opt_get(tcp_opts, VXHS_OPT_HOST);
>     > +    if (!server_host_opt) {
>     > +        error_setg(&local_err, QERR_MISSING_PARAMETER,
>     > +                   VXHS_OPT_SERVER"."VXHS_OPT_HOST);
>     > +        ret =3D -EINVAL;
>     > +        goto out;
>     > +    }
>     > +
>     > +    if (strlen(server_host_opt) > MAXHOSTNAMELEN) {
>     > +        error_setg(errp, "server.host cannot be more than %d chara=
cters",
>     > +                   MAXHOSTNAMELEN);
>     > +        ret =3D -EINVAL;
>     > +        goto out;
>     > +    }
>     > +
>     > +    s->vdisk_hostinfo.host =3D g_strdup(server_host_opt);
>     > +
>     > +    s->vdisk_hostinfo.port =3D g_ascii_strtoll(qemu_opt_get(tcp_op=
ts,
>     > +                                                          VXHS_OPT=
_PORT),
>     > +                                                          NULL, 0)=
;
>     > +
>     > +    trace_vxhs_qemu_init(s->vdisk_hostinfo.host,
>     > +                         s->vdisk_hostinfo.port);
>     > +
>     > +    qdict_del(backing_options, str);
>     > +    qemu_opts_del(tcp_opts);
>     > +
>     > +    of_vsa_addr =3D g_strdup_printf("of://%s:%d",
>     > +                                s->vdisk_hostinfo.host,
>     > +                                s->vdisk_hostinfo.port);
>     > +
>     > +    /*
>     > +     * Open qnio channel to storage agent if not opened before.
>     > +     */
>     > +    dev_handlep =3D iio_open(of_vsa_addr, s->vdisk_guid, 0);
>     > +    if (dev_handlep =3D=3D NULL) {
>     > +        trace_vxhs_qnio_iio_open(of_vsa_addr);
>     > +        ret =3D -ENODEV;
>     > +        goto out;
>     > +    }
>     > +    s->vdisk_hostinfo.dev_handle =3D dev_handlep;
>     > +
>     > +out:
>     > +    g_free(str);
>     > +    g_free(of_vsa_addr);
>     > +    QDECREF(backing_options);
>     > +    qemu_opts_del(opts);
>     > +
>     > +    if (ret < 0) {
>     > +        error_propagate(errp, local_err);
>     > +        g_free(s->vdisk_hostinfo.host);
>     > +        g_free(s->vdisk_guid);
>     > +        s->vdisk_guid =3D NULL;
>     > +        errno =3D -ret;
>     > +    }
>     > +
>     > +    return ret;
>     > +}
>     > +
>     > +static const AIOCBInfo vxhs_aiocb_info =3D {
>     > +    .aiocb_size =3D sizeof(VXHSAIOCB)
>     > +};
>     > +
>     > +/*
>     > + * This allocates QEMU-VXHS callback for each IO
>     > + * and is passed to QNIO. When QNIO completes the work,
>     > + * it will be passed back through the callback.
>     > + */
>     > +static BlockAIOCB *vxhs_aio_rw(BlockDriverState *bs, int64_t secto=
r_num,
>     > +                               QEMUIOVector *qiov, int nb_sectors,
>     > +                               BlockCompletionFunc *cb, void *opaq=
ue,
>     > +                               VDISKAIOCmd iodir)
>     > +{
>     > +    VXHSAIOCB *acb =3D NULL;
>     > +    BDRVVXHSState *s =3D bs->opaque;
>     > +    size_t size;
>     > +    uint64_t offset;
>     > +    int iio_flags =3D 0;
>     > +    int ret =3D 0;
>     > +    void *dev_handle =3D s->vdisk_hostinfo.dev_handle;
>     > +
>     > +    offset =3D sector_num * BDRV_SECTOR_SIZE;
>     > +    size =3D nb_sectors * BDRV_SECTOR_SIZE;
>     > +    acb =3D qemu_aio_get(&vxhs_aiocb_info, bs, cb, opaque);
>     > +
>     > +    /*
>     > +     * Initialize VXHSAIOCB.
>     > +     */
>     > +    acb->err =3D 0;
>     > +    acb->qiov =3D qiov;
>     > +
>     > +    iio_flags =3D IIO_FLAG_ASYNC;
>     > +
>     > +    switch (iodir) {
>     > +    case VDISK_AIO_WRITE:
>     > +            ret =3D iio_writev(dev_handle, acb, qiov->iov, qiov->n=
iov,
>     > +                             offset, (uint64_t)size, iio_flags);
>     > +            break;
>     > +    case VDISK_AIO_READ:
>     > +            ret =3D iio_readv(dev_handle, acb, qiov->iov, qiov->ni=
ov,
>     > +                            offset, (uint64_t)size, iio_flags);
>     > +            break;
>     > +    default:
>     > +            trace_vxhs_aio_rw_invalid(iodir);
>     > +            goto errout;
>     > +    }
>     > +
>     > +    if (ret !=3D 0) {
>     > +        trace_vxhs_aio_rw_ioerr(s->vdisk_guid, iodir, size, offset=
,
>     > +                                acb, ret, errno);
>     > +        goto errout;
>     > +    }
>     > +    return &acb->common;
>     > +
>     > +errout:
>     > +    qemu_aio_unref(acb);
>     > +    return NULL;
>     > +}
>     > +
>     > +static BlockAIOCB *vxhs_aio_readv(BlockDriverState *bs,
>     > +                                   int64_t sector_num, QEMUIOVecto=
r *qiov,
>     > +                                   int nb_sectors,
>     > +                                   BlockCompletionFunc *cb, void *=
opaque)
>     > +{
>     > +    return vxhs_aio_rw(bs, sector_num, qiov, nb_sectors, cb,
>     > +                       opaque, VDISK_AIO_READ);
>     > +}
>     > +
>     > +static BlockAIOCB *vxhs_aio_writev(BlockDriverState *bs,
>     > +                                   int64_t sector_num, QEMUIOVecto=
r *qiov,
>     > +                                   int nb_sectors,
>     > +                                   BlockCompletionFunc *cb, void *=
opaque)
>     > +{
>     > +    return vxhs_aio_rw(bs, sector_num, qiov, nb_sectors,
>     > +                       cb, opaque, VDISK_AIO_WRITE);
>     > +}
>     > +
>     > +static void vxhs_close(BlockDriverState *bs)
>     > +{
>     > +    BDRVVXHSState *s =3D bs->opaque;
>     > +
>     > +    trace_vxhs_close(s->vdisk_guid);
>     > +
>     > +    g_free(s->vdisk_guid);
>     > +    s->vdisk_guid =3D NULL;
>     > +
>     > +    /*
>     > +     * Close vDisk device
>     > +     */
>     > +    if (s->vdisk_hostinfo.dev_handle) {
>     > +        iio_close(s->vdisk_hostinfo.dev_handle);
>     > +        s->vdisk_hostinfo.dev_handle =3D NULL;
>     > +    }
>     > +
>     > +    /*
>     > +     * Free the dynamically allocated host string
>     > +     */
>     > +    g_free(s->vdisk_hostinfo.host);
>     > +    s->vdisk_hostinfo.host =3D NULL;
>     > +    s->vdisk_hostinfo.port =3D 0;
>     > +}
>     > +
>     > +static int64_t vxhs_get_vdisk_stat(BDRVVXHSState *s)
>     > +{
>     > +    int64_t vdisk_size =3D -1;
>     > +    int ret =3D 0;
>     > +    void *dev_handle =3D s->vdisk_hostinfo.dev_handle;
>     > +
>     > +    ret =3D iio_ioctl(dev_handle, IOR_VDISK_STAT, &vdisk_size, 0);
>     > +    if (ret < 0) {
>     > +        trace_vxhs_get_vdisk_stat_err(s->vdisk_guid, ret, errno);
>     > +        return -EIO;
>     > +    }
>     > +
>     > +    trace_vxhs_get_vdisk_stat(s->vdisk_guid, vdisk_size);
>     > +    return vdisk_size;
>     > +}
>     > +
>     > +/*
>     > + * Returns the size of vDisk in bytes. This is required
>     > + * by QEMU block upper block layer so that it is visible
>     > + * to guest.
>     > + */
>     > +static int64_t vxhs_getlength(BlockDriverState *bs)
>     > +{
>     > +    BDRVVXHSState *s =3D bs->opaque;
>     > +    int64_t vdisk_size;
>     > +
>     > +    vdisk_size =3D vxhs_get_vdisk_stat(s);
>     > +    if (vdisk_size < 0) {
>     > +        return -EIO;
>     > +    }
>     > +
>     > +    return vdisk_size;
>     > +}
>     > +
>     > +static BlockDriver bdrv_vxhs =3D {
>     > +    .format_name                  =3D "vxhs",
>     > +    .protocol_name                =3D "vxhs",
>     > +    .instance_size                =3D sizeof(BDRVVXHSState),
>     > +    .bdrv_file_open               =3D vxhs_open,
>     > +    .bdrv_parse_filename          =3D vxhs_parse_filename,
>     > +    .bdrv_close                   =3D vxhs_close,
>     > +    .bdrv_getlength               =3D vxhs_getlength,
>     > +    .bdrv_aio_readv               =3D vxhs_aio_readv,
>     > +    .bdrv_aio_writev              =3D vxhs_aio_writev,
>     > +};
>     > +
>     > +static void bdrv_vxhs_init(void)
>     > +{
>     > +    lib_init_failed =3D iio_init(QNIO_VERSION, vxhs_iio_callback);
>     > +    bdrv_register(&bdrv_vxhs);
>     > +}
>     > +
>     > +block_init(bdrv_vxhs_init);
>     > diff --git a/configure b/configure
>     > index 6325339..ba9ad0a 100755
>     > --- a/configure
>     > +++ b/configure
>     > @@ -321,6 +321,7 @@ numa=3D""
>     >  tcmalloc=3D"no"
>     >  jemalloc=3D"no"
>     >  replication=3D"yes"
>     > +vxhs=3D""
>     >
>     >  # parse CC options first
>     >  for opt do
>     > @@ -1170,6 +1171,10 @@ for opt do
>     >    ;;
>     >    --enable-replication) replication=3D"yes"
>     >    ;;
>     > +  --disable-vxhs) vxhs=3D"no"
>     > +  ;;
>     > +  --enable-vxhs) vxhs=3D"yes"
>     > +  ;;
>     >    *)
>     >        echo "ERROR: unknown option $opt"
>     >        echo "Try '$0 --help' for more information"
>     > @@ -1403,6 +1408,7 @@ disabled with --disable-FEATURE, default is e=
nabled if available:
>     >    tcmalloc        tcmalloc support
>     >    jemalloc        jemalloc support
>     >    replication     replication support
>     > +  vxhs            Veritas HyperScale vDisk backend support
>     >
>     >  NOTE: The object files are built at the place where configure is l=
aunched
>     >  EOF
>     > @@ -4748,6 +4754,33 @@ if test "$modules" =3D "yes" && test "$LD_RE=
L_FLAGS" =3D ""; then
>     >  fi
>     >
>     >  ##########################################
>     > +# Veritas HyperScale block driver VxHS
>     > +# Check if libqnio is installed
>     > +
>     > +if test "$vxhs" !=3D "no" ; then
>     > +  cat > $TMPC <<EOF
>     > +#include <stdint.h>
>     > +#include <qnio/qnio_api.h>
>     > +
>     > +void *vxhs_callback;
>     > +
>     > +int main(void) {
>     > +    iio_init(QNIO_VERSION, vxhs_callback);
>     > +    return 0;
>     > +}
>     > +EOF
>     > +  vxhs_libs=3D"-lqnio"
>     > +  if compile_prog "" "$vxhs_libs" ; then
>     > +    vxhs=3Dyes
>     > +  else
>     > +    if test "$vxhs" =3D "yes" ; then
>     > +      feature_not_found "vxhs block device" "Install libqnio See g=
ithub"
>     > +    fi
>     > +    vxhs=3Dno
>     > +  fi
>     > +fi
>     > +
>     > +##########################################
>     >  # End of CC checks
>     >  # After here, no more $cc or $ld runs
>     >
>     > @@ -5114,6 +5147,7 @@ echo "tcmalloc support  $tcmalloc"
>     >  echo "jemalloc support  $jemalloc"
>     >  echo "avx2 optimization $avx2_opt"
>     >  echo "replication support $replication"
>     > +echo "VxHS block device $vxhs"
>     >
>     >  if test "$sdl_too_old" =3D "yes"; then
>     >  echo "-> Your SDL version is too old - please upgrade to have SDL =
support"
>     > @@ -5729,6 +5763,12 @@ if test "$pthread_setname_np" =3D "yes" ; th=
en
>     >    echo "CONFIG_PTHREAD_SETNAME_NP=3Dy" >> $config_host_mak
>     >  fi
>     >
>     > +if test "$vxhs" =3D "yes" ; then
>     > +  echo "CONFIG_VXHS=3Dy" >> $config_host_mak
>     > +  echo "VXHS_CFLAGS=3D$vxhs_cflags" >> $config_host_mak
>     > +  echo "VXHS_LIBS=3D$vxhs_libs" >> $config_host_mak
>     > +fi
>     > +
>     >  if test "$tcg_interpreter" =3D "yes"; then
>     >    QEMU_INCLUDES=3D"-I\$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
>     >  elif test "$ARCH" =3D "sparc64" ; then
>     > diff --git a/qapi/block-core.json b/qapi/block-core.json
>     > index 932f5bb..f37df56 100644
>     > --- a/qapi/block-core.json
>     > +++ b/qapi/block-core.json
>     > @@ -2110,6 +2110,7 @@
>     >  # @nfs: Since 2.8
>     >  # @replication: Since 2.8
>     >  # @ssh: Since 2.8
>     > +# @vxhs: Since 2.9
>     >  #
>     >  # Since: 2.0
>     >  ##
>     > @@ -2119,7 +2120,7 @@
>     >              'host_device', 'http', 'https', 'luks', 'nbd', 'nfs', =
'null-aio',
>     >              'null-co', 'parallels', 'qcow', 'qcow2', 'qed', 'quoru=
m', 'raw',
>     >              'replication', 'ssh', 'vdi', 'vhdx', 'vmdk', 'vpc',
>     > -            'vvfat' ] }
>     > +            'vvfat','vxhs' ] }
>     >
>     >  ##
>     >  # @BlockdevOptionsFile:
>     > @@ -2744,6 +2745,20 @@
>     >    'data': { '*offset': 'int', '*size': 'int' } }
>     >
>     >  ##
>     > +# @BlockdevOptionsVxHS:
>     > +#
>     > +# Driver specific block device options for VxHS
>     > +#
>     > +# @vdisk-id:    UUID of VxHS volume
>     > +# @server:      vxhs server IP, port
>     > +#
>     > +# Since: 2.9
>     > +##
>     > +{ 'struct': 'BlockdevOptionsVxHS',
>     > +  'data': { 'vdisk-id': 'str',
>     > +            'server': 'InetSocketAddress' } }
>     > +
>     > +##
>     >  # @BlockdevOptions:
>     >  #
>     >  # Options for creating a block device.  Many options are available=
 for all
>     > @@ -2806,7 +2821,8 @@
>     >        'vhdx':       'BlockdevOptionsGenericFormat',
>     >        'vmdk':       'BlockdevOptionsGenericCOWFormat',
>     >        'vpc':        'BlockdevOptionsGenericFormat',
>     > -      'vvfat':      'BlockdevOptionsVVFAT'
>     > +      'vvfat':      'BlockdevOptionsVVFAT',
>     > +      'vxhs':       'BlockdevOptionsVxHS'
>     >    } }
>     >
>     >  ##
>     > --
>     > 1.8.3.1
>     >
>
>

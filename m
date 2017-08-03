Received: from eggs.gnu.org ([2001:4830:134:3::10]:43765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1ddEdO-0008VQ-Vf
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 07:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1ddEdM-0001Xi-8P
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 07:49:47 -0400
Date: Thu, 3 Aug 2017 14:48:56 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170803114856.ardy4zn24yanjhlj@postretch>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-6-el13635@mail.ntua.gr>
	<20170803080741.GA4456@dhcp-200-186.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5rf3fgllfyglsh5i"
Content-Disposition: inline
In-Reply-To: <20170803080741.GA4456@dhcp-200-186.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] block: add throttle block filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--5rf3fgllfyglsh5i
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2017 at 10:07:41AM +0200, Kevin Wolf wrote:
>Am 31.07.2017 um 11:54 hat Manos Pitsidianakis geschrieben:
>> +/* Extract ThrottleConfig options. Assumes cfg is initialized and will =
be
>> + * checked for validity.
>> + */
>> +static int throttle_extract_options(QemuOpts *opts, ThrottleConfig *cfg,
>> +                                     Error **errp)
>> +{
>> +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL)) {
>> +        cfg->buckets[THROTTLE_BPS_TOTAL].avg =3D
>> +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_=
TOTAL,
>> +                                0);
>> +    }
>> +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ)) {
>> +        cfg->buckets[THROTTLE_BPS_READ].avg  =3D
>> +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_=
READ,
>> +                                0);
>> +    }
>> +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE)) {
>> +        cfg->buckets[THROTTLE_BPS_WRITE].avg =3D
>> +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_=
WRITE,
>> +                                0);
>> +    }
>> +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL)) {
>> +        cfg->buckets[THROTTLE_OPS_TOTAL].avg =3D
>> +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS=
_TOTAL,
>> +                                0);
>> +    }
>> +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ)) {
>> +        cfg->buckets[THROTTLE_OPS_READ].avg =3D
>> +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS=
_READ,
>> +                                0);
>> +    }
>> +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE)) {
>> +        cfg->buckets[THROTTLE_OPS_WRITE].avg =3D
>> +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS=
_WRITE,
>> +                                0);
>> +    }
>> +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL_MAX))=
 {
>> +        cfg->buckets[THROTTLE_BPS_TOTAL].max =3D
>> +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
>> +                                QEMU_OPT_BPS_TOTAL_MAX, 0);
>> +    }
>> +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ_MAX)) {
>> +        cfg->buckets[THROTTLE_BPS_READ].max  =3D
>> +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
>> +                                QEMU_OPT_BPS_READ_MAX, 0);
>> +    }
>> +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE_MAX))=
 {
>> +        cfg->buckets[THROTTLE_BPS_WRITE].max =3D
>> +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
>> +                                QEMU_OPT_BPS_WRITE_MAX, 0);
>> +    }
>> +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL_MAX)=
) {
>> +        cfg->buckets[THROTTLE_OPS_TOTAL].max =3D
>> +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
>> +                                QEMU_OPT_IOPS_TOTAL_MAX, 0);
>> +    }
>> +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ_MAX))=
 {
>> +        cfg->buckets[THROTTLE_OPS_READ].max =3D
>> +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
>> +                                QEMU_OPT_IOPS_READ_MAX, 0);
>> +    }
>> +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE_MAX)=
) {
>> +        cfg->buckets[THROTTLE_OPS_WRITE].max =3D
>> +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
>> +                                QEMU_OPT_IOPS_WRITE_MAX, 0);
>> +    }
>> +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL_MAX_L=
ENGTH)) {
>> +        if (qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
>> +                                QEMU_OPT_BPS_TOTAL_MAX_LENGTH, 1) > UIN=
T_MAX) {
>> +            error_setg(errp, "%s value must be in the range [0, %u]",
>> +                       THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL_MAX_LENGT=
H,
>> +                       UINT_MAX);
>> +            return -1;
>> +        }
>> +        cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =3D
>> +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
>> +                                QEMU_OPT_BPS_TOTAL_MAX_LENGTH, 1);
>> +    }
>> +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ_MAX_LE=
NGTH)) {
>> +        if (qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
>> +                                QEMU_OPT_BPS_READ_MAX_LENGTH, 1) > UINT=
_MAX) {
>> +            error_setg(errp, "%s must be in the range [0, %u]",
>> +                       THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ_MAX_LENGTH,
>> +                       UINT_MAX);
>> +            return -1;
>> +        }
>> +        cfg->buckets[THROTTLE_BPS_READ].burst_length  =3D
>> +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
>> +                                QEMU_OPT_BPS_READ_MAX_LENGTH, 1);
>> +    }
>> +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE_MAX_L=
ENGTH)) {
>> +        if (qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
>> +                                QEMU_OPT_BPS_WRITE_MAX_LENGTH, 1) > UIN=
T_MAX) {
>> +            error_setg(errp, "%s must be in the range [0, %u]",
>> +                       THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE_MAX_LENGT=
H,
>> +                       UINT_MAX);
>> +            return -1;
>> +        }
>> +        cfg->buckets[THROTTLE_BPS_WRITE].burst_length =3D
>> +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
>> +                                QEMU_OPT_BPS_WRITE_MAX_LENGTH, 1);
>> +    }
>> +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL_MAX_=
LENGTH)) {
>> +        if (qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
>> +                                QEMU_OPT_IOPS_TOTAL_MAX_LENGTH, 1) > UI=
NT_MAX) {
>> +            error_setg(errp, "%s must be in the range [0, %u]",
>> +                       THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL_MAX_LENG=
TH,
>> +                       UINT_MAX);
>> +            return -1;
>> +        }
>> +        cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =3D
>> +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
>> +                                QEMU_OPT_IOPS_TOTAL_MAX_LENGTH, 1);
>> +    }
>> +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ_MAX_L=
ENGTH)) {
>> +        if (qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
>> +                                QEMU_OPT_IOPS_READ_MAX_LENGTH, 1) > UIN=
T_MAX) {
>> +            error_setg(errp, "%s must be in the range [0, %u]",
>> +                       THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ_MAX_LENGT=
H,
>> +                       UINT_MAX);
>> +            return -1;
>> +        }
>> +        cfg->buckets[THROTTLE_OPS_READ].burst_length =3D
>> +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
>> +                                QEMU_OPT_IOPS_READ_MAX_LENGTH, 1);
>> +    }
>> +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE_MAX_=
LENGTH)) {
>> +        if (qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
>> +                                QEMU_OPT_IOPS_WRITE_MAX_LENGTH, 1) > UI=
NT_MAX) {
>> +            error_setg(errp, "%s must be in the range [0, %u]",
>> +                       THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE_MAX_LENG=
TH,
>> +                       UINT_MAX);
>> +            return -1;
>> +        }
>> +        cfg->buckets[THROTTLE_OPS_WRITE].burst_length =3D
>> +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
>> +                                QEMU_OPT_IOPS_WRITE_MAX_LENGTH, 1);
>> +    }
>> +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_SIZE)) {
>> +        cfg->op_size =3D
>> +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS=
_SIZE,
>> +                                0);
>> +    }
>> +    return 0;
>> +}
>
>This function is very repetitive, but each block is long enough that
>you have to look closely to review whether the right constants are used
>everywhere.
>
>Maybe this could become a bit more readable with a macro or two?

How about this?


#   #define IF_OPT_SET(rvalue,opt_name) \
#       if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX opt_name)) { \
#           rvalue =3D qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX opt_na=
me, 0); }=20

#       IF_OPT_SET(cfg->buckets[THROTTLE_BPS_TOTAL].avg, QEMU_OPT_BPS_TOTAL=
);
#       IF_OPT_SET(cfg->buckets[THROTTLE_BPS_READ].avg, QEMU_OPT_BPS_READ);
#       IF_OPT_SET(cfg->buckets[THROTTLE_BPS_WRITE].avg, QEMU_OPT_BPS_WRITE=
);
#       IF_OPT_SET(cfg->buckets[THROTTLE_OPS_TOTAL].avg, QEMU_OPT_IOPS_TOTA=
L);
#       IF_OPT_SET(cfg->buckets[THROTTLE_OPS_READ].avg, QEMU_OPT_IOPS_READ);
#       IF_OPT_SET(cfg->buckets[THROTTLE_OPS_WRITE].avg, QEMU_OPT_IOPS_WRIT=
E);
#       IF_OPT_SET(cfg->buckets[THROTTLE_BPS_TOTAL].max, QEMU_OPT_BPS_TOTAL=
_MAX);
#       IF_OPT_SET(cfg->buckets[THROTTLE_BPS_READ].max , QEMU_OPT_BPS_READ_=
MAX);
#       IF_OPT_SET(cfg->buckets[THROTTLE_BPS_WRITE].max, QEMU_OPT_BPS_WRITE=
_MAX);
#       IF_OPT_SET(cfg->buckets[THROTTLE_OPS_TOTAL].max, QEMU_OPT_IOPS_TOTA=
L_MAX);
#       IF_OPT_SET(cfg->buckets[THROTTLE_OPS_READ].max, QEMU_OPT_IOPS_READ_=
MAX);
#       IF_OPT_SET(cfg->buckets[THROTTLE_OPS_WRITE].max, QEMU_OPT_IOPS_WRIT=
E_MAX);
#       IF_OPT_SET(cfg->op_size, QEMU_OPT_IOPS_SIZE);

#   #define IF_OPT_UINT_SET(rvalue,opt_name) \
#       if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX opt_name)) { \
#           if (qemu_opt_get_number(opts,  \
#                       THROTTLE_OPT_PREFIX opt_name, 1) > UINT_MAX) { \
#               error_setg(errp, "%s value must be in the range [0, %u]", \
#                          THROTTLE_OPT_PREFIX opt_name, UINT_MAX); \
#               return -1; \
#           } \
#           rvalue =3D qemu_opt_get_number(opts, opt_name, 1); \
#       }

#       IF_OPT_UINT_SET(cfg->buckets[THROTTLE_BPS_TOTAL].burst_length,
#                       QEMU_OPT_BPS_TOTAL_MAX_LENGTH);
#       IF_OPT_UINT_SET(cfg->buckets[THROTTLE_BPS_READ].burst_length,
#                       QEMU_OPT_BPS_READ_MAX_LENGTH);
#       IF_OPT_UINT_SET(cfg->buckets[THROTTLE_BPS_WRITE].burst_length,
#                       QEMU_OPT_BPS_WRITE_MAX_LENGTH);
#       IF_OPT_UINT_SET(cfg->buckets[THROTTLE_OPS_TOTAL].burst_length,
#                       QEMU_OPT_IOPS_TOTAL_MAX_LENGTH);
#       IF_OPT_UINT_SET(cfg->buckets[THROTTLE_OPS_READ].burst_length,
#                       QEMU_OPT_IOPS_READ_MAX_LENGTH);
#       IF_OPT_UINT_SET(cfg->buckets[THROTTLE_OPS_WRITE].burst_length,
#                       QEMU_OPT_IOPS_WRITE_MAX_LENGTH);



>> +static int throttle_configure_tgm(BlockDriverState *bs,
>> +                                  ThrottleGroupMember *tgm,
>> +                                  QDict *options, Error **errp)
>> +{
>> +    int ret;
>> +    ThrottleConfig cfg;
>> +    const char *group_name =3D NULL;
>> +    Error *local_err =3D NULL;
>> +    QemuOpts *opts =3D qemu_opts_create(&throttle_opts, NULL, 0, &local=
_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return -EINVAL;
>> +    }
>
>As Stefan said, qemu_opts_create() can't fail if you pass NULL for id,
>so you can just use &error_abort.
>
>> +
>> +    qemu_opts_absorb_qdict(opts, options, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        goto err;
>> +    }
>> +
>> +    /* If no name is specified, an anonymous group will be created */
>> +    group_name =3D qemu_opt_get(opts, QEMU_OPT_THROTTLE_GROUP_NAME);
>> +
>> +    /* Register membership to group with name group_name */
>> +    throttle_group_register_tgm(tgm, group_name, bdrv_get_aio_context(b=
s));
>
>The documentation of throttle_group_register_tgm() suggests that you
>have to pass a string here, but group_name can be NULL if the option
>wasn't given. Probably just means that the comment for that function
>needs to be updated.
>
>> +    /* Copy previous configuration */
>> +    throttle_group_get_config(tgm, &cfg);
>> +
>> +    /* Change limits if user has specified them */
>> +    if (throttle_extract_options(opts, &cfg, errp) ||
>> +        !throttle_is_valid(&cfg, errp)) {
>> +        throttle_group_unregister_tgm(tgm);
>> +        goto err;
>> +    }
>> +    /* Update group configuration */
>> +    throttle_group_config(tgm, &cfg);
>> +
>> +    ret =3D 0;
>> +    goto fin;
>> +
>> +err:
>> +    ret =3D -EINVAL;
>> +fin:
>> +    qemu_opts_del(opts);
>> +    return ret;
>> +}
>> +
>> +static int throttle_open(BlockDriverState *bs, QDict *options,
>> +                            int flags, Error **errp)
>> +{
>> +    ThrottleGroupMember *tgm =3D bs->opaque;
>> +
>> +    bs->file =3D bdrv_open_child(NULL, options, "file",
>> +                                    bs, &child_file, false, errp);
>
>Indentation is off.
>
>> +    if (!bs->file) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    return throttle_configure_tgm(bs, tgm, options, errp);
>> +}
>> +
>> +static void throttle_close(BlockDriverState *bs)
>> +{
>> +    ThrottleGroupMember *tgm =3D bs->opaque;
>> +    throttle_group_unregister_tgm(tgm);
>> +}
>> +
>> +
>> +static int64_t throttle_getlength(BlockDriverState *bs)
>> +{
>> +    return bdrv_getlength(bs->file->bs);
>> +}
>> +
>> +
>> +static int coroutine_fn throttle_co_preadv(BlockDriverState *bs,
>> +                                           uint64_t offset, uint64_t by=
tes,
>> +                                           QEMUIOVector *qiov, int flag=
s)
>> +{
>> +
>> +    ThrottleGroupMember *tgm =3D bs->opaque;
>> +    throttle_group_co_io_limits_intercept(tgm, bytes, false);
>> +
>> +    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
>> +}
>> +
>> +static int coroutine_fn throttle_co_pwritev(BlockDriverState *bs,
>> +                                            uint64_t offset, uint64_t b=
ytes,
>> +                                            QEMUIOVector *qiov, int fla=
gs)
>> +{
>> +    ThrottleGroupMember *tgm =3D bs->opaque;
>> +    throttle_group_co_io_limits_intercept(tgm, bytes, true);
>> +
>> +    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
>> +}
>
>I think we want to set BlockDriver.supported_write_flags so that passing
>down flags is actually of any use.

Can you explain what you mean? Do you mean doing this in=20
throttle_open():

    bs->supported_write_flags =3D bs->file->bs->supported_write_flags;
    bs->supported_zero_flags =3D bs->file->bs->supported_zero_flags;
>
>> +
>> +static int coroutine_fn throttle_co_pwrite_zeroes(BlockDriverState *bs,
>> +        int64_t offset, int bytes, BdrvRequestFlags flags)
>> +{
>> +    ThrottleGroupMember *tgm =3D bs->opaque;
>> +    throttle_group_co_io_limits_intercept(tgm, bytes, true);
>> +
>> +    return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
>> +}
>
>The same is true for BlockDriver.supported_zero_flags.
>
>> +static int coroutine_fn throttle_co_pdiscard(BlockDriverState *bs,
>> +        int64_t offset, int bytes)
>> +{
>> +    ThrottleGroupMember *tgm =3D bs->opaque;
>> +    throttle_group_co_io_limits_intercept(tgm, bytes, true);
>> +
>> +    return bdrv_co_pdiscard(bs->file->bs, offset, bytes);
>> +}
>> +
>> +static int throttle_co_flush(BlockDriverState *bs)
>> +{
>> +    return bdrv_co_flush(bs->file->bs);
>> +}
>> +
>> +static void throttle_detach_aio_context(BlockDriverState *bs)
>> +{
>> +    ThrottleGroupMember *tgm =3D bs->opaque;
>> +    throttle_group_detach_aio_context(tgm);
>> +}
>> +
>> +static void throttle_attach_aio_context(BlockDriverState *bs,
>> +                                    AioContext *new_context)
>
>Indentation is off here...
>
>> +{
>> +    ThrottleGroupMember *tgm =3D bs->opaque;
>> +    throttle_group_attach_aio_context(tgm, new_context);
>> +}
>> +
>> +static int throttle_reopen_prepare(BDRVReopenState *reopen_state,
>> +                                      BlockReopenQueue *queue, Error **=
errp)
>
>...and here.
>
>> +{
>> +    ThrottleGroupMember *tgm =3D NULL;
>> +
>> +    assert(reopen_state !=3D NULL);
>> +    assert(reopen_state->bs !=3D NULL);
>> +
>> +    reopen_state->opaque =3D g_new0(ThrottleGroupMember, 1);
>> +    tgm =3D reopen_state->opaque;
>> +
>> +    return throttle_configure_tgm(reopen_state->bs, tgm, reopen_state->=
options,
>> +            errp);
>> +}
>> +
>> +static void throttle_reopen_commit(BDRVReopenState *state)
>> +{
>> +    ThrottleGroupMember *tgm =3D state->bs->opaque;
>> +
>> +    throttle_group_unregister_tgm(tgm);
>> +    g_free(state->bs->opaque);
>> +    state->bs->opaque =3D state->opaque;
>> +    state->opaque =3D NULL;
>> +}
>> +
>> +static void throttle_reopen_abort(BDRVReopenState *state)
>> +{
>> +    ThrottleGroupMember *tgm =3D state->opaque;
>> +
>> +    throttle_group_unregister_tgm(tgm);
>> +    g_free(state->opaque);
>> +    state->opaque =3D NULL;
>> +}
>> +
>> +static bool throttle_recurse_is_first_non_filter(BlockDriverState *bs,
>> +                                                 BlockDriverState *cand=
idate)
>> +{
>> +    return bdrv_recurse_is_first_non_filter(bs->file->bs, candidate);
>> +}
>> +
>> +static BlockDriver bdrv_throttle =3D {
>> +    .format_name                        =3D   "throttle",
>> +    .protocol_name                      =3D   "throttle",
>> +    .instance_size                      =3D   sizeof(ThrottleGroupMembe=
r),
>> +
>> +    .bdrv_file_open                     =3D   throttle_open,
>> +    .bdrv_close                         =3D   throttle_close,
>> +    .bdrv_co_flush                      =3D   throttle_co_flush,
>> +
>> +    .bdrv_child_perm                    =3D   bdrv_filter_default_perms,
>> +
>> +    .bdrv_getlength                     =3D   throttle_getlength,
>> +
>> +    .bdrv_co_preadv                     =3D   throttle_co_preadv,
>> +    .bdrv_co_pwritev                    =3D   throttle_co_pwritev,
>> +
>> +    .bdrv_co_pwrite_zeroes              =3D   throttle_co_pwrite_zeroes,
>> +    .bdrv_co_pdiscard                   =3D   throttle_co_pdiscard,
>> +
>> +    .bdrv_recurse_is_first_non_filter   =3D   throttle_recurse_is_first=
_non_filter,
>> +
>> +    .bdrv_attach_aio_context            =3D   throttle_attach_aio_conte=
xt,
>> +    .bdrv_detach_aio_context            =3D   throttle_detach_aio_conte=
xt,
>> +
>> +    .bdrv_reopen_prepare                =3D   throttle_reopen_prepare,
>> +    .bdrv_reopen_commit                 =3D   throttle_reopen_commit,
>> +    .bdrv_reopen_abort                  =3D   throttle_reopen_abort,
>> +
>> +    .is_filter                          =3D   true,
>> +};
>
>What about .bdrv_co_get_block_status?

We should use the default implementation here that you merged into your=20
2.11 tree, thanks for noticing and for all the comments.
>
>> +static void bdrv_throttle_init(void)
>> +{
>> +    bdrv_register(&bdrv_throttle);
>> +}
>> +
>> +block_init(bdrv_throttle_init);
>> diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-opt=
ions.h
>> index 182b7896e1..3528a8f4a2 100644
>> --- a/include/qemu/throttle-options.h
>> +++ b/include/qemu/throttle-options.h
>> @@ -29,6 +29,7 @@
>>  #define QEMU_OPT_BPS_WRITE_MAX "bps-write-max"
>>  #define QEMU_OPT_BPS_WRITE_MAX_LENGTH "bps-write-max-length"
>>  #define QEMU_OPT_IOPS_SIZE "iops-size"
>> +#define QEMU_OPT_THROTTLE_GROUP_NAME "throttle-group"
>>
>>  #define THROTTLE_OPT_PREFIX "throttling."
>>  #define THROTTLE_OPTS \
>
>Kevin
>

--5rf3fgllfyglsh5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmDDacACgkQc2J8L2kN
9xAZDg/+KKnZGfUnu87UqcNnM03A/Ek9OEeSYbv5N9c35brcrrvmtc0Dp2s8kKgi
SHtz1gArTGK6JSbHyua0TZGgEdi5FPcQgfbGC1/TqmMXNCwzoOLWWW5s5qAGwEBM
1j3Ol+01g9eGR1lPjhGF3QO+ZEXm987TKs7+lIJYKDF09bAzX/UIA1DcVdqzBr82
uTKKhtoHxCEQVrKy7Ovv/l8nUDZB06jZfS1AV6dl2KOK6mWwM8tKgCqrMTvhdYzO
AoJnsYe7DANQ1QGwNb+Lnv+OUv/qP6HmRy9WJ3aT5Px5UI2vjfUwNeWyE5pcYVGd
vOzvE5OVbUWgNB/BGKJFbi1dPhdgPixKw+IXurg1GTUeZga8A5CY3yO3EVp0qqn7
fcQXNfp9m+LnZHh5P8LOnu8GkP0hR4XuG1qAujyZEbVkBAQ4U51AOUxl+r+rPaKw
YDRgVf1KvuKIDDXMAqEmi0TUibKzoaj6Cfsok33Gw/pljPQ8GsoIgmm6isBF2lUs
ZbrcAD5D1brok9/UVScEr4sixb3gRhmssxUIyWYWoX6rdR0r4qyB2WoMmJjh2ddh
A9MOCZQxMK/G5+xmCo5Z06IvyNFOH7Lfbt4ZCdQ2S9BG8Y+lC0SY39RtLy6tpD9m
rwaqZHfNkXEn71E7aWa/wKaSwNcNDqEqYO2pk5XYsswqAUl0BLY=
=SRu0
-----END PGP SIGNATURE-----

--5rf3fgllfyglsh5i--

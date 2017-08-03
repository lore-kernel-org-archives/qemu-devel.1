Received: from eggs.gnu.org ([2001:4830:134:3::10]:41343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ddEtB-0007A7-0V
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 08:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ddEt9-0001ae-Ms
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 08:06:05 -0400
Date: Thu, 3 Aug 2017 14:05:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170803120549.GH4456@dhcp-200-186.str.redhat.com>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-6-el13635@mail.ntua.gr>
	<20170803080741.GA4456@dhcp-200-186.str.redhat.com>
	<20170803114856.ardy4zn24yanjhlj@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline
In-Reply-To: <20170803114856.ardy4zn24yanjhlj@postretch>
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
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 03.08.2017 um 13:48 hat Manos Pitsidianakis geschrieben:
> On Thu, Aug 03, 2017 at 10:07:41AM +0200, Kevin Wolf wrote:
> > Am 31.07.2017 um 11:54 hat Manos Pitsidianakis geschrieben:
> > > +/* Extract ThrottleConfig options. Assumes cfg is initialized and wi=
ll be
> > > + * checked for validity.
> > > + */
> > > +static int throttle_extract_options(QemuOpts *opts, ThrottleConfig *=
cfg,
> > > +                                     Error **errp)
> > > +{
> > > +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL)) {
> > > +        cfg->buckets[THROTTLE_BPS_TOTAL].avg =3D
> > > +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX QEMU_OPT_B=
PS_TOTAL,
> > > +                                0);
> > > +    }
> > > +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ)) {
> > > +        cfg->buckets[THROTTLE_BPS_READ].avg  =3D
> > > +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX QEMU_OPT_B=
PS_READ,
> > > +                                0);
> > > +    }
> > > +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE)) {
> > > +        cfg->buckets[THROTTLE_BPS_WRITE].avg =3D
> > > +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX QEMU_OPT_B=
PS_WRITE,
> > > +                                0);
> > > +    }
> > > +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL))=
 {
> > > +        cfg->buckets[THROTTLE_OPS_TOTAL].avg =3D
> > > +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX QEMU_OPT_I=
OPS_TOTAL,
> > > +                                0);
> > > +    }
> > > +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ)) {
> > > +        cfg->buckets[THROTTLE_OPS_READ].avg =3D
> > > +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX QEMU_OPT_I=
OPS_READ,
> > > +                                0);
> > > +    }
> > > +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE))=
 {
> > > +        cfg->buckets[THROTTLE_OPS_WRITE].avg =3D
> > > +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX QEMU_OPT_I=
OPS_WRITE,
> > > +                                0);
> > > +    }
> > > +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL_MA=
X)) {
> > > +        cfg->buckets[THROTTLE_BPS_TOTAL].max =3D
> > > +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
> > > +                                QEMU_OPT_BPS_TOTAL_MAX, 0);
> > > +    }
> > > +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ_MAX=
)) {
> > > +        cfg->buckets[THROTTLE_BPS_READ].max  =3D
> > > +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
> > > +                                QEMU_OPT_BPS_READ_MAX, 0);
> > > +    }
> > > +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE_MA=
X)) {
> > > +        cfg->buckets[THROTTLE_BPS_WRITE].max =3D
> > > +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
> > > +                                QEMU_OPT_BPS_WRITE_MAX, 0);
> > > +    }
> > > +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL_M=
AX)) {
> > > +        cfg->buckets[THROTTLE_OPS_TOTAL].max =3D
> > > +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
> > > +                                QEMU_OPT_IOPS_TOTAL_MAX, 0);
> > > +    }
> > > +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ_MA=
X)) {
> > > +        cfg->buckets[THROTTLE_OPS_READ].max =3D
> > > +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
> > > +                                QEMU_OPT_IOPS_READ_MAX, 0);
> > > +    }
> > > +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE_M=
AX)) {
> > > +        cfg->buckets[THROTTLE_OPS_WRITE].max =3D
> > > +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
> > > +                                QEMU_OPT_IOPS_WRITE_MAX, 0);
> > > +    }
> > > +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL_MA=
X_LENGTH)) {
> > > +        if (qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
> > > +                                QEMU_OPT_BPS_TOTAL_MAX_LENGTH, 1) > =
UINT_MAX) {
> > > +            error_setg(errp, "%s value must be in the range [0, %u]",
> > > +                       THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL_MAX_LE=
NGTH,
> > > +                       UINT_MAX);
> > > +            return -1;
> > > +        }
> > > +        cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =3D
> > > +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
> > > +                                QEMU_OPT_BPS_TOTAL_MAX_LENGTH, 1);
> > > +    }
> > > +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ_MAX=
_LENGTH)) {
> > > +        if (qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
> > > +                                QEMU_OPT_BPS_READ_MAX_LENGTH, 1) > U=
INT_MAX) {
> > > +            error_setg(errp, "%s must be in the range [0, %u]",
> > > +                       THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ_MAX_LEN=
GTH,
> > > +                       UINT_MAX);
> > > +            return -1;
> > > +        }
> > > +        cfg->buckets[THROTTLE_BPS_READ].burst_length  =3D
> > > +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
> > > +                                QEMU_OPT_BPS_READ_MAX_LENGTH, 1);
> > > +    }
> > > +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE_MA=
X_LENGTH)) {
> > > +        if (qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
> > > +                                QEMU_OPT_BPS_WRITE_MAX_LENGTH, 1) > =
UINT_MAX) {
> > > +            error_setg(errp, "%s must be in the range [0, %u]",
> > > +                       THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE_MAX_LE=
NGTH,
> > > +                       UINT_MAX);
> > > +            return -1;
> > > +        }
> > > +        cfg->buckets[THROTTLE_BPS_WRITE].burst_length =3D
> > > +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
> > > +                                QEMU_OPT_BPS_WRITE_MAX_LENGTH, 1);
> > > +    }
> > > +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL_M=
AX_LENGTH)) {
> > > +        if (qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
> > > +                                QEMU_OPT_IOPS_TOTAL_MAX_LENGTH, 1) >=
 UINT_MAX) {
> > > +            error_setg(errp, "%s must be in the range [0, %u]",
> > > +                       THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL_MAX_L=
ENGTH,
> > > +                       UINT_MAX);
> > > +            return -1;
> > > +        }
> > > +        cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =3D
> > > +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
> > > +                                QEMU_OPT_IOPS_TOTAL_MAX_LENGTH, 1);
> > > +    }
> > > +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ_MA=
X_LENGTH)) {
> > > +        if (qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
> > > +                                QEMU_OPT_IOPS_READ_MAX_LENGTH, 1) > =
UINT_MAX) {
> > > +            error_setg(errp, "%s must be in the range [0, %u]",
> > > +                       THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ_MAX_LE=
NGTH,
> > > +                       UINT_MAX);
> > > +            return -1;
> > > +        }
> > > +        cfg->buckets[THROTTLE_OPS_READ].burst_length =3D
> > > +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
> > > +                                QEMU_OPT_IOPS_READ_MAX_LENGTH, 1);
> > > +    }
> > > +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE_M=
AX_LENGTH)) {
> > > +        if (qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
> > > +                                QEMU_OPT_IOPS_WRITE_MAX_LENGTH, 1) >=
 UINT_MAX) {
> > > +            error_setg(errp, "%s must be in the range [0, %u]",
> > > +                       THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE_MAX_L=
ENGTH,
> > > +                       UINT_MAX);
> > > +            return -1;
> > > +        }
> > > +        cfg->buckets[THROTTLE_OPS_WRITE].burst_length =3D
> > > +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
> > > +                                QEMU_OPT_IOPS_WRITE_MAX_LENGTH, 1);
> > > +    }
> > > +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_SIZE)) {
> > > +        cfg->op_size =3D
> > > +            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX QEMU_OPT_I=
OPS_SIZE,
> > > +                                0);
> > > +    }
> > > +    return 0;
> > > +}
> >=20
> > This function is very repetitive, but each block is long enough that
> > you have to look closely to review whether the right constants are used
> > everywhere.
> >=20
> > Maybe this could become a bit more readable with a macro or two?
>=20
> How about this?
>=20
>=20
> #   #define IF_OPT_SET(rvalue,opt_name) \
> #       if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX opt_name)) { \
> #           rvalue =3D qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX opt_=
name,
> 0); }
>=20
> #       IF_OPT_SET(cfg->buckets[THROTTLE_BPS_TOTAL].avg, QEMU_OPT_BPS_TOT=
AL);
> #       IF_OPT_SET(cfg->buckets[THROTTLE_BPS_READ].avg, QEMU_OPT_BPS_READ=
);
> [...]

Looks a lot more readable to me. :-)

If nobody objects, I'd suggest to go this way.

> > > +static int coroutine_fn throttle_co_pwritev(BlockDriverState *bs,
> > > +                                            uint64_t offset, uint64_=
t bytes,
> > > +                                            QEMUIOVector *qiov, int =
flags)
> > > +{
> > > +    ThrottleGroupMember *tgm =3D bs->opaque;
> > > +    throttle_group_co_io_limits_intercept(tgm, bytes, true);
> > > +
> > > +    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
> > > +}
> >=20
> > I think we want to set BlockDriver.supported_write_flags so that passing
> > down flags is actually of any use.
>=20
> Can you explain what you mean? Do you mean doing this in throttle_open():
>=20
>    bs->supported_write_flags =3D bs->file->bs->supported_write_flags;
>    bs->supported_zero_flags =3D bs->file->bs->supported_zero_flags;

Yes, I think that should do the trick.

Kevin

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZgxGdAAoJEH8JsnLIjy/WfSUQAIUbtyu211Hz0QwaNX72PmFL
zkaBtsKvZP7XDy5HX6dr3nQiDLT0l0Q4oQV2OKkvzxoQGWSZnxBP3JS+amJq+lV0
lsfdpqaojNyM7+4JYSsjHJ6kZniHhEvLfjeRlQ3ME8HBxkjfXZGj6FZ0Fnv9xhO8
YEnKXwyMOkHvc4kfKEva5tnD9MdNQYgMcDm+M4AAxmcSwAK1QrdKir9+UGbBeqCG
1LuxCmPNXe9Ah+eZWFWQPDipvEQlpNZJ1+EYNfzVDDXBOWTQx/f5+3ocRXl7RGAF
c2uQsWVXfc9W1x5qu1ZYq7tVUxCMkt8Izj9sajk3RTu5+hpIr8wRLWUGitHqYAh0
gIDEIS66LMjVhXee6Q+nRLru0EjJPbiTZGkSX6ulpJOzcH1nhmUYJRsIURY7uPMg
mAadt27bPDgf9WrEedpHFgICP+2xyRUhHpI+sBjz1Tz0RBdz1HSWZAjnIUF/baq9
rlq161VIeVCOi1SLmHOXdOAg9TrjqsCtLEiFrDPggQghtmHl7o+AOpX8Y0c5umwX
tDZbfW6ewtEogRtYN6bvqnY2bIPM9L0jFXbQh7OaGHjztLhV6Cj5YHOwLxUIUfDV
4VhRVdK/5fRjhfGOaOPmUOZD4vlEMVVTOnHNE5haush4JTrPtpDmbaLR2ovYNqwJ
kfmLTCouf78Pb+ZaYTTN
=pg3t
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--

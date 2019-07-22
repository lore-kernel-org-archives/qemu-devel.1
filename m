Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AA1C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 17:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD3B6217D4
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 17:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3B6217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpbxa-0003aA-T4
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 13:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48867)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hpbxO-0003Be-HJ
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 13:18:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hpbxM-0006Id-76
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 13:18:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46608)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hpbxI-0006G6-3u; Mon, 22 Jul 2019 13:18:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D3F9D60CC;
 Mon, 22 Jul 2019 17:18:29 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E7E225D721;
 Mon, 22 Jul 2019 17:18:23 +0000 (UTC)
To: qemu-block@nongnu.org
References: <20190722133054.21781-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <5f89c6ba-b049-db87-23ec-0317c53e978f@redhat.com>
Date: Mon, 22 Jul 2019 19:18:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190722133054.21781-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dIKXItK6DzrbiKh7BiQb4eoCKI3XECdGJ"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 22 Jul 2019 17:18:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1 0/2] block: bdrv_drained_end()
 changes fallout
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dIKXItK6DzrbiKh7BiQb4eoCKI3XECdGJ
Content-Type: multipart/mixed; boundary="c6pYDuu9QfrtDlXR6Y5VIP9f9Uqm2E7Ok";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <5f89c6ba-b049-db87-23ec-0317c53e978f@redhat.com>
Subject: Re: [PATCH for-4.1 0/2] block: bdrv_drained_end() changes fallout
References: <20190722133054.21781-1-mreitz@redhat.com>
In-Reply-To: <20190722133054.21781-1-mreitz@redhat.com>

--c6pYDuu9QfrtDlXR6Y5VIP9f9Uqm2E7Ok
Content-Type: multipart/mixed;
 boundary="------------A83A1C022BEBD4A03CF73243"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------A83A1C022BEBD4A03CF73243
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22.07.19 15:30, Max Reitz wrote:
> Hi,
>=20
> I noted that test-bdrv-drain sometimgs hangs (very rarely, though), and=

> tried to write a test that triggers the issue.  I failed to do so (ther=
e
> is a good reason for that, see patch 1), but on my way I noticed that
> calling bdrv_set_aio_context_ignore() from any AioContext but the main
> one is a bad idea.  Hence patch 2.
>=20
> Anyway, I found the problem, which is fixed by patch 1 -- I think it=E2=
=80=99s
> rather obvious.  There is no dedicated test because I don=E2=80=99t thi=
nk it=E2=80=99s
> possible to write one, as I explain there.
>=20
>=20
> Max Reitz (2):
>   block: Dec. drained_end_counter before bdrv_wakeup
>   block: Only the main loop can change AioContexts
>=20
>  include/block/block.h |  8 +++-----
>  block.c               | 13 ++++++++-----
>  block/io.c            |  5 ++---
>  3 files changed, 13 insertions(+), 13 deletions(-)

Sorry, applied to my block branch.


=E2=80=9CSorry=E2=80=9D obviously because I didn=E2=80=99t really give mu=
ch time to review this
series.  My justification is:

- rc2=E2=80=99s tomorrow.  I know the current code is broken, so I=E2=80=99=
d rather take
  the chance to have a fixed rc2 than to know it to be broken and force
  an rc4 by sending this for rc3.

- Patch 1 looks really obvious and simple to me.  It makes sense to
  decrement the drained_end_counter exactly where .done is set to true.

- Patch 2 is not so obvious.  But the only dangerous change it
  introduces is an assertion that bdrv_set_aio_context_ignore() is
  called from the main loop.  Right now, if it is called from anywhere
  but the main loop, we *will* run into assertions elsewhere:
  - bdrv_drained_begin() does a BDRV_POLL_WHILE(bs, ...).  This only
    works from the main context or bs's context.
  - bdrv_drained_end() does the same, but now bs's context has changed.
  Ergo, right now (on master), you can run bdrv_set_aio_context_ignore()
  only from the main loop anyway.  The new assertion only makes that
  fact more explicit.

Now this makes it look like before e037c09c78520, you could run
bdrv_set_aio_context_ignore() from the old context (like the comment
therein said).  But that=E2=80=99s wrong.  Even before e037c09c78520,
bdrv_drained_end() didn=E2=80=99t work for mixed-context trees unless you=
 call
it from the main context: It schedules the drained_end callbacks in the
respective node's context, but then it polls them from the original
context.  So if you modify e.g. test_set_aio_context() in
test-bdrv-drain to run bdrv_try_set_aio_context() from a BH in the old
context, you will see a failed assertion in bdrv_drain_invoke()'s
BDRV_POLL_WHILE.  (I=E2=80=99ve attached a diff for use on e037c09c78520^=
=2E)

Therefore, I=E2=80=99m confident this series doesn=E2=80=99t make things =
worse, which is
why I=E2=80=99m taking it without reviews.

Max

--------------A83A1C022BEBD4A03CF73243
Content-Type: text/x-patch;
 name="test-bdrv-drain.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="test-bdrv-drain.diff"

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 3503ce3b69..cf1194754e 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -1497,6 +1497,19 @@ static void test_append_to_drained(void)
     blk_unref(blk);
 }
=20
+typedef struct BHParams {
+    BlockDriverState *bs;
+    AioContext *target;
+    bool done;
+} BHParams;
+
+static void bh_fun(void *opaque)
+{
+    BHParams *bhp =3D opaque;
+    bdrv_try_set_aio_context(bhp->bs, bhp->target, &error_abort);
+    bhp->done =3D true;
+}
+
 static void test_set_aio_context(void)
 {
     BlockDriverState *bs;
@@ -1504,22 +1517,38 @@ static void test_set_aio_context(void)
     IOThread *b =3D iothread_new();
     AioContext *ctx_a =3D iothread_get_aio_context(a);
     AioContext *ctx_b =3D iothread_get_aio_context(b);
+    BHParams bhp;
=20
     bs =3D bdrv_new_open_driver(&bdrv_test, "test-node", BDRV_O_RDWR,
                               &error_abort);
=20
     bdrv_drained_begin(bs);
-    bdrv_try_set_aio_context(bs, ctx_a, &error_abort);
+    bhp =3D (BHParams){ bs, ctx_a };
+    aio_bh_schedule_oneshot(qemu_get_aio_context(), bh_fun, &bhp);
+    while (!bhp.done) {
+        aio_poll(qemu_get_aio_context(), true);
+    }
=20
     aio_context_acquire(ctx_a);
     bdrv_drained_end(bs);
=20
     bdrv_drained_begin(bs);
-    bdrv_try_set_aio_context(bs, ctx_b, &error_abort);
+
+    bhp =3D (BHParams){ bs, ctx_b };
+    aio_bh_schedule_oneshot(ctx_a, bh_fun, &bhp);
     aio_context_release(ctx_a);
+    while (!bhp.done) {
+        aio_poll(qemu_get_aio_context(), true);
+    }
+
     aio_context_acquire(ctx_b);
-    bdrv_try_set_aio_context(bs, qemu_get_aio_context(), &error_abort);
+    bhp =3D (BHParams){ bs, qemu_get_aio_context() };
+    aio_bh_schedule_oneshot(ctx_b, bh_fun, &bhp);
     aio_context_release(ctx_b);
+    while (!bhp.done) {
+        aio_poll(qemu_get_aio_context(), true);
+    }
+
     bdrv_drained_end(bs);
=20
     bdrv_unref(bs);

--------------A83A1C022BEBD4A03CF73243--

--c6pYDuu9QfrtDlXR6Y5VIP9f9Uqm2E7Ok--

--dIKXItK6DzrbiKh7BiQb4eoCKI3XECdGJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0179wACgkQ9AfbAGHV
z0DKuwf+LS8AqstoTdQH76VShA7tLBHowe/pK6UqEAWH5y9fHKBB/n4PvRr94Sq4
sWsxglk9Ckq5SDRmF61o2KslGjDJqTVOb1kZP0RU1WGR8amauReV323IIUkIeEYE
hhyCo+cqtbzxRFtkAA7C6pYDe2I7HScRmrTrQC0MN6OcFCLz19CL3DSm5oR5tfRo
/V4Y7JcrXtmcOyzVhUFJO7wKQ36wf7Y/dh3DPXQx+6Y34HYOAdh3Fptc+3Pioz8b
lFyM5xnF0V8Fm8jQTjKidEacxUUz/JSJZCiYw3MMFPfRwUTjKtr3EhbQ/0TUH8Kl
h8m5JYiWxGPWKzQiopSRMhd6WG9fPA==
=ddfR
-----END PGP SIGNATURE-----

--dIKXItK6DzrbiKh7BiQb4eoCKI3XECdGJ--


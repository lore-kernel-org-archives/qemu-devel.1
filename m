Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3798C4BA10
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F23624685
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIiRvvdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F23624685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6uj5-0005PZ-KL
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:19:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j6uiO-0004wA-O9
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j6uiN-0008HO-Dk
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:18:56 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27910
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j6uiN-0008DZ-9k
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582715934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3omZTCjXswJ/LzADMJVkXLPVw9sFdFJ4+bK+B/NtUXc=;
 b=WIiRvvdEZiQa5UmmzTJ0gU6Wn7Rk5AlhoasUlKvXknS+LNLGRpljDtH40IKl21SlDfNkre
 4uU9CmMLL8MpdFzyyaiUObmUg1XAbXplYWkmMYIx+DneUUn5cmMIdGojPem+d3jfvhNE3O
 ZEe1Qz13dzpwvfnkWRu6hiwPCJ+UP1c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-zug256KmPpO73KvrdUH4sQ-1; Wed, 26 Feb 2020 06:18:50 -0500
X-MC-Unique: zug256KmPpO73KvrdUH4sQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AC8D800D53;
 Wed, 26 Feb 2020 11:18:49 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A87DF60BE2;
 Wed, 26 Feb 2020 11:18:47 +0000 (UTC)
Subject: Re: [PATCH 1/2] iotests: add JobRunner class
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200226004425.1303-1-jsnow@redhat.com>
 <20200226004425.1303-2-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <689f4a10-b1f2-14f9-c759-13e7447bd5b3@redhat.com>
Date: Wed, 26 Feb 2020 12:18:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226004425.1303-2-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dQEghFBbJnrGap5ruvJSzldmxeaTh2mZ4"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dQEghFBbJnrGap5ruvJSzldmxeaTh2mZ4
Content-Type: multipart/mixed; boundary="pSy1Tf3PBOopbgt08HAVFF9dGWHV3CFAO"

--pSy1Tf3PBOopbgt08HAVFF9dGWHV3CFAO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.02.20 01:44, John Snow wrote:
> The idea is that instead of increasing the arguments to job_run all the
> time, create a more general-purpose job runner that can be subclassed to
> do interesting things with.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/255        |   9 +-
>  tests/qemu-iotests/257        |  12 ++-
>  tests/qemu-iotests/287        |  19 +++-
>  tests/qemu-iotests/iotests.py | 176 ++++++++++++++++++++++++----------
>  4 files changed, 158 insertions(+), 58 deletions(-)

I like it!

[...]

> diff --git a/tests/qemu-iotests/287 b/tests/qemu-iotests/287
> index 0ab58dc011..f06e6ff084 100755
> --- a/tests/qemu-iotests/287
> +++ b/tests/qemu-iotests/287
> @@ -165,13 +165,22 @@ def test_bitmap_populate(config):
>                  if not config.disabled:
>                      ebitmap.dirty_group(2)
> =20
> +
> +        class TestJobRunner(iotests.JobRunner):
> +            def on_pending(self, event):
> +                if config.mid_writes:
> +                    perform_writes(drive0, 2)
> +                    if not config.disabled:
> +                        ebitmap.dirty_group(2)

I actually prefer inlining the pre_finalize() functions (over calling
the existing one), but then we can also remove the original function. :)

> +                super().on_pending(event)
> +
>          job =3D populate(drive0, 'target', 'bitpop0')
>          assert job['return'] =3D=3D {'return': {}}
> -        vm.run_job(job['id'],
> -                   auto_dismiss=3Djob['auto-dismiss'],
> -                   auto_finalize=3Djob['auto-finalize'],
> -                   pre_finalize=3Dpre_finalize,
> -                   cancel=3Dconfig.cancel)
> +        job_runner =3D TestJobRunner(vm, job['id'],
> +                                   auto_dismiss=3Djob['auto-dismiss'],
> +                                   auto_finalize=3Djob['auto-finalize'],
> +                                   cancel=3Dconfig.cancel)
> +        job_runner.run()
>          log('')
> =20
> =20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index 3390fab021..37a8b4d649 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -460,6 +460,130 @@ def remote_filename(path):
>      else:
>          raise Exception("Protocol %s not supported" % (imgproto))
> =20
> +
> +class JobRunner:

[...]

> +    def on_ready(self, event):
> +        if self.logging:
> +            self._vm.qmp_log('job-complete', id=3Dself._id)
> +        else:
> +            self._vm.qmp('job-complete', id=3Dself._id)

I suppose this is a bug fix.  (The old version always called qmp_log.)

But what about adding a do_qmp method to JobRunner that does the
=E2=80=9Cif self.logging { self._vm.qmp_log() } else { self._vm.qmp }=E2=80=
=9D part so
we don=E2=80=99t have to inline that everywhere?

Max


--pSy1Tf3PBOopbgt08HAVFF9dGWHV3CFAO--

--dQEghFBbJnrGap5ruvJSzldmxeaTh2mZ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5WVBUACgkQ9AfbAGHV
z0DUUwf9Fffhv64acXpkTIAGhv5B8sXnhPROCeZ482H1GJMdBdlMIaKo0j7Hdx1q
xT+sw79V0j1CfQw6XHn9A077uC/mlZoEsZwSHYjv5KFW54enzflVuSeixhA9//22
BLQ4rLrOtiU8yZV1qUY1jqFs57q4T25xLG7QGKB7ex6vM620MAhzcjt8oROEiThK
raXueS6JKDgw42zc1Pj+KyR4UYmQFr63+hjhTGA3xKIMryN2sT3i/VbvxSoadxF2
RbHe5d4y0GRbmAzN7Pnc1+9VIsgqYwTk/hcGIedfjDKFTZY/zQksUwaV0MpQBzzb
hTsyhJJnlqzrPDla33LCykfb2Z/yKA==
=Axxo
-----END PGP SIGNATURE-----

--dQEghFBbJnrGap5ruvJSzldmxeaTh2mZ4--



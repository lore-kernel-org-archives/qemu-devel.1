Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AF6C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A60B324693
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xd0vJcb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60B324693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Ilp-0008JH-RO
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:00:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j7IlC-0007nV-TA
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j7IlB-0003ka-JC
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:59:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20210
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j7IlB-0003kM-Eo
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582808365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=k6GcLQDvmEesoiZvndcJeCKBnzxUwfq6B07tmV8Y1JU=;
 b=Xd0vJcb8GVawl/hRufEcPPSxxi+5G02c1MdWxViDYRHbiyXiPYMkd3UpRgudi9Lc44FQk+
 o7tYXvOlCSPKzsgvhFfUKeRovcHVZc0DwcO9Y95NrUr6YkfPDzgc3aQMLr6V33YKpfiCm3
 V450v0q33vfmj2ALrhMrlQv+OToXW4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-qpohfwErMGGnwMffHzhsVg-1; Thu, 27 Feb 2020 07:59:20 -0500
X-MC-Unique: qpohfwErMGGnwMffHzhsVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBBDE8017DF;
 Thu, 27 Feb 2020 12:59:19 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B461584779;
 Thu, 27 Feb 2020 12:59:18 +0000 (UTC)
Subject: Re: [PATCH v6 1/9] iotests: do a light delinting
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200227000639.9644-1-jsnow@redhat.com>
 <20200227000639.9644-2-jsnow@redhat.com>
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
Message-ID: <5c3f3029-37c3-dd97-efb7-ea244742ab51@redhat.com>
Date: Thu, 27 Feb 2020 13:59:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227000639.9644-2-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5ixgTbNWzEo1B32nWpz4Oj7gqyUN9xMm9"
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
--5ixgTbNWzEo1B32nWpz4Oj7gqyUN9xMm9
Content-Type: multipart/mixed; boundary="w6X9ozmZie2mnQ2OVX9DSA1ARo2i0zKRg"

--w6X9ozmZie2mnQ2OVX9DSA1ARo2i0zKRg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.02.20 01:06, John Snow wrote:
> This doesn't fix everything in here, but it does help clean up the
> pylint report considerably.
>=20
> This should be 100% style changes only; the intent is to make pylint
> more useful by working on establishing a baseline for iotests that we
> can gate against in the future. This will be important if (when?) we
> begin adding type hints to our code base.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 88 ++++++++++++++++++-----------------
>  1 file changed, 45 insertions(+), 43 deletions(-)

I feel like I=E2=80=99m the wrongest person there is for reviewing a Python
style-fixing patch, but here I am and so here I go:

> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index 8815052eb5..e8a0ea14fc 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py

[...]

> @@ -245,8 +243,7 @@ def qemu_nbd_early_pipe(*args):
>                            ' '.join(qemu_nbd_args + ['--fork'] + list(arg=
s))))
>      if exitcode =3D=3D 0:
>          return exitcode, ''
> -    else:
> -        return exitcode, subp.communicate()[0]
> +    return exitcode, subp.communicate()[0]

If we want to make such a change (which I don=E2=80=99t doubt we want), I t=
hink
it should be the other way around: Make the condition =E2=80=9Cexitcode !=
=3D 0=E2=80=9D,
so the final return is the return for the successful case.  (Just
because I think that=E2=80=99s how we usually do it, at least in the qemu c=
ode?)

[...]

> @@ -455,10 +452,9 @@ def file_path(*names, base_dir=3Dtest_dir):
>  def remote_filename(path):
>      if imgproto =3D=3D 'file':
>          return path
> -    elif imgproto =3D=3D 'ssh':
> +    if imgproto =3D=3D 'ssh':

This seems like a weird thing to complain about for a coding style
check, but whatever.

(As in, I prefer the elif form)

>          return "ssh://%s@127.0.0.1:22%s" % (os.environ.get('USER'), path=
)
> -    else:
> -        raise Exception("Protocol %s not supported" % (imgproto))
> +    raise Exception("Protocol %s not supported" % (imgproto))
> =20
>  class VM(qtest.QEMUQtestMachine):
>      '''A QEMU VM'''

[...]

> @@ -756,12 +750,13 @@ def assert_block_path(self, root, path, expected_no=
de, graph=3DNone):
>              assert node is not None, 'Cannot follow path %s%s' % (root, =
path)
> =20
>              try:
> -                node_id =3D next(edge['child'] for edge in graph['edges'=
] \
> -                                             if edge['parent'] =3D=3D no=
de['id'] and
> -                                                edge['name'] =3D=3D chil=
d_name)
> +                node_id =3D next(edge['child'] for edge in graph['edges'=
]
> +                               if edge['parent'] =3D=3D node['id'] and
> +                               edge['name'] =3D=3D child_name)

I don=E2=80=99t mind the if alignment, but I do mind not aligning the third=
 line
to the =E2=80=9Cedge=E2=80=9D above it (i.e. the third line is part of the =
condition, so
I=E2=80=99d align it to the =E2=80=9Cif=E2=80=9D condition).

But then again it=E2=80=99s nothing new that I like to disagree with common=
ly
agreed-upon Python coding styles, so.

[...]

> @@ -891,13 +892,14 @@ def wait_until_completed(self, drive=3D'drive0', ch=
eck_offset=3DTrue, wait=3D60.0,
>                          self.assert_qmp(event, 'data/error', error)
>                      self.assert_no_active_block_jobs()
>                      return event
> -                elif event['event'] =3D=3D 'JOB_STATUS_CHANGE':
> +                if event['event'] =3D=3D 'JOB_STATUS_CHANGE':
>                      self.assert_qmp(event, 'data/id', drive)
> =20
>      def wait_ready(self, drive=3D'drive0'):
>          '''Wait until a block job BLOCK_JOB_READY event'''
> -        f =3D {'data': {'type': 'mirror', 'device': drive } }
> +        f =3D {'data': {'type': 'mirror', 'device': drive}}
>          event =3D self.vm.event_wait(name=3D'BLOCK_JOB_READY', match=3Df=
)
> +        return event

Why not just =E2=80=9Creturn self.vm.event_wait=E2=80=A6=E2=80=9D?

Max


--w6X9ozmZie2mnQ2OVX9DSA1ARo2i0zKRg--

--5ixgTbNWzEo1B32nWpz4Oj7gqyUN9xMm9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5XvSUACgkQ9AfbAGHV
z0CiXgf/awWeShEED49kHg+5Qo4aDoWAC+ea2fDJTLgVEacTo64E5/ZTwUoPgunp
kue3sZk8h5d6k1GufwTxttRENHc1D/sstAW9OW6a+2dzZZmQsP6Lg0O7DcerFdc6
1qMGNccjYidA+nKPyLyUV7chluTT8QYNKH76dbjTtcoSpoO/GJF6FhjVFmoHzAUq
cOB62u8CdlAwocHBW40grVwrXSImpA3tjToC0chHk5Hm0b6e4HWYipPqOUvaF6Ro
VYp2T/4YrcowcxgnFjZpMINhXeRy5GnC4rfFON5Y08Rkga0u5b9y6CuhUj39DPs/
/thicv+KGqfv8PVn6eN0/KBZBzmL4A==
=UfGf
-----END PGP SIGNATURE-----

--5ixgTbNWzEo1B32nWpz4Oj7gqyUN9xMm9--



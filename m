Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7894DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 467D6207DD
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZriKYog+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467D6207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlYnd-0002ot-ID
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 10:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlYmw-00029v-MN
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:11:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25507
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlYmu-0003Wo-1j
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592403094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CK6v2c8Fp45ENucK3/euUzyyAXoaTJUdaRqhUZ97G80=;
 b=ZriKYog+NB3K7HcsmYDgxnVZ+TY/66/bWxcMXsDwfvK393N44C5GP+LI6q5G6aWYDgDoc6
 MA68AS/JwYvqnsTotqQC5kT741jhPdoSZnWuDOkCBRH6nliI5xLBRDHNOg8yQ6+RiIGatb
 i+tN7KgLanFJIrGtPj31FB6XlwdIFYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-84SF-c2OMrypjcQdHNqm2A-1; Wed, 17 Jun 2020 10:11:16 -0400
X-MC-Unique: 84SF-c2OMrypjcQdHNqm2A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2B5BEC1A1;
 Wed, 17 Jun 2020 14:11:15 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-111.ams2.redhat.com
 [10.36.113.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BADB379303;
 Wed, 17 Jun 2020 14:11:14 +0000 (UTC)
Subject: Re: [PATCH 0/5] iotests: Some fixes for rarely run cases
To: Kevin Wolf <kwolf@redhat.com>
References: <20200617104822.27525-1-mreitz@redhat.com>
 <20200617125238.GC5166@linux.fritz.box>
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
Message-ID: <f8192770-0fe1-95e6-9560-47571a1ebc59@redhat.com>
Date: Wed, 17 Jun 2020 16:11:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617125238.GC5166@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AttY2f4W4ks3ObLC8US72Kf9CPU1MhQWX"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AttY2f4W4ks3ObLC8US72Kf9CPU1MhQWX
Content-Type: multipart/mixed; boundary="Xy63EYGMZcJTomZdHAZpJBKHFckNeNI3t"

--Xy63EYGMZcJTomZdHAZpJBKHFckNeNI3t
Content-Type: multipart/mixed;
 boundary="------------DE41B26741C50229CF574D7D"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------DE41B26741C50229CF574D7D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.06.20 14:52, Kevin Wolf wrote:
> Am 17.06.2020 um 12:48 hat Max Reitz geschrieben:
>> Hi,
>>
>> Thomas=E2=80=99s report
>> (https://lists.nongnu.org/archive/html/qemu-block/2020-06/msg00791.html)
>> has given me a nice excuse to write this series.
>>
>> There are some iotests that have recently start to fail in rarely
>> exercised test environments (qed, qcow2 with data_file, qcow2 v2), and
>> this series fixes what I found.
>=20
> Thanks, applied to the block branch.

Sorry, I didn=E2=80=99t run iotest 297 before sending this series...

The problems arise in patch 1:

iotests.py:1113:0: C0301: Line too long (80/79) (line-too-long)
iotests.py:1106: error: Function is missing a return type annotation

(So there=E2=80=99s a line with 80 characters, when 79 is the maximum (*shr=
ug*),
and I failed to specify skip_for_format=E2=80=99s return type.)

I think patch 1 needs the attached diff squashed in.  Are you willing to
do that or should I just send a v2?

Max

--------------DE41B26741C50229CF574D7D
Content-Type: text/x-patch; charset=UTF-8;
 name="patch1.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="patch1.diff"

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 92c08b9dc6..5ea4c4df8b 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -1103,14 +1103,17 @@ def skip_if_unsupported(required_formats=3D(), read=
_only=3DFalse):
         return func_wrapper
     return skip_test_decorator
=20
-def skip_for_formats(formats: Sequence[str] =3D ()):
+def skip_for_formats(formats: Sequence[str] =3D ()) \
+    -> Callable[[Callable[[QMPTestCase, List[Any], Dict[str, Any]], None]]=
,
+                Callable[[QMPTestCase, List[Any], Dict[str, Any]], None]]:
     '''Skip Test Decorator
        Skips the test for the given formats'''
     def skip_test_decorator(func):
         def func_wrapper(test_case: QMPTestCase, *args: List[Any],
                          **kwargs: Dict[str, Any]) -> None:
             if imgfmt in formats:
-                test_case.case_skip(f'{test_case}: Skipped for format {img=
fmt}')
+                msg =3D f'{test_case}: Skipped for format {imgfmt}'
+                test_case.case_skip(msg)
             else:
                 func(test_case, *args, **kwargs)
         return func_wrapper

--------------DE41B26741C50229CF574D7D--

--Xy63EYGMZcJTomZdHAZpJBKHFckNeNI3t--

--AttY2f4W4ks3ObLC8US72Kf9CPU1MhQWX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl7qJIEACgkQ9AfbAGHV
z0CelggAkAW5ax1p66ZuUF72zlhnJzotsnIF1RAUPunHkQCXxSKYkRwbTYJfvjgt
0Sy+4ZL89JyaW3j+F2RzXyAKAMVLCXgBTVxz1KbznJwTxSVWEEX+RoPo+3bg227G
ulFlHyP58VM1XV9Cb+lovV1vGDMjpGhlW+OEZoppZ2SXQMiv5MLKq0TpXJ876ryv
Lnf+KRzRtSygNVhHauDJ+igWS87+EK3D8WT3VdEOPagEhQIDgggHEH6AxMb938gR
sL//IrmjKIvOscqTmIHq62tdPn7Dv1p1SCkHN2YWExC2c0QvKkt/ouY1rY7KWJpY
J65GBLB4XIbsu5KSsW90qn4Hdb6qZA==
=QMAz
-----END PGP SIGNATURE-----

--AttY2f4W4ks3ObLC8US72Kf9CPU1MhQWX--



Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476A2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 08:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E719120724
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 08:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hbgia5Ds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E719120724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsMiA-0002gk-7I
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 04:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jsMUD-00043q-Hj
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 04:28:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57632
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jsMU9-0006JY-Fc
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 04:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594024100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DYPwDD5ZlUcWJCFFwCrqQGLl7yIomTYA5IHbJzMmwq8=;
 b=Hbgia5DsWfAkBQbDF7Bin5KMGtK9GHkFegFERjnv9Qv9AG84Fx5aCOfG85u+hQraz3RSDG
 4c2Mu4bUzUlQH73uTonJqPTHgTfmKdjTQmtzQLJPATngLcUU59PyIFqQX6XErm8jqhgT+v
 SjB2aZp7DAndRivfn3xJRyHIicNNzRE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-l0kz3z91MnCPi5OS1GEZlg-1; Mon, 06 Jul 2020 04:28:15 -0400
X-MC-Unique: l0kz3z91MnCPi5OS1GEZlg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDEE41005510;
 Mon,  6 Jul 2020 08:28:13 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-176.ams2.redhat.com
 [10.36.112.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CB241001268;
 Mon,  6 Jul 2020 08:28:07 +0000 (UTC)
Subject: Re: [PATCH v3 04/10] block/vpc: return ZERO block-status when
 appropriate
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200528094405.145708-1-vsementsov@virtuozzo.com>
 <20200528094405.145708-5-vsementsov@virtuozzo.com>
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
Message-ID: <3b1bd97d-364e-2a7f-0013-853c89a1723e@redhat.com>
Date: Mon, 6 Jul 2020 10:28:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200528094405.145708-5-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2V2R4JIZLIoLqfBLnqgWXMFZRtLdCBiz3"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:22:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com, codyprime@gmail.com,
 sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2V2R4JIZLIoLqfBLnqgWXMFZRtLdCBiz3
Content-Type: multipart/mixed; boundary="HW1rm0ngjTk6mUzghfIHQ9VF0fGZHqJYF"

--HW1rm0ngjTk6mUzghfIHQ9VF0fGZHqJYF
Content-Type: multipart/mixed;
 boundary="------------A5B7E422761F7B4B0E634F5A"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------A5B7E422761F7B4B0E634F5A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28.05.20 11:43, Vladimir Sementsov-Ogievskiy wrote:
> In case when get_image_offset() returns -1, we do zero out the
> corresponding chunk of qiov. So, this should be reported as ZERO.
>=20
> Note that this changes visible output of "qemu-img map --output=3Djson"
> and "qemu-io -c map" commands. For qemu-img map, the change is obvious:
> we just mark as zero what is really zero. For qemu-io it's less
> obvious: what was unallocated now is allocated.
>=20
> There is an inconsistency in understanding of unallocated regions in
> Qemu: backing-supporting format-drivers return 0 block-status to report
> go-to-backing logic for this area. Some protocol-drivers (iscsi) return
> 0 to report fs-unallocated-non-zero status (i.e., don't occupy space on
> disk, read result is undefined).
>=20
> BDRV_BLOCK_ALLOCATED is defined as something more close to
> go-to-backing logic. Still it is calculated as ZERO | DATA, so 0 from
> iscsi is treated as unallocated. It doesn't influence backing-chain
> behavior, as iscsi can't have backing file. But it does influence
> "qemu-io -c map".
>=20
> We should solve this inconsistency at some future point. Now, let's
> just make backing-not-supporting format drivers (vdi in the previous
> patch and vpc now) to behave more like backing-supporting drivers
> and not report 0 block-status. More over, returning ZERO status is
> absolutely valid thing, and again, corresponds to how the other
> format-drivers (backing-supporting) work.
>=20
> After block-status update, it never reports 0, so setting
> unallocated_blocks_are_zero doesn't make sense (as the only user of it
> is bdrv_co_block_status and it checks unallocated_blocks_are_zero only
> for unallocated areas). Drop it.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/vpc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

This breaks iotest 146, I=E2=80=99m afraid.  Now everything is reported as
allocated, which is of course what we kind of want, but I suppose it
renders the test a bit useless.

It seems to me like the best thing to do would be to replace the
=E2=80=9Cqemu-io -o $opts -c map=E2=80=9D calls by
=E2=80=9Cqemu-img map --output=3Djson --image-opts $opts=E2=80=9D, so that =
we get
=E2=80=9Czero: true=E2=80=9D instead of =E2=80=9Cnot allocated=E2=80=9D in =
the output.

A bit of a problem with that approach are the =E2=80=9Callocated=E2=80=9D e=
ntries,
because those are split into 2 MB chunks, so the output gets long.  But,
well.

I=E2=80=99ve attached a diff to that effect.  Would you be OK with squashin=
g
that in?

Max

--------------A5B7E422761F7B4B0E634F5A
Content-Type: text/x-patch; charset=UTF-8;
 name="146.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="146.diff"

diff --git a/tests/qemu-iotests/146 b/tests/qemu-iotests/146
index 2e43abddfc..ddc3c1fd80 100755
--- a/tests/qemu-iotests/146
+++ b/tests/qemu-iotests/146
@@ -51,19 +51,25 @@ echo =3D=3D=3D Testing VPC Autodetect =3D=3D=3D
 echo
 _use_sample_img virtualpc-dynamic.vhd.bz2
=20
-${QEMU_IO} -c "open -o driver=3Dvpc ${TEST_IMG}" -c 'map'
+$QEMU_IMG map --output=3Djson --image-opts \
+    "driver=3Dvpc,file.filename=3D$TEST_IMG" \
+    | _filter_qemu_img_map
=20
 echo
 echo =3D=3D=3D Testing VPC with current_size force =3D=3D=3D
 echo
=20
-${QEMU_IO} -c "open -o driver=3Dvpc,force_size_calc=3Dcurrent_size ${TEST_=
IMG}" -c 'map'
+$QEMU_IMG map --output=3Djson --image-opts \
+    "driver=3Dvpc,force_size_calc=3Dcurrent_size,file.filename=3D$TEST_IMG=
" \
+    | _filter_qemu_img_map
=20
 echo
 echo =3D=3D=3D Testing VPC with chs force =3D=3D=3D
 echo
=20
-${QEMU_IO} -c "open -o driver=3Dvpc,force_size_calc=3Dchs ${TEST_IMG}" -c =
'map'
+$QEMU_IMG map --output=3Djson --image-opts \
+    "driver=3Dvpc,force_size_calc=3Dchs,file.filename=3D$TEST_IMG" \
+    | _filter_qemu_img_map
=20
 _cleanup_test_img
=20
@@ -72,19 +78,25 @@ echo =3D=3D=3D Testing Hyper-V Autodetect =3D=3D=3D
 echo
 _use_sample_img hyperv2012r2-dynamic.vhd.bz2
=20
-${QEMU_IO} -c "open -o driver=3Dvpc ${TEST_IMG}" -c 'map'
+$QEMU_IMG map --output=3Djson --image-opts \
+    "driver=3Dvpc,file.filename=3D$TEST_IMG" \
+    | _filter_qemu_img_map
=20
 echo
 echo =3D=3D=3D Testing Hyper-V with current_size force =3D=3D=3D
 echo
=20
-${QEMU_IO} -c "open -o driver=3Dvpc,force_size_calc=3Dcurrent_size ${TEST_=
IMG}" -c 'map'
+$QEMU_IMG map --output=3Djson --image-opts \
+    "driver=3Dvpc,force_size_calc=3Dcurrent_size,file.filename=3D$TEST_IMG=
" \
+    | _filter_qemu_img_map
=20
 echo
 echo =3D=3D=3D Testing Hyper-V with chs force =3D=3D=3D
 echo
=20
-${QEMU_IO} -c "open -o driver=3Dvpc,force_size_calc=3Dchs ${TEST_IMG}" -c =
'map'
+$QEMU_IMG map --output=3Djson --image-opts \
+    "driver=3Dvpc,force_size_calc=3Dchs,file.filename=3D$TEST_IMG" \
+    | _filter_qemu_img_map
=20
 _cleanup_test_img
=20
@@ -93,19 +105,25 @@ echo =3D=3D=3D Testing d2v Autodetect =3D=3D=3D
 echo
 _use_sample_img d2v-zerofilled.vhd.bz2
=20
-${QEMU_IO} -c "open -o driver=3Dvpc ${TEST_IMG}" -c 'map'
+$QEMU_IMG map --output=3Djson --image-opts \
+    "driver=3Dvpc,file.filename=3D$TEST_IMG" \
+    | _filter_qemu_img_map
=20
 echo
 echo =3D=3D=3D Testing d2v with current_size force =3D=3D=3D
 echo
=20
-${QEMU_IO} -c "open -o driver=3Dvpc,force_size_calc=3Dcurrent_size ${TEST_=
IMG}" -c 'map'
+$QEMU_IMG map --output=3Djson --image-opts \
+    "driver=3Dvpc,force_size_calc=3Dcurrent_size,file.filename=3D$TEST_IMG=
" \
+    | _filter_qemu_img_map
=20
 echo
 echo =3D=3D=3D Testing d2v with chs force =3D=3D=3D
 echo
=20
-${QEMU_IO} -c "open -o driver=3Dvpc,force_size_calc=3Dchs ${TEST_IMG}" -c =
'map'
+$QEMU_IMG map --output=3Djson --image-opts \
+    "driver=3Dvpc,force_size_calc=3Dchs,file.filename=3D$TEST_IMG" \
+    | _filter_qemu_img_map
=20
 _cleanup_test_img
=20
@@ -121,19 +139,25 @@ echo
 echo =3D=3D=3D Read created image, default opts =3D=3D=3D=3D
 echo
=20
-${QEMU_IO} -c "open -o driver=3Dvpc ${TEST_IMG}" -c 'map'
+$QEMU_IMG map --output=3Djson --image-opts \
+    "driver=3Dvpc,file.filename=3D$TEST_IMG" \
+    | _filter_qemu_img_map
=20
 echo
 echo =3D=3D=3D Read created image, force_size_calc=3Dchs =3D=3D=3D=3D
 echo
=20
-${QEMU_IO} -c "open -o driver=3Dvpc,force_size_calc=3Dchs ${TEST_IMG}" -c =
'map'
+$QEMU_IMG map --output=3Djson --image-opts \
+    "driver=3Dvpc,force_size_calc=3Dchs,file.filename=3D$TEST_IMG" \
+    | _filter_qemu_img_map
=20
 echo
 echo =3D=3D=3D Read created image, force_size_calc=3Dcurrent_size =3D=3D=
=3D=3D
 echo
=20
-${QEMU_IO} -c "open -o driver=3Dvpc,force_size_calc=3Dcurrent_size ${TEST_=
IMG}" -c 'map'
+$QEMU_IMG map --output=3Djson --image-opts \
+    "driver=3Dvpc,force_size_calc=3Dcurrent_size,file.filename=3D$TEST_IMG=
" \
+    | _filter_qemu_img_map
=20
 echo
 echo =3D=3D=3D Testing Image create, force_size =3D=3D=3D
@@ -145,19 +169,25 @@ echo
 echo =3D=3D=3D Read created image, default opts =3D=3D=3D=3D
 echo
=20
-${QEMU_IO} -c "open -o driver=3Dvpc ${TEST_IMG}" -c 'map'
+$QEMU_IMG map --output=3Djson --image-opts \
+    "driver=3Dvpc,file.filename=3D$TEST_IMG" \
+    | _filter_qemu_img_map
=20
 echo
 echo =3D=3D=3D Read created image, force_size_calc=3Dchs =3D=3D=3D=3D
 echo
=20
-${QEMU_IO} -c "open -o driver=3Dvpc,force_size_calc=3Dchs ${TEST_IMG}" -c =
'map'
+$QEMU_IMG map --output=3Djson --image-opts \
+    "driver=3Dvpc,force_size_calc=3Dchs,file.filename=3D$TEST_IMG" \
+    | _filter_qemu_img_map
=20
 echo
 echo =3D=3D=3D Read created image, force_size_calc=3Dcurrent_size =3D=3D=
=3D=3D
 echo
=20
-${QEMU_IO} -c "open -o driver=3Dvpc,force_size_calc=3Dcurrent_size ${TEST_=
IMG}" -c 'map'
+$QEMU_IMG map --output=3Djson --image-opts \
+    "driver=3Dvpc,force_size_calc=3Dcurrent_size,file.filename=3D$TEST_IMG=
" \
+    | _filter_qemu_img_map
=20
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/146.out b/tests/qemu-iotests/146.out
index 1332189d87..80513cdd06 100644
--- a/tests/qemu-iotests/146.out
+++ b/tests/qemu-iotests/146.out
@@ -2,39 +2,414 @@ QA output created by 146
=20
 =3D=3D=3D Testing VPC Autodetect =3D=3D=3D
=20
-126.998 GiB (0x1fbfe04000) bytes not allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 136363130880, "depth": 0, "zero": true, "data": f=
alse }]
=20
 =3D=3D=3D Testing VPC with current_size force =3D=3D=3D
=20
-127 GiB (0x1fc0000000) bytes not allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 136365211648, "depth": 0, "zero": true, "data": f=
alse }]
=20
 =3D=3D=3D Testing VPC with chs force =3D=3D=3D
=20
-126.998 GiB (0x1fbfe04000) bytes not allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 136363130880, "depth": 0, "zero": true, "data": f=
alse }]
=20
 =3D=3D=3D Testing Hyper-V Autodetect =3D=3D=3D
=20
-127 GiB (0x1fc0000000) bytes not allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 136365211648, "depth": 0, "zero": true, "data": f=
alse }]
=20
 =3D=3D=3D Testing Hyper-V with current_size force =3D=3D=3D
=20
-127 GiB (0x1fc0000000) bytes not allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 136365211648, "depth": 0, "zero": true, "data": f=
alse }]
=20
 =3D=3D=3D Testing Hyper-V with chs force =3D=3D=3D
=20
-126.998 GiB (0x1fbfe04000) bytes not allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 136363130880, "depth": 0, "zero": true, "data": f=
alse }]
=20
 =3D=3D=3D Testing d2v Autodetect =3D=3D=3D
=20
-251.250 MiB (0xfb40000) bytes     allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 2097152, "depth": 0, "zero": false, "data": true,=
 "offset": OFFSET },
+{ "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data": =
true, "offset": OFFSET },
+{ "start": 4194304, "length": 2097152, "depth": 0, "zero": false, "data": =
true, "offset": OFFSET },
+{ "start": 6291456, "length": 2097152, "depth": 0, "zero": false, "data": =
true, "offset": OFFSET },
+{ "start": 8388608, "length": 2097152, "depth": 0, "zero": false, "data": =
true, "offset": OFFSET },
+{ "start": 10485760, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 12582912, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 14680064, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 16777216, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 18874368, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 20971520, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 23068672, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 25165824, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 27262976, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 29360128, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 31457280, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 33554432, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 35651584, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 37748736, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 39845888, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 41943040, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 44040192, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 46137344, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 48234496, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 50331648, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 52428800, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 54525952, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 56623104, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 58720256, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 60817408, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 62914560, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 65011712, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 67108864, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 69206016, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 71303168, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 73400320, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 75497472, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 77594624, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 79691776, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 81788928, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 83886080, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 85983232, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 88080384, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 90177536, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 92274688, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 94371840, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 96468992, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 98566144, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 100663296, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 102760448, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 104857600, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 106954752, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 109051904, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 111149056, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 113246208, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 115343360, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 117440512, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 119537664, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 121634816, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 123731968, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 125829120, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 127926272, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 130023424, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 132120576, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 134217728, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 136314880, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 138412032, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 140509184, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 142606336, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 144703488, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 146800640, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 148897792, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 150994944, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 153092096, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 155189248, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 157286400, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 159383552, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 161480704, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 163577856, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 165675008, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 167772160, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 169869312, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 171966464, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 174063616, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 176160768, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 178257920, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 180355072, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 182452224, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 184549376, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 186646528, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 188743680, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 190840832, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 192937984, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 195035136, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 197132288, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 199229440, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 201326592, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 203423744, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 205520896, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 207618048, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 209715200, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 211812352, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 213909504, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 216006656, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 218103808, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 220200960, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 222298112, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 224395264, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 226492416, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 228589568, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 230686720, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 232783872, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 234881024, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 236978176, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 239075328, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 241172480, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 243269632, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 245366784, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 247463936, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 249561088, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 251658240, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 253755392, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 255852544, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 257949696, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 260046848, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 262144000, "length": 1310720, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET }]
=20
 =3D=3D=3D Testing d2v with current_size force =3D=3D=3D
=20
-251.250 MiB (0xfb40000) bytes     allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 2097152, "depth": 0, "zero": false, "data": true,=
 "offset": OFFSET },
+{ "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data": =
true, "offset": OFFSET },
+{ "start": 4194304, "length": 2097152, "depth": 0, "zero": false, "data": =
true, "offset": OFFSET },
+{ "start": 6291456, "length": 2097152, "depth": 0, "zero": false, "data": =
true, "offset": OFFSET },
+{ "start": 8388608, "length": 2097152, "depth": 0, "zero": false, "data": =
true, "offset": OFFSET },
+{ "start": 10485760, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 12582912, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 14680064, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 16777216, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 18874368, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 20971520, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 23068672, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 25165824, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 27262976, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 29360128, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 31457280, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 33554432, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 35651584, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 37748736, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 39845888, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 41943040, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 44040192, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 46137344, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 48234496, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 50331648, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 52428800, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 54525952, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 56623104, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 58720256, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 60817408, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 62914560, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 65011712, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 67108864, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 69206016, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 71303168, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 73400320, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 75497472, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 77594624, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 79691776, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 81788928, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 83886080, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 85983232, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 88080384, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 90177536, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 92274688, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 94371840, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 96468992, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 98566144, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 100663296, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 102760448, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 104857600, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 106954752, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 109051904, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 111149056, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 113246208, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 115343360, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 117440512, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 119537664, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 121634816, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 123731968, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 125829120, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 127926272, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 130023424, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 132120576, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 134217728, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 136314880, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 138412032, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 140509184, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 142606336, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 144703488, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 146800640, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 148897792, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 150994944, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 153092096, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 155189248, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 157286400, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 159383552, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 161480704, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 163577856, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 165675008, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 167772160, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 169869312, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 171966464, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 174063616, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 176160768, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 178257920, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 180355072, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 182452224, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 184549376, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 186646528, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 188743680, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 190840832, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 192937984, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 195035136, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 197132288, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 199229440, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 201326592, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 203423744, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 205520896, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 207618048, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 209715200, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 211812352, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 213909504, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 216006656, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 218103808, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 220200960, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 222298112, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 224395264, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 226492416, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 228589568, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 230686720, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 232783872, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 234881024, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 236978176, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 239075328, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 241172480, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 243269632, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 245366784, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 247463936, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 249561088, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 251658240, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 253755392, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 255852544, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 257949696, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 260046848, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 262144000, "length": 1310720, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET }]
=20
 =3D=3D=3D Testing d2v with chs force =3D=3D=3D
=20
-251.250 MiB (0xfb40000) bytes     allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 2097152, "depth": 0, "zero": false, "data": true,=
 "offset": OFFSET },
+{ "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data": =
true, "offset": OFFSET },
+{ "start": 4194304, "length": 2097152, "depth": 0, "zero": false, "data": =
true, "offset": OFFSET },
+{ "start": 6291456, "length": 2097152, "depth": 0, "zero": false, "data": =
true, "offset": OFFSET },
+{ "start": 8388608, "length": 2097152, "depth": 0, "zero": false, "data": =
true, "offset": OFFSET },
+{ "start": 10485760, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 12582912, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 14680064, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 16777216, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 18874368, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 20971520, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 23068672, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 25165824, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 27262976, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 29360128, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 31457280, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 33554432, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 35651584, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 37748736, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 39845888, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 41943040, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 44040192, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 46137344, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 48234496, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 50331648, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 52428800, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 54525952, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 56623104, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 58720256, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 60817408, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 62914560, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 65011712, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 67108864, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 69206016, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 71303168, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 73400320, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 75497472, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 77594624, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 79691776, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 81788928, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 83886080, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 85983232, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 88080384, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 90177536, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 92274688, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 94371840, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 96468992, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 98566144, "length": 2097152, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET },
+{ "start": 100663296, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 102760448, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 104857600, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 106954752, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 109051904, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 111149056, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 113246208, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 115343360, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 117440512, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 119537664, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 121634816, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 123731968, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 125829120, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 127926272, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 130023424, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 132120576, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 134217728, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 136314880, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 138412032, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 140509184, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 142606336, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 144703488, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 146800640, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 148897792, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 150994944, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 153092096, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 155189248, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 157286400, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 159383552, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 161480704, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 163577856, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 165675008, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 167772160, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 169869312, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 171966464, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 174063616, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 176160768, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 178257920, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 180355072, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 182452224, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 184549376, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 186646528, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 188743680, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 190840832, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 192937984, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 195035136, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 197132288, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 199229440, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 201326592, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 203423744, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 205520896, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 207618048, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 209715200, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 211812352, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 213909504, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 216006656, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 218103808, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 220200960, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 222298112, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 224395264, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 226492416, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 228589568, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 230686720, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 232783872, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 234881024, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 236978176, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 239075328, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 241172480, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 243269632, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 245366784, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 247463936, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 249561088, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 251658240, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 253755392, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 255852544, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 257949696, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 260046848, "length": 2097152, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET },
+{ "start": 262144000, "length": 1310720, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET }]
=20
 =3D=3D=3D Testing Image create, default =3D=3D=3D
=20
@@ -42,15 +417,15 @@ Formatting 'TEST_DIR/IMGFMT-create-test.IMGFMT', fmt=
=3DIMGFMT size=3D4294967296
=20
 =3D=3D=3D Read created image, default opts =3D=3D=3D=3D
=20
-4 GiB (0x10007a000) bytes not allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 4295467008, "depth": 0, "zero": true, "data": fal=
se }]
=20
 =3D=3D=3D Read created image, force_size_calc=3Dchs =3D=3D=3D=3D
=20
-4 GiB (0x10007a000) bytes not allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 4295467008, "depth": 0, "zero": true, "data": fal=
se }]
=20
 =3D=3D=3D Read created image, force_size_calc=3Dcurrent_size =3D=3D=3D=3D
=20
-4 GiB (0x10007a000) bytes not allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 4295467008, "depth": 0, "zero": true, "data": fal=
se }]
=20
 =3D=3D=3D Testing Image create, force_size =3D=3D=3D
=20
@@ -58,13 +433,13 @@ Formatting 'TEST_DIR/IMGFMT-create-test.IMGFMT', fmt=
=3DIMGFMT size=3D4294967296
=20
 =3D=3D=3D Read created image, default opts =3D=3D=3D=3D
=20
-4 GiB (0x100000000) bytes not allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 4294967296, "depth": 0, "zero": true, "data": fal=
se }]
=20
 =3D=3D=3D Read created image, force_size_calc=3Dchs =3D=3D=3D=3D
=20
-4 GiB (0x100000000) bytes not allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 4294967296, "depth": 0, "zero": true, "data": fal=
se }]
=20
 =3D=3D=3D Read created image, force_size_calc=3Dcurrent_size =3D=3D=3D=3D
=20
-4 GiB (0x100000000) bytes not allocated at offset 0 bytes (0x0)
+[{ "start": 0, "length": 4294967296, "depth": 0, "zero": true, "data": fal=
se }]
 *** done

--------------A5B7E422761F7B4B0E634F5A--

--HW1rm0ngjTk6mUzghfIHQ9VF0fGZHqJYF--

--2V2R4JIZLIoLqfBLnqgWXMFZRtLdCBiz3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8C4JUACgkQ9AfbAGHV
z0AQvQf/en/99KSNtnOjQzr7XYDbV76W+NkPAST1y+ist+eUIwjPHYFvQqA+/RmV
mn4XDZ6uvHY1KCZbvsZmuErj0ep617ZBtaB/eGB3MZ1iE/88SJ8d1+ip+gV2aujB
FwFdYi5hR70sDSiPkQhXFte00zZk1+jNMR0VDOZ4TWHSLqffT9ihQNI5fyCBOrVF
GH/Q14olXkqm24Qg98IngUquJ2vxm0NMeTBcQXQ2ISbXBxE7tbyrAVGmjjKQRw/h
/MOoGqeL2RQ2oD0wT87ZDoT0uyXgVaqvDbFnC3xJbF99B3PlOLeikvvUNaVnSkws
1flEg7MLlnm0oCVde0tgw5z5reZB3Q==
=+DB3
-----END PGP SIGNATURE-----

--2V2R4JIZLIoLqfBLnqgWXMFZRtLdCBiz3--



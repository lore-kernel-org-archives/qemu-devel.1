Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8994BC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 15:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53544206E6
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 15:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AH7vLd0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53544206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYAXj-0001rz-Im
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 11:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYAVh-0008FT-PJ
 for qemu-devel@nongnu.org; Mon, 11 May 2020 11:38:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42771
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYAVg-0008IL-Lh
 for qemu-devel@nongnu.org; Mon, 11 May 2020 11:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589211508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MHJmf2NdLuq5b+i20PQWwjyjXIneCTtHhIA7/7G7HAE=;
 b=AH7vLd0qT2l4WpQM4ikIl83Qdw4lpBFznGJN83GfE6n3O/tXisyMRwrEhWG4BVPVWYBl3H
 NZc9OnPXv+pbzoDxghiKf+phTBxfuj3QXEsjKTu0fH2JiNcKVDb6FIf3n7CTSLoh4R91rN
 HTqo24XAYNxTowOI2Y+VKjS8NcPoCKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-Fz0oL14ENHWVz2VXs5TKFA-1; Mon, 11 May 2020 11:38:24 -0400
X-MC-Unique: Fz0oL14ENHWVz2VXs5TKFA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB92B8005B7;
 Mon, 11 May 2020 15:38:22 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-247.ams2.redhat.com
 [10.36.113.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F29E475277;
 Mon, 11 May 2020 15:37:32 +0000 (UTC)
Subject: Re: [PATCH v2 1/4] iotests/109: Don't mirror with mismatched size
To: Kevin Wolf <kwolf@redhat.com>
References: <20200511135825.219437-1-kwolf@redhat.com>
 <20200511135825.219437-2-kwolf@redhat.com>
 <8bd8e50f-30b8-f3b7-acd1-6f2cfb32a2f3@redhat.com>
 <20200511152942.GE5661@linux.fritz.box>
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
Message-ID: <e46c5b22-1e5e-384f-7ad4-00785118d207@redhat.com>
Date: Mon, 11 May 2020 17:37:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511152942.GE5661@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="J6UpmKnjrHfTzOHSOFyldpYXtz0aEQ2ay"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 01:43:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J6UpmKnjrHfTzOHSOFyldpYXtz0aEQ2ay
Content-Type: multipart/mixed; boundary="VxkfzkdqQdLIgfZMqtpx9d4eGuGzG5i05"

--VxkfzkdqQdLIgfZMqtpx9d4eGuGzG5i05
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.05.20 17:29, Kevin Wolf wrote:
> Am 11.05.2020 um 17:08 hat Max Reitz geschrieben:
>> On 11.05.20 15:58, Kevin Wolf wrote:
>>> This patch makes the raw image the same size as the file in a different
>>> format that is mirrored as raw to it to avoid errors when mirror starts
>>> to enforce that source and target are the same size.
>>>
>>> We check only that the first 512 bytes are zeroed (instead of 64k)
>>> because some image formats create image files that are smaller than 64k=
,
>>> so trying to read 64k would result in I/O errors. Apart from this, 512
>>> is more appropriate anyway because the raw format driver protects
>>> specifically the first 512 bytes.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  tests/qemu-iotests/109           | 10 ++---
>>>  tests/qemu-iotests/109.out       | 74 +++++++++++++-------------------
>>>  tests/qemu-iotests/common.filter |  5 +++
>>>  3 files changed, 41 insertions(+), 48 deletions(-)
>>>
>>> diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
>>> index 5bc2e9b001..3ffeaf3c55 100755
>>> --- a/tests/qemu-iotests/109
>>> +++ b/tests/qemu-iotests/109
>>> @@ -77,14 +77,14 @@ for fmt in qcow qcow2 qed vdi vmdk vpc; do
>>>      echo "=3D=3D=3D Writing a $fmt header into raw =3D=3D=3D"
>>>      echo
>>> =20
>>> -    _make_test_img 64M
>>>      TEST_IMG=3D"$TEST_IMG.src" IMGFMT=3D$fmt _make_test_img 64M
>>> +    _make_test_img $(du -b "$TEST_IMG.src" | cut -f1) | _filter_img_cr=
eate_size
>>
>> Why du and not the file length (stat -c '%s')?
>=20
> Because the test from which I copied had 'du' and the internet claimed
> that 'stat -c' isn't portable. Now I see that we do use it in other test
> cases, so I guess it would have been fine, too. Is there a good reason
> why 'stat' would be better?

Oh, I didn=92t know that du -b reports the file length.  Well, then that
works, too.  (I=92ve never seen du used for anything but getting the,
well, disk usage.)

(I figured -b would just report the size in bytes.)

Then:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--VxkfzkdqQdLIgfZMqtpx9d4eGuGzG5i05--

--J6UpmKnjrHfTzOHSOFyldpYXtz0aEQ2ay
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl65cS0ACgkQ9AfbAGHV
z0C1mQgAuyPnI/2ItMYzZO+YN5rRaqTu8KwbtSFzOe6rPEuKmMr+Ix8XFyOci7go
pxNrls+75wa6mspdtWZmX4KysoEOfLXi4yTash8IeLoe0a5EWYB0HIX8S+m1yuv6
aSjyLTMEDTYnsQCSaNi1xoMD35vZEytOqShXkT9BLVpKi0mz66wuVPcboTpYHcvx
wxQ+k/mXSnRDTO+Y4EeLCwO/hR75AMzPh3SCVFvoFSn5R7eHVOjXRTRa1+ut7G2y
FOKxBMDG5Wdc4lPno/qnbbnPXS8s04MpElI9F3xgm2UDvAXQI3s7iV4uaLmSH7fP
DsPKcoWbfWUZM7O90iLQ9JyPfNAz8g==
=16sy
-----END PGP SIGNATURE-----

--J6UpmKnjrHfTzOHSOFyldpYXtz0aEQ2ay--



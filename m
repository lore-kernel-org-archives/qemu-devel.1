Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B241C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:36:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 635672192A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpSoC+3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635672192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHkuS-0002hh-9L
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 05:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kHktk-0002B9-An
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:35:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23908
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kHkti-0002jA-3Z
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600076140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=40YcTBTWzoEKip1a4Wpc6v4QqSVy4HCvTuKbTR20jZE=;
 b=hpSoC+3VyvwIERTXJlhz3ipXO5Q7uuUBBpqhwPStvdgMaAFXwS1pnGCELPOHCVDtKmYRAQ
 s+y8JJyUr4i0L3KccMSA8tWe/jEAXyMdwXpTV9LuTCMlEsJvZhcx1oUWRAy4HFNV9PQ+jX
 Gqh109bUgEP181rNXX/earuBJQFM2no=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-xk-wlHlTM-SHuZ00j4s6Ew-1; Mon, 14 Sep 2020 05:35:38 -0400
X-MC-Unique: xk-wlHlTM-SHuZ00j4s6Ew-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82FA71007468;
 Mon, 14 Sep 2020 09:35:37 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-80.ams2.redhat.com
 [10.36.114.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01720100EBB8;
 Mon, 14 Sep 2020 09:35:35 +0000 (UTC)
Subject: Re: [PATCH] qemu-img: Support bitmap --merge into backing image
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200909123358.1244744-1-eblake@redhat.com>
 <32a96bcc-78de-a13e-c090-ad00c3b4c4ad@redhat.com>
 <b8bb3e55-2f23-798a-b0c7-843067e19dfd@redhat.com>
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
Message-ID: <9ba3cbc3-e4a7-66e2-c1d7-daa1ea886fa8@redhat.com>
Date: Mon, 14 Sep 2020 11:35:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <b8bb3e55-2f23-798a-b0c7-843067e19dfd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="It2OsULukM4dcgXB8cA0QHTZBc9iaQrCD"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:36:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eyal Shenitzky <eshenitz@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--It2OsULukM4dcgXB8cA0QHTZBc9iaQrCD
Content-Type: multipart/mixed; boundary="rml15fYGESwKuTAxJR5PmXJDZX7UeWKHn"

--rml15fYGESwKuTAxJR5PmXJDZX7UeWKHn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.09.20 17:17, Eric Blake wrote:
> On 9/11/20 3:31 AM, Max Reitz wrote:
>> On 09.09.20 14:33, Eric Blake wrote:
>>> If you have the chain 'base.qcow2 <- top.qcow2' and want to merge a
>>> bitmap from top into base, qemu-img was failing with:
>>>
>>> qemu-img: Could not open 'top.qcow2': Could not open backing file:
>>> Failed to get shared "write" lock
>>> Is another process using the image [base.qcow2]?
>>>
>>> The easiest fix is to not open the entire backing chain of the source
>>> image, so that we aren't worrying about competing BDS visiting the
>>> backing image as both a read-only backing of the source and the
>>> writeable destination.
>>>
>>> Fixes: http://bugzilla.redhat.com/1877209
>>> Reported-by: Eyal Shenitzky <eshenitz@redhat.com>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>>> =C2=A0 qemu-img.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +-
>>> =C2=A0 tests/qemu-iotests/291=C2=A0=C2=A0=C2=A0=C2=A0 | 12 ++++++++
>>> =C2=A0 tests/qemu-iotests/291.out | 56 ++++++++++++++++++++++++++++++++=
++++++
>>> =C2=A0 3 files changed, 70 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qemu-img.c b/qemu-img.c
>>> index eb2fc1f86243..b15098a2f9b3 100644
>>> --- a/qemu-img.c
>>> +++ b/qemu-img.c
>>> @@ -4755,7 +4755,8 @@ static int img_bitmap(int argc, char **argv)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs =3D blk_bs(blk);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (src_filename) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 src =3D img_open(false, src=
_filename, src_fmt, 0, false,
>>> false, false);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 src =3D img_open(false, src=
_filename, src_fmt, BDRV_O_NO_BACKING,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 false, fals=
e, false);
>>
>> Why not do the same for the destination BB?
>=20
> Yeah, that should work, too.
>=20
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!src) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto out;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> diff --git a/tests/qemu-iotests/291 b/tests/qemu-iotests/291
>>> index 1e0bb76959bb..4f837b205655 100755
>>> --- a/tests/qemu-iotests/291
>>> +++ b/tests/qemu-iotests/291
>>
>> [...]
>>
>>> @@ -107,6 +116,9 @@ $QEMU_IMG map --output=3Djson --image-opts \
>>> =C2=A0 nbd_server_start_unix_socket -r -f qcow2 -B b2 "$TEST_IMG"
>>> =C2=A0 $QEMU_IMG map --output=3Djson --image-opts \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap=
:b2" | _filter_qemu_img_map
>>> +nbd_server_start_unix_socket -r -f qcow2 -B b3 "$TEST_IMG"
>>
>> Why not look into $TEST_IMG.base to see specifically whether the bitmap
>> is there?
>=20
> We did just that, several lines earlier, with the qemu-img info
> --backing-chain.

OK, perfect.

>>
>> (I also am quite surprised that it=E2=80=99s even possible to export bit=
maps
>> from backing nodes, but, well.)
>=20
> I actually ought to call that out in the commit message.=C2=A0 It used to=
 be
> that we were inconsistent on what we could see from the backing chain (a
> filter would make it so we can't), but as soon as your filter patches
> land, then we _do_ want to always be able to find a bitmap from the
> backing chain (incremental backup depends on that: we create an overlay
> disk to run the block-copy job as a filter, and _want_ to expose that
> overlay image with the bitmap it inherits from the original image).=C2=A0=
 So
> being able to export bitmaps from a backing node is normally a feature;
> and it is only in 'qemu-img bitmap' where we don't want accidental
> inheritance to get in the way from what we are actually merging.

Understood.

Max


--rml15fYGESwKuTAxJR5PmXJDZX7UeWKHn--

--It2OsULukM4dcgXB8cA0QHTZBc9iaQrCD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9fOWYACgkQ9AfbAGHV
z0C7NggAi92M3AItC1sYnh+8tpuGxLCWypXQ10p4VFqA10/ESw3mcanXbvWpiwyg
GsnU5NWtJVyvif2nyfEzh3YVtc8o2eN9tV0xl6DmjnCSk3f/7EyryDLwbpmDu1zY
GzjUcmk4yLgzYcsK3W3iDPGmUxcO4JM+7Ddwy5AOQdprQwLTGiOGFzIYxYj505U0
urIzhKWmsQhz/Cp2ZZMNhd98lhx0jjQbtMj+qxTI5ZMZkooEBiunpXP3yygD/w13
eP2Qe97/L+oSPFavPpnGRnr/XQsBgrcTgIYVC5xm4dI8uH5z25D8IQQgi8J8BbtU
uFNuh44OdIhs1Ay8AO6QGAHEib729A==
=hOyW
-----END PGP SIGNATURE-----

--It2OsULukM4dcgXB8cA0QHTZBc9iaQrCD--



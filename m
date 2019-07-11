Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2D1C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:24:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 332BD20872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332BD20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlY83-0002wK-Ce
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 08:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51815)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlY7K-0002JT-RJ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlY7I-0004s0-7a
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:24:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44294)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlY7E-0004ny-Tt; Thu, 11 Jul 2019 08:24:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 30689C057F2E;
 Thu, 11 Jul 2019 12:24:00 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EAD4D1001B00;
 Thu, 11 Jul 2019 12:23:57 +0000 (UTC)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190710170349.1548-1-mlevitsk@redhat.com>
 <84232589-627a-8151-a3d5-84c053d9a257@redhat.com>
 <20190711092031.GB11930@redhat.com>
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
Message-ID: <4af9b328-f74b-50db-f130-3ce551239e14@redhat.com>
Date: Thu, 11 Jul 2019 14:23:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190711092031.GB11930@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dfvQSI82xShk9DBo3k96bes5ZR0jPxzo4"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 11 Jul 2019 12:24:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] LUKS: support preallocation in qemu-img
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dfvQSI82xShk9DBo3k96bes5ZR0jPxzo4
Content-Type: multipart/mixed; boundary="9RgCwFplqr9LCZBqM6lUVGEIWf4J1iiv6";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <4af9b328-f74b-50db-f130-3ce551239e14@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] LUKS: support preallocation in qemu-img
References: <20190710170349.1548-1-mlevitsk@redhat.com>
 <84232589-627a-8151-a3d5-84c053d9a257@redhat.com>
 <20190711092031.GB11930@redhat.com>
In-Reply-To: <20190711092031.GB11930@redhat.com>

--9RgCwFplqr9LCZBqM6lUVGEIWf4J1iiv6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.07.19 11:20, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Jul 10, 2019 at 11:24:46PM +0200, Max Reitz wrote:
>> On 10.07.19 19:03, Maxim Levitsky wrote:
>>> preallocation=3Doff and preallocation=3Dmetadata
>>> both allocate luks header only, and preallocation=3Dfalloc/full
>>> is passed to underlying file, with the given image size.
>>>
>>> Note that the actual preallocated size is a bit smaller due
>>> to luks header.
>>
>> Couldn=E2=80=99t you just preallocate it after creating the crypto hea=
der so
>> qcrypto_block_get_payload_offset(crypto->block) + size is the actual
>> file size?
>=20
> Yeah that would be preferrable. If that's really not possible, we
> could likely provide some API to query the expected hreader size for
> a given set of creation options.=20
>=20
>>
>>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534951
>>>
>>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>>> ---
>>>  block/crypto.c | 28 ++++++++++++++++++++++++++--
>>>  1 file changed, 26 insertions(+), 2 deletions(-)
>>
>> Hm.  I would expect a preallocated image to read 0.  But if you just
>> pass this through to the protocol layer, it won=E2=80=99t read 0.
>=20
> Yes, it will be zeros at the physical layer, but unintelligble
> garbage from POV of the virtual disk.
>=20
> I don't think this is really a problem though - this is what you
> get already if you create a LUKS volume on top of a block device
> today.

Which is why we have BlockDriver.bdrv_has_zero_init(), which the LUKS
driver does not implement, hence it being treated as false.

But if you are preallocating, you have a choice of what you write, and
why not make that zeroes?

> AFAIK, we've not documented that preallocation guarantees future
> reads will return zeros. Preallocation simply ensures that all
> required space is allocated upfront. We do mention that it might
> be achieved by writing zeros to the underlying storage but never
> said you'll get zeros back.

But we have, as I wrote in my second reply.  PreallocMode's
documentation says that at least =E2=80=9Cfull=E2=80=9D is writing zeroes=
, and to say
those zeroes can be anywhere in the stack is cheating, from my POV.

> IOW I think its at most a docs problem to more clearly explain
> that preallocation !=3D guaranteed zeros for reads.
>=20
>> (In fact, I don=E2=80=99t even quite see the point of having LUKS as a=
n own
>> format still.  It was useful when qcow2 didn=E2=80=99t have LUKS suppo=
rt, but
>> now it does, so...  I suppose everyone using the LUKS format should
>> actually be using qcow2 with LUKS?)
>=20
> Certainly not. LUKS on raw is going to be very common, not least becaus=
e
> that's directly compatible with what Linux kernel supports. If you don'=
t
> want the features of qcow2 like snapshots, it just adds overhead and mg=
mt
> complexity for no gain, especially if dealing with block device backed
> storage (iSCSI, RBD).
>=20
> OpenStack will use cryptsetup when initializing its block storage with
> LUKS, then tell QEMU to run with the raw + LUKS driver.

I see the compatibility with the Linux kernel, yes (as I wrote in my
second reply), but I=E2=80=99m not sure whether =E2=80=9Coverhead=E2=80=9D=
 really is that big of
a point when using encryption.

Max


--9RgCwFplqr9LCZBqM6lUVGEIWf4J1iiv6--

--dfvQSI82xShk9DBo3k96bes5ZR0jPxzo4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0nKlsACgkQ9AfbAGHV
z0D+0Qf/dVdf53xNBSn+mq4GwR3zXlNAjewUs3MoBCv25GBvF+yKVnkdCU/euNbl
oVI2hYDu3bkjUZSJx1snwTqomv1MvJbtQDvwQ6A2xTU9XJ8CTLYQEmu/KkCTzLyh
qHnMovYugXnbCRaoary9hUlJczXup76Elrw7GyxkoiTjg+z9El1Ifz9+4U8I6z5R
zySVPIDVe5ffq572UZW6ZEi9ir9Iq6DcH5sH7mXFkw1HcRNpynRu4u6TOzsykBcK
MmIf9S99K7K+5zdJi2RCI7GtF1QqoxbjQUdxxbcRlxlom65nzfH+mUa5NJHGgasn
JUmry6ynObkA0sS6EpdEj/PHfPPYJg==
=eEnC
-----END PGP SIGNATURE-----

--dfvQSI82xShk9DBo3k96bes5ZR0jPxzo4--


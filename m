Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26DFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB1CD2051A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NnmRM0bV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB1CD2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iudLh-00039U-At
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iubqp-0000K0-K5
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:44:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iubqo-0007vv-D7
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:44:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40104
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iubqo-0007uu-82
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579783485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+koljWVKn8g07HRSUoUOLZ7KTyqbfsbxQyVP/IhRrek=;
 b=NnmRM0bV02XZyK6cBPEU3AZQj3BkKFbKUzzYJuAOFYPkA4b30fxQr4SncED7LPP3OPw3I4
 n4GpPEVZdgh+kd1tXxabp7844p5JdIauC0z7RqtU6zHnV5TVXVto7v98JDV57/ofB+V9Yf
 8boPl79m+hsPJ+kVeblldEAZrWa/Sx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-v_nQOZcJPbmBlfynKScVhA-1; Thu, 23 Jan 2020 07:44:43 -0500
X-MC-Unique: v_nQOZcJPbmBlfynKScVhA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B55C18C43C1;
 Thu, 23 Jan 2020 12:44:42 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C0925C1BB;
 Thu, 23 Jan 2020 12:44:38 +0000 (UTC)
Subject: Re: [PATCH] qemu-nbd: Removed deprecated --partition option
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200122214328.1413664-1-eblake@redhat.com>
 <bcf38c8e-c207-73bd-8707-44b500ef3fa2@redhat.com>
 <7084da4a-fa6a-e4ab-868d-2ad397dd5cb3@redhat.com>
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
Message-ID: <24c7b6e3-40dd-cbae-053d-ebc03babaf9f@redhat.com>
Date: Thu, 23 Jan 2020 13:44:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <7084da4a-fa6a-e4ab-868d-2ad397dd5cb3@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Niagb6s3Q55CyUrXmHTIJWDptYdHMtTun"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: "reviewer:Incompatible changes" <libvir-list@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Niagb6s3Q55CyUrXmHTIJWDptYdHMtTun
Content-Type: multipart/mixed; boundary="OpD2anNmo0ql0HR87Zc68XhG2ilZZXL9l"

--OpD2anNmo0ql0HR87Zc68XhG2ilZZXL9l
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.01.20 13:30, Eric Blake wrote:
> On 1/23/20 6:10 AM, Max Reitz wrote:
>> On 22.01.20 22:43, Eric Blake wrote:
>>> The option was deprecated in 4.0.0 (commit 0ae2d546); it's now been
>>> long enough with no complaints to follow through with that process.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>=20
>>> -@code{qemu-nbd -t -P 1 -f qcow2 file.qcow2}
>>> -
>>> -can be rewritten as:
>>> -
>>> -@code{qemu-nbd -t --image-opts
>>> driver=3Draw,offset=3D1M,size=3D100M,file.driver=3Dqcow2,file.backing.d=
river=3Dfile,file.backing.filename=3Dfile.qcow2}
>>>
>>> -
>=20
>>> +can be rewritten as:
>>> +
>>> +@code{qemu-nbd -t --image-opts
>>> driver=3Draw,offset=3D1M,size=3D100M,file.driver=3Dqcow2,file.backing.d=
river=3Dfile,file.backing.filename=3Dfile.qcow2}
>>>
>>
>> I know you just moved it from above, but isn=E2=80=99t this wrong?=C2=A0=
 Shouldn=E2=80=99t it
>> be s/backing/file/g?
>=20
> Indeed; file.file.driver=3Dfile,file.file.filename=3Dfile.qcow2 is requir=
ed
> for it to work, rather than fail with
> qemu-nbd: Failed to blk_new_open
> 'driver=3Draw,offset=3D1m,size=3D100m,file.driver=3Dqcow2,file.backing.dr=
iver=3Dfile,file.backing.filename=3Dfile4':
> A block device must be specified for "file"
>=20
> I'll repost with the bug-fix as a separate commit (and it's a shame that
> we've gone nearly a year with no one noticing the typo in the original).

It was actually meant as a service to our users!  So they can=E2=80=99t jus=
t
blindly copy-paste the example but have to think it through.  And the
fact that noone has complained shows that our users indeed didn=E2=80=99t l=
et
themselves be caught off-guard!  /s O:-)

Thanks!

Max


--OpD2anNmo0ql0HR87Zc68XhG2ilZZXL9l--

--Niagb6s3Q55CyUrXmHTIJWDptYdHMtTun
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4plTQACgkQ9AfbAGHV
z0D5cQf7BlW5d3/Lk4XLE/77DB8g2yNXl4gCWZf99THVZsXS+nWREjV+tso1kYKm
L9PZ0k9K5hYzTDsKlvBcY30mmuLkhEr1KKNNJlY/M2GSJw1rPXWVFIx8zz9Q+0Iw
nmW9msKotE7sVFkTy962fgVmstyJpyNomAqN5rZRh7wBG2BSJwikXELKeTQyfF6w
KPUmzirq6N6VrTm9xJcPBmjpsCPEYt9ym385Mw5r86Ekktit5RW22cB3xNhEAFDl
HHt2X3NXuUcObvQuBBudl3aDAuu0Raq6SU1OoWc4xkBUZXzjeOzjIu3/6cXVm27X
jxtnjOEBE9QZ0kxAGfUbkia2cEXI3g==
=ugYU
-----END PGP SIGNATURE-----

--Niagb6s3Q55CyUrXmHTIJWDptYdHMtTun--



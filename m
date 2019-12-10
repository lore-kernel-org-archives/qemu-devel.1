Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC23C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 972FF2073B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPpuC5gN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972FF2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iefW8-0000Gn-NZ
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 08:25:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iefVF-0008Ct-FY
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 08:24:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iefVC-000746-IP
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 08:24:35 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45812
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iefVC-00073o-DS
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 08:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575984273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IYTXgczvxycgWbr//6cHzRQTvnrhKetsFZfSsUVKdp4=;
 b=WPpuC5gNw1406vwys6AdiGNa6xzkHnV/5U/DKQR/JGxsgLfG4+mLdDcImxT4NtbsUuB4qr
 L2CJPUC/gEO6FaIkpjJ0FPfuk5FpveGHngJaJN1V7FTHg1BD/SQsnHtnLUK3kipOAr1N4z
 T6kdfywygXFifa1GCeUS+reSF5xfQmo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-iEcd2M_PMTSPFpAOx-lLbQ-1; Tue, 10 Dec 2019 08:24:30 -0500
X-MC-Unique: iEcd2M_PMTSPFpAOx-lLbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4F441800D45;
 Tue, 10 Dec 2019 13:24:28 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-54.ams2.redhat.com
 [10.36.117.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E881600D3;
 Tue, 10 Dec 2019 13:24:24 +0000 (UTC)
Subject: Re: [bugfix ping2] Re: [PATCH v2 0/2] fix
 qcow2_can_store_new_dirty_bitmap
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191014115126.15360-1-vsementsov@virtuozzo.com>
 <e89b8844-26c7-0768-f6dd-6faa814551e2@virtuozzo.com>
 <0db82122-ee0d-a346-cb49-d902d5d66b77@virtuozzo.com>
 <cbba2b12-da7d-eed8-1f6b-fc2412f82ff8@redhat.com>
 <a67b4a16-773c-52c8-288a-0e9e032b4589@redhat.com>
 <466a95d3-e808-02d1-94df-27bf1e4e13ee@redhat.com>
 <a7f98c9a-6b3e-c6a5-fd6d-96db14ed612f@redhat.com>
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
Message-ID: <3f84b0c2-c95d-f42e-9494-8d67ff3ebc28@redhat.com>
Date: Tue, 10 Dec 2019 14:24:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a7f98c9a-6b3e-c6a5-fd6d-96db14ed612f@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GIyll5VLYSNIavMXKh00qnzs7TuXvFYbC"
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GIyll5VLYSNIavMXKh00qnzs7TuXvFYbC
Content-Type: multipart/mixed; boundary="aD7sn1PqaydM3YfSMSBpBqBjbFqDnyGnu"

--aD7sn1PqaydM3YfSMSBpBqBjbFqDnyGnu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.12.19 09:11, Max Reitz wrote:
> On 09.12.19 23:03, Eric Blake wrote:
>> On 12/9/19 11:58 AM, Max Reitz wrote:
>>> On 09.12.19 17:30, Max Reitz wrote:
>>>> On 02.12.19 15:09, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Hi again!
>>>>>
>>>>> Still forgotten bug-fix :(
>>>>>
>>>>> Is it too late for 4.2?
>>>>
>>>> Sorry. :-/
>>>>
>>>> Yes, I think I just forgot it.=C2=A0 I don=E2=80=99t think it=E2=80=99=
s too important for
>>>> 4.2, so, well, it isn=E2=80=99t too bad, but...=C2=A0 Sorry.
>>>>
>>>>> I can't imagine better test, and it tests exactly what written in
>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1712636
>>>>>
>>>>> (Hmm, actually, I doubt that it is real use-case, more probably it's
>>>>> a bug in management layer)
>>>>>
>>>>> So, take this with test or without test, to 4.2 or 5.0.
>>>>
>>>> I was thinking of seeing whether I could write a quicker test, but of
>>>> course we should take the patch either way.
>>>
>>> OK, I give up.=C2=A0 It=E2=80=99s very much possible to create an image=
 with 65535
>>> bitmaps very quickly (like, under a second) outside of qemu, but just
>>> opening it takes 2:30 min (because of the quadratic complexity of
>>> checking whether a bitmap of the same name already exists).
>>
>> Can we fix that to use a hash table for amortized O(1) lookup rather
>> than the current O(n) lookup?
>=20
> Not unreasonable, considering that this is probably what we would=E2=80=
=99ve
> done from the start in any language where hash tables are built in.
>=20
> But OTOH when you have 66k bitmaps, you probably have other problems.
> Like, writes being incredibly slow, because all those bitmaps have to be
> updated.
>=20
> (Well, you can technically have 99 % of them disabled, but who=E2=80=99d =
do such
> a thing?)
>=20
> ((Maybe I=E2=80=99ll look into it.))

Hmm, now I did.  This gets the test down to 24 s.  Still not sure
whether it=E2=80=99s worth it, though...

Max


--aD7sn1PqaydM3YfSMSBpBqBjbFqDnyGnu--

--GIyll5VLYSNIavMXKh00qnzs7TuXvFYbC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3vnIYACgkQ9AfbAGHV
z0DPzQf/e1mCFlDMO96EEntllMpP8BMQ9XOJYTEj1DeNK1vao7mYu9aKwgfcoYgE
E27ULBrh99u50bqfWOUKjWnc8m+T/HDlRGICB+Ao1RIdfBH+iB/dpd6+4lI1JCqR
Ak7mcrwjwZgwEhlUxZwFgqzNgwmyZ/IkyWdKDb4P+N0nPmhYfXAUL/rN6GgYN4BO
npBFs2oqZoIH/9VmHDQFDJ6PM4Y6Ms48IHAalTGyrNo+ER45boEi5OtC69OUkW8j
tL2/YC7miNMHcO9zHt9HmzVi8x5qUTv6gB5s1vgp1iZFA/BnqWVv90rkO4r42VdB
PCimm9ZlL0ezBWo7r10rt6CnbQRHRA==
=6QbT
-----END PGP SIGNATURE-----

--GIyll5VLYSNIavMXKh00qnzs7TuXvFYbC--



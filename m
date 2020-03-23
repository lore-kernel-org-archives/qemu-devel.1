Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34EFC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB2912070A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKUH0Iws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2912070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGN8X-0004nR-So
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 09:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jGN60-0001Kn-GB
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:26:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jGN5y-0002CL-Oi
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:26:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:45428)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jGN5y-0002By-KR
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584969981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l5NcgyGNZC4upa0rMHDXqyY2EjbqnE6ZHwDiijcdglE=;
 b=GKUH0IwsQAQecUKPJGvP4GwlHwG1CMIqEhSdgFrtptbsB5TEwd8aKufXiPrEAHcSR5QZ7A
 l7+64E3kzEze3rjHwhHRXgUD14SnB4y2Efoz2ygvZ2Pn1XdKm9Yz1i6ygDmlzwUsPHNgPB
 vwD7l3znwLEpBGBO7DMhVZGQIElOJ7U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-YsIdbdO5O6KU9dp-vGDGDw-1; Mon, 23 Mar 2020 09:26:20 -0400
X-MC-Unique: YsIdbdO5O6KU9dp-vGDGDw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69FBB477;
 Mon, 23 Mar 2020 13:26:18 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-242.ams2.redhat.com
 [10.36.114.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACD3E65E80;
 Mon, 23 Mar 2020 13:26:15 +0000 (UTC)
Subject: Re: Coverity CID 1421984
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <d9b7d8d8-1640-7d69-cd16-66e6d9cef3d1@redhat.com>
 <88618db3-cb48-12bd-6152-b642b25a0287@redhat.com>
 <alpine.BSF.2.22.395.2003231359420.14974@zero.eik.bme.hu>
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
Message-ID: <4b6c74d7-6b3d-72a4-999a-1d97287fb324@redhat.com>
Date: Mon, 23 Mar 2020 14:26:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2003231359420.14974@zero.eik.bme.hu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3xBcQWVf5hOidamHo3ReXEfVPpMIHFqkC"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3xBcQWVf5hOidamHo3ReXEfVPpMIHFqkC
Content-Type: multipart/mixed; boundary="2bXRWpgtyG5oqMpZlvkoI4bcvW5MiOaJm"

--2bXRWpgtyG5oqMpZlvkoI4bcvW5MiOaJm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.03.20 14:11, BALATON Zoltan wrote:
> On Mon, 23 Mar 2020, Philippe Mathieu-Daud=C3=A9 wrote:
>> Cc'ing qemu-ppc since this is restricted to the aCube Sam460ex board.
>> On 3/23/20 12:46 PM, Max Reitz wrote:
>>> Hi,
>>>
>>> I was triaging new Coverity block layer reports today, and one that
>>> seemed like a real bug was CID 1421984:
>>>
>>> It complains about a memleak in sii3112_pci_realize() in
>>> hw/ide/sii3112.c, specifically about @irq being leaked (it=E2=80=99s al=
located
>>> by qemu_allocate_irqs(), but never put anywhere or freed).
>>>
>>> I=E2=80=99m not really well-versed in anything under hw/ide, so I was w=
ondering
>>> whether you agree it=E2=80=99s a bug and whether you know the correct w=
ay to fix
>>> it.=C2=A0 (I assume it=E2=80=99s just a g_free(irqs), but maybe there=
=E2=80=99s a more
>>> specific way that=E2=80=99s applicable here.)
>>
>> What does other devices is hold a reference in the DeviceState
>> (SiI3112PCIState) to make static analyzers happy.
>=20
> Other IDE devices such as ahci and cmd646 seem to free it at the end of
> the init function after calling ide_init2 with it. However it's not
> clear to me how all this is supposed to work. Ahci does for example:
>=20
> qemu_irq *irqs =3D qemu_allocate_irqs(ahci_irq_set, s, s->ports);
> for (i =3D 0; i < s->ports; i++) {
> =C2=A0=C2=A0=C2=A0 ide_init2(&ad->port, irqs[i]);
> }
> g_free(irqs);
>=20
> So it allocates an array of s->ports irqs then only frees a single
> element?

It doesn=E2=80=99t free a single element, it frees the array.

> Also aren't these needed after ide_init2 to actually raise the
> irq or are these end up copied to the irq field of the BMDMAState
> sonehow? Where will that be freed?

I don=E2=80=99t know where the array elements end up, but they aren=E2=80=
=99t freed by
the g_free().

(irqs is an array of pointers, so freeing the array does not touch its
elements, specifically it doesn=E2=80=99t free what those pointers point to=
.)

>> Ideally we should free such memory in the DeviceUnrealize handler, but
>> we in the reality we only care for hotunpluggable devices.
>> PCI devices usually are. There is a trick however, you can mark
>> overwrite the DeviceClass::hotpluggable field in sii3112_pci_class_init:
>>
>> =C2=A0dc->hotpluggable =3D false;
>=20
> If the above is correct then simply adding g_free(irq) after the loop at
> end of sii3112_pci_realize should be enough but I can't tell if that's
> correct. Setting hotpluggable to false does not seem to be a good fix.

Well, if other code just uses g_free(irqs), it sounds good to me.  But
again, I don=E2=80=99t know anything about this code so far.

Max


--2bXRWpgtyG5oqMpZlvkoI4bcvW5MiOaJm--

--3xBcQWVf5hOidamHo3ReXEfVPpMIHFqkC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl54uPUACgkQ9AfbAGHV
z0CzhAf5AVhUVZ7sAcmjeNU4GBPnDBU6SGGK2RibzkbuV0FDXmH01+mKG+UM1kAE
mIHTBRi3t+3fVpAGmo3nMmXZPdgfzDQ+EcWFCih/gsz55FHUtMUaaezUOngoNdls
Lez1RXXy9I1ZzTxbQmmI36EnGchqBNIS3m8oPBLHHD+grGIc+7QW/tKYXWaezbNe
yHfb9U9QSLj/8IntrAs1xpKgZF6V5hjhVAZ19Zn2BB4zsykSap8RE5m5ekpWiAD5
cJYUrIlH7E0yM+By/absBjNDeh6hU/1VL3TuMLCMS5KCcWevuC9gL1VFkUGf6lSi
n/kqG/zxComnIZDOMMCl16BgiOTqrQ==
=YcBS
-----END PGP SIGNATURE-----

--3xBcQWVf5hOidamHo3ReXEfVPpMIHFqkC--



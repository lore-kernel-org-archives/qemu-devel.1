Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65482C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30CE22166E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azu0lPlP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30CE22166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSNMS-0000YF-Dm
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 10:36:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSNLb-0008PC-VE
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:35:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSNLZ-0000rN-Sq
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:35:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51428
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSNLZ-0000qX-PC
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573054548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Roc1xTP3kElRyYr1DE2V4TKDdGBt6d4B5KYL93SM3sM=;
 b=azu0lPlPDcIjd/cUop/vERUXsCvXuvQ4KGGjBS7jnSVGzIAS7+kGDS2ghiQbM2EUkztNLZ
 juouBUhtsnoInqz+PirXvIT5Okih6lCKBm2CX2XlwKWyk8/S4z96nUTkgnSGfnmO9IOobo
 recdgdPbTdOKRfUDoMugq37vs+YpHD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-u2wT2gE5OBStKNk-Mw68qQ-1; Wed, 06 Nov 2019 10:35:44 -0500
X-MC-Unique: u2wT2gE5OBStKNk-Mw68qQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 704E8800C72;
 Wed,  6 Nov 2019 15:35:43 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-212.ams2.redhat.com
 [10.36.117.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7897C5D9E1;
 Wed,  6 Nov 2019 15:35:40 +0000 (UTC)
Subject: Re: [RFC PATCH 00/18] Add qemu-storage-daemon
To: Kevin Wolf <kwolf@redhat.com>
References: <20191017130204.16131-1-kwolf@redhat.com>
 <8a9a5eae-d388-867b-f4a1-080e876389b3@redhat.com>
 <20191106145800.GC7548@dhcp-200-226.str.redhat.com>
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
Message-ID: <9f7e1287-23ac-bf61-a808-a2462c0ce1d4@redhat.com>
Date: Wed, 6 Nov 2019 16:35:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191106145800.GC7548@dhcp-200-226.str.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Gs7VuMxNDSbqYdd4QboeA47n5685ezLmd"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: pkrempa@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Gs7VuMxNDSbqYdd4QboeA47n5685ezLmd
Content-Type: multipart/mixed; boundary="JkTNPg8cmoqVEaaeRDxELWsL3wCxZVE7U"

--JkTNPg8cmoqVEaaeRDxELWsL3wCxZVE7U
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.11.19 15:58, Kevin Wolf wrote:
> Am 06.11.2019 um 15:37 hat Max Reitz geschrieben:
>> On 17.10.19 15:01, Kevin Wolf wrote:
>>> This series adds a new tool 'qemu-storage-daemon', which can be used to
>>> export and perform operations on block devices.
>>
>> Looks good to me.
>>
>> I remember a discussion at some KVM Forum a couple of years ago where
>> someone (Berto?) was asking about adding QMP to qemu-nbd.  I found it a
>> pragmatic solution, but I remember that Markus was against it, based on
>> the fact that we wanted qemu -M none.
>=20
> Yes, but it turned out that qemu -M none is a bit too heavyweight in
> practice and fixing that would involve a lot of work. As I understand it
> (mostly what I took from discussions on the list), even if someone were
> interested in doing that and started now, it's the kind of thing that
> would take multiple years.

I didn=E2=80=99t want to give the impression I wouldn=E2=80=99t agree. O:-)

(I agree completely, and basically that was my
understanding/opinion/feeling back when we discussed it, too.)

> As long as we keep the code simple and the interesting parts are just
> reused and shared with the system emulator and other tools, it shouldn't
> be hard to maintain.
>=20
>> Well, but anyway.  Just as I didn=E2=80=99t have anything against adding=
 QMP to
>> qemu-nbd, I don=E2=80=99t have anything against adding a new application=
 that
>> kind of fulfills the same purpose.  And I think introducing a new
>> application instead of reusing qemu-nbd that focuses on all-around QAPI
>> compatibility (which qemu-nbd decidedly does not have) makes sense.
>=20
> Yes, QAPI is one big reason for creating a new tool that doesn't need to
> support the old qemu-nbd command line. Another is that we can add other
> types of exports that are not NBD.

Sure.

>> The only thing I don=E2=80=99t like is the name, but that=E2=80=99s what=
 <Tab> is for.
>> :-)
>=20
> I'm open for suggestions, but I thought 'qsd' was a bit too terse. :-)
>=20
> (Actually, maybe we could even pick something that doesn't mention
> storage or block? After all, it can do all kinds of QEMU backends in
> theory. Not sure if there's any standalone use for them, but who
> knows...)

Be careful, if we stuff too much into it, we=E2=80=99ll end up with just qe=
mu
again. :-)

Max


--JkTNPg8cmoqVEaaeRDxELWsL3wCxZVE7U--

--Gs7VuMxNDSbqYdd4QboeA47n5685ezLmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3C6EsACgkQ9AfbAGHV
z0BsyQf/etOPavXPgsiaClVcqrQTSC3BvYoJQN167okCoTgJF1wiWcPjpPV75fOV
6vyoJw39zeqXy0qtT3i+RIoePECwl82smXxikKve+uad1NBto42iIB5/pXohi62u
Utg7aLz39/K9XvjNcyvKyf+xF4GM7DzkzAvStCp/wDYnNXlfi1e7PwQrYU6NGTql
ZX4TsrlGBCiiwumxTZ0j3KPVbQhozFvP4SMrgb50j5aYlTpj6VforpckAFMi+jC1
JPvTHI3AkRsLiSPeakeFThWfVzbr5bPGT698ImHMZIEv3GfwZPD9c9F8PIwOqvkS
VyQ8IXg7gS/aEtXhkEiAlnxk63Hnzw==
=iq45
-----END PGP SIGNATURE-----

--Gs7VuMxNDSbqYdd4QboeA47n5685ezLmd--



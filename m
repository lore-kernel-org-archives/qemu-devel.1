Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EC0C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 11:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6ACC21D92
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 11:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1brM0sn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6ACC21D92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGgsn-0004EE-MZ
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 07:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kGgrt-0003Ji-I6
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 07:05:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kGgrq-0005sn-U5
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 07:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599822321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vnOlO/h2/fazOmBVEofDqXl3TA3TuvaY2p2Xu3AOCVE=;
 b=Y1brM0snFKz42Y6vOiWnJAjuYiwtXWTfVGsaVGNDLRT6qhjO5J25dM6OjCRUYazyph+ILP
 qexmQxjQW6PhuIrwWxuQ5aDaRdzgmZIGjQP/o7Y5L5z1MMRFAwek8I8gh6jSd7Fp7gtnGK
 cO6DIceNphwQhKkudND4dU/whmUIfe4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-wurcEu-mNHC_YPT-4H6zhw-1; Fri, 11 Sep 2020 07:05:18 -0400
X-MC-Unique: wurcEu-mNHC_YPT-4H6zhw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 229861009465
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 11:05:17 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-148.ams2.redhat.com
 [10.36.113.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C60881C40;
 Fri, 11 Sep 2020 11:05:16 +0000 (UTC)
Subject: Re: [PULL v2 01/46] qemu-iotests: move check-block back to Makefiles
From: Max Reitz <mreitz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200906175344.5042-1-pbonzini@redhat.com>
 <20200906175344.5042-2-pbonzini@redhat.com>
 <98f7869a-cb45-08b5-670a-ebc47254b0c2@redhat.com>
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
Message-ID: <42d1edc2-228b-220c-8db8-251cb83c964b@redhat.com>
Date: Fri, 11 Sep 2020 13:05:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <98f7869a-cb45-08b5-670a-ebc47254b0c2@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="X7ksedWiecOcjNEunabjtPDZ0YwBkTizZ"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 23:26:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X7ksedWiecOcjNEunabjtPDZ0YwBkTizZ
Content-Type: multipart/mixed; boundary="i11xx23iev6TIInV9sC9RNSlRf2Z6gDLj"

--i11xx23iev6TIInV9sC9RNSlRf2Z6gDLj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.09.20 12:58, Max Reitz wrote:
> On 06.09.20 19:53, Paolo Bonzini wrote:
>> check-block has its own test harness, unlike every other test.  If
>> we capture its output, as is in general nicer to do without V=3D1,
>> there will be no sign of progress.  So for lack of a better option
>> just move the invocation of the test back to Makefile rules.
>>
>> As a side effect, this will also fix "make check" in --disable-tools
>> builds, as they were trying to run qemu-iotests without having
>> made qemu-img before.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  meson.build                    |  1 -
>>  tests/Makefile.include         | 15 ++++++++++++---
>>  tests/qemu-iotests/meson.build |  4 ----
>>  3 files changed, 12 insertions(+), 8 deletions(-)
>=20
> I=E2=80=99m not entirely sure why (or I would=E2=80=99ve sent a patch mys=
elf)

On closer inspection it seems like it=E2=80=99s because of the
=E2=80=9Cbuild_by_default: false=E2=80=9D, which seems like a rather consci=
ous decision.
 Was I only lucky that the socket_scm_helper was built by default so
far?  Should I have explicitly built it all this time?

Max


--i11xx23iev6TIInV9sC9RNSlRf2Z6gDLj--

--X7ksedWiecOcjNEunabjtPDZ0YwBkTizZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9bWeoACgkQ9AfbAGHV
z0AN2Qf/V34wHKj7WX2FTkbrpENCFfY9kLslRmVIwUcSrDKXfJAuX1L5Ku3mv7DS
xkRkGt5YQxv88iXHkTLU1De0qEvPpgQOJ4mhMxHd3Frl8bjrkILvIj0/IFARO3Pp
fWMvKlwaZU5dEv1zxBIOPMpJQVdRiYWG+tR5mGL66orvo4jDCf35oo25eyLE+35k
o9cWKL5n7ZgRGZ9Um9KC4SFXMCegIiMjcla5/9SxCTF+imm3CjeFkd11SPOvgW33
S/plDyLaFy/jNjdLCKVkv+Itqqg1WUxJq2EqwX+IiaAzfBXuG9koOq93dh6UXqgX
gExS+e+danKkedHYWBcrjsUvXTAkLg==
=kUZ4
-----END PGP SIGNATURE-----

--X7ksedWiecOcjNEunabjtPDZ0YwBkTizZ--



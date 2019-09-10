Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4948AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F7AF2081B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7AF2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cXh-0003zh-64
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7cGF-00073k-4Z
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7cGE-0006Oh-4O
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:16:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54308)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7cGC-0006Nl-26; Tue, 10 Sep 2019 05:16:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 649B2307D986;
 Tue, 10 Sep 2019 09:16:27 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-90.ams2.redhat.com
 [10.36.117.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A96B41001959;
 Tue, 10 Sep 2019 09:16:25 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20190712173600.14554-1-mreitz@redhat.com>
 <84a35d4dd5a915fb879a313b0d5cd30bfa6aaa67.camel@redhat.com>
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
Message-ID: <5c843f00-eb9f-8442-fb0c-e99aa423c5a9@redhat.com>
Date: Tue, 10 Sep 2019 11:16:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <84a35d4dd5a915fb879a313b0d5cd30bfa6aaa67.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Gqzp0XX8bBDCgw4v8xpOgKlQPU3WiGtFG"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 10 Sep 2019 09:16:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/7] block: Generic file
 creation fallback
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Gqzp0XX8bBDCgw4v8xpOgKlQPU3WiGtFG
Content-Type: multipart/mixed; boundary="W4iiWgUqMzoRVeEhYdcKjOu7pFe5Cyv8T";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <5c843f00-eb9f-8442-fb0c-e99aa423c5a9@redhat.com>
Subject: Re: [Qemu-block] [PATCH 0/7] block: Generic file creation fallback
References: <20190712173600.14554-1-mreitz@redhat.com>
 <84a35d4dd5a915fb879a313b0d5cd30bfa6aaa67.camel@redhat.com>
In-Reply-To: <84a35d4dd5a915fb879a313b0d5cd30bfa6aaa67.camel@redhat.com>

--W4iiWgUqMzoRVeEhYdcKjOu7pFe5Cyv8T
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.09.19 15:30, Maxim Levitsky wrote:
> On Fri, 2019-07-12 at 19:35 +0200, Max Reitz wrote:
>> Hi,
>>
>> Kevin commented on my RFC, so I got what an RFC wants, and he didn=E2=80=
=99t
>> object to the creation fallback part.  So I suppose I can go down that=

>> route at least.  (Which was actually the more important part of the
>> series.)
>>
>> So as in the RFC, this series adds a fallback path for creating files
>> (on the protocol layer) if the protocol driver does not support file
>> creation, but the file already exists.
>>
>=20
> Hi!
> Do you have any update on this patch series by a chance?

Unfortunately, no.  I was on PTO, and before that, there was just too
much else going on.  (And frankly, there=E2=80=99s still too much else go=
ing on.)

Max


--W4iiWgUqMzoRVeEhYdcKjOu7pFe5Cyv8T--

--Gqzp0XX8bBDCgw4v8xpOgKlQPU3WiGtFG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl13aegACgkQ9AfbAGHV
z0C+Hgf/WsYGTeg2Ca7oIF7gS9QRfQ4eMKMp8+kHKtDzgoAOyLONUqSy+mMpK9Aj
ZXoDhLeIN7DZFZr7vUy8bm6EEyez5hOKAu2io9A4oXfrVISKmBYtVZhdirxEaDWH
TAsmbDnvh7Pens10m6cz+/kl2U2YdZ3liJpQuqoe/WJFbwhFHc+aPeksjMSGMPda
YjGoXmhytEhBoPZQ36X2oSGHAFLWX7skxLHx2N/mLwQId/nAdiGXO35KduJ9WDtT
uUyptnT2BKz/rnLE0NNp2bjpJd9PfdJmgE/OT0BKAqWKzvnF2wjH69bLBEh++Abr
wcEvsnYQFe3v/QrEJ69Z8IZrqcA9sg==
=WmrL
-----END PGP SIGNATURE-----

--Gqzp0XX8bBDCgw4v8xpOgKlQPU3WiGtFG--


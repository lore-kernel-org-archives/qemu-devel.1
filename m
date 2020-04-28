Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0852C83004
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 10:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADAFB206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 10:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmaObxwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADAFB206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTNAI-0003lC-R0
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 06:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTN90-0002kR-T4
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:07:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTN7s-0006Wa-Ui
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:07:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30094
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTN7s-0006WH-HZ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588068363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qSoHt9KiI8SHmBws6qFdKSsmZu+aZqUUzhVEQycr+zc=;
 b=JmaObxwoOIWJ/u1CRyPSdhq/ncYKAqmpjUHHVq2L6AzPZRy5LTC2mG3/rNEHOCYU8pfr/U
 C767rNoehhHp1VQWIgoXgaYpN/VANyA/dhzrWSF+vvgMFvjd8yzOChn1lzd/Wg2gTFOgjQ
 mII3tPQdpLUu+Aj98pz4HLHTGbJPPgc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-7nA6vnTYP6i3oDs5r2CVbg-1; Tue, 28 Apr 2020 06:06:01 -0400
X-MC-Unique: 7nA6vnTYP6i3oDs5r2CVbg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25A41107ACF4;
 Tue, 28 Apr 2020 10:06:00 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2F475D9E5;
 Tue, 28 Apr 2020 10:05:58 +0000 (UTC)
Subject: Re: [PATCH v2 5/6] block/block-copy: move block_copy_task_create down
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200325134639.16337-1-vsementsov@virtuozzo.com>
 <20200325134639.16337-6-vsementsov@virtuozzo.com>
 <ae040bc6-7c0e-4b55-0723-c5e892570fb9@redhat.com>
 <9fd7f07e-d297-15a5-1bd1-355e8c8b013e@virtuozzo.com>
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
Message-ID: <4fa175ee-8308-013c-dd44-e2eacdfce241@redhat.com>
Date: Tue, 28 Apr 2020 12:05:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9fd7f07e-d297-15a5-1bd1-355e8c8b013e@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OBffgBWlYqKBOhyNjqz81CbFsBkhhArMK"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OBffgBWlYqKBOhyNjqz81CbFsBkhhArMK
Content-Type: multipart/mixed; boundary="H2N3Q4PnDbZYGcnk2tOkHAofmVnx1zdyr"

--H2N3Q4PnDbZYGcnk2tOkHAofmVnx1zdyr
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.04.20 11:17, Vladimir Sementsov-Ogievskiy wrote:
> 28.04.2020 12:06, Max Reitz wrote:
>> On 25.03.20 14:46, Vladimir Sementsov-Ogievskiy wrote:
>>> Simple movement without any change. It's needed for the following
>>> patch, as this function will need to use some staff which is currently
>>
>> *stuff
>>
>>> below it.
>>
>> Wouldn=92t it be simpler to just declare block_copy_task_entry()?
>>
>=20
> I just think, that it's good to keep native order of functions and avoid
> extra declarations. Still, may be I care too much. No actual difference,
> if you prefer declaration, I can drop this patch.

Personally, the native order doesn=92t do me any good (cscope doesn=92t
really care where the definition is), and also having functions in order
seems just like a C artifact.

I just prefer declarations because otherwise we end up moving functions
all the time with no real benefit.  Furthermore, moving functions has
the drawback of polluting git blame.

Max


--H2N3Q4PnDbZYGcnk2tOkHAofmVnx1zdyr--

--OBffgBWlYqKBOhyNjqz81CbFsBkhhArMK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6oAAUACgkQ9AfbAGHV
z0BXOgf/QNJZViDIjcs2am8NihYSMz3uwnTkdzHSPL1UfYTH0+uIBlGaEPGhNW1u
YY0am+ZpD6WFYAN88BSGdcBBN9vjsHvDzUFMc1jpDlABd0OCdEhbaHQCWT68d81z
ToWTKJZz5dlJORayFV+IXgn4GqI4XlLv2oeDtK2SQeblWUPZu2qsy5oEtp3KXJgS
q7SjMel/CR/HErTrZoyoy77MUNFiH+CTn3br95dMN+j/t92GA7j2VFDaZQ3hDU/q
kLdG4p/aFcbQQd15hb5ugPNo8Q8vH+XF8eTO8kvSR8e7UW3RV1GatfiaCnkSvlna
rHe9A1l/Txdb7BGDi91rQVZME6ye+A==
=BOKx
-----END PGP SIGNATURE-----

--OBffgBWlYqKBOhyNjqz81CbFsBkhhArMK--



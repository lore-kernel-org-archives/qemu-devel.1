Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F77C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:00:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F207206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7gqur5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F207206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVBvT-0005Ma-IX
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 05:00:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iVBtX-0003Wb-Hg
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:58:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iVBtW-00044n-I5
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:58:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32117
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iVBtW-00044K-E9
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573725509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2yTXW+Zc6vdj8GSrA1o5hSC2zgRCuAdNbIEfJx2QdBs=;
 b=O7gqur5Il0g0lQdLEaWHPrGySxyfFl3IvY7/So9JXxRTwST6nyRzlZFzfv2NN5EIi+hif0
 4I4vqsdxsYPB6J/u8cnoL1KBdKYUNXH/OSYnHVRltyWyMyWkaFUmoF8kLWIKLDXA54Bask
 guCFpJjO011NC8XnxR1lvnYDkeBMaiY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-l7tRJgHaOouV7VyWWAs5bw-1; Thu, 14 Nov 2019 04:58:26 -0500
X-MC-Unique: l7tRJgHaOouV7VyWWAs5bw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E2B6189CB00;
 Thu, 14 Nov 2019 09:58:25 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-160.ams2.redhat.com
 [10.36.117.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69204108132E;
 Thu, 14 Nov 2019 09:58:23 +0000 (UTC)
Subject: Re: [Qemu-devel] [PATCH v4 02/14] qapi: Move to_c_string() to
 common.py
To: Markus Armbruster <armbru@redhat.com>
References: <20190624173935.25747-1-mreitz@redhat.com>
 <20190624173935.25747-3-mreitz@redhat.com>
 <87imnmq0fu.fsf@dusky.pond.sub.org>
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
Message-ID: <74c8532f-971f-9e5e-ea12-16508d49fedf@redhat.com>
Date: Thu, 14 Nov 2019 10:58:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87imnmq0fu.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8vIPydQE2nXUwJE2Z4tAda9RJdV26ESnJ"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8vIPydQE2nXUwJE2Z4tAda9RJdV26ESnJ
Content-Type: multipart/mixed; boundary="cu0rSlCpgjy3P8QSkMt8zqD2gHcLE2M85"

--cu0rSlCpgjy3P8QSkMt8zqD2gHcLE2M85
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.11.19 10:20, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> This function will be useful for code generation once we allow default
>> values, so move it to the other "C helper functions".  In the process,
>> rewrite it so it supports all nonprintable and non-ASCII characters.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> Please have a close look at commit 56a8caff92 "qapi: Restrict strings to
> printable ASCII".  Do we still need the rewrite?

If that=E2=80=99s all that has changed, I think we will still need at least=
 some
bits, like the " or \ escaping.

Also, actually, it looks like 56a8caff92 didn=E2=80=99t change the fact tha=
t
control characters are verbatim parts of the string, i.e. \u000a will
still be a literal 0xa byte, and as such must be escaped anew in the C
string.

So without having tried, I think this is still very much necessary.

> If yes: the commit message title promises code motion, but the patch is
> anything but.  Adjust the title, please.

OK.

Max



--cu0rSlCpgjy3P8QSkMt8zqD2gHcLE2M85--

--8vIPydQE2nXUwJE2Z4tAda9RJdV26ESnJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3NJT0ACgkQ9AfbAGHV
z0D5qAf9FI3biTo2N0X/pvSl7NaP7p1xSYgln4ObbJu6sJ7XgGkkZzTdwodrsmVA
eM/2LafgXYcPFVRjjEf856l34CZ4snJshQ20op81iksiS6bXMNzYgi6i34df73AC
KsFNNrM9gdV3rjBuFLAtszHNJIXX6JaCfOV+tQaHmrwE2W+EjmCFPaqtM8kUrVDJ
bQHpGBLqmWu7XBelpBKXk4OUT1vBkFJO6xuo/gZJ3oj0nscg7ZZji3i/bw1nI/jj
jzKiX2/rzCGPaQv3TOrlQJxdqbQCVc4lV4QAH1CmQlkGdujAEy7YvrvKOsAxOY01
4TWNTGDe3H0c44KW2phBoAND0G8GsQ==
=aaAT
-----END PGP SIGNATURE-----

--8vIPydQE2nXUwJE2Z4tAda9RJdV26ESnJ--



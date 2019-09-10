Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BC3C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:00:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 690C021019
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690C021019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7dsj-0007EF-ID
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 07:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7dqS-0005PN-Du
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7dqR-0003Tj-81
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:58:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52350)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7dqP-0003Su-1f; Tue, 10 Sep 2019 06:57:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2DFA33172D96;
 Tue, 10 Sep 2019 10:57:56 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-90.ams2.redhat.com
 [10.36.117.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B02160BE2;
 Tue, 10 Sep 2019 10:57:54 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
References: <20190906113534.10907-1-thuth@redhat.com>
 <54cd1dd0-6e23-92d1-ff86-0eccddcb3da8@redhat.com>
 <6627619f-e0e2-f8fd-14b0-d675d5931ed0@redhat.com>
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
Message-ID: <42a0d9dc-fd96-637f-abb0-1879b7ff0ad3@redhat.com>
Date: Tue, 10 Sep 2019 12:57:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6627619f-e0e2-f8fd-14b0-d675d5931ed0@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="boMD4TU1Cre6ZOENRYUKqtiBhOp21WxPp"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 10 Sep 2019 10:57:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] tests/Makefile: Do not print the name of
 the check-block.sh shell script
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--boMD4TU1Cre6ZOENRYUKqtiBhOp21WxPp
Content-Type: multipart/mixed; boundary="rluP4xSb5QDt4rHIqcvd0kK9gSQ13fr4P";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-trivial@nongnu.org
Message-ID: <42a0d9dc-fd96-637f-abb0-1879b7ff0ad3@redhat.com>
Subject: Re: [PATCH] tests/Makefile: Do not print the name of the
 check-block.sh shell script
References: <20190906113534.10907-1-thuth@redhat.com>
 <54cd1dd0-6e23-92d1-ff86-0eccddcb3da8@redhat.com>
 <6627619f-e0e2-f8fd-14b0-d675d5931ed0@redhat.com>
In-Reply-To: <6627619f-e0e2-f8fd-14b0-d675d5931ed0@redhat.com>

--rluP4xSb5QDt4rHIqcvd0kK9gSQ13fr4P
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.09.19 12:55, Thomas Huth wrote:
> On 10/09/2019 12.53, Max Reitz wrote:
>> On 06.09.19 13:35, Thomas Huth wrote:
>>> The check script is already printing out which iotest is currently
>>> running, so printing out the name of the check-block.sh shell script
>>> looks superfluous here.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  tests/Makefile.include | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>> (Not sure which tree you=E2=80=99d like this to go through...)
>=20
> I think either your block tree or trivial would be appropriate?

OK then, I=E2=80=99ve taken it. :-)

Max


--rluP4xSb5QDt4rHIqcvd0kK9gSQ13fr4P--

--boMD4TU1Cre6ZOENRYUKqtiBhOp21WxPp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl13gbAACgkQ9AfbAGHV
z0BecAf+K43GfZ5xUPjw4HHb2jXnHHFNkr2JSSMsr8KWcmn5mxq+RkvJTqKuUwWy
ulByjOq6WDMbVbvgFVDhPr/fEAW1EILRXNLGTkxDGPxtIgcWY7JEXIQb9aImgJLT
DhleDe7zil2pCx1CDMDi6bPuvzzthEv2k7GdcKCaLACxsPtFXxuCDbt9b8tKs/Gp
SVQMqScvMWnVuNnBtI/btU/u9ubUux9V4E13s5evQPtX+u+sOim5h2sJTBt8DBaq
xjAVtdGNEXL1UrTcnSB9viOzd0UvOu27wwwA6Ohj6xMlR7ZjxkCKWy3ZDzwHxHf1
v/5LeRnijGeY1rfT0EG7XujWjiKGQw==
=K9Uh
-----END PGP SIGNATURE-----

--boMD4TU1Cre6ZOENRYUKqtiBhOp21WxPp--


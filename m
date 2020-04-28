Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D15BC83004
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 11:51:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF688206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 11:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKubXDq/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF688206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTOm2-00049D-3g
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 07:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTOjM-0000Mo-Qp
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 07:49:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTOgr-0007gU-6Y
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 07:48:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31023
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTOgq-0007gC-LO
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 07:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588074375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ybfEM1J+dcH0zE4QDaM2UHzAtfwnLcZfPyIOmG6zFJE=;
 b=JKubXDq/F+Kk1MMF6dEeXHaXcqULBLx3yXJUw404FHw23FUKKwPllcIyuxFQVGEAjyK1aS
 P6M+Gbsl043D+Lm6mQnu0D+2k3805/IU3z1ywyl6GUPCjKtwWB/OS+bx0rXK0q/f/zmKFE
 5cFV8+SOsQxVZyJjKCTC8zFSVhIqUmc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-Aqk2Dd97Nk2D32zvV-c57A-1; Tue, 28 Apr 2020 07:46:09 -0400
X-MC-Unique: Aqk2Dd97Nk2D32zvV-c57A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26278800688;
 Tue, 28 Apr 2020 11:46:08 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1051C600DB;
 Tue, 28 Apr 2020 11:46:03 +0000 (UTC)
Subject: Re: [PATCH v10 00/14] iotests: use python logging
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200331000014.11581-1-jsnow@redhat.com>
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
Message-ID: <a63ac7e2-51fd-7d02-3e7d-be14912bd103@redhat.com>
Date: Tue, 28 Apr 2020 13:46:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200331000014.11581-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rqTtjEMIlI2DCjZ44JL4aamXIxuYNehpX"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 philmd@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rqTtjEMIlI2DCjZ44JL4aamXIxuYNehpX
Content-Type: multipart/mixed; boundary="7inEjrTcfmal2ctKx3qx6SiFfs6hTIUkT"

--7inEjrTcfmal2ctKx3qx6SiFfs6hTIUkT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 31.03.20 02:00, John Snow wrote:
> This series uses python logging to enable output conditionally on
> iotests.log(). We unify an initialization call (which also enables
> debugging output for those tests with -d) and then make the switch
> inside of iotests.
>=20
> It will help alleviate the need to create logged/unlogged versions
> of all the various helpers we have made.
>=20
> Also, I got lost and accidentally delinted iotests while I was here.
> Sorry about that. By version 9, it's now the overwhelming focus of
> this series. No good deed, etc.

Seems like nobody else wants it, so I thank you and let you know that
I=E2=80=99ve applied this series to my block-next branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block-next

Max


--7inEjrTcfmal2ctKx3qx6SiFfs6hTIUkT--

--rqTtjEMIlI2DCjZ44JL4aamXIxuYNehpX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6oF3oACgkQ9AfbAGHV
z0Awqgf+OFAS2BUgAgVXPCg4iWq4Y5bvqUq7vXgzjbW2vy9WKm7MVpWdIgUZI/pc
8Ahfnb3j0kczMFbXMPta1AGWHukdfhQ9xv6DwrHs+mSzJTx1Mk2vPgbLvLH1ET88
3LvYpDhNCBH94K0f8PmC2TaTlOPXNqhXf81CUdo0QGKM6MsK9IepilBlKrq3g8Ua
81OQ2YwAk4wxSkkFIx15rYzMCTtaKaFxuGdEdFquxC5pl6k45ZL7KY1iFkrPLJ3v
8d+ukjHi8j+Dtz4ZYxPctN40ljXxgcJako2a4+NsdLYc6YTpl3tXKOIc4jl3m/aZ
e1FoZnYtCFtK+HRYS+QCrTZ/Uc6Cbg==
=7LfW
-----END PGP SIGNATURE-----

--rqTtjEMIlI2DCjZ44JL4aamXIxuYNehpX--



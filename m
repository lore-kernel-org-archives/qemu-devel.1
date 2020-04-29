Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5A4C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:16:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B965E206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CdJIbvyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B965E206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThtK-0008Ri-OM
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 04:16:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jThmm-0007na-JR
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:09:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jThlT-0001yv-Pw
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:09:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41045
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jThlT-0001qk-Aw
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588147698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5qfjxSAKaYLi1ufXhMvjN0NOUVaqhPFYn239LxeN2Rg=;
 b=CdJIbvyhSJcphBUzK0Sk3ztfKFJ5y/g9IuFCjh6tGvyPCsRavGUtdHz56nfuBEPFndDIrK
 5uAm55pwbb1uhJCwJkPukidDQJ1xT0kuR3/XEzC05W7F2zNN7ywRtU/gB96uSPjMzV1rac
 S19oNpdeRxdin6PgCLlV6AUNUUJs3UU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-HzVRA_mwNy2NkmUxNdE51A-1; Wed, 29 Apr 2020 04:08:10 -0400
X-MC-Unique: HzVRA_mwNy2NkmUxNdE51A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A343464;
 Wed, 29 Apr 2020 08:08:09 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-19.ams2.redhat.com
 [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED7751001281;
 Wed, 29 Apr 2020 08:08:07 +0000 (UTC)
Subject: Re: [PATCH v10 00/14] iotests: use python logging
To: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20200331000014.11581-1-jsnow@redhat.com>
 <a63ac7e2-51fd-7d02-3e7d-be14912bd103@redhat.com>
 <20200428122107.GD5789@linux.fritz.box>
 <6f3ee80e-e3f7-ff58-717c-8b3eaed7d788@redhat.com>
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
Message-ID: <94fcec36-1113-512d-36ce-a6e8c1a0c058@redhat.com>
Date: Wed, 29 Apr 2020 10:08:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6f3ee80e-e3f7-ff58-717c-8b3eaed7d788@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2S1blymeElDrMyzbKQwEGO0L1R51m88HR"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: ehabkost@redhat.com, qemu-block@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2S1blymeElDrMyzbKQwEGO0L1R51m88HR
Content-Type: multipart/mixed; boundary="rkFamHDtAz7zm0XFWNdLSEe1zs58Gbkx1"

--rkFamHDtAz7zm0XFWNdLSEe1zs58Gbkx1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.04.20 19:36, John Snow wrote:
>=20
>=20
> On 4/28/20 8:21 AM, Kevin Wolf wrote:
>> Am 28.04.2020 um 13:46 hat Max Reitz geschrieben:
>>> On 31.03.20 02:00, John Snow wrote:
>>>> This series uses python logging to enable output conditionally on
>>>> iotests.log(). We unify an initialization call (which also enables
>>>> debugging output for those tests with -d) and then make the switch
>>>> inside of iotests.
>>>>
>>>> It will help alleviate the need to create logged/unlogged versions
>>>> of all the various helpers we have made.
>>>>
>>>> Also, I got lost and accidentally delinted iotests while I was here.
>>>> Sorry about that. By version 9, it's now the overwhelming focus of
>>>> this series. No good deed, etc.
>>>
>>> Seems like nobody else wants it, so I thank you and let you know that
>>> I=E2=80=99ve applied this series to my block-next branch:
>>>
>>> https://git.xanclic.moe/XanClic/qemu/commits/branch/block-next
>>
>> John said he wanted to address my comment on patch 14, so I expected him
>> to send another version. This need not stop this series (we can still
>> fix that on top), but just as an explanation why I didn't take it yet.
>>
>> Kevin
>>
>=20
> Sorry, foggy memory. I will send a follow-up and we can try to squash it =
in.

All right.

Max


--rkFamHDtAz7zm0XFWNdLSEe1zs58Gbkx1--

--2S1blymeElDrMyzbKQwEGO0L1R51m88HR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6pNeYACgkQ9AfbAGHV
z0C/Hwf7BeSXPdiqrXRQ4hwc0Y9LWvVWy/1m5AzfM+feM6G4lqkBLttFNjU5LMIm
8TKz8KdMQdmBGUOgVhEBfH03um2TdygTjTfbNZ1enOl+tUvCt4xhq8sMnUyalDB+
JI/12z7F5iQLLu3OcNhcRLigUPSX7d68tnY3+GKfv12PBNB/BuUzrCNPS7Iydlei
zQ2EMQ/NCIOXi9WRDaHj6k8vIm7dfrNXlR+s86qU/TNNfUphC9s/zq25cuyu8DTK
ldlK6ULLyIDYdoAKPmgilebvvMPg7joOsNmw/7lCwS1uNXUwwdX0t2tqzvkw4n8T
mW/AgtwdhLvpxJlkQD/pMQBXoiUVYA==
=egnW
-----END PGP SIGNATURE-----

--2S1blymeElDrMyzbKQwEGO0L1R51m88HR--



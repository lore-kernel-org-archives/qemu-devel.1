Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B53FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:21:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B989214E0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B989214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL2uH-0001dQ-Kk
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 06:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iL2tO-00019B-MB
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iL2tK-0007Px-J8
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:20:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37698)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iL2tD-0007JM-AX; Thu, 17 Oct 2019 06:20:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8AF5380F83;
 Thu, 17 Oct 2019 10:20:14 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-3.ams2.redhat.com
 [10.36.117.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E0FC60600;
 Thu, 17 Oct 2019 10:20:13 +0000 (UTC)
Subject: Re: iotest 260 failure (linux host): "OSError: AF_UNIX path too long"
To: Peter Maydell <peter.maydell@linaro.org>
References: <CAFEAcA-jutAw2KFBDX9v=Q7LQ8_Mj0AHB79wi74hoW6J81fbhw@mail.gmail.com>
 <71badd7c-a9f0-ef91-5477-623389aa52fd@redhat.com>
 <CAFEAcA-0aYLbEoWf_ZeTxoLdKNaeFESyiuHi5KYG9kdUWaAJtg@mail.gmail.com>
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
Message-ID: <1b52f4fb-c8e7-ecbd-9db4-32e7e9c5f1b5@redhat.com>
Date: Thu, 17 Oct 2019 12:20:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-0aYLbEoWf_ZeTxoLdKNaeFESyiuHi5KYG9kdUWaAJtg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wnF1KsRnLYvYs4wxLV7yW0b5mqwsrVO74"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 17 Oct 2019 10:20:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wnF1KsRnLYvYs4wxLV7yW0b5mqwsrVO74
Content-Type: multipart/mixed; boundary="lvXuFS441rA2n9pzZtA7caFsp4Ue3F7Lx"

--lvXuFS441rA2n9pzZtA7caFsp4Ue3F7Lx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.10.19 12:04, Peter Maydell wrote:
> On Thu, 17 Oct 2019 at 10:53, Max Reitz <mreitz@redhat.com> wrote:
>>
>> On 17.10.19 11:51, Peter Maydell wrote:
>>> I just got this iotest 260 failure processing an
>>> unrelated merge on my x86-64 Ubuntu box. I assume
>>> it's an intermittent (have just kicked off a retry) but
>>> post the backtrace in case it's of interest:
>>
>> I hope it=E2=80=99s intermittent, although I presume it might not be.
>=20
> It has indeed failed again. Is there some way to get the
> build to pick a shorter test directory name, or to get
> 'make check' to skip the iotests, so I can proceed with
> testing until that fix lands?

Yes, you can set the $TEST_DIR environment variable to a shorter scratch
path.

Max


--lvXuFS441rA2n9pzZtA7caFsp4Ue3F7Lx--

--wnF1KsRnLYvYs4wxLV7yW0b5mqwsrVO74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2oQFsACgkQ9AfbAGHV
z0DZmgf/d8AfSUdhFyUU1lRBU8qHosSd03Ghboikk6fMUob5L2DaqOU8bl7IFR0B
gHLoOt3Eb5k9ITFSiENPtgtgTUftar3xjzjyMpWqYSiNUTXbJUSgbntavnbuAmMZ
d1bguJTs1VfiMZpHVN3h/zVqIsNDiRVjv2eIkXcytp1O/ZXtiKrJRVF6NYv+r5a6
btm1RGzdEa6GuRdJsJi3absSUa0p/yW0JazDXRD+DwolLGjVt8JCj7t12T5qdBLr
wMlOkDsqN1VpCVki/+6gfFoFZCA7Lg+wo9Wpq4IXkwZofrwk8MlrjUKVgHjzQxtu
GeRWeZ2TfyCsVymCl+wncfhDcS8ruw==
=SgSR
-----END PGP SIGNATURE-----

--wnF1KsRnLYvYs4wxLV7yW0b5mqwsrVO74--


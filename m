Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04945C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 16:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1332208C3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 16:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1332208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48420 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVIti-0002IG-Pe
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 12:54:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVIsM-0001bM-Jp
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVIsL-0005PQ-MF
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:53:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVIsD-0004yv-6J; Mon, 27 May 2019 12:53:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54B1D21BAA;
	Mon, 27 May 2019 16:53:14 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E4FC7DFC2;
	Mon, 27 May 2019 16:53:11 +0000 (UTC)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190523102532.10486-1-alex.bennee@linaro.org>
	<20190523102532.10486-28-alex.bennee@linaro.org>
	<18f8fad1-5dac-eb5b-f531-da3b2124ec35@redhat.com>
	<87imtvrhs6.fsf@zen.linaroharston>
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
Message-ID: <62382ffc-031d-37e9-736d-a2cebd7dc84f@redhat.com>
Date: Mon, 27 May 2019 18:53:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87imtvrhs6.fsf@zen.linaroharston>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="q6pnJdvXk6KQlEOEOBrkvotyiRKvDgFGS"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Mon, 27 May 2019 16:53:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 27/28] tests/qemu-iotests: re-format
 output to for make check-block
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
	qemu-arm@nongnu.org, qemu-devel@nongnu.org,
	"open list:Block layer core" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q6pnJdvXk6KQlEOEOBrkvotyiRKvDgFGS
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Thomas Huth
 <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Message-ID: <62382ffc-031d-37e9-736d-a2cebd7dc84f@redhat.com>
Subject: Re: [PATCH v2 27/28] tests/qemu-iotests: re-format output to for make
 check-block
References: <20190523102532.10486-1-alex.bennee@linaro.org>
 <20190523102532.10486-28-alex.bennee@linaro.org>
 <18f8fad1-5dac-eb5b-f531-da3b2124ec35@redhat.com>
 <87imtvrhs6.fsf@zen.linaroharston>
In-Reply-To: <87imtvrhs6.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.05.19 18:20, Alex Benn=C3=A9e wrote:
>=20
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> On 23.05.19 12:25, Alex Benn=C3=A9e wrote:
>>> This attempts to clean-up the output to better match the output of th=
e
>>> rest of the QEMU check system when called with -makecheck. This inclu=
des:
>>>
>>>   - formatting as "  TEST    iotest-FMT: nnn"
>>>   - only dumping config on failure (when -makecheck enabled)
>>>
>>> The non-make check output has been cleaned up as well:
>>>
>>>   - line re-displayed (\r) at the end
>>>   - fancy colours for pass/fail/skip
>>>   - timestamps always printed (option removed)
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Message-Id: <20190503143904.31211-1-alex.bennee@linaro.org>
>>> Tested-by: Thomas Huth <thuth@redhat.com>
>>>
>>> ---
>>> v3
>>>   - revert echo to printf
>>>   - add _report_test_start
>>> v4
>>>   - -pretty -> -makecheck
>>>   - keep all output together for makecheck
>>> v5
>>>   - merged in kwolf's pretty printing
>>>   - timestamps always printed in non-makecheck mode
>>> ---
>>>  tests/qemu-iotests/check | 179 +++++++++++++++++++++++++------------=
--
>>>  1 file changed, 116 insertions(+), 63 deletions(-)
>>
>> Unless I missed something, this breaks ./check:
>>
>> $ ./check -T -qcow2
>> 000 - unknown test, ignored
>=20
> Because -T has been dropped (timestamps are always shown). Of course
> removing from the opts passing falls through. Should I just do:

Ah, OK.

> modified   tests/qemu-iotests/check
> @@ -433,6 +433,11 @@ testlist options
>              cachemode=3Dtrue
>              xpand=3Dfalse
>              ;;
> +        -T)
> +            echo "-T no longer needed"
> +            exit -1
> +            ;;
> +
>          -v)
>              verbose=3Dtrue

Hm, why not just ignore it?

Max


--q6pnJdvXk6KQlEOEOBrkvotyiRKvDgFGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzsFfUACgkQ9AfbAGHV
z0D9lggApPo1h0uIZzier+GygWapsQar9fYBucByxA5VhaTNoDRtuEq1m/IbIner
ozE2mE9Ey8BU02pQ67e80CUZcTHL9zw7HpGHnVkVaAEhh9UXDzXkNKd8zdCOSdiS
YA+xbA0itaiyI9fLS+vMroWguGDw5MOO/v0nRt1F9Lt+W+qKBwFbre/YR0EjO7vS
AuK+wQ8yCytTsqW4Ws8hYLKAvyARxl7Efyfw+v/SB3KHveZ/RVigmis+XQExWo6M
iAx0qAC8xYvOsquWfPUU0NKNZ3BZ3RNU6E8/hISbVu9uAmN+JU/tOiqVD4VC6aJf
tgCjBCWBoNiXmUn4nWMk1NfdxBmDZg==
=2oik
-----END PGP SIGNATURE-----

--q6pnJdvXk6KQlEOEOBrkvotyiRKvDgFGS--


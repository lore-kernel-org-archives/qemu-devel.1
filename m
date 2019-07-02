Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE556C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 17:30:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C94B20989
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 17:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C94B20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiMbf-0007Ok-Eq
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 13:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47159)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hiLV7-0004sz-LE
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hiLV6-0001sm-Kb
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:19:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52190)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hiLV4-0001rW-7v; Tue, 02 Jul 2019 12:19:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6453BAC2D9;
 Tue,  2 Jul 2019 16:19:21 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-120.brq.redhat.com
 [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E86645D9C6;
 Tue,  2 Jul 2019 16:19:15 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
References: <20190627223255.3789-1-mreitz@redhat.com>
 <20190627223255.3789-5-mreitz@redhat.com>
 <6f5eb9ac-c56f-943f-698f-38ec7726143d@redhat.com>
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
Message-ID: <82691afe-1a12-edbc-1cdc-f25ca114056a@redhat.com>
Date: Tue, 2 Jul 2019 18:19:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6f5eb9ac-c56f-943f-698f-38ec7726143d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DADSSPM0fytzLOKXLkzctCBAIjh5JwWPb"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 02 Jul 2019 16:19:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/5] iotests: Add @use_log to VM.run_job()
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DADSSPM0fytzLOKXLkzctCBAIjh5JwWPb
Content-Type: multipart/mixed; boundary="afDMoVDLgRq9x9dbwPyQw74tTJALGqSZ1";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Cleber Rosa <crosa@redhat.com>
Message-ID: <82691afe-1a12-edbc-1cdc-f25ca114056a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] iotests: Add @use_log to VM.run_job()
References: <20190627223255.3789-1-mreitz@redhat.com>
 <20190627223255.3789-5-mreitz@redhat.com>
 <6f5eb9ac-c56f-943f-698f-38ec7726143d@redhat.com>
In-Reply-To: <6f5eb9ac-c56f-943f-698f-38ec7726143d@redhat.com>

--afDMoVDLgRq9x9dbwPyQw74tTJALGqSZ1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.07.19 00:59, John Snow wrote:
>=20
>=20
> On 6/27/19 6:32 PM, Max Reitz wrote:
>> unittest-style tests generally do not use the log file, but VM.run_job=
()
>> can still be useful to them.  Add a parameter to it that hides its
>> output from the log file.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> Wondering out loud:
>=20
> can log() (and by extension qmp_log, and run_job) be made to use the
> python logging module and we can configure the logging environment
> instead of bespoke arguments to avoid ever engaging the log?
>=20
> We could theoretically just pre-disable iotests log output for unittest=

> style tests, unless you run in debug mode where we allow it.
>=20
> I don't have a specific proposal for how to accomplish this, I think
> there are some nuances to Python logging that I don't quite understand.=

> Maybe Cleber Rosa can help advise?
>=20
> I'd like to toy with this idea; it seems like this won't be the last
> time we want to turn output on/off.

Sounds good.  But considering this is just test infrastructure, I=E2=80=99=
ll
leave that for when someone(TM) gets around to doing it.  (Hopefully
when the next function is about to get a @use_log parameter.)

Max


--afDMoVDLgRq9x9dbwPyQw74tTJALGqSZ1--

--DADSSPM0fytzLOKXLkzctCBAIjh5JwWPb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0bhAIACgkQ9AfbAGHV
z0D0ZwgAoc9Mn2ahSp0t+zoCyH3GD/uWb4tGTXaTywusO3fc+ayabJrr/bSFyex8
qf4lG1RD2aJqomxCglrru1gP+6XQnAm0umuSisII/0Xk7gyiUrkSw2bV20o9uAbn
KH/K6UuYFFy7GSS+d67Rb8C4iFEe4zn7vihtYVtneDp/ZQjh7vLBWdsVNbtCl3VB
vokmpfh4M2YDBxx/kXUIL1K4ADngCUpBmkeb1DcjHiFbnRppQ1ABCc1m2ZdW4B6t
D93e+fDMrsHJOwWk4kahm8FVfr0xl7toKG4MBAkPaj4HQRk9sX9mjx4SFgFtRNDu
gZVc7ozmbolUrcMnDFgnPT6r71jK6A==
=K6tU
-----END PGP SIGNATURE-----

--DADSSPM0fytzLOKXLkzctCBAIjh5JwWPb--


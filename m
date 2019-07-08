Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C179CC606AF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 12:26:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97EE820861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 12:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97EE820861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkSjI-00007R-OC
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 08:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34048)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hkSh3-0007n8-JA
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 08:24:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hkSh2-0001dg-Ib
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 08:24:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47804)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hkSgu-0001Vp-Hw; Mon, 08 Jul 2019 08:24:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F12E659455;
 Mon,  8 Jul 2019 12:24:05 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-127.brq.redhat.com
 [10.40.204.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 92A7B5D9C8;
 Mon,  8 Jul 2019 12:24:00 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190703155944.9637-1-mlevitsk@redhat.com>
 <20190703155944.9637-2-mlevitsk@redhat.com>
 <c47da7ef-82ac-1a76-9c8e-f76336c20c44@redhat.com>
 <d009ad68b237aae51d327955367dc2356f33bba0.camel@redhat.com>
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
Message-ID: <5d32c846-1ff6-ec99-af20-8e7a794c4fe2@redhat.com>
Date: Mon, 8 Jul 2019 14:23:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d009ad68b237aae51d327955367dc2356f33bba0.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="USCwwg2j1GX8g46N9jXoW4sJJc16TrjzP"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 08 Jul 2019 12:24:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/6] block/nvme: don't touch the
 completion entries
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--USCwwg2j1GX8g46N9jXoW4sJJc16TrjzP
Content-Type: multipart/mixed; boundary="gdQUBiS15iMXSaUEvDyHWdGaa1XfG5TXb";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <5d32c846-1ff6-ec99-af20-8e7a794c4fe2@redhat.com>
Subject: Re: [PATCH v3 1/6] block/nvme: don't touch the completion entries
References: <20190703155944.9637-1-mlevitsk@redhat.com>
 <20190703155944.9637-2-mlevitsk@redhat.com>
 <c47da7ef-82ac-1a76-9c8e-f76336c20c44@redhat.com>
 <d009ad68b237aae51d327955367dc2356f33bba0.camel@redhat.com>
In-Reply-To: <d009ad68b237aae51d327955367dc2356f33bba0.camel@redhat.com>

--gdQUBiS15iMXSaUEvDyHWdGaa1XfG5TXb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.07.19 10:43, Maxim Levitsky wrote:
> On Fri, 2019-07-05 at 13:03 +0200, Max Reitz wrote:
>> On 03.07.19 17:59, Maxim Levitsky wrote:
>>> Completion entries are meant to be only read by the host and written =
by the device.
>>> The driver is supposed to scan the completions from the last point wh=
ere it left,
>>> and until it sees a completion with non flipped phase bit.
>>
>> (Disclaimer: This is the first time I read the nvme driver, or really
>> something in the nvme spec.)
>>
>> Well, no, completion entries are also meant to be initialized by the
>> host.  To me it looks like this is the place where that happens:
>> Everything that has been processed by the device is immediately being
>> re-initialized.
>>
>> Maybe we shouldn=E2=80=99t do that here but in nvme_submit_command(). =
 But
>> currently we don=E2=80=99t, and I don=E2=80=99t see any other place wh=
ere we currently
>> initialize the CQ entries.
>=20
> Hi!
> I couldn't find any place in the spec that says that completion entries=
 should be initialized.
> It is probably wise to initialize that area to 0 on driver initializati=
on, but nothing beyond that.

Ah, you=E2=80=99re right, I misread.  I didn=E2=80=99t pay as much attent=
ion to the
=E2=80=9C...prior to setting CC.EN to =E2=80=981=E2=80=99=E2=80=9D as I s=
hould have.  Yep, and that is
done in nvme_init_queue().

OK, I cease my wrongful protest:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> In particular that is what the kernel nvme driver does.=20
> Other that allocating a zeroed memory (and even that I am not sure it d=
oes),=20
> it doesn't write to the completion entrie


--gdQUBiS15iMXSaUEvDyHWdGaa1XfG5TXb--

--USCwwg2j1GX8g46N9jXoW4sJJc16TrjzP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0jNd4ACgkQ9AfbAGHV
z0DN5gf/UG3C0NhsOGgY68EqJEOnUfHBdD2zTYukESt4vb+GcXBuHoSP+GpwcnKO
qeOlBOffwCmpmyOrHr6derj6J9jLn2G5Pj6yz9x/01z3A0KzBRvf/2hEpBxw5Biy
Ik+4AvXYh+ZeYY9fltKOg0T241T7EkWrGKNoDoSktQrl/DMVFKt1vqNJTEydXYtF
KQbNI/7rnBppMKPj+HnLTxxd4yezYe9h48tctGhTy/tFU51yjlLl7o4HqabpISns
8OhHroBBj0JBv2b2DHwA4aeaVMsy41vpRMSLEspxd0mn7wyjaBENEiPrzou9lbCj
vRUv9Cim/2A4QIMuyoIaf8qkvF44fQ==
=L0W2
-----END PGP SIGNATURE-----

--USCwwg2j1GX8g46N9jXoW4sJJc16TrjzP--


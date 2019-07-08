Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F19BC606AC
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 13:03:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12EC12064B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 13:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12EC12064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkTIm-0006e0-5L
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 09:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46523)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hkTGj-00062M-I6
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hkTGh-0005LW-Fb
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:01:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51938)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hkTGb-0005Cc-Gu; Mon, 08 Jul 2019 09:01:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 349EB30832E9;
 Mon,  8 Jul 2019 13:01:03 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-127.brq.redhat.com
 [10.40.204.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 88E2B2D1BC;
 Mon,  8 Jul 2019 13:00:55 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190703155944.9637-1-mlevitsk@redhat.com>
 <20190703155944.9637-2-mlevitsk@redhat.com>
 <c47da7ef-82ac-1a76-9c8e-f76336c20c44@redhat.com>
 <d009ad68b237aae51d327955367dc2356f33bba0.camel@redhat.com>
 <5d32c846-1ff6-ec99-af20-8e7a794c4fe2@redhat.com>
 <7eeafe074290d5374b5ad6c0fc81d1c0dea492e1.camel@redhat.com>
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
Message-ID: <32e58390-1093-c470-84be-980f1b3e12f5@redhat.com>
Date: Mon, 8 Jul 2019 15:00:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7eeafe074290d5374b5ad6c0fc81d1c0dea492e1.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tcNYrtOm3VsvnGGdfKjkPgIOnuLB00no7"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 08 Jul 2019 13:01:03 +0000 (UTC)
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
--tcNYrtOm3VsvnGGdfKjkPgIOnuLB00no7
Content-Type: multipart/mixed; boundary="plBbpuG6C2pD7kS90BjhXyWS1QEjaRvLy";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <32e58390-1093-c470-84be-980f1b3e12f5@redhat.com>
Subject: Re: [PATCH v3 1/6] block/nvme: don't touch the completion entries
References: <20190703155944.9637-1-mlevitsk@redhat.com>
 <20190703155944.9637-2-mlevitsk@redhat.com>
 <c47da7ef-82ac-1a76-9c8e-f76336c20c44@redhat.com>
 <d009ad68b237aae51d327955367dc2356f33bba0.camel@redhat.com>
 <5d32c846-1ff6-ec99-af20-8e7a794c4fe2@redhat.com>
 <7eeafe074290d5374b5ad6c0fc81d1c0dea492e1.camel@redhat.com>
In-Reply-To: <7eeafe074290d5374b5ad6c0fc81d1c0dea492e1.camel@redhat.com>

--plBbpuG6C2pD7kS90BjhXyWS1QEjaRvLy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.07.19 14:51, Maxim Levitsky wrote:
> On Mon, 2019-07-08 at 14:23 +0200, Max Reitz wrote:
>> On 07.07.19 10:43, Maxim Levitsky wrote:
>>> On Fri, 2019-07-05 at 13:03 +0200, Max Reitz wrote:
>>>> On 03.07.19 17:59, Maxim Levitsky wrote:
>>>>> Completion entries are meant to be only read by the host and writte=
n by the device.
>>>>> The driver is supposed to scan the completions from the last point =
where it left,
>>>>> and until it sees a completion with non flipped phase bit.
>>>>
>>>> (Disclaimer: This is the first time I read the nvme driver, or reall=
y
>>>> something in the nvme spec.)
>>>>
>>>> Well, no, completion entries are also meant to be initialized by the=

>>>> host.  To me it looks like this is the place where that happens:
>>>> Everything that has been processed by the device is immediately bein=
g
>>>> re-initialized.
>>>>
>>>> Maybe we shouldn=E2=80=99t do that here but in nvme_submit_command()=
=2E  But
>>>> currently we don=E2=80=99t, and I don=E2=80=99t see any other place =
where we currently
>>>> initialize the CQ entries.
>>>
>>> Hi!
>>> I couldn't find any place in the spec that says that completion entri=
es should be initialized.
>>> It is probably wise to initialize that area to 0 on driver initializa=
tion, but nothing beyond that.
>>
>> Ah, you=E2=80=99re right, I misread.  I didn=E2=80=99t pay as much att=
ention to the
>> =E2=80=9C...prior to setting CC.EN to =E2=80=981=E2=80=99=E2=80=9D as =
I should have.  Yep, and that is
>> done in nvme_init_queue().
>>
>> OK, I cease my wrongful protest:
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>>>
>=20
> Thank you very much!
> BTW, the qemu driver does allocate zeroed memory (in nvme_init_queue,=20
> "q->queue =3D qemu_try_blockalign0(bs, bytes);"

Yes, that=E2=80=99s what I was referring to above. :-)

> Thus I think this is all that is needed in that regard.
>=20
> Note that this patch doesn't fix any real bug I know of,=20
> but just makes the thing right in regard to the spec.
> Also racing with hardware in theory can have various memory ordering bu=
gs,
> although in this case the writes are done in=20
> entries which controller probably won't touch, but still.
>=20
> TL;DR - no need in code which does nothing and might cause issues.
>=20
> Do you want me to resend the series or shall I wait till we decide
> what to do with the image creation support? I done fixing all the
> review comments long ago, just didn't want to resend the series.
> Or shall I drop that patch and resend?

I think I won=E2=80=99t apply the image creation patch now, so it=E2=80=99=
s probably
better to just drop it for now.

> From the urgency standpoint the only patch that really should
> be merged ASAP is the one that adds support for block sizes,
> because without it, the whole thing crashes and burns on 4K
> nvme drives.

By now we=E2=80=99re in softfreeze anyway, so unless write-zeroes/discard=

support is important now, it=E2=80=99s difficult to justify taking them f=
or 4.1.
 So for me it would be best if you put patches 1 through 3 into a
for-4.1 series and move the rest to 4.2.  (I=E2=80=99d probably also spli=
t the
creation patch off, because I don=E2=80=99t think I=E2=80=99m going to ap=
ply it before
having experimented a bit with blockdev-create for qemu-img.)

If you think write-zeroes/discard support is important for 4.1, feel
free to include them in the for-4.1 series along with an explanation as
to why it=E2=80=99s important.

Max


--plBbpuG6C2pD7kS90BjhXyWS1QEjaRvLy--

--tcNYrtOm3VsvnGGdfKjkPgIOnuLB00no7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0jPoUACgkQ9AfbAGHV
z0BOvQgAq11StipzC7Y0UwDY89ommdiSf1zhxAr0Co00BB1U6nKUdBMv3iqzmwIH
Z1Xm5PB4WgvhCrWKp3SAR08RWISBUdmBhfkqnNYqxlZG09n/mPFepPhbivn7Ks/W
DyYnA8JTeVIcwadJnxCzFcXMQjyzvEkeBEk9ghY0QtBANRCtjme/o9AieKiQtNWN
AP8KqgGSkI6ljNxrvnYvblNyKEyYcpabOpxll1Y5JRBNeXvwF2bFQSQmerQHxgAR
zrYqRBSrrAINucsEVRd7bDlYAL48ypmSZOZudryCSlhH8H7InH7bIG2n9hH4jFjL
SYEFdUJdWbClgVqkaVPoC0LDBlff7Q==
=tZ/G
-----END PGP SIGNATURE-----

--tcNYrtOm3VsvnGGdfKjkPgIOnuLB00no7--


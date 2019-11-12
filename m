Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC389C17441
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:49:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78EBA222BD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTFGPbPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78EBA222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUTjk-0002Ql-K4
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 05:49:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iUThq-0000IZ-Jz
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:47:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iUThp-00085E-5Y
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:47:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48558
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iUThp-000853-1t
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573555648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xuzf2aAhVCKbbyzUiziMYkimd86sF7n+FshiaeWk93A=;
 b=ZTFGPbPk7BygdSRkdHlYbK/SP0xv4RKTTOmpD9X5VwfdKOeU80YB2kG/mC7tBArju7on1P
 QMT3QhSJwy1Ry3eKb9D8zoXgb7ShbM3+VEoF2cQWz3nDV03rx0tq0hXA2grchQ5c92IBPr
 62IKcVBLvYiwhFEEDBjXpi7Y2YFYh6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-SPhhH7JrO1CIiVQKT4IbBw-1; Tue, 12 Nov 2019 05:47:25 -0500
X-MC-Unique: SPhhH7JrO1CIiVQKT4IbBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B42235994C;
 Tue, 12 Nov 2019 10:47:24 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-206.ams2.redhat.com
 [10.36.116.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BA0360173;
 Tue, 12 Nov 2019 10:47:02 +0000 (UTC)
Subject: Re: API definition for LUKS key management
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <122fc70c802b9a1185e008bf13fb7f078fe70af7.camel@redhat.com>
 <20191111183424.GR814211@redhat.com> <20191112091245.GB5364@linux.fritz.box>
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
Message-ID: <1543a6e1-6cb9-b1ea-5f98-79308bf09c75@redhat.com>
Date: Tue, 12 Nov 2019 11:47:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191112091245.GB5364@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TvypZ6L2vWVkRrPOyZXUY7JXa0Dqk0Rw9"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 John Ferlan <jferlan@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TvypZ6L2vWVkRrPOyZXUY7JXa0Dqk0Rw9
Content-Type: multipart/mixed; boundary="Ud6ZAYpCbaf4kKUtHKkRs1kHfKDjVnpZS"

--Ud6ZAYpCbaf4kKUtHKkRs1kHfKDjVnpZS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.11.19 10:12, Kevin Wolf wrote:
> Am 11.11.2019 um 19:34 hat Daniel P. Berrang=C3=A9 geschrieben:
>> On Mon, Nov 11, 2019 at 05:58:20PM +0200, Maxim Levitsky wrote:
>>> One of the concerns that was raised during the review was that amend in=
terface for luks that I propose is
>>> different from the amend inteface used currently for qcow2.
>>>
>>> qcow2 amend interface specifies all the format options, thus overwrites=
 the existing options.
>>> Thus it seems natural to make the luks amend interface work the same wa=
y, that it receive an array
>>> of 8 slots, and for each slot specify if it is active, and if true what=
 password to put in it.
>>> This does allow to add and erase the keyslots, but it doesn't allow:
>>>
>>>    * add a password without knowing all other passwords that exist in e=
xisting keyslots
>>>      this can be mitigated by specifying which keyslots to modify for e=
xample by omitting the
>>>      keyslots that shouldn't be touched from the array (passing null pl=
aceholder instead)
>>>      but then it already doesn't follow the 'specify all the options ea=
ch time' principle.
>>
>> I think this is highly undesirable, as we must not assume that the
>> mgmt app has access to all the passwords currently set.
>=20
> And I think this shows the problem that we realy have with the crypto
> driver and amend: For every other driver, if you must, you can query the
> current settings and just write them back.
>=20
> The difference here is that crypto doesn't allow to directly query or
> specify the content of some options (the keyslots), but provides only a
> way to derives that content from a secret, and obviously there is no way
> back from the stored data to the secret (that's what it's for).
>=20
> I think we have two options here:
>=20
> 1. Add a special "don't touch this" value for keyslots. Normally, just
>    leaving out the value would be suitable syntax for this. Here,
>    however, we have a list of keyslots, so we can't leave anything out.
>=20
>    We could use something like an alternate between str (new secret ID),
>    null (erase keyslot) and empty dict (leave it alone) - the latter
>    feels a bit hackish, but maybe it's not too bad.

I thought of something similar, but how would that look on the command line=
?

Though I suppose if the worst thing were how it looks on the command
line, we could introduce a new qemu-img subcommand that then internally
translates into the right amend syntax.

>    If the list is
>    shorter than 8 entries, the rest is assumed to mean "leave it alone",
>    too.
>=20
> 2. Allow to query and set the raw key, which doesn't require a password
>=20
>> The two key use cases for having multiple key slots are
>>
>>   - To enable a two-phase change of passwords to ensure new password
>>     is safely written out before erasing the old password
>>    =20
>>   - To allow for multiple access passwords with different controls
>>     or access to when each password is made available.
>>
>>     eg each VM may have a separate "backup password" securely
>>     stored off host that is only made available for use when
>>     doing disaster recovery.
>>
>> the second use case is doomed if you need to always provide all
>> current passwords when changing any key slots.
>=20
> That providing all current passwords doesn't work is obvious.
>=20
>>>    * erase all keyslots matching a password - this is really hard to do=
 using this approach,
>>>      unless we give user some kind of api to try each keyslot with give=
n password,
>>>      which is kind of ugly and might be racy as well.
>>
>>> So what do you think?
>>
>> The point of using "amend" is that we already have some of the boilerpla=
te
>> supporting framework around that, so it saves effort for both QEMU and
>> our users. If the semantics of "amend" don't fit nicely though, then the
>> benefit of re-using "amend" is cancelled out and we should go back to
>> considering a separate "key-manage" command.
>=20
> This wouldn't solve the fundamental problem that the crypto block
> driver, as it currently is, isn't able to provide a blockdev-amend
> callback. It's worse for qcow2 because qcow2 already implements amend.

Hm, well, I would have assumed this is only bad on the premise that we
want to have amend be complete at some point.  Do we?

While I do think it might be nice to be able to change e.g. cluster_size
especially for the upcoming subcluster extension (in addition to
enabling subclusters on an existing image), I seriously doubt anyone=E2=80=
=99s
going to implement it.  (Maybe enabling subclusters, but not changing
cluster_size.)

> I think we need to find a solution for the amend API.

I do think it=E2=80=99s weird to look for non-amend solutions when it clear=
ly
looks like an amend problem, but OTOH I don=E2=80=99t think it would be tha=
t bad
to disregard amend.  (Provided there are good reasons for disregarding it.)

Max


--Ud6ZAYpCbaf4kKUtHKkRs1kHfKDjVnpZS--

--TvypZ6L2vWVkRrPOyZXUY7JXa0Dqk0Rw9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3KjaUACgkQ9AfbAGHV
z0DWtgf/diYQPrU45GqFtKfWg6C/pUS3coLdhHsSY1rXDSVT8lZCr0/lFgW1jmJc
GkQsgOeLZuNYHSYEJVHRgM0CqLs4cw3GzI5LsDv/J9B7ZqePKK+H4JNou7wkUKMm
Vd+jb+1gWoVFS8F5VmLiPSFtPxM2PLkqZ4UFGdcraHhaiE44vNT22VzoY+2xN5jx
M8b1Gdu4UqJJ/M+KrECmo0pt4OYkIaxPMN0U10DyBnIRgGQIjBaLzBnWgLXMMInN
1qwsKd1g96nrnpYq0/8CnyG/GUf4HDDr4GLoaOGQjzaUZUPo1bec0K9GGpPcg0Zt
ew8SYOdc518fHZ9ShjBoodWq5HIkoA==
=YixZ
-----END PGP SIGNATURE-----

--TvypZ6L2vWVkRrPOyZXUY7JXa0Dqk0Rw9--



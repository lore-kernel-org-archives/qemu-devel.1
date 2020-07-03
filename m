Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90BBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8435620826
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DniHgAUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8435620826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrM3s-0007mm-PJ
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jrM2h-0006fF-Bi
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:47:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60863
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jrM2e-0006QC-TD
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593784067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5wRPfzmuIEiz4KfNJYnwnVZHbf+DmzS5ulehTwdR4XE=;
 b=DniHgAUdPzlsc+X995l/diaSr1iDR2c7O7eXtplZa4JbtnasJl1/ItBa/syqpBQr11ORuK
 mDYQUtVUatR2lvewVBCdgJCRC+gKik/RDX2xmPPW6Uxu2J2rHKRHxSBmwdpvk0nj1nHenT
 YQqqxWCZJWuKt0EQG+kKfGSIs728n8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-kSwggdgvOti5ruBagW2Nrg-1; Fri, 03 Jul 2020 09:47:45 -0400
X-MC-Unique: kSwggdgvOti5ruBagW2Nrg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 875C410059AA;
 Fri,  3 Jul 2020 13:47:44 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-131.ams2.redhat.com
 [10.36.113.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E436817D8F;
 Fri,  3 Jul 2020 13:47:42 +0000 (UTC)
Subject: Re: [PATCH v9 34/34] iotests: Add tests for qcow2 images with
 extended L2 entries
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1593342067.git.berto@igalia.com>
 <536717bef174a2d5405647bf9ecf899e0aafadbb.1593342067.git.berto@igalia.com>
 <2a791051-5967-0279-75a1-4a44817b83b3@redhat.com>
 <w51o8owwxvz.fsf@maestria.local.igalia.com>
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
Message-ID: <9afea208-5a07-4ef9-2cec-0ca1008e08b0@redhat.com>
Date: Fri, 3 Jul 2020 15:47:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <w51o8owwxvz.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QYVCvd3fRZ9CWbpt7aQNJUgYNkVtMabjd"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:38:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QYVCvd3fRZ9CWbpt7aQNJUgYNkVtMabjd
Content-Type: multipart/mixed; boundary="5CmfJdNTpqTBpFFyzTVvsFeiLE3lc9mQt"

--5CmfJdNTpqTBpFFyzTVvsFeiLE3lc9mQt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.07.20 15:06, Alberto Garcia wrote:
> On Fri 03 Jul 2020 11:49:14 AM CEST, Max Reitz wrote:

[...]

>>> +    expected_bitmap=3D0
>>> +    for bit in $expected_alloc; do
>>> +        expected_bitmap=3D$(($expected_bitmap | (1 << $bit)))
>>> +    done
>>> +    for bit in $expected_zero; do
>>> +        expected_bitmap=3D$(($expected_bitmap | (1 << (32 + $bit))))
>>> +    done
>>> +    printf -v expected_bitmap "%llu" $expected_bitmap # Convert to uns=
igned
>>
>> Does the length modifier =E2=80=9Cll=E2=80=9D actually do anything?
>>
>>> +
>>> +    printf "L2 entry #%d: 0x%016lx %016lx\n" "$entry_no" "$entry" "$bi=
tmap"
>>
>> Or the =E2=80=9Cl=E2=80=9D here?
>=20
> Actually they don't (I just tested in i386 and x86_64), I assumed that
> it would require the length modifiers like in C.
>=20
> I'm tempted to leave them for clarity (using 'll' in both cases),
> opinions?

I don=E2=80=99t mind, although at least zsh=E2=80=99s printf doesn=E2=80=99=
t seem to support
them all:

$ printf %lli 42
printf: %ll: invalid directive

So it doesn=E2=80=99t seem portable to me.  But then again I think we run a=
ll of
our tests in bash, and in any case, Eric=E2=80=99s the expert on shell
compatibility. :)

Max


--5CmfJdNTpqTBpFFyzTVvsFeiLE3lc9mQt--

--QYVCvd3fRZ9CWbpt7aQNJUgYNkVtMabjd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl7/Nv0ACgkQ9AfbAGHV
z0A1DwgAl8VgZTbEr3mlNiv7EkpVuGOuk5wKAHzI3LTXOtY07xo/NhjXiR/kZpei
pCIV5EIfoQDn5wvnW71AxVD1hHl15s2WlI6CjICDHu/4gdgn6fsQOvfzSRAFgCO7
/Ae3wLQcnmCsR81ukCLNfqyO0uyts9kSAJEqYDlMc/cH9q4do04jb8E7H7SkylCB
ersZAxT/pY0kJi7QsSti/cIg8OWry6sVfwe/TLPy53K30Z/7C9Z4I9R2u4Gll6fI
1Gwai7BeYBZj81b9amjJW4jKyDIOTtTxesbRWyqiL0OrEdB3XJPyClWfPCE+tpqQ
aCjmkYg/wV6dHmm0U/ecfE81OMAv4A==
=1Nca
-----END PGP SIGNATURE-----

--QYVCvd3fRZ9CWbpt7aQNJUgYNkVtMabjd--



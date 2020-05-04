Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CAFC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF2E2073E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQ4YxUMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF2E2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaqS-0002Hf-62
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 09:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVapp-0001Rj-Vj
 for qemu-devel@nongnu.org; Mon, 04 May 2020 09:08:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34470
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVapo-0004ZN-OA
 for qemu-devel@nongnu.org; Mon, 04 May 2020 09:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588597715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f7rmu0t3yoGFtKFRZ+35CNidkJfUSyAzLuJRqx+4pLI=;
 b=DQ4YxUMIHI/LMUwwrSgia7nyttAwoo+etKsw6WUhw1KO6rcoHN3T0wEyPoHTItRbXyfROs
 /ZtOPPZAthKMd+cuGYTY+2tUHR/+4YlvRfOISQnEWrElw5JXNzfhcWwUL3mzk1T2EUzQ41
 nce2yTA9U+hnz3GqEUMgaRQLzy7/3/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-U8H2bQtUM4qL1lmPz0KY6A-1; Mon, 04 May 2020 09:08:33 -0400
X-MC-Unique: U8H2bQtUM4qL1lmPz0KY6A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2F2D872FEE;
 Mon,  4 May 2020 13:08:32 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-219.ams2.redhat.com
 [10.36.113.219])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DD565C1B2;
 Mon,  4 May 2020 13:08:30 +0000 (UTC)
Subject: Re: [PATCH] Fix iotest 153
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20200503164943.27215-1-mlevitsk@redhat.com>
 <ae56957e-090c-0d8d-0499-4e1b97e615e0@redhat.com>
 <93921c24cdb5f70b3d836500bf0d3836c8a9fbb1.camel@redhat.com>
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
Message-ID: <d4bb0d5e-615c-eac9-d0cd-5e8ad1e1d07a@redhat.com>
Date: Mon, 4 May 2020 15:08:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <93921c24cdb5f70b3d836500bf0d3836c8a9fbb1.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SIYEjCGEFt8d0Aw6TlZC5jkiMtSD4jhwU"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 08:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SIYEjCGEFt8d0Aw6TlZC5jkiMtSD4jhwU
Content-Type: multipart/mixed; boundary="WLhKr1N5c7QgjePqvuDfwxwA3qY2kB2kk"

--WLhKr1N5c7QgjePqvuDfwxwA3qY2kB2kk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.05.20 11:41, Maxim Levitsky wrote:
> On Mon, 2020-05-04 at 11:22 +0200, Max Reitz wrote:
>> On 03.05.20 18:49, Maxim Levitsky wrote:
>>> Commit f62514b3def5fb2acbef64d0e053c0c31fa45aff made qemu-img reject -o=
 "" but this test uses it
>>>
>>> Since this test only tries to do a dry-run run of qemu-img amend, repla=
ce the -o "" with
>>> dummy -o "size=3D0" since due to the nature of the test, it is not goin=
g
>>> to reach the actual amend operation anyway
>>>
>>> Fixes: f62514b3def5fb2acbef64d0e053c0c31fa45aff
>>>
>>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>>> ---
>>>  tests/qemu-iotests/153     |  2 +-
>>>  tests/qemu-iotests/153.out | 12 ++++++------
>>>  2 files changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
>>> index 2b13111768..3f5029dd8f 100755
>>> --- a/tests/qemu-iotests/153
>>> +++ b/tests/qemu-iotests/153
>>> @@ -122,7 +122,7 @@ for opts1 in "" "read-only=3Don" "read-only=3Don,fo=
rce-share=3Don"; do
>>>          _run_cmd $QEMU_IMG check       $L "${TEST_IMG}"
>>>          _run_cmd $QEMU_IMG compare     $L "${TEST_IMG}" "${TEST_IMG}"
>>>          _run_cmd $QEMU_IMG map         $L "${TEST_IMG}"
>>> -        _run_cmd $QEMU_IMG amend -o "" $L "${TEST_IMG}"
>>> +        _run_cmd $QEMU_IMG amend -o "size=3D0" $L "${TEST_IMG}"
>>
>> AFAIU we don=E2=80=99t want this command to actually change the image (h=
ence the
>> empty options list, which would result in nothing being changed), so
>> maybe "size=3D$size" would be more in the spirit of the test?
>=20
> This is a good idea! Should I resend the patch or you can add this change=
 locally?

Fixing it up locally should actually rather be the exception than the
rule.  It makes sense for larger series where resending it just for one
little thing generates too much noise, but in this case I don=E2=80=99t thi=
nk
sending a v2 would hurt.

Max


--WLhKr1N5c7QgjePqvuDfwxwA3qY2kB2kk--

--SIYEjCGEFt8d0Aw6TlZC5jkiMtSD4jhwU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6wE80ACgkQ9AfbAGHV
z0Dl6gf/fF/jXEm9ujeRXZZI78FC4c16LioyRTd9qovPrdYxi2TEHAbvhKtitWq9
abCqa8b31zgxdys3BBSMpM9UpT7mSG9mTb8uD+aomWAKgX5B/9KEmpf9SCHhf4jY
+ZItE3V1Q+Com37aBchNe8L956jTqCfrtfln/HkXrJz8pk0fysw4mnePQbWrsZu+
ZIQpM6Fn7ew8ygK6/QerQb2nzEdWj6EUVH4D9xecaXddH9gFxgMRGJrJEy+Tffmv
cHgclpscxuWI43brqyIQTut18WnRiyT34kt0Wtxq1GU3drXg7D974DY+8Cbl0I1b
S6nH5AZxoLecYdWmXoRpwHY5/vtV6w==
=sOz+
-----END PGP SIGNATURE-----

--SIYEjCGEFt8d0Aw6TlZC5jkiMtSD4jhwU--



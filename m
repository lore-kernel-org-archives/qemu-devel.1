Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B6DC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F48208DB
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7B+iaDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F48208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHmRd-0008Ez-FQ
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 07:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kHmQk-0007UN-3m
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:13:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23916
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kHmQg-0006fY-Pk
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600082029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=n8E3u84LGYokTPzIRnmaf/+ellTgP846xgIIKjoyE6k=;
 b=f7B+iaDD8/bOCV8+nmjiC7dohqFwtq0DD/obrUIINuXXZuoHSYg7128aeYA0AkhsMnp5BY
 QXa6shjfP5vHNALpYh4LF+0xdciuu1/PCtW+K2NqaKVx5OvqSdw3SKDOxDotO5uPCxXW5m
 JQbPFSwccgorIn6yWeJfZmV7qO33wik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-3TGxBDiNNR6pHyTdQpcEUw-1; Mon, 14 Sep 2020 07:13:47 -0400
X-MC-Unique: 3TGxBDiNNR6pHyTdQpcEUw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7319D1882FC1;
 Mon, 14 Sep 2020 11:13:46 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-80.ams2.redhat.com
 [10.36.114.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 35C6360BE2;
 Mon, 14 Sep 2020 11:13:45 +0000 (UTC)
Subject: Re: [PATCH] tests/check-block: Do not run the iotests with old
 versions of bash
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200912121412.10999-1-thuth@redhat.com>
 <8e1a8f08-5fd1-b53e-07a4-70170e4451e0@redhat.com>
 <532c3912-b18b-86bf-52a2-044aaacbbc81@redhat.com>
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
Message-ID: <803bda1b-fc4a-3221-b130-f86c45f30826@redhat.com>
Date: Mon, 14 Sep 2020 13:13:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <532c3912-b18b-86bf-52a2-044aaacbbc81@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XKv58WBkeufjtKdgHUZw7QBd1tyIgtAtN"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:33:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XKv58WBkeufjtKdgHUZw7QBd1tyIgtAtN
Content-Type: multipart/mixed; boundary="oor6X4QfECTXIJb6SVDmwW4VRPjLgkl0n"

--oor6X4QfECTXIJb6SVDmwW4VRPjLgkl0n
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.09.20 12:50, Thomas Huth wrote:
> On 14/09/2020 11.19, Max Reitz wrote:
>> On 12.09.20 14:14, Thomas Huth wrote:
>>> macOS is shipped with a very old version of the bash (3.2), which
>>> is currently not suitable for running the iotests anymore. Add
>>> a check to skip the iotests in this case - if someone still wants
>>> to run the iotests on macOS, they can install a newer version from
>>> homebrew, for example.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  tests/check-block.sh | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/tests/check-block.sh b/tests/check-block.sh
>>> index 8e29c868e5..bfe1630c1e 100755
>>> --- a/tests/check-block.sh
>>> +++ b/tests/check-block.sh
>>> @@ -46,6 +46,11 @@ if ! command -v bash >/dev/null 2>&1 ; then
>>>      exit 0
>>>  fi
>>> =20
>>> +if bash --version | grep 'GNU bash, version [123]' > /dev/null 2>&1 ; =
then
>>
>> grep -q instead of the redirections, perhaps?
>>
>> But more importantly, I think this needs a LANG=3DC prefix.  (If I expan=
d
>> the rejected major versions to [12345], it doesn=E2=80=99t skip without =
a
>> prefix, because the string reads =E2=80=9CGNU bash, Version 5...=E2=80=
=9D here in
>> LANG=3Dde_DE.UTF-8.)
>=20
> Ouch, ok. But actually, I'm not quite sure anymore whether the patch is
> really required. I ran into the "readlink -f" problem and thought that
> it occurred due to the ancient version of bash on macOS, but as a I now
> know, readlink is a separate program and not a bash built-in, so it's a
> different issue... thus let's skip this patch here for now until we hit
> a real issue with bash again.

Yes, I had hoped this patch would fix that issue.  Or perhaps at least
hide it, because if you have a newer bash, chances are your readlink has
-f, too.

So should we just effectively revert b1cbc33a397 if readlink -f didn=E2=80=
=99t
work, i.e. check "$?" and on failure use $PWD as it was before b1cbc33a397?

Max


--oor6X4QfECTXIJb6SVDmwW4VRPjLgkl0n--

--XKv58WBkeufjtKdgHUZw7QBd1tyIgtAtN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9fUGcACgkQ9AfbAGHV
z0A+QAgAvVcPGXBW6Cy30j3/LIj1NOb1PGxvvzKzJ1T3swPMB4N4oTQ1FGh4zZpL
HlWWAOtG75UeHsQqZ7fCRosb24T8L4kePFy13JOH26GAIsrPuw5zL6D/yCFFhLKY
2s4uyPPc6u3JegN/5/7ty3kH1YfAnOysbr0xyFuccsQWXp86xSJVI3C5AZj03y1B
+6u/fHNTO6Qq/q4IO0DYW4fY8FAeZ4xvApXCTbhM7FSfW1cMbIC/Pou8oAL0m4Q5
TrjQvbtge7iuWzYrFsgI3Twc+/E+LpVYm2ia54gml49OuVkOpOQRkllFLQArz5bd
yfpBl829OQj8HY/HRouUD90XtxUCVA==
=pIgT
-----END PGP SIGNATURE-----

--XKv58WBkeufjtKdgHUZw7QBd1tyIgtAtN--



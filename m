Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C1AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:14:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02CC22075F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CL9H+XQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CC22075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAaez-0003vM-Az
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 11:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAadm-0002i5-31
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:13:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41925
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAadj-0004ki-Qs
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598368415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=smySdvAeg8WrA3xfMcUd8eJhAb/z+f+MtQN9dzWEg7k=;
 b=CL9H+XQ2b0HjZY4QVmQS0YNobosdykK0KxsuYD/sfl2AVh4b4l3Vj0QqGzzUIVFpt+aRJq
 WkNK97t4ygzUlMaVqGSoF6Q5syrr6H8TrZRfiQ4wz4DpSexi8f3zFYo6c7BagktByJT6jp
 KJzCdHKk44ZHKBnrw6P4DDW0CUZzOM0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-TqA0a2-pMPC0BqO-zfRpXA-1; Tue, 25 Aug 2020 11:13:31 -0400
X-MC-Unique: TqA0a2-pMPC0BqO-zfRpXA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 328C71900CA1;
 Tue, 25 Aug 2020 15:13:30 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-72.ams2.redhat.com
 [10.36.113.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27FE47E728;
 Tue, 25 Aug 2020 15:13:26 +0000 (UTC)
Subject: Re: [PULL 00/34] Block patches
To: Alberto Garcia <berto@igalia.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20200825083311.1098442-1-mreitz@redhat.com>
 <CAFEAcA-4bgPq2_8c7wo9y_A5Mp1KZ7iLuye5jQMMesXfE+fNhw@mail.gmail.com>
 <w51pn7e24ak.fsf@maestria.local.igalia.com>
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
Message-ID: <e599e45c-4d3d-15e2-967a-48a20c943e3f@redhat.com>
Date: Tue, 25 Aug 2020 17:13:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <w51pn7e24ak.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5rOhX6aO7tdcnlE1cTAjbu8XeYl0CITmH"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 10:39:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.602, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5rOhX6aO7tdcnlE1cTAjbu8XeYl0CITmH
Content-Type: multipart/mixed; boundary="2F064IDncrHqf4Uy2dO3Tc0wSsY94nW4r"

--2F064IDncrHqf4Uy2dO3Tc0wSsY94nW4r
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.08.20 16:22, Alberto Garcia wrote:
> On Tue 25 Aug 2020 04:01:14 PM CEST, Peter Maydell <peter.maydell@linaro.=
org> wrote:
>> On Tue, 25 Aug 2020 at 09:33, Max Reitz <mreitz@redhat.com> wrote:
>>>
>>> The following changes since commit 30aa19446d82358a30eac3b556b4d6641e00=
b7c1:
>>>
>>>   Merge remote-tracking branch 'remotes/cschoenebeck/tags/pull-9p-20200=
812' into staging (2020-08-24 16:39:53 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   https://github.com/XanClic/qemu.git tags/pull-block-2020-08-25
>>>
>>> for you to fetch changes up to c576fd97d4ca77b5a1a27728df11a61083dbfa98=
:
>>>
>>>   iotests: Add tests for qcow2 images with extended L2 entries (2020-08=
-25 10:20:18 +0200)
>>>
>>> ----------------------------------------------------------------
>>> Block patches:
>>> - qcow2 subclusters (extended L2 entries)
>>
>> This fails 'make check' on the BSDs because it assumes it has a bash
>> in /bin/bash, which isn't necessarily true:

:(

> I guess it needs to be replaced by '#!/usr/bin/env bash', shall I send
> the patches again, or can you fix it Max?

Sure, I=E2=80=99ll fix it and send a v2 tomorrow.

Max


--2F064IDncrHqf4Uy2dO3Tc0wSsY94nW4r--

--5rOhX6aO7tdcnlE1cTAjbu8XeYl0CITmH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9FKpUACgkQ9AfbAGHV
z0Ayqgf8DdlNKYmfKNuOodBoizh7zVGkrSnj9hfsxAN/8cl9bcacnMV2w1mvqT9F
bwze55epYh+XuVLej9zctp2hmFCFm7cj5gky6Ko1jvK98/EyWvk8kDswXHin9kv5
/kvQVUJzNmkRvOVT+D2do313qIE60EcNIOteqVKx1ILKShMmi9ELa/K6uBY/89Pv
tBOVIZVBKEy3wEEp5/KYuW2hCQpyA2H1/1/rk21eCLQxMRjEIhhOZmXsvIOo+PcI
8a11Cr9d1Ok8YZd3XJfhPpfC+2kZ/+Bh3a6CsyU+s1YFI99zcO84G/841i2O1Zbi
M/ctzlJK8CzQ8WwSabBVskIbBMKA+A==
=v3e9
-----END PGP SIGNATURE-----

--5rOhX6aO7tdcnlE1cTAjbu8XeYl0CITmH--



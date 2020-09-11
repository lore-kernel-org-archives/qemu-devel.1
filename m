Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9296C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 10:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35CB722208
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 10:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S119iNm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35CB722208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGgly-0008PD-4z
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 06:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kGglA-0007fF-PF
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 06:58:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34819
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kGgl8-0004kM-31
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 06:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599821903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lnNpW1hCUwv6aLDbOWySRFNj5yf1EwkVRz1R0s6uh0c=;
 b=S119iNm8AFuPaI8nxDwB7eNspO+wb8iVpS0hwMQzwH0bev2BSiT0gEEEH0bdLEgLSg2i5w
 lsrBffTQPsEM54wjJzZ4EhD+rrjwhA+zJgBMtz9ijlUO7kZyD83RlmoVQVTIUDfr+MxMrc
 Q1I1IpsTT1YXCsZuNcnDX+vg97+keN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-3X6h8pNCO5O1-_cXRjMSrg-1; Fri, 11 Sep 2020 06:58:19 -0400
X-MC-Unique: 3X6h8pNCO5O1-_cXRjMSrg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FDE181CAFE
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 10:58:18 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-148.ams2.redhat.com
 [10.36.113.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CBC927BC7;
 Fri, 11 Sep 2020 10:58:17 +0000 (UTC)
Subject: Re: [PULL v2 01/46] qemu-iotests: move check-block back to Makefiles
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200906175344.5042-1-pbonzini@redhat.com>
 <20200906175344.5042-2-pbonzini@redhat.com>
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
Message-ID: <98f7869a-cb45-08b5-670a-ebc47254b0c2@redhat.com>
Date: Fri, 11 Sep 2020 12:58:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200906175344.5042-2-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="asQoGAdzqZJvceI54hhdtukL2SN2MNp4i"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 00:33:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--asQoGAdzqZJvceI54hhdtukL2SN2MNp4i
Content-Type: multipart/mixed; boundary="Gx7x8yWscqRWeaPmn8tGf4G2DdwmNsdxA"

--Gx7x8yWscqRWeaPmn8tGf4G2DdwmNsdxA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.09.20 19:53, Paolo Bonzini wrote:
> check-block has its own test harness, unlike every other test.  If
> we capture its output, as is in general nicer to do without V=3D1,
> there will be no sign of progress.  So for lack of a better option
> just move the invocation of the test back to Makefile rules.
>=20
> As a side effect, this will also fix "make check" in --disable-tools
> builds, as they were trying to run qemu-iotests without having
> made qemu-img before.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build                    |  1 -
>  tests/Makefile.include         | 15 ++++++++++++---
>  tests/qemu-iotests/meson.build |  4 ----
>  3 files changed, 12 insertions(+), 8 deletions(-)

I=E2=80=99m not entirely sure why (or I would=E2=80=99ve sent a patch mysel=
f), but this
breaks all iotests using the socket_scm_helper program unless one runs
make check-block before (or make tests/qemu-iotests/socket_scm_helper
specifically).

It seems like the socket_scm_helper is now only built as a dependency of
check-block, instead of all the time.  That=E2=80=99s a bit of a shame.
(The obvious workaround of course is to specifically build the
socket_scm_helper, but that doesn=E2=80=99t seem right.)

As a reproducer:

[delete build directory, or most importantly the socket_scm_helper]
[configure]
[make]
$ cd tests/qemu-iotests
$ ./check -nbd 147
[...]
+qemu.machine.QEMUMachineError: socket_scm_helper does not exist
[...]

Max


--Gx7x8yWscqRWeaPmn8tGf4G2DdwmNsdxA--

--asQoGAdzqZJvceI54hhdtukL2SN2MNp4i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9bWEcACgkQ9AfbAGHV
z0BBPQgAozWPTTXImhyn7/XE/rf3qt58ya59BiBZxzuonXHB7GjQkGO1vwyd4KIg
0z51RHYUm2Lrn3yFJVoUPQUXrwF+DGRsd3VMj18mvYX5l46IHlHbB0v5hiqvgX6W
AQOZfj2jWELReOXLbfElcu9hZvepN6S3YOSW4+UDXk2al3UQLAwWKyh/536mhkg3
qD4lkWUJmwqFprvyhhxiRm/7L4fWbZb5G60WBnEg8p0SrtFCtFduVHvwupjpAr/f
LrscBO3QD7uJ3dcJrmMK6FLzZMAZowJSL00MpOswkSIZX3bQx0FsdIhiD9ChX4nk
baoGiVmyvEqrvIWxu7njOu054WWl/Q==
=grcC
-----END PGP SIGNATURE-----

--asQoGAdzqZJvceI54hhdtukL2SN2MNp4i--



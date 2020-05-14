Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F478C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:04:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AAE4205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gsv/WZyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AAE4205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFPT-00008B-6e
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 11:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jZFAu-00047j-N7
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:49:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54849
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jZFAt-0003nJ-HM
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589467766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WiFjeVi7t51T4IcxHHQVuNI7d1jrE7Kn6UaNtPs3K+A=;
 b=Gsv/WZytT1Uj2uRnRI1yMRnfIImeBV7AS943pHd5SuOytW9uZIX91mhpKN+vADvTPXUQrS
 Am4ISl8OqklC6101dCIHtg2h2XGE1Z7TRbnIYaoZSA+0/Fzda1Y8kQrvMvdgr5dviuzDCQ
 C2uXo38BV8Qawsj5gzKqQBJA+rh+zOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-gOF59GHlP_aXR8zDXmndYg-1; Thu, 14 May 2020 10:49:24 -0400
X-MC-Unique: gOF59GHlP_aXR8zDXmndYg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AD481895A32;
 Thu, 14 May 2020 14:49:23 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9A3E620AF;
 Thu, 14 May 2020 14:49:21 +0000 (UTC)
Subject: Re: [PATCH v6 09/14] iotests: filter few more luks specific create
 options
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20200510134037.18487-1-mlevitsk@redhat.com>
 <20200510134037.18487-10-mlevitsk@redhat.com>
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
Message-ID: <9916f5ef-3373-8999-1c1b-bcc97e1ce7cd@redhat.com>
Date: Thu, 14 May 2020 16:49:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510134037.18487-10-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yIAbCxUt7pCJRdT1veX1fK4X4Udhcx0Xv"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yIAbCxUt7pCJRdT1veX1fK4X4Udhcx0Xv
Content-Type: multipart/mixed; boundary="aMCMT070m20Wjqlp9jjrO2sRSrvzHOxBg"

--aMCMT070m20Wjqlp9jjrO2sRSrvzHOxBg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.05.20 15:40, Maxim Levitsky wrote:
> This allows more tests to be able to have same output on both qcow2 luks =
encrypted images
> and raw luks images
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  tests/qemu-iotests/087.out       |  6 ++---
>  tests/qemu-iotests/134.out       |  2 +-
>  tests/qemu-iotests/158.out       |  4 +--
>  tests/qemu-iotests/188.out       |  2 +-
>  tests/qemu-iotests/189.out       |  4 +--
>  tests/qemu-iotests/198.out       |  4 +--
>  tests/qemu-iotests/263.out       |  4 +--
>  tests/qemu-iotests/274.out       | 46 ++++++++++++++++----------------
>  tests/qemu-iotests/284.out       |  6 ++---
>  tests/qemu-iotests/common.filter |  6 +++--
>  10 files changed, 43 insertions(+), 41 deletions(-)

[...]

> diff --git a/tests/qemu-iotests/274.out b/tests/qemu-iotests/274.out
> index 9d6fdeb1f7..59de176b99 100644
> --- a/tests/qemu-iotests/274.out
> +++ b/tests/qemu-iotests/274.out
> @@ -1,9 +1,9 @@
>  =3D=3D Commit tests =3D=3D
> -Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D2097152 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> +Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 cluster_size=3D65536 size=3D=
2097152 lazy_refcounts=3Doff refcount_bits=3D16
> =20
> -Formatting 'TEST_DIR/PID-mid', fmt=3Dqcow2 size=3D1048576 backing_file=
=3DTEST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bit=
s=3D16
> +Formatting 'TEST_DIR/PID-mid', fmt=3Dqcow2 cluster_size=3D65536 size=3D1=
048576 backing_file=3DTEST_DIR/PID-base lazy_refcounts=3Doff refcount_bits=
=3D16
> =20
> -Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D2097152 backing_file=
=3DTEST_DIR/PID-mid cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=
=3D16
> +Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 cluster_size=3D65536 size=3D2=
097152 backing_file=3DTEST_DIR/PID-mid lazy_refcounts=3Doff refcount_bits=
=3D16

@size and @cluster_size swapping positions doesn=E2=80=99t look right for t=
his
patch.  I think all hunks for 274.out should be in patch 5.

Max


--aMCMT070m20Wjqlp9jjrO2sRSrvzHOxBg--

--yIAbCxUt7pCJRdT1veX1fK4X4Udhcx0Xv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl69WnAACgkQ9AfbAGHV
z0BPtAf+LUPCI/63tP2K5P5917Qbs0e52ab8rG3x2Dtgr1ZxgeeQSw1sev17v6T3
FKbOCqTxanO5vfZgVuYIhl9W40oghMfAVsUXluehqOBcpMKSdfRKByvKvQtc0e78
TMrL9aSlOmdWEcrCOnJkqrtrd8v2OeeC+mukvoX/+TrxPxcRTuqj+WJ6DpLtGVl5
aMHsuax2cmKS/QMNovMcpDqfmNHKShJCnBvqiIZN1JkMRugTOdHOycwVlyRbxH/J
gYrCx6APYE/hW8WSaasFOLJ+Bum0XXOIINI+DP7bUeGK98a80xycCJNEvfh7Mr4s
wstmsnmqm1QDY+zaAf1Jc1FaLEVXFg==
=cdkt
-----END PGP SIGNATURE-----

--yIAbCxUt7pCJRdT1veX1fK4X4Udhcx0Xv--



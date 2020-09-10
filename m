Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1053AC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 11:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A191B20C09
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 11:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YfiSsPMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A191B20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGLAJ-000873-Nb
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 07:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kGL9m-0007b3-Gu
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 07:54:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23410
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kGL9k-0004vM-S2
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 07:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599738863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qpH3RzLEmYFxoiGSwixChabsvE+1N+3DekcDMNshWrE=;
 b=YfiSsPMiWHy0IsEDX++J4DV6X5/Ixdooc75RmatVvv739Mi38cmedr9IN3htbZtz+AGixx
 D4fDpRWsmIpW8l7Hvr8c3wOFMgDyeCbOFN2irDoHmINDENTk9KCMwsr2w5gXWaKEfHhb3D
 rv21fvwGgqT2nAiDUzByMoziZcwITQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-CvK6wUTNO4ueXK3Njb2Z2g-1; Thu, 10 Sep 2020 07:54:21 -0400
X-MC-Unique: CvK6wUTNO4ueXK3Njb2Z2g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DCC61DDFD;
 Thu, 10 Sep 2020 11:54:20 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-197.ams2.redhat.com
 [10.36.112.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 173E75D9E8;
 Thu, 10 Sep 2020 11:54:18 +0000 (UTC)
Subject: Re: [PULL v2] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20200908115322.325832-1-kwolf@redhat.com>
 <CAFEAcA-wrgOC9oqdqBuVSTiidaRcwbgQWF08zD=TSetSwn_tjA@mail.gmail.com>
 <480db253-9aa4-39c3-592f-bc5cfea1997b@redhat.com>
 <20200910091323.GC7100@linux.fritz.box>
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
Message-ID: <1ca1c2d9-a89c-de6e-4ea4-2eae01b0b7c6@redhat.com>
Date: Thu, 10 Sep 2020 13:54:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200910091323.GC7100@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8wbjxP5yjXBPTWnvApnjPbSH3MKmmm6lW"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 01:23:25
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8wbjxP5yjXBPTWnvApnjPbSH3MKmmm6lW
Content-Type: multipart/mixed; boundary="e9cC6tDTSxhcT2jgDeOF5aRHoqcPXaJKk"

--e9cC6tDTSxhcT2jgDeOF5aRHoqcPXaJKk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.09.20 11:13, Kevin Wolf wrote:
> Am 10.09.2020 um 00:09 hat Eric Blake geschrieben:
>> On 9/9/20 4:55 PM, Peter Maydell wrote:
>>
>>>
>>> This fails 'make check' on NetBSD and OpenBSD:
>>>
>>> ./check: line 47: realpath: command not found
>>> ./check: line 60: /common.env: No such file or directory
>>> check: failed to source common.env (make sure the qemu-iotests are run
>>> from tests/qemu-iotests in the build tree)
>>> gmake: *** [/home/qemu/qemu-test.vcb7nz/src/tests/Makefile.include:144:
>>> check-block] Error 1
>>
>> BSD has 'readlink -f' (and so does coreutils on Linux), which does the s=
ame
>> thing as the Linux-only realpath.
>=20
> Thanks, I'll use that in v3.
>=20
> Max, if v3 doesn't go through either, please take over the pull request
> as I will be on PTO until the 22th.

OK, sure.

(Enjoy your time off. :))

Max


--e9cC6tDTSxhcT2jgDeOF5aRHoqcPXaJKk--

--8wbjxP5yjXBPTWnvApnjPbSH3MKmmm6lW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9aE+kACgkQ9AfbAGHV
z0Bx6wf9EJj+VXfxS2By1gpE/J9CS9v1H1292Smn6q23otNzdPylOg+j4F9yO1zD
zCOsDKoWF8Gcso9FzpZ9VAwR38p/tKmhoxeD6leeWjq5RAapWPAAdo9J7mRBg7AV
iqtg6+vCCmE1iCrsHZNGvbI4tkplTEd9oIwjls5NPHVpKsiv/Hanq+ZJEPwWiUza
lIGoIecPP2u2QNiSS6GDJESaD9Y5spoPPeV9QEMyt0ncHXwrKNGAf/LfNI9n3r0l
ZjSy+et0blxYcOhq+LSyL0aMtTosH1/L92G8qM9Y7fm8t0r3TjjD7cX/aENSltYm
N/yeYnnrMzNR5TO2IY11zlzqwtsc2g==
=j9Y2
-----END PGP SIGNATURE-----

--8wbjxP5yjXBPTWnvApnjPbSH3MKmmm6lW--



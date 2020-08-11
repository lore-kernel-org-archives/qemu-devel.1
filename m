Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A38EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22207205CB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nc4iEEVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22207205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5R0b-0008GD-Bl
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 05:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k5Qzt-0007lW-JN
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 05:55:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22832
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k5Qzr-0003aH-KD
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 05:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597139706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=e5sXfwys3cXceWosYN1YB8vUBkGM3GYeu1+V3LWThlI=;
 b=Nc4iEEVVIfiDh5p5lRpW6UXaLiQhiDnvM5GXSAWSiAt6XS1pLKO6OaCLdeExc27AJq8ULm
 NpwrDk9HWdzwmn/74Di6DZBn39QwrIsEXgGjt3tnUWg4mG6hzDiIftlyE0+SEYIqUSM9vi
 dQLE99jJoca0tq2Vhw54scB4eZF1Tbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-yhWmYdjLN7uqIJeAEeJiLg-1; Tue, 11 Aug 2020 05:55:04 -0400
X-MC-Unique: yhWmYdjLN7uqIJeAEeJiLg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5C831940920;
 Tue, 11 Aug 2020 09:55:02 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-152.ams2.redhat.com
 [10.36.113.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD2751A4D9;
 Tue, 11 Aug 2020 09:55:01 +0000 (UTC)
Subject: Re: [PULL 0/2] Block patches for 5.1.0-rc4
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200811093505.972894-1-mreitz@redhat.com>
 <CAFEAcA_v=pTcao6-42bQP7yhVq1Zinjk-bbE71Bksu0=LaON0A@mail.gmail.com>
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
Message-ID: <615bc8ec-d686-cdd7-88aa-8023c26d6c69@redhat.com>
Date: Tue, 11 Aug 2020 11:54:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_v=pTcao6-42bQP7yhVq1Zinjk-bbE71Bksu0=LaON0A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YOFtc6J9iOIPwCfQbA7qUy8wac6UIV36o"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 04:41:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
--YOFtc6J9iOIPwCfQbA7qUy8wac6UIV36o
Content-Type: multipart/mixed; boundary="hKxdPI4gH9sZcifcDDp4mcOuwNXrq6R64"

--hKxdPI4gH9sZcifcDDp4mcOuwNXrq6R64
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.08.20 11:39, Peter Maydell wrote:
> On Tue, 11 Aug 2020 at 10:35, Max Reitz <mreitz@redhat.com> wrote:
>>
>> Hi,
>>
>> There is a bug in the backup job that breaks backups from images whose
>> size is not aligned to the job's cluster size (i.e., qemu crashes
>> because of a failed assertion).  If this bug makes it into the release,
>> it would be a regression from 5.0.
>>
>> On one hand, this is probably a rare configuration that should not
>> happen in practice.  On the other, it is a regression, and the fix
>> (patch 1) is simple.  So I think it would be good to have this in 5.1.
>=20
> I'm really reluctant to have to roll an rc4...

Well, that=E2=80=99s the information there is on this: Regression, simple f=
ix,
but little relevance in practice, and late to the party.
If, given this, you don=E2=80=99t want to roll an rc4, then that=E2=80=99s =
how it is.

Max


--hKxdPI4gH9sZcifcDDp4mcOuwNXrq6R64--

--YOFtc6J9iOIPwCfQbA7qUy8wac6UIV36o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8yavMACgkQ9AfbAGHV
z0AlxQf9GITV+f5TFh+3amWrg6k+CjHwKUitZ8QzSvL1H0l8EPpBb2WEa8KSvMpM
5GNN+a4XcMvp+vpjclDjNPCDhoKMEpjaP/1Isxe8G/PTx/+crd3VFwY+slXIl+UZ
UA7hAqUkoTtXInF/t27gsSJ0DFWo62p6CYsjk23Ne/TBF9SM0XxFxixWA/5MMXpY
GRiMMrehIBneySyfrytxUs2CdX5wzuk9cbR2CrUUt/UdJ8zpG5rqeAXEURyYk7f2
FPBLAGrPVP9B17B9B4J+1FXwmkQvCvljHVfl9+JbXcmWe+JnFOAuqul8Dh+DxB7+
1ZjUzdswU0TcIPiWAcOo/rQEybxg8g==
=f4t3
-----END PGP SIGNATURE-----

--YOFtc6J9iOIPwCfQbA7qUy8wac6UIV36o--



Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEEBC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:53:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1EC320838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2fmbsR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1EC320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j06sP-0007Fd-30
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 11:53:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j06qe-0004u3-Nc
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:51:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j06qd-000741-4q
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:51:20 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40832
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j06qd-00072q-0d
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581094276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4B7LrMvy7n44m80MfRwSCizcOiT66wbCkqjBucqWc0A=;
 b=h2fmbsR82wMQgW3L91twEYOjdMBQ15JsAoe2s+7YaPJV78ByVvciEV6VRRIIDX9Wp4QvHk
 Q412It1Yg8LXxcF7Rqmhu5xwFQ1rUKXRnqSaQBuQZHS6tuJgLC7M6SNaAb5V2W2lnlGgJz
 PtkTfW+MCdTeT+txh8dOCItRhe7uKvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-tzJrbG8lOUK_PvfAeWAI6w-1; Fri, 07 Feb 2020 11:51:11 -0500
X-MC-Unique: tzJrbG8lOUK_PvfAeWAI6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B508107B7D4;
 Fri,  7 Feb 2020 16:51:10 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B86635C21A;
 Fri,  7 Feb 2020 16:51:07 +0000 (UTC)
Date: Fri, 7 Feb 2020 11:51:06 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PULL v2 00/46] Python queue 2020-02-07
Message-ID: <20200207165106.GH412524@habkost.net>
References: <20200207151113.29349-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200207151113.29349-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Cleber Rosa <crosa@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2020 at 04:11:12PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Hi Peter,
>=20
> I prepared this series on behalf of Eduardo and
> Cleber.
>=20
> Eduardo already ack'ed yesterday version (2020-02-06) cover:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg677636.html

Acked-by: Eduardo Habkost <ehabkost@redhat.com>


>=20
> Since 2020-02-06 (v1):
> - rebased to cover new iotests #283 (merged yesterday).
>=20
> Regards,
>=20
> Phil.
>=20
> The following changes since commit 863d2ed5823f90c42dcd481687cc99cbc9c4a1=
7c:
>=20
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-02-=
06' into staging (2020-02-06 16:22:05 +0000)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.com/philmd/qemu.git tags/python-next-20200207
>=20
> for you to fetch changes up to 66e7dde18cc4085ca47124be4ca08fa8e6bcdd3a:
>=20
>   .readthedocs.yml: specify some minimum python requirements (2020-02-07 =
15:15:16 +0100)
>=20

--=20
Eduardo

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEWjIv1avE09usz9GqKAeTb5hNxaYFAl49lXcACgkQKAeTb5hN
xaZsHA/7Bb205h5DQB7cwiFZQxuqC8RO4hGuwXKIaoVifqRHfa/UDYb9qRy0gXQM
p0ov1oYAElYHdF8Z1RnF7PBIbu5I6MQhxxm5sCpkPcHe2JtS35gFq8G/oil2xnYP
EfWjqsdsCRwt93+YzTviwQ6+wgwIpCr+cxJ/s3YmuKpUx04Kqneq+UDYUxYDMFh6
lWroM1CKgkF3IBJWGoidwZPBI7y5Sq/zX16akmTEaLgI+xmrA+rf3SQd26XRhyE+
aNSdfy1TOKycxzZOmBx0Mr0W768os6C/crmoi+tkbaeGRX/U3zgopYX7oGGnymNJ
j9nfwtR1UY3PTVxpv5vArFrDAT4xymo0Np84pOKF6IT8OSxe7BkVxgPY4lOg32PO
wNYNCDEi1Fb76N/+MuTMXFcI3PS4fMDctxbAeO7wMIDjeuKuJljrVjrp9cB8EPUH
Rtlb0I8Tad4aTweJYT8cA8z5zUlrLkUDoZbT7xoEuGC1cKTmpwEniAFNdvO+jh7u
n8XAsdpRmBBmTXjkjQ4k56EJi5+MtbOt4a6i6Z6zDdwyMEzQ70OkbCZTg3nXZOTw
1g/DY4c/LGgnLfK7wR1oxwAD8fVtKgPCGKBZWmspgr/3qrlGaifd+4tE66jqhOtz
M1pbgwyiSLesDFZY4Bl/HXWV33VCAuGlp7fmgsrhBYEis0oH2xM=
=fKP6
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--



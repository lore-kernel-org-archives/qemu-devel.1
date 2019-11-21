Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B3FC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:09:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A1BD20721
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WF5FN7IG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1BD20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXkLD-0000LC-BD
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 06:09:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iXkK7-0007rK-3Z
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iXkK5-0002Ob-5p
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:08:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41797
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iXkK4-0002O9-Nh
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574334507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RhjxBMpSXS2HrqnBQ/CmPaJrtVXXxm2Dj8wYCBff9fE=;
 b=WF5FN7IG4io0jK6sCFlr7Ez5oALDKE5/EP0nZ01zOhlkzOLQp8bkn4v3Tx20LajClgWvF4
 Zxs4oJNgB8zPghvdoAiJbAGWUh+ycDO19DB/QqjCuKPs0lD3NWCLu63SDrEd3UsFRgo7Ym
 iLw0v4/YWGarfSDg73FVNTYVsIR9RAQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-s0lAagw9M12c9xgQoIH3pA-1; Thu, 21 Nov 2019 06:08:20 -0500
X-MC-Unique: s0lAagw9M12c9xgQoIH3pA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25F8D8E4385;
 Thu, 21 Nov 2019 11:08:19 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-225.ams2.redhat.com [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3F9760C23;
 Thu, 21 Nov 2019 11:08:17 +0000 (UTC)
Date: Thu, 21 Nov 2019 12:08:16 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH 00/18] Add qemu-storage-daemon
Message-ID: <20191121110816.GB6007@linux.fritz.box>
References: <20191017130204.16131-1-kwolf@redhat.com>
 <8a9a5eae-d388-867b-f4a1-080e876389b3@redhat.com>
 <20191106145800.GC7548@dhcp-200-226.str.redhat.com>
 <20191121103238.GF439743@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191121103238.GF439743@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 21.11.2019 um 11:32 hat Stefan Hajnoczi geschrieben:
> On Wed, Nov 06, 2019 at 03:58:00PM +0100, Kevin Wolf wrote:
> > Am 06.11.2019 um 15:37 hat Max Reitz geschrieben:
> > > On 17.10.19 15:01, Kevin Wolf wrote:
> > > The only thing I don=E2=80=99t like is the name, but that=E2=80=99s w=
hat <Tab> is for.
> > > :-)
> >=20
> > I'm open for suggestions, but I thought 'qsd' was a bit too terse. :-)
> >=20
> > (Actually, maybe we could even pick something that doesn't mention
> > storage or block? After all, it can do all kinds of QEMU backends in
> > theory. Not sure if there's any standalone use for them, but who
> > knows...)
>=20
> It's likely that non-storage use cases will want to a daemon too.  Maybe
> just qemu-daemon?

Do you have specific use cases in mind? Most backends seem rather
useless without a device to attach them to. In older QEMU versions,
maybe you could put multiple network backends into a common vlan to
forward between them, but even that vlan concept doesn't exist any more.

Kevin

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJd1nAgAAoJEH8JsnLIjy/WwPwQAK08vhvGyjC7Y6qS2Q7e5J8i
iEL2m66BHfIkPunBOr+kjD7M96tTCfhWb8a5RM1ek9onfDTQdj1LZ6d8O4HndHpQ
wukWMM5ibCJJ/ii4+boH/UE3cQY3FQ9+ZrDJ4sZkxfpZ0fBWZUrbBUHDbb0UEDUS
JwyaJil0GZtc7wLzSdUII0zrtnmlIzAhVDRx6YhGkFS2kRVHGdrIsWbzYI6/OmIp
RguEqxvr2ONSgWE6m5uQ8C4L3pkM0Dt8+QcyGkYq744xcy2Mqhi5sZhrMjYWEviJ
Wuy13BY+ZjnAWQKH3UMyoTJ2RDi6DzqoNZxQ6VgiBb1gIDIkj2v4Bsw+ICTwRfEP
Y9y2YZp1EOocnOcL2sCtlex/m+K92ms1pkOL5qiTj2dzU5JkrP9velOogEjiHAK9
hYvw558xnuiR/giPF5OG38Y/mQtureG4YEprmSyGdi2fGwLOhWjZl6KCVvbajsN6
+zWMDxch+Epwm1F7N3JtOzaOLsu6MYfZbCoCKUGnOZTvJS9vetP/Ua+tPXZ2o+NQ
ZHpmWb6fRVDvqmKALPUrWiSgjGhSyfiqxrWj4eiy/jweehSXND6b4GtR+qwRmGPu
akzxqMgWxe4LvH3fFkxzNhDI4cy5okKNUr9vEYw5wZUjKdhrHrYWKNGf+f+PbhVF
+V2qXc449uNqXBfO6NNq
=c6+M
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--



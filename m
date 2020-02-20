Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5516C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 12:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A118524656
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 12:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIBgoABl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A118524656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4kwu-0004wy-OP
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 07:29:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j4kwF-0004Qi-8b
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 07:28:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j4kwD-0008Ud-U9
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 07:28:18 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60310
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j4kwD-0008Tq-QY
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 07:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582201696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qG64DzHeL8nvwsGFYxYnFkb6X+AeUAkN+CWlSum7oXM=;
 b=aIBgoABlaRZwsbkJdFL4FDa2VZQuvkBSai2SFFYPIO+wyvEiNorN2BnA4/dNTO/DNE8Osy
 3WPFa/QRZ7m+GJXB1UCVBGdoOb9SwqdIJ+iCZBxUWLW41xnb2k++TisaWgqbyomT2mxY0p
 HajQnceL7a623denIxSsu3TQhuzF8HM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-4wLnM0GlMyWVV_Nh3j2Ynw-1; Thu, 20 Feb 2020 07:28:11 -0500
X-MC-Unique: 4wLnM0GlMyWVV_Nh3j2Ynw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E08AEDB2E;
 Thu, 20 Feb 2020 12:28:09 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-221.ams2.redhat.com [10.36.117.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B671860BE1;
 Thu, 20 Feb 2020 12:28:07 +0000 (UTC)
Date: Thu, 20 Feb 2020 13:28:06 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v3 0/3] Dump QCOW2 metadata
Message-ID: <20200220122806.GC5932@linux.fritz.box>
References: <1578990137-308222-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <fb4eb1a7-25f7-86ce-4c27-06bca430e97a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fb4eb1a7-25f7-86ce-4c27-06bca430e97a@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: vsementsov@virtuozzo.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 armbru@redhat.com, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 20.02.2020 um 12:58 hat Max Reitz geschrieben:
> On 14.01.20 09:22, Andrey Shinkevich wrote:
> > The information about QCOW2 metadata allocations in an image ELF-file i=
s
> > helpful for finding issues with the image data integrity.
>=20
> Sorry that I=E2=80=99m replying only so late =E2=80=93 but I don=E2=80=99=
t know why we need this
> in qemu, and this cover letter doesn=E2=80=99t provide a justification.  =
I mean,
> it isn=E2=80=99t too complex (from the diffstat), but wouldn=E2=80=99t it=
 be better to
> just have a script for this?

Specifically, we could extend tests/qemu-iotests/qcow2.py. This seems to
be debugging output that would be in line with what the script is
already used for.

Kevin

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJeTntWAAoJEH8JsnLIjy/WfR4P/Rqo+ieb47v4KUq+N5EP+SqQ
PzvqnsZFTfSm+ZWuG0Olip8eIKyXCJsQhhLa+/CI2mc/9Q6On+hVhogC8QbWy+Ac
BjAZMThhDhw83jCp7qZli6IrnHPnjrGAZO9mryJcRy/Pr1PFaCyQYLGNubPD+nYo
oXxORzIKVMJRMxzZ2y5a0AgYiPXuQoMPsijZOsoZYVp6bPeNCrTYz7pfpYKwTBge
aAc/2V9EPq8MY0MWAgvSBGnz77+egVAzzAmoiU3FzleIL/dUqWdSUaSYR9aNySeB
3Lz9K0BTmvbi6U1ZrgWbzI0vGS/+5JeHMu5jNXj9Xue5BjMMsvJm65h3uAgk9O42
fshQHL86IO+bgPdeuRPmcfFzkKPSpnncrlkph+WlOgljYNziYMPDUwLvOFWSzPgN
izyVHVPOEiF9zBtFV6bheKMm4z4clUWfYsNmughr3zyUC5Yp8e3EGR6GTXE0+eXZ
pNUdEJ+9EiZpghI8lUpfIgzwqSoxOMlBffz9dF7WPRnwnJU5t1UHrUoEV9HSDgal
ervKyu4PGjXaMmnDC1vl+o6KxWRqlg/rvuuZ/+V1d9Cec2urLNV4xiMzi44Ar0Eq
ruq2Pr1izXa8tgicGAJe6hwIvfeoII8Tn7ap97uOJPFa4iTaVri+oCFPELpOp+Qw
mSNf8MeKUcShMWVCM+5q
=ceWd
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--



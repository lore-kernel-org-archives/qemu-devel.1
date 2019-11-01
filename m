Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C377DCA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 10:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C6322086D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 10:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VN1k02GS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6322086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQTvc-0007xZ-Nu
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 06:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iQTut-0007T6-Im
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iQTur-0004uC-BY
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:12:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42162
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1iQTur-0004s6-3h
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572603144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IkakBsW8tm/X89mYA0gIski7JKtq8Um8PmTB/JGyyP0=;
 b=VN1k02GSbxF6yqvRa5qSDbvSSIvYdaIuFD3Je9fibNareOPZjsMptIHr8hLJ6zCzq2Pc92
 O1JeB3sWWjXTz/eOVZ8OeuGM6/qLnyZO11iEDQxRHSolPmN9pS4Zk9yxnmccULqlB+vMQ7
 HFkYRgPz9VdIyLND4m7R6LPMXl3zwIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-DxsQHR_tNs6lOc4rM0YBZQ-1; Fri, 01 Nov 2019 06:12:21 -0400
X-MC-Unique: DxsQHR_tNs6lOc4rM0YBZQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 308D9800D49;
 Fri,  1 Nov 2019 10:12:20 +0000 (UTC)
Received: from andariel.pipo.sk (unknown [10.40.205.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3B2860870;
 Fri,  1 Nov 2019 10:12:01 +0000 (UTC)
Date: Fri, 1 Nov 2019 11:11:58 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [libvirt] [PULL 1/9] IDE: deprecate ide-drive
Message-ID: <20191101101158.GA2875@andariel.pipo.sk>
References: <20191031105904.12194-1-jsnow@redhat.com>
 <20191031105904.12194-2-jsnow@redhat.com>
 <c688f160-e10e-52d1-5a54-881dd86987d4@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c688f160-e10e-52d1-5a54-881dd86987d4@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com,
 Laszlo Ersek <lersek@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2019 at 23:02:45 +0100, Paolo Bonzini wrote:
> On 31/10/19 11:58, John Snow wrote:
> > It's an old compatibility shim that just delegates to ide-cd or ide-hd.
> > I'd like to refactor these some day, and getting rid of the super-objec=
t
> > will make that easier.
> >=20
> > Either way, we don't need this.
>=20
> Good idea.  I will prepare a similar patch for scsi-disk, even though
> technically we're already in soft freeze; it makes no sense to deprecate
> only one of the two.

I checked in libvirt and you are welcome to do so since we no longer use
it similarly to ide-disk.


--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAl28BOkACgkQHGwCByjY
1Goiwg/9GFSNQu9ok2VqiGeRc9BCRBSqutvqFvJ3RzEvNUIcr7PsuvgiwbrrA7x6
H+D1Dhog272c10vNdOg+uOdcHBKpYopmWBwy/uBQ7sF/MuQjGGCF/wOY4sEiNp0f
Vhb0ft/qNmCdIfZR5pG6KbelUGhEM5HW4ByzQjKhmxXOPemGA59D0N5NxDg/t6Ob
1zy1SfHgMUarBolK+QBMcsUrZuS3QIQ2lTBznlE+7Il+xzSIsDMnZNymSW4malue
FpsJVBTWg0u50/XyYjX9WxLryF0wftFb9YQuUJCZA60wfRjBCodK8tdeAto1shLN
XcZB0SvkhSqk62f+wOlqeDGGbq8Q30yfV5LRbq8NI9RxYZi2apYhm3c46oRlsXN0
ZmUiRmHO24jUmqIKJSXJkksi8zsg8irQfM0adP900/7vH98gWpAjp9bPWCszVtUL
tW2kyo0VWUA+81nnekx6epqTLHUKajyfTms6+Yfwp+Vja43ZSUi2/B6W413dXHGT
3r4qICTmpPQ8aE2hFv8OqZLfx2mxYq4axT9RKo8MufVm0M9GkOaT9OAFCCidNwsK
v8KlZ/0TpaNvBwlkc0aLrXlsYC75e2qNUIYVBvQTZysoZ8fG1ZIjnhIniaXy/IwJ
PKPeWK+yYkpGqi1Rpc2jHkd9+QzmxedVFAzC7gDcPIawOAuqZJY=
=Kirs
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--



Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156C8C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 23:26:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 508402072D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 23:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbrAY2F3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508402072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSq9m-0001GB-21
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 19:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kSq8a-0000id-P0
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 19:24:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kSq8X-0008Bz-TI
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 19:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602717887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UPNpdCyuBDgLyzGGvzszCj/88eVghs+UychuaVpG3ZE=;
 b=QbrAY2F3xNK1o+Bcz+Y/MoSR93OyLALjHGRKRbUeKRLXpoKFtuXPi80Fggcg0rc/KoCWzw
 3te7TOY86ZzDW7tHbrtSsYSDz471L/L3PJIk3UCnYDP81xUtXfFFYu1g//4yMYqjS4yGbh
 SIjgukHkz5QWkJhu3d8H40hoCMyeBAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-x99NccvjMjeHODDQe-YL4w-1; Wed, 14 Oct 2020 19:24:41 -0400
X-MC-Unique: x99NccvjMjeHODDQe-YL4w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F031107AD65;
 Wed, 14 Oct 2020 23:24:40 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B09DF55798;
 Wed, 14 Oct 2020 23:24:32 +0000 (UTC)
Date: Wed, 14 Oct 2020 19:24:30 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 4/4] Jobs based on custom runners: add job definitions
 for QEMU's machines
Message-ID: <20201014232430.GB1203215@localhost.localdomain>
References: <20201014052140.1146924-1-crosa@redhat.com>
 <20201014052140.1146924-5-crosa@redhat.com>
 <20201014174655.GW115189@redhat.com>
 <20201014211356.GA1199212@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201014211356.GA1199212@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>, Willian Rampazzo <wrampazz@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2020 at 05:14:01PM -0400, Cleber Rosa wrote:
> On Wed, Oct 14, 2020 at 06:46:55PM +0100, Daniel P. Berrang=E9 wrote:
> >=20
> > This bug links to
> >=20
> >   https://bugs.launchpad.net/ubuntu/+source/libssh/+bug/1847514
> >=20
> > which is marked as fixed. So I'm thinking we can drop the --disable-lib=
ssh
> > arg from all these jobs
> >
>=20
> OK, I'll double check that and, if the fix is comfirmed beyond the bug
> tracker, I'll update it.
>=20

I was still able to reproduce the build failure with the latest packages.

The last update on the bug, is very misleading, but there's a hint of
its outcome:

---
Martin Wimpress (flexiondotorg) on 2019-12-17
tags:=09added: rls-bb-notfixing
tags:=09removed: bionic
no longer affects:=09libssh (Ubuntu Bionic)
---

So, *notfixing* means it no longer affects that package on that
distro? Right...

Anyway, keeping this AS IS.

Regards,
- Cleber.

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+HiKwACgkQZX6NM6Xy
CfNWCg/+N4LbLYl24Zq/49hFhAYNPf3KiM7FXFmlpuaNcSqCeO5K2wwd+WT8p+rs
BGw15IfQA2Akhgdr8dfD31Rl48pFIbkXPgYtGdxDnAe0fa9TprbuzLwsXByLTDhH
Sk+TiBVCtWhr46r8SAbSKanMUSGpGy3jEnlf/ly6dgydMlsvaDUjsrSyWqz8bLh/
BGkQtUUVPXj0UhfV/V/1C7ryjYGIwfGWw85rUqczABfoPMhUBm5s1tRRSrYSeWPM
y/HJTC/ZLax9atGN2jnU+zBaMXRokjuHzCEjUSvfInx8RbE9QrzTLfAMScN/6Oos
P4MX4RIDyxLTaaDpPDrwN/7FthamrBDRAWB0ZZ2CqqUFHjj/ImkYQgl0Gty1JLdO
HfteQO8lvlndRRhXgW+2EVt7yruXGnbGQD9tVa5mKJwsl5+p5S/nosPU0/6zAUlg
LOGEeFZIyNuQWnm5RmOpLHNLmdtMbf85y5XcNJUrP+nAdrbhrYOQmMqkZYYgCeXX
StL6AMIvD3wiI4okN8b09StFTDwQdD+30fzVxmbjgSVRjcQi7Jqoxy8w/L7KqTzJ
ymK7tSMziMffr64XpMgljaXTWRK91c5z6hBFqef9JiL/9+BTTRKoEz8vZ9Wj54Z3
qmvY3MBPz95Ki49JckGR8UjJ6mt85Jis5erTWNfCES79Z3m0i40=
=wxPS
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--



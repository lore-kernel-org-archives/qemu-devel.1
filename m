Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8E9C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 09:54:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04DC021479
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 09:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04DC021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvf7Z-0005vw-8m
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 05:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54683)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hvf6x-0004kR-SR
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hvf6x-0006BF-3r
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:53:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58148)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hvf6w-0006Am-Ug
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:53:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8518F76540;
 Thu,  8 Aug 2019 09:53:29 +0000 (UTC)
Received: from localhost (ovpn-116-70.ams2.redhat.com [10.36.116.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CC245D772;
 Thu,  8 Aug 2019 09:53:26 +0000 (UTC)
Date: Thu, 8 Aug 2019 10:53:25 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: piaojun <piaojun@huawei.com>
Message-ID: <20190808095325.GB1999@stefanha-x1.localdomain>
References: <20190801165409.20121-1-stefanha@redhat.com>
 <20190807180355.GA22758@stefanha-x1.localdomain>
 <5D4BD8D8.5080402@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
In-Reply-To: <5D4BD8D8.5080402@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 08 Aug 2019 09:53:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Virtio-fs] [PATCH 0/4] virtiofsd: multithreading
 preparation part 3
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2019 at 04:10:00PM +0800, piaojun wrote:
> From my test, your patch set of multithreading improves iops greatly as
> below:

Thank you for sharing your results!

Stefan

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1L8RUACgkQnKSrs4Gr
c8g7ewf9HPRIXe9aG8uSZNgM5swW99DJ8NhRw8Fj3qLSh79jEOm3SwOjxMIjPTNe
3rEglrOxYJ+k2LgTSQTHs1qAajmZhUC+MrfFCo79o5eacTY9/TiHTAy9bzOuCVYh
WRcE/T9WL2GzK3O/lUYmwVygkrZDHffX4RJ+OcNKQED/yLspyIdgxVmSpXTpu9iC
NhgaSPkh9knjQ5eNEBo356jW79KDoHI2q+/PGNVJCTCOBYAthKDAUL2lAu0xNNw5
1ne2VlQ/hhCbs6QF3Y9zYJvohzAGs5WD7HSGfKsTQyHmsg7X79+gtGcD0c0FNKDQ
tMmmoLYoEh+2Vodv1RG0r6ewmRiT5A==
=SSz9
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--


Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96CAC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 06:18:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F0182084D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 06:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0182084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHMLP-0006Tv-M7
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 02:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iHMKm-000642-4K
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 02:17:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iHMKk-0005ll-EZ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 02:17:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50428)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iHMKk-0005lC-9X
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 02:17:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7CA2446288;
 Mon,  7 Oct 2019 06:17:24 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72C0A600C1;
 Mon,  7 Oct 2019 06:17:24 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 4A9B81808876;
 Mon,  7 Oct 2019 06:17:24 +0000 (UTC)
Date: Mon, 7 Oct 2019 02:17:23 -0400 (EDT)
From: Thomas Huth <thuth@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <1861880686.5726737.1570429043380.JavaMail.zimbra@redhat.com>
In-Reply-To: <1932cc2e-830c-e542-817d-a6e5ef750c6c@redhat.com>
References: <20191003225437.16651-1-philmd@redhat.com>
 <20191003225437.16651-8-philmd@redhat.com>
 <1932cc2e-830c-e542-817d-a6e5ef750c6c@redhat.com>
Subject: Re: [PATCH 7/7] tests/fw_cfg: Run the tests on big-endian targets
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [84.136.96.125, 10.4.196.12, 10.5.101.130, 10.4.195.9]
Thread-Topic: tests/fw_cfg: Run the tests on big-endian targets
Thread-Index: wBjES5YPxxWuPQ+aV8Th1WyynTv5aA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 07 Oct 2019 06:17:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

----- Original Message -----
> Sent: Friday, October 4, 2019 10:05:09 AM
> On 04/10/2019 00:54, Philippe Mathieu-Daud=C3=A9 wrote:
[...]
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index 3543451ed3..322bdb36ff 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -242,6 +242,7 @@ check-qtest-ppc64-$(CONFIG_VGA) +=3D
> > tests/display-vga-test$(EXESUF)
> >  check-qtest-ppc64-y +=3D tests/numa-test$(EXESUF)
> >  check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) +=3D tests/ivshmem-test$(EX=
ESUF)
> >  check-qtest-ppc64-y +=3D tests/cpu-plug-test$(EXESUF)
> > +check-qtest-ppc64-y +=3D tests/fw_cfg-test$(EXESUF)
>=20
> Perhaps only a detail, but ppc64 (pseries) doesn't use fw_cfg, but ppc
> (mac99, g3beige and prep) does, so perhaps you should rather add the
> test to check-qtest-ppc-y (and it will be inherited by ppc64)?

Yes, this should go into check-qtest-ppc-y instead of check-qtest-ppc64-y.

 Thanks,
  Thomas


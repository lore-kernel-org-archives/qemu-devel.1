Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0218C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D3C20675
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MhKLEUgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D3C20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icuL9-0003WP-Bu
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 11:50:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <abologna@redhat.com>) id 1icuJQ-0002dE-9P
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:49:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <abologna@redhat.com>) id 1icuJO-0002b0-7g
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:49:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40657
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <abologna@redhat.com>) id 1icuJM-0002YT-7O
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575564541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lNOPQM2t5/Ier7GPy2lCVOB1KYRwjiNgwvFpHh0aOtE=;
 b=MhKLEUgA8mWLINNSTNTPtnOPzVBkohzZnT3RK2cmSptZURP5wgdpNPanRpmfNf99ZjkNzX
 j2WxI07jGeJQftuWqQXlAmK4/NtTC4oKjnH1YBJpLs1EhSLzPe32dQ1TSccdCG9XDTqns8
 1+/0ruISgfYhXTCqIktM66y0PTqaKps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-KhvT7iLRPt-1Ar133UZONg-1; Thu, 05 Dec 2019 11:47:33 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01E051084E25;
 Thu,  5 Dec 2019 16:47:32 +0000 (UTC)
Received: from ovpn-205-65.brq.redhat.com (ovpn-205-65.brq.redhat.com
 [10.40.205.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CDF45C1BB;
 Thu,  5 Dec 2019 16:47:27 +0000 (UTC)
Message-ID: <ea6fdfcaef35ed6571c4234b9400a75b429c72ac.camel@redhat.com>
Subject: Re: [PATCH-for-5.0] roms/edk2-funcs.sh: Use available GCC for
 ARM/Aarch64 targets
From: Andrea Bolognani <abologna@redhat.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Laszlo
 Ersek <lersek@redhat.com>
Date: Thu, 05 Dec 2019 17:47:24 +0100
In-Reply-To: <90b6b303-2cb7-aeea-8f10-8520de2511c6@redhat.com>
References: <20191204221229.30612-1-philmd@redhat.com>
 <ecbb6c69-1fc1-a730-db9f-656b0a82c3fd@redhat.com>
 <90b6b303-2cb7-aeea-8f10-8520de2511c6@redhat.com>
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: KhvT7iLRPt-1Ar133UZONg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-12-05 at 17:27 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> On 12/5/19 5:13 PM, Laszlo Ersek wrote:
> > If that rules out CentOS 7 as a QEMU project build / CI platform for th=
e
> > bundled ArmVirtQemu binaries, then we need a more recent platform
> > (perhaps CentOS 8, not sure).
>=20
> Unfortunately CentOS 8 is not available as a Docker image, which is a=20
> convenient way to build EDK2 in a CI.

Uh?

  https://hub.docker.com/_/centos

seems to disagree with you. Is the 'centos:8' image not suitable
for some non-obvious reason?

--=20
Andrea Bolognani / Red Hat / Virtualization



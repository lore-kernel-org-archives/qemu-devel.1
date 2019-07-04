Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A69C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 13:57:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F2702085A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 13:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2702085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj2Eg-0002z9-Q7
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 09:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53804)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hj2DW-0002Hu-LA
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hj2DV-0004xf-PO
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:56:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55330)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hj2DV-0004sb-KC
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:56:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A853C30ADC79;
 Thu,  4 Jul 2019 13:55:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-222.ams2.redhat.com
 [10.36.116.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74A24968C2;
 Thu,  4 Jul 2019 13:55:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AE26611AA3; Thu,  4 Jul 2019 15:55:50 +0200 (CEST)
Date: Thu, 4 Jul 2019 15:55:50 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190704135550.x75fdmzezl3be5xk@sirius.home.kraxel.org>
References: <41536801-f8ac-b3c6-a74a-4a7ead43695f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <41536801-f8ac-b3c6-a74a-4a7ead43695f@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 04 Jul 2019 13:55:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] hw/display/vga: Why architecture specific code?
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 04, 2019 at 03:27:25PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Hi Gerd,
>=20
> I'm looking at:
>=20
> static const MemoryRegionPortio vbe_portio_list[] =3D {
>     { 0, 1, 2, .read =3D vbe_ioport_read_index, .write =3D
> vbe_ioport_write_index },
> # ifdef TARGET_I386
>     { 1, 1, 2, .read =3D vbe_ioport_read_data, .write =3D
> vbe_ioport_write_data },
> # endif
>     { 2, 1, 2, .read =3D vbe_ioport_read_data, .write =3D
> vbe_ioport_write_data },
>     PORTIO_END_OF_LIST(),
> };

Unaligned 16bit ioport access works on x86 only.

cheers,
  Gerd



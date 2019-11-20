Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87666C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55090223D1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIOc1F59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55090223D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXMRQ-0007fH-0T
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 04:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1iXMPK-0005h8-Al
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:36:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1iXMPJ-00047L-9b
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:36:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52095
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1iXMPJ-000470-66
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574242576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UrHd7RqNrB+1bDkaKW8M5t+cGM1h//lO5MzDrsHEsOA=;
 b=IIOc1F594H6TRf7V1/C6x8Uw3KfpnekbVXNzV3SI1czQ7X7vvFCmwf6zbveLMAhpf+wzKW
 X89TUHDNLoz6c+Y2qX8dZoI8aTELcgPtInhdRxt/vNLD0uL9gG0s7/ObzM690VHrnGF9uM
 XkR8BOkHlDhqx8oagWCeaCeqndpjuZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-XqDW1PHrPquzjStFyHcJ6w-1; Wed, 20 Nov 2019 04:35:06 -0500
X-MC-Unique: XqDW1PHrPquzjStFyHcJ6w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45FA9801E6A;
 Wed, 20 Nov 2019 09:35:05 +0000 (UTC)
Received: from lpt (unknown [10.43.2.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 929C267E5C;
 Wed, 20 Nov 2019 09:34:54 +0000 (UTC)
Date: Wed, 20 Nov 2019 10:35:49 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [libvirt] [PATCH for-5.0 2/4] hw/usb: Remove the USB bluetooth
 dongle device
Message-ID: <20191120093549.GO3832@lpt>
References: <20191120091014.16883-1-thuth@redhat.com>
 <20191120091014.16883-3-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191120091014.16883-3-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BuBclajtnfx5hylj"
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
Cc: Peter Maydell <peter.maydell@linaro.org>, libvir-list@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--BuBclajtnfx5hylj
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2019 at 10:10:12AM +0100, Thomas Huth wrote:
>We are going to remove the bluetooth backend, so the USB bluetooth
>dongle can not work anymore. It's a completely optional device, no
>board depends on it, so let's simply remove it now.
>
>Signed-off-by: Thomas Huth <thuth@redhat.com>
>---
> hw/usb/Kconfig         |   5 -
> hw/usb/Makefile.objs   |   1 -
> hw/usb/dev-bluetooth.c | 581 -----------------------------------------
> qemu-doc.texi          |  15 --
> 4 files changed, 602 deletions(-)
> delete mode 100644 hw/usb/dev-bluetooth.c
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--BuBclajtnfx5hylj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl3VCO8ACgkQ+YPwO/Ma
t50gSwgAivAhVu/IeLutYVnPgIFVBRn+l0WLl8gsdTV6W+gJtW0J8T0lFzP29ekE
HfOXC7DI+RVi4YV/wX8RJSuBj/yfk50ce/cSrsSGuf0H3mRNDI0uI5eri9ByZ8Iz
MA/bapDxhQ0E1pDq1doDtdZU7xagW5W7S7vJqHYEl9YUx32m7QPJYEBiGU+lL2L3
d2UA/TovE3EbVJW8GTM1Jf0a1Cv+uqpodz2/OhUCe/wRJuJfePfDxtkZ9+p2z08u
m0WMIM8YeTXDru0wnogT5VtPVSiXtwnjnK2Wf3sJUSw0WfvtN/899jlz3FNsFKHe
bO9caxvQ54yycYGbLDLlv1hzbW6srw==
=OU4P
-----END PGP SIGNATURE-----

--BuBclajtnfx5hylj--



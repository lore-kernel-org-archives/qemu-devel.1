Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB3AC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABC8F223D1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRDSB6Na"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC8F223D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXMSy-0001dz-JB
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 04:40:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1iXMPg-00062w-2G
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:36:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1iXMPc-0004F4-Rq
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:36:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54431
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1iXMPa-0004Eg-NK
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574242594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cqOxygx0X6XnKw8PDZFbH4XlG3ohAm074QouO/3N3J8=;
 b=aRDSB6Nas12jImu1Rjud1umAg9CmyJuAJPns1nbmd2OsyNK36/tOHTmTtSURbVPeh7wc0F
 PXdT63yJSw+bElqwlJgsszN8cvKIiSiIzbtrwNj7seNpJIDZeHtT1K4a7BpjGC3u1Jgguj
 Noya2f48np61jNYlI/XNI8mj9xWg/Sk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-2iOl4u2XOOG6mxcmGoy7NA-1; Wed, 20 Nov 2019 04:35:27 -0500
X-MC-Unique: 2iOl4u2XOOG6mxcmGoy7NA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A48E2100550E;
 Wed, 20 Nov 2019 09:35:26 +0000 (UTC)
Received: from lpt (unknown [10.43.2.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9E0C66D4E;
 Wed, 20 Nov 2019 09:35:16 +0000 (UTC)
Date: Wed, 20 Nov 2019 10:36:11 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [libvirt] [PATCH for-5.0 3/4] Remove the core bluetooth code
Message-ID: <20191120093611.GP3832@lpt>
References: <20191120091014.16883-1-thuth@redhat.com>
 <20191120091014.16883-4-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191120091014.16883-4-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="A6Z7MKnLVMfR85kG"
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
Cc: Peter Maydell <peter.maydell@linaro.org>, libvir-list@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--A6Z7MKnLVMfR85kG
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2019 at 10:10:13AM +0100, Thomas Huth wrote:
>It's been deprecated since QEMU v3.1. We've explicitly asked in the
>deprecation message that people should speak up on qemu-devel in case
>they are still actively using the bluetooth part of QEMU, but nobody
>ever replied that they are really still using it.
>
>I've tried it on my own to use this bluetooth subsystem for one of my
>guests, but I was also not able to get it running anymore: When I was
>trying to pass-through a real bluetooth device, either the guest did
>not see the device at all, or the guest crashed.
>
>Even worse for the emulated device: When running
>
> qemu-system-x86_64 -bt device:keyboard
>
>QEMU crashes once you hit a key.
>
>So it seems like the bluetooth stack is not only neglected, it is
>completely bitrotten, as far as I can tell. The only attention that
>this code got during the past years were some CVEs that have been
>spotted there. So this code is a burden for the developers, without
>any real benefit anymore. Time to remove it.
>
>Signed-off-by: Thomas Huth <thuth@redhat.com>
>---
> Makefile.objs        |    2 -
> bt-host.c            |  198 ----
> bt-vhci.c            |  167 ----
> configure            |   31 -
> hw/Kconfig           |    1 -
> hw/Makefile.objs     |    1 -
> hw/bt/Kconfig        |    2 -
> hw/bt/Makefile.objs  |    3 -
> hw/bt/core.c         |  143 ---
> hw/bt/hci-csr.c      |  512 ----------
> hw/bt/hci.c          | 2263 ------------------------------------------
> hw/bt/hid.c          |  553 -----------
> hw/bt/l2cap.c        | 1367 -------------------------
> hw/bt/sdp.c          |  989 ------------------
> include/hw/bt.h      | 2177 ----------------------------------------
> include/sysemu/bt.h  |   20 -
> qemu-deprecated.texi |    7 -
> qemu-options.hx      |   79 --
> vl.c                 |  136 ---
> 19 files changed, 8651 deletions(-)

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--A6Z7MKnLVMfR85kG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl3VCQsACgkQ+YPwO/Ma
t509xwgAh4bM/I773MxOazWuQDIkUFm300owdx+O1ymFtgV/JQempqj6ODrRg+uc
rdwsQK9wmxkVe8V3pN0O55zW4686TcHq/b8ASSlBNA64kWZ3gQawzyeDwFdp9k7k
b7nPu3iqtv9DcVQteNwfcs1PEQ17qJ9KOp6j2eXik7aPFGHp5cDot7p68yR9imLm
1eeX9SaqdH0ZJlwwW+G0bzDStiVB0iMqyxpllkOWGQb+R6X4PXwsMDFl2nXH8qcq
gUbfn+sXtluMIXNAer/rXPvgAx0bz5DFjk6UIH117qb11Ii7LY9MQUVvPbT/tfpM
rUjMIVxyTFIo5G+p1ny9kcXbU0KjEg==
=8RCf
-----END PGP SIGNATURE-----

--A6Z7MKnLVMfR85kG--



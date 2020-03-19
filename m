Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9545C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7948A2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HI+2GN2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7948A2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEtMi-0002mk-IP
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 07:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jEtLv-0002MK-KP
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jEtLt-0006kq-VM
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:28:42 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:37922)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jEtLt-0006hy-RY
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584617320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AQ0dBvEC7x09HJTpK3HT9GXNWHXtXjsIyfPFLpkeFh0=;
 b=HI+2GN2GXJ8klNr9n5OPFI1UBp4Vnzeq2FbGHsCo7XtmDv/aL7vPdp3DgqVAqHybSFWPfF
 h0+OkZuA/hPRIPjvE38siddNZep8jNjwPLcGntPX997NiEexT2GYpJw6hPEk9a/4xG1ljv
 UjBIZqariGgGyqsKBQfJitHbxiPFHGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-XuXdCecoNOKmHC_Ns4kfBw-1; Thu, 19 Mar 2020 07:28:37 -0400
X-MC-Unique: XuXdCecoNOKmHC_Ns4kfBw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37957107ACC4;
 Thu, 19 Mar 2020 11:28:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBF475D9CD;
 Thu, 19 Mar 2020 11:28:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F2C7F3BD; Thu, 19 Mar 2020 12:28:29 +0100 (CET)
Date: Thu, 19 Mar 2020 12:28:29 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 00/13] microvm: add acpi support
Message-ID: <20200319112829.m4fls4ekqgj4ucia@sirius.home.kraxel.org>
References: <20200319080117.7725-1-kraxel@redhat.com>
 <2ed586e7-d7a1-77b2-ecc6-01b6fb38d72e@redhat.com>
 <20200319093342.m6fppq4y2qoqefpa@sirius.home.kraxel.org>
 <c93e28a0-80ec-a986-cb8f-426b84947844@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c93e28a0-80ec-a986-cb8f-426b84947844@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> The main reason for not having ACPI was the time that it took to start;

Yep, ACPI needs additional boot time.  Shouldn't be a big difference
though, microvm acpi only declares some devices and has small tables.
Also no acpi methods, so no interpreter work.  Maybe it is mostly the
additional time needed to log the ACPI stuff to the serial console
(didn't try yet to time boots with "quiet").

On the other hand you have effects like this:
Without acpi the kernel checks whenever hardware is present:

    # dmesg | grep i8042
    [    0.334403] i8042: PNP: No PS/2 controller found.
    [    0.334619] i8042: Probing ports directly.
    [    1.370573] i8042: No controller found

With acpi the kernel trusts the firmware and doesn't bother
probing directly:

    # dmesg | grep i8042
    [    0.345500] i8042: PNP: No PS/2 controller found.

cheers,
  Gerd



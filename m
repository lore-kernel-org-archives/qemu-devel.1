Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B025C43332
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 08:23:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6D8C20767
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 08:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwVUeAUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D8C20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFCwe-0002nT-Vs
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 04:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jFCvt-0002Mk-Vq
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 04:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jFCvt-0000k2-2V
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 04:23:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:24737)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jFCvs-0000iv-Ur
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 04:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584692588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sn4YRagkJ2GG8ttYZIf1bl6ToxivKp38w0mKxZlahqM=;
 b=iwVUeAUeFCeVCzxrMJPdfbWT3p0q2eVSQdZE5mFEWB9+US+st9D+hyavrUy+t8iQ0oFHWP
 LOtdOG7AvdEJYaNR9CVg9PUV4EKe1fzvkbJeFNyFopb2qlZb/rKv/K/xdl4E3BLqtURGmb
 fiSTy8hrnuQSwh2xegyHo191/skuL68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-xKI26m_dMwawXI_u6ktayQ-1; Fri, 20 Mar 2020 04:23:06 -0400
X-MC-Unique: xKI26m_dMwawXI_u6ktayQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 420961005510;
 Fri, 20 Mar 2020 08:23:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA73A91290;
 Fri, 20 Mar 2020 08:22:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F085F9DB3; Fri, 20 Mar 2020 09:22:58 +0100 (CET)
Date: Fri, 20 Mar 2020 09:22:58 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 03/13] microvm: add isa-acpi device
Message-ID: <20200320082258.fm4prxr6fac336ua@sirius.home.kraxel.org>
References: <20200319080117.7725-1-kraxel@redhat.com>
 <20200319080117.7725-4-kraxel@redhat.com>
 <20200319144218.5d2f8fd3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200319144218.5d2f8fd3@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 19, 2020 at 02:42:18PM +0100, Igor Mammedov wrote:
> On Thu, 19 Mar 2020 09:01:07 +0100
> Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> > Minimal ACPI device for PCI-less machines like microvm.
> it seems that x86 kernel is able to boot on hw-reduced acpi systems
> (but I haven't really tested any distro kernel, not sure how usable NEMU =
is)
>=20
> Maybe reusing hw/acpi/generic_event_device.c (which was borrowed
> for NEMU effort) would be better since guest won't have to initialize
> not necessary interfaces and QEMU could implement simpler hw impl
> compared to full ACPI with GPEs, SCIs & co.

I see the generic event device has support for powerdown request events,
good.  But I'm wondering how entering S5 state (aka poweroff) would
work then?

cheers,
  Gerd



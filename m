Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C143AC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 10:32:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 834D4206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 10:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUu6Gp8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834D4206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWHM5-0003iz-Iz
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 06:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jWHKi-0002xo-Om
 for qemu-devel@nongnu.org; Wed, 06 May 2020 06:31:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57592
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jWHKh-0001Ou-4U
 for qemu-devel@nongnu.org; Wed, 06 May 2020 06:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588761077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R9O5U0Jcu2u2nLNValNmnZt/gtvSgTiKFYtp960/NTE=;
 b=PUu6Gp8auOAJyi9nWYyJPzPJnqeaVTeRdiyVe3rA3md2LOeIGPWucFPPeJ4mkdU2yt7E7v
 +U4zJwhp/cg0DjPAOYI9cNjqRaxf9QcZzWWpkS31YkNL8RMTztwLb82S3Hlzu04bkzLHTZ
 MHyJisVIoFV93x0RlKnHR5Q2bBGXnWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-DMNFBdG5M3i2eg5-KBKJNA-1; Wed, 06 May 2020 06:31:14 -0400
X-MC-Unique: DMNFBdG5M3i2eg5-KBKJNA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22F0B45F;
 Wed,  6 May 2020 10:31:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33EE11001B07;
 Wed,  6 May 2020 10:31:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 39AA81747D; Wed,  6 May 2020 12:31:06 +0200 (CEST)
Date: Wed, 6 May 2020 12:31:06 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 08/13] acpi: generic event device for x86
Message-ID: <20200506103106.nih5mf5zpltv3fns@sirius.home.kraxel.org>
References: <20200505134305.22666-1-kraxel@redhat.com>
 <20200505134305.22666-9-kraxel@redhat.com>
 <20200505170316.7e72da4d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200505170316.7e72da4d@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 04:02:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 05, 2020 at 05:03:16PM +0200, Igor Mammedov wrote:
> On Tue,  5 May 2020 15:43:00 +0200
> Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> > Uses TYPE_ACPI_GED as QOM parent for code reuse.
> > Add registers for sleep states and reset.
> > Add powerdown notifier for power button events.
> registers aren't x86 specific per spec,
> can we put these registers into TYPE_ACPI_GED
> and enable the optionally like is done with memory hotplug registers
> in acpi_ged_initfn()

Sure, will do.

> > Set AcpiDeviceIfClass->madt_cpu.
> that's the only reason I could justify adding x86 specific flavour.

Also the powerdown notifier.  Seems the workflow is slightly different
on x86 (acpi device registers notifier) and arm (machine registers
notifier and calls acpidev->send_event).

take care,
  Gerd



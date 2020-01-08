Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116C6C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 08:04:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF18C206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 08:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jmlt5NvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF18C206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip6Km-0001Dt-Th
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 03:04:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1ip6K1-0000dQ-Fl
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 03:04:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1ip6Jz-0003kP-0g
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 03:04:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29054
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ip6Jy-0003il-TR
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 03:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578470645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XZ9iXYJA0PYaMZ0QPTy3Nc0f/jJKf9BwSWr5DgVl2wo=;
 b=Jmlt5NvDsmaOB2E8v5q2Z51I2COeITqwSjX5D+L0jHN2fptkpebPOewSrGtlBmqJMuhgSF
 qpaHT9sp6IaXXWsl8kYfM7ZMS8YwGFKe+djTcOmy+XUDgzwIA757N/S3+TW5CbI96xBbiO
 UKKr0pKLLs3ZAvhaCM/hElMw7V1a4TM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-vAe8sbjeOI-vpkI-U7ZK7Q-1; Wed, 08 Jan 2020 03:04:02 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0DDD1807481
 for <qemu-devel@nongnu.org>; Wed,  8 Jan 2020 08:04:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com
 [10.36.116.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE7CA60E1C;
 Wed,  8 Jan 2020 08:03:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CB9CB16E08; Wed,  8 Jan 2020 09:03:55 +0100 (CET)
Date: Wed, 8 Jan 2020 09:03:55 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 6/8] x86: move more x86-generic functions out of PC
 files
Message-ID: <20200108080355.l762jkzec57iecsv@sirius.home.kraxel.org>
References: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
 <1576171754-45138-7-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1576171754-45138-7-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: vAe8sbjeOI-vpkI-U7ZK7Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org, slp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 06:29:12PM +0100, Paolo Bonzini wrote:
> These are needed by microvm too, so move them outside of PC-specific file=
s.
> With this patch, microvm.c need not include pc.h anymore.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Current master does not work with libvirt ...

$ virsh start fedora-org-base
error: Failed to start domain fedora-org-base
error: internal error: Failed to probe QEMU binary with QMP: /home/kraxel/p=
rojects/qemu/target/i386/kvm.c:2176:kvm_arch_init: Object 0x5608f33be1f0 is=
 not an instance of type x86-machine

... and git bisect lands at this patch.

cheers,
  Gerd



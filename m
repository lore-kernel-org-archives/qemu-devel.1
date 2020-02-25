Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C06C35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 08:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF28721744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 08:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/L/Pa59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF28721744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6VVj-0008AO-V6
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 03:24:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j6VUy-0007J5-5t
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 03:23:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j6VUx-0006p8-Bd
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 03:23:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34921
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j6VUx-0006or-7e
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 03:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582619002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rFfHbhfDzeLCGd2rC37WNtSvNSRpQ3E/OB0ECbV1fqc=;
 b=d/L/Pa592hTuNX3OKLiw+wKwjsxO4ZwBq2q0i7+fHQPIk8/wSoRlWqBRcrGG7VsdqFxPu+
 WWIkRJsDf5FP/5PjSuxSvoqsyRbHRGq8d3JZC+HbSXW3AkVKftR0k/+aGGAw3+QmTtDVox
 4XwFYd8ynplZowBjlgoC2ujOhIheZ7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-6J9EK9MuNJm_Kz_56JgLuQ-1; Tue, 25 Feb 2020 03:23:20 -0500
X-MC-Unique: 6J9EK9MuNJm_Kz_56JgLuQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BBCC8017CC;
 Tue, 25 Feb 2020 08:23:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-87.ams2.redhat.com
 [10.36.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5442D9009D;
 Tue, 25 Feb 2020 08:23:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 559609DA4; Tue, 25 Feb 2020 09:23:15 +0100 (CET)
Date: Tue, 25 Feb 2020 09:23:15 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] qxl: drop shadow_rom
Message-ID: <20200225082315.xpxryeuxyehv7qhd@sirius.home.kraxel.org>
References: <20200225055920.17261-1-kraxel@redhat.com>
 <20200225055920.17261-3-kraxel@redhat.com>
 <3e1d3937-1f63-3e8a-4e20-532ae34a51ed@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3e1d3937-1f63-3e8a-4e20-532ae34a51ed@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: sstabellini@kernel.org, pmatouse@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, ppandit@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 25, 2020 at 08:39:12AM +0100, Paolo Bonzini wrote:
> On 25/02/20 06:59, Gerd Hoffmann wrote:
> > Now that the rom bar is mapped read-only and the guest can't change
> > things under our feet we don't need the shadow rom any more.
>=20
> Can't it do so when migrating from an older version?

Good point, and I think there is no easy way around it.
So drop 2/2 and merge 1/2 only I guess?

cheers,
  Gerd



Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FCDC55179
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C67E7221FA
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxWrUOuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67E7221FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kagaL-0003Rz-Ig
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 09:49:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kagUT-0007kB-SC
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:43:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36400)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kagUP-0001IM-MT
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604587428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sp2UqcGaK7QCnYU9Q9T9G+DuCqCtag4Fab3IQM54tr4=;
 b=TxWrUOuyJxgoG+ZGAYXoT/xvAWHOfoTR45Ns26AzC8OR7NKUlH5+TURK0UqXPc722bXniW
 /iSQx9qxFPTFmzYeSqiBXRg113uKDCErZ99JIyO3oU21Qybs9Exiv8nC3jzpMjmx+g8puV
 AC4Z2p3m0R9BeiZ1xo19zwCKzjOCcCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-eBBPzJqFMva0ahLLIC1N8A-1; Thu, 05 Nov 2020 09:43:47 -0500
X-MC-Unique: eBBPzJqFMva0ahLLIC1N8A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56C51807339;
 Thu,  5 Nov 2020 14:43:45 +0000 (UTC)
Received: from gondolin (ovpn-112-138.ams2.redhat.com [10.36.112.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1354C5D9D5;
 Thu,  5 Nov 2020 14:43:41 +0000 (UTC)
Date: Thu, 5 Nov 2020 15:43:39 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.2 v3 1/4] s390x: fix build for
 --without-default-devices
Message-ID: <20201105154339.6314b227.cohuck@redhat.com>
In-Reply-To: <20201105130113.4bacf2c0.cohuck@redhat.com>
References: <20201104115706.3101190-1-philmd@redhat.com>
 <20201104115706.3101190-2-philmd@redhat.com>
 <20201104182547.5ae54d3f.cohuck@redhat.com>
 <394ea3ee-fdef-e25b-4419-3b1bf51a48cc@redhat.com>
 <20201105130113.4bacf2c0.cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, Greg Kurz <groug@kaod.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Nov 2020 13:01:13 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, 5 Nov 2020 12:58:01 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
> > Hi Cornelia,
> >=20
> > On 11/4/20 6:25 PM, Cornelia Huck wrote: =20
> > > On Wed,  4 Nov 2020 12:57:03 +0100
> > > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> > >    =20
> > >> From: Cornelia Huck <cohuck@redhat.com>
> > >>
> > >> s390-pci-vfio.c calls into the vfio code, so we need it to be
> > >> built conditionally on vfio (which implies CONFIG_LINUX).
> > >>
> > >> Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > >> Fixes: cd7498d07fbb ("s390x/pci: Add routine to get the vfio dma ava=
ilable count")
> > >> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > >> Message-Id: <20201103123237.718242-1-cohuck@redhat.com>
> > >> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > >> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > >> Acked-by: Greg Kurz <groug@kaod.org>
> > >> Tested-by: Greg Kurz <groug@kaod.org>
> > >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > >> ---
> > >>  include/hw/s390x/s390-pci-vfio.h | 3 ++-
> > >>  hw/s390x/meson.build             | 2 +-
> > >>  2 files changed, 3 insertions(+), 2 deletions(-)   =20
> > >=20
> > > I think you're missing Matt's r-b?
> > >=20
> > > Do you plan to send this, or should I include it on my s390-fixes
> > > branch?   =20
> >=20
> > I plan to send a pull request with gitlab patches (or maybe
> > they will go via Alex's testing tree) but not soon. If you
> > are preparing s390-fixes patches, please go ahead taking this
> > one (I only included to have the series build succeed). =20
>=20
> Thanks, I plan to prepare a pull req this week, so I'll just go ahead
> and include it.

Queued to s390-fixes now (with Matt's r-b included).



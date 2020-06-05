Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76717C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46199208B6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvoyLSAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46199208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhDBh-00033o-EO
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 10:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jhDAl-0002QN-Is
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:18:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44340
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jhDAk-0007Fi-U1
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591366694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xtE8xC5ULETdc3BCEJwkWRw/hYF2JYwSR9w4Tbb07vA=;
 b=hvoyLSAIBkc6v7OlQ1kmgNEW5ghVvhUB2Vg00aMAFL2pl4XilTE428kQMD4FSFETzCqfxZ
 PHjXOtVUsZYz2mzBcfEXi7Lk5D8xoGbN6KEbZ8ZOM9Up9XIoHsjdt8P68JzjAPDt2qUkmI
 a4It8p2QSU9jBha374WQj4D6AmbCUPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-6t3sK9N2PHO4pJwEV6UT5w-1; Fri, 05 Jun 2020 10:18:10 -0400
X-MC-Unique: 6t3sK9N2PHO4pJwEV6UT5w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39B47A0C02;
 Fri,  5 Jun 2020 14:18:09 +0000 (UTC)
Received: from gondolin (ovpn-113-2.ams2.redhat.com [10.36.113.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44FB160C1C;
 Fri,  5 Jun 2020 14:18:04 +0000 (UTC)
Date: Fri, 5 Jun 2020 16:18:01 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 0/7] exec/cpu: Cleanups around "exec/hwaddr.h"
 (reserved to system-mode)
Message-ID: <20200605161801.4bba0d0e.cohuck@redhat.com>
In-Reply-To: <525ebf16-1265-e403-54b6-e1168d84e4f4@redhat.com>
References: <20200526172427.17460-1-f4bug@amsat.org>
 <525ebf16-1265-e403-54b6-e1168d84e4f4@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Roman Bolshakov <r.bolshakov@yadro.com>,
 qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 4 Jun 2020 20:11:38 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 26/05/20 19:24, Philippe Mathieu-Daud=C3=A9 wrote:
> > The 'hwaddr' type declared in "exec/hwaddr.h" is meant for
> > system-mode emulation only.
> > This series is a preparatory cleanup to allow later poisoning
> > it in user-mode code.
> >=20
> > Missing review: patche 7
> > - target/s390x: Restrict system-mode declarations
> >=20
> > Maybe PPC/S390X maintainers can take their patches and let
> > the rest to Paolo, or he can take all the series. They are
> > not dependents.
> >=20
> > Since v1:
> > - Do not poison hwaddr type
> > - Addressed Cornelia & David review comments
> > - Added R-b/A-b
> >=20
> > $ git backport-diff -u v1
> > Key:
> > [----] : patches are identical
> > [####] : number of functional differences between upstream/downstream p=
atch
> > [down] : patch is downstream-only
> > The flags [FC] indicate (F)unctional and (C)ontextual differences, resp=
ectively
> >=20
> > 001/7:[----] [--] 'sysemu/accel: Restrict machine methods to system-mod=
e'
> > 002/7:[----] [--] 'sysemu/tcg: Only declare tcg_allowed when TCG is ava=
ilable'
> > 003/7:[----] [--] 'sysemu/hvf: Only declare hvf_allowed when HVF is ava=
ilable'
> > 004/7:[----] [--] 'target/ppc: Restrict PPCVirtualHypervisorClass to sy=
stem-mode'
> > 005/7:[----] [--] 'target/s390x: Only compile decode_basedisp() on syst=
em-mode'
> > 006/7:[0002] [FC] 'target/s390x/helper: Clean ifdef'ry'
> > 007/7:[0005] [FC] 'target/s390x: Restrict system-mode declarations'
> >=20
> > Supersedes: <20200509130910.26335-1-f4bug@amsat.org>
> >=20
> > Philippe Mathieu-Daud=C3=A9 (7):
> >   sysemu/accel: Restrict machine methods to system-mode
> >   sysemu/tcg: Only declare tcg_allowed when TCG is available
> >   sysemu/hvf: Only declare hvf_allowed when HVF is available
> >   target/ppc: Restrict PPCVirtualHypervisorClass to system-mode
> >   target/s390x: Only compile decode_basedisp() on system-mode
> >   target/s390x/helper: Clean ifdef'ry
> >   target/s390x: Restrict system-mode declarations
> >=20
> >  include/sysemu/accel.h          |  2 ++
> >  include/sysemu/hvf.h            |  6 +++---
> >  include/sysemu/tcg.h            |  2 +-
> >  target/ppc/cpu.h                |  4 ++--
> >  target/ppc/kvm_ppc.h            | 22 +++++++++++-----------
> >  target/s390x/internal.h         | 16 +++++++++++-----
> >  target/ppc/translate_init.inc.c |  4 ++++
> >  target/s390x/helper.c           |  5 -----
> >  8 files changed, 34 insertions(+), 27 deletions(-)
> >  =20
>=20
> Queued all, thanks.

So, I guess I should unqueue patch 5-7 from s390-next again?

>=20
> Paolo
>=20



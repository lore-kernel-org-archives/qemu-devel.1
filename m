Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FDEC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F163B215F1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jF1QCrxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F163B215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaco5-0006iP-5d
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 04:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iacV7-00038u-IP
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:23:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iacV2-0000wQ-FU
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:23:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26706
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iacV2-0000pN-AI
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:23:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575019418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QJC5NEOyWAYRNOuluSSqxLUfEDMwph8JpTjlbHY+1UU=;
 b=jF1QCrxvuEP1DVl9VmhxKmjfVSJC278o6bTCP5paNHKe74KnhfIbHBWEWQvHZ8456QuZfu
 azOlZKLgeI3Zrdf2r1ipYbaDe5CIn85KIkIAs4O6REtnreq6FtbppT+wM5lKLlSAZzFBtA
 JjU5np4778R75QFkvyzA5ffRlnEjunM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-gkSBdAZFPUa3J0oOc79eLw-1; Fri, 29 Nov 2019 04:23:35 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F27380183C;
 Fri, 29 Nov 2019 09:23:34 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BCD5E19C4F;
 Fri, 29 Nov 2019 09:23:27 +0000 (UTC)
Date: Fri, 29 Nov 2019 10:23:25 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
Message-ID: <20191129102325.55ee16ea@redhat.com>
In-Reply-To: <20191128165933.GB3295@work-vm>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191128165933.GB3295@work-vm>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: gkSBdAZFPUa3J0oOc79eLw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 Nov 2019 16:59:33 +0000
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@redhat.com) wrote:
> > Hi,
> >=20
> > Setting up shared memory for vhost-user is a bit complicated from
> > command line, as it requires NUMA setup such as: m 4G -object
> > memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,share=3Don -=
numa
> > node,memdev=3Dmem.
> >=20
> > Instead, I suggest to add a -mem-shared option for non-numa setups,
> > that will make the -mem-path or anonymouse memory shareable.
> >=20
> > Comments welcome, =20
>=20
> It's worth checking with Igor (cc'd) - he said he was going to work on
> something similar.
>=20
> One other thing this fixes is that it lets you potentially do vhost-user
> on s390, since it currently has no NUMA.
Switching to memdev will let vhost-user on s390 work as well.
This is convenience option and workarounds inability to set main RAM
properties in current impl.=20


> Dave
>=20
> > Marc-Andr=C3=A9 Lureau (2):
> >   memfd: add qemu_memfd_open()
> >   Add -mem-shared option
> >=20
> >  exec.c                  | 11 ++++++++++-
> >  hw/core/numa.c          | 16 +++++++++++++++-
> >  include/qemu/memfd.h    |  3 +++
> >  include/sysemu/sysemu.h |  1 +
> >  qemu-options.hx         | 10 ++++++++++
> >  util/memfd.c            | 39 +++++++++++++++++++++++++--------------
> >  vl.c                    |  4 ++++
> >  7 files changed, 68 insertions(+), 16 deletions(-)
> >=20
> > --=20
> > 2.24.0
> >=20
> >  =20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
>=20



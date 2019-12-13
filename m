Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A15AC2D0CC
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:28:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 019E121655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkFT7ts9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019E121655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifkmM-00064X-K2
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 08:14:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ifkkl-00059r-S3
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 08:13:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ifkkj-0001Wx-0Y
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 08:13:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20440
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ifkki-0001Ti-Hj
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 08:13:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576242783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XJAaCGTQyOdY+ZlVP4tFf/dlth23z9aVmfrtHknWenE=;
 b=XkFT7ts9IzJXzVsFhTCOjelmBe6EkfB7ofkIG9u9262ed7IGXPPBcpy8vu9yeSY5Qcht3k
 Gx3vD7rEA6kAQ0EcPuLpYkBW2J2iFbvOWl6YKOxyCGC+sH1A8nYDoqZ1NU3qvzzaB01jar
 CC12GDepeEA98SCrOM6pBMGRuvocmVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-sau5UIecORCd7sRuOGNXcg-1; Fri, 13 Dec 2019 08:13:00 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFDAD18543B0;
 Fri, 13 Dec 2019 13:12:59 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C556C5D6BE;
 Fri, 13 Dec 2019 13:12:53 +0000 (UTC)
Date: Fri, 13 Dec 2019 14:12:51 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
Message-ID: <20191213141251.00dfc67c@redhat.com>
In-Reply-To: <20191213113957.GB1186952@stefanha-x1.localdomain>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191128165933.GB3295@work-vm>
 <20191129102325.55ee16ea@redhat.com>
 <20191213113957.GB1186952@stefanha-x1.localdomain>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: sau5UIecORCd7sRuOGNXcg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: gongsu@us.ibm.com, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Dec 2019 11:39:57 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Fri, Nov 29, 2019 at 10:23:25AM +0100, Igor Mammedov wrote:
> > On Thu, 28 Nov 2019 16:59:33 +0000
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> >  =20
> > > * Marc-Andr=C3=A9 Lureau (marcandre.lureau@redhat.com) wrote: =20
> > > > Hi,
> > > >=20
> > > > Setting up shared memory for vhost-user is a bit complicated from
> > > > command line, as it requires NUMA setup such as: m 4G -object
> > > > memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,share=3D=
on -numa
> > > > node,memdev=3Dmem.
> > > >=20
> > > > Instead, I suggest to add a -mem-shared option for non-numa setups,
> > > > that will make the -mem-path or anonymouse memory shareable.
> > > >=20
> > > > Comments welcome,   =20
> > >=20
> > > It's worth checking with Igor (cc'd) - he said he was going to work o=
n
> > > something similar.
> > >=20
> > > One other thing this fixes is that it lets you potentially do vhost-u=
ser
> > > on s390, since it currently has no NUMA. =20
> > Switching to memdev will let vhost-user on s390 work as well.
> > This is convenience option and workarounds inability to set main RAM
> > properties in current impl.  =20
>=20
> Gong Su asked about virtio-fs (vhost-user) on s390.  This patch series
> might be the first step to enabling it.

I'm preparing(resplitting/cleaning up) series that will switch main RAM
to memdev backend.

(
I'd prefer to post complete series that does conversion across all boards.
But if it's pressing, I surely can post several patches to enable it for s3=
90
and get some early feedback on approach
)


>=20
> Stefan



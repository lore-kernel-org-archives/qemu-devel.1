Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE4BC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 21:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6400C206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 21:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0LHgfYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6400C206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiPW1-0000IR-KF
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 16:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rjones@redhat.com>) id 1iiPVK-0008L6-Rc
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rjones@redhat.com>) id 1iiPVH-0006gx-Is
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:08:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48244
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rjones@redhat.com>) id 1iiPVH-0006ZO-De
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:08:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576876086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8osKcF0T0C10dE0toD2iXLOuPXkMQAwPazAbzV0Zv/Y=;
 b=G0LHgfYpW6eAoPh72xkQRvPgz4UPJ4mWVaPmbzNyhYXZJ39ofSDDo7gYxg9GsBIyr0lVrg
 j8ME4dFXPMsv/jFDxzE70tfUZkp92BwVIH9m8XHz8Y7P8D0CC7ArwKtr0UPOdDTcdL/dk9
 MwLb2HXdYgeI3Tw9PRtGWnBFWIIxZzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-rt4V5kEJPyCLnQp45bv_3g-1; Fri, 20 Dec 2019 16:07:58 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65C2A107ACC4;
 Fri, 20 Dec 2019 21:07:57 +0000 (UTC)
Received: from localhost (ovpn-117-237.ams2.redhat.com [10.36.117.237])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DCE3D5DA32;
 Fri, 20 Dec 2019 21:07:51 +0000 (UTC)
Date: Fri, 20 Dec 2019 21:07:50 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20191220210750.GA29167@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: rt4V5kEJPyCLnQp45bv_3g-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 20, 2019 at 04:13:59PM +0000, Stefan Hajnoczi wrote:
> Hi,
> QEMU presents a command-line interface and QMP monitor for
> applications to interact with.  Applications actually need API
> bindings in their programming language.  Bindings avoid reimplementing
> code to spawn a QEMU process and interact with QMP.  QEMU is kind of
> lazy and de facto relies on libvirt for API bindings.

Just wanted to add that for a concrete example you might want to look
at how libguestfs launches qemu, either directly:

  https://github.com/libguestfs/libguestfs/blob/master/lib/launch-direct.c

or via libvirt:

  https://github.com/libguestfs/libguestfs/blob/master/lib/launch-libvirt.c

Obviously I support anything that makes that easier, especially
the direct case.

Some points that you didn't cover:

- Any APIs we use need to be callable from a C library.  This has a
  few weird and wonderful beartraps to be aware of, such as being
  unable to predict the state of signal masks, not knowing what file
  descriptors will be open, and being religious about cleaning up any
  resources or subprocesses that you allocate / fork.

- To be usable, the new APIs need to cover everything that libguestfs
  needs, otherwise we literally cannot switch over to them.  (I guess
  the same applies to libvirt to an even greater extent.)

> 6. A configuration file format is sorely needed so that guest
> configuration can be persisted and easily launched.=20

Actually qemu already has that, but it's really half-assed, barely
documented, and doesn't cover major features that qemu provides :-)

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjon=
es
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW



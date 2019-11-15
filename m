Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B93AC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 10:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB3D5206C0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 10:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALMuAjbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3D5206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVYxS-00029N-0I
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 05:36:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iVYwp-0001Xi-2G
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 05:35:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iVYwm-0002hU-Vi
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 05:35:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48275
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iVYwm-0002gc-Fk
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 05:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573814123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xp+3mPnIe6Jgr36FirKPvyGuu++eZ0SjGE/i96JmlD8=;
 b=ALMuAjbDRPCHqsrjvh54cv6r/13KVn+qPrg+qsGqFvb0yU7Bg2d+PTkjFhkwdHrWc5db9u
 A1ha52I05lCt/47KUuL+6+NBfoThIVLR4IOs4SNc7j43wPxsPSNsdYiWj+7mAMmUA8sFBi
 2BX9hG2cpkjvc8mmqhtzCYaGdVpDw20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-WwzaNCBuPCOEYDuVUsBCsg-1; Fri, 15 Nov 2019 05:35:19 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83F44107ACC4;
 Fri, 15 Nov 2019 10:35:18 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A8BE969185;
 Fri, 15 Nov 2019 10:35:14 +0000 (UTC)
Date: Fri, 15 Nov 2019 11:35:12 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v1] s390x: kvm-unit-tests: a PONG device for Sub
 Channels tests
Message-ID: <20191115113512.2b9be20e.cohuck@redhat.com>
In-Reply-To: <2c10ed4f-2b9e-89e7-0e3e-704355523239@linux.ibm.com>
References: <1573671753-15115-1-git-send-email-pmorel@linux.ibm.com>
 <20191114113823.5d752648.cohuck@redhat.com>
 <20191114140235.30a788d6.pasic@linux.ibm.com>
 <20191114141915.6dd5b9c8.cohuck@redhat.com>
 <2c10ed4f-2b9e-89e7-0e3e-704355523239@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: WwzaNCBuPCOEYDuVUsBCsg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 Nov 2019 18:42:35 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 2019-11-14 14:19, Cornelia Huck wrote:
> > On Thu, 14 Nov 2019 14:02:35 +0100
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> > =20
> >> On Thu, 14 Nov 2019 11:38:23 +0100
> >> Cornelia Huck <cohuck@redhat.com> wrote:
> >> =20
> >>> On Wed, 13 Nov 2019 20:02:33 +0100
> >>> Pierre Morel <pmorel@linux.ibm.com> wrote:
> >>> =20
> ...snip...
> >> We made some different design decisions, while aiming essentially for =
the
> >> same. Maybe it's due to different scope, maybe not. For instance one
> >> can't test IDA with PONG, I guess. =20
> > Now that I saw this again, I also recall the discussion of comparing it
> > with the "testdev" for pci/isa. Anybody knows if these are used by
> > kvm-unit-tests? =20
>=20
> Only by X.

If they use it, it might make sense for s390 to use a comparable
approach.

Btw, I created https://wiki.qemu.org/Testing/CCWTestDevice back then;
might make sense to collect ideas there?

>=20
> Regards,
>=20
> Pierre
>=20
>=20



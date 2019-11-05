Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422EBC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD9E6214B2
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmTyLnB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9E6214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS1Ka-0000Ze-Fx
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 11:05:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iS1JL-0007Uw-Hj
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iS1JI-0006fT-AS
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:04:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24299
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iS1JI-0006eq-1E
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:04:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572969839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gWp6xfaIi0yb+gtxo42P3PwJt+pK/MMljHSmgaWqopw=;
 b=QmTyLnB8jQkLHrIDB4jUCTP9fcv+5eaEAF4a/78fth22FG+VWnRFi5Gj7XdUeBG9Y0XX3C
 oBPan1OWRO24syVaB8CpzmQj/1cqrXP+nYbrXuZCJvsEfFOHeWqYA3FYHjRc/vwuVB2tA8
 4xCA/mBaS+IFzPAJM/inOgfOlyGLEzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-4ALnvi9VMDqKTec0Qn6HQg-1; Tue, 05 Nov 2019 11:03:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5073477;
 Tue,  5 Nov 2019 16:03:54 +0000 (UTC)
Received: from work-vm (ovpn-117-86.ams2.redhat.com [10.36.117.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3D635D6A3;
 Tue,  5 Nov 2019 16:03:47 +0000 (UTC)
Date: Tue, 5 Nov 2019 16:03:45 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PULL 0/4] Trivial branch patches
Message-ID: <20191105160345.GB2781@work-vm>
References: <157296887817.27285.13935693519835086344@37313f22b938>
 <41caef0b-3db3-3fcf-a0b4-329e8e88ff0f@vivier.eu>
MIME-Version: 1.0
In-Reply-To: <41caef0b-3db3-3fcf-a0b4-329e8e88ff0f@vivier.eu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 4ALnvi9VMDqKTec0Qn6HQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, sstabellini@kernel.org, berrange@redhat.com,
 ehabkost@redhat.com, paul@xen.org, qemu-trivial@nongnu.org, mjt@tls.msk.ru,
 claudio.fontana@huawei.com, qemu-devel@nongnu.org, chouteau@adacore.com,
 Greg Kurz <groug@kaod.org>, marcandre.lureau@redhat.com,
 frederic.konrad@adacore.com, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 clg@kaod.org, crosa@redhat.com, anthony.perard@citrix.com, pbonzini@redhat.com,
 david@gibson.dropbear.id.au, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Laurent Vivier (laurent@vivier.eu) wrote:
> Greg, Dave,
>=20
> could you fix that?
>=20
> Thanks,
> Laurent
>=20
> Le 05/11/2019 =E0 16:48, no-reply@patchew.org a =E9crit=A0:
> > Patchew URL: https://patchew.org/QEMU/20191105144247.10301-1-laurent@vi=
vier.eu/
> >=20
> >=20
> >=20
> > Hi,
> >=20
> > This series seems to have some coding style problems. See output below =
for
> > more information:
> >=20
> > Subject: [PULL 0/4] Trivial branch patches
> > Type: series
> > Message-id: 20191105144247.10301-1-laurent@vivier.eu
> >=20
> > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > #!/bin/bash
> > git rev-parse base > /dev/null || exit 0
> > git config --local diff.renamelimit 0
> > git config --local diff.renames True
> > git config --local diff.algorithm histogram
> > ./scripts/checkpatch.pl --mailback base..
> > =3D=3D=3D TEST SCRIPT END =3D=3D=3D
> >=20
> > Switched to a new branch 'test'
> > 85ac453 global: Squash 'the the'
> > 9dd7da4 qom: Fix error message in object_class_property_add()
> > 2b76b45 hw/misc/grlib_ahb_apb_pnp: Fix 8-bit accesses
> > bddcfd9 hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to PnP regi=
sters
> >=20
> > =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> > 1/4 Checking commit bddcfd9b6b24 (hw/misc/grlib_ahb_apb_pnp: Avoid cras=
h when writing to PnP registers)
> > 2/4 Checking commit 2b76b451f9b7 (hw/misc/grlib_ahb_apb_pnp: Fix 8-bit =
accesses)
> > 3/4 Checking commit 9dd7da421bfb (qom: Fix error message in object_clas=
s_property_add())
> > WARNING: line over 80 characters
> > #31: FILE: qom/object.c:1109:
> > +        error_setg(errp, "attempt to add duplicate property '%s' to ob=
ject (type '%s')",
> >=20
> > WARNING: line over 80 characters
> > #43: FILE: qom/object.c:1141:
> > +        error_setg(errp, "attempt to add duplicate property '%s' to cl=
ass (type '%s')",
> >=20
> > total: 0 errors, 2 warnings, 22 lines checked
> >=20
> > Patch 3/4 has style problems, please review.  If any of these errors
> > are false positives report them to the maintainer, see
> > CHECKPATCH in MAINTAINERS.
> > 4/4 Checking commit 85ac453d1520 (global: Squash 'the the')
> > ERROR: do not use C99 // comments
> > #26: FILE: disas/libvixl/vixl/invalset.h:105:
> > +  // Note that this does not mean the backing storage is empty: it can=
 still

That one is a false positive; libvixl is written in C++ !

Dave

> > total: 1 errors, 0 warnings, 56 lines checked
> >=20
> > Patch 4/4 has style problems, please review.  If any of these errors
> > are false positives report them to the maintainer, see
> > CHECKPATCH in MAINTAINERS.
> >=20
> > =3D=3D=3D OUTPUT END =3D=3D=3D
> >=20
> > Test command exited with code: 1
> >=20
> >=20
> > The full log is available at
> > http://patchew.org/logs/20191105144247.10301-1-laurent@vivier.eu/testin=
g.checkpatch/?type=3Dmessage.
> > ---
> > Email generated automatically by Patchew [https://patchew.org/].
> > Please send your feedback to patchew-devel@redhat.com
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



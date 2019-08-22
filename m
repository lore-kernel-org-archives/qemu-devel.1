Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F6AC41514
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 16:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0915A23404
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 16:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0915A23404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0q2Q-0006OV-44
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 12:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i0q0G-00054z-Ix
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:32:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i0q0E-00050Q-Lv
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:32:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42744)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i0q0E-0004xq-8q
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:31:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D94713C928;
 Thu, 22 Aug 2019 16:31:54 +0000 (UTC)
Received: from work-vm (ovpn-117-231.ams2.redhat.com [10.36.117.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A340E10016E9;
 Thu, 22 Aug 2019 16:31:52 +0000 (UTC)
Date: Thu, 22 Aug 2019 17:31:50 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190822163150.GA3332@work-vm>
References: <CAFEAcA8kEKVcRu62+VGDkzRj2J87QPxzjg05dCHszeBC6X76pg@mail.gmail.com>
 <20190822114747.GS3267@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190822114747.GS3267@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 22 Aug 2019 16:31:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] more automated/public CI for QEMU pullreqs
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Samuel Ortiz <sameo@linux.intel.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Fri, Aug 16, 2019 at 07:16:55PM +0100, Peter Maydell wrote:
> > The two major contenders suggested were:
> >=20
> > (1) GitLab CI, which supports custom 'runners' which we can set
> > up to run builds and tests on machines we have project access to
> >=20
> > (2) Patchew, which can handle running tests on multiple machines (eg
> > we do s390 testing today for all patches on list), and which we could
> > enhance to provide support for the release-manager to do their work
> >=20
> > Advantages of Gitlab CI:
> >  * somebody else is doing the development and maintainance of the
> >    CI tool -- bigger 'bus factor' than patchew
> >  * already does (more or less) what we want without needing
> >    extra coding work
> >=20
> > Advantages of Patchew:
> >  * we're already using it for patch submissions, so we know it's
> >    not going to go away
> >  * it's very easy to deploy to a new host
> >  * no dependencies except Python, so works anywhere we expect
> >    to be able to build QEMU (whereas gitlab CI's runner is
> >    written in Go, and there seem to be ongoing issues with getting
> >    it actually to compile for other architectures than x86)
>=20
> IMHO the development tools/processes chosen should enable the project
> contributors to maximise the time they can put into developing useful
> features for QEMU itself. Time we spend writing CI systems like patchew
> is time we're taking away from writing QEMU features, unless the new CI
> system offers major efficiency benefits over other existing solutions.
>=20
> A second important aspect is that to enable a smooth/shallow onramp
> for new contributors it is useful to have our development processes
> and tools be familiar to those with general open source dev experience
> outside QEMU.
>=20
> With both these points in mind, I think it is  pretty hard sell to
> say we should write & maintain a custom CI system just for QEMU
> unless it is offering major compelling functionality we can't do
> without.
>=20
> IOW, I'd be biased in favour of GitLab CI.

I'd agree; and I'd also find it useful to have runners setup for
Gitlab CI for related things (it would be useful for the virtio-fs
stuff);  if there are problems on other architectures then we should
find some go wranglers to go fix it.

Dave

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


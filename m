Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACD5CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 09:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 249DB20656
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 09:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8PFBgV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249DB20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQTfs-0004Ln-8L
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 05:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iQTds-0003Qs-Qt
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 05:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iQTdp-0005a1-75
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 05:54:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29171
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iQTdo-0005Pe-Tl
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 05:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572602086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xht0y0BS/kTDLrnds4Ptzz5MaZrnnI/jm6x8f6czTpU=;
 b=D8PFBgV00S7vqYQldP/byoMdTnY4L7yUGWiMrBAwOGzqCZn7bCdLJ+sRrf/mg+IXbzl6tQ
 O6M+5Rr3kzGG3v6lSP43+5mnytxJYZcOLXO9sfSm2JVBpxK6iCjbIlOzdhB22j8/EB8zSP
 PROrvXOoOIP9CwaZj+tIMJwvV1oEVeY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-BmwcowUKPg-QOzu8Gr1Ezw-1; Fri, 01 Nov 2019 05:54:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AD46107ACC0;
 Fri,  1 Nov 2019 09:54:42 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-117-11.ams2.redhat.com
 [10.36.117.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74E39600D1;
 Fri,  1 Nov 2019 09:54:41 +0000 (UTC)
Date: Fri, 1 Nov 2019 10:54:38 +0100
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/11] target-arm queue
Message-ID: <20191101095438.a6wd2mal4w75irvg@kamzik.brq.redhat.com>
References: <20191101085140.5205-1-peter.maydell@linaro.org>
 <CAFEAcA-N-Fh7+NCHGPXuK-H6DUTOwjfCU6rmZGz4k8n+tkKdxw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-N-Fh7+NCHGPXuK-H6DUTOwjfCU6rmZGz4k8n+tkKdxw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: BmwcowUKPg-QOzu8Gr1Ezw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 01, 2019 at 09:30:21AM +0000, Peter Maydell wrote:
> On Fri, 1 Nov 2019 at 08:51, Peter Maydell <peter.maydell@linaro.org> wro=
te:
> >
> > target-arm queue: two bug fixes, plus the KVM/SVE patchset,
> > which is a new feature but one which was in my pre-softfreeze
> > pullreq (it just had to be dropped due to an unexpected test failure.)
> >
> > thanks
> > -- PMM
> >
> > The following changes since commit b7c9a7f353c0e260519bf735ff0d4aa01e72=
784b:
> >
> >   Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' i=
nto staging (2019-10-31 15:57:30 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-=
arm-20191101-1
> >
> > for you to fetch changes up to d9ae7624b659362cb2bb2b04fee53bf50829ca56=
:
> >
> >   target/arm: Allow reading flags from FPSCR for M-profile (2019-11-01 =
08:49:10 +0000)
>=20
> Drew, this is still failing 'make check' on the aarch32-chroot-on-aarch64=
 :-(
>=20
> (armhf)pmaydell@mustang-maydell:~/qemu/build/all-a32$
> QTEST_QEMU_BINARY=3Darm-softmmu/qemu-system-arm ./tests/arm-cpu-features
> /arm/arm/query-cpu-model-expansion: OK
> /arm/arm/kvm/query-cpu-model-expansion: qemu-system-arm: Failed to
> retrieve host CPU features
> Broken pipe
> /home/peter.maydell/qemu/tests/libqtest.c:140: kill_qemu() tried to
> terminate QEMU process but encountered exit status 1 (expected 0)
> Aborted
>

Darn it. Sorry about that, but if it's still failing then I think QEMU
must believe KVM is enabled, i.e. kvm_enabled() in QEMU must be true.
I can try to confirm that and fix it, but I'll need to set up this
environment first.

Thanks,
drew



Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55210C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2454D21D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmXR30+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2454D21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuhLJ-0006RH-Qw
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:36:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iufBB-0006sU-Bc
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:18:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iufB9-0003IX-U1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:18:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35888
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iufB9-0003HU-Mf
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579796278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VKwo6yXRdMFGGFhb6nzWt7c5A0r9Gan3VMFkQ5bI3Ms=;
 b=GmXR30+iZUoBGBRtmz1wGZgR2dKm9j+eNsKjVzmZsGswuKbk+TvoRX76jvELw2KGg6MxN/
 exHuUuINCdEGgZ6H4UKPiOWyaHEyGOgfoQKXde6hMz/FhAxzd6L815XRH5635hsxMdZiao
 rXa8JKM0thBhOwhgzxsigDqzntd1/0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-eaPHjztJMDuXqihKILqsyQ-1; Thu, 23 Jan 2020 11:17:48 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E009E1005514;
 Thu, 23 Jan 2020 16:17:46 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EFB3785753;
 Thu, 23 Jan 2020 16:17:42 +0000 (UTC)
Date: Thu, 23 Jan 2020 17:17:40 +0100
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH REPOST v3] target/arm/arch_dump: Add SVE notes
Message-ID: <20200123161740.dkukm5sy2dvjjdej@kamzik.brq.redhat.com>
References: <20200120101832.18781-1-drjones@redhat.com>
 <CAFEAcA9+amcwA7WGzXxc2Cb_J7-=rxFb6ubk3ZYn-Y+zWoWk4w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9+amcwA7WGzXxc2Cb_J7-=rxFb6ubk3ZYn-Y+zWoWk4w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: eaPHjztJMDuXqihKILqsyQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dave P Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 23, 2020 at 02:53:42PM +0000, Peter Maydell wrote:
> On Mon, 20 Jan 2020 at 10:18, Andrew Jones <drjones@redhat.com> wrote:
> >
> > When dumping a guest with dump-guest-memory also dump the SVE
> > registers if they are in use.
> >
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  include/elf.h          |   2 +
> >  target/arm/arch_dump.c | 124 ++++++++++++++++++++++++++++++++++++++++-
> >  target/arm/cpu.h       |  25 +++++++++
> >  target/arm/kvm64.c     |  24 --------
> >  4 files changed, 149 insertions(+), 26 deletions(-)
> >
>=20
>=20
> Applied to target-arm.next, thanks (I fixed up the checkpatch
> nits).
>

You mean the ones in include/elf.h? I had left those on purpose in
order to exactly match the glibc elf.h. I just checked QEMU's
elf.h, though, and see other changes were reformatted. Next time
I'll do the same.

Thanks,
drew



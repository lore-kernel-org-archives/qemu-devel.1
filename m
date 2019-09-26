Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B0AC432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:26:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1914217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1914217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDQ2F-0000ze-2d
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 05:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iDQ1G-0008TC-1X
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iDQ1C-0003tI-FS
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:25:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8278)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iDQ1C-0003t6-9k
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:24:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 55EF230A7BB5;
 Thu, 26 Sep 2019 09:24:57 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 07C6119C5B;
 Thu, 26 Sep 2019 09:24:55 +0000 (UTC)
Message-ID: <7c019f3a5236daaa79e67467f64cde212ad05f35.camel@redhat.com>
Subject: Re: Questions about the real mode in kvm/qemu
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Li Qiang <liq3ea@gmail.com>
Date: Thu, 26 Sep 2019 12:24:55 +0300
In-Reply-To: <23789310-35fb-8c93-44f4-532bcd34007d@redhat.com>
References: <CAKXe6SJfZt8WcA43Vsh0=GT=jBedcAOUx9DNGZ4Bsvi10oCkog@mail.gmail.com>
 <644968ffb11c11fd580e96c1e67932501a633fe4.camel@redhat.com>
 <CAKXe6SK+cEytTtgKHw8KXY=jY4xv=27GBu55hTbTmbRyTPsfxg@mail.gmail.com>
 <3d3f3a0e6e796260348c66e69e859e1901501ee8.camel@redhat.com>
 <23789310-35fb-8c93-44f4-532bcd34007d@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 26 Sep 2019 09:24:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Qemu Developers <qemu-devel@nongnu.org>, Avi Kivity <avi.kivity@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-09-26 at 11:18 +0200, Paolo Bonzini wrote:
> On 26/09/19 10:59, Maxim Levitsky wrote:
> > If you mean to ask if there is a way to let guest access use no
> > paging at all, that is access host physical addresses directly, then
> > indeed there is no way, since regular non 'unrestricted guest' mode
> > required both protected mode and paging, and 'unrestricted guest'
> > requires EPT. Academically speaking it is of course possible to
> > create paging tables that are 1:1...
>=20
> Not so academically, it's exactly what KVM does.
You mean KVM uses 1:1 EPT pages and no guest paging,
to allow guest to access host physical address space?
That would break the security completely, thus I think you
mean something else here.


>   However, indeed it
> would also be possible to switch out of EPT mode when CR0.PG=3D0.  I'm =
not
> sure why it was done this way, maybe when the code was written it was
> simpler to use the identity map.
>=20
> Let's see if Avi is listening... :)
>=20
> Paolo

Here a quote from the PRM:

"The first processors to support VMX operation require CR0.PE and CR0.PG =
to be 1 in VMX operation (see Section
23.8). This restriction implies that guest software cannot be run in unpa=
ged protected mode or in real-address
mode. Later processors support a VM-execution control called =E2=80=9Cunr=
estricted guest=E2=80=9D. 1 If this control is 1, CR0.PE and
CR0.PG may be 0 in VMX non-root operation. Such processors allow guest so=
ftware to run in unpaged protected
mode or in real-address mode. The following items describe the behavior o=
f such software:"
...

"As noted in Section 26.2.1.1, the =E2=80=9Cenable EPT=E2=80=9D VM-execut=
ion control must be 1 if the =E2=80=9Cunrestricted guest=E2=80=9D VM-exec=
ution control is 1."


Best regards,
	Maxim Levitsky



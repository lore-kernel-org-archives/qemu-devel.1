Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8126C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:00:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B127F222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B127F222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDPdH-0003C6-SU
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 05:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iDPcO-000233-FY
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iDPcM-0007gn-ET
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:59:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59502)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iDPcM-0007eE-8A
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:59:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6E310796E0;
 Thu, 26 Sep 2019 08:59:17 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55C975C21F;
 Thu, 26 Sep 2019 08:59:16 +0000 (UTC)
Message-ID: <3d3f3a0e6e796260348c66e69e859e1901501ee8.camel@redhat.com>
Subject: Re: Questions about the real mode in kvm/qemu
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Li Qiang <liq3ea@gmail.com>
Date: Thu, 26 Sep 2019 11:59:15 +0300
In-Reply-To: <CAKXe6SK+cEytTtgKHw8KXY=jY4xv=27GBu55hTbTmbRyTPsfxg@mail.gmail.com>
References: <CAKXe6SJfZt8WcA43Vsh0=GT=jBedcAOUx9DNGZ4Bsvi10oCkog@mail.gmail.com>
 <644968ffb11c11fd580e96c1e67932501a633fe4.camel@redhat.com>
 <CAKXe6SK+cEytTtgKHw8KXY=jY4xv=27GBu55hTbTmbRyTPsfxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 26 Sep 2019 08:59:17 +0000 (UTC)
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-09-26 at 16:52 +0800, Li Qiang wrote:
>=20
>=20
> Maxim Levitsky <mlevitsk@redhat.com> =E4=BA=8E2019=E5=B9=B49=E6=9C=8826=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=884:31=E5=86=99=E9=81=93=EF=BC=
=9A
> > On Thu, 2019-09-26 at 15:52 +0800, Li Qiang wrote:
> > > Hi Paolo and all,
> > >=20
> > > There are some question about the emulation for real mode in kvm/qe=
mu. For all the=20
> > > question I suppose the 'unstrict guest' is not enabled.=20
> > >=20
> > > 1. how the protected mode CPU emulate the real mode? It seems it us=
es vm86, however, vm86 is not available in x86_64 CPU? So what's the 'to_=
vmx(vcpu)->rmode.vm86_active' here vm86 means?
> > >=20
> >=20
>=20
> Hi Maxim,
>=20
> Thanks for your kind reply.
>=20
> =20
> > As far as I know it, modern intel's cpus support so called unrestrict=
ed guest mode, which allows guest to be basically in any mode,
>=20
> Right, but I also want to know the secret when the 'unstrict guest' is =
disabled. So I suppose the 'unstrict guest' is  not enabled for these que=
stions.
> =20
> > as long as EPT paging is used (that is guest can be in real mode with
> > no paging, but EPT has to be enabled).
> > The 'vm86_active' is probably lefover support for cpus that don't sup=
port EPT and/or the unrestricted guest mode,
> > where KVM tried to use the good old vm86 mode to
> > for real mode virtualization.
> >=20
> >=20
> > > 2. Does the guest's real mode code run directly in native CPU? It s=
eems 'vmx->emulation_required' is also be false, it the vmx_vcpu_run will=
 do a switch to guest.
> >=20
> > Same as above
> >=20
> > >=20
> > > 3. How the EPT work in guest real mode? The EPT is for GVA->GPA->HP=
A, however there is no GVA, seems the identity mapping does something. Bu=
t there also some confusion for me. For example the
> > real
> > > mode uses CS*4 + IP to address the code.  Who does this calculation=
? In the kernel emulator?=20
> >=20
> > EPT sits underneath the guest's paging mode, which in case of real mo=
de is 1:1 mapping.
>=20
> It seems when the 'unstrict guest' is enabled, there is no identity map=
ping table.

If you mean to ask if there is a way to let guest access use no paging at=
 all, that is access host physical addresses directly,
then indeed there is no way, since regular non 'unrestricted guest' mode =
required both protected mode and paging, and 'unrestricted guest' require=
s
EPT.
Academically speaking it is of course possible to create paging tables th=
at are 1:1...


Best regards,
	Maxim Levitsky



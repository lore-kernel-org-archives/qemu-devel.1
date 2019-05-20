Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BA4C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986442171F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986442171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41911 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSpUM-0001al-Tu
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 17:06:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hSpTQ-00015V-Cg
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:05:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hSpTN-0002tp-MV
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:05:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hSpTN-0002sy-GD
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:05:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1CF63086272;
	Mon, 20 May 2019 21:05:27 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 214361001DE7;
	Mon, 20 May 2019 21:05:26 +0000 (UTC)
Date: Mon, 20 May 2019 18:05:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190520210525.GE10764@habkost.net>
References: <1557813999-9175-1-git-send-email-wanpengli@tencent.com>
	<dcbf44c3-2fb9-02c0-79cc-c8a30373d35a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dcbf44c3-2fb9-02c0-79cc-c8a30373d35a@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Mon, 20 May 2019 21:05:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] i386: Enable IA32_MISC_ENABLE MWAIT bit
 when exposing mwait/monitor
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Wanpeng Li <kernellwp@gmail.com>, qemu-devel@nongnu.org,
	kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 20, 2019 at 02:59:53PM +0200, Paolo Bonzini wrote:
> On 14/05/19 08:06, Wanpeng Li wrote:
> > From: Wanpeng Li <wanpengli@tencent.com>
> >=20
> > The CPUID.01H:ECX[bit 3] ought to mirror the value of the MSR=20
> > IA32_MISC_ENABLE MWAIT bit and as userspace has control of them=20
> > both, it is userspace's job to configure both bits to match on=20
> > the initial setup.
>=20
> Queued, thanks.
>=20
> Paolo
>=20
> > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> > Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> > ---
> >  target/i386/cpu.c | 3 +++
> >  target/i386/cpu.h | 1 +
> >  2 files changed, 4 insertions(+)
> >=20
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 722c551..40b6108 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -4729,6 +4729,9 @@ static void x86_cpu_reset(CPUState *s)
> > =20
> >      env->pat =3D 0x0007040600070406ULL;
> >      env->msr_ia32_misc_enable =3D MSR_IA32_MISC_ENABLE_DEFAULT;
> > +    if (enable_cpu_pm) {
> > +        env->msr_ia32_misc_enable |=3D MSR_IA32_MISC_ENABLE_MWAIT;
> > +    }

What if enable_cpu_pm is false but we're running TCG, or if
enable_cpu_pm is true but we're not using -cpu host?

Shouldn't this be conditional on
  (env->features[FEAT_1_ECX] & CPUID_EXT_MONITOR)
instead?

> > =20
> >      memset(env->dr, 0, sizeof(env->dr));
> >      env->dr[6] =3D DR6_FIXED_1;
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index 0128910..b94c329 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -387,6 +387,7 @@ typedef enum X86Seg {
> >  #define MSR_IA32_MISC_ENABLE            0x1a0
> >  /* Indicates good rep/movs microcode on some processors: */
> >  #define MSR_IA32_MISC_ENABLE_DEFAULT    1
> > +#define MSR_IA32_MISC_ENABLE_MWAIT      (1ULL << 18)
> > =20
> >  #define MSR_MTRRphysBase(reg)           (0x200 + 2 * (reg))
> >  #define MSR_MTRRphysMask(reg)           (0x200 + 2 * (reg) + 1)
> >=20
>=20

--=20
Eduardo


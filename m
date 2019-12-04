Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FAFC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 09:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4AB20675
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 09:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z36/sFtu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4AB20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icQsU-0002xE-Eh
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 04:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1icQkx-00011x-6u
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:15:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1icQkn-0001L5-Dl
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:15:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43240
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1icQkn-0001BD-8W
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575450922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XyOjVEgHcFM0M8TQKjiiwR4fA1tb3QtgAmeOdVJLkN4=;
 b=Z36/sFtuYiskdgNV35tKnR+QDTXwHpGanE2m8rm7Llz7YcvsNDJXb7lC+d/F/T42MrxYXn
 FimsVxG+Q7rIFkasq5lFOBsi+jbBtuC/cs5c/6n1eO8FAoToZrHbYPzme1GGBgXQFaDFxs
 i8CWTOhra7fcibqV0SLz6OZbag8hTu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-KtMW7vbEMN6v-nk95fFtsQ-1; Wed, 04 Dec 2019 04:15:19 -0500
X-MC-Unique: KtMW7vbEMN6v-nk95fFtsQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02F9810054E3;
 Wed,  4 Dec 2019 09:15:18 +0000 (UTC)
Received: from gondolin (dhcp-192-245.str.redhat.com [10.33.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8CF85C1B0;
 Wed,  4 Dec 2019 09:15:16 +0000 (UTC)
Date: Wed, 4 Dec 2019 10:15:06 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 2/4] s390x: Add missing vcpu reset functions
Message-ID: <20191204101506.7b5963bc.cohuck@redhat.com>
In-Reply-To: <a84f5248-8255-0e9d-7253-91d53e4f7765@linux.ibm.com>
References: <20191203132813.2734-1-frankja@linux.ibm.com>
 <20191203132813.2734-3-frankja@linux.ibm.com>
 <20191203184459.0417a40a.cohuck@redhat.com>
 <a84f5248-8255-0e9d-7253-91d53e4f7765@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="Sig_/qb9GFA80F669iYJJ4_nJNG6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/qb9GFA80F669iYJJ4_nJNG6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Dec 2019 10:00:45 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 12/3/19 6:44 PM, Cornelia Huck wrote:
> > On Tue,  3 Dec 2019 08:28:11 -0500
> > Janosch Frank <frankja@linux.ibm.com> wrote:
> >  =20
> >> Up to now we only had an ioctl to reset vcpu data QEMU couldn't reach
> >> for the initial reset, and that was also called for the clear
> >> reset. To be architecture compliant, we also need to clear local
> >> interrupts on a normal reset.
> >>
> >> Because of this and the upcoming protvirt support we need to add
> >> ioctls for the missing clear and normal resets.
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >> Acked-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  target/s390x/cpu.c       | 16 +++++++++++++--
> >>  target/s390x/kvm-stub.c  | 10 +++++++++-
> >>  target/s390x/kvm.c       | 42 ++++++++++++++++++++++++++++++++-------=
-
> >>  target/s390x/kvm_s390x.h |  4 +++-
> >>  4 files changed, 60 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> >> index 829ce6ad54..4973365d6c 100644
> >> --- a/target/s390x/cpu.c
> >> +++ b/target/s390x/cpu.c
> >> @@ -139,8 +139,20 @@ static void s390_cpu_reset(CPUState *s, cpu_reset=
_type type)
> >>      }
> >> =20
> >>      /* Reset state inside the kernel that we cannot access yet from Q=
EMU. */ =20
> >=20
> > For the last iteration, I asked about the 'yet' here... =20
>=20
> I have not written those comments, I merely refuse to delete them :)
> We still reset some state in the kernel, I'm not sure how much of that
> is already exposed via ioctls to QEMU, so I won't remove the comment.
>=20
> >  =20
> >> -    if (kvm_enabled() && type !=3D S390_CPU_RESET_NORMAL) {
> >> -        kvm_s390_reset_vcpu(cpu);
> >> +    if (kvm_enabled()) {
> >> +        switch (type) {
> >> +        case S390_CPU_RESET_CLEAR:
> >> +            kvm_s390_reset_vcpu_clear(cpu);
> >> +            break;
> >> +        case S390_CPU_RESET_INITIAL:
> >> +            kvm_s390_reset_vcpu_initial(cpu);
> >> +            break;
> >> +        case S390_CPU_RESET_NORMAL:
> >> +            kvm_s390_reset_vcpu_normal(cpu);
> >> +            break;
> >> +        default:
> >> +            g_assert_not_reached();
> >> +        }
> >>      }
> >>  }
> >>   =20
> >=20
> > (...)
> >  =20
> >> @@ -403,17 +405,41 @@ int kvm_arch_destroy_vcpu(CPUState *cs)
> >>      return 0;
> >>  }
> >> =20
> >> -void kvm_s390_reset_vcpu(S390CPU *cpu)
> >> +static void kvm_s390_reset_vcpu(S390CPU *cpu, unsigned long type)
> >>  {
> >>      CPUState *cs =3D CPU(cpu);
> >> =20
> >> -    /* The initial reset call is needed here to reset in-kernel
> >> -     * vcpu data that we can't access directly from QEMU
> >> -     * (i.e. with older kernels which don't support sync_regs/ONE_REG=
).
> >> -     * Before this ioctl cpu_synchronize_state() is called in common =
kvm
> >> -     * code (kvm-all) */
> >> -    if (kvm_vcpu_ioctl(cs, KVM_S390_INITIAL_RESET, NULL)) {
> >> -        error_report("Initial CPU reset failed on CPU %i", cs->cpu_in=
dex);
> >> +    /*
> >> +     * The reset call is needed here to reset in-kernel vcpu data tha=
t
> >> +     * we can't access directly from QEMU (i.e. with older kernels
> >> +     * which don't support sync_regs/ONE_REG).  Before this ioctl =20
> >=20
> > ...and this reference to 'older kernels' here.
> >=20
> > Are the comments still correct/relevant? =20
>=20
> See above

Fair enough, let's keep them for now and revisit this later.

>=20
> >  =20
> >> +     * cpu_synchronize_state() is called in common kvm code
> >> +     * (kvm-all).
> >> +     */
> >> +    if (kvm_vcpu_ioctl(cs, type)) {
> >> +        error_report("CPU reset failed on CPU %i type %lx",
> >> +                     cs->cpu_index, type);
> >> +    }
> >> +} =20
> >  =20
>=20
>=20


--Sig_/qb9GFA80F669iYJJ4_nJNG6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl3neRoACgkQ3s9rk8bw
L69/LhAAnECoMr6I7+S6rx4Etb1UJU+4Z9PX2qO9Oi9mYScYsoh2L2bmXx0myXHp
Bkb8Wdirm8yHaIZTTcqxenT/oi1ENK+wk2/ERXoMX8V1UqXrgdoBHW8+8R0byqW1
2dvdOeeFOnrvWg+lD4Tux1aLYVUCjn8Ps76iiHD7KxCHzzlrSTTTaeLzjp46ivw5
DMHJOrZneQmgHpKLKcVpRcU2oLj25VPN8RF3pC0xRNa//gzyISwBuN90MzqntAao
2tS64J1EjAU6wqeTbAopT4khC07l3cQXzeImy5bEJ/czyPYK/khcoDrABJHfnYWm
RXPwpm0LthIdgwj2hUs9cHPwuW3VD1zkSpQc69QYuAr4kFQWPDWsCt3Grwlsu0J8
cifUvL3vM6MB7wjdMCL0Zaf2MTzk1lY1R7KdwNlC13YLirW+vqvnXT8RhDjOoLEp
R9TRDOoJSbAmzf2uRbjFguU7halKl1uN9dbYLR9Aq6ibUfVNt+hzTKFF+YgyIrkx
c2lF66bqxcf3VoOzD+9V+6bA/YgAtzTgWNayj9yC+3aaV6gqDAqERRQCnayO89QM
fKOc3I+Te3Pk7txwg9esZa9dbE9ZbNLz+gQeAivIYvsl9HcoRT/xwTQYVN5Sfyxk
2jqta+jh+t567NZ+/Xs16odeqSo5pBAbBKssQTcDfz9JAXmOkkI=
=/SuI
-----END PGP SIGNATURE-----

--Sig_/qb9GFA80F669iYJJ4_nJNG6--



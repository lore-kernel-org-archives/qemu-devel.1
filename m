Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EECC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 23:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E1A21927
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 23:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TE7iqe5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E1A21927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFQvN-0000xo-Ig
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 19:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFQur-0000Ws-6z; Mon, 07 Sep 2020 19:51:17 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:56023 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFQun-0001gH-GP; Mon, 07 Sep 2020 19:51:16 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BllRG1PHfz9sTK; Tue,  8 Sep 2020 09:51:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599522666;
 bh=qD454x6JcxFguVNpjv/cmg5ZwHuCt9VHMjWmODsm1zQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TE7iqe5cdt8ogekpOflqbp6h3TpqOmQdflc8JNjCzUiPpQVRvtyuf9CWsePBSpc59
 zBH1z4QMhlYINL+Ta7LJjr5I59DG2uTwA32h9DHL/5ypTo/sPiXhT0egaKl+QcJXUw
 ovFttUp00yjSyjUCRLUpRNvcFRZOLingZhR4B/uo=
Date: Tue, 8 Sep 2020 09:50:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PULL 00/30] ppc-for-5.2 queue 20200904
Message-ID: <20200907235059.GL341806@yekko.fritz.box>
References: <20200904034719.673626-1-david@gibson.dropbear.id.au>
 <CAFEAcA8xCpRBcsCaozEXnCuM5SqWr5ZEDrwLjs+8va=316_70Q@mail.gmail.com>
 <20200907023800.GJ341806@yekko.fritz.box>
 <675253df-b750-1a0a-5447-9dadef1accba@redhat.com>
 <7c287125-70b3-4330-fd5c-8e644e1c347d@redhat.com>
 <ffee957d-0428-d167-c1ab-3fe67b4d8c7c@redhat.com>
 <20200907165132.683d2880.cohuck@redhat.com>
 <f93673f9-3e83-ef5f-9628-819b25908e43@redhat.com>
 <77b63a31-48a8-c77f-9956-7511db170594@redhat.com>
 <0bca4e6e-f4ba-2108-ecaf-c3daaadbdb26@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dpynvXbW/eW9Tpc3"
Content-Disposition: inline
In-Reply-To: <0bca4e6e-f4ba-2108-ecaf-c3daaadbdb26@redhat.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--dpynvXbW/eW9Tpc3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2020 at 09:46:28PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 9/7/20 7:26 PM, Laurent Vivier wrote:
> > On 07/09/2020 18:29, Laurent Vivier wrote:
> >> On 07/09/2020 16:51, Cornelia Huck wrote:
> >>> On Mon, 7 Sep 2020 16:31:24 +0200
> >>> Laurent Vivier <lvivier@redhat.com> wrote:
> >>>
> >>>> On 07/09/2020 16:05, Philippe Mathieu-Daud=E9 wrote:
> >>>>> Hi Thiago,
> >>>>>
> >>>>> On 9/7/20 3:29 PM, Laurent Vivier wrote: =20
> >>>>>> On 07/09/2020 04:38, David Gibson wrote: =20
> >>>>>>> On Sun, Sep 06, 2020 at 04:20:10PM +0100, Peter Maydell wrote: =
=20
> >>>
> >>>>>>>> The 'check-tcg' tests for the linux-user static build also
> >>>>>>>> failed on an s390x test:
> >>>>>>>>
> >>>>>>>>   CHECK   debian-s390x-cross
> >>>>>>>>   BUILD   s390x-linux-user guest-tests with docker qemu/debian-s=
390x-cross
> >>>>>>>>   RUN     tests for s390x
> >>>>>>>>   TEST    threadcount on s390x
> >>>>>>>> Unhandled trap: 0x10003 =20
> >>>>>>
> >>>>>> This is EXCP_HALTED (include/exec/cpu-all.h)
> >>>>>>
> >>>>>> The message error comes from cpu_loop() in linux-user/s390x/cpu_lo=
op.c.
> >>>>>>
> >>>>>> The trap can only come from accel/tcg/cpu-exec.c
> >>>>>>
> >>>>>>     679 int cpu_exec(CPUState *cpu)
> >>>>>>     680 {
> >>>>>> ...
> >>>>>>     688     if (cpu_handle_halt(cpu)) {
> >>>>>>     689         return EXCP_HALTED;
> >>>>>>     690     }
> >>>>>>
> >>>>>> and
> >>>>>>
> >>>>>>     428 static inline bool cpu_handle_halt(CPUState *cpu)
> >>>>>>     429 {
> >>>>>>     430     if (cpu->halted) {
> >>>>>> ...
> >>>>>>     441         if (!cpu_has_work(cpu)) {
> >>>>>>     442             return true;
> >>>>>>     443         }
> >>>>>>
> >>>>>> and
> >>>>>>
> >>>>>>      58 static bool s390_cpu_has_work(CPUState *cs)
> >>>>>>      59 {
> >>>>>>      60     S390CPU *cpu =3D S390_CPU(cs);
> >>>>>>      61
> >>>>>>      62     /* STOPPED cpus can never wake up */
> >>>>>>      63     if (s390_cpu_get_state(cpu) !=3D S390_CPU_STATE_LOAD &&
> >>>>>>      64         s390_cpu_get_state(cpu) !=3D S390_CPU_STATE_OPERAT=
ING) {
> >>>>>>      65         return false;
> >>>>>>      66     }
> >>>>>>      67
> >>>>>>      68     if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
> >>>>>>      69         return false;
> >>>>>>      70     }
> >>>>>>      71
> >>>>>>      72     return s390_cpu_has_int(cpu);
> >>>>>>      73 }
> >>>>>>
> >>>>>> and in target/s390x/cpu.h:
> >>>>>>
> >>>>>>     772 #ifndef CONFIG_USER_ONLY
> >>>>>>     773 unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU=
 *cpu);
> >>>>>>     774 #else
> >>>>>>     775 static inline unsigned int s390_cpu_set_state(uint8_t cpu_=
state,
> >>>>>> S390CPU *cpu)
> >>>>>>     776 {
> >>>>>>     777     return 0;
> >>>>>>     778 }
> >>>>>>     779 #endif /* CONFIG_USER_ONLY */
> >>>>>>     780 static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
> >>>>>>     781 {
> >>>>>>     782     return cpu->env.cpu_state;
> >>>>>>     783 }
> >>>>>>
> >>>>>> As cpu_state is never set, perhaps in case of linux-user it should
> >>>>>> always return S390_CPU_STATE_OPERATING?
> >>>
> >>> Possibly, we should not have any state handling for linux-user.
> >>>
> >>
> >> I did that, but now 390_cpu_has_work() is false because
> >> CPU_INTERRUPT_HARD is not set in cs->interrupt_request.
> >>
> >> I think we should not enter in cpu_loop() with halted set to 1.
> >>
> >> Before the patch of this series, s390_cpu_reset() is called twice, and
> >> on the second call, halted is already 0.
> >>
> >> With start_powered_off set to true in initfn, on the first reset
> >> "halted" is 0 and on the second it is 1 (because it has been copied fr=
om
> >> start_powered_off) and so cpu_loop() starts with halted set to 1 and f=
ails.
> >=20
> > What is happening:
> >=20
> > [without start_powered_off]
> >=20
> >   1- halted is set to 1 in s390x_cpu_initfn()
> >   2- halted is set to 0 in s390x_cpu_reset() by parent_reset()
> >      (cpu_common_reset()
> >   3- cpu_loop() is always entered with halted set to 0
> >=20
> > [with start_powered_off]
> >=20
> >   1- halted is set to start_powered_off (1) in s390x_cpu_reset() by
> >      parent_reset() (cpu_common_reset()
> >   2- cpu_loop() is always entered with halted set to 1
> >=20
> > So in the first case, cpu_loop() is always started with halted set to 0
> > and in the second case with halted set to 1.
> >=20
> > And I think, with linux-user, it should never be started with halted set
> > to 1.
> >=20
> > We can't add a "#ifdef CONFIG_USER_ONLY" in hw/core/cpu.c to set halted
> > to 0 because it is in the common files, but we can do:
> >=20
> > diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> > index 73d7d6007e8e..749cd548f0f3 100644
> > --- a/target/s390x/cpu.c
> > +++ b/target/s390x/cpu.c
> > @@ -291,9 +291,9 @@ static void s390_cpu_initfn(Object *obj)
> >      S390CPU *cpu =3D S390_CPU(obj);
> >=20
> >      cpu_set_cpustate_pointers(cpu);
> > -    cs->start_powered_off =3D true;
> >      cs->exception_index =3D EXCP_HLT;
> >  #if !defined(CONFIG_USER_ONLY)
> > +    cs->start_powered_off =3D true;
> >      object_property_add(obj, "crash-information", "GuestPanicInformati=
on",
> >                          s390_cpu_get_crash_info_qom, NULL, NULL, NULL);
> >      cpu->env.tod_timer =3D
>=20
> This looks like the correct fix indeed :)
> (Maybe worth adding a comment around).
>=20
> Thanks for investigating!

Yes, thanks for figuring this out.  I'll fix up my PR accordingly and
resend today.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dpynvXbW/eW9Tpc3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9Wx2MACgkQbDjKyiDZ
s5JmPxAAxcW9xvfNS5AhmrDMBwNiFrmgej40Q6eQUJh3yphWxiog/x3PYPnjH8l+
D1LnIBJFfZIvk0rkaEiHeK66RV8OqCLbvZY6qfXjG02Rc6+4UObe3teV9GeQQf1K
eAP4UFzbyibVIS4RaKt4Y38GkuV0m/8NdPu+jW8zyinhCmpVfJarIIjspI/4x3k2
a6w5O4TMrpPr1FKpVO88q3kK+JHQzmNxeZyFKirVmvGdJqDJXVS3lxKbGPZ8wxmk
0NdMdU/Uzru4LhhBdJDj60ifTPWU5ZJkl4SEEyHHkVYC4EL2wS9hCJ4qtNwxNHwI
kghAsRDEte0K31UOVOwhSyaAngbFvQp040qasOnwhrDoLux8I1PZaJlpF9Az9YQE
0Lvi3IegZDhxBv+i2tPmOT1sLC2kED7fy60B6rrwX+w1MzwVNXFxtpQmfNBlYflv
fCSqz5if6HuxMvrpnxhYvDsrudMv0PmLuJ3kTnNmS/mv9Dk6C6b9YxGysSw/H3f2
5rLsmW5CF8eK9vKO8Vyg6n8o1MliSJLLNfkZ0g/fSbr3nBSrEF82tblmYOHhQ69C
jQTRz5fqwI8/r12iyY0HwpHfkeB7EBvHh/cJ584GZGzKgfVAQ8lydr9WWzNKb99F
TK8e1zxlzDuu4Hr+c65R1cOCsceMLUfOJLzvqwJr1KZywzkbjjk=
=opko
-----END PGP SIGNATURE-----

--dpynvXbW/eW9Tpc3--


Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C29C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 14:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D025207C3
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 14:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JR8PZ3IA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D025207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFIVI-0007EO-48
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 10:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kFIUl-0006pP-NU
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 10:51:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39970
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kFIUj-0001kV-4J
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 10:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599490303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WRJKrL3igjZgcqM+wlvodXLgF98vQ1qr8oAIUile/dc=;
 b=JR8PZ3IAKxFbJPErOAi2o0y9ePtGIi8JSJqHVC5td6zw3G6eqSzBwwyQjZ5VOIsIB0OoLF
 elt77mInrk2AJ2nX6le59UsMLyE/w6GY+AsBo7wJmji1Rqg5YvLoFncF39lgTo9w1m1SmB
 wON8gooeZwobW87Pl3pXaU4cNOvut8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-4Cx9ukMIN-Wqd06HNl5ZIA-1; Mon, 07 Sep 2020 10:51:42 -0400
X-MC-Unique: 4Cx9ukMIN-Wqd06HNl5ZIA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F31A1005E5B;
 Mon,  7 Sep 2020 14:51:40 +0000 (UTC)
Received: from gondolin (ovpn-112-249.ams2.redhat.com [10.36.112.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E84DC5D9D2;
 Mon,  7 Sep 2020 14:51:34 +0000 (UTC)
Date: Mon, 7 Sep 2020 16:51:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PULL 00/30] ppc-for-5.2 queue 20200904
Message-ID: <20200907165132.683d2880.cohuck@redhat.com>
In-Reply-To: <ffee957d-0428-d167-c1ab-3fe67b4d8c7c@redhat.com>
References: <20200904034719.673626-1-david@gibson.dropbear.id.au>
 <CAFEAcA8xCpRBcsCaozEXnCuM5SqWr5ZEDrwLjs+8va=316_70Q@mail.gmail.com>
 <20200907023800.GJ341806@yekko.fritz.box>
 <675253df-b750-1a0a-5447-9dadef1accba@redhat.com>
 <7c287125-70b3-4330-fd5c-8e644e1c347d@redhat.com>
 <ffee957d-0428-d167-c1ab-3fe67b4d8c7c@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 02:54:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 7 Sep 2020 16:31:24 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> On 07/09/2020 16:05, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Thiago,
> >=20
> > On 9/7/20 3:29 PM, Laurent Vivier wrote: =20
> >> On 07/09/2020 04:38, David Gibson wrote: =20
> >>> On Sun, Sep 06, 2020 at 04:20:10PM +0100, Peter Maydell wrote: =20

> >>>> The 'check-tcg' tests for the linux-user static build also
> >>>> failed on an s390x test:
> >>>>
> >>>>   CHECK   debian-s390x-cross
> >>>>   BUILD   s390x-linux-user guest-tests with docker qemu/debian-s390x=
-cross
> >>>>   RUN     tests for s390x
> >>>>   TEST    threadcount on s390x
> >>>> Unhandled trap: 0x10003 =20
> >>
> >> This is EXCP_HALTED (include/exec/cpu-all.h)
> >>
> >> The message error comes from cpu_loop() in linux-user/s390x/cpu_loop.c=
.
> >>
> >> The trap can only come from accel/tcg/cpu-exec.c
> >>
> >>     679 int cpu_exec(CPUState *cpu)
> >>     680 {
> >> ...
> >>     688     if (cpu_handle_halt(cpu)) {
> >>     689         return EXCP_HALTED;
> >>     690     }
> >>
> >> and
> >>
> >>     428 static inline bool cpu_handle_halt(CPUState *cpu)
> >>     429 {
> >>     430     if (cpu->halted) {
> >> ...
> >>     441         if (!cpu_has_work(cpu)) {
> >>     442             return true;
> >>     443         }
> >>
> >> and
> >>
> >>      58 static bool s390_cpu_has_work(CPUState *cs)
> >>      59 {
> >>      60     S390CPU *cpu =3D S390_CPU(cs);
> >>      61
> >>      62     /* STOPPED cpus can never wake up */
> >>      63     if (s390_cpu_get_state(cpu) !=3D S390_CPU_STATE_LOAD &&
> >>      64         s390_cpu_get_state(cpu) !=3D S390_CPU_STATE_OPERATING)=
 {
> >>      65         return false;
> >>      66     }
> >>      67
> >>      68     if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
> >>      69         return false;
> >>      70     }
> >>      71
> >>      72     return s390_cpu_has_int(cpu);
> >>      73 }
> >>
> >> and in target/s390x/cpu.h:
> >>
> >>     772 #ifndef CONFIG_USER_ONLY
> >>     773 unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cp=
u);
> >>     774 #else
> >>     775 static inline unsigned int s390_cpu_set_state(uint8_t cpu_stat=
e,
> >> S390CPU *cpu)
> >>     776 {
> >>     777     return 0;
> >>     778 }
> >>     779 #endif /* CONFIG_USER_ONLY */
> >>     780 static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
> >>     781 {
> >>     782     return cpu->env.cpu_state;
> >>     783 }
> >>
> >> As cpu_state is never set, perhaps in case of linux-user it should
> >> always return S390_CPU_STATE_OPERATING?

Possibly, we should not have any state handling for linux-user.

> >>
> >> Something like:
> >>
> >> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> >> index 035427521cec..8a8628fcdcc6 100644
> >> --- a/target/s390x/cpu.h
> >> +++ b/target/s390x/cpu.h
> >> @@ -771,16 +771,20 @@ int s390_assign_subch_ioeventfd(EventNotifier
> >> *notifier, uint32_t sch_id,
> >>                                  int vq, bool assign);
> >>  #ifndef CONFIG_USER_ONLY
> >>  unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu);
> >> +static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
> >> +{
> >> +    return cpu->env.cpu_state;
> >> +}
> >>  #else
> >>  static inline unsigned int s390_cpu_set_state(uint8_t cpu_state,
> >> S390CPU *cpu)
> >>  {
> >>      return 0;
> >>  }
> >> -#endif /* CONFIG_USER_ONLY */
> >>  static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
> >>  {
> >> -    return cpu->env.cpu_state;
> >> +    return S390_CPU_STATE_OPERATING;
> >>  }
> >> +#endif /* CONFIG_USER_ONLY */ =20
> >=20
> > Since this is the effect of your "target/s390x: Use start-powered-off
> > CPUState property" patch, can you have a look please?
> >  =20
>=20
> For information, the problem appears only with "--enable-debug-tcg" (I
> have also "--static --enable-linux-user --disable-system --disable-tools"=
).

Ah, so that's why this did not show up in my testing.

>=20
> CC: David Hildenbrand (s390 TCG CPU maintainer)
>=20
> Thanks,
> Laurent



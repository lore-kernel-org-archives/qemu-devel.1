Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183EEC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 06:12:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A2B920732
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 06:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFEsLeWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2B920732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFWrh-0006tX-Pz
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 02:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kFWqu-0005Z6-Dl
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 02:11:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48848
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kFWqs-0003JU-NV
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 02:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599545494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eH+DqruWu7/zKItU+1x6TcTS0IPp0yjCBo3AEUXiI6s=;
 b=gFEsLeWuC8pyBX5n8etCYo1dBLucLtQq9+irTqNizzpciZXUX7kff2G0gJlZvd1knRH3qn
 8V/X8oaYsr/Ajw+W8gAmN+9fyvzYgvi9XVsg89Kdf+W153P6UFEYrMbv8P9gEdGGnq2CwD
 /L6Ed2wRq2wfOZXFG+grb+IlBykddgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-JMDfD_SGPG-eqIw-p9Xh3A-1; Tue, 08 Sep 2020 02:11:32 -0400
X-MC-Unique: JMDfD_SGPG-eqIw-p9Xh3A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF06A801AC2;
 Tue,  8 Sep 2020 06:11:30 +0000 (UTC)
Received: from gondolin (ovpn-112-243.ams2.redhat.com [10.36.112.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC62C19728;
 Tue,  8 Sep 2020 06:11:25 +0000 (UTC)
Date: Tue, 8 Sep 2020 08:11:23 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PULL 00/30] ppc-for-5.2 queue 20200904
Message-ID: <20200908081123.048f7534.cohuck@redhat.com>
In-Reply-To: <0bca4e6e-f4ba-2108-ecaf-c3daaadbdb26@redhat.com>
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
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 7 Sep 2020 21:46:28 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 9/7/20 7:26 PM, Laurent Vivier wrote:
> > On 07/09/2020 18:29, Laurent Vivier wrote: =20

> >> I think we should not enter in cpu_loop() with halted set to 1.
> >>
> >> Before the patch of this series, s390_cpu_reset() is called twice, and
> >> on the second call, halted is already 0.
> >>
> >> With start_powered_off set to true in initfn, on the first reset
> >> "halted" is 0 and on the second it is 1 (because it has been copied fr=
om
> >> start_powered_off) and so cpu_loop() starts with halted set to 1 and f=
ails. =20
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
> > And I think, with linux-user, it should never be started with halted se=
t
> > to 1.

linux-user always confuses me a bit, but this seems right.

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
> >                          s390_cpu_get_crash_info_qom, NULL, NULL, NULL)=
;
> >      cpu->env.tod_timer =3D =20
>=20
> This looks like the correct fix indeed :)
> (Maybe worth adding a comment around).

Agreed on both counts.

> Thanks for investigating!

And here as well :)



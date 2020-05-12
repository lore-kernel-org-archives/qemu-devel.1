Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65920C54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 06:02:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AAA42072B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 06:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LY+s0qOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AAA42072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYO0F-0002WS-Nv
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 02:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jYNzV-0001nP-IZ
 for qemu-devel@nongnu.org; Tue, 12 May 2020 02:02:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44010
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jYNzU-0006mo-Rc
 for qemu-devel@nongnu.org; Tue, 12 May 2020 02:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589263325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nugp8cv/l75vGPOWqJLtFmJBdhcRZ01YnyHn34TCwiE=;
 b=LY+s0qOFuiL+OTrDA3zvXO+JnIl81fL5smiREvWXY6b0P1bsQlEMxukPYi+4uIQR1HCld9
 uu8q6Xmgtt+a1j0YJDkTkncwWJiDGaMfP+/L11Ttig2lOfbbmtX3zkB1bDyQXt+RHvcytq
 OetaqIbfcbHV17sFyYSJaxOY/SmdvjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-9kTSJPCUNjuQd4HWHxIfhA-1; Tue, 12 May 2020 02:02:02 -0400
X-MC-Unique: 9kTSJPCUNjuQd4HWHxIfhA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26EA38015CE;
 Tue, 12 May 2020 06:01:58 +0000 (UTC)
Received: from gondolin (ovpn-112-176.ams2.redhat.com [10.36.112.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FACB5D9DD;
 Tue, 12 May 2020 06:01:48 +0000 (UTC)
Date: Tue, 12 May 2020 08:01:46 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH 08/11] target/s390x: Restrict system-mode declarations
Message-ID: <20200512080146.7d0f4ae2.cohuck@redhat.com>
In-Reply-To: <2bb91290-32c5-997d-c689-4d651836c7fc@amsat.org>
References: <20200509130910.26335-1-f4bug@amsat.org>
 <20200509130910.26335-9-f4bug@amsat.org>
 <20200511124804.1a7a43aa.cohuck@redhat.com>
 <2bb91290-32c5-997d-c689-4d651836c7fc@amsat.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Marek Vasut <marex@denx.de>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 May 2020 14:21:27 +0200
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> On 5/11/20 12:48 PM, Cornelia Huck wrote:
> > On Sat,  9 May 2020 15:09:07 +0200
> > Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> >  =20
> >> As these declarations are restricted to !CONFIG_USER_ONLY in
> >> helper.c, only declare them when system-mode emulation is used.
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> ---
> >>   target/s390x/internal.h | 11 ++++++-----
> >>   1 file changed, 6 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/target/s390x/internal.h b/target/s390x/internal.h
> >> index c1678dc6bc..ddc276cdf4 100644
> >> --- a/target/s390x/internal.h
> >> +++ b/target/s390x/internal.h
> >> @@ -236,7 +236,6 @@ int s390_cpu_write_elf64_note(WriteCoreDumpFunctio=
n f, CPUState *cs,
> >>  =20
> >>   /* cc_helper.c */
> >>   const char *cc_name(enum cc_op cc_op);
> >> -void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr);
> >>   uint32_t calc_cc(CPUS390XState *env, uint32_t cc_op, uint64_t src, u=
int64_t dst,
> >>                    uint64_t vr);
> >>  =20
> >> @@ -303,18 +302,20 @@ void s390_cpu_gdb_init(CPUState *cs);
> >>  =20
> >>   /* helper.c */
> >>   void s390_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> >> -hwaddr s390_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> >> -hwaddr s390_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
> >> +void do_restart_interrupt(CPUS390XState *env);
> >> +
> >> +#ifndef CONFIG_USER_ONLY
> >> +void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr); =20
> >=20
> > load_psw() is in cc_helper.c (and not in helper.c). Rather add the
> > #ifndef above, even if it is a bit awkward? Otherwise, the wrong
> > comment makes it confusing. =20
>=20
> I've been tempted to remove the kinda outdated /* helper.c */ comment...

I don't think they're really outdated, but not sure how useful they are
to people. I'm not personally attached to them, other opinions?

>=20
> >  =20
> >>   uint64_t get_psw_mask(CPUS390XState *env);
> >>   void s390_cpu_recompute_watchpoints(CPUState *cs);
> >>   void s390x_tod_timer(void *opaque);
> >>   void s390x_cpu_timer(void *opaque);
> >> -void do_restart_interrupt(CPUS390XState *env);
> >>   void s390_handle_wait(S390CPU *cpu);
> >> +hwaddr s390_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> >> +hwaddr s390_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
> >>   #define S390_STORE_STATUS_DEF_ADDR offsetof(LowCore, floating_pt_sav=
e_area)
> >>   int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch);
> >>   int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len);
> >> -#ifndef CONFIG_USER_ONLY
> >>   LowCore *cpu_map_lowcore(CPUS390XState *env);
> >>   void cpu_unmap_lowcore(LowCore *lowcore);
> >>   #endif /* CONFIG_USER_ONLY */ =20
> >=20
> >  =20
>=20



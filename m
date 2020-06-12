Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBDFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 13:47:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C2B820792
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 13:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="pGVZa/y6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2B820792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjk1n-0008AX-B7
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 09:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jjk0a-0007Hr-4z
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 09:46:12 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:43656 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jjk0Y-0006BP-4J
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 09:46:11 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 27C8A4C8B6;
 Fri, 12 Jun 2020 13:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1591969567;
 x=1593783968; bh=kLZ47vF1qznlIfDixzNcwi0SjBhcKTGcDSAgWDyEO6k=; b=
 pGVZa/y6UkvpyhSjij5RwWAD2eYUmlvdcZFFwh4OR+Ib6n7U/TgpDzcoX4wsfpTh
 pNK/uWVwNUY+b0Dl7meey/UdYg55MhJmBUXqVM+yCfQV8T2xlHPQrB2YRL0kW57N
 mku7Bb8i+c4RntLVkVHhrBNKv2MPLwm0qMoiACdzLG4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eNXmS8CqsBd1; Fri, 12 Jun 2020 16:46:07 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id A1AB44C898;
 Fri, 12 Jun 2020 16:46:06 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 12
 Jun 2020 16:46:06 +0300
Date: Fri, 12 Jun 2020 16:46:05 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 000/115] Huge miscellaneous pull request for 2020-06-11
Message-ID: <20200612134605.GB76007@SPB-NB-133.local>
References: <20200611194449.31468-1-pbonzini@redhat.com>
 <CAFEAcA-qrxBdn5aA0kaituroTX8c1yFGdRux0_X1Y+W5_s-WHA@mail.gmail.com>
 <6e1f1fa5-2a23-b586-a3b4-1394c82794d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6e1f1fa5-2a23-b586-a3b4-1394c82794d7@redhat.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 09:46:08
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 QEMU Developers <qemu-devel@nongnu.org>,
 "Joseph S. Myers" <joseph@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 12, 2020 at 03:33:38PM +0200, Paolo Bonzini wrote:
> On 12/06/20 15:09, Peter Maydell wrote:
> > Hi; I'm afraid this fails to build on OSX, and has a check-tcg
> > failure on x86-64 Linux.
> > 
> > OSX:
> > 
> > In file included from /Users/pm215/src/qemu-for-merges/target/i386/hvf/hvf.c:53:
> > In file included from /Users/pm215/src/qemu-for-merges/include/sysemu/hvf.h:16:
> > /Users/pm215/src/qemu-for-merges/target/i386/cpu.h:1601:5: error:
> > unknown type name 'hvf_lazy_flags'
> >     hvf_lazy_flags hvf_lflags;
> >     ^
> > In file included from /Users/pm215/src/qemu-for-merges/target/i386/hvf/hvf.c:53:
> > In file included from /Users/pm215/src/qemu-for-merges/include/sysemu/hvf.h:16:
> > In file included from /Users/pm215/src/qemu-for-merges/target/i386/cpu.h:2021:
> > /Users/pm215/src/qemu-for-merges/include/exec/cpu-all.h:442:12: error:
> > returning 'void' from a function with incompatible result type
> > 'ArchCPU *' (aka 'struct X86CPU *')
> >     return container_of(env, ArchCPU, env);
> >            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /Users/pm215/src/qemu-for-merges/include/qemu/compiler.h:56:41: note:
> > expanded from macro 'container_of'
> > #define container_of(ptr, type, member) ({                      \
> >                                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> > In file included from /Users/pm215/src/qemu-for-merges/target/i386/hvf/hvf.c:53:
> > In file included from /Users/pm215/src/qemu-for-merges/include/sysemu/hvf.h:16:
> > In file included from /Users/pm215/src/qemu-for-merges/target/i386/cpu.h:2021:
> > /Users/pm215/src/qemu-for-merges/include/exec/cpu-all.h:464:14: error:
> > initializing 'ArchCPU *' (aka 'struct X86CPU *') with an expression of
> > incompatible type 'void'
> >     ArchCPU *arch_cpu = container_of(env, ArchCPU, env);
> >              ^          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 3 errors generated.
> > 
> > 
> > On x86-64 Linux host, running the check-tcg tests on the static
> > linux-user build:
> > 
> >   BUILD   i386-linux-user guest-tests with docker qemu:fedora-i386-cross
> > /home/petmay01/linaro/qemu-for-merges/tests/tcg/i386/test-i386-pcmpistri.c:
> > In function 'main':
> > /home/petmay01/linaro/qemu-for-merges/tests/tcg/i386/test-i386-pcmpistri.c:28:15:
> > warning: left-hand operand of comma expression has no effect
> > [-Wunused-value]
> >    28 |     if ("%d\n", _mm_cmpistri(s1.x, s3.x, 0x4c) != 16) {
> >       |               ^
> > 
> > (only a warning because we don't seem to be using -Werror here?)
> > 
> > and then the test crashed at runtime:
> > 
> >   TEST    test-i386-pcmpistri on i386
> > qemu: uncaught target signal 4 (Illegal instruction) - core dumped
> > timeout: the monitored command dumped core
> > Illegal instruction
> > ../Makefile.target:151: recipe for target 'run-test-i386-pcmpistri' failed
> 
> I'll resend without the offending patch.  Roman, Joseph, please take a
> look and (especially for the OS X) please check if your series need a
> rebase.
> 
> Thanks,
> 
> Paolo
> 

Hi Paolo,

I'm looking at it.

Regards,
Roman


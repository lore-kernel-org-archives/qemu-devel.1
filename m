Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D571FC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:50:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F862075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F862075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjSH-000285-SI
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kBjCl-0002br-7v
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:27 -0400
Received: from relay68.bu.edu ([128.197.228.73]:37832)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kBjCf-0005zE-6j
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:26 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 07SIX9aK005482
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 28 Aug 2020 14:33:12 -0400
Date: Fri, 28 Aug 2020 14:33:09 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Fwd] Issue 25164 in oss-fuzz: qemu: Fuzzing build failure
Message-ID: <20200828183305.6lbuwvmleqtn7fx3@mozz.bu.edu>
References: <20200823225804.umk5gh6knptqo5mw@mozz.bu.edu>
 <CABgObfZtGY-TuTLXNJNU9m_yQLfE6AM-+MdfqaaRjfMcWC8+Og@mail.gmail.com>
 <20200826135513.ay5ga3xi2ilcagqf@mozz.bu.edu>
 <CABgObfbxqPH1p-0ZD2wZWiKP0GjOjV6s+umgmOMKjm2ic7R=zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfbxqPH1p-0ZD2wZWiKP0GjOjV6s+umgmOMKjm2ic7R=zg@mail.gmail.com>
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 14:34:18
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: Darren Kenny <darren.kenny@oracle.com>, Bandan Das <bsd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200826 1715, Paolo Bonzini wrote:
> On Wed, Aug 26, 2020 at 3:56 PM Alexander Bulekov <alxndr@bu.edu> wrote:
> >
> > On 200825 0958, Paolo Bonzini wrote:
> > > Il lun 24 ago 2020, 00:58 Alexander Bulekov <alxndr@bu.edu> ha scritto:
> > >
> > > > Hi Paolo,
> > > > Our oss-fuzz builds started failing, after the meson merge. I think I
> > > > tracked down the issues:
> > > > 1.) Looking at the build-log here:
> > > >
> > > > https://oss-fuzz-build-logs.storage.googleapis.com/log-d43d402c-1ce5-4422-b3db-ccbf83a862a0.txt
> > > > The error happens at link-time. Re-running the build with V=1:
> > > > "/usr/bin/ld" ...
> > > > --whole-archive /usr/local/lib/clang/12.0.0/.../libclang_rt.asan-x86_64.a \
> > > > --start-group ..... -T /src/qemu/tests/qtest/fuzz/fork_fuzz.ld  \
> > > > -wrap qtest_inb -wrap qtest_inw ..... --end-group .....
> > > >
> > >
> > > I think you can put everything into a response for and include it with
> > > @fuzz.cmd in the command line.
> >
> > I don't think I understand. Should I provide the entire linker command,
> > by email?
> 
> You can create a file fuzz.cmd.in containing
> 
> -Wl,-T,@FUZZING_LINKER_SCRIPT@
> -Wl,-wrap,qtest_inb
> -Wl,-wrap,qtest_inw
> 
> etc.
> 
> Create a fuzz.cmd that includes the correct path to fuzz.ld in the
> source tree (using configure_file) and pass this file to the linker
> using @tests/libqtest/fuzz/fuzz.cmd in link_args (and also
> link_depends). See libblock and block for an example.

I'm not sure whether this solves the problem that the linker-script is
placed in between --start-group and --end-group arguments.  It seems
that no matter what I do to specify the linker script with -Wl,-T, and
link_args, the flag ends up placed between --start-group and --end-group
due to some parsing that meson does in
mesonbuild/compilers/mixins/clike.py.

Relevant:
https://github.com/mesonbuild/meson/pull/7505
-Alex

> Paolo
> 
> Paolo
> 


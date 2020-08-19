Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7844EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 16:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D5FA2083B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 16:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5FA2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Qsr-0000bz-Gx
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 12:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8Qrj-0008KZ-Kj
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 12:23:07 -0400
Received: from relay64.bu.edu ([128.197.228.104]:57831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8Qrh-0008OW-AR
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 12:23:07 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 07JGMB1D027134
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 19 Aug 2020 12:22:15 -0400
Date: Wed, 19 Aug 2020 12:22:11 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [PATCH] qtest: add fuzz test case
Message-ID: <20200819162211.5z6blwmgy35mw6dk@mozz.bu.edu>
References: <20200819141533.66354-1-liq3ea@163.com>
 <baabaa94-e4bf-3578-2f78-624704eb29c4@redhat.com>
 <CAKXe6S+Vpe5NH4j22deQLxZaX7NRFtwvGR0FhEoBPPNdK33ibQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKXe6S+Vpe5NH4j22deQLxZaX7NRFtwvGR0FhEoBPPNdK33ibQ@mail.gmail.com>
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 12:23:04
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200819 2250, Li Qiang wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> 于2020年8月19日周三 下午10:38写道：
> 
> > On 8/19/20 4:15 PM, Li Qiang wrote:
> > > Currently the device fuzzer find a more and more issues.
> > > For every fuzz case, we need not only the fixes but also
> > > the coressponding test case. We can analysis the reproducer
> >
> > Typo "corresponding"
> >
> 
> Will correct in next revision.
> 
> 
> >
> > > for every case and find what happened in where and write
> > > a beautiful test case. However the raw data of reproducer is not
> > > friendly to analysis. It will take a very long time, even far more
> > > than the fixes itself. So let's create a new file to hold all of
> > > the fuzz test cases and just use the raw data to act as the test
> > > case. This way nobody will be afraid of writing a test case for
> > > the fuzz reproducer.
> >
> > Ahaha nice :)
> >

So the problem is that QOS isn't built out-enough for all of the devices
that we want to test, and it would take a lot of time to translate the
fuzzer-generated reproducer each time we want to add a test?

If we want some context for the crashing trace, but cannot build out a
full test, we could add trace events to the actual device code. This
should be a small amount of work compared to building a full-fledged
tests, but maybe I'm wrong.

For the issue in question, there are already some trace points.
If I run the repro with -trace 'pci*' -trace 'megasas*' -trace 'scsi*' :
Reformat the trace somewhat and add some annotations for the data that
comes from DMA:

# megasas_init Using 80 sges, 1000 cmds, raid mode
# scsi_device_set_ua target 0 lun 0 key 0x06 asc 0x29 ascq 0x00
# megasas_reset firmware state 0xb0000000
outl 0xcf8 0x80001818
outl 0xcfc 0xc101
# pci_cfg_write megasas 03:0 @0x18 <- 0xc101
outl 0xcf8 0x8000181c
outl 0xcf8 0x80001804
outw 0xcfc 0x7
# pci_cfg_write megasas 03:0 @0x4 <- 0x7
# pci_update_mappings_add d=0x7fd3b8fbd800 00:03.0 2,0xc100+0x100
outl 0xcf8 0x8000186a
write 0x14 0x1 0xfe     # DMA Buffer
write 0x0 0x1 0x02      # DMA Buffer
outb 0xc1c0 0x17
# megasas_mmio_writel reg MFI_IQPL: 0x17
# megasas_qf_new frame 0x0 addr 0x0
# megasas_qf_enqueue frame 0x0 count 11 context 0x0 head 0x0 tail 0x0 busy 1
#  LD Write dev 0/0 lba 0x0 count 254
#  len 0 limit 520192
# scsi_req_parsed target 0 lun 0 tag 0 command 138 dir 2 length 520192
# scsi_req_parsed_lba target 0 lun 0 tag 0 command 138 lba 0
# scsi_req_alloc target 0 lun 0 tag 0
# scsi_disk_new_request Command: lun=0 tag=0x0 data= 0x8a 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xfe 0x00 0x00
# scsi_disk_dma_command_WRITE Write (sector 0, count 254)
# scsi_req_continue target 0 lun 0 tag 0

I don't know how useful this trace is, but maybe we can provide it
alongside the reproducer that we commit to the repo. Maybe it could be
improved with better trace events. Just a suggestion if we want more
context around the raw qtest trace..

> > >
> > > This patch adds the issue LP#1878263 test case.
> > >
> > > Signed-off-by: Li Qiang <liq3ea@163.com>
> > > ---
> > >  tests/qtest/Makefile.include |  2 ++
> > >  tests/qtest/fuzz-test.c      | 45 ++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 47 insertions(+)
> > >  create mode 100644 tests/qtest/fuzz-test.c
> > >
> > > diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
> > > index b0204e44f2..ff460179c5 100644
> > > --- a/tests/qtest/Makefile.include
> > > +++ b/tests/qtest/Makefile.include
> > > @@ -7,6 +7,7 @@ check-qtest-generic-y += machine-none-test
> > >  check-qtest-generic-y += qmp-test
> > >  check-qtest-generic-y += qmp-cmd-test
> > >  check-qtest-generic-y += qom-test
> > > +check-qtest-generic-y += fuzz-test
> >
> > Maybe name that fuzzed-reproducers-test?
> >
> 
> This maybe be more understandable.
> 
> 
> >
> > >  check-qtest-generic-$(CONFIG_MODULES) += modules-test
> > >  check-qtest-generic-y += test-hmp
> > >
> > > @@ -272,6 +273,7 @@ tests/qtest/m25p80-test$(EXESUF):
> > tests/qtest/m25p80-test.o
> > >  tests/qtest/i440fx-test$(EXESUF): tests/qtest/i440fx-test.o
> > $(libqos-pc-obj-y)
> > >  tests/qtest/q35-test$(EXESUF): tests/qtest/q35-test.o $(libqos-pc-obj-y)
> > >  tests/qtest/fw_cfg-test$(EXESUF): tests/qtest/fw_cfg-test.o
> > $(libqos-pc-obj-y)
> > > +tests/qtest/fuzz-test$(EXESUF): tests/qtest/fuzz-test.o
> > $(libqos-pc-obj-y)
> > >  tests/qtest/rtl8139-test$(EXESUF): tests/qtest/rtl8139-test.o
> > $(libqos-pc-obj-y)
> > >  tests/qtest/pnv-xscom-test$(EXESUF): tests/qtest/pnv-xscom-test.o
> > >  tests/qtest/wdt_ib700-test$(EXESUF): tests/qtest/wdt_ib700-test.o
> > > diff --git a/tests/qtest/fuzz-test.c b/tests/qtest/fuzz-test.c
> > > new file mode 100644
> > > index 0000000000..695c6dffb9
> > > --- /dev/null
> > > +++ b/tests/qtest/fuzz-test.c
> > > @@ -0,0 +1,45 @@
> > > +/*
> > > + * QTest testcase for fuzz case
> > > + *
> > > + * Copyright (c) 2020 Li Qiang <liq3ea@gmail.com>
> > > + *
> > > + * This work is licensed under the terms of the GNU GPL, version 2 or
> > later.
> > > + * See the COPYING file in the top-level directory.
> > > + */
> > > +
> > > +
> > > +#include "qemu/osdep.h"
> > > +
> > > +#include "libqtest.h"
> > > +
> > > +/*
> > > + * This used to trigger the assert in scsi_dma_complete
> > > + * https://bugs.launchpad.net/qemu/+bug/1878263
> > > + */
> > > +static void test_megasas_zero_iov_cnt(void)
> >
> > I'd name it test_lp1878263_megasas_zero_iov_cnt()
> >
> 
> This seems better.
> 
> 
> > or lp1878263_megasas_zero_iov_cnt().
> 
> 
> 
> >
> > > +{
> > > +    QTestState *s;
> > > +
> > > +    s = qtest_init("-nographic -monitor none -serial none "
> > > +                   "-M q35 -device megasas -device scsi-cd,drive=null0 "
> > > +                   "-blockdev
> > driver=null-co,read-zeroes=on,node-name=null0");
> > > +    qtest_outl(s, 0xcf8, 0x80001818);
> > > +    qtest_outl(s, 0xcfc, 0xc101);
> > > +    qtest_outl(s, 0xcf8, 0x8000181c);
> > > +    qtest_outl(s, 0xcf8, 0x80001804);
> > > +    qtest_outw(s, 0xcfc, 0x7);
> > > +    qtest_outl(s, 0xcf8, 0x8000186a);
> > > +    qtest_writeb(s, 0x14, 0xfe);
> > > +    qtest_writeb(s, 0x0, 0x02);
> > > +    qtest_outb(s, 0xc1c0, 0x17);
> > > +    qtest_quit(s);
> >
> > Actually all the test body could be generated...
> 
> Alex, can you have a look at that?
> >

I think there are couple ways to approach this:
1. Parse the reproducer and generate C code from a reproducer trace. The
   result would be similar to Li's code.

Pros:
 * We get something that looks more-or-less like a normal qtest test.
Cons:
 * Need to automatically generate the C code.

2. Write a single C function that reads the command line args and raw
   qtest commands from a repro file and sends them to the qtest server.
   Roughly:

+++ /path/to/repros/i386/megasas-lp1878263.repro

cmd: -nographic -monitor none -serial none -M q35 -device megasas -device scsi-cd,drive=null0 -blockdev driver=null-co,read-zeroes=on,node-name=null0
# megasas_init Using 80 sges, 1000 cmds, raid mode
# scsi_device_set_ua target 0 lun 0 key 0x06 asc 0x29 ascq 0x00
# megasas_reset firmware state 0xb0000000
outl 0xcf8 0x80001818
outl 0xcfc 0xc101
....

The code would then roughly be
s = qtest_init(get_cmd_from_first_line())
while get_next_line() {
    if line doesnt start with "#":
        qtest_sendf(line)
}

..
qtest_add_data_func("fuzz/repro", "/path/to/megasas-lp1878263", run_reproducer);
qtest_add_data_func("fuzz/repro", "/path/to/another-repro", run_reproducer);
...

Pros:
 * Little post-processing required to go from a qtest repro trace to a
   test case
 * Simple to add a new test. Just create a repro file and add a new
   qtest_add_data_func
Cons:
 * I think this would require us to expose qtest_sendf
 * We might need a separate reproduce.c file for each arch/target for
   which we want to reproduce bugs

3. Same as 2. but do not use the libqtest client or modify qtest_sendf.
Use a python script to do the same thing.
Pros:
 * We don't need to expose qtest_sendf, if that is a problem
Cons:
 * We would need to integrate it into the build/test system

4. Use the original binary crashes and feed them into a softmmu/fuzz,
rather than a softmmu/all build.  As a result, we would have unreadable
binary files in the repo instead of slightly-more readable qtest traces.
Pros:
 * We would be able to test/reproduce issues such as double-fetches
   or other timing-sensitive problems that we cannot with a simple qtest
   trace.
Cons:
 * Now we have to build the fuzzer to run the tests and integrate that
   into the build system.
 * If we tweak the fuzzer, the binary inputs might break.

Thoughts about these approaches?

-Alex

> > > +}
> > > +
> > > +int main(int argc, char **argv)
> > > +{
> > > +    g_test_init(&argc, &argv, NULL);
> > > +
> > > +    qtest_add_func("fuzz/megasas_zero_iov_cnt",
> > test_megasas_zero_iov_cnt);
> > > +
> > > +    return g_test_run();
> >
> > The problem is now the test suite will fail because this test is not
> > fixed.
> >
> >
> Yes, as Paolo queued my patch to solve this:
> -->https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg03712.html
> 
> I think this patch should go Paolo's tree.
> 
> Thanks,
> Li Qiang
> 
> 
> > Good idea btw :)
> >
> > > +}
> > >
> >
> >


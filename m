Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841B0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E97F2084C
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E97F2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeIxa-0007Ns-Gi
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 09:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jeIwy-0006yL-AM
 for qemu-devel@nongnu.org; Thu, 28 May 2020 09:52:00 -0400
Received: from relay68.bu.edu ([128.197.228.73]:42164)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jeIww-0003gZ-ST
 for qemu-devel@nongnu.org; Thu, 28 May 2020 09:51:59 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 04SDpXGT018801
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 28 May 2020 09:51:37 -0400
Date: Thu, 28 May 2020 09:51:33 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 0/2] tests/qtest/fuzz: Avoid QTest serialization
Message-ID: <20200528135133.of4k5pyy3fhifw4s@mozz.bu.edu>
References: <20200526055820.12999-1-f4bug@amsat.org>
 <20200526085609.GA766304@stefanha-x1.localdomain>
 <0e3f6528-b26e-6b5b-be23-f7cf79c216f5@amsat.org>
 <20200526145632.65uxxj7qk2lrwxsv@mozz.bu.edu>
 <1e9429d6-7309-4f1e-4a72-6d4d28eea956@amsat.org>
 <20200526154146.of5jbenq7gduimx6@mozz.bu.edu>
 <90302b66-8512-3b3c-58db-9cdcd0049ed6@amsat.org>
 <bd0090dd-0a86-979d-9f43-2fe199fb9d28@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd0090dd-0a86-979d-9f43-2fe199fb9d28@amsat.org>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 09:51:56
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200528 1533, Philippe Mathieu-Daudé wrote:
> On 5/26/20 5:52 PM, Philippe Mathieu-Daudé wrote:
> > On 5/26/20 5:41 PM, Alexander Bulekov wrote:
> >> On 200526 1725, Philippe Mathieu-Daudé wrote:
> >>> On 5/26/20 4:56 PM, Alexander Bulekov wrote:
> >>>> On 200526 1105, Philippe Mathieu-Daudé wrote:
> >>>>> On 5/26/20 10:56 AM, Stefan Hajnoczi wrote:
> >>>>>> On Tue, May 26, 2020 at 07:58:18AM +0200, Philippe Mathieu-Daudé wrote:
> >>>>>>> Hi Alexander,
> >>>>>>>
> >>>>>>> I forgot to share these 2 patches wrote before
> >>>>>>> the direct MemoryRegion fuzzer sent yesterday.
> >>>>>>>
> >>>>>>> Regards,
> >>>>>>>
> >>>>>>> Phil.
> >>>>>>>
> >>>>>>> Philippe Mathieu-Daudé (2):
> >>>>>>>   tests/qtest/fuzz: Avoid QTest ioport serialization
> >>>>>>>   tests/qtest/fuzz: Avoid QTest mmio serialization
> >>>>>>>
> >>>>>>>  tests/qtest/fuzz/i440fx_fuzz.c      | 19 +++++++++++++------
> >>>>>>>  tests/qtest/fuzz/virtio_net_fuzz.c  |  6 ++++--
> >>>>>>>  tests/qtest/fuzz/virtio_scsi_fuzz.c |  6 +++++-
> >>>>>>>  3 files changed, 22 insertions(+), 9 deletions(-)
> >>>>>>
> >>>>>> Will it still be possible to print qtest reproducer commands when a
> >>>>>> crash is found?
> >>>>>
> >>>>> Yes, there is no change in the corpus format.
> >>>>
> >>>> Yes, though with these patches, the qtest-based code will be gone.
> >>>> Should there be some option to switch between the two modes?
> >>>
> >>> How so?
> >>>
> >>> How do you generate your reproducers?
> >>
> >> Right now basically with this:
> >>
> >> --- a/qtest.c
> >> +++ b/qtest.c
> >> @@ -808,6 +808,8 @@ bool qtest_driver(void)
> >>
> >>  void qtest_server_inproc_recv(void *dummy, const char *buf)
> >>  {
> >> +    // It would be nice to add support for qtest's built in qtest_log_fp.
> >> +    printf(">>> %s\n", buf);
> > 
> > Uh =) I suppose you restart a single job with the offending corpus file?
> > 
> >>      static GString *gstr;
> >>      if (!gstr) {
> >>          gstr = g_string_new(NULL);
> >> --
> >>
> >> It would be nice to add support for qtest's built in qtest_log_fp.
> >> Unless I'm missing something, these address_space_writes completely
> >> bypass qtest, so there has to be some additional step to build
> >> reproducers(eg running against the QTest-based version, or adding some
> >> way to spit out corresponding qtest commands for the
> >> address_space_writes).
> > 
> > I am using this hacky script, not committed yet because not ready but
> > still you can get the idea:
> > 
> > -- >8 --
> > import sys
> > import struct
> > 
> > # Tune to MemoryRegion properties
> > IOBASE = 0xa0002000
> > IOSIZE =     0x1000
> > 
> > action = { #           ASM        ADDR         VAL
> >     0x00: {'opcode': 'writeb', 'size': 8,  'fmt': 'B'},
> >     0x01: {'opcode': 'writew', 'size': 8,  'fmt': 'H'},
> >     0x02: {'opcode': 'writel', 'size': 8,  'fmt': 'I'},
> >     0x03: {'opcode': 'writeq', 'size': 8,  'fmt': 'L'},
> > 
> >     0x04: {'opcode': 'writeb', 'size': 16,  'fmt': 'B'},
> >     0x05: {'opcode': 'writew', 'size': 16,  'fmt': 'H'},
> >     0x06: {'opcode': 'writel', 'size': 16,  'fmt': 'I'},
> >     0x07: {'opcode': 'writeq', 'size': 16,  'fmt': 'L'},
> > 
> >     0x08: {'opcode': 'writeb', 'size': 32,  'fmt': 'B'},
> >     0x09: {'opcode': 'writew', 'size': 32,  'fmt': 'H'},
> >     0x0a: {'opcode': 'writel', 'size': 32,  'fmt': 'I'},
> >     0x0b: {'opcode': 'writeq', 'size': 32,  'fmt': 'L'},
> > 
> >     0x10: {'opcode': 'readb',  'size': 8,  'fmt': 'B'},
> >     0x11: {'opcode': 'readw',  'size': 8,  'fmt': 'H'},
> >     0x12: {'opcode': 'readl',  'size': 8,  'fmt': 'I'},
> >     0x13: {'opcode': 'readq',  'size': 8,  'fmt': 'L'},
> > 
> >     0x14: {'opcode': 'readb',  'size': 16,  'fmt': 'B'},
> >     0x15: {'opcode': 'readw',  'size': 16,  'fmt': 'H'},
> >     0x16: {'opcode': 'readl',  'size': 16,  'fmt': 'I'},
> >     0x17: {'opcode': 'readq',  'size': 16,  'fmt': 'L'},
> > 
> >     0x18: {'opcode': 'readb',  'size': 32,  'fmt': 'B'},
> >     0x19: {'opcode': 'readw',  'size': 32,  'fmt': 'H'},
> >     0x1a: {'opcode': 'readl',  'size': 32,  'fmt': 'I'},
> >     0x1b: {'opcode': 'readq',  'size': 32,  'fmt': 'L'},
> > }
> > AMASK = 0x1f
> > ADDR = {8: 'B', 16: 'H', 32: 'I', 64: 'L'}
> > 
> > def fuzz_parse_corpus_data(fn):
> >     fd = open(fn, 'rb')
> >     while True:
> >         buf = fd.read(1)
> >         if len(buf) < 1:
> >             break
> >         op, = struct.unpack("B", buf)
> >         op &= AMASK
> >         if op not in action:
> >             break
> >         a = action[op]
> >         fmt = "<" + ADDR[a['size']] + a['fmt']
> >         fmtsz = struct.calcsize(fmt)
> >         buf = fd.read(fmtsz)
> >         if len(buf) < fmtsz:
> >             break
> >         if a['fmt'] == 'x':
> >             addr, = struct.unpack(fmt, buf)
> >             val = 0
> >         else:
> >             addr, val = struct.unpack(fmt, buf)
> >         addr &= IOSIZE - 1
> >         print("%s 0x%02x 0x%x" % (a['opcode'], IOBASE + addr, val))
> > 
> > fuzz_parse_corpus_data(sys.argv[1])
> > ---
> > 
> > $ python tests/qtest/fuzz/corpus2qtest.py \
> >   ./crash-12e481ba7c2a7a625152dc701821d5e184cddee8
> > writel 0xa0002000 0x20010000
> > writeb 0xa0002020 0x20
> > readl 0xa0002100 0x204204ff
> > writeb 0xa0002042 0x36
> > readl 0xa0002436 0xf4760024
> > writel 0xa0002020 0x4363636
> > writeb 0xa0002600 0xf4
> > writew 0xa0002001 0x2020
> > writeb 0xa0002020 0x4
> > writel 0xa0002020 0x4363636
> > writeb 0xa0002600 0xf4
> > writel 0xa0002020 0x36363a01
> > readl 0xa0002404 0x1f47600
> > writew 0xa0002020 0x2020
> > writeb 0xa0002004 0x42
> > writeb 0xa0002036 0x36
> > readl 0xa0002404 0x42f47600
> > writeb 0xa0002036 0x36
> > readl 0xa0002404 0x1f47600
> > writew 0xa0002020 0x420
> 
> FYI talking with Stefan he kinda suggested it is cleaner to use a
> '-replay corpus_data.bin' mode that enables the printf output from
> qtest_*read/write (without reaching the device) rather than maintaining
> a Python script.

I think handling the QTEST_LOG=1 environment variable in
qtest_inproc_init would be a decent solution. Alternatively we could
have a -replay flag which just adds "-qtest-log /dev/fd/2" to the
qemu_main args. Writing scripts gets complicated for e.g. the
virtio-net-* fuzzers, where the input is converted into some high-level
libqos calls.
-Alex

> > 
> >>
> >>>>
> >>>>>>
> >>>>>> Other than this concern, higher fuzzing rates would be great.
> >>>>>
> >>>>> Thanks,
> >>>>>
> >>>>> Phil.
> >>>>
> >>
> > 


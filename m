Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA722C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 01:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B6E2078D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 01:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbsHIlw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B6E2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8ZIo-0000tg-G9
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 21:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k8ZI2-0000SC-V7
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 21:22:50 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k8ZI0-0001R5-He
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 21:22:50 -0400
Received: by mail-ot1-x343.google.com with SMTP id h16so204285oti.7
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 18:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CG80YzkZYb+WvTikTYC+LZou2FloMGL+03Mnw5WTs+g=;
 b=sbsHIlw4kDojUf1oJy+U8+bA5jZYFwbahV5r3z315vRlE46n5cHfHwBeB1QCAgdmj2
 2+GVcZaz2dCIpEx276ywdGI+9cKf3uDAJlOCY/vOKwCMnlVPRikXA+DsO5agmDVLMicB
 gRHmqLa9gFSD0XXcgIluZl7qY6z2lB1nzF8FyfFKimCUFbM/fJIVMAU0mg1LGMUKLC4+
 PNqGTLA8muT+JXKbMSXNQW9scWsR7UHaCMdwvHL5ueSmGakK3rMVcRKsK+ltC2dxgfMj
 Nf/uJ4BcHf1T3fKFtaPvWV/TVEVQFWsLiUQkBTthQ33wC+/Hjb43asiyz3Zuv+peljzt
 frxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CG80YzkZYb+WvTikTYC+LZou2FloMGL+03Mnw5WTs+g=;
 b=QYTcGQDP25tgevHzrFwDEs7Z2seUOowkKtbxji4C7Al0oNkXDqCeTFVTcxbTnXMP+C
 ZJs9xzWYH44+Hy9EfMrqRiRgZZrdyIvGUkIJ96ldDEBoYY5P/emmrC3VE5z1+Fc4WcHP
 leLUg5nOm4yKS4t+83CSEhJcwJrcJ1FVg/9YzZ2o5ZzYhZXFVXYBhGnleN/LjCb0wUPO
 vVelPQM3cdim54HhYooGlMeVc6IXCT1JhQ/fanxVl2No+6tOUPCaKX3SM57oXWTuIvVR
 xXJck0/RUCsEdsrhCqxE4WMqj+9l4HoSqTlqXT0wgXXXYgIX6jCbHeWflFc/OXvSxKb2
 me9A==
X-Gm-Message-State: AOAM533UG/tgVQULBv+JGA92/iqjPOUC7Zf9HSyc6WdYvzCSnBOGTxg6
 ndf2NPFsLxDIPgX2MLP+AMc0vPIQvAZTGJdlrdg=
X-Google-Smtp-Source: ABdhPJyzSi3qNG6aEXnyz/5xspgAt2SivYFFnF+qeKkXiX7XPVLOcEBW0RQHlSsdj3P4Lr3RZX5x+8vARFnXuRQqi6c=
X-Received: by 2002:a05:6830:796:: with SMTP id
 w22mr418862ots.353.1597886566759; 
 Wed, 19 Aug 2020 18:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200819141533.66354-1-liq3ea@163.com>
 <baabaa94-e4bf-3578-2f78-624704eb29c4@redhat.com>
 <CAKXe6S+Vpe5NH4j22deQLxZaX7NRFtwvGR0FhEoBPPNdK33ibQ@mail.gmail.com>
 <20200819162211.5z6blwmgy35mw6dk@mozz.bu.edu>
In-Reply-To: <20200819162211.5z6blwmgy35mw6dk@mozz.bu.edu>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 20 Aug 2020 09:22:10 +0800
Message-ID: <CAKXe6SLLa_ZG9GT=svbhWsNVE1xqrhfBgdNFJfQ9zS2N0kza8Q@mail.gmail.com>
Subject: Re: [PATCH] qtest: add fuzz test case
To: Alexander Bulekov <alxndr@bu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alexander Bulekov <alxndr@bu.edu> =E4=BA=8E2020=E5=B9=B48=E6=9C=8820=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:23=E5=86=99=E9=81=93=EF=BC=9A
>
> On 200819 2250, Li Qiang wrote:
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2020=E5=B9=B48=
=E6=9C=8819=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:38=E5=86=99=E9=
=81=93=EF=BC=9A
> >
> > > On 8/19/20 4:15 PM, Li Qiang wrote:
> > > > Currently the device fuzzer find a more and more issues.
> > > > For every fuzz case, we need not only the fixes but also
> > > > the coressponding test case. We can analysis the reproducer
> > >
> > > Typo "corresponding"
> > >
> >
> > Will correct in next revision.
> >
> >
> > >
> > > > for every case and find what happened in where and write
> > > > a beautiful test case. However the raw data of reproducer is not
> > > > friendly to analysis. It will take a very long time, even far more
> > > > than the fixes itself. So let's create a new file to hold all of
> > > > the fuzz test cases and just use the raw data to act as the test
> > > > case. This way nobody will be afraid of writing a test case for
> > > > the fuzz reproducer.
> > >
> > > Ahaha nice :)
> > >
>
> So the problem is that QOS isn't built out-enough for all of the devices
> that we want to test, and it would take a lot of time to translate the
> fuzzer-generated reproducer each time we want to add a test?


Yes

>
>
> If we want some context for the crashing trace, but cannot build out a
> full test, we could add trace events to the actual device code. This
> should be a small amount of work compared to building a full-fledged
> tests, but maybe I'm wrong.


The issue here is not find the context for crashing(which I think you
mean the root cause of crash?).
In fact we can easily point the root cause and find where is wrong in
most cases.
The issue here is that we construct a meaningful test-case from scratch.

Take this megasas as an example, I analysis the crash from where it
starts find find it is caused by considering
'iov_count=3D0' (megasas_map_sgl) success so megasas_handle_io will
continue process it and cause the assert
failure.

However when I try to construct a qtest case for this. I need to find
a code path to this function.

they are:
megasas_mmio_write->megasas_handle_frame->megasas_handle_io. In this
path, it does a lot of DMA map, so I
need to construct the data structure carefully, and also I should be
carefully to pass all the error check path.

Compared with the reproducer raw data, it just have a few lines, it
write to the northbridge port to reconfigure the megasas device
which I think we can't do this in a meaningful testcase.

So here the time costs is not getting context from reproducer raw
data. It is  constructing a meaningful test case.


>
>
> For the issue in question, there are already some trace points.
> If I run the repro with -trace 'pci*' -trace 'megasas*' -trace 'scsi*' :
> Reformat the trace somewhat and add some annotations for the data that
> comes from DMA:
>
> # megasas_init Using 80 sges, 1000 cmds, raid mode
> # scsi_device_set_ua target 0 lun 0 key 0x06 asc 0x29 ascq 0x00
> # megasas_reset firmware state 0xb0000000
> outl 0xcf8 0x80001818
> outl 0xcfc 0xc101
> # pci_cfg_write megasas 03:0 @0x18 <- 0xc101
> outl 0xcf8 0x8000181c
> outl 0xcf8 0x80001804
> outw 0xcfc 0x7
> # pci_cfg_write megasas 03:0 @0x4 <- 0x7
> # pci_update_mappings_add d=3D0x7fd3b8fbd800 00:03.0 2,0xc100+0x100
> outl 0xcf8 0x8000186a
> write 0x14 0x1 0xfe     # DMA Buffer
> write 0x0 0x1 0x02      # DMA Buffer
> outb 0xc1c0 0x17
> # megasas_mmio_writel reg MFI_IQPL: 0x17
> # megasas_qf_new frame 0x0 addr 0x0
> # megasas_qf_enqueue frame 0x0 count 11 context 0x0 head 0x0 tail 0x0 bus=
y 1
> #  LD Write dev 0/0 lba 0x0 count 254
> #  len 0 limit 520192
> # scsi_req_parsed target 0 lun 0 tag 0 command 138 dir 2 length 520192
> # scsi_req_parsed_lba target 0 lun 0 tag 0 command 138 lba 0
> # scsi_req_alloc target 0 lun 0 tag 0
> # scsi_disk_new_request Command: lun=3D0 tag=3D0x0 data=3D 0x8a 0x00 0x00=
 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xfe 0x00 0x00
> # scsi_disk_dma_command_WRITE Write (sector 0, count 254)
> # scsi_req_continue target 0 lun 0 tag 0
>
> I don't know how useful this trace is, but maybe we can provide it
> alongside the reproducer that we commit to the repo. Maybe it could be
> improved with better trace events. Just a suggestion if we want more
> context around the raw qtest trace..

I agree with Paolo this is useful adding this in the commit message.
It can be as a reference for the people want to investigate the issue.

>
> > > >
> > > > This patch adds the issue LP#1878263 test case.
> > > >
> > > > Signed-off-by: Li Qiang <liq3ea@163.com>
> > > > ---
> > > >  tests/qtest/Makefile.include |  2 ++
> > > >  tests/qtest/fuzz-test.c      | 45 ++++++++++++++++++++++++++++++++=
++++
> > > >  2 files changed, 47 insertions(+)
> > > >  create mode 100644 tests/qtest/fuzz-test.c
> > > >
> > > > diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.in=
clude
> > > > index b0204e44f2..ff460179c5 100644
> > > > --- a/tests/qtest/Makefile.include
> > > > +++ b/tests/qtest/Makefile.include
> > > > @@ -7,6 +7,7 @@ check-qtest-generic-y +=3D machine-none-test
> > > >  check-qtest-generic-y +=3D qmp-test
> > > >  check-qtest-generic-y +=3D qmp-cmd-test
> > > >  check-qtest-generic-y +=3D qom-test
> > > > +check-qtest-generic-y +=3D fuzz-test
> > >
> > > Maybe name that fuzzed-reproducers-test?
> > >
> >
> > This maybe be more understandable.
> >
> >
> > >
> > > >  check-qtest-generic-$(CONFIG_MODULES) +=3D modules-test
> > > >  check-qtest-generic-y +=3D test-hmp
> > > >
> > > > @@ -272,6 +273,7 @@ tests/qtest/m25p80-test$(EXESUF):
> > > tests/qtest/m25p80-test.o
> > > >  tests/qtest/i440fx-test$(EXESUF): tests/qtest/i440fx-test.o
> > > $(libqos-pc-obj-y)
> > > >  tests/qtest/q35-test$(EXESUF): tests/qtest/q35-test.o $(libqos-pc-=
obj-y)
> > > >  tests/qtest/fw_cfg-test$(EXESUF): tests/qtest/fw_cfg-test.o
> > > $(libqos-pc-obj-y)
> > > > +tests/qtest/fuzz-test$(EXESUF): tests/qtest/fuzz-test.o
> > > $(libqos-pc-obj-y)
> > > >  tests/qtest/rtl8139-test$(EXESUF): tests/qtest/rtl8139-test.o
> > > $(libqos-pc-obj-y)
> > > >  tests/qtest/pnv-xscom-test$(EXESUF): tests/qtest/pnv-xscom-test.o
> > > >  tests/qtest/wdt_ib700-test$(EXESUF): tests/qtest/wdt_ib700-test.o
> > > > diff --git a/tests/qtest/fuzz-test.c b/tests/qtest/fuzz-test.c
> > > > new file mode 100644
> > > > index 0000000000..695c6dffb9
> > > > --- /dev/null
> > > > +++ b/tests/qtest/fuzz-test.c
> > > > @@ -0,0 +1,45 @@
> > > > +/*
> > > > + * QTest testcase for fuzz case
> > > > + *
> > > > + * Copyright (c) 2020 Li Qiang <liq3ea@gmail.com>
> > > > + *
> > > > + * This work is licensed under the terms of the GNU GPL, version 2=
 or
> > > later.
> > > > + * See the COPYING file in the top-level directory.
> > > > + */
> > > > +
> > > > +
> > > > +#include "qemu/osdep.h"
> > > > +
> > > > +#include "libqtest.h"
> > > > +
> > > > +/*
> > > > + * This used to trigger the assert in scsi_dma_complete
> > > > + * https://bugs.launchpad.net/qemu/+bug/1878263
> > > > + */
> > > > +static void test_megasas_zero_iov_cnt(void)
> > >
> > > I'd name it test_lp1878263_megasas_zero_iov_cnt()
> > >
> >
> > This seems better.
> >
> >
> > > or lp1878263_megasas_zero_iov_cnt().
> >
> >
> >
> > >
> > > > +{
> > > > +    QTestState *s;
> > > > +
> > > > +    s =3D qtest_init("-nographic -monitor none -serial none "
> > > > +                   "-M q35 -device megasas -device scsi-cd,drive=
=3Dnull0 "
> > > > +                   "-blockdev
> > > driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull0");
> > > > +    qtest_outl(s, 0xcf8, 0x80001818);
> > > > +    qtest_outl(s, 0xcfc, 0xc101);
> > > > +    qtest_outl(s, 0xcf8, 0x8000181c);
> > > > +    qtest_outl(s, 0xcf8, 0x80001804);
> > > > +    qtest_outw(s, 0xcfc, 0x7);
> > > > +    qtest_outl(s, 0xcf8, 0x8000186a);
> > > > +    qtest_writeb(s, 0x14, 0xfe);
> > > > +    qtest_writeb(s, 0x0, 0x02);
> > > > +    qtest_outb(s, 0xc1c0, 0x17);
> > > > +    qtest_quit(s);
> > >
> > > Actually all the test body could be generated...
> >
> > Alex, can you have a look at that?
> > >
>
> I think there are couple ways to approach this:
> 1. Parse the reproducer and generate C code from a reproducer trace. The
>    result would be similar to Li's code.
>

I prefer this one.
The reproducer just target one platform. So we need to decide it is a
generic qtest case
or just an arch-related test case. For example, this megasas
reproducer is in i386 platform.
But it is a generic qtest case.


> Pros:
>  * We get something that looks more-or-less like a normal qtest test.
> Cons:
>  * Need to automatically generate the C code.

Yes, maybe we contain the raw data in the test case function body.
And in runtime it automatically change to C code?
Not have many idea here.


>
> 2. Write a single C function that reads the command line args and raw
>    qtest commands from a repro file and sends them to the qtest server.
>    Roughly:
>
> +++ /path/to/repros/i386/megasas-lp1878263.repro
>
> cmd: -nographic -monitor none -serial none -M q35 -device megasas -device=
 scsi-cd,drive=3Dnull0 -blockdev driver=3Dnull-co,read-zeroes=3Don,node-nam=
e=3Dnull0
> # megasas_init Using 80 sges, 1000 cmds, raid mode
> # scsi_device_set_ua target 0 lun 0 key 0x06 asc 0x29 ascq 0x00
> # megasas_reset firmware state 0xb0000000
> outl 0xcf8 0x80001818
> outl 0xcfc 0xc101
> ....
>
> The code would then roughly be
> s =3D qtest_init(get_cmd_from_first_line())
> while get_next_line() {
>     if line doesnt start with "#":
>         qtest_sendf(line)
> }
>
> ..
> qtest_add_data_func("fuzz/repro", "/path/to/megasas-lp1878263", run_repro=
ducer);
> qtest_add_data_func("fuzz/repro", "/path/to/another-repro", run_reproduce=
r);
> ...
>
> Pros:
>  * Little post-processing required to go from a qtest repro trace to a
>    test case
>  * Simple to add a new test. Just create a repro file and add a new
>    qtest_add_data_func
> Cons:
>  * I think this would require us to expose qtest_sendf
>  * We might need a separate reproduce.c file for each arch/target for
>    which we want to reproduce bugs
>

The three approaches just let test the case in one platform.

Thanks,
Li Qiang


> 3. Same as 2. but do not use the libqtest client or modify qtest_sendf.
> Use a python script to do the same thing.
> Pros:
>  * We don't need to expose qtest_sendf, if that is a problem
> Cons:
>  * We would need to integrate it into the build/test system
>
> 4. Use the original binary crashes and feed them into a softmmu/fuzz,
> rather than a softmmu/all build.  As a result, we would have unreadable
> binary files in the repo instead of slightly-more readable qtest traces.
> Pros:
>  * We would be able to test/reproduce issues such as double-fetches
>    or other timing-sensitive problems that we cannot with a simple qtest
>    trace.
> Cons:
>  * Now we have to build the fuzzer to run the tests and integrate that
>    into the build system.
>  * If we tweak the fuzzer, the binary inputs might break.
>
> Thoughts about these approaches?
>
> -Alex
>
> > > > +}
> > > > +
> > > > +int main(int argc, char **argv)
> > > > +{
> > > > +    g_test_init(&argc, &argv, NULL);
> > > > +
> > > > +    qtest_add_func("fuzz/megasas_zero_iov_cnt",
> > > test_megasas_zero_iov_cnt);
> > > > +
> > > > +    return g_test_run();
> > >
> > > The problem is now the test suite will fail because this test is not
> > > fixed.
> > >
> > >
> > Yes, as Paolo queued my patch to solve this:
> > -->https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg03712.html
> >
> > I think this patch should go Paolo's tree.
> >
> > Thanks,
> > Li Qiang
> >
> >
> > > Good idea btw :)
> > >
> > > > +}
> > > >
> > >
> > >


Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B9CC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8A12076A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Rs4IZq5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8A12076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY8K6-0001zh-IS
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 09:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kY8IS-0000jZ-DG
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:48:57 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:40407)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kY8IP-0000x2-FK
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=LpjsdHDLR29xl1lw0XFiCPIfJwb5q3lMsr65BznsdpM=; b=Rs4IZq5I5BkG1MwynmtJiEUfGl
 quA4ezV85kn6PcFAvhmrb1gol2EbIq1ZzhpxM3fkdXPCZQu0CU3DbF/13TPdWnLYnbJKxGb7QuN7B
 6qLGBcJrlOWX7+td32nhyFKOgADDJaLMEi3xb5aiddRwWQrxuwOmiiJKu8EFTOXAmKmvSU0oT6Xjj
 lr8pFzqY8t12RhOlZgJWELtTwiZv6Q8uqcVvzgrbskkazh9LqPpvhlY5oxIZ3eiYO+htgTrT5ccxj
 oq7zwV2LzkE7tGFiEJEMM3qJiBtfSFYJ3+FO8akf3zLdC820NhaUPFFwfCiliANVA3KaPUJ+2Pu4c
 Y3by7nXA==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>
Subject: Re: [PULL 00/13] 9p queue 2020-10-23
Date: Thu, 29 Oct 2020 14:48:49 +0100
Message-ID: <3097828.JvSkC2jeLF@silver>
In-Reply-To: <CAFEAcA_qsZ1ZT-hk5wJc1Mz97vzo3N+UisK7XBagG5S1GtjqoA@mail.gmail.com>
References: <cover.1603452058.git.qemu_oss@crudebyte.com>
 <2016477.jJ6Bm08OSA@silver>
 <CAFEAcA_qsZ1ZT-hk5wJc1Mz97vzo3N+UisK7XBagG5S1GtjqoA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 08:52:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 29. Oktober 2020 14:20:11 CET Peter Maydell wrote:
> On Mon, 26 Oct 2020 at 12:48, Christian Schoenebeck
> 
> <qemu_oss@crudebyte.com> wrote:
> > On Montag, 26. Oktober 2020 11:33:42 CET Peter Maydell wrote:
> > > I get a 'make check' failure on x86-64 Linux host:
> > > 
> > > PASS 54 qtest-x86_64: qos-test
> > > /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/vir
> > > tio- 9p-tests/local/config PASS 55 qtest-x86_64: qos-test
> > > /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/vir
> > > tio- 9p-tests/local/create_dir PASS 56 qtest-x86_64: qos-test
> > > /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/vir
> > > tio- 9p-tests/local/unlinkat_dir PASS 57 qtest-x86_64: qos-test
> > > /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/vir
> > > tio- 9p-tests/local/create_file PASS 58 qtest-x86_64: qos-test
> > > /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/vir
> > > tio- 9p-tests/local/unlinkat_file PASS 59 qtest-x86_64: qos-test
> > > /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/vir
> > > tio- 9p-tests/local/symlink_file Received response 7 (RLERROR) instead
> > > of 73 (RMKDIR)
> > > Rlerror has errno 2 (No such file or directory)
> > > **
> > > ERROR:../../tests/qtest/virtio-9p-test.c:300:v9fs_req_recv: assertion
> > > failed (hdr.id == id): (7 == 73)
> > > ERROR qtest-x86_64: qos-test - Bail out!
> > > ERROR:../../tests/qtest/virtio-9ptest.c:300:v9fs_req_recv: assertion
> > > failed (hdr.id == id): (7 == 73)
> > > Makefile.mtest:3953: recipe for target 'run-test-492' failed
> 
> I just got this again on an entirely different pullreq so that
> suggests that this is indeed an intermittent currently in master:
> 
> PASS 49 qtest-i386/qos-test
> /i386/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p
> -tests/synth/flush/ignored PASS 50 qtest-i386/qos-test
> /i386/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p
> -tests/synth/readdir/basic PASS 51 qtest-i386/qos-test
> /i386/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p
> -tests/synth/readdir/split_512 PASS 52 qtest-i386/qos-test
> /i386/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p
> -tests/synth/readdir/split_256 PASS 53 qtest-i386/qos-test
> /i386/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p
> -tests/synth/readdir/split_128 PASS 54 qtest-i386/qos-test
> /i386/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p
> -tests/local/config Received response 7 (RLERROR) instead of 73 (RMKDIR)
> Rlerror has errno 2 (No such file or directory)
> **
> ERROR:../../tests/qtest/virtio-9p-test.c:296:v9fs_req_recv: assertion
> failed (hdr.id == id): (7 == 73)
> ERROR qtest-i386/qos-test - Bail out!
> ERROR:../../tests/qtest/virtio-9p-test.c:296:v9fs_req_recv: assertion
> failed (hdr.id == id): (7 == 73)
> Makefile.mtest:1857: recipe for target 'run-test-230' failed
> 
> > So the 9p server is already failing to create the test case directory
> > "./qtest-9p-local/05/" relative to your current working directory.
> 
> This sounds suspicious, because there's nothing in that filename
> that's specific to the test case being qtest-i386 and not
> qtest-something-else. How does the test harness deal with the
> possibility of the same virtio-9p-pci test being run in parallel
> for multiple guest architectures under a make -jN setup ?

Aaaaah, now there we go!

I was actually running the tests for 2 days and >3000 test suite runs now 
without a single 9p test failure, but ... not for multiple architectures 
simultaniously.

Another point for centralizing test dir locations in future.

> 
> > What puzzles me is that the previous test cases succeeded there, which all
> > 
> > create their own test directory in the same way:
> >         ./qtest-9p-local/01/
> >         ./qtest-9p-local/02/  (<-- dir vanishes after that test completed)
> >         ./qtest-9p-local/03/
> >         ./qtest-9p-local/04/
> >         ...
> 
> After the build failed, the qtest-9p-local directory was empty.

Yes, that suggests a parallel test suite was wiping the test directory
'./qtest-9p-local'.

So I'll append the architecture to the test dir location. To nail it this 
time, anyting else that would come to your mind regarding test dirs?

> 
> thanks
> -- PMM

Best regards,
Christian Schoenebeck




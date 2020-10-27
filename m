Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7AFC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B6C20747
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGIhY1yV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B6C20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXKyH-0005SX-FX
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 05:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kXKwd-0004tr-Mr
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:07:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kXKwa-00075K-4V
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603789622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+VuVC1c/5rub2sqZXTt9V5g4hs/E8LRR/WVy4wM+zhI=;
 b=OGIhY1yVIUK5W7pxLSmSr4lftGaYlu0wwsLDP3HZJNsb1hcNJM96V3GpkxYiRmkAaysqES
 gvXL61eala6mlIv3SEIFtosXbMfE2kD1Eq6OKnrahLpdmdAMknpNLQoqGEulK8VTVuw2Hd
 n9bt2gzY3ouljzBQmlND4u+YQCraJbA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-17fYU8qRNwOAJGDxukr5LQ-1; Tue, 27 Oct 2020 05:06:58 -0400
X-MC-Unique: 17fYU8qRNwOAJGDxukr5LQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BD31108E1A1;
 Tue, 27 Oct 2020 09:06:57 +0000 (UTC)
Received: from work-vm (ovpn-115-62.ams2.redhat.com [10.36.115.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9342510013C4;
 Tue, 27 Oct 2020 09:06:55 +0000 (UTC)
Date: Tue, 27 Oct 2020 09:06:53 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PULL 00/13] 9p queue 2020-10-23
Message-ID: <20201027090653.GA3369@work-vm>
References: <cover.1603452058.git.qemu_oss@crudebyte.com>
 <CAFEAcA_Pd2PQd097tSHABR=jFK-Rq6odkZXEC2V2DBHrh8pSXg@mail.gmail.com>
 <2016477.jJ6Bm08OSA@silver> <20201026222537.61ac2ad8@bahia.lan>
MIME-Version: 1.0
In-Reply-To: <20201026222537.61ac2ad8@bahia.lan>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Greg Kurz (groug@kaod.org) wrote:
> On Mon, 26 Oct 2020 13:48:37 +0100
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> 
> > On Montag, 26. Oktober 2020 11:33:42 CET Peter Maydell wrote:
> > > On Fri, 23 Oct 2020 at 12:46, Christian Schoenebeck
> > > 
> > > <qemu_oss@crudebyte.com> wrote:
> > > > The following changes since commit 4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430:
> > > >   Merge remote-tracking branch
> > > >   'remotes/kraxel/tags/modules-20201022-pull-request' into staging
> > > >   (2020-10-22 12:33:21 +0100)> 
> > > > are available in the Git repository at:
> > > >   https://github.com/cschoenebeck/qemu.git tags/pull-9p-20201023
> > > > 
> > > > for you to fetch changes up to ee01926a11b1f9bffcd6cdec0961dd9d1882da71:
> > > >   tests/9pfs: add local Tunlinkat hard link test (2020-10-22 20:26:33
> > > >   +0200)
> > > > 
> > > > ----------------------------------------------------------------
> > > > 9pfs: more tests using local fs driver
> > > > 
> > > > Only 9pfs test case changes this time:
> > > > 
> > > > * Refactor: Rename functions to make top-level test functions fs_*()
> > > > 
> > > >   easily distinguishable from utility test functions do_*().
> > > > 
> > > > * Refactor: Drop unnecessary function arguments in utility test
> > > > 
> > > >   functions.
> > > > 
> > > > * More test cases using the 9pfs 'local' filesystem driver backend,
> > > > 
> > > >   namely for the following 9p requests: Tunlinkat, Tlcreate, Tsymlink
> > > >   and Tlink.
> > > > 
> > > > ----------------------------------------------------------------
> > > 
> > > I get a 'make check' failure on x86-64 Linux host:
> > > 
> > > PASS 54 qtest-x86_64: qos-test
> > > /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-
> > > 9p-tests/local/config PASS 55 qtest-x86_64: qos-test
> > > /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-
> > > 9p-tests/local/create_dir PASS 56 qtest-x86_64: qos-test
> > > /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-
> > > 9p-tests/local/unlinkat_dir PASS 57 qtest-x86_64: qos-test
> > > /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-
> > > 9p-tests/local/create_file PASS 58 qtest-x86_64: qos-test
> > > /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-
> > > 9p-tests/local/unlinkat_file PASS 59 qtest-x86_64: qos-test
> > > /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-
> > > 9p-tests/local/symlink_file Received response 7 (RLERROR) instead of 73
> > > (RMKDIR)
> > > Rlerror has errno 2 (No such file or directory)
> > > **
> > > ERROR:../../tests/qtest/virtio-9p-test.c:300:v9fs_req_recv: assertion
> > > failed (hdr.id == id): (7 == 73)
> 
> Not sure this is related to this PR actually. Dave Gilbert reported on irc that
> he encountered a similar issue with 'make -j check', likely without these patches.

I was running on current master as of yesterday; no 9p specific patches.

Dave

> > > ERROR qtest-x86_64: qos-test - Bail out!
> > > ERROR:../../tests/qtest/virtio-9ptest.c:300:v9fs_req_recv: assertion
> > > failed (hdr.id == id): (7 == 73)
> > > Makefile.mtest:3953: recipe for target 'run-test-492' failed
> > > 
> > > 
> > > thanks
> > > -- PMM
> > 
> > So the 9p server is already failing to create the test case directory
> > "./qtest-9p-local/05/" relative to your current working directory.
> > 
> > I would appreciate to get more info when you have some free cycles, as I'm
> > unable to reproduce this on any system unfortunately. But no hurry as
> > these tests only become relevant actually for QEMU 6.
> > 
> > What puzzles me is that the previous test cases succeeded there, which all
> > create their own test directory in the same way:
> > 
> > 	./qtest-9p-local/01/
> > 	./qtest-9p-local/02/  (<-- dir vanishes after that test completed)
> > 	./qtest-9p-local/03/
> > 	./qtest-9p-local/04/
> > 	...
> > 
> > How does the "./qtest-9p-local/" directory look like after that
> > "local/symlink_file" test failed there? You can use this shortcut:
> > 
> > export QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
> > cd build
> > tests/qtest/qos-test --verbose
> > ls -l qtest-9p-local
> > 
> > That latter qos-test run will also output the assembled qemu command
> > line the 9p local tests would run with, which might also be helpful,
> > e.g. the relevant output would be something like this:
> > 
> > GTest: run: /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/local/config
> > (MSG: starting QEMU: exec x86_64-softmmu/qemu-system-x86_64 -qtest unix:/tmp/qtest-7428.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-7428.qmp,id=char0 -mon chardev=char0,mode=control -display none -M pc  -fsdev local,id=fsdev0,path='/home/me/git/qemu/build/qtest-9p-local',security_model=mapped-xattr -device virtio-9p-pci,fsdev=fsdev0,addr=04.0,mount_tag=qtest -accel qtest)
> > 
> > Would probably the test succeed if run alone?
> > 
> > tests/qtest/qos-test -p /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/local/symlink_file
> > 
> > Best regards,
> > Christian Schoenebeck
> > 
> > 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82C2C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:44:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02AA52223C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aiomzt2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AA52223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZXKC-00020X-0f
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 05:44:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZXJF-0001Ss-Ak
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 05:43:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30464)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZXJC-00019e-VA
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 05:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604313809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KnBbXX1FiGElHZi7lHzn2stXpoMtV7HevrPFjZmAE9Q=;
 b=Aiomzt2S2wvdEFWMhhIH4s6gPDA8zxvlwRwEM5b7t1OlSZaK9uqxa88QDTiw3uVAxeaPUx
 /82Nqazi8oGfWbf5RxQZxWt647Y9P/Ge+ey+7eZ9Vz2CvjCJesaiVSProzIDOxNf4VSn47
 afa7RP4x73l6oDBzrN0PrSCksIsnLDM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-9K4Sr_XnOu-7nrt2GDuWwg-1; Mon, 02 Nov 2020 05:43:27 -0500
X-MC-Unique: 9K4Sr_XnOu-7nrt2GDuWwg-1
Received: by mail-wr1-f71.google.com with SMTP id t17so6284572wrm.13
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 02:43:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KnBbXX1FiGElHZi7lHzn2stXpoMtV7HevrPFjZmAE9Q=;
 b=ML8WH2d1xkAnbTpvu+t+XPF6vKskcfKiNspahXqUdv7hVA6eWLOf3A2TKlbtVYeYf6
 HUoZzYYoxMh6bluFgTECLGWXEgfZNwdAA3TNSVE+ZzRWyXpjyQF8UGkT8uD/z0Fu2zJ5
 w493YHxx4FofNIX3t0Me4S6vN+6CZ4WS5DH427ffI+l9NaeVvu/n1do184sO+WLTx1Ln
 Kg4RQj6JFOhWvSMyIOdmt1fz7yefuFo31Et9LrtfCUdL21bZ6/RW6KbDz0pSWZtslfgC
 9+BEYVK5d83NQe1LUawB8jbFWBVb1KvR+wLLu3xODKmtpeie9qqMSBhboHnkmCnoQ+iJ
 yyRg==
X-Gm-Message-State: AOAM5323u2mLkelu6gt35G1i5h/hLA3CPKQnS8u6jLDI0zNgkcAl5fZS
 QSW+fsIKvs3e5jUcOrziGBqzmNbjorHj5xcwzc9Wfszazj8B1PGgbBxmbDslftlxc/WqljRtfVO
 cppENadrqYXhIKfY=
X-Received: by 2002:a1c:5a06:: with SMTP id o6mr17503756wmb.181.1604313806136; 
 Mon, 02 Nov 2020 02:43:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhOHDj8pqtfaxbKCtL1lW63HTKM8S6xAl36jKfRIE4XZM8egD7KWCbJcfGVUDahuoLrU7uAg==
X-Received: by 2002:a1c:5a06:: with SMTP id o6mr17503723wmb.181.1604313805875; 
 Mon, 02 Nov 2020 02:43:25 -0800 (PST)
Received: from redhat.com (bzq-79-182-97-190.red.bezeqint.net. [79.182.97.190])
 by smtp.gmail.com with ESMTPSA id n6sm21501063wrj.60.2020.11.02.02.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 02:43:25 -0800 (PST)
Date: Mon, 2 Nov 2020 05:43:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 00/12] block/export: vhost-user-blk server cleanups and
 tests
Message-ID: <20201102054252-mutt-send-email-mst@kernel.org>
References: <20201027173528.213464-1-stefanha@redhat.com>
 <20201030084155-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20201030084155-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Coiby Xu <Coiby.Xu@gmail.com>, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 30, 2020 at 08:42:22AM -0400, Michael S. Tsirkin wrote:
> On Tue, Oct 27, 2020 at 05:35:16PM +0000, Stefan Hajnoczi wrote:
> > This patch series solves some issues with the new vhost-user-blk-server and
> > adds the qtest test case. The test case was not included in the pull request
> > that introduced the vhost-user-blk server because of reliability issues that
> > are fixed in this patch series.
> 
> 
> Fails make check for me:
> 
> Running test qtest-i386/qos-test
> Broken pipe
> ../qemu/tests/qtest/libqtest.c:161: kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)
> ERROR qtest-i386/qos-test - too few tests run (expected 92, got 65)
> make: *** [Makefile.mtest:1857: run-test-230] Error 1

And here's the coredump:



[mst@tuck qemu-oot]$ coredumpctl  debug 853792
           PID: 853792 (qemu-system-i38)
           UID: 1000 (mst)
           GID: 1000 (mst)
        Signal: 11 (SEGV)
     Timestamp: Fri 2020-10-30 08:41:31 EDT (2 days ago)
  Command Line: ./qemu-system-i386 -qtest unix:/tmp/qtest-853536.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-853536.qmp,id=char0 -mon chardev=char0,mode=control -display none -M pc -device vhost-user-blk-pci,id=drv0,chardev=char1,addr=4.0 -object memory-backend-memfd,id=mem,size=256M,share=on -M memory-backend=mem -chardev socket,id=char1,path=/tmp/qtest-853536-sock.krlJyA -accel qtest
    Executable: /scm/qemu-oot/qemu-system-i386
 Control Group: /user.slice/user-1000.slice/session-4.scope
          Unit: session-4.scope
         Slice: user-1000.slice
       Session: 4
     Owner UID: 1000 (mst)
       Boot ID: 978b4cacb2df46319a9c6310b653f95d
    Machine ID: 6234c9d2c9c34980ad6b1b2de307f043
      Hostname: tuck.redhat.com
       Storage: /var/lib/systemd/coredump/core.qemu-system-i38.1000.978b4cacb2df46319a9c6310b653f95d.853792.1604061691000000.lz4
       Message: Process 853792 (qemu-system-i38) of user 1000 dumped core.
                
                Stack trace of thread 853792:
                #0  0x000055b2ace9ca0b vhost_dev_has_iommu (qemu-system-i386 + 0x657a0b)
                #1  0x000055b2ace9fbbf vhost_dev_prepare_inflight (qemu-system-i386 + 0x65abbf)
                #2  0x000055b2ace51d01 vhost_user_blk_start (qemu-system-i386 + 0x60cd01)
                #3  0x000055b2ace51f1a vhost_user_blk_set_status (qemu-system-i386 + 0x60cf1a)
                #4  0x000055b2acde489b virtio_set_status (qemu-system-i386 + 0x59f89b)
                #5  0x000055b2acb38638 virtio_pci_common_write (qemu-system-i386 + 0x2f3638)
                #6  0x000055b2ace4818c memory_region_write_accessor (qemu-system-i386 + 0x60318c)
                #7  0x000055b2ace46cae access_with_adjusted_size (qemu-system-i386 + 0x601cae)
                #8  0x000055b2ace4a4c3 memory_region_dispatch_write (qemu-system-i386 + 0x6054c3)
                #9  0x000055b2ace72010 flatview_write_continue (qemu-system-i386 + 0x62d010)
                #10 0x000055b2ace74fc5 flatview_write (qemu-system-i386 + 0x62ffc5)
                #11 0x000055b2acdc0981 qtest_process_command (qemu-system-i386 + 0x57b981)
                #12 0x000055b2acdc111d qtest_process_inbuf (qemu-system-i386 + 0x57c11d)
                #13 0x000055b2acf7092e tcp_chr_read (qemu-system-i386 + 0x72b92e)
                #14 0x00007f0554a5f78f g_main_context_dispatch (libglib-2.0.so.0 + 0x5278f)
                #15 0x000055b2acfbbed8 glib_pollfds_poll (qemu-system-i386 + 0x776ed8)
                #16 0x000055b2acdccbf2 qemu_main_loop (qemu-system-i386 + 0x587bf2)
                #17 0x000055b2acb0a5be main (qemu-system-i386 + 0x2c55be)
                #18 0x00007f0553000042 __libc_start_main (libc.so.6 + 0x27042)
                #19 0x000055b2acb0e97e _start (qemu-system-i386 + 0x2c997e)
                
                Stack trace of thread 853794:
                #0  0x00007f05530a1801 clock_nanosleep@@GLIBC_2.17 (libc.so.6 + 0xc8801)
                #1  0x00007f05530a7157 __nanosleep (libc.so.6 + 0xce157)
                #2  0x00007f0554a8b2d7 g_usleep (libglib-2.0.so.0 + 0x7e2d7)
                #3  0x000055b2acfbfa9a call_rcu_thread (qemu-system-i386 + 0x77aa9a)
                #4  0x000055b2acfd1cb9 qemu_thread_start (qemu-system-i386 + 0x78ccb9)
                #5  0x00007f05531ac432 start_thread (libpthread.so.0 + 0x9432)
                #6  0x00007f05530da913 __clone (libc.so.6 + 0x101913)
                
                Stack trace of thread 853796:
                #0  0x00007f0553016962 __sigtimedwait (libc.so.6 + 0x3d962)
                #1  0x00007f05531b75bc sigwait (libpthread.so.0 + 0x145bc)
                #2  0x000055b2ace8c223 dummy_cpu_thread_fn (qemu-system-i386 + 0x647223)
                #3  0x000055b2acfd1cb9 qemu_thread_start (qemu-system-i386 + 0x78ccb9)
                #4  0x00007f05531ac432 start_thread (libpthread.so.0 + 0x9432)
                #5  0x00007f05530da913 __clone (libc.so.6 + 0x101913)
                
                Stack trace of thread 853795:
                #0  0x00007f05530cfaaf __poll (libc.so.6 + 0xf6aaf)
                #1  0x00007f0554a5faae g_main_context_iterate.constprop.0 (libglib-2.0.so.0 + 0x52aae)
                #2  0x00007f0554a5fe33 g_main_loop_run (libglib-2.0.so.0 + 0x52e33)
                #3  0x000055b2acedcd01 iothread_run (qemu-system-i386 + 0x697d01)
                #4  0x000055b2acfd1cb9 qemu_thread_start (qemu-system-i386 + 0x78ccb9)
                #5  0x00007f05531ac432 start_thread (libpthread.so.0 + 0x9432)
                #6  0x00007f05530da913 __clone (libc.so.6 + 0x101913)

GNU gdb (GDB) Fedora 9.1-6.fc32
Copyright (C) 2020 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-redhat-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from /scm/qemu-oot/qemu-system-i386...

warning: core file may not match specified executable file.
[New LWP 853792]
[New LWP 853794]
[New LWP 853796]
[New LWP 853795]
Core was generated by `./qemu-system-i386 -qtest unix:/tmp/qtest-853536.sock -qtest-log /dev/null -cha'.
Program terminated with signal SIGSEGV, Segmentation fault.
#0  0x000055b2ace9ca0b in ?? ()
[Current thread is 1 (LWP 853792)]
warning: File "/scm/qemu/.gdbinit" auto-loading has been declined by your `auto-load safe-path' set to "$debugdir:$datadir/auto-load:/usr/lib/golang/src/runtime/runtime-gdb.py".
To enable execution of this file add
        add-auto-load-safe-path /scm/qemu/.gdbinit
line to your configuration file "/home/mst/.gdbinit".
To completely disable this security protection add
        set auto-load safe-path /
line to your configuration file "/home/mst/.gdbinit".
For more information about this security protection see the
"Auto-loading safe path" section in the GDB manual.  E.g., run from the shell:
        info "(gdb)Auto-loading safe path"


> 
> > Coiby Xu (1):
> >   test: new qTest case to test the vhost-user-blk-server
> > 
> > Stefan Hajnoczi (11):
> >   libvhost-user: follow QEMU comment style
> >   configure: introduce --enable-vhost-user-blk-server
> >   block/export: make vhost-user-blk config space little-endian
> >   block/export: fix vhost-user-blk get_config() information leak
> >   contrib/vhost-user-blk: fix get_config() information leak
> >   tests/qtest: add multi-queue test case to vhost-user-blk-test
> >   libqtest: add qtest_socket_server()
> >   vhost-user-blk-test: rename destroy_drive() to destroy_file()
> >   vhost-user-blk-test: close fork child file descriptors
> >   vhost-user-blk-test: drop unused return value
> >   vhost-user-blk-test: fix races by using fd passing
> > 
> >  configure                               |  15 +
> >  contrib/libvhost-user/libvhost-user.h   |  15 +-
> >  tests/qtest/libqos/libqtest.h           |  25 +
> >  tests/qtest/libqos/vhost-user-blk.h     |  48 ++
> >  block/export/export.c                   |   4 +-
> >  block/export/vhost-user-blk-server.c    |  28 +-
> >  contrib/vhost-user-blk/vhost-user-blk.c |   2 +
> >  tests/qtest/libqos/vhost-user-blk.c     | 129 ++++
> >  tests/qtest/libqtest.c                  |  76 ++-
> >  tests/qtest/vhost-user-blk-test.c       | 843 ++++++++++++++++++++++++
> >  block/export/meson.build                |   2 +-
> >  tests/qtest/libqos/meson.build          |   1 +
> >  tests/qtest/meson.build                 |   2 +
> >  util/meson.build                        |   2 +-
> >  14 files changed, 1151 insertions(+), 41 deletions(-)
> >  create mode 100644 tests/qtest/libqos/vhost-user-blk.h
> >  create mode 100644 tests/qtest/libqos/vhost-user-blk.c
> >  create mode 100644 tests/qtest/vhost-user-blk-test.c
> > 
> > -- 
> > 2.26.2
> > 



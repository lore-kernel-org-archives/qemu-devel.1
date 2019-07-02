Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BBDC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 21:40:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F9E218DA
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 21:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F9E218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiQW1-0007zN-94
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 17:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42272)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hiQU5-0007Rv-NE
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 17:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hiQU3-0003wq-Rm
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 17:38:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45018)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hiQU3-0003sE-I3
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 17:38:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B16963082E69;
 Tue,  2 Jul 2019 21:38:32 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 590363794;
 Tue,  2 Jul 2019 21:38:25 +0000 (UTC)
Date: Tue, 2 Jul 2019 18:38:24 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: patchew-devel@redhat.com
Message-ID: <20190702213824.GS5198@habkost.net>
References: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
 <156210201797.16064.1193142357173483033@c4a48874b076>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156210201797.16064.1193142357173483033@c4a48874b076>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 02 Jul 2019 21:38:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] No symbols in LeakSanitizer output (was Re: [RFC PATCH
 0/7] target/i386: support VMX features in "-cpu")
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
Cc: pbonzini@redhat.com, liran.alon@oracle.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Can the asan build test in Patchew be updated to include
symbolize=1?

For reference, below is the full stack trace of the leak.  It
looks like it existed for a long time.


[qemu/machine-next]$ export ASAN_OPTIONS=symbolize=1
[qemu/machine-next]$ export ASAN_SYMBOLIZER_PATH=/usr/bin/llvm-symbolizer
[qemu/machine-next]$ MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img tests/device-introspect-test -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="qmp-test"
PASS 1 qmp-test /x86_64/device/introspect/list
PASS 2 qmp-test /x86_64/device/introspect/list-fields
PASS 3 qmp-test /x86_64/device/introspect/none
PASS 4 qmp-test /x86_64/device/introspect/abstract
PASS 5 qmp-test /x86_64/device/introspect/abstract-interfaces

=================================================================
==21992==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x55e9a04dfc6e in calloc (/home/ehabkost/rh/proj/virt/qemu/x86_64-softmmu/qemu-system-x86_64+0x18b5c6e)
    #1 0x7fb604a10cf0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x55cf0)
    #2 0x55e9a1712c0b in gpio_i2c_init /home/ehabkost/rh/proj/virt/qemu/hw/i2c/bitbang_i2c.c:237:18
    #3 0x55e9a23885d8 in object_init_with_type /home/ehabkost/rh/proj/virt/qemu/qom/object.c:359:9
    #4 0x55e9a236e80f in object_initialize_with_type /home/ehabkost/rh/proj/virt/qemu/qom/object.c:463:5
    #5 0x55e9a2370b95 in object_new_with_type /home/ehabkost/rh/proj/virt/qemu/qom/object.c:632:5
    #6 0x55e9a23709b1 in object_new /home/ehabkost/rh/proj/virt/qemu/qom/object.c:642:12
    #7 0x55e9a20b5cc8 in qmp_device_list_properties /home/ehabkost/rh/proj/virt/qemu/monitor/qmp-cmds.c:528:11
    #8 0x55e9a11b5094 in qdev_device_help /home/ehabkost/rh/proj/virt/qemu/qdev-monitor.c:275:17
    #9 0x55e9a11bab2a in qmp_device_add /home/ehabkost/rh/proj/virt/qemu/qdev-monitor.c:810:34
    #10 0x55e9a20e31a1 in hmp_device_add /home/ehabkost/rh/proj/virt/qemu/monitor/hmp-cmds.c:2169:5
    #11 0x55e9a20a2de6 in handle_hmp_command /home/ehabkost/rh/proj/virt/qemu/monitor/hmp.c:1082:5
    #12 0x55e9a0d883af in qmp_human_monitor_command /home/ehabkost/rh/proj/virt/qemu/monitor/misc.c:139:5
    #13 0x55e9a21c4a24 in qmp_marshal_human_monitor_command /home/ehabkost/rh/proj/virt/qemu/qapi/qapi-commands-misc.c:1172:14
    #14 0x55e9a2983c28 in do_qmp_dispatch /home/ehabkost/rh/proj/virt/qemu/qapi/qmp-dispatch.c:131:5
    #15 0x55e9a2982f05 in qmp_dispatch /home/ehabkost/rh/proj/virt/qemu/qapi/qmp-dispatch.c:174:11
    #16 0x55e9a209d2f5 in monitor_qmp_dispatch /home/ehabkost/rh/proj/virt/qemu/monitor/qmp.c:120:11
    #17 0x55e9a209b525 in monitor_qmp_bh_dispatcher /home/ehabkost/rh/proj/virt/qemu/monitor/qmp.c:209:9
    #18 0x55e9a2b1942a in aio_bh_call /home/ehabkost/rh/proj/virt/qemu/util/async.c:89:5
    #19 0x55e9a2b19b42 in aio_bh_poll /home/ehabkost/rh/proj/virt/qemu/util/async.c:117:13
    #20 0x55e9a2b3b800 in aio_dispatch /home/ehabkost/rh/proj/virt/qemu/util/aio-posix.c:459:5
    #21 0x55e9a2b1eb73 in aio_ctx_dispatch /home/ehabkost/rh/proj/virt/qemu/util/async.c:260:5
    #22 0x7fb604a0aedc in g_main_context_dispatch (/lib64/libglib-2.0.so.0+0x4fedc)

Direct leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x55e9a04dfc6e in calloc (/home/ehabkost/rh/proj/virt/qemu/x86_64-softmmu/qemu-system-x86_64+0x18b5c6e)
    #1 0x7fb604a10cf0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x55cf0)
    #2 0x55e9a1712c0b in gpio_i2c_init /home/ehabkost/rh/proj/virt/qemu/hw/i2c/bitbang_i2c.c:237:18
    #3 0x55e9a23885d8 in object_init_with_type /home/ehabkost/rh/proj/virt/qemu/qom/object.c:359:9
    #4 0x55e9a236e80f in object_initialize_with_type /home/ehabkost/rh/proj/virt/qemu/qom/object.c:463:5
    #5 0x55e9a2370b95 in object_new_with_type /home/ehabkost/rh/proj/virt/qemu/qom/object.c:632:5
    #6 0x55e9a23709b1 in object_new /home/ehabkost/rh/proj/virt/qemu/qom/object.c:642:12
    #7 0x55e9a20b5cc8 in qmp_device_list_properties /home/ehabkost/rh/proj/virt/qemu/monitor/qmp-cmds.c:528:11
    #8 0x55e9a21c7624 in qmp_marshal_device_list_properties /home/ehabkost/rh/proj/virt/qemu/qapi/qapi-commands-misc.c:1439:14
    #9 0x55e9a2983c28 in do_qmp_dispatch /home/ehabkost/rh/proj/virt/qemu/qapi/qmp-dispatch.c:131:5
    #10 0x55e9a2982f05 in qmp_dispatch /home/ehabkost/rh/proj/virt/qemu/qapi/qmp-dispatch.c:174:11
    #11 0x55e9a209d2f5 in monitor_qmp_dispatch /home/ehabkost/rh/proj/virt/qemu/monitor/qmp.c:120:11
    #12 0x55e9a209b525 in monitor_qmp_bh_dispatcher /home/ehabkost/rh/proj/virt/qemu/monitor/qmp.c:209:9
    #13 0x55e9a2b1942a in aio_bh_call /home/ehabkost/rh/proj/virt/qemu/util/async.c:89:5
    #14 0x55e9a2b19b42 in aio_bh_poll /home/ehabkost/rh/proj/virt/qemu/util/async.c:117:13
    #15 0x55e9a2b3b800 in aio_dispatch /home/ehabkost/rh/proj/virt/qemu/util/aio-posix.c:459:5
    #16 0x55e9a2b1eb73 in aio_ctx_dispatch /home/ehabkost/rh/proj/virt/qemu/util/async.c:260:5
    #17 0x7fb604a0aedc in g_main_context_dispatch (/lib64/libglib-2.0.so.0+0x4fedc)

SUMMARY: AddressSanitizer: 64 byte(s) leaked in 2 allocation(s).
tests/libqtest.c:137: kill_qemu() tried to terminate QEMU process but encountered exit status 1
ERROR - too few tests run (expected 6, got 5)


On Tue, Jul 02, 2019 at 02:13:39PM -0700, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/1562079681-19204-1-git-send-email-pbonzini@redhat.com/
[...]
> =================================================================
> ==10979==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 32 byte(s) in 1 object(s) allocated from:
>     #0 0x558e9bbf3b1e in calloc (/tmp/qemu-test/build/x86_64-softmmu/qemu-system-x86_64+0x19f8b1e)
> ---
> 
> SUMMARY: AddressSanitizer: 64 byte(s) leaked in 2 allocation(s).
> /tmp/qemu-test/src/tests/libqtest.c:137: kill_qemu() tried to terminate QEMU process but encountered exit status 1
> ERROR - too few tests run (expected 6, got 5)
> make: *** [/tmp/qemu-test/src/tests/Makefile.include:894: check-qtest-x86_64] Error 1
> make: *** Waiting for unfinished jobs....
> Traceback (most recent call last):
> 
> 
> The full log is available at
> http://patchew.org/logs/1562079681-19204-1-git-send-email-pbonzini@redhat.com/testing.asan/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

-- 
Eduardo


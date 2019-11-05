Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7B4C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:30:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F11217F5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F11217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS1jN-0008Pp-J9
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 11:30:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iS1iS-0007Pv-0Z
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:30:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iS1iP-000375-DI
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:29:59 -0500
Received: from relay68.bu.edu ([128.197.228.73]:48387)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iS1iP-00031N-93
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:29:57 -0500
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: 144.121.20.162.lightower.net [144.121.20.162] (may be forged)
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id xA5GSx6v029357
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
 Tue, 5 Nov 2019 11:29:00 -0500
Subject: Re: [PATCH v4 00/20] Add virtual device fuzzing support
To: Darren Kenny <darren.kenny@oracle.com>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191105135711.lld344zgbin2tz72@starbug-mbp>
From: Alexander Oleinik <alxndr@bu.edu>
Message-ID: <6b127ec9-e9aa-ac27-5db9-bb731ae0eec0@bu.edu>
Date: Tue, 5 Nov 2019 11:28:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191105135711.lld344zgbin2tz72@starbug-mbp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by relay68.bu.edu id
 xA5GSx6v029357
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.6.x [fuzzy]
X-Received-From: 128.197.228.73
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/19 8:57 AM, Darren Kenny wrote:
> Hi Alexander,
>=20
> I've been trying out these patches, and I'm seeing a high volume of
> crashes - where for v3, there were none in a run of over 3 weeks -
> so it was a bit of a surprise :)
>=20
> The question is what may have changed that is causing that level of
> crashes - are you seeing this for the virtio-net-fork-fuzz tests?
Good question - my guess is that it may have to do with the change in=20
how we run the main loop. I have not looked into it in much detail, but=20
the crash below is likely triggered only after running the main_loop=20
several times (the events handled in the first loop, schedule additional=20
BHs). In v3, I believe the main_loop only ran once before the forked=20
process exited. There are also changes to the linker-script used to=20
facilitate communication between the forked process and the parent, but=20
I think that would only impact the coverage information passed back to=20
the parent.

> But also, I've been trying to debug some of these crashes - and the
> expectation is that you pass the crash-XXXX file as an argument to
> the qemu-fuzz-* binary - and when I do, I see the crash - but when I
> try to debug it, it ends up running through and exiting
> My assumption is that because of the fork in the test, the crash is
> in one of the children.
Right! Seems you are already using the follow-fork-mode option.

> (ASIDE: I think it might be worth adding a debugging/analysing
> section to the documentation you've added to help people debug such
> crashes)
Will do. Although it did not make it into v4, I am also working on an=20
option to dump a trace of the qtest commands leading to a crashing=20
input, which can then be replayed with a standard qtest program=20
"replay.c". This seems like a good way to provide a reproducer to the=20
device developers who may not be familiar with the fuzzer, or have time=20
to build it.

> Setting follow-fork-mode to child does get me there, and each crash
> seems, at least in the samples that I've taken, to be in iov_copy:
Yes - this is what I have been using as well.

>  =C2=A0#0=C2=A0 0x00007ffff4cff377 in raise () from /lib64/libc.so.6
>  =C2=A0#1=C2=A0 0x00007ffff4d00a68 in abort () from /lib64/libc.so.6
>  =C2=A0#2=C2=A0 0x00007ffff4cf8196 in __assert_fail_base () from
>  =C2=A0/lib64/libc.so.6
>  =C2=A0#3=C2=A0 0x00007ffff4cf8242 in __assert_fail () from /lib64/libc=
.so.6
>  =C2=A0#4=C2=A0 0x00005555574d4026 in iov_copy ()
>  =C2=A0#5=C2=A0 0x000055555640dbd8 in virtio_net_flush_tx ()
>  =C2=A0#6=C2=A0 0x000055555640c8ef in virtio_net_tx_bh ()
>  =C2=A0#7=C2=A0 0x00005555574a05bb in aio_bh_call ()
>  =C2=A0#8=C2=A0 0x00005555574a0a34 in aio_bh_poll ()
>  =C2=A0#9=C2=A0 0x00005555574b1687 in aio_dispatch ()
>  =C2=A0#10 0x00005555574a35f9 in aio_ctx_dispatch ()
>  =C2=A0#11 0x00007ffff5e5d099 in g_main_context_dispatch () from
>  =C2=A0/lib64/libglib-2.0.so.0
>  =C2=A0#12 0x00005555574ae9fd in glib_pollfds_poll ()
>  =C2=A0#13 0x00005555574ad972 in os_host_main_loop_wait ()
>  =C2=A0#14 0x00005555574ad62c in main_loop_wait ()
>  =C2=A0#15 0x000055555736c653 in flush_events ()
>  =C2=A0#16 0x00005555573710a4 in virtio_net_fork_fuzz ()
>  =C2=A0#17 0x000055555736cb85 in LLVMFuzzerTestOneInput ()
>  =C2=A0...
>=20
> Have you seen these kind of crashes, or is this just me?
Not just you :) I posted a fix for this, but it may have not been=20
complete. I think the fuzzer found it before we added forking, just by=20
doing reboots in between runs:
https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg04882.html

> Just wondering if I should dig into it as a real issue, or some
> mis-merge I've done (not all the patches were cleanly applied for
> me when I cloned from master).

> Thanks,
>=20
> Darren.
>=20
> On Wed, Oct 30, 2019 at 02:49:47PM +0000, Oleinik, Alexander wrote:
>> This series adds a framework for coverage-guided fuzzing of
>> virtual-devices. Fuzzing targets are based on qtest and can make use o=
f
>> the libqos abstractions.
>>
>> V4:
>> * add/transfer license headers to new files
>> * restructure the added QTestClientTransportOps struct
>> * restructure the FuzzTarget struct and fuzzer skeleton
>> * fork-based fuzzer now directly mmaps shm over the coverage bitmaps
>> * fixes to i440 and virtio-net fuzz targets
>> * undo the changes to qtest_memwrite
>> * possible to build /fuzz and /all in the same build-dir
>> * misc fixes to address V3 comments
>>
>> V3:
>> * rebased onto v4.1.0+
>> * add the fuzzer as a new build-target type in the build-system
>> * add indirection to qtest client/server communication functions
>> * remove ramfile and snapshot-based fuzzing support
>> * add i440fx fuzz-target as a reference for developers.
>> * add linker-script to assist with fork-based fuzzer
>>
>> V2:
>> * split off changes to qos virtio-net and qtest server to other patche=
s
>> * move vl:main initialization into new func: qemu_init
>> * moved useful functions from qos-test.c to a separate object
>> * use struct of function pointers for add_fuzz_target(), instead of
>> =C2=A0 arguments
>> * move ramfile to migration/qemu-file
>> * rewrite fork-based fuzzer pending patch to libfuzzer
>> * pass check-patch
>>
>> Alexander Oleinik (20):
>> =C2=A0softmmu: split off vl.c:main() into main.c
>> =C2=A0libqos: Rename i2c_send and i2c_recv
>> =C2=A0fuzz: Add FUZZ_TARGET module type
>> =C2=A0qtest: add qtest_server_send abstraction
>> =C2=A0libqtest: Add a layer of abstraciton to send/recv
>> =C2=A0module: check module wasn't already initialized
>> =C2=A0qtest: add in-process incoming command handler
>> =C2=A0tests: provide test variables to other targets
>> =C2=A0libqos: split qos-test and libqos makefile vars
>> =C2=A0libqos: move useful qos-test funcs to qos_external
>> =C2=A0libqtest: make qtest_bufwrite send "atomic"
>> =C2=A0libqtest: add in-process qtest.c tx/rx handlers
>> =C2=A0fuzz: add configure flag --enable-fuzzing
>> =C2=A0fuzz: Add target/fuzz makefile rules
>> =C2=A0fuzz: add fuzzer skeleton
>> =C2=A0fuzz: add support for fork-based fuzzing.
>> =C2=A0fuzz: add support for qos-assisted fuzz targets
>> =C2=A0fuzz: add i440fx fuzz targets
>> =C2=A0fuzz: add virtio-net fuzz target
>> =C2=A0fuzz: add documentation to docs/devel/
>>
>> Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 16 ++-
>> Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
>> Makefile.target=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 ++-
>> configure=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 39 ++++++
>> docs/devel/fuzzing.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 119 +++++=
+++++++++++++
>> exec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 12 +-
>> include/qemu/module.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 4 +-
>> include/sysemu/qtest.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 4 +
>> include/sysemu/sysemu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 =
+
>> main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 52 ++++++++
>> qtest.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3=
0 ++++-
>> tests/Makefile.include=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 75 =
+++++------
>> tests/fuzz/Makefile.include=C2=A0 |=C2=A0 11 ++
>> tests/fuzz/fork_fuzz.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 51 =
++++++++
>> tests/fuzz/fork_fuzz.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 23 =
++++
>> tests/fuzz/fork_fuzz.ld=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 37 +++++=
+
>> tests/fuzz/fuzz.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 177 ++++++++++++++++++++++++++
>> tests/fuzz/fuzz.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 66 ++++++++++
>> tests/fuzz/i440fx_fuzz.c=C2=A0=C2=A0=C2=A0=C2=A0 | 176 +++++++++++++++=
+++++++++++
>> tests/fuzz/qos_fuzz.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 232 =
+++++++++++++++++++++++++++++++++++
>> tests/fuzz/qos_fuzz.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 33 +++++
>> tests/fuzz/virtio_net_fuzz.c | 123 +++++++++++++++++++
>> tests/libqos/i2c-imx.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 8 +-
>> tests/libqos/i2c-omap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 =
+-
>> tests/libqos/i2c.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 10 +-
>> tests/libqos/i2c.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 4 +-
>> tests/libqos/qos_external.c=C2=A0 | 168 +++++++++++++++++++++++++
>> tests/libqos/qos_external.h=C2=A0 |=C2=A0 28 +++++
>> tests/libqtest.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 109 ++++++++++++++--
>> tests/libqtest.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
>> tests/pca9552-test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 10 +-
>> tests/qos-test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 140 +--------------------
>> util/module.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 ++
>> vl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 36 ++----
>> 34 files changed, 1601 insertions(+), 237 deletions(-)
>> create mode 100644 docs/devel/fuzzing.txt
>> create mode 100644 main.c
>> create mode 100644 tests/fuzz/Makefile.include
>> create mode 100644 tests/fuzz/fork_fuzz.c
>> create mode 100644 tests/fuzz/fork_fuzz.h
>> create mode 100644 tests/fuzz/fork_fuzz.ld
>> create mode 100644 tests/fuzz/fuzz.c
>> create mode 100644 tests/fuzz/fuzz.h
>> create mode 100644 tests/fuzz/i440fx_fuzz.c
>> create mode 100644 tests/fuzz/qos_fuzz.c
>> create mode 100644 tests/fuzz/qos_fuzz.h
>> create mode 100644 tests/fuzz/virtio_net_fuzz.c
>> create mode 100644 tests/libqos/qos_external.c
>> create mode 100644 tests/libqos/qos_external.h
>>
>> --=20
>> 2.23.0
>>
>>



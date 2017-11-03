Received: from eggs.gnu.org ([2001:4830:134:3::10]:38543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eAYpf-0003sr-Cr
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eAYpb-0004lw-FK
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:04:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eAYpb-0004lb-87
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:04:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31C7313A74
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 10:04:06 +0000 (UTC)
References: <150970267983.273.1055338257816616711@bafd83ae6430>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9066062f-b01e-0e37-8d0d-0982429d546a@redhat.com>
Date: Fri, 3 Nov 2017 11:03:58 +0100
MIME-Version: 1.0
In-Reply-To: <150970267983.273.1055338257816616711@bafd83ae6430>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: Run the test-crypto-block only if
 encryption is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, berrange@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

On 03.11.2017 10:51, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed automatic build test. Please find the testing comman=
ds and
> their output below. If you have docker installed, you can probably repr=
oduce it
> locally.
[...]
>   GTESTER tests/test-coroutine
>   GTESTER tests/test-visitor-serialization
>   GTESTER tests/test-aio
>   GTESTER tests/test-iov
>   GTESTER tests/test-aio-multithread
>   GTESTER tests/test-throttle
>   GTESTER tests/test-thread-pool
>   GTESTER tests/test-hbitmap
>   GTESTER tests/test-blockjob-txn
>   GTESTER tests/test-blockjob
>   GTESTER tests/test-x86-cpuid
>   GTESTER tests/test-xbzrle
>   GTESTER tests/test-vmstate
> Failed to load simple/primitive:b_1
> Failed to load simple/primitive:i64_2
> Failed to load simple/primitive:i32_1
> Failed to load simple/primitive:i32_1
> Failed to load test/with_tmp:a
> Failed to load test/tmp_child_parent:f
> Failed to load test/tmp_child:parent
> Failed to load test/with_tmp:tmp
> Failed to load test/tmp_child:diff
> Failed to load test/with_tmp:tmp
> Failed to load test/tmp_child:diff
> Failed to load test/with_tmp:tmp
>   GTESTER tests/test-cutils
>   GTESTER tests/test-shift128
>   GTESTER tests/test-mul64
>   GTESTER tests/test-int128
>   GTESTER tests/rcutorture
>   GTESTER tests/test-rcu-list
>   GTESTER tests/test-qdist
>   GTESTER tests/test-qht
> GTester: last random seed: R02S7edfc183e8c228b3f1f73d7b19921a84
>   LINK    tests/test-qht-par
>   GTESTER tests/test-bitops
>   GTESTER tests/test-bitcnt
>   GTESTER tests/check-qom-interface
>   GTESTER tests/check-qom-proplist
>   GTESTER tests/test-qemu-opts
>   GTESTER tests/test-keyval
>   GTESTER tests/test-write-threshold
>   GTESTER tests/test-crypto-hash
>   GTESTER tests/test-crypto-hmac
>   GTESTER tests/test-crypto-cipher
>   GTESTER tests/test-crypto-secret
>   GTESTER tests/test-qga
>   GTESTER tests/test-timed-average
>   GTESTER tests/test-io-task
>   GTESTER tests/test-io-channel-socket
>   GTESTER tests/test-io-channel-file
>   GTESTER tests/test-io-channel-command
>   GTESTER tests/test-io-channel-buffer
>   GTESTER tests/test-base64
>   GTESTER tests/test-crypto-ivgen
>   GTESTER tests/test-crypto-afsplit
>   GTESTER tests/test-crypto-xts

Mhh, this looks somewhat strange - apparently the test-crypto-block has
now been skipped - but then I wonder why this was working before here if
the crypto libraries were not available? ... maybe there's still
something wrong with my patch?

>   GTESTER tests/test-logging
>   GTESTER tests/test-replication
>   GTESTER tests/test-bufferiszero
>   GTESTER tests/test-uuid
>   GTESTER tests/ptimer-test
>   GTESTER tests/test-qapi-util
>   GTESTER check-qtest-x86_64
>   GTESTER check-qtest-aarch64
>   GTESTER tests/test-qobject-output-visitor
>   GTESTER tests/test-clone-visitor
>   GTESTER tests/test-qobject-input-visitor
>   GTESTER tests/test-qmp-commands
>   GTESTER tests/test-string-input-visitor
>   GTESTER tests/test-string-output-visitor
>   GTESTER tests/test-qmp-event
>   GTESTER tests/test-opts-visitor
>   GTESTER tests/test-qht-par
> make: *** [check-tests/test-aio-multithread] Error 1
> make: *** Waiting for unfinished jobs....
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator

... but this test-aio-multithread error is certainly not related to my
patch, I think. Is this already a known issue?

 Thomas

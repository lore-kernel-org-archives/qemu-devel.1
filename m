Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756C1C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:20:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E2C820659
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2C820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiFtR-0001Zp-Jy
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 06:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45344)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiFqr-00074W-PM
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiFqp-0003IT-NX
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:17:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45377)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiFqo-0003HE-2H
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:17:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so17074101wre.12
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 03:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ek1JR3XuB4PXRUwXKaD0r6r3sxIKQNv+u9hBNFyvU6Q=;
 b=MGTeYfd1vMFlpT3jDmdq1AOGj52f9NdhCixHQHnJ2O9S15gGblHqaVgMt5+fE5jHiO
 IC3pEvvIfo3ma1Pj4WsWJiKBj9mPfSx3FEuE4otOuMsk90Gvhxdm4/7vRQ43awHIA9+1
 3enquHBUZ+HxoiIc0WfZpkX/3UGPyXhZVYTBqqelZ8sz4RyZzPvzXUfYmHRZlEiqwwBz
 7+K8N4aqxtJhot5ZHG9s5FJ8rpWUHu7LMYeX7isNbZvFG5oahxAVMVajmuCELfgD2Xbk
 xQHcVNMobudMGSKoNYPto2R8of7ZrlCC/kBdMm++4cO/U52PsyjOARmsSBaAF8dFDrdi
 18aw==
X-Gm-Message-State: APjAAAVA1O8TC/E0n87cVw5Lck0sUCi2XqMwtk53dJa4hi7CQTtmHGVo
 Q6Cs3LS54ehh5QhYr4ylrkhFgg==
X-Google-Smtp-Source: APXvYqwx42AMxd8voKjgq6hsnDHkNK/jQneqcO7ZyFDUJPTmO6WceTEmLST6SJPEC3AqK0BCebWd0w==
X-Received: by 2002:adf:f186:: with SMTP id h6mr5634455wro.274.1562062643635; 
 Tue, 02 Jul 2019 03:17:23 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id o6sm30930735wra.27.2019.07.02.03.17.21
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 03:17:22 -0700 (PDT)
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <156204814619.13267.5511467304528619824@c4a48874b076>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <00364cd4-9689-9873-1317-d95640af21d3@redhat.com>
Date: Tue, 2 Jul 2019 12:17:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156204814619.13267.5511467304528619824@c4a48874b076>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2 0/9] hw/block/pflash_cfi01: Add
 DeviceReset() handler
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
Cc: mst@redhat.com, jcmvbkbc@gmail.com, kraxel@redhat.com,
 edgar.iglesias@gmail.com, qemu-block@nongnu.org, arikalo@wavecomp.com,
 alex.bennee@linaro.org, armbru@redhat.com, david@gibson.dropbear.id.au,
 lersek@redhat.com, ehabkost@redhat.com, qemu-arm@nongnu.org,
 alistair23@gmail.com, jsnow@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 mreitz@redhat.com, michael@walle.cc, qemu-ppc@nongnu.org,
 richardw.yang@linux.intel.com, amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Marc-André,

On 7/2/19 8:15 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190702001301.4768-1-philmd@redhat.com/
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> make docker-image-fedora V=1 NETWORK=1
> time make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu J=14 NETWORK=1
> === TEST SCRIPT END ===

I am not sure how the error reported is related to this series:

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
tests/test-bdrv-drain -m=quick -k --tap < /dev/null |
./scripts/tap-driver.pl --test-name="test-bdrv-drain"
==8090==WARNING: ASan doesn't fully support makecontext/swapcontext
functions and may produce false positives in some cases!
PASS 1 test-bdrv-drain /bdrv-drain/nested
PASS 2 test-bdrv-drain /bdrv-drain/multiparent
PASS 3 test-bdrv-drain /bdrv-drain/set_aio_context
PASS 4 test-bdrv-drain /bdrv-drain/driver-cb/drain_all
PASS 5 test-bdrv-drain /bdrv-drain/driver-cb/drain
PASS 6 test-bdrv-drain /bdrv-drain/driver-cb/drain_subtree
PASS 7 test-bdrv-drain /bdrv-drain/driver-cb/co/drain_all
PASS 8 test-bdrv-drain /bdrv-drain/driver-cb/co/drain
PASS 9 test-bdrv-drain /bdrv-drain/driver-cb/co/drain_subtree
PASS 10 test-bdrv-drain /bdrv-drain/quiesce/drain_all
PASS 11 test-bdrv-drain /bdrv-drain/quiesce/drain
PASS 12 test-bdrv-drain /bdrv-drain/quiesce/drain_subtree
PASS 13 test-bdrv-drain /bdrv-drain/quiesce/co/drain_all
PASS 14 test-bdrv-drain /bdrv-drain/quiesce/co/drain
PASS 15 test-bdrv-drain /bdrv-drain/quiesce/co/drain_subtree
PASS 16 test-bdrv-drain /bdrv-drain/graph-change/drain_subtree
PASS 17 test-bdrv-drain /bdrv-drain/graph-change/drain_all
=================================================================
==8090==ERROR: AddressSanitizer: heap-use-after-free on address
0x61200002c1f0 at pc 0x559638e7e006 bp 0x7f974eab8680 sp 0x7f974eab8678
WRITE of size 1 at 0x61200002c1f0 thread T5
PASS 3 ahci-test /x86_64/ahci/pci_enable
    #0 0x559638e7e005 in aio_notify /tmp/qemu-test/src/util/async.c:351:9
    #1 0x559638e7fc3b in qemu_bh_schedule
/tmp/qemu-test/src/util/async.c:167:9
    #2 0x559638e82e40 in aio_co_schedule
/tmp/qemu-test/src/util/async.c:464:5
    #3 0x559638e83109 in aio_co_enter /tmp/qemu-test/src/util/async.c:483:9
    #4 0x559638e8308d in aio_co_wake /tmp/qemu-test/src/util/async.c:477:5
    #5 0x55963876b3d4 in co_reenter_bh
/tmp/qemu-test/src/tests/test-bdrv-drain.c:63:5
    #6 0x559638e7e8aa in aio_bh_call /tmp/qemu-test/src/util/async.c:89:5
    #7 0x559638e7efc2 in aio_bh_poll /tmp/qemu-test/src/util/async.c:117:13
    #8 0x559638ea4a73 in aio_poll /tmp/qemu-test/src/util/aio-posix.c:728:17
    #9 0x559638d48628 in iothread_run
/tmp/qemu-test/src/tests/iothread.c:51:9
    #10 0x559638eb8612 in qemu_thread_start
/tmp/qemu-test/src/util/qemu-thread-posix.c:502:9
    #11 0x7f976074a5a1 in start_thread (/lib64/libpthread.so.0+0x85a1)
    #12 0x7f9760657022 in __GI___clone (/lib64/libc.so.6+0xfb022)

0x61200002c1f0 is located 176 bytes inside of 312-byte region
[0x61200002c140,0x61200002c278)
freed by thread T0 here:
    #0 0x55963872475f in free
(/tmp/qemu-test/build/tests/test-bdrv-drain+0x53375f)
    #1 0x7f9760bc5d8c in g_free (/lib64/libglib-2.0.so.0+0x55d8c)

previously allocated by thread T4 here:
    #0 0x559638724d9e in calloc
(/tmp/qemu-test/build/tests/test-bdrv-drain+0x533d9e)
    #1 0x7f9760bc5cf0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x55cf0)

Thread T5 created by T0 here:
    #0 0x559638659f16 in __interceptor_pthread_create
(/tmp/qemu-test/build/tests/test-bdrv-drain+0x468f16)
    #1 0x559638eb7f19 in qemu_thread_create
/tmp/qemu-test/src/util/qemu-thread-posix.c:539:11
    #2 0x559638d47cce in iothread_new
/tmp/qemu-test/src/tests/iothread.c:75:5
    #3 0x55963876c412 in test_iothread_common
/tmp/qemu-test/src/tests/test-bdrv-drain.c:664:19
    #4 0x55963876724e in test_iothread_drain_all
/tmp/qemu-test/src/tests/test-bdrv-drain.c:758:5
    #5 0x7f9760be7f9d  (/lib64/libglib-2.0.so.0+0x77f9d)

Thread T4 created by T0 here:
    #0 0x559638659f16 in __interceptor_pthread_create
(/tmp/qemu-test/build/tests/test-bdrv-drain+0x468f16)
    #1 0x559638eb7f19 in qemu_thread_create
/tmp/qemu-test/src/util/qemu-thread-posix.c:539:11
    #2 0x559638d47cce in iothread_new
/tmp/qemu-test/src/tests/iothread.c:75:5
    #3 0x55963876c406 in test_iothread_common
/tmp/qemu-test/src/tests/test-bdrv-drain.c:663:19
    #4 0x55963876724e in test_iothread_drain_all
/tmp/qemu-test/src/tests/test-bdrv-drain.c:758:5
    #5 0x7f9760be7f9d  (/lib64/libglib-2.0.so.0+0x77f9d)

SUMMARY: AddressSanitizer: heap-use-after-free
/tmp/qemu-test/src/util/async.c:351:9 in aio_notify
Shadow bytes around the buggy address:
  0x0c247fffd7e0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c247fffd7f0: fa fa fa fa fa fa fa fa fd fd fd fd fd fd fd fd
  0x0c247fffd800: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c247fffd810: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fa
  0x0c247fffd820: fa fa fa fa fa fa fa fa fd fd fd fd fd fd fd fd
=>0x0c247fffd830: fd fd fd fd fd fd fd fd fd fd fd fd fd fd[fd]fd
  0x0c247fffd840: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fa
  0x0c247fffd850: fa fa fa fa fa fa fa fa 00 00 00 00 00 00 00 00
  0x0c247fffd860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c247fffd870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fa fa
  0x0c247fffd880: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
  Shadow gap:              cc
==8090==ABORTING
ERROR - too few tests run (expected 39, got 17)
make: *** [/tmp/qemu-test/src/tests/Makefile.include:899: check-unit]
Error 1
make: *** Waiting for unfinished jobs....


Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33F0C33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DED52083E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XGMEdMhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DED52083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isVWO-0004Gi-Hz
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 12:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1isVUs-0002mx-Nv
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:33:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1isVUq-0004PL-TG
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:33:26 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:34893)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1isVUq-0004Mt-Lb
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:33:24 -0500
Received: by mail-wr1-x42f.google.com with SMTP id g17so23488930wro.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 09:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=user-agent:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/xG9z9PdUuUJmyqH43nSPLPDTO5Ez/tBISLDm7x6mCI=;
 b=XGMEdMhieM/j6s//Zvb/mJdjlwz9Pa3AA5xvyqUt0nKY4Nmb+YTTHbYRL9DTe2rYA9
 c8o2L4aTlQiVh4h2ahOxVbVWjJL7QJRRPw120aa90je5NP/FfqCacENn8e7sYKR5J2jm
 KztkckubaJQVxU2eL6nZhSIad4qshbJkQ1fjspK+iKipMhe8QCBIzA/iBEiO4GAQSNH5
 rZgdYwo7InVBCERUzdelPXK0YdAUeptqR/57g3A1eC/LyTvGjkEMCec+UFxoI3IhJZoe
 oJe848+yIDcuWZNoltxXs2K7XIjR3/ccX5eHlF9EWThAtH2OtpRO3NlqG0QjN92VCtCw
 mGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:user-agent:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=/xG9z9PdUuUJmyqH43nSPLPDTO5Ez/tBISLDm7x6mCI=;
 b=FxNwd+Ocm7+qWu37UBEfg5pbWAg4u2y3O6fL40ufPlMRZySln/8Dqu3dFT7NcHRZgC
 ALabjnboYrtirVsMRhcfzzBqKOUql6iTVWcykfUQL1qnfbcUiPSA7CGIk406/tYJTv6Z
 7RCcnxSsjDUPCXtPbx2PM4/7oIKn8s61gxWaI7mSFXNn2qfcPGx/Rw4Jv3L8kkAVF8CJ
 AnWxsmz68SmSCMRyLM3BdRm4Ls7MU4C3oQUlWwCbliFtlHJky6HG4P7/LvZPCVBKL7Aw
 myiHq2G4FO2Ol80/pFWRYzYFD4H8BzRMTN/rfXrC3V/A/O/KK70NTZ2bsE6v7k7J3Qh5
 Odyw==
X-Gm-Message-State: APjAAAUA7tbxMtgPquX4U7lqBvUEed7sNf0s0AHx0KKMKzVOmdmCYY/5
 y5yKO3raoFHsrEvH8m951Isr+g==
X-Google-Smtp-Source: APXvYqyQMFSSXcEqR1/Hdy8nSKNf4q/9CiGPXKTODJA2kFbsyT6o069KWobSgREzTd22fXSj6a18bA==
X-Received: by 2002:adf:978c:: with SMTP id s12mr4232543wrb.408.1579282402388; 
 Fri, 17 Jan 2020 09:33:22 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o16sm499600wmc.18.2020.01.17.09.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 09:33:20 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0E6881FF87;
 Fri, 17 Jan 2020 17:33:20 +0000 (GMT)
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Richard Henderson" <richard.henderson@linaro.org>
Subject: qemu-x86_64, buster /sbin/ldconfig and setup_arg_pages (a mind dump)
Date: Fri, 17 Jan 2020 17:33:20 +0000
Message-ID: <874kwukmxr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi Richard,

While I was attempting to test the new vsyscall patches for x86 I
discovered I couldn't debootstrap an x86_64 buster image on my ARM box.
After digging further into it I discovered it was because executing
/sbin/ldconfig crashes and aborts the bootstrap.

This is helpfully reproducible on my main development system which is
also running buster:

  ./x86_64-linux-user/qemu-x86_64 /sbin/ldconfig
  setup_arg_pages: 00000040000e0000
  target_set_brk: new_brk=3D00000040000dfdf8
  do_brk(0000000000000000) -> 00000040000e0000 (!new_brk)
  do_brk(00000040000e11c0) -> do_brk: allocating 8192 =3D> 00007fb2dace5000
  00000040000e0000 (mapped_addr !=3D -1 or brk_page)
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  fish: Job 2, =E2=80=9C./x86_64-linux-user/qemu-x86_64=E2=80=A6=E2=80=9D t=
erminated by signal SIGSEGV (Address boundary error)

The failure of the second do_brk during the early setup of the binaries
TLS data area. However for some reason this isn't always the case. For
example with testthread which also uses TLS:

  ./x86_64-linux-user/qemu-x86_64 ./tests/tcg/x86_64-linux-user/testthread
  setup_arg_pages: 0000004000000000
  target_set_brk: new_brk=3D00000000004c8558
  do_brk(0000000000000000) -> 00000000004c9000 (!new_brk)
  do_brk(00000000004ca1c0) -> do_brk: allocating 8192 =3D> 00000000004c9000
  00000000004ca1c0 (mapped_addr =3D=3D brk_page)
  do_brk(00000000004eb1c0) -> do_brk: allocating 135168 =3D> 00000000004cb0=
00
  00000000004eb1c0 (mapped_addr =3D=3D brk_page)
  do_brk(00000000004ec000) -> 00000000004ec000 (new_brk <=3D brk_page)
  thread1: 0 hello1
  thread2: 0 hello2
  thread1: 1 hello1

Ultimately the failure is down to setup_arg_pages allocating too low in
the address space in the ldconfig case which leaves the second brk
unable to example it's region of memory. Turning on -d page and you can
see the region forming:

  page layout changed following target_mmap
  start            end              size             prot
  0000004000000000-0000004000009000 0000000000009000 r--
  0000004000009000-00000040000ae000 00000000000a5000 r-x
  00000040000ae000-00000040000d8000 000000000002a000 r--
  00000040000d8000-00000040000df000 0000000000007000 rw-
  00000040000df000-00000040000e0000 0000000000001000 ---
  page layout changed following target_mmap
  start            end              size             prot
  0000004000000000-0000004000009000 0000000000009000 r--
  0000004000009000-00000040000ae000 00000000000a5000 r-x
  00000040000ae000-00000040000d8000 000000000002a000 r--
  00000040000d8000-00000040008e1000 0000000000809000 rw-
  setup_arg_pages: 00000040000e0000
  guest_base  0x0
  page layout changed following binary load
  start            end              size             prot
  0000004000000000-0000004000009000 0000000000009000 r--
  0000004000009000-00000040000ae000 00000000000a5000 r-x
  00000040000ae000-00000040000d8000 000000000002a000 r--
  00000040000d8000-00000040000e0000 0000000000008000 rw-
  00000040000e0000-00000040000e1000 0000000000001000 ---
  00000040000e1000-00000040008e1000 0000000000800000 rw-
  start_brk   0x0000000000000000
  end_code    0x00000040000ad971
  start_code  0x0000004000009000
  start_data  0x00000040000d8778
  end_data    0x00000040000de510
  start_stack 0x00000040008e02d0
  brk         0x00000040000dfdf8
  entry       0x000000400000a370
  argv_start  0x00000040008e02d8
  env_start   0x00000040008e02e8
  auxv_start  0x00000040008e0428
  target_set_brk: new_brk=3D00000040000dfdf8
  page layout changed following target_mmap
  start            end              size             prot
  0000004000000000-0000004000009000 0000000000009000 r--
  0000004000009000-00000040000ae000 00000000000a5000 r-x
  00000040000ae000-00000040000d8000 000000000002a000 r--
  00000040000d8000-00000040000e0000 0000000000008000 rw-
  00000040000e0000-00000040000e1000 0000000000001000 ---
  00000040000e1000-00000040008e2000 0000000000801000 rw-

So it looks like setup_arg_pages just creates a segment right in the
middle of a previously allocated block of storage. This is odd because
the loader basically just leaves it to mmap to pick a region:

    error =3D target_mmap(0, size + guard, PROT_READ | PROT_WRITE,
                        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

AFAICT this just depends on where we have allocated last, in the
testthread case we already have a high mapping to splat:

  page layout changed following target_mmap
  start            end              size             prot
  0000000000400000-0000000000401000 0000000000001000 r--
  0000000000401000-0000000000495000 0000000000094000 r-x
  0000000000495000-00000000004bc000 0000000000027000 r--
  00000000004bd000-00000000004c9000 000000000000c000 rw-
  0000004000000000-0000004000801000 0000000000801000 rw-
  setup_arg_pages: 0000004000000000
  guest_base  0x0
  page layout changed following binary load
  start            end              size             prot
  0000000000400000-0000000000401000 0000000000001000 r--
  0000000000401000-0000000000495000 0000000000094000 r-x
  0000000000495000-00000000004bc000 0000000000027000 r--
  00000000004bd000-00000000004c9000 000000000000c000 rw-
  0000004000000000-0000004000001000 0000000000001000 ---
  0000004000001000-0000004000801000 0000000000800000 rw-

And comparing the ldconfig to a "normal" case we can see that the
problem is all of ldconfig has been allocated in the TASK_UNMAPPED_BASE
region. This is due to ldconfig having a DYNAMIC region without a load
address which causes mmap_find_vma to get called to find space for it
and then all the subsequent anonymous regions that are needed:

  load_elf_image: dynamic loaddr 0000000000000000
  mmap_find_vma: 0000004000000000
  load_elf_image: mapping un-backed region: 0000004000000000:00000000000090=
00
  load_elf_image: mapping un-backed region: 0000004000009000:00000000000a50=
00
  load_elf_image: mapping un-backed region: 00000040000ae000:000000000002a0=
00
  load_elf_image: mapping un-backed region: 00000040000d8000:00000000000070=
00
  mmap_find_vma: 00000040000e0000
  setup_arg_pages: 00000040000e0000
  target_set_brk: new_brk=3D00000040000dfdf8
  mmap_find_vma: 00000040008e1000
  mmap_find_vma: 00000040008e2000
  do_brk(0000000000000000) -> 00000040000e0000 (!new_brk)
  do_brk(00000040000e11c0) -> mmap_find_vma: 00000040000e0000
  do_brk: allocating 8192 =3D> 00007fb999e49000
  00000040000e0000 (mapped_addr !=3D -1 or brk_page)
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped

But no actually this all seems to be normal for dynamically linked
things - but still something must be different:

  ./x86_64-linux-user/qemu-x86_64 ./tests/tcg/x86_64-linux-user/testthread.=
dyn
  load_elf_image: dynamic loaddr 0000000000000000
  mmap_find_vma: 0000004000000000
  load_elf_image: mapping un-backed region: 0000004000000000:00000000000010=
00
  load_elf_image: mapping un-backed region: 0000004000001000:00000000000010=
00
  load_elf_image: mapping un-backed region: 0000004000002000:00000000000010=
00
  load_elf_image: mapping un-backed region: 0000004000003000:00000000000020=
00
  mmap_find_vma: 0000004000005000
  setup_arg_pages: 0000004000005000
  load_elf_image: dynamic loaddr 0000000000000000
  mmap_find_vma: 0000004000806000
  load_elf_image: mapping un-backed region: 0000004000806000:00000000000010=
00
  load_elf_image: mapping un-backed region: 0000004000807000:000000000001e0=
00
  load_elf_image: mapping un-backed region: 0000004000825000:00000000000080=
00
  load_elf_image: mapping un-backed region: 000000400082d000:00000000000020=
00
  target_set_brk: new_brk=3D0000004000004070
  mmap_find_vma: 0000004000830000
  mmap_find_vma: 0000004000831000
  do_brk(0000000000000000) -> 0000004000005000 (!new_brk)
  mmap_find_vma: 0000004000832000
  mmap_find_vma: 0000004000857000
  mmap_find_vma: 0000004000878000
  mmap_find_vma: 000000400087a000
  mmap_find_vma: 0000004000a3b000
  mmap_find_vma: 0000004000a3e000
  do_brk(0000000000000000) -> 0000004000005000 (!new_brk)
  do_brk(0000004000026000) -> mmap_find_vma: 0000004000005000
  do_brk: allocating 135168 =3D> 00007fa00659b000
  0000004000005000 (mapped_addr !=3D -1 or brk_page)
  mmap_find_vma: 000000400123f000
  mmap_find_vma: 000000400923f000

Recompiling testthread as a dynamic executable and it runs fine, leaving
itself enough space to expand the brk region at least once.

So what do we take away from this?

 * we need testcases to exercise the memory layout of dynamic binaries
 * "special" dynamic binaries can break our careful memory layout
 * I feel as though I've trodden on a nest of vipers

Does any of this track with you? What is different about ldconfig that
breaks our memory placement?

--=20
Alex Benn=C3=A9e


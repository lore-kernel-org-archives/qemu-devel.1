Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD15FC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26C4521734
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEKrc6t4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C4521734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIuxe-0002TY-62
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 10:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kIufl-0001YA-DO
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 10:14:06 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:41584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kIufh-00026G-MY
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 10:14:05 -0400
Received: by mail-io1-xd41.google.com with SMTP id z13so2324625iom.8
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 07:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4f5a4FelpglxSOiH/9a2wj6wy+Vu8Q6sy9no5WwXklg=;
 b=ZEKrc6t4iVgohJ7WSrQFAiQsw/sHbcAwaGPin1WryIXxRPgDLbQQvrCE5A4tFacnBL
 ssiPapMFoeTbeu5tBZtyx6zgtRSAQsNUKXlh9v331s+gIPvBfh5p6QMTJ9XqcCeJ8+qV
 82fJ4I2R24uQg1ipxUZU/JgkXs27RDUNVQNkjeb0aX9WotXQEoXtKB7yz7LvPJcDxXWA
 O0auqeMKxGpddKN3D/L729+j+943qbtrQys/hMIxhMqppZVv2FU2GjSzfh5DtGja3+NO
 I6lhJwR668yH+U2BewsCOGUGx8CMwnt3d8nFN1uHzLaumr6Y5w/sr9X9HPa3yCcyCxyY
 1RAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4f5a4FelpglxSOiH/9a2wj6wy+Vu8Q6sy9no5WwXklg=;
 b=tRmU36OD5xdWQgZc2X09GIFfdxJ7VXAFR5gCSVfddCelz1RbS8cJE5AsYTy9wn5ChL
 1sLJSnFcA34/WyPnlQa1UjCywJIy26R9/PE8ZiiKn+WwuYbLDqCFfZWdCposq+tzthRa
 cP7e32a9G+cCWHLTyb6qX3cQKMq3F5W2/518CSG6lgdHaQlqh1PZLluD3TqH0bf2lDnR
 E/CYsCGHIF2V3GRs6x2nREvVrbZetBGRmHBmggW5hvBHPWxZNx5fSt2RNd7vMtbTOp9M
 oPeS1PBJvH5ZsncC5YIRnxFXgtaFYM32WpByNgFdOVxpypJDdwFJa4XhI8t3Q245O8x+
 eK4A==
X-Gm-Message-State: AOAM5334rQKL7VNAk0ebm+WlhNSxax5K1Jp/yeW2YJKBMYrNctjuN6a0
 rSYgqu8hMkIrfqOTP+JDt4KBrr0NUiIgNrvRL2s=
X-Google-Smtp-Source: ABdhPJzTo6tZhy98zTbrys97PbkMu+OPcStZ9ctjNaxLa/n1OrnRO4FWLM6M/8fpBWzmUmiCaNccEGfFdL8q0JFVnAw=
X-Received: by 2002:a6b:3e84:: with SMTP id
 l126mr23179051ioa.118.1600352040361; 
 Thu, 17 Sep 2020 07:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <9435182.tdPhlSkOF2@farino> <9381423.g9G3TJQzCC@farino>
 <CAKmqyKOZ+i-zWp06GPyDNDo3ON+D5Q09e=YhPsJQOd4K9uPeVQ@mail.gmail.com>
 <2156782.iezcSG77Qx@farino>
In-Reply-To: <2156782.iezcSG77Qx@farino>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 17 Sep 2020 07:02:47 -0700
Message-ID: <CAKmqyKOW8rWSomowD9Hn+9Saa9W5QJVD3Sj7PQz7J+euMDSKAQ@mail.gmail.com>
Subject: Re: riscv32 wait() problem, qemu or glibc?
To: =?UTF-8?B?QW5kcmVhcyBLLiBIw7x0dGVs?= <dilfridge@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: GNU C Library <libc-alpha@sourceware.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 17, 2020 at 3:16 AM Andreas K. H=C3=BCttel <dilfridge@gentoo.or=
g> wrote:
>
> Am Donnerstag, 17. September 2020, 00:05:10 EEST schrieb Alistair Francis=
:
> > On Wed, Sep 16, 2020 at 2:09 PM Andreas K. H=C3=BCttel <dilfridge@gento=
o.org>
> wrote:
> > > > My guess is that somewhere in QEMU the types don't match what RV32 =
is
> > > > using. It's probably worth printing out the size, alignment and val=
ue
> > > > of everything at every stage and see what breaks.
> > >
> > > Thanks.
> >
> > Sorry I can't be more helpful. Hopefully one day I will look into it,
> > but it's not a high priority.
>
> No problem at all. I'm mostly going to postpone this now in favour of
> autobuilding bootable images (which needs some non-riscv specific
> preparation).
>
> Last thing I still did overnight was run the glibc testsuite in quemu-ris=
cv32
> user emulation. The summary is below (and as suspected a bit of a massacr=
e);
> I'll look at the details later sometime.
> If anyone else wants to poke at it, I've tarred up the full glibc build d=
ir
> and uploaded it together with the build log, see
> https://dev.gentoo.org/~dilfridge/rv32-testing/
>
> UNSUPPORTED: crypt/cert
> FAIL: debug/tst-backtrace4
> FAIL: debug/tst-backtrace5
> FAIL: debug/tst-backtrace6
> FAIL: elf/check-localplt
> UNSUPPORTED: elf/tst-dlopen-self-container
> UNSUPPORTED: elf/tst-dlopen-tlsmodid-container
> XPASS: elf/tst-latepthread
> UNSUPPORTED: elf/tst-ldconfig-bad-aux-cache
> UNSUPPORTED: elf/tst-ldconfig-ld_so_conf-update
> UNSUPPORTED: elf/tst-pldd
> XPASS: elf/tst-protected1a
> XPASS: elf/tst-protected1b
> FAIL: iconv/tst-iconv_prog
> UNSUPPORTED: io/tst-copy_file_range
> UNSUPPORTED: io/tst-getcwd-abspath
> FAIL: libio/tst-atime
> UNSUPPORTED: locale/tst-localedef-path-norm
> UNSUPPORTED: localedata/tst-localedef-hardlinks
> FAIL: malloc/tst-dynarray-fail
> FAIL: malloc/tst-dynarray-fail-mem
> FAIL: malloc/tst-interpose-nothread
> FAIL: malloc/tst-interpose-static-nothread
> FAIL: malloc/tst-interpose-static-thread
> FAIL: malloc/tst-interpose-thread
> FAIL: malloc/tst-mallocfork2
> UNSUPPORTED: malloc/tst-mallocstate
> FAIL: math/test-double-j1
> FAIL: math/test-double-y0
> UNSUPPORTED: math/test-fesetexcept-traps
> UNSUPPORTED: math/test-fexcept-traps
> FAIL: math/test-float-asinh
> FAIL: math/test-float-cos
> FAIL: math/test-float-cosh
> FAIL: math/test-float-erfc
> FAIL: math/test-float-exp
> FAIL: math/test-float-j0
> FAIL: math/test-float-j1
> FAIL: math/test-float-lgamma
> FAIL: math/test-float-sin
> FAIL: math/test-float-tgamma
> FAIL: math/test-float-y0
> FAIL: math/test-float32-asinh
> FAIL: math/test-float32-cos
> FAIL: math/test-float32-cosh
> FAIL: math/test-float32-erfc
> FAIL: math/test-float32-exp
> FAIL: math/test-float32-j0
> FAIL: math/test-float32-j1
> FAIL: math/test-float32-lgamma
> FAIL: math/test-float32-sin
> FAIL: math/test-float32-tgamma
> FAIL: math/test-float32-y0
> FAIL: math/test-float32x-j1
> FAIL: math/test-float32x-y0
> FAIL: math/test-float64-j1
> FAIL: math/test-float64-y0
> UNSUPPORTED: math/test-matherr
> UNSUPPORTED: math/test-matherr-2
> UNSUPPORTED: math/test-nearbyint-except
> UNSUPPORTED: math/test-nearbyint-except-2
> FAIL: misc/test-errno-linux
> FAIL: misc/tst-clone2
> FAIL: misc/tst-clone3
> FAIL: misc/tst-gettid-kill
> FAIL: misc/tst-glibcsyscalls
> FAIL: misc/tst-memfd_create
> FAIL: misc/tst-mlock2
> UNSUPPORTED: misc/tst-ofdlocks-compat
> UNSUPPORTED: misc/tst-pkey
> FAIL: misc/tst-sigcontext-get_pc
> UNSUPPORTED: misc/tst-ttyname
> UNSUPPORTED: nptl/test-cond-printers
> UNSUPPORTED: nptl/test-condattr-printers
> UNSUPPORTED: nptl/test-mutex-printers
> UNSUPPORTED: nptl/test-mutexattr-printers
> UNSUPPORTED: nptl/test-rwlock-printers
> UNSUPPORTED: nptl/test-rwlockattr-printers
> FAIL: nptl/tst-align-clone
> FAIL: nptl/tst-cancel-self-canceltype
> FAIL: nptl/tst-cancel17
> FAIL: nptl/tst-cancel21
> FAIL: nptl/tst-cancel21-static
> FAIL: nptl/tst-cancel24
> FAIL: nptl/tst-cancel24-static
> FAIL: nptl/tst-cancelx16
> FAIL: nptl/tst-cancelx17
> FAIL: nptl/tst-cancelx18
> FAIL: nptl/tst-cancelx20
> FAIL: nptl/tst-cancelx21
> FAIL: nptl/tst-cancelx4
> FAIL: nptl/tst-cancelx5
> FAIL: nptl/tst-cleanupx4
> FAIL: nptl/tst-cond-except
> FAIL: nptl/tst-cond24
> FAIL: nptl/tst-cond25
> FAIL: nptl/tst-getpid1
> UNSUPPORTED: nptl/tst-mutexpi5
> UNSUPPORTED: nptl/tst-mutexpi5a
> UNSUPPORTED: nptl/tst-mutexpi9
> FAIL: nptl/tst-oncex3
> FAIL: nptl/tst-oncex4
> UNSUPPORTED: nptl/tst-pthread-getattr
> FAIL: nptl/tst-robust-fork
> FAIL: nptl/tst-robust1
> FAIL: nptl/tst-robust2
> FAIL: nptl/tst-robust3
> FAIL: nptl/tst-robust4
> FAIL: nptl/tst-robust5
> FAIL: nptl/tst-robust6
> FAIL: nptl/tst-robust7
> FAIL: nptl/tst-robust8
> FAIL: nptl/tst-robust9
> XPASS: nptl/tst-stack4
> UNSUPPORTED: nss/tst-nss-db-endgrent
> UNSUPPORTED: nss/tst-nss-db-endpwent
> UNSUPPORTED: nss/tst-nss-files-alias-leak
> UNSUPPORTED: nss/tst-nss-files-alias-truncated
> UNSUPPORTED: nss/tst-nss-files-hosts-erange
> UNSUPPORTED: nss/tst-nss-files-hosts-getent
> UNSUPPORTED: nss/tst-nss-files-hosts-long
> UNSUPPORTED: nss/tst-nss-test3
> FAIL: posix/test-errno
> FAIL: posix/tst-fexecve
> UNSUPPORTED: posix/tst-glob_lstat_compat
> FAIL: posix/tst-posix_spawn-setsid
> FAIL: posix/tst-spawn2
> FAIL: posix/tst-spawn4
> UNSUPPORTED: posix/tst-spawn4-compat
> UNSUPPORTED: posix/tst-sysconf-empty-chroot
> FAIL: posix/tst-wait4
> UNSUPPORTED: resolv/tst-p_secstodate
> UNSUPPORTED: resolv/tst-resolv-res_init
> UNSUPPORTED: resolv/tst-resolv-res_init-thread
> UNSUPPORTED: resolv/tst-resolv-threads
> FAIL: rt/tst-aio4
> FAIL: rt/tst-mqueue3
> FAIL: rt/tst-mqueue5
> FAIL: rt/tst-mqueue6
> FAIL: rt/tst-mqueue8x
> FAIL: stdio-common/tst-vfprintf-width-prec
> FAIL: stdio-common/tst-vfprintf-width-prec-mem
> UNSUPPORTED: stdlib/tst-system
> UNSUPPORTED: string/tst-strerror
> UNSUPPORTED: string/tst-strsignal
> XPASS: support/tst-support_descriptors
> FAIL: sysvipc/test-sysvmsg
> FAIL: sysvipc/test-sysvsem
> Summary of test results:
>      95 FAIL
>    3971 PASS
>      48 UNSUPPORTED
>      17 XFAIL
>       5 XPASS
> make[1]: *** [Makefile:634: tests] Error 1

That's actually not too bad. A lot of those are grouped, so fixing one
test should fix a few. Some of them are probably because QEMU is
missing the new syscall.

Some math failures occur in softmmu as well. The guess is that it's
due to bugs in QEMUs float, but I haven't investigated yet.

Alistair

>
>
>
>
>
>
>
> >
> > > > AFAIK RV32 linux-user mode is pretty much un-tested. So their might=
 be
> > > > all sorts of issues with it unfortunately.
> > >
> > > Would you consider qemu system mode more reliable?
> >
> > Yes. For RISC-V the softmmu implementations are much more thoroughly te=
sted.
> > > I need to prepare some bootable riscv gentoo images eventually anyway=
.
> > > Might as well try a riscv32 one for comparison then if that is more
> > > promising.
> > It would be great to have more distros supporting RV32.
> >
> > Alistair
> >
> > > --
> > > Andreas K. H=C3=BCttel
> > > dilfridge@gentoo.org
> > > Gentoo Linux developer
> > > (council, qa, toolchain, base-system, perl, libreoffice)
>
>
> --
> Andreas K. H=C3=BCttel
> dilfridge@gentoo.org
> Gentoo Linux developer
> (council, qa, toolchain, base-system, perl, libreoffice)


Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88801C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C393206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEQ5WEvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C393206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHl8T-0002HV-5i
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 05:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kHl7T-0001Yv-MB
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:49:55 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:50455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kHl7R-0004Ql-VZ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:49:55 -0400
Received: by mail-wm1-x32f.google.com with SMTP id e17so9985346wme.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 02:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=2lXVSaEhrEdCQfBpaMduexmEQfuqn37vqwGeLVLDKPo=;
 b=WEQ5WEvz7psBm4/ZxoaCeur+iTWtUoj+61WRzdBFZi9rWHOyA0bw7ZmcwyNDmLPq5V
 CTd5i6TlhvMJffmnEkwZLldN9mJfLFiGqAIneVl5AZZbDcDEQw5KJy6isaZtCLY946Cm
 BxZHazik2/6j36bOuhLMKhXwzZw3rqVmZ4naQPvtyiEgc3RXQfUKm5MLRYrvUn2MndYz
 l6GvHIKoViQA6Ze0WPPh2d9PiBVVIPRA9IiWxyfE2oy/N2VvUDVAfo8OqYrX69ZiZHFR
 KQUknoNp8Q6WcVbljy8zhXCk08Ydi0uzG6AZ6SvCXH0KrfI2f3fFs31iq+bnaQT8UyUs
 VrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2lXVSaEhrEdCQfBpaMduexmEQfuqn37vqwGeLVLDKPo=;
 b=Y0axqiETfBx+uf/9VGlSTmu7IBDaF6Vtf80FyoBwqtoIjxi5rUL2XfCPJBazq0lpNt
 tMB1j3kxapB4oLoR0UlSMpxYmlBgcOGkH1lSUpIXdptdI2i1p7REMFY8UQcFh5UlMO25
 J9wuiAiU7Z2Lj6kCrv4aGxTpHLrNALhSxGiKzvR4ZPUEOhjwd7PBxZcc59Wn5ColzWA2
 V7U+DNA2bIBBMKs+BSnejN78ZBF8d7OhTxnCkS9pF343SWWMKDvPgrlAL5pHCZq2hMc8
 QVDntStFBQReQxgyjKCghsx21bW1yfFuEIFvVrpWCJSyNc7qlUbuA10B9LzYGisR1EJg
 5Mrw==
X-Gm-Message-State: AOAM533CskJDXILNLNQvKlqKxi8FsbgeSA3vXlQ3BLcibw9UT9rYivJp
 zT4SP9ia3GYRnkLWieC9Ff8=
X-Google-Smtp-Source: ABdhPJycR5ORjZ+CRfHsln9jkMSUnkUvX9Fgh9vvlPrHvRRVDCjEWcSVfN5J0clENdtdAN0F2qe3bw==
X-Received: by 2002:a1c:65c1:: with SMTP id z184mr5489929wmb.61.1600076991875; 
 Mon, 14 Sep 2020 02:49:51 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id h76sm19494452wme.10.2020.09.14.02.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 02:49:51 -0700 (PDT)
Date: Mon, 14 Sep 2020 10:49:49 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Bug 1895471 <1895471@bugs.launchpad.net>
Subject: Re: [Bug 1895471] [NEW] compilation error with clang in util/async.c
Message-ID: <20200914094949.GA579094@stefanha-x1.localdomain>
References: <160002337216.747.16078826830052525094.malonedeb@chaenomeles.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <160002337216.747.16078826830052525094.malonedeb@chaenomeles.canonical.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x32f.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2020 at 06:56:12PM -0000, Amey Narkhede wrote:
> configured with ` CC=3Dclang CXX=3Dclang++ ../configure --target-
> list=3Dx86_64-softmmu --enable-kvm --enable-curl --enable-debug --enable-
> jemalloc --enable-fuzzing --enable-sdl` and after make I get the
> following error related to c11 atomics. I'm using clang because I'm
> experimenting with fuzzer
>=20
> [glitz@archlinux /code/qemu/build]$ ninja -j5
> [479/2290] Compiling C object libqemuutil.a.p/util_async.c.o
> FAILED: libqemuutil.a.p/util_async.c.o
> clang -Ilibqemuutil.a.p -I. -I.. -Iqapi -Itrace -Iui -Iui/shader -I/usr/i=
nclude/p11-kit-1 -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include -I/usr=
/include/libmount -I/usr/include/blkid -I/usr/include/gio-unix-2.0 -Ilinux-=
headers -Xclang -fcolor-diagnostics -pipe -Wall -Winvalid-pch -Werror -std=
=3Dgnu99 -g -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE=
_SOURCE -Wstrict-prototypes -Wredundant-decls -Wundef -Wwrite-strings -Wmis=
sing-prototypes -fno-strict-aliasing -fno-common -fwrapv -Wold-style-defini=
tion -Wtype-limits -Wformat-security -Wformat-y2k -Winit-self -Wignored-qua=
lifiers -Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined=
 -Wno-initializer-overrides -Wno-missing-include-dirs -Wno-shift-negative-v=
alue -Wno-string-plus-int -Wno-typedef-redefinition -Wno-tautological-type-=
limit-compare -fstack-protector-strong -fsanitize=3Dfuzzer-no-link -iquote =
/code/qemu/tcg/i386 -isystem /code/qemu/linux-headers -iquote . -iquote /co=
de/qemu -iquote /code/qemu/accel/tcg -iquote /code/qemu/include -iquote /co=
de/qemu/disas/libvixl -pthread -fPIC -MD -MQ libqemuutil.a.p/util_async.c.o=
 -MF libqemuutil.a.p/util_async.c.o.d -o libqemuutil.a.p/util_async.c.o -c =
=2E./util/async.c
> ../util/async.c:79:17: error: address argument to atomic operation must b=
e a pointer to _Atomic type ('unsigned int *' invalid)
>     old_flags =3D atomic_fetch_or(&bh->flags, BH_PENDING | new_flags);
>                 ^               ~~~~~~~~~~
> /usr/lib/clang/10.0.1/include/stdatomic.h:138:42: note: expanded from mac=
ro 'atomic_fetch_or'
> #define atomic_fetch_or(object, operand) __c11_atomic_fetch_or(object, op=
erand, __ATOMIC_SEQ_CST)
>                                          ^                     ~~~~~~
> ../util/async.c:105:14: error: address argument to atomic operation must =
be a pointer to _Atomic type ('unsigned int *' invalid)
>     *flags =3D atomic_fetch_and(&bh->flags,
>              ^                ~~~~~~~~~~
> /usr/lib/clang/10.0.1/include/stdatomic.h:144:43: note: expanded from mac=
ro 'atomic_fetch_and'
> #define atomic_fetch_and(object, operand) __c11_atomic_fetch_and(object, =
operand, __ATOMIC_SEQ_CST)
>                                           ^                      ~~~~~~
> 2 errors generated.
> [483/2290] Compiling C object libqemuutil.a.p/util_qemu-error.c.o
> ninja: build stopped: subcommand failed.

This happens when a system header file includes <stdatomic.h>. QEMU's
"atomic.h" conflicts with <stdatomic.h> in that QEMU atomic variables do
not need to be declared _Atomic.

Please rerun the full clang command-line above from your meson build
directory with -E instead of -c. Then upload the
libqemuutil.a.p/util_async.c.o so we can see why stdatomic.h was
included.

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9fPL0ACgkQnKSrs4Gr
c8iFvAf/RxwCT+RlucIvDXVRVLagJfiytXB7tzFmhX3LZAHD8Ce9DipdcSwrSJnv
Yb8uG5R1WANQRahPnk6JFHUS2beIfICVTAyl8AI/dMbj7jwvWeaxw8Ehq9OvpV4e
urlhgKqGTmaHHINlht6CIJfDYZeQGoetSfa/phJjrGh0VymmfS9ubtLck6ncG8ZA
uuT7PQ2TdB9rBw+2sbvTAYF0eac3qlQe7cdmSgFp//V8CwUCMTBmaQsREa7ICaq3
c4h2K3ZvUtK8xqJYANO6J579Qc6HyX8UWkODW0VGKmMB3WruX6eKp6mcpTnOJTGr
x+bPKy4zj7HlAXFW0rk834T6mcsdog==
=Jc1x
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--


Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C29C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80706206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vp35Xr5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80706206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgCVP-0006mo-Re
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 15:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgCUN-0005rR-1B
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:22:19 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgCUL-0003hb-Dv
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:22:18 -0400
Received: by mail-wr1-x441.google.com with SMTP id p5so4527298wrw.9
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 12:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=RHMr1PhcS1mj4xJC3h3y6LGc8yt+5J8Ma0TISxznwts=;
 b=vp35Xr5JAIU+1+O69mYuRgElgyORXOlkiIHdexL8hRJfL3FwDXfyHLtUAy0bhQxCUg
 wgA156NWkJHjYr9LBaChWsQH/nJWaxVA1ohHLkhjCRbHpUgpU0WsAY5J8eyNmixkwH8v
 OUK/Qid4I+Um65T02ei1L3LK2rrQ+ko/Ow7gX72EIpLCn0n3KWTgFZ9Ne59sXdyMRNeF
 jK1E4vC1XDflJ7yi3NtNv3E216soR2YS8qAMxWcV4u4BYy6lRNeEc65mYLPzFBaXLkQp
 S82HQYv8YuuDNBihCmOI1m5OAfsgk3MSb38ysUBH9pfs3fo/3j9z020z992Me6MOlxzq
 I7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=RHMr1PhcS1mj4xJC3h3y6LGc8yt+5J8Ma0TISxznwts=;
 b=KwdawHAi1Uh1JfGAZdCxn0qOBf5h2m5nO3dCrjgCIf3iqV+k9ftv+wJYvsZti002Wg
 KZXkUIOEceIXxaesu4KRia8CO5RpDxTbBQjyRxlwyIOkwHZsbv7/yDwyr6PGRXtzuEdX
 50ybPg4mSEPOJ2G1TS8Y4d255C7GIR+IFOn6nMbnbA520sz5td5RY7Dtj9msaePlQbuC
 EZaZkJlhiMT3VLmFH12bB2n61+CsTUX2jMETrsD1IvQllznyVVJOII/fTffBaccJPFUX
 Pwhb2SHWL/37J2oKz2xf7J6g9WpyE6Zv/ugT442SRmAnHlSo9/iV0HO8RCSvGAaiuFmo
 oZzA==
X-Gm-Message-State: AOAM531o5ZAZRPhXeWyFGuiSt2+bRC2BWGVS9lc7ywX6k5j/oJSUEkyP
 KZzsWItk/9GoKzosoAziPx69uw==
X-Google-Smtp-Source: ABdhPJypTDuoK6j7XEg4zvYkXH25de1UMlVdEYHqDxUT12RM8m8aLYTpQ1LcfcsxOiX4+gTNbMeLKg==
X-Received: by 2002:adf:f446:: with SMTP id f6mr27556823wrp.59.1591125735935; 
 Tue, 02 Jun 2020 12:22:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j68sm5383126wrj.28.2020.06.02.12.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 12:22:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BBF041FF7E;
 Tue,  2 Jun 2020 20:22:13 +0100 (BST)
References: <20200529132341.755-1-robert.foley@linaro.org>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v1 01/12] configure: add --enable-tsan flag + fiber
 annotations for coroutine-ucontext
In-reply-to: <20200529132341.755-1-robert.foley@linaro.org>
Date: Tue, 02 Jun 2020 20:22:13 +0100
Message-ID: <87eeqx6zoa.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, cota@braap.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Lingfeng Yang <lfy@google.com>,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> From: Lingfeng Yang <lfy@google.com>
>
> We tried running QEMU under tsan in 2016, but tsan's lack of support for
> longjmp-based fibers was a blocker:
>   https://groups.google.com/forum/#!topic/thread-sanitizer/se0YuzfWazw
>
> Fortunately, thread sanitizer gained fiber support in early 2019:
>   https://reviews.llvm.org/D54889
>
> This patch brings tsan support upstream by importing the patch that annot=
ated
> QEMU's coroutines as tsan fibers in Android's QEMU fork:
>   https://android-review.googlesource.com/c/platform/external/qemu/+/8446=
75
>
> Tested with '--enable-tsan --cc=3Dclang-9 --cxx=3Dclang++-9 --disable-wer=
ror'
> configure flags.
>
> Signed-off-by: Lingfeng Yang <lfy@google.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> [cota: minor modifications + configure changes]
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> [RF: Error out in configure if tsan not available, fix checkpatch warning=
s]
> ---
>  configure                 | 41 +++++++++++++++++
>  util/coroutine-ucontext.c | 97 +++++++++++++++++++++++++++++++++++----
>  2 files changed, 129 insertions(+), 9 deletions(-)
>
> diff --git a/configure b/configure
> index b969dee675..c18efae65e 100755
> --- a/configure
> +++ b/configure
> @@ -395,6 +395,7 @@ gprof=3D"no"
>  debug_tcg=3D"no"
>  debug=3D"no"
>  sanitizers=3D"no"
> +tsan=3D"no"
>  fortify_source=3D""
>  strip_opt=3D"yes"
>  tcg_interpreter=3D"no"
> @@ -1150,6 +1151,10 @@ for opt do
>    ;;
>    --disable-sanitizers) sanitizers=3D"no"
>    ;;
> +  --enable-tsan) tsan=3D"yes"
> +  ;;
> +  --disable-tsan) tsan=3D"no"
> +  ;;
>    --enable-sparse) sparse=3D"yes"
>    ;;
>    --disable-sparse) sparse=3D"no"
> @@ -1750,6 +1755,7 @@ Advanced options (experts only):
>    --with-pkgversion=3DVERS   use specified string as sub-version of the =
package
>    --enable-debug           enable common debug build options
>    --enable-sanitizers      enable default sanitizers
> +  --enable-tsan            enable thread sanitizer
>    --disable-strip          disable stripping binaries
>    --disable-werror         disable compilation abort on warning
>    --disable-stack-protector disable compiler-provided stack protection
> @@ -6192,6 +6198,27 @@ if test "$fuzzing" =3D "yes" ; then
>    fi
>  fi
>=20=20
> +# Thread sanitizer is, for now, much noisier than the other sanitizers;
> +# keep it separate until that is not the case.

I think we also need to stop both being enabled at once. On my clang-9
setup I get:

  make: *** [qapi/qobject-output-visitor.o] Error 1
  clang: error: invalid argument '-fsanitize=3Daddress' not allowed with '-=
fsanitize=3Dthread'
  clang: error: invalid argument '-fsanitize=3Daddress' not allowed with '-=
fsanitize=3Dthread'
  clang: errorclang: : errorinvalid argument '-fsanitize=3Daddress' not all=
owed with '-fsanitize=3Dthread':
  invalid argument '-fsanitize=3Daddress' not allowed with '-fsanitize=3Dth=
read'
  clang: error: invalid argument '-fsanitize=3Daddress' not allowed with '-=
fsanitize=3Dthread'

> +have_tsan=3Dno
> +have_tsan_iface_fiber=3Dno
> +if test "$tsan" =3D "yes" ; then
> +  write_c_skeleton
> +  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Dthread" "" ; then
> +      have_tsan=3Dyes
> +  fi
> +  cat > $TMPC << EOF
> +#include <sanitizer/tsan_interface.h>
> +int main(void) {
> +  __tsan_create_fiber(0);
> +  return 0;
> +}
> +EOF
> +  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Dthread" "" ; then
> +      have_tsan_iface_fiber=3Dyes
> +  fi
> +fi
> +
>  ##########################################
>  # check for libpmem
>=20=20
> @@ -6293,6 +6320,16 @@ if test "$have_asan" =3D "yes"; then
>             "Without code annotation, the report may be inferior."
>    fi
>  fi
> +if test "$have_tsan" =3D "yes" ; then
> +  if test "$have_tsan_iface_fiber" =3D "yes" ; then
> +    QEMU_CFLAGS=3D"-fsanitize=3Dthread $QEMU_CFLAGS"
> +    QEMU_LDFLAGS=3D"-fsanitize=3Dthread $QEMU_LDFLAGS"
> +  else
> +    error_exit "Cannot enable TSAN due to missing fiber annotation inter=
face."
> +  fi
> +elif test "$tsan" =3D "yes" ; then
> +  error_exit "Cannot enable TSAN due to missing sanitize thread interfac=
e."
> +fi
>  if test "$have_ubsan" =3D "yes"; then
>    QEMU_CFLAGS=3D"-fsanitize=3Dundefined $QEMU_CFLAGS"
>    QEMU_LDFLAGS=3D"-fsanitize=3Dundefined $QEMU_LDFLAGS"
> @@ -7382,6 +7419,10 @@ if test "$have_asan_iface_fiber" =3D "yes" ; then
>      echo "CONFIG_ASAN_IFACE_FIBER=3Dy" >> $config_host_mak
>  fi


Are we missing any LDFLAGS? On Ubuntu 18.04 with clang-9 I'm seeing:

    LINK    qemu-ga
  /usr/lib/llvm-9/lib/clang/9.0.0/lib/linux/libclang_rt.tsan-x86_64.a(tsan_=
rtl_amd64.S.o): warning: common of `__interception::real_setjmp' overridden=
 by definition
  /usr/lib/llvm-9/lib/clang/9.0.0/lib/linux/libclang_rt.tsan-x86_64.a(tsan_=
interceptors.cc.o): warning: defined here
  /usr/lib/llvm-9/lib/clang/9.0.0/lib/linux/libclang_rt.tsan-x86_64.a(tsan_=
rtl_amd64.S.o): warning: common of `__interception::real__setjmp' overridde=
n by definition
  /usr/lib/llvm-9/lib/clang/9.0.0/lib/linux/libclang_rt.tsan-x86_64.a(tsan_=
interceptors.cc.o): warning: defined here
  /usr/lib/llvm-9/lib/clang/9.0.0/lib/linux/libclang_rt.tsan-x86_64.a(tsan_=
rtl_amd64.S.o): warning: common of `__interception::real_sigsetjmp' overrid=
den by definition
  /usr/lib/llvm-9/lib/clang/9.0.0/lib/linux/libclang_rt.tsan-x86_64.a(tsan_=
interceptors.cc.o): warning: defined here
  /usr/lib/llvm-9/lib/clang/9.0.0/lib/linux/libclang_rt.tsan-x86_64.a(tsan_=
rtl_amd64.S.o): warning: common of `__interception::real___sigsetjmp' overr=
idden by definition
  /usr/lib/llvm-9/lib/clang/9.0.0/lib/linux/libclang_rt.tsan-x86_64.a(tsan_=
interceptors.cc.o): warning: defined here
  libqemuutil.a(osdep.o):/usr/lib/llvm-9/lib/clang/9.0.0/include/sanitizer/=
tsan_interface.h:41: multiple definition of `__tsan_mutex_linker_init'
  libqemuutil.a(control.o):/usr/lib/llvm-9/lib/clang/9.0.0/include/sanitize=
r/tsan_interface.h:41: first defined here
  libqemuutil.a(osdep.o):/usr/lib/llvm-9/lib/clang/9.0.0/include/sanitizer/=
tsan_interface.h:50: multiple definition of `__tsan_mutex_not_static'
  libqemuutil.a(control.o):/usr/lib/llvm-9/lib/clang/9.0.0/include/sanitize=
r/tsan_interface.h:50: first defined here
  libqemuutil.a(osdep.o):/usr/lib/llvm-9/lib/clang/9.0.0/include/sanitizer/=
tsan_interface.h:55: multiple definition of `__tsan_mutex_read_lock'
  libqemuutil.a(control.o):/usr/lib/llvm-9/lib/clang/9.0.0/include/sanitize=
r/tsan_interface.h:55: first defined here
  libqemuutil.a(osdep.o):/usr/lib/llvm-9/lib/clang/9.0.0/include/sanitizer/=
tsan_interface.h:45: multiple definition of `__tsan_mutex_read_reentrant'
  libqemuutil.a(control.o):/usr/lib/llvm-9/lib/clang/9.0.0/include/sanitize=
r/tsan_interface.h:45: first defined here
  libqemuutil.a(osdep.o):/usr/lib/llvm-9/lib/clang/9.0.0/include/sanitizer/=
tsan_interface.h:64: multiple definition of `__tsan_mutex_recursive_lock'
  libqemuutil.a(control.o):/usr/lib/llvm-9/lib/clang/9.0.0/include/sanitize=
r/tsan_interface.h:64: first defined here
  libqemuutil.a(osdep.o):/usr/lib/llvm-9/lib/clang/9.0.0/include/sanitizer/=
tsan_interface.h:68: multiple definition of `__tsan_mutex_recursive_unlock'

<snip>

--=20
Alex Benn=C3=A9e


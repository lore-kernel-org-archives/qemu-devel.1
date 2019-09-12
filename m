Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF019C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A6D82081B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lxdJaGEX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6D82081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Nj0-0006Nb-HZ
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 07:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8Nhq-0005Su-Dz
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8Nho-0006dN-Vj
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:56:10 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37050)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8Nho-0006cn-NV
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:56:08 -0400
Received: by mail-wm1-x344.google.com with SMTP id r195so7351385wme.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 04:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=/iTD3XNZ6c6EFIqRm6vu58w0o/MXtO2LsP01Op1mlGQ=;
 b=lxdJaGEX2qUEKR+pB2I1LYZhV9R3hCi0N945ttdlsiG6zphmXMmbLeQZiDekwSDCoI
 Qi1d/M5cchvrdYl1JbdgfwWNtM/Kk/qh92+hBAn22Qr5zXAPMv/7qKGMTAX/+rDhEtA/
 eDk/9+hBzIgRPTyZY14BEAvXi17t1XQpSFt+IuYTnEL/o58qyimlT36ixwwkp1IdyYkz
 u/msz1mxd8az7XOMJMRn20CNIkUXmGgEVjh8RWpiFsnsZ21dQiU2f33rry0VfK23hyVt
 4h1YwdWFB7UTreF9O/jmPzFyA6nA8ySDkX6CRAH2QNN7KtLtYeCMA2GhzjH0b3iNVo0o
 gVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=/iTD3XNZ6c6EFIqRm6vu58w0o/MXtO2LsP01Op1mlGQ=;
 b=dRrMgr/l0dii5o3AlU+p0ie6kHEy2OWWWjZ5tHwZo7tcb4Kc20ZqoOsq+PiRZ18HSw
 M9+Pl2s1gix4zDA2VbUdsv2J4GoaXXg/jAnJYlb4FHumc2tF9pTDDldft+SwsqQdWZJ0
 YRuXDXmFxuwxFD/S5RN7ANU0xWGFmjetOGXlj7G6JnSI3b3xYEJfZWc44vLKVp6nQ8y6
 3sBpWsocOmL9QkKquuSjUiEmpi95ZVgh0D44zJjdVSegnKyevbNBn86L+Sj+SkeYKsue
 izGDV5ipLRbn4pjqNPQIWcEvmF4kclWwFlVbUDIbGrjxkO7qiJdehNng010SsYSgiE/3
 bFxA==
X-Gm-Message-State: APjAAAXXrkygbMWlmKVgBfbllVRt73OsfaHMmZtzJKk2x/79H7ro1SsC
 mbJtfP4jG9hrvAw82DMNsOCwYQ==
X-Google-Smtp-Source: APXvYqwYkwLsbQ0E3C45lkvg1aWgxA6ztt+eMBThoUiVz98l2DPMeVDvgXtLiRfOuLDcLra8il9j7w==
X-Received: by 2002:a1c:6c0c:: with SMTP id h12mr2158771wmc.162.1568289366762; 
 Thu, 12 Sep 2019 04:56:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q15sm6691142wmb.28.2019.09.12.04.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 04:56:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 43FEF1FF87;
 Thu, 12 Sep 2019 12:56:05 +0100 (BST)
References: <20190910144428.32597-1-peter.maydell@linaro.org>
 <20190910144428.32597-12-peter.maydell@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190910144428.32597-12-peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 12:56:05 +0100
Message-ID: <87blvpzq22.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 11/13] target/arm/arm-semi:
 Implement support for semihosting feature detection
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


Peter Maydell <peter.maydell@linaro.org> writes:

> Version 2.0 of the semihosting specification added support for
> allowing a guest to detect whether the implementation supported
> particular features. This works by the guest opening a magic
> file ":semihosting-features", which contains a fixed set of
> data with some magic numbers followed by a sequence of bytes
> with feature flags. The file is expected to behave sensibly
> for the various semihosting calls which operate on files
> (SYS_FLEN, SYS_SEEK, etc).
>
> Implement this as another kind of guest FD using our function
> table dispatch mechanism. Initially we report no extended
> features, so we have just one feature flag byte which is zero.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

with your EACCESS suggestion:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/arm-semi.c | 107 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 106 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index f9019b00b8d..531084b7799 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -117,6 +117,7 @@ typedef enum GuestFDType {
>      GuestFDUnused =3D 0,
>      GuestFDHost =3D 1,
>      GuestFDGDB =3D 2,
> +    GuestFDFeatureFile =3D 3,
>  } GuestFDType;
>
>  /*
> @@ -125,7 +126,10 @@ typedef enum GuestFDType {
>   */
>  typedef struct GuestFD {
>      GuestFDType type;
> -    int hostfd;
> +    union {
> +        int hostfd;
> +        target_ulong featurefile_offset;
> +    };
>  } GuestFD;
>
>  static GArray *guestfd_array;
> @@ -467,6 +471,87 @@ static uint32_t gdb_flenfn(TaskState *ts, ARMCPU *cp=
u, GuestFD *gf)
>                             gf->hostfd, arm_flen_buf(cpu));
>  }
>
> +#define SHFB_MAGIC_0 0x53
> +#define SHFB_MAGIC_1 0x48
> +#define SHFB_MAGIC_2 0x46
> +#define SHFB_MAGIC_3 0x42
> +
> +static const uint8_t featurefile_data[] =3D {
> +    SHFB_MAGIC_0,
> +    SHFB_MAGIC_1,
> +    SHFB_MAGIC_2,
> +    SHFB_MAGIC_3,
> +    0, /* Feature byte 0 */
> +};
> +
> +static void init_featurefile_guestfd(int guestfd)
> +{
> +    GuestFD *gf =3D do_get_guestfd(guestfd);
> +
> +    assert(gf);
> +    gf->type =3D GuestFDFeatureFile;
> +    gf->featurefile_offset =3D 0;
> +}
> +
> +static uint32_t featurefile_closefn(TaskState *ts, ARMCPU *cpu, GuestFD =
*gf)
> +{
> +    /* Nothing to do */
> +    return 0;
> +}
> +
> +static uint32_t featurefile_writefn(TaskState *ts, ARMCPU *cpu, GuestFD =
*gf,
> +                                    target_ulong buf, uint32_t len)
> +{
> +    /* This fd can never be open for writing */
> +    errno =3D EBADF;
> +    return set_swi_errno(ts, -1);
> +}
> +
> +static uint32_t featurefile_readfn(TaskState *ts, ARMCPU *cpu, GuestFD *=
gf,
> +                                   target_ulong buf, uint32_t len)
> +{
> +    uint32_t i;
> +#ifndef CONFIG_USER_ONLY
> +    CPUARMState *env =3D &cpu->env;
> +#endif
> +    char *s;
> +
> +    s =3D lock_user(VERIFY_WRITE, buf, len, 0);
> +    if (!s) {
> +        return len;
> +    }
> +
> +    for (i =3D 0; i < len; i++) {
> +        if (gf->featurefile_offset >=3D sizeof(featurefile_data)) {
> +            break;
> +        }
> +        s[i] =3D featurefile_data[gf->featurefile_offset];
> +        gf->featurefile_offset++;
> +    }
> +
> +    unlock_user(s, buf, len);
> +
> +    /* Return number of bytes not read */
> +    return len - i;
> +}
> +
> +static uint32_t featurefile_isattyfn(TaskState *ts, ARMCPU *cpu, GuestFD=
 *gf)
> +{
> +    return 0;
> +}
> +
> +static uint32_t featurefile_seekfn(TaskState *ts, ARMCPU *cpu, GuestFD *=
gf,
> +                                   target_ulong offset)
> +{
> +    gf->featurefile_offset =3D offset;
> +    return 0;
> +}
> +
> +static uint32_t featurefile_flenfn(TaskState *ts, ARMCPU *cpu, GuestFD *=
gf)
> +{
> +    return sizeof(featurefile_data);
> +}
> +
>  typedef struct GuestFDFunctions {
>      sys_closefn *closefn;
>      sys_writefn *writefn;
> @@ -493,6 +578,14 @@ static const GuestFDFunctions guestfd_fns[] =3D {
>          .seekfn =3D gdb_seekfn,
>          .flenfn =3D gdb_flenfn,
>      },
> +    [GuestFDFeatureFile] =3D {
> +        .closefn =3D featurefile_closefn,
> +        .writefn =3D featurefile_writefn,
> +        .readfn =3D featurefile_readfn,
> +        .isattyfn =3D featurefile_isattyfn,
> +        .seekfn =3D featurefile_seekfn,
> +        .flenfn =3D featurefile_flenfn,
> +    },
>  };
>
>  /* Read the input value from the argument block; fail the semihosting
> @@ -586,6 +679,18 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>              unlock_user(s, arg0, 0);
>              return guestfd;
>          }
> +        if (strcmp(s, ":semihosting-features") =3D=3D 0) {
> +            unlock_user(s, arg0, 0);
> +            /* We must fail opens for modes other than 0 ('r') or 1 ('rb=
') */
> +            if (arg1 !=3D 0 && arg1 !=3D 1) {
> +                dealloc_guestfd(guestfd);
> +                errno =3D EINVAL;
> +                return set_swi_errno(ts, -1);
> +            }
> +            init_featurefile_guestfd(guestfd);
> +            return guestfd;
> +        }
> +
>          if (use_gdb_syscalls()) {
>              ret =3D arm_gdb_syscall(cpu, arm_semi_cb, "open,%s,%x,1a4", =
arg0,
>                                    (int)arg2+1, gdb_open_modeflags[arg1]);


--
Alex Benn=C3=A9e


Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71CEC4CECB
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:15:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF14208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sLGW+O+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF14208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8N4U-0002Y8-N4
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 07:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8N2C-0000fY-5l
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:13:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8N2A-0006te-VI
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:13:08 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46900)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8N2A-0006tK-O8
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:13:06 -0400
Received: by mail-wr1-x441.google.com with SMTP id d17so15210429wrq.13
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 04:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=kvB9JmDJfz0uX5RhQq1pw00isBpwiDvTZQHcqdRPnoI=;
 b=sLGW+O+PfJSukmNV2HJ8EgtsjKiHF1jOf/veWPMDk/Zc0TXtv068H5QGqL4ZZWjyPQ
 NPQGDVYpZR5epSAZnimcdMaFs++QSIZk+gHSpJrMuwL2MSLKaokRts+3rdWuS7Pf0p/r
 1fjqNN3SIl3aQOZoALOzX+O+hYSCcRtdOWXElb0SL7HUZZXhlRZOUkCEkTsdSz/UW9dJ
 NwomdoeoBjyjF1nLXA53kuLd5G4h7GNRtS1KtyRnMx/x3YOv9YSKMyLluKNJxsWb6E96
 NsEyq7mAOUIr3f6OiYyfyZmd/mgEGvZpvP3AglK9xOdgtc1voqvwi+di81Vhr4C53Fwo
 lZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=kvB9JmDJfz0uX5RhQq1pw00isBpwiDvTZQHcqdRPnoI=;
 b=AmTXgmQvKo+LOwsKuoUa1cZtfxwcs2/TWshaAd7KhhrJ7JQ7ASt6QYmeBPdRJdJdYY
 v96qwaWeLyCv8G8rw1LQdMMC4ylG+/MGqyLKggzaP5PgyIIAjSePUFfXVMER8taaKsnN
 003ZIOJPj7LDH3rAakYEiEBRVw4A7rHCTL52+NaChOq3Fc6P2qwg7KXmDgDmneNHXXnh
 j36rdqcahIQ4NtHm0dPfZUqdmm+kue6OIsnc84GGhwBmv53hergRMAxKCCUUnkRywKro
 Yaw2Rt8to5Vwgb8MKcmt4srGct5v+hLDXIpnRKCb033b9XdrxoBbjWHj2TQ7XR6L0KJ4
 T2tA==
X-Gm-Message-State: APjAAAV46zNtDCSOlLTrs7n0uh3FXqNqvOH+SsRIMkXO+SXo2Bvms82q
 8R7jWj0MEwACn18y7OtWhahuJPT3334=
X-Google-Smtp-Source: APXvYqzdoLiRI9OXtdRLj7lMeXyMDf1DYGsj5DjN/ceA7oBLYF+hHiUdtwyLKs0kl6N3t8Q2a1Wj7A==
X-Received: by 2002:adf:e548:: with SMTP id z8mr34290861wrm.324.1568286785547; 
 Thu, 12 Sep 2019 04:13:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q192sm8122126wme.23.2019.09.12.04.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 04:13:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 431171FF87;
 Thu, 12 Sep 2019 12:13:04 +0100 (BST)
References: <20190910144428.32597-1-peter.maydell@linaro.org>
 <20190910144428.32597-6-peter.maydell@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190910144428.32597-6-peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 12:13:04 +0100
Message-ID: <87muf9zs1r.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 05/13] target/arm/arm-semi:
 Factor out implementation of SYS_CLOSE
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

> Currently for the semihosting calls which take a file descriptor
> (SYS_CLOSE, SYS_WRITE, SYS_READ, SYS_ISTTY, SYS_SEEK, SYS_FLEN)
> we have effectively two implementations, one for real host files
> and one for when we indirect via the gdbstub. We want to add a
> third one to deal with the magic :semihosting-features file.
>
> Instead of having a three-way if statement in each of these
> cases, factor out the implementation of the calls to separate
> functions which we dispatch to via function pointers selected
> via the GuestFDType for the guest fd.
>
> In this commit, we set up the framework for the dispatch,
> and convert the SYS_CLOSE call to use it.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/arm-semi.c | 42 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 7 deletions(-)
>
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index ce3ba554bef..f3e0bf77cd3 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -116,6 +116,7 @@ static int open_modeflags[12] =3D {
>  typedef enum GuestFDType {
>      GuestFDUnused =3D 0,
>      GuestFDHost =3D 1,
> +    GuestFDGDB =3D 2,
>  } GuestFDType;
>
>  /*
> @@ -179,14 +180,14 @@ static GuestFD *do_get_guestfd(int guestfd)
>  /*
>   * Associate the specified guest fd (which must have been
>   * allocated via alloc_fd() and not previously used) with
> - * the specified host fd.
> + * the specified host/gdb fd.
>   */
>  static void associate_guestfd(int guestfd, int hostfd)
>  {
>      GuestFD *gf =3D do_get_guestfd(guestfd);
>
>      assert(gf);
> -    gf->type =3D GuestFDHost;
> +    gf->type =3D use_gdb_syscalls() ? GuestFDGDB : GuestFDHost;
>      gf->hostfd =3D hostfd;
>  }
>
> @@ -337,6 +338,37 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gdb=
_syscall_complete_cb cb,
>      return is_a64(env) ? env->xregs[0] : env->regs[0];
>  }
>
> +/*
> + * Types for functions implementing various semihosting calls
> + * for specific types of guest file descriptor. These must all
> + * do the work and return the required return value for the guest,
> + * setting the guest errno if appropriate.
> + */
> +typedef uint32_t sys_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf);
> +
> +static uint32_t host_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
> +{
> +    return set_swi_errno(ts, close(gf->hostfd));
> +}
> +
> +static uint32_t gdb_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
> +{
> +    return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
> +}
> +
> +typedef struct GuestFDFunctions {
> +    sys_closefn *closefn;
> +} GuestFDFunctions;
> +
> +static const GuestFDFunctions guestfd_fns[] =3D {
> +    [GuestFDHost] =3D {
> +        .closefn =3D host_closefn,
> +    },
> +    [GuestFDGDB] =3D {
> +        .closefn =3D gdb_closefn,
> +    },
> +};
> +
>  /* Read the input value from the argument block; fail the semihosting
>   * call if the memory read fails.
>   */
> @@ -452,11 +484,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>              return set_swi_errno(ts, -1);
>          }
>
> -        if (use_gdb_syscalls()) {
> -            ret =3D arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->ho=
stfd);
> -        } else {
> -            ret =3D set_swi_errno(ts, close(gf->hostfd));
> -        }
> +        ret =3D guestfd_fns[gf->type].closefn(ts, cpu, gf);
>          dealloc_guestfd(arg0);
>          return ret;
>      case TARGET_SYS_WRITEC:


--
Alex Benn=C3=A9e


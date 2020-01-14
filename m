Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9433BC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:44:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55AA224672
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HnlFVeVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55AA224672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJgI-00063w-UB
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:44:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1irJf8-00053A-2b
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:43:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1irJf6-0005vV-HZ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:43:05 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37501)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1irJf6-0005tN-9C
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:43:04 -0500
Received: by mail-wm1-x344.google.com with SMTP id f129so13113238wmf.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 02:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=V0h8X0i7MkgwJtPLOGDf+sYvsMTEIeKi5N6iAJN6+fg=;
 b=HnlFVeVu4pob8Ru04/CCxDJziTNs+pjMkjcSGp025hoGwlXw47yZEi+XIzhwtxWzc+
 8EOyzdhQZlpivbnectQd8qUv1adO1wCl4qcxQMCbSceCTWd50StEgS+Y+1mIoVuxLIYy
 3bmgUR9JyE9IaoHQxstVe6ceCelxxeO9dCz0ad/CaqqY+U/HCEmj5bG1IxzkGyFmajnJ
 4t+EqiVaQxTFGVtgDswE1MVXbg4VMAUgXL23Zc72PUpYQMjfkM9gmDDBNMFn66VFkVLl
 1t+7V2Sh39HkaCDXPUcfNAMbKc2VgVYPYTW15k+qrBMpI3LZNPnwDSf2tjcOxbrrHrhw
 devA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=V0h8X0i7MkgwJtPLOGDf+sYvsMTEIeKi5N6iAJN6+fg=;
 b=Q1TMl7RmBgsbwlVPsiQQ+605JkJOpVdqeMKDO29ETUbpD5xSvJeDfdwR/6PPKuZsFG
 fzv7SmZrvD1CZ+x9RiR23NwR2f4USTT4PNn2mTT0RQ9tOHAVYWLlIAloV6Z/+suuPPOP
 yxW75LG3L9mxoh9DTP9fXQSy/aR/ow5EmwyN0rnXLIZdf9CvFk8N+iG7RAi/7tTmeFdA
 0HlxCdevECg7VKIex5i1BrKKE8cOKEtSpsynRD6/iwWQTHgBd4An9ED14MWKPZ38KhHO
 FDduEzL8Fx35ogTdCh6lHJ6p1VMpyUGYPTaX+err5ppHsvSE8V6veu9UE7ay9tu0Vem6
 oosg==
X-Gm-Message-State: APjAAAVHuhXVf9z2EzGC+T+1zr5nywEJuPn9RKbgokas/OoakcpMXUsE
 NUCGBV41XEV9xxgNX/uBeLSv5A==
X-Google-Smtp-Source: APXvYqz9fJ3JU7w54uyNbcqgyuLYNg5BUav69wciUZUIhzsKEDW9Nms2lNK1xl9A8576trS9LcHg8A==
X-Received: by 2002:a1c:ddd7:: with SMTP id
 u206mr27768692wmg.159.1578998581715; 
 Tue, 14 Jan 2020 02:43:01 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q15sm19144659wrr.11.2020.01.14.02.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 02:43:00 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B1EA51FF87;
 Tue, 14 Jan 2020 10:42:59 +0000 (GMT)
References: <20200114030138.260347-1-jkz@google.com>
 <20200114030138.260347-2-jkz@google.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Josh Kunz <jkz@google.com>
Subject: Re: [PATCH 1/4] linux-user: Use `qemu_log' for non-strace logging
In-reply-to: <20200114030138.260347-2-jkz@google.com>
Date: Tue, 14 Jan 2020 10:42:59 +0000
Message-ID: <87pnfmmi8c.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: armbru@redhat.com, riku.voipio@iki.fi, qemu-devel@nongnu.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Josh Kunz <jkz@google.com> writes:

> This change introduces a new logging mask "LOG_USER", which is used for
> masking general user-mode logging. This change also switches all non-stra=
ce
> uses of `gemu_log' in linux-user/ to use `qemu_log_mask(LOG_USER, ...)'
> instead. This allows the user to easily log to a file, and to mask out
> these log messages if they desire.
>
> Signed-off-by: Josh Kunz <jkz@google.com>
> ---
>  include/qemu/log.h        |  2 ++
>  linux-user/arm/cpu_loop.c |  5 ++--
>  linux-user/fd-trans.c     | 55 +++++++++++++++++++++++++--------------
>  linux-user/main.c         | 24 +++++++++++++++++
>  linux-user/syscall.c      | 30 ++++++++++++---------
>  linux-user/vm86.c         |  3 ++-
>  util/log.c                |  3 +++
>  7 files changed, 86 insertions(+), 36 deletions(-)
>
> diff --git a/include/qemu/log.h b/include/qemu/log.h
> index e0f4e40628..503e4f88d5 100644
> --- a/include/qemu/log.h
> +++ b/include/qemu/log.h
> @@ -62,6 +62,8 @@ static inline bool qemu_log_separate(void)
>  #define CPU_LOG_TB_OP_IND  (1 << 16)
>  #define CPU_LOG_TB_FPU     (1 << 17)
>  #define CPU_LOG_PLUGIN     (1 << 18)
> +/* LOG_USER is used for some informational user-mode logging. */
> +#define LOG_USER           (1 << 19)

As Laurent said I think LOG_UNIMP is perfectly fine for stuff we haven't
done. I don't think any of the cases warrant LOG_GUEST_ERROR.
>=20=20
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 8718d03ee2..c4f3de77db 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -60,6 +60,9 @@ unsigned long mmap_min_addr;
>  unsigned long guest_base;
>  int have_guest_base;
>=20=20
> +/* Used to implement backwards-compatibility for user-mode logging. */
> +static bool force_user_mode_logging =3D true;
> +

I'm not sure want to bother with this. I know we like to avoid
regression but isn't this all debug log stuff? If we must keep it can we
invert the variable to save the initialisation.

>  /*
>   * When running 32-on-64 we should make sure we can fit all of the possi=
ble
>   * guest address space into a contiguous chunk of virtual host memory.
> @@ -399,6 +402,11 @@ static void handle_arg_abi_call0(const char *arg)
>  }
>  #endif
>=20=20
> +static void handle_arg_no_force_user_mode_logging(const char *arg)
> +{
> +    force_user_mode_logging =3D false;
> +}
> +
>  static QemuPluginList plugins =3D QTAILQ_HEAD_INITIALIZER(plugins);
>=20=20
>  #ifdef CONFIG_PLUGIN
> @@ -469,6 +477,10 @@ static const struct qemu_argument arg_table[] =3D {
>      {"xtensa-abi-call0", "QEMU_XTENSA_ABI_CALL0", false, handle_arg_abi_=
call0,
>       "",           "assume CALL0 Xtensa ABI"},
>  #endif
> +    {"no-force-user-mode-logging", "", false,
> +      handle_arg_no_force_user_mode_logging,
> +      "",          "disable forced user-mode logging, other logging opti=
ons "
> +                   "will be used exactly as provided" },
>      {NULL, NULL, false, NULL, NULL, NULL}
>  };
>=20=20
> @@ -661,6 +673,18 @@ int main(int argc, char **argv, char **envp)
>=20=20
>      optind =3D parse_args(argc, argv);
>=20=20
> +    if (force_user_mode_logging) {
> +        /*
> +         * Backwards Compatibility: gemu_log for non-strace messages was=
 not
> +         * configurable, and was always on. Unless the user explicitly d=
isables
> +         * forced LOG_USER, force LOG_USER into the mask.
> +         */
> +        qemu_add_log(LOG_USER);
> +    }
> +
> +    qemu_log_mask(LOG_USER, "--> from user\n");
> +    qemu_log_mask(LOG_STRACE, "--> from strace\n");
> +

I mean we jumped through hoops to maintain backwards compatibility and
then added new output? Also LOG_STRACE doesn't exist yet.

>      if (!trace_init_backends()) {
>          exit(1);
>      }
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 171c0caef3..7e23dd6327 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1555,7 +1555,7 @@ static inline abi_long target_to_host_cmsg(struct m=
sghdr *msgh,
>               * something more intelligent than "twice the size of the
>               * target buffer we're reading from".
>               */
> -            gemu_log("Host cmsg overflow\n");
> +            qemu_log_mask(LOG_USER, "Host cmsg overflow\n");

I'm not sure we shouldn't just be asserting this case above. The
comments imply it is a bug on our part. The rest look like good cases
for LOG_UNIMP.

--=20
Alex Benn=C3=A9e


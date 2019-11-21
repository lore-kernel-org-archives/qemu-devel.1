Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5F9C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:45:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16ED5206CB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Etcqk6Ml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16ED5206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXrSL-0002ot-6N
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 13:45:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXrQw-0002Cx-Nr
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXrQv-0008Mz-6F
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:44:02 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37470)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iXrQv-0008MS-15
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:44:01 -0500
Received: by mail-ot1-x344.google.com with SMTP id d5so3887048otp.4
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 10:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+OpmGlBlmLStmJtIzK9f77cb8kh/4f2QRQbM/SvCP9c=;
 b=Etcqk6MlyPyNoGTkGML9dso3CxyXw6w5VPaAFcYFrEmup2NT0+x5m2Ysz9mcLGQWqW
 PiUfRmNa1/gif0j3YacYe3NRK/Hz7nq4EDC7wDv9GXQVD4Gu6P6STAKUBaVPqkapEI2j
 bhAgq260OuCW9ait6svs2lL8t3g/hpQHTduLddvbrux9GbN1/V9C3K0Y+XAnGjgUO5Bw
 SHPWcT2t1u+VsR/NlseFQP+gfbemRR9qyursezgk9R9VRLW25JMcBwMyw8e+J82Ku2zh
 eO7/mrCpiMgYg42+c08/ymvLmWWr+H83kY7lCVwGHdw9y7QOJa9tJotGgYCuqfte6HB+
 1GUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+OpmGlBlmLStmJtIzK9f77cb8kh/4f2QRQbM/SvCP9c=;
 b=eciUXvH4rEiGb0YHfTRNHI8Kp8FKtN+c9Ix27XEpxxdxWyItnL7nDjteT35k9YUNWs
 /wBko/wiMWRYLL5Igo87tEKycbl3Ej3nwi4IreTdBTG4zhr7R2u4aEBQn2ijMSKEOt/P
 I45DgOYS8RHtlcYGCXQPdnOagfRITPlHCjDeL0U4cVGvmS4rYqaJzDKjJ53FgOK8wThz
 oyuI75IIHW78sFdWvPqnG1B5c+XEnBSM7du8V4pp0P0K5ERAS1Ow75iwOCie4uGNnoo8
 F4sxC7KDpwi+fh0NJarMz/PeUMLS/qvN3vez7obcPskd15hRps0J0RAtqlGzhJeTZzfq
 kS+Q==
X-Gm-Message-State: APjAAAWKSA1KVGqjBNsx4sBoKFuMK/UxgG2C2vC6oYCvJEc1ZbCvJbcn
 5aVxF9Hxoe0hhlqjU5dHXTUQIuta97wrYygUIQE=
X-Google-Smtp-Source: APXvYqzRO7VPsMnCmcMzCS4idzMGySFv0cfl4FYJO+J3bkLYc+6eUv9HMrOe+gFeaA5RQ03bQrrkO7KjpHt109kHpcM=
X-Received: by 2002:a05:6830:81:: with SMTP id a1mr7473928oto.64.1574361839667; 
 Thu, 21 Nov 2019 10:43:59 -0800 (PST)
MIME-Version: 1.0
References: <20191120145555.GA15154@ls3530.fritz.box>
In-Reply-To: <20191120145555.GA15154@ls3530.fritz.box>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 21 Nov 2019 19:43:48 +0100
Message-ID: <CAL1e-=i1N4YSf6E8-5_b5N0qaKBB5hqMtm6A-+LnfY-ckS33gQ@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user/strace: Add missing signal strings
To: Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 3:57 PM Helge Deller <deller@gmx.de> wrote:
>
> Add the textual representations of some missing target signals.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
>
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 3d4d684450..de43238fa4 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -146,6 +146,19 @@ print_signal(abi_ulong arg, int last)
>      case TARGET_SIGSTOP: signal_name = "SIGSTOP"; break;
>      case TARGET_SIGTTIN: signal_name = "SIGTTIN"; break;
>      case TARGET_SIGTTOU: signal_name = "SIGTTOU"; break;
> +    case TARGET_SIGIO: signal_name = "SIGIO"; break;
> +    case TARGET_SIGBUS: signal_name = "SIGBUS"; break;
> +    case TARGET_SIGPWR: signal_name = "SIGPWR"; break;
> +    case TARGET_SIGURG: signal_name = "SIGURG"; break;
> +    case TARGET_SIGSYS: signal_name = "SIGSYS"; break;
> +    case TARGET_SIGTRAP: signal_name = "SIGTRAP"; break;
> +    case TARGET_SIGXCPU: signal_name = "SIGXCPU"; break;
> +    case TARGET_SIGPROF: signal_name = "SIGPROF"; break;
> +    case TARGET_SIGTSTP: signal_name = "SIGTSTP"; break;
> +    case TARGET_SIGXFSZ: signal_name = "SIGXFSZ"; break;
> +    case TARGET_SIGWINCH: signal_name = "SIGWINCH"; break;
> +    case TARGET_SIGVTALRM: signal_name = "SIGVTALRM"; break;
> +    case TARGET_SIGSTKFLT: signal_name = "SIGSTKFLT"; break;

What about TARGET_SIGEMT, TARGET_SIGIOT ? Those are missing from
MIPS-specific list of signals, and they won't be printed as strings. I
think you should add:

#if defined TARGET_SIGEMT
    case TARGET_SIGEMT: signal_name = "SIGEMT"; break;
#endif
case TARGET_SIGIOT: signal_name = "SIGIOT"; break;

(I believe "#if defined"s is needed only for SIG_EMT, but doublecheck.)

Without this, this patch favors other platforms over MIPS, which is
certainly not a good/fair thing.

There might be some similar case or two for other platforms too
(alpha, sparc perhaps).

Your reference should be kernel files:

arch/<platform>/include/uapi/asm/sighal.h.

In fact, there is some peace of kernell code that exactly deal with
the same problem - getting the names of the signals. It is in
security/apparmor/include/sig_names.h

( https://elixir.bootlin.com/linux/v5.4-rc8/source/security/apparmor/include/sig_names.h
)

Since the file is short, I am inserting the whole content here:

#include <linux/signal.h>

#define SIGUNKNOWN 0
#define MAXMAPPED_SIG 35
#define MAXMAPPED_SIGNAME (MAXMAPPED_SIG + 1)
#define SIGRT_BASE 128

/* provide a mapping of arch signal to internal signal # for mediation
 * those that are always an alias SIGCLD for SIGCLHD and SIGPOLL for SIGIO
 * map to the same entry those that may/or may not get a separate entry
 */
static const int sig_map[MAXMAPPED_SIG] = {
[0] = MAXMAPPED_SIG, /* existence test */
[SIGHUP] = 1,
[SIGINT] = 2,
[SIGQUIT] = 3,
[SIGILL] = 4,
[SIGTRAP] = 5, /* -, 5, - */
[SIGABRT] = 6, /*  SIGIOT: -, 6, - */
[SIGBUS] = 7, /* 10, 7, 10 */
[SIGFPE] = 8,
[SIGKILL] = 9,
[SIGUSR1] = 10, /* 30, 10, 16 */
[SIGSEGV] = 11,
[SIGUSR2] = 12, /* 31, 12, 17 */
[SIGPIPE] = 13,
[SIGALRM] = 14,
[SIGTERM] = 15,
#ifdef SIGSTKFLT
[SIGSTKFLT] = 16, /* -, 16, - */
#endif
[SIGCHLD] = 17, /* 20, 17, 18.  SIGCHLD -, -, 18 */
[SIGCONT] = 18, /* 19, 18, 25 */
[SIGSTOP] = 19, /* 17, 19, 23 */
[SIGTSTP] = 20, /* 18, 20, 24 */
[SIGTTIN] = 21, /* 21, 21, 26 */
[SIGTTOU] = 22, /* 22, 22, 27 */
[SIGURG] = 23, /* 16, 23, 21 */
[SIGXCPU] = 24, /* 24, 24, 30 */
[SIGXFSZ] = 25, /* 25, 25, 31 */
[SIGVTALRM] = 26, /* 26, 26, 28 */
[SIGPROF] = 27, /* 27, 27, 29 */
[SIGWINCH] = 28, /* 28, 28, 20 */
[SIGIO] = 29, /* SIGPOLL: 23, 29, 22 */
[SIGPWR] = 30, /* 29, 30, 19.  SIGINFO 29, -, - */
#ifdef SIGSYS
[SIGSYS] = 31, /* 12, 31, 12. often SIG LOST/UNUSED */
#endif
#ifdef SIGEMT
[SIGEMT] = 32, /* 7, - , 7 */
#endif
#if defined(SIGLOST) && SIGPWR != SIGLOST /* sparc */
[SIGLOST] = 33, /* unused on Linux */
#endif
#if defined(SIGUNUSED) && \
    defined(SIGLOST) && defined(SIGSYS) && SIGLOST != SIGSYS
[SIGUNUSED] = 34, /* -, 31, - */
#endif
};

/* this table is ordered post sig_map[sig] mapping */
static const char *const sig_names[MAXMAPPED_SIGNAME] = {
"unknown",
"hup",
"int",
"quit",
"ill",
"trap",
"abrt",
"bus",
"fpe",
"kill",
"usr1",
"segv",
"usr2",
"pipe",
"alrm",
"term",
"stkflt",
"chld",
"cont",
"stop",
"stp",
"ttin",
"ttou",
"urg",
"xcpu",
"xfsz",
"vtalrm",
"prof",
"winch",
"io",
"pwr",
"sys",
"emt",
"lost",
"unused",

"exists", /* always last existence test mapped to MAXMAPPED_SIG */
};

I think you should mirror the functionality from that file.

Yours,
Aleksandar


>      }
>      if (signal_name == NULL) {
>          print_raw_param("%ld", arg, last);
>


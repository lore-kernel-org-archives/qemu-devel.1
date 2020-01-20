Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2326C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:46:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A95E217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gdrV2mSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A95E217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itYJb-0006Fs-FP
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 09:46:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1itYFM-0000jU-Pq
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1itYFL-00024K-6e
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:41:44 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55983)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1itYFK-00023s-Vx
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:41:43 -0500
Received: by mail-wm1-x344.google.com with SMTP id q9so14726954wmj.5
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 06:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=BkbKFUYioYiccz4Tlq6NKyvQf4k2puHksCjJN5rFz3w=;
 b=gdrV2mSkWNuRo+gNoFoaXNpnTW0zE+0gcDpXURBoRtGCw7z5TxNxydFOVIWp0IvTTq
 KKP7he4UEWB18/n9/xKG1C1QVM1p4GCQ2Et80ehcHJHs4BYxff0oIqZb8EQG9j9shqLn
 jZxCdJYm4XdPJX7FlZ4A4288xf5u4ObkWrM0YiEvX+G+AnalztMLkmYC21IqnpTygYzM
 to5rW9n7Pxbu2Gq08fyBlXLBtzjGVXS2ZqoOTk0nIwUSMD5HzgvYS+9gABPWBQpYHtlM
 pgKBHTs9f3VmDq8I1Wq9E2hQbNqD8YW4cWlOFrGUcfQ/nUYCYcXr5rEpk/m0yAqGxGln
 xx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=BkbKFUYioYiccz4Tlq6NKyvQf4k2puHksCjJN5rFz3w=;
 b=iPcOcwe08Lnh/KeMyf8HLsn/Cx4I/MBFX+nzSQS97/l5/HMTmHZhAPoXZnygS8e4Cw
 +dYeVeDE0j9ZTISAZRxNVh0TVDNInaovL5F/JuumekESDC6kE3si6A9+n4giBYKGfUw6
 M09M9aado855jDndugaHLL3eqcBqiZFuBk35In9nr5jK5DMrEeZOkkrX9CthRYE47mLB
 Ea3aQICMHmN9WicFYqvk7PdpByfBo3h832zpU4oe91B7filRr9LGzJpcQu7wxnlf/OAi
 7ZEGsreO52bUnVuw/B7uVUeJArJqrMb9Iimd/xnxOhs4j/MsXreIpLyv5fPuxAFesuH7
 Ugkw==
X-Gm-Message-State: APjAAAWzLUli7XUGbUEdIgGzf1YcjHhxVkWF+nfiAbDORWYvtTfFdlEH
 jc5Hxfnis6LKcs1ttgYAkd40pg==
X-Google-Smtp-Source: APXvYqzZKcwUcn2e72PyNkFAjSmOOZqnjVZJdmVhggk0+OOHyONGUnFxIoBQFL9ZZliNxz6D5XgXHw==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr18217348wmi.146.1579531301665; 
 Mon, 20 Jan 2020 06:41:41 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s19sm23010503wmj.33.2020.01.20.06.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 06:41:40 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BF12F1FF87;
 Mon, 20 Jan 2020 14:41:39 +0000 (GMT)
References: <20200116194341.402-1-richard.henderson@linaro.org>
 <20200116194341.402-5-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 4/5] linux-user: Add x86_64 vsyscall page to
 /proc/self/maps
In-reply-to: <20200116194341.402-5-richard.henderson@linaro.org>
Date: Mon, 20 Jan 2020 14:41:39 +0000
Message-ID: <87tv4q197g.fsf@linaro.org>
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
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The page isn't (necessarily) present in the host /proc/self/maps,
> and even if it might be it isn't present in page_flags, and even
> if it was it might not have the same set of page permissions.
>
> The easiest thing to do, particularly when it comes to the
> "[vsyscall]" note at the end of line, is to special case it.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 171c0caef3..eb867a5296 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7005,6 +7005,15 @@ static int open_self_maps(void *cpu_env, int fd)
>          }
>      }
>=20=20
> +#ifdef TARGET_X86_64
> +    /*
> +     * We only support execution from the vsyscall page.
> +     * This is as if CONFIG_LEGACY_VSYSCALL_XONLY=3Dy from v5.3.
> +     */
> +    dprintf(fd, "ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0"
> +                "          [vsyscall]\n");
> +#endif
> +

I'm not sure what whitespace is wrong - tabs maybe? But looking at a
real vsyscall system vs emulated things line up better:

  Welcome to Buildroot
  buildroot login: root
  # uname -a
  Linux buildroot 5.4.13 #1 SMP Mon Jan 20 14:36:20 GMT 2020 x86_64 GNU/Lin=
ux
  # cat /proc/self/maps
  00400000-004ab000 r-xp 00000000 00:02 7635                               =
/bin/busybox
  004ab000-004ac000 r-xp 000aa000 00:02 7635                               =
/bin/busybox
  004ac000-004ad000 rwxp 000ab000 00:02 7635                               =
/bin/busybox
  004ad000-004ae000 rwxp 00000000 00:00 0
  7fcc91566000-7fcc91567000 rwxp 00000000 00:00 0
  7fcc91567000-7fcc915de000 r-xp 00000000 00:02 7475                       =
/lib/libuClibc-1.0.32.so
  7fcc915de000-7fcc915df000 ---p 00000000 00:00 0
  7fcc915df000-7fcc915e0000 r-xp 00077000 00:02 7475                       =
/lib/libuClibc-1.0.32.so
  7fcc915e0000-7fcc915e1000 rwxp 00078000 00:02 7475                       =
/lib/libuClibc-1.0.32.so
  7fcc915e1000-7fcc915fc000 rwxp 00000000 00:00 0
  7fcc915fc000-7fcc91603000 r-xp 00000000 00:02 7480                       =
/lib/ld64-uClibc-1.0.32.so
  7fcc91603000-7fcc91604000 r-xp 00006000 00:02 7480                       =
/lib/ld64-uClibc-1.0.32.so
  7fcc91604000-7fcc91605000 rwxp 00007000 00:02 7480                       =
/lib/ld64-uClibc-1.0.32.so
  7ffd92001000-7ffd92022000 rwxp 00000000 00:00 0                          =
[stack]
  7ffd920c3000-7ffd920c6000 r--p 00000000 00:00 0                          =
[vvar]
  7ffd920c6000-7ffd920c7000 r-xp 00000000 00:00 0                          =
[vdso]
  ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  =
[vsyscall]
  # QEMU 4.2.50 monitor - type 'help' for more information
  (qemu) quit
  14:38:52 [alex.bennee@hackbox2:~/l/q/b/all] review/fix-user-brk|=E2=80=A6=
 + ./x86_64-linux-user/qemu-x86_64 /bin/cat /proc/self/maps
  4000000000-4000008000 r-xp 00000000 00:19 8131          /bin/cat
  4000008000-4000207000 ---p 00000000 00:00 0
  4000207000-4000208000 r--p 00007000 00:19 8131          /bin/cat
  4000208000-4000209000 rw-p 00008000 00:19 8131          /bin/cat
  4000209000-400022a000 rw-p 00000000 00:00 0
  4001209000-400120a000 ---p 00000000 00:00 0
  400120a000-4001a0a000 rw-p 00000000 00:00 0                [stack]
  4001a0a000-4001a31000 r-xp 00000000 00:19 3644          /lib/x86_64-linux=
-gnu/ld-2.27.so
  4001a31000-4001c31000 ---p 00000000 00:00 0
  4001c31000-4001c32000 r--p 00027000 00:19 3644          /lib/x86_64-linux=
-gnu/ld-2.27.so
  4001c32000-4001c33000 rw-p 00028000 00:19 3644          /lib/x86_64-linux=
-gnu/ld-2.27.so
  4001c33000-4001c36000 rw-p 00000000 00:00 0
  4001c6d000-4001e54000 r-xp 00000000 00:19 3648          /lib/x86_64-linux=
-gnu/libc-2.27.so
  4001e54000-4002054000 ---p 001e7000 00:19 3648          /lib/x86_64-linux=
-gnu/libc-2.27.so
  4002054000-4002058000 r--p 001e7000 00:19 3648          /lib/x86_64-linux=
-gnu/libc-2.27.so
  4002058000-400205a000 rw-p 001eb000 00:19 3648          /lib/x86_64-linux=
-gnu/libc-2.27.so
  400205a000-4002060000 rw-p 00000000 00:00 0
  4002060000-40023d2000 r--p 00000000 00:19 195276          /usr/lib/locale=
/locale-archive
  ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0          [vsyscal=
l]

>      free(line);
>      fclose(fp);


--=20
Alex Benn=C3=A9e


Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BF8C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 07:47:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C56CE20708
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 07:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Pnkq7iqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56CE20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY3fV-0003W5-QQ
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 02:47:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1iY3bI-0002eI-54
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 02:43:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1iY3bG-0000ub-JF
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 02:43:31 -0500
Received: from mout.gmx.net ([212.227.15.18]:56433)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1iY3bG-0000uF-5W
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 02:43:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1574408605;
 bh=SSDK6LwV9cjAJc/1ywkgby5VBM9STgo6o9ge8cc04Rg=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Pnkq7iqe4cgY6MNeEQN4TM7tt+o9W2gZcARg23nbJSizw0z5TWsOOZMh9szKScgSZ
 +rkHNa+KeLXoRUaiW+ir848ACPYB9fIQxiiL6ox7j+skZkZT5tK6o967Of4Wwl30ss
 yGizXSAp+94ECDQGFwX4AfUym1n4xmFRQr/71Hy8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.191.200]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ma20k-1iJqfZ0E0y-00Vvhl; Fri, 22
 Nov 2019 08:43:25 +0100
Subject: Re: [PATCH v2] linux-user/strace: Add missing signal strings
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191120145555.GA15154@ls3530.fritz.box>
 <CAL1e-=i1N4YSf6E8-5_b5N0qaKBB5hqMtm6A-+LnfY-ckS33gQ@mail.gmail.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <b095da34-7c98-0b28-e9b4-a92c73a386a0@gmx.de>
Date: Fri, 22 Nov 2019 08:43:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAL1e-=i1N4YSf6E8-5_b5N0qaKBB5hqMtm6A-+LnfY-ckS33gQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nBMx4KR/S3osfKTdftl7JpPXhlHMA/BEHyHePo0w+l2hpdHjRHc
 tTnroK71xg/lBAldKz/1VTc/rNhN6b+Dg9/GlaE4Lm6YZwTV4MSLBWd7sYc0wzfBBZqOYRp
 zDQH2p09y0KYi7aIpp0Qek1EupcXMQpe52k++saLmCs3xzRylwPFRkV79xhmhL9s9lmfJH+
 zDXY28T9LMnsb6I4FsleA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CPiNjwTGq0o=:KDYqr6lL3JKZ2s65Xh9q2D
 ImDwIMoG1ChXSPYKN4dxyXr2N++qdadR+ogA+52AsVLKs0SG85lCz04fnAns38k8w5iOW2XVb
 bggctegmpA5gA4u9IUndmwKpmhqkJ4ZD9U4n6/2NmDVap4WofVhXIFnwqZoPicSU+SJs4dxbs
 i6OxzhpVva7Zw1/TPvkMVDIHiyyFheXPwbhvgwL9GfFc3iSN3q8VLqJJS++YuQX4WzlYyPeWk
 N0uU1rNaRW3NhggRYq+fmLTbVKfmNmArKtnvEdNLG6UC5pOLYgX/umsJt7z06aiTVtouP2984
 4KS0HRFi+CJdb7QnF2jlfDU8zsnHJdAJI4FZ2uIZEIGXtddyglxJpwWxXDB5h8IZqzxaVS5bJ
 ILFfH0HSFswY0+qqZpiNyKj8407LO0ep482R4PjRPKIxvaRvUKRLZ1umt8yUB5XjZc3RJGXLS
 OfSD7n/zwpXiGHW8qORdF1TEPJ/AOyzRyMe05BQqtTxf9xuZJYLgVuzqLWBA9ZB9uJO1oVbCk
 YhTBBecqmUZUZsM5187Z/fzBnn7YXgw4s9ML0iJfoOh1bsASQ0m4loiFHQc4QH2by98rhNozO
 56bdu6Icxx9nNE4rdP4/h83yOQKJApKSGBpIiAo8wHT5FhsXCBaQdZWQ1temouDKQQWk6gBC9
 jVywRk359r5KNwbSAYZh8O2fQh50Osu2KdUU/wBR/Dt0fSkhBtezxqFXHjjzRd0lfkUzP8WEz
 2Qsr2o+tgqqb4r+sl3ruFQVs/a14Gom4W+AqaNHePbN/UskJRosY3fCL4pZ4TipBgDA2t3Sf/
 4Wt6wNQFJqQlCsOTWKjcpkKBAmuNTHArwLb6T0wlL7bFlxZGTmD9UoT93wpjbLCPQSUJPgE8b
 qaFLRvANWJ2L+rJPOx16g44lPOgeW1ahCrnOU4E3H3x0nKQo/flMYcvruwZ6Gx/H9kAZti8mL
 GOC+J6qJUcLmot3CkVRBWdVdfV0FR0LGBY4tBlnv2j2CUIsQiIArFWDEqxXTeQSY06qM3BAND
 E1v3pDK1iBXst3xgSSHpw7HtesHME+6stKhYuUWzXYWjAJhnfudu0OwDzOfMLcrgCgWw9VoBL
 cBBzKaqXha3Rho+Ck8UdubG5VNRqgUdv6FoIXrLrHuTDPs0KF+a0zAcdB09iymy4rqV4QTYQ+
 Aq0yuUECdOgwHw7WtaEfl8++6s/BpsJRvWAiZimmlnxrYmnIa0AgUahoHc8Ibo5/O25H6EVno
 k9XMKzmsDjwcB5rm6Vyqm5IvL67SXj1ARUGazRg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.18
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21.11.19 19:43, Aleksandar Markovic wrote:
> On Wed, Nov 20, 2019 at 3:57 PM Helge Deller <deller@gmx.de> wrote:
>>
>> Add the textual representations of some missing target signals.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>>
>> diff --git a/linux-user/strace.c b/linux-user/strace.c
>> index 3d4d684450..de43238fa4 100644
>> --- a/linux-user/strace.c
>> +++ b/linux-user/strace.c
>> @@ -146,6 +146,19 @@ print_signal(abi_ulong arg, int last)
>>      case TARGET_SIGSTOP: signal_name =3D "SIGSTOP"; break;
>>      case TARGET_SIGTTIN: signal_name =3D "SIGTTIN"; break;
>>      case TARGET_SIGTTOU: signal_name =3D "SIGTTOU"; break;
>> +    case TARGET_SIGIO: signal_name =3D "SIGIO"; break;
>> +    case TARGET_SIGBUS: signal_name =3D "SIGBUS"; break;
>> +    case TARGET_SIGPWR: signal_name =3D "SIGPWR"; break;
>> +    case TARGET_SIGURG: signal_name =3D "SIGURG"; break;
>> +    case TARGET_SIGSYS: signal_name =3D "SIGSYS"; break;
>> +    case TARGET_SIGTRAP: signal_name =3D "SIGTRAP"; break;
>> +    case TARGET_SIGXCPU: signal_name =3D "SIGXCPU"; break;
>> +    case TARGET_SIGPROF: signal_name =3D "SIGPROF"; break;
>> +    case TARGET_SIGTSTP: signal_name =3D "SIGTSTP"; break;
>> +    case TARGET_SIGXFSZ: signal_name =3D "SIGXFSZ"; break;
>> +    case TARGET_SIGWINCH: signal_name =3D "SIGWINCH"; break;
>> +    case TARGET_SIGVTALRM: signal_name =3D "SIGVTALRM"; break;
>> +    case TARGET_SIGSTKFLT: signal_name =3D "SIGSTKFLT"; break;
>
> What about TARGET_SIGEMT, TARGET_SIGIOT ? Those are missing from
> MIPS-specific list of signals, and they won't be printed as strings. I
> think you should add:
>
> #if defined TARGET_SIGEMT
>     case TARGET_SIGEMT: signal_name =3D "SIGEMT"; break;
> #endif
> case TARGET_SIGIOT: signal_name =3D "SIGIOT"; break;

Please see my first version of the patch.
There I added the TARGET_SIGIOT as comment.
I assume there is a build issue if you add a case
for TARGET_SIGIOT, since it probably conflicts with TARGET_SIGABRT.
That's probably why TARGET_SIGIOT is commented out in linux-user/signal.c
as well?

For SIGEMT I don't know.
It's only defined for MIPS, and I can't test-compile it.
I'm happy to add the #ifdef mentioned above if you could test it.

> (I believe "#if defined"s is needed only for SIG_EMT, but doublecheck.)

Yes, it's not defined for any other arch.

> Without this, this patch favors other platforms over MIPS, which is
> certainly not a good/fair thing.

Everyone loves the own baby :-)
> There might be some similar case or two for other platforms too
> (alpha, sparc perhaps).

I think I checked with the table in linux-user/signal.c before sending.

> Your reference should be kernel files:
> arch/<platform>/include/uapi/asm/sighal.h.
>
> In fact, there is some peace of kernell code that exactly deal with
> the same problem - getting the names of the signals. It is in
> security/apparmor/include/sig_names.h
>
> ( https://elixir.bootlin.com/linux/v5.4-rc8/source/security/apparmor/inc=
lude/sig_names.h
> )
>
> Since the file is short, I am inserting the whole content here:
>
> #include <linux/signal.h>
>
> #define SIGUNKNOWN 0
> #define MAXMAPPED_SIG 35
> #define MAXMAPPED_SIGNAME (MAXMAPPED_SIG + 1)
> #define SIGRT_BASE 128
>
> /* provide a mapping of arch signal to internal signal # for mediation
>  * those that are always an alias SIGCLD for SIGCLHD and SIGPOLL for SIG=
IO
>  * map to the same entry those that may/or may not get a separate entry
>  */
> static const int sig_map[MAXMAPPED_SIG] =3D {
> [0] =3D MAXMAPPED_SIG, /* existence test */
> [SIGHUP] =3D 1,
> [SIGINT] =3D 2,
> [SIGQUIT] =3D 3,
> [SIGILL] =3D 4,
> [SIGTRAP] =3D 5, /* -, 5, - */
> [SIGABRT] =3D 6, /*  SIGIOT: -, 6, - */
> [SIGBUS] =3D 7, /* 10, 7, 10 */
> [SIGFPE] =3D 8,
> [SIGKILL] =3D 9,
> [SIGUSR1] =3D 10, /* 30, 10, 16 */
> [SIGSEGV] =3D 11,
> [SIGUSR2] =3D 12, /* 31, 12, 17 */
> [SIGPIPE] =3D 13,
> [SIGALRM] =3D 14,
> [SIGTERM] =3D 15,
> #ifdef SIGSTKFLT
> [SIGSTKFLT] =3D 16, /* -, 16, - */
> #endif
> [SIGCHLD] =3D 17, /* 20, 17, 18.  SIGCHLD -, -, 18 */
> [SIGCONT] =3D 18, /* 19, 18, 25 */
> [SIGSTOP] =3D 19, /* 17, 19, 23 */
> [SIGTSTP] =3D 20, /* 18, 20, 24 */
> [SIGTTIN] =3D 21, /* 21, 21, 26 */
> [SIGTTOU] =3D 22, /* 22, 22, 27 */
> [SIGURG] =3D 23, /* 16, 23, 21 */
> [SIGXCPU] =3D 24, /* 24, 24, 30 */
> [SIGXFSZ] =3D 25, /* 25, 25, 31 */
> [SIGVTALRM] =3D 26, /* 26, 26, 28 */
> [SIGPROF] =3D 27, /* 27, 27, 29 */
> [SIGWINCH] =3D 28, /* 28, 28, 20 */
> [SIGIO] =3D 29, /* SIGPOLL: 23, 29, 22 */
> [SIGPWR] =3D 30, /* 29, 30, 19.  SIGINFO 29, -, - */
> #ifdef SIGSYS
> [SIGSYS] =3D 31, /* 12, 31, 12. often SIG LOST/UNUSED */
> #endif
> #ifdef SIGEMT
> [SIGEMT] =3D 32, /* 7, - , 7 */
> #endif
> #if defined(SIGLOST) && SIGPWR !=3D SIGLOST /* sparc */
> [SIGLOST] =3D 33, /* unused on Linux */
> #endif
> #if defined(SIGUNUSED) && \
>     defined(SIGLOST) && defined(SIGSYS) && SIGLOST !=3D SIGSYS
> [SIGUNUSED] =3D 34, /* -, 31, - */
> #endif
> };
>
> /* this table is ordered post sig_map[sig] mapping */
> static const char *const sig_names[MAXMAPPED_SIGNAME] =3D {
> "unknown",
> "hup",
> "int",
> "quit",
> "ill",
> "trap",
> "abrt",
> "bus",
> "fpe",
> "kill",
> "usr1",
> "segv",
> "usr2",
> "pipe",
> "alrm",
> "term",
> "stkflt",
> "chld",
> "cont",
> "stop",
> "stp",
> "ttin",
> "ttou",
> "urg",
> "xcpu",
> "xfsz",
> "vtalrm",
> "prof",
> "winch",
> "io",
> "pwr",
> "sys",
> "emt",
> "lost",
> "unused",
>
> "exists", /* always last existence test mapped to MAXMAPPED_SIG */
> };
>
> I think you should mirror the functionality from that file.

Simply mirroring files isn't good IMHO.
The copy from bootlin above might not have all cases/fixes for all platfor=
ms
(e.g. s390x, parisc, sparc, ...)?

Helge


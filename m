Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F6BC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 20:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 375A520659
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 20:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JCO6Rz0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375A520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZLKz-0008CJ-6p
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 15:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1iZLFC-000788-La
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 15:46:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1iZLFB-0004cn-Bs
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 15:46:02 -0500
Received: from mout.gmx.net ([212.227.15.18]:38807)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1iZLFB-0004cC-2v
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 15:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1574714759;
 bh=IjYPXuzSKOJKZyKHz/S7Gox02BojlkbI/UlPqaxSTzc=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=JCO6Rz0ghllaxKBji1s/QYCocO6FXIgF/KXSyla4DXUvrsxbeD/WFZjbJYiNTakf9
 sn/6v5kGHTYhJSSXNcNDxpavUD0r9bsrxyRlD4Q9S3Bpf68uDaHl3wu6lGreoAy6Lw
 bscDgxYw0yeBEZUkcMl7qSIyCS0rhvCN9LU1c7Ys=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.187.143]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjS9I-1i7OE03SQ6-00l129; Mon, 25
 Nov 2019 21:45:58 +0100
Subject: Re: [PATCH v2] linux-user/strace: Improve strace output for read()
 and getcwd()
To: qemu-devel@nongnu.org
References: <157459913141.7001.1861884858484439323@37313f22b938>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <ae409bbc-d388-25b7-a928-4fe376c72cbc@gmx.de>
Date: Mon, 25 Nov 2019 21:45:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <157459913141.7001.1861884858484439323@37313f22b938>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oOGwFaQV16e7OEhj/G/DCZ4UyzDmP519mFSom9cZmvHOsw22fxM
 t9Sip8uogLSvWNuP+yBs3pxxPPFuz/vv1uDnpqCBSx00EvSsL0S/Jy1kZ9S1CbMc3kPOWS9
 DoZP+ACEqrPtMXdXGeVmHEYgNY5oCSj8lcqIUDcVQWEHoYsFIl62xklY2CKVJTwhECpaQqz
 ISP78IV++8DX0qxHnBYnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EvKxmlwWNAU=:TtfdvnFYBzstI+NoEOYEMJ
 xN38y3TmNFCSPTj0mez4BqFWLhU/BjDgkwEAIEbYV+kDidT3DgCb12CwE+h5L/PGM8uYQakjJ
 lYnEYspIMJaPO/46jSrgrJhub3sNjOWMnAdH4JMEY4U/G2cZOH1fdvPvNX0gerbE1nIOANFQY
 ynkzXNZIvBSI0YxjAfAiHW+gunRLnQi3Kr854qVMg3BZp+liP+vDORligGyUb/PPTAuKR/tGM
 GFJEHMVnfjK1OxTSGHcDFZEA2uL7NXP6TC9ehVuCv0HO0pm76/Gf6tgKiu5jGhkmYgOP8Aky7
 T/7bnvYMAMc2vAVNJT9PU5AM3NCNckD/j3n3QpRzIG8xmq9Zlnk6VlQ47xTnQVHZUL0Nxelcs
 FE+SVLshlRZqmvG5+DuyzQJE4I3JrSfTjmNp1R6Qs1BRgId863EOPSaSTppvxJfqa1V2weUWv
 NgiAX6JiV1l+r9k+yCeuEpA06UCXfTNY40q7EwkJrvk7S1BZuBx6o3FY9REUI9TbXu5kJveA+
 6CUm0FVEP/47f6/TsEN1gddtedAvrnwpVzSoPsChlH1Gm1mfh4ZRRWCI4JTqKdjBCc2Nw08iU
 e9NEtlBcOF5cUAvRzEmBavRsD5/ktb5nQe/islG1VmA0Pi8HEwD+Pv8Rjt05qsiN7+efANGWP
 G26tTQaFIhGtWo/f9k2ExLy/WKoqH/7oviVd1S1AzOKFQgiITsAFGEYjvW0yJsb9xx21VkMtO
 rOHUQDUC+zNS7RXDLnctkMTou5F4/1boux1ThYWfdq7Qw/OP8WV+wqYPkwE0rqen84aZaLNTP
 /63tnB8VmzIbau+DtWGj0P+MsctV37TcCpKZ+xsL8VtO2z6cVRMGJTu+r/iuAbbyhD7XD2PTY
 Kx+LgG86kgLaqELa7uA96mmC5pcFw/dTydrZ1FHPfFOmuUbkBpbnu4q5TVgqWigUSctgs4Mks
 PZhuFMdETGHZP22W9UycN0o+O+YL3zuQVBEH6fwAGrX0sYqUeMLGkfUDwtRWV+idD8iqe/0O7
 Oq7ieWT/inLTAlWqhjoxwtnM8S0Bxfi/Ul5NZjdsdNoGcZX46FST+Ux6THzZxF5t3PkK0attL
 hLDum+04Tfa7s2MnQ2qm/FnPHV5nn7r1C5VN6i8eHnKATVXZpwDQhRv6H5mLczTi5RMHydpBs
 JkTHqrhT6HWmX/2hILdjzhFYXgoM2OQ3e0ovT2Su6xZVSnclE6Ko+f3Xlot7ZJf5GdP5kfNRb
 ExwGzD+kliZnEUul7yD1PMbjhEJUOprFrgDh1VQ==
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
Cc: aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24.11.19 13:38, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20191124115656.GA23850@ls3530.frit=
z.box/
> ...
> This series seems to have some coding style problems. See output below f=
or
> more information:
>
> Subject: [PATCH v2] linux-user/strace: Improve strace output for read() =
and getcwd()
> ...
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> WARNING: line over 80 characters
> #51: FILE: linux-user/strace.c:64:
> +UNUSED static void print_encoded_string(abi_long addr, unsigned int max=
len, int last);
>
> ERROR: storage class should be at the beginning of the declaration
> #51: FILE: linux-user/strace.c:64:
> +UNUSED static void print_encoded_string(abi_long addr, unsigned int max=
len, int last);

IMHO the error is bogus.
This is the part of the patch:

diff --git a/linux-user/strace.c b/linux-user/strace.c
index de43238fa4..dc963accd5 100644
=2D-- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -61,6 +61,7 @@ UNUSED static void print_open_flags(abi_long, int);
 UNUSED static void print_syscall_prologue(const struct syscallname *);
 UNUSED static void print_syscall_epilogue(const struct syscallname *);
 UNUSED static void print_string(abi_long, int);
+UNUSED static void print_encoded_string(abi_long addr, unsigned int maxle=
n, int last);
 UNUSED static void print_buf(abi_long addr, abi_long len, int last);
 UNUSED static void print_raw_param(const char *, abi_long, int);
 UNUSED static void print_timeval(abi_ulong, int);

Maybe the warning is somewhat real, but *if* I should cut the line to
less than 80 chars, where should I break it?
E.g. like this?

+UNUSED static void print_encoded_string(abi_long addr, unsigned int maxle=
n,
+					 int last);
 UNUSED static void print_buf(abi_long addr, abi_long len, int last);

Helge


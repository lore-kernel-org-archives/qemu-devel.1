Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582EEC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:25:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15ABD26A72
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KgaMii5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15ABD26A72
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44495 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWiTX-0008WD-BZ
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 10:25:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWiSK-0007mU-Rx
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:24:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWiSJ-0000cM-5J
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:24:28 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWiSI-0000VZ-Tu
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:24:27 -0400
Received: by mail-wm1-x342.google.com with SMTP id t5so6072448wmh.3
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 07:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=hOQxTa1a/K4S/ZJK3d9Rf2b3wefrE5AFQJInh8Xv/Mc=;
	b=KgaMii5f7+XcPB9kYN9lqU2J+99H0gx3FbUMV8ASEX9xnp4A9DKf3A5zv/rklnpz00
	rPwt0GslpruBKoO+cPwkZFYfGQX8XPS1/pm3hRSs3jjy+gxpiyuF/Ljlh6lBozFRXa3J
	FCtqw3gj+wlJd8Y8Y0cJzpTl+xvvDaecAJ1of7pUoclaNL0dCSvd7yQl94h79isiFyXH
	9nk3OjAVEYgtTWSaUDcmHygAHTH0ZeVHSsR1C6g9LPulCcqrRWZQu97dA1d209W6b1jE
	P/dSY4iI0XScsF5OpVMrk4zO0kheDeaR08BxnKK0mKd7n5nPeizhEOazOZrX7gpDOnY6
	juNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=hOQxTa1a/K4S/ZJK3d9Rf2b3wefrE5AFQJInh8Xv/Mc=;
	b=JPeMAUQ5UMRKUsOAJAHNrcTy05doT1l/6p9ARkVs8/c2lvI4cg6PzV1Hve8f0u+1sn
	ryiuL0cWrxNrRTtczKqvpuJpRIHMswumqq7PSxqs9pULMVtRveNcHQpaOpDpKGG6N/Mk
	5mYHts5zaNwANlr82pRtGuV8YSpsdInTBd5Huusb1aGFgGF0Uc0xjrp6z/9QaneO23rx
	LKY5LKtuiFyez0VxXs2Og17AELJd7F3kNgAbSHk5UHDdxwQp73Cc9WYmgAAoCgQ5DcXp
	RBCnYjenIkdannfab64ABJeh2IcwtDkeuQdcHAn9GllyvIE6lbrXQztdSJre6ogDob3K
	hA/w==
X-Gm-Message-State: APjAAAXVQzSA7Sgq8LZKLArzzjCDIYvUQmPicFAX0sjOcO+47xY40z/6
	fVBc7yP7lxIEoF1kvpq0szQ2NQ==
X-Google-Smtp-Source: APXvYqzvWj7ciV50fiS5NvOIYxqHLLdyaEXn47q/wks9hNbvKSF6iadnsQi150oq7cIKQgL+Tn0yFw==
X-Received: by 2002:a1c:2c89:: with SMTP id s131mr6150286wms.142.1559312664141;
	Fri, 31 May 2019 07:24:24 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	x21sm15603595wmi.1.2019.05.31.07.24.22
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 31 May 2019 07:24:22 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 46BAC1FF87;
	Fri, 31 May 2019 15:24:22 +0100 (BST)
References: <20190529064148.19856-1-arilou@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190529064148.19856-1-arilou@gmail.com>
Date: Fri, 31 May 2019 15:24:22 +0100
Message-ID: <87pnny8zxl.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v12 00/20] gdbstub: Refactor command
 packets handler
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jon Doron <arilou@gmail.com> writes:

> This patch series refactors the old gdbstub command packets handler
> with a new infrastructure which should ease extending and adding new
> and missing gdb command packets.

And a:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

for the whole series. I'll see about preparing a PR next week.

>
> version 12 changes:
> - Fixed a bug during rebase of v10 which broke:
>   "Implement breakpoint commands (Z/z pkt) with new infra"
>   which basically broke the remove breakpoint command
> - Changed gdb_handle_packet call to process_string_cmds with a wrapper
>   which handles errors appropriately.
> - Patches which require review:
>   gdbstub: Implement deatch (D pkt) with new infra
>   gdbstub: Implement breakpoint commands (Z/z pkt) with new infra
>   gdbstub: Implement set register (P pkt) with new infra
>   gdbstub: Implement get register (p pkt) with new infra
>   gdbstub: Implement file io (F pkt) with new infra
>   gdbstub: Implement v commands with new infra
>   gdbstub: Implement generic set/query (Q/q pkt) with new infra
>   gdbstub: Implement target halted (? pkt) with new infra
>   gdbstub: Implement qemu physical memory mode
>
> version 11 changes:
> - Add reviewed by tag
> - Requires review:
>   gdbstub: Implement deatch (D pkt) with new infra
>   gdbstub: Implement breakpoint commands (Z/z pkt) with new infra
>   gdbstub: Implement set register (P pkt) with new infra
>   gdbstub: Implement get register (p pkt) with new infra
>   gdbstub: Implement file io (F pkt) with new infra
>   gdbstub: Implement v commands with new infra
>   gdbstub: Implement generic set/query (Q/q pkt) with new infra
>   gdbstub: Implement target halted (? pkt) with new infra
>   gdbstub: Implement qemu physical memory mode
> - Already reviewed:
>   gdbstub: Add infrastructure to parse cmd packets
>   gdbstub: Implement thread_alive (T pkt) with new infra
>   gdbstub: Implement continue (c pkt) with new infra
>   gdbstub: Implement continue with signal (C pkt) with new infra
>   gdbstub: Implement set_thread (H pkt) with new infra
>   gdbstub: Implement write memory (M pkt) with new infra
>   gdbstub: Implement read memory (m pkt) with new infra
>   gdbstub: Implement write all registers (G pkt) with new infra
>   gdbstub: Implement read all registers (g pkt) with new infra
>   gdbstub: Implement step (s pkt) with new infra
>   gdbstub: Clear unused variables in gdb_handle_packet
>
> version 10 changes:
> - Remove kvm added API as this is not really required and can be
>   accomplished by defining a coprocessor callback with a system
>   specific xml (see: 200bf5b7ffea635079cc05fdfb363372b9544ce7)
> - Remove the new QEMU extended commands to read KVM MSRs
> - Various fixes from Code Review by Alex Bennee
> - Change the QEMU specific command to read physical memory to non-User QE=
MU
> - Per patch changes:
>   gdbstub: Add infrastructure to parse cmd packets
>     * remove the union for the flags in GdbCmdParseEntry
>   gdbstub: Implement deatch (D pkt) with new infra
>     * Changed default handling for error flow / command not found
>   gdbstub: Implement continue with signal (C pkt) with new infra
>     * Added comment we dont support C sig;[addr] commands
>   gdbstub: Implement set_thread (H pkt) with new infra
>     * Change num_params check to be equal and not less than
>   gdbstub: Implement breakpoint commands (Z/z pkt) with new infra
>     * Merged z/Z commands into a single patch
>   gdbstub: Implement read memory (m pkt) with new infra
>     * Change num_params check to be equal and not less than
>   gdbstub: Implement file io (F pkt) with new infra
>     * Changed to have a single command parser
>   gdbstub: Implement generic set/query (Q/q pkt) with new infra
>     * Merged q/Q and qemu.Supported patches into a single patch
>   gdbstub: Implement target halted (? pkt) with new infra
>     * Removed TODO comment and added a note about it in the commit msg
>   gdbstub: Implement qemu physical memory mode
>     * Added CONFIG_USER_ONLY where required
>
> version 9 changes:
> - checkpatch fixes
>
> version 8 changes:
> - Add new command to display the Supported qemu generic query/sets
> - kvm: Add API to read/write a MSR
> - Add new commands specific for qemu:
>   * Command to swap the memory GDB sees to be the physical memory
>   * Commands to read and write a MSR
>
> version 7 changes:
> - Fixed few checkpatch complaints
> - Feedback from Alex Bennee
>
> version 4-6 changes:
> - mostly feedback from Richard Henderson
>
> version 3 changes
> - Split the single patch to many individual patches for easier reviewing
>
> version 2 changes
> - Code convention fixes
>
> Jon Doron (20):
>   gdbstub: Add infrastructure to parse cmd packets
>   gdbstub: Implement deatch (D pkt) with new infra
>   gdbstub: Implement thread_alive (T pkt) with new infra
>   gdbstub: Implement continue (c pkt) with new infra
>   gdbstub: Implement continue with signal (C pkt) with new infra
>   gdbstub: Implement set_thread (H pkt) with new infra
>   gdbstub: Implement breakpoint commands (Z/z pkt) with new infra
>   gdbstub: Implement set register (P pkt) with new infra
>   gdbstub: Implement get register (p pkt) with new infra
>   gdbstub: Implement write memory (M pkt) with new infra
>   gdbstub: Implement read memory (m pkt) with new infra
>   gdbstub: Implement write all registers (G pkt) with new infra
>   gdbstub: Implement read all registers (g pkt) with new infra
>   gdbstub: Implement file io (F pkt) with new infra
>   gdbstub: Implement step (s pkt) with new infra
>   gdbstub: Implement v commands with new infra
>   gdbstub: Implement generic set/query (Q/q pkt) with new infra
>   gdbstub: Implement target halted (? pkt) with new infra
>   gdbstub: Clear unused variables in gdb_handle_packet
>   gdbstub: Implement qemu physical memory mode
>
>  gdbstub.c | 1761 ++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 1270 insertions(+), 491 deletions(-)


--
Alex Benn=C3=A9e


Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7498C07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677A02173C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wVPz4ynH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677A02173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42217 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVBQD-0001n5-A1
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 04:55:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVBPB-0001PW-1G
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVBP9-0007wj-Fh
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:54:52 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVBP9-0007w0-5z
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:54:51 -0400
Received: by mail-wm1-x341.google.com with SMTP id i3so15294384wml.4
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 01:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=EqXOuljTFrl/++ZjN5wuqjIx2JVRK+03iauIDzc9gvU=;
	b=wVPz4ynHHiKTjWvLcNf35nBm5VXh3j4ykC5xJ1Gw0SWCkmE2pgXjmyaQHtkg08DiXE
	CPlG2GcVoiwrzoEQXMulvFargy96oUYXdyPjfnYAmqg5bAT39G8HjTpaBZ06POEVe/s4
	JXhYsSaUaES4oUL9lL3HHg5d6G1yYHqzPr1u4odaQkw/VXKzNAVJCWrkonOvWfZVWFA6
	LL3X7lPeHHzGmqQCQCt7PGUE8ZAwBzVbiOpl8K4DgmQuFuG9FespaHXMpyi5BnArNOBB
	yDgoztvWhGwDfcmr85bwTo9q2nNjophmcks8sRDG6vyEeeYYkz/XczhxMg3bylEkAA1w
	q3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=EqXOuljTFrl/++ZjN5wuqjIx2JVRK+03iauIDzc9gvU=;
	b=E3/oAukYQj1iR2cG4lW1o8gANfZ5V2XfaqtelSGTMM8YKGomge0KmFQKHiT3ITo4k2
	VAqeX+kzYsWsmCDT+273I45HsLmc4M495n3snFMAXuyAu1dbohrKdxkkOoI+eGed+ugS
	uI1rYzG9aUkUd3VrEoYDmvAhKRHfG52i3Od0XLp+RjM3yzwEJa73nnR4wGnJjZjTOY4T
	dduBH/fYaJnSi4kp02PQei2yCmWTwRCbjL0lKn7HD9xV4gfBjOYwyBu5WwfGUDLQ/6Uh
	MpL3j4DEh6TV9VfYza4xolDzQtGNpphnlTTn8jXc/91C13bnppw1ff+7KuyzIlobZXl+
	Va6A==
X-Gm-Message-State: APjAAAXoPWWwDNa4v+lES1bWsJTqqWwJgo+upg65FGHx0s8inFqwF09B
	2FF6lp9OeB5zZ+CHJMrFNipOpw==
X-Google-Smtp-Source: APXvYqyLujlh7/xUhwC+mBaDejP0zvmgRPyRIe3Tj5lheBy32yDyhkZNS/pKU0MDOGxsHkFrb61qNg==
X-Received: by 2002:a7b:c844:: with SMTP id c4mr8833555wml.108.1558947289765; 
	Mon, 27 May 2019 01:54:49 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id o8sm25215493wra.4.2019.05.27.01.54.49
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 27 May 2019 01:54:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id C12521FF87;
	Mon, 27 May 2019 09:54:48 +0100 (BST)
References: <20190524160118.31134-1-arilou@gmail.com>
	<20190524160118.31134-3-arilou@gmail.com>
	<87o93oqonk.fsf@zen.linaroharston>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <87o93oqonk.fsf@zen.linaroharston>
Date: Mon, 27 May 2019 09:54:48 +0100
Message-ID: <87muj8qntz.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v11 02/20] gdbstub: Implement deatch (D
 pkt) with new infra
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


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Jon Doron <arilou@gmail.com> writes:
>
>> Signed-off-by: Jon Doron <arilou@gmail.com>
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Hmm although I bisected to this patch which fails on:

09:49 alex@zen/x86_64  [linux.git/master@origin] >gdb ./builds/arm64/vmlinu=
x -x ~/lsrc/qemu.git/tests/guest-debug/test-gdbstub.py
GNU gdb (GDB) 8.3.50.20190424-git
Copyright (C) 2019 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-pc-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Executed .gdbinit
Reading symbols from ./builds/arm64/vmlinux...
Traceback (most recent call last):
  File "/home/alex/lsrc/linux.git/builds/arm64/vmlinux-gdb.py", line 30, in=
 <module>
    import linux.config
ImportError: No module named config
Connecting to remote
0x0000000040000000 in ?? ()
Checking we can step the first few instructions
warning: Invalid remote reply:

Thread 1 received signal SIGINT, Interrupt.
0x0000000040000000 in ?? ()
warning: Invalid remote reply:

Thread 1 received signal SIGINT, Interrupt.
0x0000000040000000 in ?? ()
warning: Invalid remote reply:

Thread 1 received signal SIGINT, Interrupt.
0x0000000040000000 in ?? ()
FAIL: single step in boot code
Checking HW breakpoint works
Hardware assisted breakpoint 1 at 0xffffff8010778f0c: file /home/alex/lsrc/=
linux.git/init/main.c, line 1068.
warning: Invalid remote reply:

Thread 1 received signal SIGINT, Interrupt.
0x0000000040000000 in ?? ()
0x40000000 =3D=3D {int (void *)} 0xffffff8010778f0c <kernel_init>
FAIL: hbreak @ kernel_init
Setup catch-all for run_init_process
Breakpoint 2 at 0xffffff8010083dc4: file /home/alex/lsrc/linux.git/init/mai=
n.c, line 1009.
Breakpoint 3 at 0xffffff8010083e10: file /home/alex/lsrc/linux.git/init/mai=
n.c, line 1020.
Checking Normal breakpoint works
Breakpoint 4 at 0xffffff801077b300: file /home/alex/lsrc/linux.git/kernel/s=
ched/completion.c, line 136.
warning: Invalid remote reply:

Thread 1 received signal SIGINT, Interrupt.
0x0000000040000000 in ?? ()
0x40000000 =3D=3D {void (struct completion *)} 0xffffff801077b300 <wait_for=
_completion> 0
FAIL: break @ wait_for_completion
Checking watchpoint works
Hardware access (read/write) watchpoint 5: *(enum system_states *)(&system_=
state)
warning: Invalid remote reply:

Thread 1 received signal SIGINT, Interrupt.
0x0000000040000000 in ?? ()
FAIL: awatch for system_state (SYSTEM_BOOTING)
Hardware read watchpoint 6: *(enum system_states *)(&system_state)
warning: Invalid remote reply:

Thread 1 received signal SIGINT, Interrupt.
0x0000000040000000 in ?? ()
FAIL: rwatch for system_state (SYSTEM_BOOTING)
Hardware watchpoint 7: *(enum system_states *)(&system_state)
warning: Invalid remote reply:

Thread 1 received signal SIGINT, Interrupt.
0x0000000040000000 in ?? ()
FAIL: watch for system_state (SYSTEM_BOOTING)
[Inferior 1 (process 1) killed]


>
>> ---
>>  gdbstub.c | 93 +++++++++++++++++++++++++++++++------------------------
>>  1 file changed, 53 insertions(+), 40 deletions(-)
>>
>> diff --git a/gdbstub.c b/gdbstub.c
>> index e6d895177b..307366b250 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -1413,11 +1413,6 @@ static inline int startswith(const char *string, =
const char *pattern)
>>    return !strncmp(string, pattern, strlen(pattern));
>>  }
>>
>> -static int process_string_cmd(
>> -        GDBState *s, void *user_ctx, const char *data,
>> -        const GdbCmdParseEntry *cmds, int num_cmds)
>> -        __attribute__((unused));
>> -
>>  static int process_string_cmd(GDBState *s, void *user_ctx, const char *=
data,
>>                                const GdbCmdParseEntry *cmds, int num_cmd=
s)
>>  {
>> @@ -1463,6 +1458,41 @@ static int process_string_cmd(GDBState *s, void *=
user_ctx, const char *data,
>>      return -1;
>>  }
>>
>> +static void handle_detach(GdbCmdContext *gdb_ctx, void *user_ctx)
>> +{
>> +    GDBProcess *process;
>> +    GDBState *s =3D gdb_ctx->s;
>> +    uint32_t pid =3D 1;
>> +
>> +    if (s->multiprocess) {
>> +        if (!gdb_ctx->num_params) {
>> +            put_packet(s, "E22");
>> +            return;
>> +        }
>> +
>> +        pid =3D gdb_ctx->params[0].val_ul;
>> +    }
>> +
>> +    process =3D gdb_get_process(s, pid);
>> +    gdb_process_breakpoint_remove_all(s, process);
>> +    process->attached =3D false;
>> +
>> +    if (pid =3D=3D gdb_get_cpu_pid(s, s->c_cpu)) {
>> +        s->c_cpu =3D gdb_first_attached_cpu(s);
>> +    }
>> +
>> +    if (pid =3D=3D gdb_get_cpu_pid(s, s->g_cpu)) {
>> +        s->g_cpu =3D gdb_first_attached_cpu(s);
>> +    }
>> +
>> +    if (!s->c_cpu) {
>> +        /* No more process attached */
>> +        gdb_syscall_mode =3D GDB_SYS_DISABLED;
>> +        gdb_continue(s);
>> +    }
>> +    put_packet(s, "OK");
>> +}
>> +
>>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>>  {
>>      CPUState *cpu;
>> @@ -1477,6 +1507,7 @@ static int gdb_handle_packet(GDBState *s, const ch=
ar *line_buf)
>>      uint8_t *registers;
>>      target_ulong addr, len;
>>      GDBThreadIdKind thread_kind;
>> +    const GdbCmdParseEntry *cmd_parser =3D NULL;
>>
>>      trace_gdbstub_io_command(line_buf);
>>
>> @@ -1577,42 +1608,15 @@ static int gdb_handle_packet(GDBState *s, const =
char *line_buf)
>>          error_report("QEMU: Terminated via GDBstub");
>>          exit(0);
>>      case 'D':
>> -        /* Detach packet */
>> -        pid =3D 1;
>> -
>> -        if (s->multiprocess) {
>> -            unsigned long lpid;
>> -            if (*p !=3D ';') {
>> -                put_packet(s, "E22");
>> -                break;
>> -            }
>> -
>> -            if (qemu_strtoul(p + 1, &p, 16, &lpid)) {
>> -                put_packet(s, "E22");
>> -                break;
>> -            }
>> -
>> -            pid =3D lpid;
>> -        }
>> -
>> -        process =3D gdb_get_process(s, pid);
>> -        gdb_process_breakpoint_remove_all(s, process);
>> -        process->attached =3D false;
>> -
>> -        if (pid =3D=3D gdb_get_cpu_pid(s, s->c_cpu)) {
>> -            s->c_cpu =3D gdb_first_attached_cpu(s);
>> -        }
>> -
>> -        if (pid =3D=3D gdb_get_cpu_pid(s, s->g_cpu)) {
>> -            s->g_cpu =3D gdb_first_attached_cpu(s);
>> -        }
>> -
>> -        if (s->c_cpu =3D=3D NULL) {
>> -            /* No more process attached */
>> -            gdb_syscall_mode =3D GDB_SYS_DISABLED;
>> -            gdb_continue(s);
>> +        {
>> +            static const GdbCmdParseEntry detach_cmd_desc =3D {
>> +                .handler =3D handle_detach,
>> +                .cmd =3D "D",
>> +                .cmd_startswith =3D 1,
>> +                .schema =3D "?.l0"
>> +            };
>> +            cmd_parser =3D &detach_cmd_desc;
>>          }
>> -        put_packet(s, "OK");
>>          break;
>>      case 's':
>>          if (*p !=3D '\0') {
>> @@ -1985,6 +1989,15 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>>          put_packet(s, buf);
>>          break;
>>      }
>> +
>> +    if (cmd_parser) {
>> +        /* helper will respond */
>> +        process_string_cmd(s, NULL, line_buf, cmd_parser, 1);
>> +    } else {
>> +        /* unknown command, empty respone */
>> +        put_packet(s, "");
>> +    }
>> +
>>      return RS_IDLE;
>>  }


--
Alex Benn=C3=A9e


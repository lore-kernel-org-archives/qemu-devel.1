Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC6BC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 359DA20678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4l3pqAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359DA20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOWb-0003Qv-AT
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jOOT4-0006tx-LF
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:31:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jOOT3-0001Ar-84
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:31:22 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43392)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jOOT3-0001AI-1G
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:31:21 -0400
Received: by mail-wr1-x444.google.com with SMTP id i10so15080695wrv.10
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 09:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:to:cc:from:autocrypt:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=bUeQuorw99Ho/BLVjuAYoW2kjbNgVS9ZdntEABl9u38=;
 b=T4l3pqAwQxiQT4ZueS58CMHoSmugytRvcT1KA6yfEM7/IkAQaSXs3P2/szJXba+5W4
 Ezsm3iTGq9RyP/xQb6uJ14mQfi19AR151Rah1GzF3yPh0dFyrBcID0yBlHsfYIpc/DsC
 Ey6vVKtiGpyc2rvdTLcYtleNEw87hiTSjhZ8NTHiJHXRuSK0EGKNgiuDmoHLlSCTRWCE
 mHKUAxZMFZT+BCt1uuTmoA895yINcDybXGe85mlmYEpJ1s93xGO2i+dUmVJYRZvNBLmY
 8BfDWYJwBBbmanAQnCUeAWS9wws8L2nb5J2sH/FW+Ggqnfd2PsO0B5W1uP/NhVgjqvZY
 CK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:to:cc:from:autocrypt:subject:message-id
 :date:user-agent:mime-version:content-language
 :content-transfer-encoding;
 bh=bUeQuorw99Ho/BLVjuAYoW2kjbNgVS9ZdntEABl9u38=;
 b=ltjtkgGvT0kyIF61vIPPY58hfqiw3Cr3eJm8pD/qeOWmMgsIRdCzd317rO6h2bF3BS
 4OOC6TcgQ1R3BUDqRsNZ72KSp0oymsYr2L2iZUdCZL+19/+iLSl1GPDvoUCxQ5Scxbck
 3hWnLoKuEEDcskApWWUF4k6tYZxR+RtMPeuzIeRQEXyg0tyA3vTvpac3yO2OlKK40ZjS
 fzdP3jrRumz/mzk9/Io9jtSq3WcxWyVg4YLH8sgdY7Rd5v0p9hNQb7JWWQIsfCtqzSs3
 D/kYP1OA+KACgi101IKUhQwVEqunyZsuzBax4taMxzqe1Wpa+N/pIjcmDqnZJh4zDMXt
 NO0w==
X-Gm-Message-State: AGi0PuYg57vNj+yt6Kk3pCPDxzJClNTB3ZBdzVNi6rN9MYZ9UFYL7kfX
 MN2pSGyEVIzNtiRrPBPi1Fo=
X-Google-Smtp-Source: APiQypLAPd9RHcBo4LeMnBsiaTpQJPBQ3zqsAiDq1/Ae1uV+6znAmrXegvByyGqRjpH59kNcR3ncnw==
X-Received: by 2002:adf:97d0:: with SMTP id t16mr24720608wrb.343.1586881879298; 
 Tue, 14 Apr 2020 09:31:19 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id e5sm20316694wru.92.2020.04.14.09.31.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 09:31:18 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Subject: m68k: gdbstub crashing setting float register on cfv4e cpu
Message-ID: <3be54f78-cf6d-af3b-6e1f-e91d146c6a3a@amsat.org>
Date: Tue, 14 Apr 2020 18:31:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

gdbstub/m68k seems broken with floats, previous to refactor commit
a010bdbe719 ("extend GByteArray to read register helpers").

HEAD at 6fb1603aa2:

$ qemu-system-m68k -s -S -cpu cfv4e

---[GUEST]---

(gdb) set architecture m68k:cfv4e
The target architecture is assumed to be m68k:cfv4e
(gdb) target remote 172.17.0.1:1234
Remote debugging using 172.17.0.1:1234
(gdb) info float
fp0            -nan(0xfffffffffff7f) (raw 0xffffffffffffff7f)
fp1            -nan(0xfffffffffff7f) (raw 0xffffffffffffff7f)
fp2            -nan(0xfffffffffff7f) (raw 0xffffffffffffff7f)
fp3            -nan(0xfffffffffff7f) (raw 0xffffffffffffff7f)
fp4            -nan(0xfffffffffff7f) (raw 0xffffffffffffff7f)
fp5            -nan(0xfffffffffff7f) (raw 0xffffffffffffff7f)
fp6            -nan(0xfffffffffff7f) (raw 0xffffffffffffff7f)
fp7            -nan(0xfffffffffff7f) (raw 0xffffffffffffff7f)
fpcontrol      0x0                 0
fpstatus       0x0                 0
fpiaddr        0x0                 0x0
(gdb) set $fp0=1
Remote communication error.  Target disconnected.: Connection reset by peer.

---[HOST]---

30279@1586881511.897231:gdbstub_io_command Received: P12=000000000000f03f
30279@1586881511.897293:gdbstub_io_reply Sent: OK
30279@1586881511.897593:gdbstub_io_got_ack Got ACK
30279@1586881511.897837:gdbstub_io_command Received: g
Aborted (core dumped)

(gdb) bt
#1  0x00007ffff514e895 in abort () at /lib64/libc.so.6
#2  0x00005555556a9548 in roundAndPackFloat64 (zSign=0 '\000', zExp=0,
zSig=0, status=0x7fffffff9b20) at fpu/softfloat.c:3756
#3  0x00005555556ad2bb in floatx80_to_float64 (a=...,
status=0x7fffffff9b20) at fpu/softfloat.c:5659
#4  0x000055555573a6c7 in cf_fpu_gdb_get_reg
    (env=0x555555fb58d0, mem_buf=0x7fffffff9c7c
"\177\377\377\377\377\377\377\377\177\377\377\377\377\377\377\377\177\377\377\377\377\377\377\377\177\377\377\377\377\377\377\377\177\377\377\377\377\377\377\377\177\377\377\377\377\377\377\377\177\377\377\377\377\377\377\377\177\377\377\377\377\377\377\377",
n=0) at target/m68k/helper.c:75
#5  0x00005555556bd866 in gdb_read_register
    (cpu=0x555555fad250, mem_buf=0x7fffffff9c7c
"\177\377\377\377\377\377\377\377\177\377\377\377\377\377\377\377\177\377\377\377\377\377\377\377\177\377\377\377\377\377\377\377\177\377\377\377\377\377\377\377\177\377\377\377\377\377\377\377\177\377\377\377\377\377\377\377\177\377\377\377\377\377\377\377",
reg=18) at gdbstub.c:896
#6  0x00005555556bf665 in handle_read_all_regs (gdb_ctx=0x7fffffff9c20,
user_ctx=0x0) at gdbstub.c:1813
#7  0x00005555556bead0 in process_string_cmd (s=0x5555564bb000,
user_ctx=0x0, data=0x5555564bb01c "g", cmds=0x555555bf5880
<read_all_regs_cmd_desc>, num_cmds=1) at gdbstub.c:1477
#8  0x00005555556beb45 in run_cmd_parser (s=0x5555564bb000,
data=0x5555564bb01c "g", cmd=0x555555bf5880 <read_all_regs_cmd_desc>) at
gdbstub.c:1493
#9  0x00005555556c093a in gdb_handle_packet (s=0x5555564bb000,
line_buf=0x5555564bb01c "g") at gdbstub.c:2596
#10 0x00005555556c15b7 in gdb_read_byte (s=0x5555564bb000, ch=55 '7') at
gdbstub.c:2932
#11 0x00005555556c17ea in gdb_chr_receive (opaque=0x5555564bb000,
buf=0x7fffffffbde0 "$g#67", '0' <repeats 12 times>,
"f03f#5f\347\372\340\366\377\177", size=5) at gdbstub.c:3170
#12 0x000055555595e986 in qemu_chr_be_write_impl (s=0x55555622eac0,
buf=0x7fffffffbde0 "$g#67", '0' <repeats 12 times>,
"f03f#5f\347\372\340\366\377\177", len=5) at chardev/char.c:183
#13 0x000055555595e9ea in qemu_chr_be_write (s=0x55555622eac0,
buf=0x7fffffffbde0 "$g#67", '0' <repeats 12 times>,
"f03f#5f\347\372\340\366\377\177", len=5) at chardev/char.c:195
#14 0x0000555555967734 in tcp_chr_read (chan=0x555555e21290,
cond=G_IO_IN, opaque=0x55555622eac0) at chardev/char-socket.c:525
#15 0x0000555555982fb4 in qio_channel_fd_source_dispatch
(source=0x555556493200, callback=0x555555967585 <tcp_chr_read>,
user_data=0x55555622eac0) at io/channel-watch.c:84
#16 0x00007ffff7c42ecd in g_main_context_dispatch () at
/lib64/libglib-2.0.so.0
#17 0x00005555559ec20c in glib_pollfds_poll () at util/main-loop.c:219
#18 0x00005555559ec286 in os_host_main_loop_wait (timeout=14976775) at
util/main-loop.c:242
#19 0x00005555559ec38b in main_loop_wait (nonblocking=0) at
util/main-loop.c:518
#20 0x00005555557163dd in qemu_main_loop () at softmmu/vl.c:1665
#21 0x0000555555988d21 in main (argc=7, argv=0x7fffffffd078,
envp=0x7fffffffd0b8) at softmmu/main.c:49


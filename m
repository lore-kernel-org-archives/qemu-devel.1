Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13EBC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:29:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB4AB2082C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4AB2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i69co-0000du-Ua
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 04:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i69bz-0008KK-Ge
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 04:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i69bw-0002Zw-Rd
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 04:28:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42334)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i69bw-0002Ya-Iy
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 04:28:52 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EEF77C049D7C
 for <qemu-devel@nongnu.org>; Fri,  6 Sep 2019 08:28:50 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id l6so2230777wrn.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 01:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NYd689ZzWbFE4B3MAJLt9BQIkSLX+l1SzxmZUP+/KzQ=;
 b=fdwlGZZl8y5S69V2tbVuUejiVfflacTG0a3JfR+LmeFrAUf308caolb1Rw5+gFcqQK
 eQiabxka9bVo4Nilo2Rsp6furVqT0jwHUDrkjGL5woCNIKnG3BlUTxGee9w0r+gmiGa/
 tFx+AJ1TStjd4hMeHoF4Sg02NM6vlsGURLbUd7AFvXJYp0ynB044h/hsnaU6wzWYAfSR
 Psk+idI7bBaIF0qwY+yx4YXMH7ELd79nvyYqSiYEP4Pnuo+d5NhxT1q2hzjBhbieqfyW
 uvBC0krMrqozS4XlcLPfyhaTenH56g58xOgl5ylZqjGjkNTyLQEWUDQ5koQwKTbQYnpV
 UmqQ==
X-Gm-Message-State: APjAAAVi4YQ9md3uT3uOo2BjGyXNkAqGkRZSo84QsoNqhnRqg2DfBhPN
 MHQhFGKBJExycIqUW0VtUexdRYl+Vgvo44MZtWur7/2Iq9AJ4Rquptp8XnDlkW8xErA0CkOFRwZ
 EvURpwaf+oweZpN0=
X-Received: by 2002:a5d:4044:: with SMTP id w4mr6330952wrp.281.1567758529045; 
 Fri, 06 Sep 2019 01:28:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzDrNZ4P+95MAPRhjoQxfpGC+ZGoniBR7DwRFFvm05+taFEoRNWLy2Wip35v383MoTn4xtoEg==
X-Received: by 2002:a5d:4044:: with SMTP id w4mr6330936wrp.281.1567758528814; 
 Fri, 06 Sep 2019 01:28:48 -0700 (PDT)
Received: from [192.168.1.48] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id p23sm1669954wma.18.2019.09.06.01.28.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2019 01:28:48 -0700 (PDT)
To: Tony Nguyen <tony.nguyen@bt.com>, qemu-devel@nongnu.org
References: <20190902012647.1761-1-tony.nguyen@bt.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <41e61c1c-15b0-d028-fc23-52e2c59319d2@redhat.com>
Date: Fri, 6 Sep 2019 10:28:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190902012647.1761-1-tony.nguyen@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] memory: Set notdirty_mem_ops validator
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/19 3:26 AM, Tony Nguyen wrote:
> Existing read rejecting validator was mistakenly cleared.
>=20
> Reads dispatched to io_mem_notdirty then segfaults as there is no read
> handler.
>=20
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  exec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/exec.c b/exec.c
> index 1df966d17a..05d664541f 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2796,12 +2796,12 @@ static bool notdirty_mem_accepts(void *opaque, =
hwaddr addr,
> =20
>  static const MemoryRegionOps notdirty_mem_ops =3D {
>      .write =3D notdirty_mem_write,
> -    .valid.accepts =3D notdirty_mem_accepts,
>      .endianness =3D DEVICE_NATIVE_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 1,
>          .max_access_size =3D 8,
>          .unaligned =3D false,
> +        .accepts =3D notdirty_mem_accepts,

I'm surprised the compiler doesn't emit any warning...

>      },
>      .impl =3D {
>          .min_access_size =3D 1,
>=20

mcayland provided a verbose backtrace running Solaris, can we amend it
to this commit?

Thread 4 "qemu-system-spa" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7ffff1d44700 (LWP 23749)]
0x0000000000000000 in ?? ()
(gdb) bt
#0  0x0000000000000000 in  ()
#1  0x00005555557eae4c in memory_region_read_with_attrs_accessor
(mr=3D0x55555633d360 <io_mem_notdirty>, addr=3D531677168,
value=3D0x7ffff1d42eb8, size=3D4, shift=3D0, mask=3D4294967295, attrs=3D.=
..)
    at /home/build/src/qemu/git/qemu/memory.c:461
#2  0x00005555557eb1c4 in access_with_adjusted_size (addr=3D531677168,
value=3D0x7ffff1d42eb8, size=3D4, access_size_min=3D1, access_size_max=3D=
8,
access_fn=3D
    0x5555557eadf0 <memory_region_read_with_attrs_accessor>,
mr=3D0x55555633d360 <io_mem_notdirty>, attrs=3D...) at
/home/build/src/qemu/git/qemu/memory.c:559
#3  0x00005555557edeb0 in memory_region_dispatch_read1
(mr=3D0x55555633d360 <io_mem_notdirty>, addr=3D531677168,
pval=3D0x7ffff1d42eb8, size=3D4, attrs=3D...) at
/home/build/src/qemu/git/qemu/memory.c:1429
#4  0x00005555557edf47 in memory_region_dispatch_read (mr=3D0x55555633d36=
0
<io_mem_notdirty>, addr=3D531677168, pval=3D0x7ffff1d42eb8, op=3DMO_32,
attrs=3D...) at /home/build/src/qemu/git/qemu/memory.c:1451
#5  0x0000555555803846 in io_readx (env=3D0x5555564b15c0,
iotlbentry=3D0x7fffe831e190, mmu_idx=3D2, addr=3D1880588272,
retaddr=3D140736889685638, access_type=3DMMU_DATA_LOAD, op=3DMO_32)
    at /home/build/src/qemu/git/qemu/accel/tcg/cputlb.c:923
#6  0x00005555558063ca in load_helper (full_load=3D0x555555805ffb
<full_be_ldul_mmu>, code_read=3Dfalse, op=3DMO_BEUL,
retaddr=3D140736889685638, oi=3D162, addr=3D1880588272, env=3D0x5555564b1=
5c0)
    at /home/build/src/qemu/git/qemu/accel/tcg/cputlb.c:1346
#7  0x00005555558063ca in full_be_ldul_mmu (env=3D0x5555564b15c0,
addr=3D1880588272, oi=3D162, retaddr=3D140736889685638) at
/home/build/src/qemu/git/qemu/accel/tcg/cputlb.c:1469
#8  0x0000555555806665 in helper_be_ldul_mmu (env=3D0x5555564b15c0,
addr=3D1880588272, oi=3D162, retaddr=3D140736889685638) at
/home/build/src/qemu/git/qemu/accel/tcg/cputlb.c:1476
#9  0x00007fffdc5106cd in code_gen_buffer ()
#10 0x00005555558280da in cpu_tb_exec (cpu=3D0x5555564a8820,
itb=3D0x7fffdc50f7c0 <code_gen_buffer+5306259>) at
/home/build/src/qemu/git/qemu/accel/tcg/cpu-exec.c:172
#11 0x0000555555828ec7 in cpu_loop_exec_tb (cpu=3D0x5555564a8820,
tb=3D0x7fffdc50f7c0 <code_gen_buffer+5306259>, last_tb=3D0x7ffff1d43598,
tb_exit=3D0x7ffff1d43590) at
/home/build/src/qemu/git/qemu/accel/tcg/cpu-exec.c:620
#12 0x00005555558291d5 in cpu_exec (cpu=3D0x5555564a8820) at
/home/build/src/qemu/git/qemu/accel/tcg/cpu-exec.c:731
#13 0x00005555557dc460 in tcg_cpu_exec (cpu=3D0x5555564a8820) at
/home/build/src/qemu/git/qemu/cpus.c:1445
#14 0x00005555557dc76b in qemu_tcg_rr_cpu_thread_fn (arg=3D0x5555564a8820=
)
at /home/build/src/qemu/git/qemu/cpus.c:1547
#15 0x0000555555c562d4 in qemu_thread_start (args=3D0x5555564c8020) at
/home/build/src/qemu/git/qemu/util/qemu-thread-posix.c:502
#16 0x00007ffff6296fa3 in start_thread (arg=3D<optimized out>) at
pthread_create.c:486
#17 0x00007ffff61c74cf in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:95
(gdb)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


Received: from eggs.gnu.org ([2001:4830:134:3::10]:33780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fFrl1-00032H-Jk
	for qemu-devel@nongnu.org; Mon, 07 May 2018 21:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fFrky-0006mO-F3
	for qemu-devel@nongnu.org; Mon, 07 May 2018 21:49:35 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:45374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fFrky-0006m8-52
	for qemu-devel@nongnu.org; Mon, 07 May 2018 21:49:32 -0400
Received: by mail-qt0-x234.google.com with SMTP id j42-v6so39028627qtj.12
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 18:49:31 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fe42db47-7e7c-3ec5-ab5f-8e8653554a74@amsat.org>
Date: Mon, 7 May 2018 22:49:21 -0300
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="b23rEhgo8tvWz6YNbp8Iw4WXSv2a58vcx"
Subject: [Qemu-devel] lm32: tcg_handle_interrupt: assertion failed:
 (qemu_mutex_iothread_locked())
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Walle <michael@walle.cc>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b23rEhgo8tvWz6YNbp8Iw4WXSv2a58vcx
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Michael Walle <michael@walle.cc>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Message-ID: <fe42db47-7e7c-3ec5-ab5f-8e8653554a74@amsat.org>
Subject: lm32: tcg_handle_interrupt: assertion failed:
 (qemu_mutex_iothread_locked())
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Paolo and Michael,

Using LM32 images from http://milkymist.walle.cc/README.qemu
(Whether http://milkymist.walle.cc/updates/2012-03-01/flickernoise or
the flash image) I get:

$ lm32-softmmu/qemu-system-lm32 -M milkymist -kernel flickernoise \
    -d int,guest_errors,trace:lm32\*
16363@1525743492.227513:lm32_pic_set_im im 0x00000000
16363@1525743492.227525:lm32_pic_lower_irq Lower CPU interrupt
16363@1525743492.481203:lm32_pic_interrupt Set IRQ0 0
16363@1525743492.481221:lm32_pic_lower_irq Lower CPU interrupt
16363@1525743492.556285:lm32_pic_get_im im 0x00000000
16363@1525743492.556295:lm32_pic_set_im im 0x00000001
16363@1525743492.556297:lm32_pic_lower_irq Lower CPU interrupt
16363@1525743492.556361:lm32_pic_interrupt Set IRQ0 0
16363@1525743492.556364:lm32_pic_lower_irq Lower CPU interrupt
16363@1525743492.556557:lm32_pic_get_im im 0x00000001
16363@1525743492.556570:lm32_pic_set_im im 0x00000005
16363@1525743492.556572:lm32_pic_lower_irq Lower CPU interrupt
16363@1525743492.559682:lm32_pic_get_im im 0x00000005
16363@1525743492.559687:lm32_pic_set_im im 0x00008005
16363@1525743492.559689:lm32_pic_lower_irq Lower CPU interrupt
16363@1525743492.560139:lm32_pic_get_im im 0x00008005
16363@1525743492.560142:lm32_pic_set_im im 0x00008015
16363@1525743492.560144:lm32_pic_lower_irq Lower CPU interrupt
16363@1525743492.560167:lm32_pic_get_im im 0x00008015
16363@1525743492.560169:lm32_pic_set_im im 0x00008035
16363@1525743492.560170:lm32_pic_lower_irq Lower CPU interrupt
16363@1525743492.560181:lm32_pic_get_im im 0x00008035
16363@1525743492.560183:lm32_pic_set_im im 0x00008075
16363@1525743492.560185:lm32_pic_lower_irq Lower CPU interrupt
16363@1525743492.560196:lm32_pic_get_im im 0x00008075
16363@1525743492.560198:lm32_pic_set_im im 0x000080f5
16363@1525743492.560199:lm32_pic_lower_irq Lower CPU interrupt
16363@1525743492.560413:lm32_pic_get_im im 0x000080f5
16363@1525743492.560417:lm32_pic_set_im im 0x000081f5
16363@1525743492.560418:lm32_pic_lower_irq Lower CPU interrupt
16363@1525743492.560590:lm32_pic_get_im im 0x000081f5
16363@1525743492.560593:lm32_pic_set_im im 0x000083f5
16363@1525743492.560594:lm32_pic_lower_irq Lower CPU interrupt
16363@1525743492.560935:lm32_pic_get_im im 0x000083f5
16363@1525743492.560938:lm32_pic_set_im im 0x0000c3f5
16363@1525743492.560939:lm32_pic_lower_irq Lower CPU interrupt
16363@1525743492.561088:lm32_pic_get_im im 0x0000c3f5
16363@1525743492.561091:lm32_pic_set_im im 0x0000d3f5
16363@1525743492.561092:lm32_pic_lower_irq Lower CPU interrupt
16363@1525743492.562372:lm32_pic_get_im im 0x0000d3f5
16363@1525743492.562376:lm32_pic_set_im im 0x0000f3f5
16363@1525743492.562377:lm32_pic_lower_irq Lower CPU interrupt
16363@1525743492.562983:lm32_pic_get_im im 0x0000f3f5
16363@1525743492.562988:lm32_pic_set_im im 0x0000f3f7
16363@1525743492.562989:lm32_pic_lower_irq Lower CPU interrupt
16363@1525743492.566610:lm32_pic_interrupt Set IRQ2 1
16363@1525743492.566621:lm32_pic_raise_irq Raise CPU interrupt
16363@1525743492.566624:lm32_pic_interrupt Set IRQ2 0
16363@1525743492.566626:lm32_pic_raise_irq Raise CPU interrupt
exception at pc=3D4016e6c0 type=3D6
IN: PC=3D400000c0 start
16363@1525743492.567928:lm32_pic_get_ip ip 0x00000004
16363@1525743492.567932:lm32_pic_get_im im 0x0000f3f7
ie=3D00000002 (IE=3D0 EIE=3D1 BIE=3D0) im=3D0000f3f7 ip=3D00000004
eba=3D40000000 deba=3D00000000
r00=3D00000000 r01=3D00000001 r02=3D408fcfc0 r03=3D00000000
r04=3D00000000 r05=3D40127944 r06=3D00000003 r07=3D00000004
r08=3D6f6c6500 r09=3D00000002 r10=3D00000004 r11=3D408fcf00
r12=3D00000000 r13=3D00000000 r14=3D00000000 r15=3D00000000
r16=3D00000000 r17=3D00000000 r18=3D00000000 r19=3D00000000
r20=3D00000000 r21=3D00000000 r22=3D00000000 r23=3D00000000
r24=3D00000000 r25=3D00000000 r26=3D401f931c r27=3D40906f7c
r28=3D40906f70 r29=3D4016e698 r30=3D4016e6c0 r31=3D00000000


16363@1525743492.568052:lm32_pic_get_ip ip 0x00000004
16363@1525743492.568055:lm32_pic_get_im im 0x0000f3f7
16363@1525743492.568248:lm32_pic_set_ip ip 0x00000004
16363@1525743492.568251:lm32_pic_lower_irq Lower CPU interrupt
16363@1525743492.576609:lm32_pic_interrupt Set IRQ2 1
16363@1525743492.576618:lm32_pic_raise_irq Raise CPU interrupt
16363@1525743492.576622:lm32_pic_interrupt Set IRQ2 0
16363@1525743492.576624:lm32_pic_raise_irq Raise CPU interrupt
exception at pc=3D400fa15c type=3D6
IN: PC=3D400000c0 start
16363@1525743492.576652:lm32_pic_get_ip ip 0x00000004
16363@1525743492.576657:lm32_pic_get_im im 0x0000f3f7
ie=3D00000002 (IE=3D0 EIE=3D1 BIE=3D0) im=3D0000f3f7 ip=3D00000004
eba=3D40000000 deba=3D00000000
r00=3D00000000 r01=3D00000000 r02=3D00000000 r03=3D4090f13c
r04=3D00000000 r05=3D400fa15c r06=3D40902270 r07=3D00000000
r08=3D6e000000 r09=3D00000020 r10=3D0000000f r11=3D418fc3e0
r12=3D418fc514 r13=3D00000000 r14=3D00000000 r15=3D00000000
r16=3D00000000 r17=3D00000000 r18=3D00000000 r19=3D00000000
r20=3D00000000 r21=3D00000000 r22=3D00000000 r23=3D00000000
r24=3D00000000 r25=3D401f89d0 r26=3D401f931c r27=3D4090f530
r28=3D4090f130 r29=3D40124b90 r30=3D400fa15c r31=3D00000000


16363@1525743492.576700:lm32_pic_get_ip ip 0x00000004
16363@1525743492.576704:lm32_pic_get_im im 0x0000f3f7
16363@1525743492.576711:lm32_pic_set_ip ip 0x00000004
16363@1525743492.576714:lm32_pic_lower_irq Lower CPU interrupt
16363@1525743492.578691:lm32_pic_interrupt Set IRQ0 0
16363@1525743492.578699:lm32_pic_lower_irq Lower CPU interrupt
16363@1525743492.586572:lm32_pic_interrupt Set IRQ0 1
16363@1525743492.586582:lm32_pic_raise_irq Raise CPU interrupt
16363@1525743492.586627:lm32_pic_interrupt Set IRQ2 1
16363@1525743492.586632:lm32_pic_raise_irq Raise CPU interrupt
16363@1525743492.586635:lm32_pic_interrupt Set IRQ2 0
16363@1525743492.586648:lm32_pic_raise_irq Raise CPU interrupt
exception at pc=3D401086e4 type=3D6
IN: PC=3D400000c0 start
16363@1525743492.586713:lm32_pic_get_ip ip 0x00000005
16363@1525743492.586716:lm32_pic_get_im im 0x0000f3f7
ie=3D00000002 (IE=3D0 EIE=3D1 BIE=3D0) im=3D0000f3f7 ip=3D00000005
eba=3D40000000 deba=3D00000000
r00=3D00000000 r01=3D00000000 r02=3De0000000 r03=3D0000000d
r04=3D400f9f40 r05=3D408fd028 r06=3D00000002 r07=3D00000000
r08=3D00000003 r09=3D00000000 r10=3D4090f8a8 r11=3D418fc118
r12=3D00000003 r13=3Dfffffffe r14=3D00000002 r15=3D00000001
r16=3D401c14ac r17=3D00000001 r18=3D00000001 r19=3D00000000
r20=3D00000000 r21=3D00000000 r22=3D00000000 r23=3D00000000
r24=3D00000000 r25=3D401f89d0 r26=3D401f931c r27=3D418fca90
r28=3D4090ea94 r29=3D40108710 r30=3D401086e4 r31=3D00000000


16363@1525743492.586741:lm32_pic_get_ip ip 0x00000005
16363@1525743492.586743:lm32_pic_get_im im 0x0000f3f7
16363@1525743492.586857:lm32_pic_interrupt Set IRQ0 0
16363@1525743492.586860:lm32_pic_raise_irq Raise CPU interrupt
16363@1525743492.587192:lm32_pic_set_ip ip 0x00000001
16363@1525743492.587195:lm32_pic_raise_irq Raise CPU interrupt
**
ERROR:qemu/accel/tcg/tcg-all.c:42:tcg_handle_interrupt: assertion
failed: (qemu_mutex_iothread_locked())

$ lm32-softmmu/qemu-system-lm32 -M milkymist -kernel flickernoise \
    -d in_asm,int,guest_errors,trace:\*,trace:-object_\* 2>&1 | tail -40
0x400fc83c:  78 01 40 0f    orhi     r1, r0, 0x400f
0x400fc840:  34 02 00 0f    mvi      r2, 15
0x400fc844:  37 83 00 10    addi     r3, sp, 16
0x400fc848:  38 21 c5 b8    ori      r1, r1, 0xc5b8
0x400fc84c:  f8 00 9b c2    calli    40123754
16390@1525743546.714083:translate_block tb:0x7fb98fe027c0,
pc:0x400fc83c, tb_code:0x7fb98fe02840
16390@1525743546.714101:qemu_mutex_unlock released mutex 0x55e869b01428
(qemu/accel/tcg/translate-all.c:197)
16390@1525743546.714104:qemu_mutex_lock waiting on mutex 0x55e869af3660
(qemu/cpus.c:1765)
16390@1525743546.714106:qemu_mutex_locked taken mutex 0x55e869af3660
(qemu/cpus.c:1765)
16390@1525743546.714109:qemu_mutex_unlock released mutex 0x55e869af3660
(qemu/cpus.c:1773)
16390@1525743546.714114:guest_mem_before_exec cpu=3D0x55e86b632fd0
vaddr=3D0x00000000408fb000 info=3D26
16390@1525743546.714116:qemu_mutex_lock waiting on mutex 0x55e869af3660
(qemu/cpus.c:1765)
16390@1525743546.714118:qemu_mutex_locked taken mutex 0x55e869af3660
(qemu/cpus.c:1765)
16390@1525743546.714120:qemu_mutex_unlock released mutex 0x55e869af3660
(qemu/cpus.c:1773)
16390@1525743546.714122:guest_mem_before_exec cpu=3D0x55e86b632fd0
vaddr=3D0x00000000408f84c8 info=3D10
16390@1525743546.714124:guest_mem_before_exec cpu=3D0x55e86b632fd0
vaddr=3D0x00000000408fb0c0 info=3D10
16390@1525743546.714125:guest_mem_before_exec cpu=3D0x55e86b632fd0
vaddr=3D0x00000000408fb010 info=3D26
16390@1525743546.714127:guest_mem_before_exec cpu=3D0x55e86b632fd0
vaddr=3D0x00000000408fb0c0 info=3D26
16390@1525743546.714128:qemu_mutex_lock waiting on mutex 0x55e869af3660
(qemu/cpus.c:1765)
16390@1525743546.714130:qemu_mutex_locked taken mutex 0x55e869af3660
(qemu/cpus.c:1765)
16390@1525743546.714132:qemu_mutex_unlock released mutex 0x55e869af3660
(qemu/cpus.c:1773)
16390@1525743546.714134:guest_mem_before_exec cpu=3D0x55e86b632fd0
vaddr=3D0x00000000408fb000 info=3D10
16390@1525743546.714135:qemu_mutex_lock waiting on mutex 0x55e869af3660
(qemu/cpus.c:1765)
16390@1525743546.714137:qemu_mutex_locked taken mutex 0x55e869af3660
(qemu/cpus.c:1765)
16390@1525743546.714139:qemu_mutex_unlock released mutex 0x55e869af3660
(qemu/cpus.c:1773)
16390@1525743546.714141:qemu_mutex_lock waiting on mutex 0x55e869b01428
(qemu/accel/tcg/translate-all.c:189)
16390@1525743546.714143:qemu_mutex_locked taken mutex 0x55e869b01428
(qemu/accel/tcg/translate-all.c:189)

0x400fc850:  34 01 00 0f    mvi      r1, 15
0x400fc854:  fb ff fa 92    calli    400fb29c
16390@1525743546.714155:translate_block tb:0x7fb98fe028c0,
pc:0x400fc850, tb_code:0x7fb98fe02940
16390@1525743546.714170:qemu_mutex_unlock released mutex 0x55e869b01428
(qemu/accel/tcg/translate-all.c:197)
16390@1525743546.714172:qemu_mutex_lock waiting on mutex 0x55e869af3660
(qemu/cpus.c:1765)
16390@1525743546.714174:qemu_mutex_locked taken mutex 0x55e869af3660
(qemu/cpus.c:1765)
16390@1525743546.714176:qemu_mutex_unlock released mutex 0x55e869af3660
(qemu/cpus.c:1773)
16390@1525743546.714179:lm32_pic_get_im im 0x00000005
16390@1525743546.714181:lm32_pic_set_im im 0x00008005
16390@1525743546.714183:lm32_pic_raise_irq Raise CPU interrupt
**
ERROR:qemu/accel/tcg/tcg-all.c:42:tcg_handle_interrupt: assertion
failed: (qemu_mutex_iothread_locked())

$lm32-softmmu/qemu-system-lm32 -M milkymist \
    -pflash flash-2012-07-09.img \
    -d in_asm,int,guest_errors,trace:\*,trace:-object_\* 2>&1 | tail -40
0x00866c28:  58 40 00 00    sw       (r2+0), r0
0x00866c2c:  78 02 e0 00    orhi     r2, r0, 0xe000
0x00866c30:  58 41 00 00    sw       (r2+0), r1
0x00866c34:  d0 24 00 00    wcsr     im, r4
16512@1525743851.406891:translate_block tb:0x7f856cfd0d00, pc:0x866c28,
tb_code:0x7f856cfd0d80
16512@1525743851.406910:qemu_mutex_unlock released mutex 0x5576313a7428
(qemu/accel/tcg/translate-all.c:197)
16512@1525743851.406912:guest_mem_before_exec cpu=3D0x557631fac0d0
vaddr=3D0x0000000044000434 info=3D26
16512@1525743851.406914:guest_mem_before_exec cpu=3D0x557631fac0d0
vaddr=3D0x00000000e0000000 info=3D26
16512@1525743851.406916:qemu_mutex_lock waiting on mutex 0x557631399660
(qemu/cpus.c:1765)
16512@1525743851.406918:qemu_mutex_locked taken mutex 0x557631399660
(qemu/cpus.c:1765)
16512@1525743851.406921:memory_region_subpage_write cpu 0 mr
0x5576321d07d0 offset 0x0 value 0x56 size 4
16512@1525743851.406924:memory_region_ops_write cpu 0 mr 0x557631fec500
addr 0x60000000 value 0x56 size 4
16512@1525743851.406926:milkymist_uart_memory_write addr 0x00000000
value 0x00000056
16512@1525743851.406928:qemu_mutex_lock waiting on mutex 0x557631f8ec18
(qemu/chardev/char.c:109)
16512@1525743851.406931:qemu_mutex_locked taken mutex 0x557631f8ec18
(qemu/chardev/char.c:109)
16512@1525743851.406941:qemu_mutex_unlock released mutex 0x557631f8ec18
(qemu/chardev/char.c:130)
16512@1525743851.406943:milkymist_uart_raise_irq Raise IRQ
16512@1525743851.406944:qemu_mutex_lock waiting on mutex 0x557631399660
(qemu/cpus.c:1765)
16512@1525743851.406946:lm32_pic_interrupt Set IRQ0 1
16512@1525743851.406954:lm32_pic_lower_irq Lower CPU interrupt
16512@1525743851.406957:qemu_mutex_unlock released mutex 0x557631399660
(qemu/cpus.c:1773)
16512@1525743851.406959:qemu_mutex_locked taken mutex 0x557631399660
(qemu/cpus.c:1765)
16512@1525743851.406960:lm32_pic_set_im im 0x00000001
16512@1525743851.406967:lm32_pic_raise_irq Raise CPU interrupt
16512@1525743851.406964:lockcnt_fast_path_attempt lockcnt 0x557631f131cc
fast path 0->4
16512@1525743851.406974:lockcnt_fast_path_success lockcnt 0x557631f131cc
fast path 0->4 succeeded
16512@1525743851.406978:lockcnt_fast_path_attempt lockcnt 0x557631f11e1c
fast path 0->4
16512@1525743851.406982:lockcnt_fast_path_success lockcnt 0x557631f11e1c
fast path 0->4 succeeded
**
ERROR:qemu/accel/tcg/tcg-all.c:42:tcg_handle_interrupt: assertion
failed: (qemu_mutex_iothread_locked())
16512@1525743851.406987:qemu_mutex_lock waiting on mutex 0x557631f11bc8
(qemu/util/qemu-timer.c:520)
16512@1525743851.406991:qemu_mutex_locked taken mutex 0x557631f11bc8
(qemu/util/qemu-timer.c:520)
16512@1525743851.406995:qemu_mutex_unlock released mutex 0x557631f11bc8
(qemu/util/qemu-timer.c:523)
16512@1525743851.406999:qemu_mutex_lock waiting on mutex 0x557631f11c38
(qemu/util/qemu-timer.c:520)
16512@1525743851.407003:qemu_mutex_locked taken mutex 0x557631f11c38
(qemu/util/qemu-timer.c:520)
16512@1525743851.407007:qemu_mutex_unlock released mutex 0x557631f11c38
(qemu/util/qemu-timer.c:523)
16512@1525743851.407011:qemu_mutex_lock waiting on mutex 0x5576313b8fa0
(qemu/vl.c:769)
16512@1525743851.407015:qemu_mutex_locked taken mutex 0x5576313b8fa0
(qemu/vl.c:769)
16512@1525743851.407019:qemu_mutex_unlock released mutex 0x5576313b8fa0
(qemu/vl.c:772)
16512@1525743851.407023:qemu_mutex_lock waiting on mutex 0x557631f11bc8
(qemu/util/qemu-timer.c:234)
16512@1525743851.407027:qemu_mutex_locked taken mutex 0x557631f11bc8
(qemu/util/qemu-timer.c:234)
16512@1525743851.407031:qemu_mutex_unlock released mutex 0x557631f11bc8
(qemu/util/qemu-timer.c:240)
16512@1525743851.407035:qemu_mutex_lock waiting on mutex 0x557631f11c38
(qemu/util/qemu-timer.c:234)
16512@1525743851.407039:qemu_mutex_locked taken mutex 0x557631f11c38
(qemu/util/qemu-timer.c:234)
16512@1525743851.407043:qemu_mutex_unlock released mutex 0x557631f11c38
(qemu/util/qemu-timer.c:240)
16512@1525743851.407052:qemu_mutex_unlock released mutex 0x557631399660
(qemu/cpus.c:1773)

(gdb) bt
#0  0x00007fe1640b7e7b in __GI_raise (sig=3Dsig@entry=3D6) at
=2E./sysdeps/unix/sysv/linux/raise.c:51
#1  0x00007fe1640b9231 in __GI_abort () at abort.c:79
#2  0x00007fe17d5eefa5 in g_assertion_message () at
/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#3  0x00007fe17d5ef00a in g_assertion_message_expr () at
/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#4  0x0000559d92ace7d5 in tcg_handle_interrupt (cpu=3D0x559d93aa35d0,
mask=3D2) at qemu/accel/tcg/tcg-all.c:42
#5  0x0000559d92af1b3c in cpu_interrupt (cpu=3D0x559d93aa35d0, mask=3D2) =
at
qemu/include/qom/cpu.h:848
#6  0x0000559d92af2516 in cpu_irq_handler (opaque=3D0x559d93aa35d0, irq=3D=
0,
level=3D1) at qemu/hw/lm32/milkymist.c:59
#7  0x0000559d92b6639d in qemu_set_irq (irq=3D0x559d93a0f250, level=3D1) =
at
qemu/hw/core/irq.c:45
#8  0x0000559d92b76d5f in qemu_irq_raise (irq=3D0x559d93a0f250) at
qemu/include/hw/irq.h:16
#9  0x0000559d92b7723e in update_irq (s=3D0x559d93adba00) at
qemu/hw/intc/lm32_pic.c:51
#10 0x0000559d92b7738e in lm32_pic_set_im (d=3D0x559d93adba00, im=3D1) at=

qemu/hw/intc/lm32_pic.c:82
#11 0x0000559d92af72e0 in helper_wcsr_im (env=3D0x559d93aab870, im=3D1) a=
t
qemu/target/lm32/op_helper.c:105
#12 0x00007fe155e250ca in code_gen_buffer ()
#13 0x0000559d92adec8e in cpu_tb_exec (cpu=3D0x559d93aa35d0,
itb=3D0x7fe155e24fc0 <code_gen_buffer+49043>)
    at qemu/accel/tcg/cpu-exec.c:169
#14 0x0000559d92adf9e1 in cpu_loop_exec_tb (cpu=3D0x559d93aa35d0,
tb=3D0x7fe155e24fc0 <code_gen_buffer+49043>, last_tb=3D0x7fe154e13608,
tb_exit=3D0x7fe154e13604) at qemu/accel/tcg/cpu-exec.c:626
#15 0x0000559d92adfcd3 in cpu_exec (cpu=3D0x559d93aa35d0) at
qemu/accel/tcg/cpu-exec.c:734
#16 0x0000559d92aa29cf in tcg_cpu_exec (cpu=3D0x559d93aa35d0) at
qemu/cpus.c:1362
#17 0x0000559d92aa2bfb in qemu_tcg_rr_cpu_thread_fn (arg=3D0x559d93aa35d0=
)
at qemu/cpus.c:1461
#18 0x00007fe1644445aa in start_thread (arg=3D0x7fe154e16700) at
pthread_create.c:463
#19 0x00007fe164179cbf in clone () at
=2E./sysdeps/unix/sysv/linux/x86_64/clone.S:95
(gdb) info thr
  Id   Target Id         Frame
* 1    Thread 0x7fe154e16700 (LWP 16587) __GI_raise (sig=3Dsig@entry=3D6)=
 at
=2E./sysdeps/unix/sysv/linux/raise.c:51
  2    Thread 0x7fe155e18700 (LWP 16585) 0x00007fe16444cf62 in
futex_abstimed_wait_cancelable (private=3D0, abstime=3D0x7fe155e15650,
expected=3D0,
    futex_word=3D0x559d93a89658) at
=2E./sysdeps/unix/sysv/linux/futex-internal.h:205
  3    Thread 0x7fe158619700 (LWP 16584) syscall () at
=2E./sysdeps/unix/sysv/linux/x86_64/syscall.S:38
  4    Thread 0x7fe1807b3f80 (LWP 16582) 0x00007fe16416f6d6 in
__GI_ppoll (fds=3D0x559d93d73ce0, nfds=3D6, timeout=3D<optimized out>,
sigmask=3D0x0)
    at ../sysdeps/unix/sysv/linux/ppoll.c:39
  5    Thread 0x7fe13d38d700 (LWP 16588) 0x00007fe16416f5d9 in
__GI___poll (fds=3D0x559d93cff580, nfds=3D1, timeout=3D-1)
    at ../sysdeps/unix/sysv/linux/poll.c:29
  6    Thread 0x7fe155617700 (LWP 16586) 0x00007fe16416f6d6 in
__GI_ppoll (fds=3D0x7fe148000b20, nfds=3D1, timeout=3D<optimized out>,
sigmask=3D0x0)
    at ../sysdeps/unix/sysv/linux/ppoll.c:39
  7    Thread 0x7fe13cb8c700 (LWP 16589) 0x00007fe16416f5d9 in
__GI___poll (fds=3D0x559d93d11400, nfds=3D2, timeout=3D-1)
    at ../sysdeps/unix/sysv/linux/poll.c:29

Trying to bisect, same happens with v2.12.0 & v2.11.0, however I'm
unable to build v2.10.0 ...

Any idea what's going on?

Regards,

Phil.


--b23rEhgo8tvWz6YNbp8Iw4WXSv2a58vcx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlrxAiQACgkQ4+MsLN6t
wN7A6w/7B0MGHPU8F96x3a+D2yUvIOAgwowkfuamk9HcCR3n4uW4xzlc5D5gxI1x
PYY8pbxoKKe+iZTD3hX+JfnJXZdA+D94UeyqEZOj01n31ZA+IwV4kMCM0fEH2DIZ
paBwZk2iKYVRaCCjmZIFeVgVXcW+8hPoK+TEqAyE32PaLjLPyDUDV7HjyU60n8t8
nZW0zNwfVEGNwa9ZtoXdjgQCf93jjQzgUAN65T+dodd5cEaijKr6bN/nxj7fA5ea
3ZlfbxhwKKq0ZKxFTeCroG7+PCIWBvhzDkVDNPSxUiRAxpDZs7mdLXObswnrmoII
lbVQX+yyRslLwX0vaYtYup+x9/XYDalwig6V2BIGnTB70CCRjOv+XpihLUIha0sg
NcRWvB5R8Qcov0kYhhDrMg01aPYWnhRpipdln0Uceh6I22V18m/n8V8vgzth13f1
Xuc9OEqgG5cIc3LfT/NOJm+Y0E8dpLRNaZTCro3Pv9b7bH/wHyNehCWy4XHLHyhA
zhSEhmE61ZZdNRgIDArvAP5iqrBt/hBFbxNcr5i/XwrtnlGQsQGMw6btGRFxmklY
9vv+vXdSuqnIW+5zW9gTbDU/oPpbcMtH90EXnC9raAX5F70EX5z+yMg00fGc+e4r
CxoMg2e6DobT/qb8/ZoaTxT0NU1T8uw26qgHvdF3PME+FRAKzWw=
=ee8c
-----END PGP SIGNATURE-----

--b23rEhgo8tvWz6YNbp8Iw4WXSv2a58vcx--

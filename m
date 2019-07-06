Return-Path: <SRS0=Pmsr=VD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB532C5B578
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 09:59:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCAE920989
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 09:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAE920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjhTV-0003gu-LQ
	for qemu-devel@archiver.kernel.org; Sat, 06 Jul 2019 05:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34300)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hjhSX-0003F1-5u
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 05:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hjhSV-0006c8-3L
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 05:58:21 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:49946
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hjhST-0006Mo-3I
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 05:58:18 -0400
Received: from host109-146-132-17.range109-146.btcentralplus.com
 ([109.146.132.17] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hjhPF-0005RK-W0
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 10:54:58 +0100
To: qemu-devel <qemu-devel@nongnu.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Openpgp: preference=signencrypt
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <3c8b83fe-120b-40e6-84d5-5a3b88e46ee3@ilande.co.uk>
Date: Sat, 6 Jul 2019 10:55:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 109.146.132.17
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] Parallel make build fails on fast machine
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

Today I tried transferring my QEMU development setup from my laptop onto a faster
desktop machine (Intel i7-6700) and was surprised to find my normal "full" build
script failing:

./configure --target-list='x86_64-softmmu sparc64-softmmu sparc-softmmu ppc-softmmu
arm-softmmu' --prefix=/home/build/rel-qemu-git
make V=1 -j2 install

Things start to go wrong around here:

cc -iquote /home/build/src/qemu/git/qemu/hw/i386/kvm -iquote hw/i386/kvm -iquote
/home/build/src/qemu/git/qemu/tcg -iquote /home/build/src/qemu/git/qemu/tcg/i386
-I/home/build/src/qemu/git/qemu/linux-headers
-I/home/build/src/qemu/git/qemu/linux-headers -iquote . -iquote
/home/build/src/qemu/git/qemu -iquote /home/build/src/qemu/git/qemu/accel/tcg -iquote
/home/build/src/qemu/git/qemu/include -I/usr/include/pixman-1
-I/home/build/src/qemu/git/qemu/dtc/libfdt -Werror  -pthread -I/usr/include/glib-2.0
-I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE
-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls
-Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common
-fwrapv -std=gnu99  -Wendif-labels -Wno-shift-negative-value
-Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wformat-security
-Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration
-Wold-style-definition -Wtype-limits -fstack-protector-strong
-I/usr/include/p11-kit-1   -I/usr/include/libpng16
-I/home/build/src/qemu/git/qemu/capstone/include  -I../linux-headers -iquote ..
-iquote /home/build/src/qemu/git/qemu/target/i386 -DNEED_CPU_H -iquote
/home/build/src/qemu/git/qemu/include -MMD -MP -MT hw/i386/kvm/i8259.o -MF
hw/i386/kvm/i8259.d -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -g   -c -o
hw/i386/kvm/i8259.o /home/build/src/qemu/git/qemu/hw/i386/kvm/i8259.c
exec.o: In function `reclaim_ramblock':
/home/build/src/qemu/git/qemu/exec.c:2471: undefined reference to `qemu_ram_munmap'
/home/build/src/qemu/git/qemu/exec.c:2475: undefined reference to `qemu_anon_ram_free'
exec.o: In function `cpu_notify_map_clients_locked':
/home/build/src/qemu/git/qemu/exec.c:3579: undefined reference to `qemu_bh_schedule'
exec.o: In function `mtree_print_phys_entries':
/home/build/src/qemu/git/qemu/exec.c:4169: undefined reference to `qemu_printf'
/home/build/src/qemu/git/qemu/exec.c:4171: undefined reference to `qemu_printf'
/home/build/src/qemu/git/qemu/exec.c:4177: undefined reference to `qemu_printf'
/home/build/src/qemu/git/qemu/exec.c:4175: undefined reference to `qemu_printf'
/home/build/src/qemu/git/qemu/exec.c:4167: undefined reference to `qemu_printf'
exec.o:/home/build/src/qemu/git/qemu/exec.c:4173: more undefined references to
`qemu_printf' follow
exec.o: In function `rcu_read_lock':
/home/build/src/qemu/git/qemu/include/qemu/rcu.h:82: undefined reference to `rcu_gp_ctr'
/home/build/src/qemu/git/qemu/include/qemu/rcu.h:83: undefined reference to `rcu_reader'
exec.o: In function `rcu_read_unlock':
/home/build/src/qemu/git/qemu/include/qemu/rcu.h:93: undefined reference to `rcu_reader'
/home/build/src/qemu/git/qemu/include/qemu/rcu.h:109: undefined reference to
`rcu_gp_event'
exec.o: In function `rcu_read_lock':
/home/build/src/qemu/git/qemu/include/qemu/rcu.h:78: undefined reference to `rcu_reader'
exec.o: In function `cpu_physical_memory_set_dirty_range':
/home/build/src/qemu/git/qemu/include/exec/ram_addr.h:293: undefined reference to
`bitmap_set_atomic'
/home/build/src/qemu/git/qemu/include/exec/ram_addr.h:297: undefined reference to
`bitmap_set_atomic'
/home/build/src/qemu/git/qemu/include/exec/ram_addr.h:301: undefined reference to
`bitmap_set_atomic'
exec.o: In function `qemu_ram_setup_dump':
/home/build/src/qemu/git/qemu/exec.c:2020: undefined reference to `qemu_madvise'
exec.o: In function `cpu_physical_memory_range_includes_clean':
/home/build/src/qemu/git/qemu/include/exec/ram_addr.h:236: undefined reference to
`rcu_reader'
exec.o: In function `cpu_physical_memory_all_dirty':
/home/build/src/qemu/git/qemu/include/exec/ram_addr.h:190: undefined reference to
`find_next_zero_bit'
exec.o: In function `rcu_read_lock':
/home/build/src/qemu/git/qemu/include/qemu/rcu.h:78: undefined reference to `rcu_reader'
exec.o: In function `cpu_physical_memory_all_dirty':
/home/build/src/qemu/git/qemu/include/exec/ram_addr.h:190: undefined reference to
`find_next_zero_bit'
exec.o: In function `rcu_read_lock':
/home/build/src/qemu/git/qemu/include/qemu/rcu.h:78: undefined reference to `rcu_reader'
exec.o: In function `cpu_physical_memory_all_dirty':
/home/build/src/qemu/git/qemu/include/exec/ram_addr.h:190: undefined reference to
`find_next_zero_bit'
exec.o: In function `rcu_read_lock':
/home/build/src/qemu/git/qemu/include/qemu/rcu.h:78: undefined reference to `rcu_reader'
exec.o: In function `rcu_read_unlock':
/home/build/src/qemu/git/qemu/include/qemu/rcu.h:109: undefined reference to
`rcu_gp_event'
exec.o: In function `rcu_read_lock':
/home/build/src/qemu/git/qemu/include/qemu/rcu.h:82: undefined reference to `rcu_gp_ctr'
/home/build/src/qemu/git/qemu/include/qemu/rcu.h:78: undefined reference to `rcu_reader'
/home/build/src/qemu/git/qemu/include/qemu/rcu.h:78: undefined reference to `rcu_reader'
exec.o: In function `cpu_physical_memory_test_and_clear_dirty':
/home/build/src/qemu/git/qemu/exec.c:1378: undefined reference to
`bitmap_test_and_clear_atomic'
exec.o: In function `rcu_read_unlock':
/home/build/src/qemu/git/qemu/include/qemu/rcu.h:93: undefined reference to `rcu_reader'
/home/build/src/qemu/git/qemu/include/qemu/rcu.h:94: undefined reference to `rcu_reader'
/home/build/src/qemu/git/qemu/include/qemu/rcu.h:107: undefined reference to `rcu_reader'
/home/build/src/qemu/git/qemu/include/qemu/rcu.h:108: undefined reference to `rcu_reader'
/home/build/src/qemu/git/qemu/include/qemu/rcu.h:109: undefined reference to
`rcu_gp_event'
/home/build/src/qemu/git/qemu/include/qemu/rcu.h:109: undefined reference to
`qemu_event_set'
exec.o: In function `rcu_read_lock':
/home/build/src/qemu/git/qemu/include/qemu/rcu.h:82: undefined reference to `rcu_gp_ctr'
exec.o: In function `cpu_exec_initfn':
/home/build/src/qemu/git/qemu/exec.c:958: undefined reference to `qemu_get_thread_id'
exec.o: In function `parse_cpu_option':
/home/build/src/qemu/git/qemu/exec.c:1011: undefined reference to `error_fatal'
/home/build/src/qemu/git/qemu/exec.c:998: undefined reference to `error_report'
/home/build/src/qemu/git/qemu/exec.c:1004: undefined reference to `error_report'
exec.o: In function `rcu_read_lock':

For reference I've uploaded the full build output to
https://www.ilande.co.uk/tmp/qemu/qemu-parallel-make-fail.txt. I've also confirmed
that the build completes fine when removing the -j parameter from the make
incantation above.


ATB,

Mark.


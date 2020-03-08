Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCE7C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 11:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D9D2072A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 11:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D9D2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAuaO-0005i4-Uj
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 07:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jAuZd-00057z-Tt
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 07:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jAuZc-0002bX-Cj
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 07:58:25 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:39542
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jAuZc-0002ZC-6p
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 07:58:24 -0400
Received: from host86-162-6-80.range86-162.btcentralplus.com ([86.162.6.80]
 helo=[192.168.1.65]) by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jAuZt-0002di-Qt; Sun, 08 Mar 2020 11:58:42 +0000
To: Pan Nengyuan <pannengyuan@huawei.com>, qemu-devel@nongnu.org
References: <20200305065422.12707-1-pannengyuan@huawei.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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
Message-ID: <8af2cdaa-7e3e-409f-5351-7fc54e00aab5@ilande.co.uk>
Date: Sun, 8 Mar 2020 11:58:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305065422.12707-1-pannengyuan@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.162.6.80
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v4 0/3] delay timer_new from init to realize to fix
 memleaks.
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:41c9:1:41f::167
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/03/2020 06:54, Pan Nengyuan wrote:

> This series delay timer_new from init into realize to avoid memleaks when we call 'device_list_properties'.
> And do timer_free only in s390x_cpu_finalize because it's hotplugable. However, mos6522_realize is never called 
> at all due to the incorrect creation of it. So we aslo fix the incorrect creation in mac_via first, then move the
> timer_new to mos6522_realize().
> 
> v1:
>    - Delay timer_new() from init() to realize() to fix memleaks.
> v2:
>    - Similarly to other cleanups, move timer_new into realize in target/s390x/cpu.c (Suggested by Philippe Mathieu-Daudé).
>    - Send these two patches as a series instead of send each as a single patch but with wrong subject in v1.
> v3:
>    - It's not valid in mos6522 if we move timer_new from init to realize, because it's never called at all.
>      Thus, we remove null check in reset, and add calls to mos6522_realize() in mac_via_realize to make this move to be valid.
>    - split patch by device to make it more clear.
> v4:
>    - Aslo do timer_free on the error path in realize() and fix some coding style. Then use device_class_set_parent_unrealize to declare unrealize. 
>    - split the mos6522 patch into two, one to fix incorrect creation of mos6522, the other to fix memleak.
> 
> Pan Nengyuan (3):
>   s390x: fix memleaks in cpu_finalize
>   mac_via: fix incorrect creation of mos6522 device in mac_via
>   hw/misc/mos6522: move timer_new from init() into realize() to avoid
>     memleaks
> 
>  hw/misc/mac_via.c      | 43 +++++++++++++++++++++++++++++-------------
>  hw/misc/mos6522.c      |  6 ++++++
>  target/s390x/cpu-qom.h |  1 +
>  target/s390x/cpu.c     | 41 ++++++++++++++++++++++++++++++++++++----
>  4 files changed, 74 insertions(+), 17 deletions(-)

I just tried this patchset applied on top of git master and it causes qemu-system-ppc
to segfault on startup:

$ gdb --args ./qemu-system-ppc
...
...
Thread 1 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
0x0000555555e7e38c in timer_del (ts=0x0) at util/qemu-timer.c:429
429         QEMUTimerList *timer_list = ts->timer_list;
(gdb) bt
#0  0x0000555555e7e38c in timer_del (ts=0x0) at util/qemu-timer.c:429
#1  0x0000555555b5d2c1 in mos6522_reset (dev=0x555556e0ac50) at hw/misc/mos6522.c:468
#2  0x0000555555b63570 in mos6522_cuda_reset (dev=0x555556e0ac50) at
hw/misc/macio/cuda.c:599
#3  0x0000555555ad9dd5 in device_transitional_reset (obj=0x555556e0ac50) at
hw/core/qdev.c:1136
#4  0x0000555555ae0755 in resettable_phase_hold (obj=0x555556e0ac50, opaque=0x0,
type=RESET_TYPE_COLD) at hw/core/resettable.c:182
#5  0x0000555555add5f8 in bus_reset_child_foreach (obj=0x555556a472a0,
cb=0x555555ae0605 <resettable_phase_hold>, opaque=0x0, type=RESET_TYPE_COLD) at
hw/core/bus.c:94
#6  0x0000555555ae0418 in resettable_child_foreach (rc=0x55555696af80,
obj=0x555556a472a0, cb=0x555555ae0605 <resettable_phase_hold>, opaque=0x0,
type=RESET_TYPE_COLD) at hw/core/resettable.c:96
#7  0x0000555555ae06db in resettable_phase_hold (obj=0x555556a472a0, opaque=0x0,
type=RESET_TYPE_COLD) at hw/core/resettable.c:173
#8  0x0000555555ae02ab in resettable_assert_reset (obj=0x555556a472a0,
type=RESET_TYPE_COLD) at hw/core/resettable.c:60
#9  0x0000555555ae01ef in resettable_reset (obj=0x555556a472a0, type=RESET_TYPE_COLD)
at hw/core/resettable.c:45
#10 0x0000555555ae0afa in resettable_cold_reset_fn (opaque=0x555556a472a0) at
hw/core/resettable.c:269
#11 0x0000555555ae13a0 in qemu_devices_reset () at hw/core/reset.c:69
#12 0x000055555597d54c in qemu_system_reset (reason=SHUTDOWN_CAUSE_NONE) at
/home/build/src/qemu/git/qemu/softmmu/vl.c:1393
#13 0x00005555559855bb in qemu_init (argc=1, argv=0x7fffffffea78,
envp=0x7fffffffea88) at /home/build/src/qemu/git/qemu/softmmu/vl.c:4418
#14 0x0000555555e1b646 in main (argc=1, argv=0x7fffffffea78, envp=0x7fffffffea88) at
/home/build/src/qemu/git/qemu/softmmu/main.c:48


Possibly related to some of the new reset changes?


ATB,

Mark.


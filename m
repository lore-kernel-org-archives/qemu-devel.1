Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD46C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB3F20715
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyrjvFDZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB3F20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIpGj-00026v-5g
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 04:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kIpBb-0003as-9O
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 04:22:35 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37509)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kIpBY-0005EO-Er
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 04:22:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id z4so1052809wrr.4
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 01:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=xUtI6qAmiLpK/D2Qh5YKRAkuoZ+vUq50xwjqLEQOxHc=;
 b=IyrjvFDZUt0vZJ50mH6hJ8KZsD/LxlgC+Md1I3gLmhz0DAodDbpfZg6L/GVyFs3FGY
 zAUNw99b+njRd1u7kq37iWY6UG8ip/wuy/lVPgfQpasiIE0Zz7+SrAq0vPleyl+4gQXH
 Fw0ibdtvcG9wxjDOfb9FL/diwR43O4BeNnxeXsRAb/BgrkMUAfduZxFyCbf+Bqp2vJKE
 iKG0rvqFhqhrInNRYI48bz5JfP3h2NTZ2qrQXhSJ1fau5I891D0LFp/aQ9I3y381cmX2
 nrIxmwV+OYc2+i2jBC7HD2vCBAsA7Z4KfeVnrCQG+09b9GrhUNgk7YzX8nNUtmQ9oCfz
 08sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=xUtI6qAmiLpK/D2Qh5YKRAkuoZ+vUq50xwjqLEQOxHc=;
 b=bRpffLa3bgQvFMNZtOtarrcYbY9GA0iZBmKNhFNQhGKFg4uVRd9EKPNsih729QKJHl
 YQWpJneke23xzmrFB31pzcO7xDaoCLJUC3hL6HZU3WZE5SprHcy9m/Hq8LqTUIOzuyBD
 kxFQ2UBMfTCoeXm+L+dvhk7wqAqxwwQAb4h2YRWICfkgqgIzQns2CtPINpm3ZnncfCWZ
 AlXNAEnYzm8/pSs3X/lZAB739pYItHYANnEiq4qQ7kaTWqkqa/p5nFOm+su1YJwDHxlV
 UOA7V2LtCW/1nnZGBIWiAoMa7t0dM6DN73uQS76TxVP6otmaWY+lOSBseC1ndkIKfL5i
 oIpg==
X-Gm-Message-State: AOAM532WHV1SYvlDURCNJbwy6i3MCnneBfKDuiO/SCjXwQ+HlV5wgnL4
 NP4DvhTIHWstMGU6dYdTzJE+1KwZDu+Geu10t+E=
X-Google-Smtp-Source: ABdhPJwVZF2/KklqeGDg161zO4X11m3yBM03/JraLlu6c/skWPe4AOomWvjXMArCgJ//EMHm7q+Ibs7LcEDS69f40DM=
X-Received: by 2002:a5d:4c4c:: with SMTP id n12mr17388912wrt.162.1600330950485; 
 Thu, 17 Sep 2020 01:22:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7504:0:0:0:0:0 with HTTP; Thu, 17 Sep 2020 01:22:30
 -0700 (PDT)
In-Reply-To: <1600222344-16808-1-git-send-email-chenhc@lemote.com>
References: <1600222344-16808-1-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 17 Sep 2020 10:22:30 +0200
Message-ID: <CAHiYmc6br+UYwxFa9sS8Xu=zubXVOJ5ms6+2NBk=0YOnmnjQ7A@mail.gmail.com>
Subject: Re: [PATCH V9 0/6] mips: Add Loongson-3 machine support
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000d3a8f005af7e1522"
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d3a8f005af7e1522
Content-Type: text/plain; charset="UTF-8"

On Wednesday, September 16, 2020, Huacai Chen <zltjiangshi@gmail.com> wrote:

> Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson-3B
> R1/R2. Loongson-3A R1 is the oldest and its ISA is the smallest, while
> Loongson-3A R4 is the newest and its ISA is almost the superset of all
> others. To reduce complexity, in QEMU we just define two CPU types:
>
> 1, "Loongson-3A1000" CPU which is corresponding to Loongson-3A R1. It is
>    suitable for TCG because Loongson-3A R1 has fewest ASE.
> 2, "Loongson-3A4000" CPU which is corresponding to Loongson-3A R4. It is
>    suitable for KVM because Loongson-3A R4 has the VZ ASE.
>
> Loongson-3 lacks English documents. I've tried to translated them with
> translate.google.com, and the machine translated documents (together
> with their original Chinese versions) are available here.
>
> Loongson-3A R1 (Loongson-3A1000)
> User Manual Part 1:
> http://ftp.godson.ac.cn/lemote/3A1000_p1.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_manual_P1.pdf
> (Chinese Version)
> User Manual Part 2:
> http://ftp.godson.ac.cn/lemote/3A1000_p2.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_manual_P2.pdf
> (Chinese Version)
>
> Loongson-3A R2 (Loongson-3A2000)
> User Manual Part 1:
> http://ftp.godson.ac.cn/lemote/3A2000_p1.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A2000_user1.pdf (Chinese Version)
> User Manual Part 2:
> http://ftp.godson.ac.cn/lemote/3A2000_p2.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A2000_user2.pdf (Chinese Version)
>
> Loongson-3A R3 (Loongson-3A3000)
> User Manual Part 1:
> http://ftp.godson.ac.cn/lemote/3A3000_p1.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual1.pdf
> (Chinese Version)
> User Manual Part 2:
> http://ftp.godson.ac.cn/lemote/3A3000_p2.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual2.pdf
> (Chinese Version)
>
> Loongson-3A R4 (Loongson-3A4000)
> User Manual Part 1:
> http://ftp.godson.ac.cn/lemote/3A4000_p1.pdf
> http://ftp.godson.ac.cn/lemote/3A4000user.pdf (Chinese Version)
> User Manual Part 2:
> I'm sorry that it is unavailable now.
>
> And human-translated documents (W.I.P) are available here now:
> https://github.com/loongson-community/docs/tree/master/
> English-translation-of-Loongson-manual
>
> Both KVM and TCG are available now!
>
> We now already have a full functional Linux kernel (based on Linux-5.4.x
> LTS, the kvm host side and guest side have both been upstream for Linux-
> 5.9, but Linux-5.9 has not been released yet) here:
>
> https://github.com/chenhuacai/linux
>
> Of course the upstream kernel is also usable (though it is "unstable"
> now):
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>
> How to use QEMU/Loongson-3?
> 1, Download kernel source from the above URL;
> 2, Build a kernel with arch/mips/configs/loongson3_{def,hpc}config;
> 3, Boot a Loongson-3A4000 host with this kernel (for KVM mode);
> 4, Build QEMU-master with this patchset;
> 5, modprobe kvm (only necessary for KVM mode);
> 6, Use QEMU with TCG:
>        qemu-system-mips64el -M loongson3-virt,accel=tcg -cpu
> Loongson-3A1000 -kernel <path_to_kernel> -append ...
>    Use QEMU with KVM:
>        qemu-system-mips64el -M loongson3-virt,accel=kvm -cpu
> Loongson-3A4000 -kernel <path_to_kernel> -append ...
>
>    The "-cpu" parameter is optional here and QEMU will use the correct
> type for TCG/KVM automatically.
>
> V1 -> V2:
> 1, Add a cover letter;
> 2, Improve CPU definitions;
> 3, Remove LS7A-related things (Use GPEX instead);
> 4, Add a description of how to run QEMU/Loongson-3.
>
> V2 -> V3:
> 1, Fix all possible checkpatch.pl errors and warnings.
>
> V3 -> V4:
> 1, Sync code with upstream;
> 2, Remove merged patches;
> 3, Fix build failure without CONFIG_KVM;
> 4, Add Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>.
>
> V4 -> V5:
> 1, Improve coding style;
> 2, Remove merged patches;
> 3, Rename machine name from "loongson3" to "loongson3-virt";
> 4, Rework the "loongson3-virt" machine to drop any ISA things;
> 5, Rework "hw/mips: Implement the kvm_type() hook in MachineClass";
> 6, Add Jiaxun Yang as a reviewer of Loongson-3.
>
> V5 -> V6:
> 1, Fix license preamble;
> 2, Improve commit messages;
> 3, Add hw/intc/loongson_liointc.c to MAINTAINERS;
> 4, Fix all possible checkpatch.pl errors and warnings.
>
> V7 and V8 have only one patch (machine definition) with some minor
> improvements.
>
> V8 -> V9:
> 1, Update KVM type definition from kernel;
> 2, Fix PageMask with variable page size for TCG;
> 3, Add TCG support (add Loongson-EXT instructions).
>
> Huacai Chen and Jiaxun Yang (6):
>  linux-headers: Update MIPS KVM type defintition
>  target/mips: Fix PageMask with variable page size
>  target/mips: Add loongson-ext lswc2 group of instructions (Part 1)
>  target/mips: Add loongson-ext lswc2 group of instructions (Part 2)
>  target/mips: Add loongson-ext lsdc2 group of instructions
>  hw/mips: Add Loongson-3 machine support
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  default-configs/mips64el-softmmu.mak |   1 +
>  hw/mips/Kconfig                      |  11 +
>  hw/mips/fw_cfg.c                     |  35 ++
>  hw/mips/fw_cfg.h                     |  19 +
>  hw/mips/loongson3_virt.c             | 956 ++++++++++++++++++++++++++++++
> +++++
>  hw/mips/meson.build                  |   3 +-
>  linux-headers/linux/kvm.h            |   5 +-
>  target/mips/cp0_helper.c             |  36 +-
>  target/mips/cpu.h                    |   1 +
>  target/mips/translate.c              | 437 ++++++++++++++++
>  10 files changed, 1494 insertions(+), 10 deletions(-)
>  create mode 100644 hw/mips/fw_cfg.c
>  create mode 100644 hw/mips/fw_cfg.h
>  create mode 100644 hw/mips/loongson3_virt.c
> --


There should be a suitable note in QEMU documentation describing new
functionality.

Thanks,
Aleksandar



> 2.7.0
>

--000000000000d3a8f005af7e1522
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, September 16, 2020, Huacai Chen &lt;<a href=3D"mailto=
:zltjiangshi@gmail.com">zltjiangshi@gmail.com</a>&gt; wrote:<br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 a=
nd Loongson-3B<br>
R1/R2. Loongson-3A R1 is the oldest and its ISA is the smallest, while<br>
Loongson-3A R4 is the newest and its ISA is almost the superset of all<br>
others. To reduce complexity, in QEMU we just define two CPU types:<br>
<br>
1, &quot;Loongson-3A1000&quot; CPU which is corresponding to Loongson-3A R1=
. It is<br>
=C2=A0 =C2=A0suitable for TCG because Loongson-3A R1 has fewest ASE.<br>
2, &quot;Loongson-3A4000&quot; CPU which is corresponding to Loongson-3A R4=
. It is<br>
=C2=A0 =C2=A0suitable for KVM because Loongson-3A R4 has the VZ ASE.<br>
<br>
Loongson-3 lacks English documents. I&#39;ve tried to translated them with<=
br>
<a href=3D"http://translate.google.com" target=3D"_blank">translate.google.=
com</a>, and the machine translated documents (together<br>
with their original Chinese versions) are available here.<br>
<br>
Loongson-3A R1 (Loongson-3A1000)<br>
User Manual Part 1:<br>
<a href=3D"http://ftp.godson.ac.cn/lemote/3A1000_p1.pdf" target=3D"_blank">=
http://ftp.godson.ac.cn/<wbr>lemote/3A1000_p1.pdf</a><br>
<a href=3D"http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_man=
ual_P1.pdf" target=3D"_blank">http://ftp.godson.ac.cn/<wbr>lemote/Loongson3=
A1000_<wbr>processor_user_manual_P1.pdf</a> (Chinese Version)<br>
User Manual Part 2:<br>
<a href=3D"http://ftp.godson.ac.cn/lemote/3A1000_p2.pdf" target=3D"_blank">=
http://ftp.godson.ac.cn/<wbr>lemote/3A1000_p2.pdf</a><br>
<a href=3D"http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_man=
ual_P2.pdf" target=3D"_blank">http://ftp.godson.ac.cn/<wbr>lemote/Loongson3=
A1000_<wbr>processor_user_manual_P2.pdf</a> (Chinese Version)<br>
<br>
Loongson-3A R2 (Loongson-3A2000)<br>
User Manual Part 1:<br>
<a href=3D"http://ftp.godson.ac.cn/lemote/3A2000_p1.pdf" target=3D"_blank">=
http://ftp.godson.ac.cn/<wbr>lemote/3A2000_p1.pdf</a><br>
<a href=3D"http://ftp.godson.ac.cn/lemote/Loongson3A2000_user1.pdf" target=
=3D"_blank">http://ftp.godson.ac.cn/<wbr>lemote/Loongson3A2000_user1.<wbr>p=
df</a> (Chinese Version)<br>
User Manual Part 2:<br>
<a href=3D"http://ftp.godson.ac.cn/lemote/3A2000_p2.pdf" target=3D"_blank">=
http://ftp.godson.ac.cn/<wbr>lemote/3A2000_p2.pdf</a><br>
<a href=3D"http://ftp.godson.ac.cn/lemote/Loongson3A2000_user2.pdf" target=
=3D"_blank">http://ftp.godson.ac.cn/<wbr>lemote/Loongson3A2000_user2.<wbr>p=
df</a> (Chinese Version)<br>
<br>
Loongson-3A R3 (Loongson-3A3000)<br>
User Manual Part 1:<br>
<a href=3D"http://ftp.godson.ac.cn/lemote/3A3000_p1.pdf" target=3D"_blank">=
http://ftp.godson.ac.cn/<wbr>lemote/3A3000_p1.pdf</a><br>
<a href=3D"http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual1.=
pdf" target=3D"_blank">http://ftp.godson.ac.cn/<wbr>lemote/Loongson3A3000_<=
wbr>3B3000usermanual1.pdf</a> (Chinese Version)<br>
User Manual Part 2:<br>
<a href=3D"http://ftp.godson.ac.cn/lemote/3A3000_p2.pdf" target=3D"_blank">=
http://ftp.godson.ac.cn/<wbr>lemote/3A3000_p2.pdf</a><br>
<a href=3D"http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual2.=
pdf" target=3D"_blank">http://ftp.godson.ac.cn/<wbr>lemote/Loongson3A3000_<=
wbr>3B3000usermanual2.pdf</a> (Chinese Version)<br>
<br>
Loongson-3A R4 (Loongson-3A4000)<br>
User Manual Part 1:<br>
<a href=3D"http://ftp.godson.ac.cn/lemote/3A4000_p1.pdf" target=3D"_blank">=
http://ftp.godson.ac.cn/<wbr>lemote/3A4000_p1.pdf</a><br>
<a href=3D"http://ftp.godson.ac.cn/lemote/3A4000user.pdf" target=3D"_blank"=
>http://ftp.godson.ac.cn/<wbr>lemote/3A4000user.pdf</a> (Chinese Version)<b=
r>
User Manual Part 2:<br>
I&#39;m sorry that it is unavailable now.<br>
<br>
And human-translated documents (W.I.P) are available here now:<br>
<a href=3D"https://github.com/loongson-community/docs/tree/master/English-t=
ranslation-of-Loongson-manual" target=3D"_blank">https://github.com/loongso=
n-<wbr>community/docs/tree/master/<wbr>English-translation-of-<wbr>Loongson=
-manual</a><br>
<br>
Both KVM and TCG are available now!<br>
<br>
We now already have a full functional Linux kernel (based on Linux-5.4.x<br=
>
LTS, the kvm host side and guest side have both been upstream for Linux-<br=
>
5.9, but Linux-5.9 has not been released yet) here:<br>
<br>
<a href=3D"https://github.com/chenhuacai/linux" target=3D"_blank">https://g=
ithub.com/chenhuacai/<wbr>linux</a><br>
<br>
Of course the upstream kernel is also usable (though it is &quot;unstable&q=
uot;<br>
now):<br>
<br>
<a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it" target=3D"_blank">https://git.kernel.org/pub/<wbr>scm/linux/kernel/git/=
torvalds/<wbr>linux.git</a><br>
<br>
How to use QEMU/Loongson-3?<br>
1, Download kernel source from the above URL;<br>
2, Build a kernel with arch/mips/configs/loongson3_{<wbr>def,hpc}config;<br=
>
3, Boot a Loongson-3A4000 host with this kernel (for KVM mode);<br>
4, Build QEMU-master with this patchset;<br>
5, modprobe kvm (only necessary for KVM mode);<br>
6, Use QEMU with TCG:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu-system-mips64el -M loongson3-virt,accel=3Dt=
cg -cpu Loongson-3A1000 -kernel &lt;path_to_kernel&gt; -append ...<br>
=C2=A0 =C2=A0Use QEMU with KVM:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu-system-mips64el -M loongson3-virt,accel=3Dk=
vm -cpu Loongson-3A4000 -kernel &lt;path_to_kernel&gt; -append ...<br>
<br>
=C2=A0 =C2=A0The &quot;-cpu&quot; parameter is optional here and QEMU will =
use the correct type for TCG/KVM automatically.<br>
<br>
V1 -&gt; V2:<br>
1, Add a cover letter;<br>
2, Improve CPU definitions;<br>
3, Remove LS7A-related things (Use GPEX instead);<br>
4, Add a description of how to run QEMU/Loongson-3.<br>
<br>
V2 -&gt; V3:<br>
1, Fix all possible <a href=3D"http://checkpatch.pl" target=3D"_blank">chec=
kpatch.pl</a> errors and warnings.<br>
<br>
V3 -&gt; V4:<br>
1, Sync code with upstream;<br>
2, Remove merged patches;<br>
3, Fix build failure without CONFIG_KVM;<br>
4, Add Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qe=
mu.devel@gmail.com">aleksandar.qemu.devel@gmail.<wbr>com</a>&gt;.<br>
<br>
V4 -&gt; V5:<br>
1, Improve coding style;<br>
2, Remove merged patches;<br>
3, Rename machine name from &quot;loongson3&quot; to &quot;loongson3-virt&q=
uot;;<br>
4, Rework the &quot;loongson3-virt&quot; machine to drop any ISA things;<br=
>
5, Rework &quot;hw/mips: Implement the kvm_type() hook in MachineClass&quot=
;;<br>
6, Add Jiaxun Yang as a reviewer of Loongson-3.<br>
<br>
V5 -&gt; V6:<br>
1, Fix license preamble;<br>
2, Improve commit messages;<br>
3, Add hw/intc/loongson_liointc.c to MAINTAINERS;<br>
4, Fix all possible <a href=3D"http://checkpatch.pl" target=3D"_blank">chec=
kpatch.pl</a> errors and warnings.<br>
<br>
V7 and V8 have only one patch (machine definition) with some minor improvem=
ents.<br>
<br>
V8 -&gt; V9:<br>
1, Update KVM type definition from kernel;<br>
2, Fix PageMask with variable page size for TCG;<br>
3, Add TCG support (add Loongson-EXT instructions).<br>
<br>
Huacai Chen and Jiaxun Yang (6):<br>
=C2=A0linux-headers: Update MIPS KVM type defintition<br>
=C2=A0target/mips: Fix PageMask with variable page size<br>
=C2=A0target/mips: Add loongson-ext lswc2 group of instructions (Part 1)<br=
>
=C2=A0target/mips: Add loongson-ext lswc2 group of instructions (Part 2)<br=
>
=C2=A0target/mips: Add loongson-ext lsdc2 group of instructions<br>
=C2=A0hw/mips: Add Loongson-3 machine support<br>
<br>
Signed-off-by: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com">chenhc@=
lemote.com</a>&gt;<br>
---<br>
=C2=A0default-configs/mips64el-<wbr>softmmu.mak |=C2=A0 =C2=A01 +<br>
=C2=A0hw/mips/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 11 +<br>
=C2=A0hw/mips/fw_cfg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 35 ++<br>
=C2=A0hw/mips/fw_cfg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 19 +<br>
=C2=A0hw/mips/loongson3_virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 956 ++++++++++++++++++++++++++++++<wbr>+++++<br>
=C2=A0hw/mips/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A03 +-<br>
=C2=A0linux-headers/linux/kvm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A05 +-<br>
=C2=A0target/mips/cp0_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 36 +-<br>
=C2=A0target/mips/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0target/mips/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 437 ++++++++++++++++<br>
=C2=A010 files changed, 1494 insertions(+), 10 deletions(-)<br>
=C2=A0create mode 100644 hw/mips/fw_cfg.c<br>
=C2=A0create mode 100644 hw/mips/fw_cfg.h<br>
=C2=A0create mode 100644 hw/mips/loongson3_virt.c<br>
--</blockquote><div><br></div><div>There should be a suitable note in QEMU =
documentation describing new functionality.</div><div><br></div><div>Thanks=
,</div><div>Aleksandar</div><div><br></div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
2.7.0<br>
</blockquote>

--000000000000d3a8f005af7e1522--


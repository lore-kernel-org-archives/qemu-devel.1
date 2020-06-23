Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D39C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4184F20720
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkA+GJa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4184F20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnjT7-0004ac-DP
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 10:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jnjRu-0003GA-Hc
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 09:58:54 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:42634)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jnjRr-0008WA-SY
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 09:58:54 -0400
Received: by mail-wr1-x431.google.com with SMTP id o11so12925414wrv.9
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 06:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Ktfn6mxj7LNxV535myPEwsv0bmQxGogoqKvllCS1z7Q=;
 b=UkA+GJa58ko40ecCVuDlThaqJsnZ7joB7FI4VJ1LJ2YDj6URWlC/3P6ErtVUuF2lbf
 CTI58c1fFa1LK33CvgJRpoBiDtS0l7ttWSD+MVYY6aPWXPAp1bAHM1GDgNq83/rjuINc
 8UA3uWFi5Ny8o7JAZ5WBKWOqvt8PDWcj5+JQCVylAGUcwikRTtF4DNsE+dFa8Ru3vKZB
 Ivgiku75xYsGdJEhckix02fVioSLPih7O3lebNdL/fNiQFWYNQuphnS6fd8iaYCl8n7f
 A7Ge7yXO2NIqmaS3dfYgYJlxXRGlR4V8uskkBg9wtcUY2LCaouSL4ZRQyfkMpXNM5z0o
 wcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Ktfn6mxj7LNxV535myPEwsv0bmQxGogoqKvllCS1z7Q=;
 b=jSOBtx9uekVMtNm2w/snfqUQRYh8NiPcpuen24RTvAuas3ad8latqHks3oWTlkxKZ/
 hBlPGx/lyC8I/MV1GAMw5VgPEnWYHtonWaM3Al9X2HgJ7O/rV020umMgt+50MvOGJzVd
 j9cmwFFDwHhA5HUDursNfqFBQ52fKN1ZIXWmN+pXwDULbfC0ZL39dkIkL1gonpoKvPde
 hlAOK+hPby0yBr8cwceJfGO9zp8MsbTpbc9yBdi5StgUcqLSAegaxZwqDda7MWfcbRZt
 jV0KbqKd8pUtbfQGf7EF1eHllEiOxF9x/UsPY9Rky6ui7CHFWad+FXO5RyQuDDRDJ59e
 Zo8w==
X-Gm-Message-State: AOAM531LyTdP3MIxIKC3OJtUpaMhSAgHcJ0ae3gZVfL3RLmQD5mFnx7J
 QvaqPLGjHKNaJJRnTeq5IK2Irs/eSFKCTXlTzciPwAOm
X-Google-Smtp-Source: ABdhPJyjUBaUit5yRwMpcU1AfRQmIOoYhz2mnIHeZQ+nFENEEPkli9lJZq9vV+Q2tCg+x18bD3RGlazdqzKUxQ/FPIs=
X-Received: by 2002:adf:a283:: with SMTP id s3mr23934322wra.147.1592920729875; 
 Tue, 23 Jun 2020 06:58:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a7b:c0d7:0:0:0:0:0 with HTTP; Tue, 23 Jun 2020 06:58:49
 -0700 (PDT)
In-Reply-To: <159291732571.6029.8642408239343726657@d1fd068a5071>
References: <1592914438-30317-1-git-send-email-chenhc@lemote.com>
 <159291732571.6029.8642408239343726657@d1fd068a5071>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 23 Jun 2020 15:58:49 +0200
Message-ID: <CAHiYmc6rMujXmF6NuoQVwm484PXxW2876zdp6wXpiO0p+ssAqw@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V5 0/4] mips: Add Loongson-3 machine support (with
 KVM)
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000427a7f05a8c0c2f6"
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "zltjiangshi@gmail.com" <zltjiangshi@gmail.com>,
 "aleksandar.rikalo@syrmia.com" <aleksandar.rikalo@syrmia.com>,
 "chenhuacai@gmail.com" <chenhuacai@gmail.com>,
 "f4bug@amsat.org" <f4bug@amsat.org>, "chenhc@lemote.com" <chenhc@lemote.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000427a7f05a8c0c2f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 23. =D1=98=D1=83=D0=BD 2020., <no-rep=
ly@patchew.org> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=
=BB=D0=B0:

> Patchew URL: https://patchew.org/QEMU/1592914438-30317-1-git-send-
> email-chenhc@lemote.com/
>
>
>
> Hi,
>
> This series seems to have some coding style problems. See output below fo=
r
> more information:
>
>
Hi, Huacai.

Please fix all checkpatch warnings in the next version (except thise that
complain about the need for updating MAONTAINERS)

Also, you dont need " for-5.1" in subject prefixes.

Please fix these and other small things that I commented about, and send v6
soon (tomorrow, if possible?), so that we remove these small obstacles and
focus on the core functionality of tge series.

Thanks, Aleksandar





> Subject: [PATCH for-5.1 V5 0/4] mips: Add Loongson-3 machine support (wit=
h
> KVM)
> Type: series
> Message-id: 1592914438-30317-1-git-send-email-chenhc@lemote.com
>
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>
> From https://github.com/patchew-project/qemu
>  * [new tag]         patchew/1592914438-30317-1-
> git-send-email-chenhc@lemote.com -> patchew/1592914438-30317-1-
> git-send-email-chenhc@lemote.com
> Switched to a new branch 'test'
> 63e13a2 MAINTAINERS: Add Loongson-3 maintainer and reviewer
> 727fa14 hw/mips: Add Loongson-3 machine support (with KVM)
> 5fd21a0 hw/intc: Add Loongson liointc support
> 6996d49 hw/mips: Implement the kvm_type() hook in MachineClass
>
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> 1/4 Checking commit 6996d492ec71 (hw/mips: Implement the kvm_type() hook
> in MachineClass)
> 2/4 Checking commit 5fd21a0bcd83 (hw/intc: Add Loongson liointc support)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #36:
> new file mode 100644
>
> ERROR: line over 90 characters
> #90: FILE: hw/intc/loongson_liointc.c:50:
> +#define LOONGSON_LIOINTC(obj) OBJECT_CHECK(struct loongson_liointc,
> (obj), TYPE_LOONGSON_LIOINTC)
>
> ERROR: open brace '{' following struct go on the same line
> #93: FILE: hw/intc/loongson_liointc.c:53:
> +struct loongson_liointc
> +{
>
> ERROR: code indent should never use tabs
> #148: FILE: hw/intc/loongson_liointc.c:108:
> +^I    if (p->parent_state[parent] !=3D$
>
> total: 3 errors, 1 warnings, 256 lines checked
>
> Patch 2/4 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>
> 3/4 Checking commit 727fa142abed (hw/mips: Add Loongson-3 machine support
> (with KVM))
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #84:
> new file mode 100644
>
> WARNING: line over 80 characters
> #404: FILE: hw/mips/loongson3_virt.c:316:
> +static void loongson3_pm_write(void *opaque, hwaddr addr, uint64_t val,
> unsigned size)
>
> WARNING: line over 80 characters
> #704: FILE: hw/mips/loongson3_virt.c:616:
> +    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)current_machine->
> smp.max_cpus);
>
> WARNING: line over 80 characters
> #840: FILE: hw/mips/loongson3_virt.c:752:
> +static inline void loongson3_virt_devices_init(MachineState *machine,
> DeviceState *pic)
>
> WARNING: line over 80 characters
> #871: FILE: hw/mips/loongson3_virt.c:783:
> +                             get_system_io(), 0,
> virt_memmap[VIRT_PCIE_PIO].size);
>
> WARNING: line over 80 characters
> #977: FILE: hw/mips/loongson3_virt.c:889:
> +    /* Allocate RAM/BIOS, 0x00000000~0x10000000 is alias of
> 0x80000000~0x90000000 */
>
> total: 0 errors, 6 warnings, 999 lines checked
>
> Patch 3/4 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 4/4 Checking commit 63e13a297290 (MAINTAINERS: Add Loongson-3 maintainer
> and reviewer)
> =3D=3D=3D OUTPUT END =3D=3D=3D
>
> Test command exited with code: 1
>
>
> The full log is available at
> http://patchew.org/logs/1592914438-30317-1-git-send-
> email-chenhc@lemote.com/testing.checkpatch/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

--000000000000427a7f05a8c0c2f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 23. =D1=98=D1=83=D0=BD 2020.,=
  &lt;<a href=3D"mailto:no-reply@patchew.org">no-reply@patchew.org</a>&gt; =
=D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">Patchew URL: <a href=3D"https://patchew.org/QE=
MU/1592914438-30317-1-git-send-email-chenhc@lemote.com/" target=3D"_blank">=
https://patchew.org/QEMU/<wbr>1592914438-30317-1-git-send-<wbr>email-chenhc=
@lemote.com/</a><br>
<br>
<br>
<br>
Hi,<br>
<br>
This series seems to have some coding style problems. See output below for<=
br>
more information:<br>
<br></blockquote><div><br></div><div>Hi, Huacai.</div><div><br></div><div>P=
lease fix all checkpatch warnings in the next version (except thise that co=
mplain about the need for updating MAONTAINERS)</div><div><br></div><div>Al=
so, you dont need &quot; for-5.1&quot; in subject prefixes.</div><div><br><=
/div><div>Please fix these and other small things that I commented about, a=
nd send v6 soon (tomorrow, if possible?), so that we remove these small obs=
tacles and focus on the core functionality of tge series.</div><div><br></d=
iv><div>Thanks, Aleksandar</div><div><br></div><div><br></div><div><br></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
Subject: [PATCH for-5.1 V5 0/4] mips: Add Loongson-3 machine support (with =
KVM)<br>
Type: series<br>
Message-id: <a href=3D"mailto:1592914438-30317-1-git-send-email-chenhc@lemo=
te.com">1592914438-30317-1-git-send-<wbr>email-chenhc@lemote.com</a><br>
<br>
=3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D<br>
#!/bin/bash<br>
git rev-parse base &gt; /dev/null || exit 0<br>
git config --local diff.renamelimit 0<br>
git config --local diff.renames True<br>
git config --local diff.algorithm histogram<br>
./scripts/<a href=3D"http://checkpatch.pl" target=3D"_blank">checkpatch.pl<=
/a> --mailback base..<br>
=3D=3D=3D TEST SCRIPT END =3D=3D=3D<br>
<br>
From <a href=3D"https://github.com/patchew-project/qemu" target=3D"_blank">=
https://github.com/patchew-<wbr>project/qemu</a><br>
=C2=A0* [new tag]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0patchew/<a href=3D"mailt=
o:1592914438-30317-1-git-send-email-chenhc@lemote.com">1592914438-30317-1-<=
wbr>git-send-email-chenhc@lemote.<wbr>com</a> -&gt; patchew/<a href=3D"mail=
to:1592914438-30317-1-git-send-email-chenhc@lemote.com">1592914438-30317-1-=
<wbr>git-send-email-chenhc@lemote.<wbr>com</a><br>
Switched to a new branch &#39;test&#39;<br>
63e13a2 MAINTAINERS: Add Loongson-3 maintainer and reviewer<br>
727fa14 hw/mips: Add Loongson-3 machine support (with KVM)<br>
5fd21a0 hw/intc: Add Loongson liointc support<br>
6996d49 hw/mips: Implement the kvm_type() hook in MachineClass<br>
<br>
=3D=3D=3D OUTPUT BEGIN =3D=3D=3D<br>
1/4 Checking commit 6996d492ec71 (hw/mips: Implement the kvm_type() hook in=
 MachineClass)<br>
2/4 Checking commit 5fd21a0bcd83 (hw/intc: Add Loongson liointc support)<br=
>
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?<b=
r>
#36: <br>
new file mode 100644<br>
<br>
ERROR: line over 90 characters<br>
#90: FILE: hw/intc/loongson_liointc.c:50:<br>
+#define LOONGSON_LIOINTC(obj) OBJECT_CHECK(struct loongson_liointc, (obj),=
 TYPE_LOONGSON_LIOINTC)<br>
<br>
ERROR: open brace &#39;{&#39; following struct go on the same line<br>
#93: FILE: hw/intc/loongson_liointc.c:53:<br>
+struct loongson_liointc<br>
+{<br>
<br>
ERROR: code indent should never use tabs<br>
#148: FILE: hw/intc/loongson_liointc.c:<wbr>108:<br>
+^I=C2=A0 =C2=A0 if (p-&gt;parent_state[parent] !=3D$<br>
<br>
total: 3 errors, 1 warnings, 256 lines checked<br>
<br>
Patch 2/4 has style problems, please review.=C2=A0 If any of these errors<b=
r>
are false positives report them to the maintainer, see<br>
CHECKPATCH in MAINTAINERS.<br>
<br>
3/4 Checking commit 727fa142abed (hw/mips: Add Loongson-3 machine support (=
with KVM))<br>
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?<b=
r>
#84: <br>
new file mode 100644<br>
<br>
WARNING: line over 80 characters<br>
#404: FILE: hw/mips/loongson3_virt.c:316:<br>
+static void loongson3_pm_write(void *opaque, hwaddr addr, uint64_t val, un=
signed size)<br>
<br>
WARNING: line over 80 characters<br>
#704: FILE: hw/mips/loongson3_virt.c:616:<br>
+=C2=A0 =C2=A0 fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)current_ma=
chine-&gt;<wbr>smp.max_cpus);<br>
<br>
WARNING: line over 80 characters<br>
#840: FILE: hw/mips/loongson3_virt.c:752:<br>
+static inline void loongson3_virt_devices_init(<wbr>MachineState *machine,=
 DeviceState *pic)<br>
<br>
WARNING: line over 80 characters<br>
#871: FILE: hw/mips/loongson3_virt.c:783:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0get_system_io(), 0, virt_memmap[VIRT_PCIE_PI=
O].<wbr>size);<br>
<br>
WARNING: line over 80 characters<br>
#977: FILE: hw/mips/loongson3_virt.c:889:<br>
+=C2=A0 =C2=A0 /* Allocate RAM/BIOS, 0x00000000~0x10000000 is alias of 0x80=
000000~0x90000000 */<br>
<br>
total: 0 errors, 6 warnings, 999 lines checked<br>
<br>
Patch 3/4 has style problems, please review.=C2=A0 If any of these errors<b=
r>
are false positives report them to the maintainer, see<br>
CHECKPATCH in MAINTAINERS.<br>
4/4 Checking commit 63e13a297290 (MAINTAINERS: Add Loongson-3 maintainer an=
d reviewer)<br>
=3D=3D=3D OUTPUT END =3D=3D=3D<br>
<br>
Test command exited with code: 1<br>
<br>
<br>
The full log is available at<br>
<a href=3D"http://patchew.org/logs/1592914438-30317-1-git-send-email-chenhc=
@lemote.com/testing.checkpatch/?type=3Dmessage" target=3D"_blank">http://pa=
tchew.org/logs/<wbr>1592914438-30317-1-git-send-<wbr>email-chenhc@lemote.co=
m/<wbr>testing.checkpatch/?type=3D<wbr>message</a>.<br>
---<br>
Email generated automatically by Patchew [<a href=3D"https://patchew.org/" =
target=3D"_blank">https://patchew.org/</a>].<br>
Please send your feedback to <a href=3D"mailto:patchew-devel@redhat.com">pa=
tchew-devel@redhat.com</a></blockquote>

--000000000000427a7f05a8c0c2f6--


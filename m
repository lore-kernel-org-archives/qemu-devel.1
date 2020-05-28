Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6E9C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 08:35:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 300692063A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 08:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CwXc0zvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300692063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeE0a-0002GX-Ch
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 04:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jeDzc-0001OP-4A
 for qemu-devel@nongnu.org; Thu, 28 May 2020 04:34:24 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:39136)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jeDza-00066r-Sd
 for qemu-devel@nongnu.org; Thu, 28 May 2020 04:34:23 -0400
Received: by mail-wr1-x436.google.com with SMTP id t18so12902828wru.6
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 01:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=CqffJZBiY/VykmUf1KGvLSl6LRGouEYjQ+HhIRS+Vh8=;
 b=CwXc0zvJVMc52YkJcxwUA17pud6XKbz0WY/x4LA4UHdkxN631HqB5AD5DUhCgeNEHQ
 W03GbSwBoXctgKS+NJs2Zqxdx5NdYPBCGkleGmDsEndxI5L3nVIBie/KN6Ib60DvmkRi
 RbxcycUZvE5hBo3orZDP2T5zQEQkdYQ5Sdm8r6iuem1+akt6dSV/IDT1swjl56lf2NGi
 +Rof6y5qGHSUR56gErFgrfSrVW5Azdp00IqJvpTWPrXv7JhbCCnwqVMl45Mi+YJJ0FWi
 lfW0qR0aQKaanIC45LM2lv5tK+gq1LxdJ1oDP6VoNyCcwEKY+Nn1pIj9sqULMe3MzhvJ
 AA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=CqffJZBiY/VykmUf1KGvLSl6LRGouEYjQ+HhIRS+Vh8=;
 b=WYzVEvJeMSeegoEcSGS9FVRfZ8g/sGDjq4XFLPluN1s90tynkMQ/uIPXpKbF5bLgRB
 bAdBUJYM3wW0Rbgrpz8jvAB94n8OCao60INHAOT4wXdBeQTnT5EXisgFl8QiVFFMEt69
 BLEV/DsbG9p48Sy0PsTuCS8Y8I326prVuFKdxIL5A0RYGISOpTn+/ep0mKPGURZGROZz
 n0cIiRUd+eD7n46klWUFDSfLc371f70qht95XHLxNTsqnKCclMg8mVRzZSWGqUH0eNMf
 +HeqhUEAo3NYS9dkvmLknko7IUg0XXtMCSIDWY1sotA1j54MBszNBR39Xql3ibs54ZVq
 reAg==
X-Gm-Message-State: AOAM530Y4+yrJEDfANTRSjgOHppYbVrNciwig3pvo3mK9R66gqrx8SBD
 OIlzGf4BlmpbM6FjX/AcNKOKhQ==
X-Google-Smtp-Source: ABdhPJwOe5vSiMm8xnbyaoGEMA/BiyDRUpC1OsF08zeUWit6PKXusS5mFRXCL++XM3NS1NW22TojYA==
X-Received: by 2002:a5d:4dd0:: with SMTP id f16mr2583718wru.117.1590654861414; 
 Thu, 28 May 2020 01:34:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w10sm5248502wrp.16.2020.05.28.01.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 01:34:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 900141FF7E;
 Thu, 28 May 2020 09:34:19 +0100 (BST)
References: <tencent_86D9DB902C46CBAC4F3A6FD5B4CDA93B7506@qq.com>
 <8b83e11b-e593-b7db-48b6-252e23c599da@amsat.org>
 <tencent_B0E453026AE8377459F3162D9F7D5ECE6907@qq.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: casmac <1482995675@qq.com>
Subject: Re: GDB get wrong debug infos on TI DSP architecture extension
In-reply-to: <tencent_B0E453026AE8377459F3162D9F7D5ECE6907@qq.com>
Date: Thu, 28 May 2020 09:34:19 +0100
Message-ID: <87v9kg4fw4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


casmac <1482995675@qq.com> writes:

> Hi,
> &nbsp;&nbsp; Thank you for forwarding my question to developers and shari=
ng the C6x implementation.
> &nbsp;&nbsp; Perhaps I should follow up with another problem I encountere=
d. The senerio is the&nbsp; emulator keeps running eventhough the program i=
t emulates has already exited. And it keeps retrieving instructions which a=
re all zero "instruction"(0x00000000).=20
>
> &nbsp;&nbsp; It looks to me that in function cpu_exec(CPUState *cpu), the=
 following loop never terminate:
> &nbsp;&nbsp; while (!cpu_handle_exception(cpu, &amp;ret)) {
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TranslationBlock *last_tb =3D =
NULL;
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int tb_exit =3D 0;
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (!cpu_handle_interrupt(c=
pu, &amp;last_tb)) { ... }
> &nbsp;&nbsp; Is it because cpu-&gt;exit_request remains 0 ?
>
> &nbsp;&nbsp; At what point should we make cpu-&gt;exit_request=3D1 ?

cpu->exit_request is set for asynchronus conditions (e.g. timer IRQs or
IO events). A number of helpers will "kick" the cpu by calling
cpu_exit().

> &nbsp;&nbsp; Thanks again!!
>
>
> regards
> xiaolei
>
>
>
> ------------------&nbsp;Original&nbsp;------------------
> From:&nbsp;"Philippe Mathieu-Daud=C3=A9"<f4bug@amsat.org&gt;;
> Date:&nbsp;Wed, May 27, 2020 03:19 PM
> To:&nbsp;"casmac"<1482995675@qq.com&gt;;"qemu-devel"<qemu-devel@nongnu.or=
g&gt;;
> Cc:&nbsp;"Taylor Simpson"<tsimpson@quicinc.com&gt;;"Alex Benn=C3=A9e"<ale=
x.bennee@linaro.org&gt;;"Luc Michel"<luc.michel@greensocs.com&gt;;
> Subject:&nbsp;Re: GDB get wrong debug infos on TI DSP architecture extens=
ion
>
>
>
> Hi Xiaolei,
>
> Cc'ing more developers who might answer you.
>
> On 5/27/20 8:48 AM, casmac wrote:
> &gt; Hi all,
> &gt; &nbsp;&nbsp; I am working on a TI DSP architecture extension for QEM=
U.
>
> FYI you can find the TI TMS320C6x target implemented here:
> https://github.com/philmd/qemu/releases/tag/target-c6x-2.4
>
> I started rebasing it to QEMU 4.2 but then got distracted.
>
> &gt; Now, we are
> &gt; adding GDB debugging features.
> &gt; &nbsp;&nbsp; We have done the following, but not sure we are on the =
right track :
> &gt; &nbsp;&nbsp; - add a xml description file in gdb-xml, without unders=
tanding the
> &gt; purpose of the file, why some architectures don't provide such xml f=
ile?
> &gt; &nbsp;&nbsp; - add ***_cpu_gdb_read_register(), ***_cpu_gdb_write_re=
gister();
> &gt; &nbsp;&nbsp; - added&nbsp; dsp_cpu_get_phys_page_attrs_debug(), but =
uncertain about
> &gt; what to return
> &gt; &nbsp; &nbsp;&nbsp; dsp_cpu_get_phys_page_attrs_debug(CPUState *cs, =
vaddr addr,
> &gt; MemTxAttrs *attrs)
> &gt; &nbsp; &nbsp;&nbsp; {
> &gt; &nbsp; &nbsp; &nbsp; &nbsp; return addr &amp; TARGET_PAGE_MASK;&nbsp=
;&nbsp;
> &gt; &nbsp; &nbsp;&nbsp; }
> &gt; &nbsp;&nbsp;
> &gt; &nbsp;&nbsp; We run QEMU with the these arguments
> &gt; &nbsp;&nbsp; qemu-system-dsp ... -kernel filename.out -S -s
> &gt; &nbsp;&nbsp;
> &gt; &nbsp;&nbsp; It turns out that gdb reads incorrect register values, =
and complains
> &gt; : "warning: Target-supplied registers are not supported by the curre=
nt
> &gt; architecture".
> &gt; &nbsp;&nbsp;
> &gt; &nbsp;&nbsp; Something is missing here, or we do it in a wrong way.&=
nbsp; Any advise
> &gt; would be helpful to us.
> &gt; &nbsp;&nbsp;
> &gt; &nbsp;&nbsp; Thanks.
> &gt; &nbsp; &nbsp;
> &gt; xiaolei
> &gt;=20
> &gt; &nbsp;&nbsp; ----- ti_dsp.xml&nbsp; -----
> &gt; &nbsp;&nbsp;
> &gt; &nbsp;&nbsp; <?xml version=3D"1.0"?&gt;
> &gt; <!DOCTYPE feature SYSTEM "gdb-target.dtd"&gt;
> &gt; <feature name=3D"org.gnu.gdb.tic3x.core"&gt;
> &gt; &nbsp;&nbsp;&nbsp; <reg name=3D"r0"&nbsp; bitsize=3D"32"&gt;</reg&gt;
> &gt; &nbsp;<reg name=3D"r1"&nbsp; bitsize=3D"32"/&gt;
> &gt; &nbsp;<reg name=3D"r2"&nbsp; bitsize=3D"32"&gt;</reg&gt;
> &gt; &nbsp;<reg name=3D"r3"&nbsp; bitsize=3D"32"/&gt;
> &gt; &nbsp;<reg name=3D"r4"&nbsp; bitsize=3D"32"/&gt;
> &gt; &nbsp;<reg name=3D"r5"&nbsp; bitsize=3D"32"/&gt;
> &gt; &nbsp;<reg name=3D"r6"&nbsp; bitsize=3D"32"/&gt;
> &gt; &nbsp;<reg name=3D"r7"&nbsp; bitsize=3D"32"/&gt;
> &gt; &nbsp;<reg name=3D"ar0" bitsize=3D"32"/&gt;
> &gt; &nbsp;<reg name=3D"ar1" bitsize=3D"32"/&gt;
> &gt; &nbsp;<reg name=3D"ar2" bitsize=3D"32"/&gt;
> &gt; &nbsp;<reg name=3D"ar3" bitsize=3D"32"/&gt;
> &gt; &nbsp;<reg name=3D"ar4" bitsize=3D"32"/&gt;
> &gt; &nbsp;<reg name=3D"ar5" bitsize=3D"32"/&gt;
> &gt; &nbsp;<reg name=3D"ar6" bitsize=3D"32"/&gt;
> &gt; &nbsp;<reg name=3D"ar7" bitsize=3D"32"/&gt;
> &gt; &nbsp;<reg name=3D"dp"&nbsp; bitsize=3D"32"/&gt;
> &gt; &nbsp;<reg name=3D"ir0" bitsize=3D"32"/&gt;
> &gt; &nbsp;<reg name=3D"ir1" bitsize=3D"32"/&gt;
> &gt; &nbsp;<reg name=3D"bk"&nbsp; bitsize=3D"32"/&gt;
> &gt; &nbsp;<reg name=3D"sp"&nbsp; bitsize=3D"32" type=3D"data_ptr"/&gt;
> &gt; &nbsp;<reg name=3D"st"&nbsp; bitsize=3D"32"&gt;</reg&gt;
> &gt; &nbsp;<reg name=3D"ie"&nbsp; bitsize=3D"32"/&gt;
> &gt; &nbsp;<reg name=3D"if"&nbsp; bitsize=3D"32"/&gt;
> &gt; &nbsp;<reg name=3D"iof" bitsize=3D"32"/&gt;
> &gt; &nbsp;<reg name=3D"rs"&nbsp; bitsize=3D"32"/&gt;
> &gt; &nbsp;<reg name=3D"re"&nbsp; bitsize=3D"32"/&gt;
> &gt; &nbsp;<reg name=3D"rc"&nbsp; bitsize=3D"32"/&gt;
> &gt; &nbsp;<reg name=3D"pc"&nbsp; bitsize=3D"32" type=3D"data_ptr"/&gt;
> &gt; &nbsp;<reg name=3D"clk"&nbsp; bitsize=3D"32"/&gt;
> &gt; </feature&gt;
> &gt; &nbsp;&nbsp;


--=20
Alex Benn=C3=A9e


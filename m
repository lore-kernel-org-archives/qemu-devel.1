Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A02C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:31:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B9B22277
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7VTYcFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B9B22277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQsUx-0005b8-Ev
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 09:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQsTh-00058F-JQ
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:30:33 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b]:40200)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQsTf-0007y4-Rt
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:30:33 -0400
Received: by mail-lj1-x22b.google.com with SMTP id f21so9622674ljh.7
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 06:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=cM3HthacfwyfqogD9vtJ+J89GsKwP/UgEonCrwpUTGM=;
 b=J7VTYcFij3i0M9g/i2wYpaIuoe3roydI1a8dp2aY+LkmRzh5uwyPokJIBZYwJiUsbH
 +uZ9FFuXFQR9y6TdvEWON6rP3RpSCW+QeY7XPivOslBbPD9JK4getjHO1i02fowsH/Dd
 E/c4m05+Mnuy7huEs7fN6v9vhbKsRfq6I9vBGkp9Ixn7J/9Bbf/XchRXEZFvsFxFsCAb
 0o7huapKYN9z/8ZEMos57LdoX40OW2pLLaXDNDGiDHNPgbep6sSNw6g3eSZQUcahza26
 bw76d/Mjmj8cs/nJdnXyXH63HyaV85JLQXpYaxEm4snVdLmYr1wm8d9hdgaVVAwfo0lY
 4gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=cM3HthacfwyfqogD9vtJ+J89GsKwP/UgEonCrwpUTGM=;
 b=K48ykMYnHqmtjbYQUtb0ODLZFFPDCoYY70q9630HeKxvHY/nUEH719QW9Qu3uqTWMk
 AIkDtZcGDYKf9nPpYFRHtE6WJhIG3ZSABieDX0KDyD0tJ2TtaVABnp+pfc0jcKWs/mKI
 QifdTdrOGFqlkaTR7WviNpJhGvnBUk8chnCUCBIRyRzDwtPxtRbC0BE4C7Q/ChASF+Y/
 exPKNit8glWuwromFW5LZ6JjEsBLYvRGjbVA0+gps3CAyOfq/TrOozQ1Bth/1QDeg+9E
 00EU+C4nS9rn8WqvSG5wPjkuoGVhQvFDk8R+8M+GMe82MG0vDbhfPKTTCn0K1zpy3nmz
 pviQ==
X-Gm-Message-State: AOAM530wXgwfxN6qItdSqu4oDJYYCGe1SRcoBM0S6f79vc/u/TK8jmoy
 jiLuXNHTKZ4CpaCQ58Y05gBZN0TrGBEphJ8uhIk=
X-Google-Smtp-Source: ABdhPJzm4DPgrfza11wrqZPMVR235fz50yNgVDtD8Bzw3qdTcov7qw714dwWz6cNSGYKr6E2Z82Bf8IKVSVboL1Fu54=
X-Received: by 2002:a2e:b5b3:: with SMTP id f19mr5669075ljn.467.1602250230099; 
 Fri, 09 Oct 2020 06:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE9YyZwRr5j3fCATTb32pacuGrT_yUBoUTd30k+id1D3iw@mail.gmail.com>
 <27f82fe6-5b0f-7e35-29d9-7b00ae8f189e@redhat.com>
In-Reply-To: <27f82fe6-5b0f-7e35-29d9-7b00ae8f189e@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 9 Oct 2020 21:30:19 +0800
Message-ID: <CAE2XoE_SC8moDRMqjoKQLDYE7XiG1OQyRYmhs+rE2ax_9hbWQQ@mail.gmail.com>
Subject: Re: How about using clang-format instead checkpatch for fixing style?
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ce782305b13cf303"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x22b.google.com
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
Reply-To: luoyonggang@gmail.com
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ce782305b13cf303
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2020 at 9:25 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 09/10/20 15:02, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> > We can even using clang-format to format the whole repository.
>
> checkpatch does other checks than formatting.
>
> Reformatting the whole repository has been mentioned many times, people
> were worried of messing up the result of "git blame".  But without doing
> that, it's hard to get rid of checkpatch because checkpatch only looks
> at the lines that are touched by the patch.
Make sense, clang-format can also only formatting the changed lines,
checkpatch also does what? do you means about the MAINTAINER? that can be
preserved
we can use clang-format as a part of checkpatch.
The current problem with checkpatch is that is doesn't understand C well.
Sometimes will arise werid errors.

For example, what's does this means?

25/30 Checking commit 9e2a36e4c279 (plugin: Getting qemu-plugin.h can be
included in multiple source file)
ERROR: storage class should be at the beginning of the declaration
#74: FILE: include/qemu/qemu-plugin.h:432:
+#define qemu_plugin_decl_symbol(symbol_name) extern symbol_name##_t
symbol_name

total: 1 errors, 0 warnings, 88 lines checked

Patch 25/30 has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
>
> Paolo
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000ce782305b13cf303
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Fri, Oct 9, 2020 at 9:25 PM Paolo Bonzini &lt;<=
a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<br=
>&gt;<br>&gt; On 09/10/20 15:02, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) =
wrote:<br>&gt; &gt; We can even using clang-format to format the whole repo=
sitory.<br>&gt;<br>&gt; checkpatch does other checks than formatting.<br>&g=
t;<br>&gt; Reformatting the whole repository has been mentioned many times,=
 people<br>&gt; were worried of messing up the result of &quot;git blame&qu=
ot;.=C2=A0 But without doing<br>&gt; that, it&#39;s hard to get rid of chec=
kpatch because checkpatch only looks<br>&gt; at the lines that are touched =
by the patch.<br>Make sense, clang-format can also only formatting the chan=
ged lines, <br>checkpatch also does what? do you means about the MAINTAINER=
? that can be preserved<br>we can use clang-format as a part of checkpatch.=
<br>The current problem with checkpatch is that is doesn&#39;t understand C=
 well.<br>Sometimes will arise werid errors.<br><br>For example, what&#39;s=
 does this means?<br><br>25/30 Checking commit 9e2a36e4c279 (plugin: Gettin=
g qemu-plugin.h can be included in multiple source file)<br>ERROR: storage =
class should be at the beginning of the declaration<br>#74: FILE: include/q=
emu/qemu-plugin.h:432:<br>+#define qemu_plugin_decl_symbol(symbol_name) ext=
ern symbol_name##_t symbol_name<br><br>total: 1 errors, 0 warnings, 88 line=
s checked<br><br>Patch 25/30 has style problems, please review.=C2=A0 If an=
y of these errors<br>are false positives report them to the maintainer, see=
<br>CHECKPATCH in MAINTAINERS.<br>&gt;<br>&gt; Paolo<br>&gt;<br><br><br>--<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=
=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang L=
uo<br></div>

--000000000000ce782305b13cf303--


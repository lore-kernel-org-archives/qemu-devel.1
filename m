Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539E9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8550A222B9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJOMynli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8550A222B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQsnG-0001n4-LN
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 09:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQslO-0000TH-TO
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:48:54 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132]:45817)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQslJ-0001j7-4n
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:48:50 -0400
Received: by mail-lf1-x132.google.com with SMTP id r127so10735918lff.12
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 06:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=4d5LnzHiYvnls/42ZzJONpjXqxkpQMoLmu7K5A5Epbc=;
 b=FJOMynli7X3JOGv4/HfbmtOrTJItXDBURoHW9/7OI6p5oUbhAVGrA2XfVx3tWiEEtx
 D81tEfpLm91qvmIWjRMnJb/KtLVXm98iGGw6FUWthqLkjyJKgQOuGKwcnQWQjczSUNK9
 boKZM0iJQB59yuPtJuzY+oQRXfVV5Kk0C1xabW7r7TojNXhz6M/fEE2/+LkE8dUsJql8
 1jpWO6/s/E051EnxDxoC3Y6Ewo1y0UM9899yCV+1EG7lbsca2/Z59T1yUTGnPvxsihEM
 vQ6M0T2sC1cCEqqu6MW1L1r7f/dfqg3JOz46Y0q1QWwwILQAcPECgA+32G0x9PP0m/Vf
 wj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=4d5LnzHiYvnls/42ZzJONpjXqxkpQMoLmu7K5A5Epbc=;
 b=T2rDv87zhP/cKAegYVpHd/szixIZW8ICwmCTO9Ro9xakDn44o0kIE0admdmOtq5bBW
 V27M7Lsc7oFCNGa0vF6g6CTiZVqjziJxDxwFYP0sC2LID0l/0hCNq68+xa2OzqSWQBiB
 c1O3/T1+WwpPcZbAIMNulKO6Qe1s3XZHugU5OkPv2k3A10beM+zQvIfC7B4//4lJtbD+
 2Prvz26uP5px2czD+JEwi6N7MMj5R4YOlp5ddqLLSdguIr/uUjjdWgVI6O+3ASmL2eXM
 hPCajmacXA9n/gF9Wq4EAZVcG2j/h+Pkqa6qAf/SlJrItq7s7Au7PB+IpnKsBDexPg2p
 srng==
X-Gm-Message-State: AOAM530mAUkC85+0va0SYMqccyMgPoLg/buXczxiz4HUyNWd0AWN8I3C
 F8srqXjLdevmpt/qiSj+JW19Qh7uheFQZUfpIf0=
X-Google-Smtp-Source: ABdhPJwBFdrP0k57r8MkYeCi+8JBFJN80lRL3QGgd9c24FAdNjerSXZGhppN7ds2FLr3pF2oOABZejDEtNNxunIXOb8=
X-Received: by 2002:a05:6512:3f0:: with SMTP id
 n16mr4026662lfq.554.1602251321996; 
 Fri, 09 Oct 2020 06:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE9YyZwRr5j3fCATTb32pacuGrT_yUBoUTd30k+id1D3iw@mail.gmail.com>
 <27f82fe6-5b0f-7e35-29d9-7b00ae8f189e@redhat.com>
In-Reply-To: <27f82fe6-5b0f-7e35-29d9-7b00ae8f189e@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 9 Oct 2020 21:48:30 +0800
Message-ID: <CAE2XoE_CSwHtUf52YvU_Kg9DLSPSvBke0NAatPY9=r2+u1hNsA@mail.gmail.com>
Subject: Re: How about using clang-format instead checkpatch for fixing style?
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e37aa505b13d3438"
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x132.google.com
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

--000000000000e37aa505b13d3438
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
For people really worried about the git blame, whe can even using
clang-format
to format the whole git history:)
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

--000000000000e37aa505b13d3438
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
by the patch.<div>For people really worried about the git blame, whe can ev=
en using clang-format</div><div>to format the whole git history:)<br>&gt;<b=
r>&gt; Paolo<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=
=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=
=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--000000000000e37aa505b13d3438--


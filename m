Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2BDC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 08:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2342720723
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 08:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFOh0oUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2342720723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jewTk-000693-Az
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 04:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jewSO-0004U4-PO
 for qemu-devel@nongnu.org; Sat, 30 May 2020 04:03:04 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c]:37498)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jewSO-0001Ca-0v
 for qemu-devel@nongnu.org; Sat, 30 May 2020 04:03:04 -0400
Received: by mail-ed1-x52c.google.com with SMTP id k8so3494992edq.4
 for <qemu-devel@nongnu.org>; Sat, 30 May 2020 01:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k8k8OBg8bqGEosRL+L+9I7oHaBOyEwB78osFf0AxB/M=;
 b=mFOh0oUqmcCl/UOA59EoIA3dd0YbnlaikAscZCtHEEbR+zIUZ/9l48EYMwRQreCaLY
 wOuUVPI2kRq5peKMG+YCvhytM8JR2X6NkW7iX80lIypfPPHGvoQHWeRfJ3kQeDGjD++e
 YJD6RWDYjxE2drhfsLfUwE7xbR4E4ueOqKiePRD7LLIrfycGo1YKs2tCJoDrmxjywgLY
 97tsyX+1SL/azHi90nXp4xI8sfDVYNgmIkVCNIt6z6/CEa/tsm5iGiyxf1WtH7jUJZzi
 fyfKVON5Lky2rq8ht3pAGwH/EqcqnE6x0qdJGFfEKkcCj24DjTaJQNwJIDrSRnbbjUt8
 7MMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k8k8OBg8bqGEosRL+L+9I7oHaBOyEwB78osFf0AxB/M=;
 b=YqgY5evSvkn3djSK0UPo3dZcchpjfrfeOD1CGUzxF7D1pQYNIuPu8nw+HRerHhsmU9
 SArxKltIb/VhBQtThQCKTZuGr73zd78k98CXzD3wz/zAOMkBK/uUfLavKN8FJLKwBJGR
 hS5GktLGsZN6jBEof+Um6XlM+iB++v1X5s4dEcJn9gFjtcaMtBadD0VaIwVHFbtmYLkJ
 0wwq4fuf96oB8HlAT8A0xwVn8aiUa9RangNe23EETRT4gCNfq+UHdbH16TEAScUDw0qx
 UqoBOjEvMJge4FFRDlrMmV2O/dA76TodxT2TQXwkjYwLv+xuhHDstIX8kQPa566ddeKo
 vVSw==
X-Gm-Message-State: AOAM5309B+BsBNrPF3iCAVddxX9bcvUPw5taF4KjYk5jFhugkI/k6GO8
 Ffe18Pw9gy29Wwgz3tpz3wZTQu5H7+w7eCMVfAnPEw==
X-Google-Smtp-Source: ABdhPJwGkcRpvHxw+nuABA14HAq9QIx1NHm70iDZLLS5CGV7JZiXkAjBHDbFFmjBD1z2EsaoE7/eE5IglYwek48L95g=
X-Received: by 2002:a05:6402:549:: with SMTP id
 i9mr5257665edx.159.1590825781849; 
 Sat, 30 May 2020 01:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_Lr8ySUK_PUNVB+RRQhFhEQL2wFeJtdYAxZhhT1xEFNw@mail.gmail.com>
 <CAFEAcA_qiz6fa7sGJmqcHEwX9CirqXVrbVP6XaLcxfskrb6wYg@mail.gmail.com>
In-Reply-To: <CAFEAcA_qiz6fa7sGJmqcHEwX9CirqXVrbVP6XaLcxfskrb6wYg@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 30 May 2020 10:02:44 +0200
Message-ID: <CAL1e-=jThKOGtG=tJT4ponkkZRTig1ZFAwJyH0vwrqxrr4Yaew@mail.gmail.com>
Subject: Re: 5.1 proposed schedule
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000a0707405a6d8fd46"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=aleksandar.m.mail@gmail.com; helo=mail-ed1-x52c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a0707405a6d8fd46
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

16:36 Pet, 29.05.2020. Peter Maydell <peter.maydell@linaro.org> =D1=98=D0=
=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On Tue, 26 May 2020 at 11:07, Peter Maydell <peter.maydell@linaro.org>
wrote:
> >
> > Here's a draft schedule for 5.1:
> >
> > 2019-07-06: softfreeze
>
> this should have read 2020-07-07 (Tuesday)...
>

I really like "Tuesdays" concept. It worked very well for me as a
submaintainer. I don't know its origin, but it works, bringing some degree
of order and predictability, and at the same seemingly not imposing larger
than necessary burden, and the end-of-week rush.

Just from my gut feeling, "Mondays" or "Fridays" wouldn't work that well.

Aleksandar

> > 2019-07-14: hardfreeze, rc0
> > 2019-07-21: rc1
> > 2019-07-28: rc2
> > 2019-08-04: rc3
> > 2019-08-11: release, or rc4 if we need it
> > 2019-08-18: release if we needed an rc4
>
> ...and these are all obviously supposed to be 2020,
> though the month/day numbers are otherwise correct.
>
> thanks
> -- PMM
>

--000000000000a0707405a6d8fd46
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">16:36 Pet, 29.05.2020. Peter Maydell &lt;<a href=3D"mailto:p=
eter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; On Tue, 26 May 2020 at 11:07, Peter Maydell &lt;<a href=3D"mailto:pete=
r.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; Here&#39;s a draft schedule for 5.1:<br>
&gt; &gt;<br>
&gt; &gt; 2019-07-06: softfreeze<br>
&gt;<br>
&gt; this should have read 2020-07-07 (Tuesday)...<br>
&gt;</p>
<p dir=3D"ltr">I really like &quot;Tuesdays&quot; concept. It worked very w=
ell for me as a submaintainer. I don&#39;t know its origin, but it works, b=
ringing some degree of order and predictability, and at the same seemingly =
not imposing larger than necessary burden, and the end-of-week rush.</p>
<p dir=3D"ltr">Just from my gut feeling, &quot;Mondays&quot; or &quot;Frida=
ys&quot; wouldn&#39;t work that well.</p>
<p dir=3D"ltr">Aleksandar</p>
<p dir=3D"ltr">&gt; &gt; 2019-07-14: hardfreeze, rc0<br>
&gt; &gt; 2019-07-21: rc1<br>
&gt; &gt; 2019-07-28: rc2<br>
&gt; &gt; 2019-08-04: rc3<br>
&gt; &gt; 2019-08-11: release, or rc4 if we need it<br>
&gt; &gt; 2019-08-18: release if we needed an rc4<br>
&gt;<br>
&gt; ...and these are all obviously supposed to be 2020,<br>
&gt; though the month/day numbers are otherwise correct.<br>
&gt;<br>
&gt; thanks<br>
&gt; -- PMM<br>
&gt;<br>
</p>

--000000000000a0707405a6d8fd46--


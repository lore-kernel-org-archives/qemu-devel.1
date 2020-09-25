Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF9AC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 06:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E402176B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 06:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=loureiro-eng-br.20150623.gappssmtp.com header.i=@loureiro-eng-br.20150623.gappssmtp.com header.b="wVGSjG1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E402176B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loureiro.eng.br
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLgtQ-0004hw-0K
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 02:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <helio@loureiro.eng.br>)
 id 1kLgpq-00045P-2J
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 02:03:58 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:35245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <helio@loureiro.eng.br>)
 id 1kLgpn-0002XU-T2
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 02:03:57 -0400
Received: by mail-ej1-x642.google.com with SMTP id u21so2034877eja.2
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 23:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=loureiro-eng-br.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M/VZXapZPUKVFa+REPSoafkcKSRPp9QZPs9YOI6GhcY=;
 b=wVGSjG1O5ARv3clBUjykDQL18V8nIQ4My/bkSWkP/sE4ZNmh0MWbCwFd/6CZKbxlnC
 EOvxG1oKeIjCEFzLBKE3foYb5KJAKZ+nK/utYh+O0rOfQpkTXfJ+T+igjHijlX4hsOJq
 d9InrFdG3KN/s6la1UUipsg+xwUboJR+RIXBwJwnTHgcy0BtceVMSd1WS7LPIvMcwrzA
 obi/HkGKDxLeQopy2o7UwQln+UWI3kcxP7zjH3VcltwzkvhMiHEmgB5zjocDPKDB5wnC
 /CqBkvwlJar5kIttNNrQkoasNKODmNDnuWAO0S46OpRfa8tsRQJMWbZ9DOFcKJJT4CPw
 uHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M/VZXapZPUKVFa+REPSoafkcKSRPp9QZPs9YOI6GhcY=;
 b=EHKOnS0nrqKBlgCp1t6ni8envgrwP31lf7FUZeFnJk/CgCLs4vmOQrUQ/XtxzZTK/6
 9R6X2DawhgD2dX4tq6daIZ/UMgqf8rxAFUqR0JtAM5j6HtAA6fucsPmhg0TpkzQbUAR9
 HiwxxfK+ciToaooE2DGct16nonROazcItUm+gP/jU6PGiRI6LT8v/J/qZy0x3OorcsqF
 SWOHsTZTNmXEAV3ZpBEyIdjRnfCJO4hy2QS1e7qycPHLI021UuVwPrTcbkE9USNDOQP/
 AeJuuZqHG8nAxnPhhFTaFhF7h5C6lcW/2qL0XxDKzBgYYoObBJxDpLDJS+bflheOq01v
 J9nw==
X-Gm-Message-State: AOAM530LPR66jjxEvqN7y92hByRxWtvFlFu7cW3SjimLq7bZb1E3FfyX
 rKehlrxsinVjMxkk1NRQ2QjkBEmNmOpT8sJMV/MaJw==
X-Google-Smtp-Source: ABdhPJzkNM7tzREbM+mQiVTzsyHsIJ9XllUtkUJ56XU4uXWxZJo7rCnedGfgvrah7PTCzPWT3KNOeDc6eIx+L4dL9es=
X-Received: by 2002:a17:906:f950:: with SMTP id
 ld16mr1086549ejb.489.1601013832588; 
 Thu, 24 Sep 2020 23:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-17-jsnow@redhat.com>
 <20200925011849.GI368253@localhost.localdomain>
 <5a392d78-cf26-7c75-e00e-bf913607c0ac@redhat.com>
In-Reply-To: <5a392d78-cf26-7c75-e00e-bf913607c0ac@redhat.com>
From: Helio Loureiro <helio@loureiro.eng.br>
Date: Fri, 25 Sep 2020 08:03:41 +0200
Message-ID: <CAPxLgJLSntAY5zaLJvJuPhA9bccGYpAe04j0nhcMdk94SSvtAA@mail.gmail.com>
Subject: Re: [PATCH 16/16] qapi/expr.py: Use an expression checker dispatch
 table
To: John Snow <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c5bb0e05b01d14e0"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=helio@loureiro.eng.br; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c5bb0e05b01d14e0
Content-Type: text/plain; charset="UTF-8"

Hi,

I would replace the word variable "kind" by "category".

./helio

On Fri, Sep 25, 2020, 03:32 John Snow <jsnow@redhat.com> wrote:

> On 9/24/20 9:18 PM, Cleber Rosa wrote:
> > I have to say the style of this line bothers me, but it's just that,
> > style. So,
>
> What don't you like?
>
>
>

--000000000000c5bb0e05b01d14e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi,<div dir=3D"auto"><br></div><div dir=3D"auto">I would =
replace the word variable &quot;kind&quot; by &quot;category&quot;.</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">./helio</div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 25, 20=
20, 03:32 John Snow &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 9/24/20 9:18 PM=
, Cleber Rosa wrote:<br>
&gt; I have to say the style of this line bothers me, but it&#39;s just tha=
t,<br>
&gt; style. So,<br>
<br>
What don&#39;t you like?<br>
<br>
<br>
</blockquote></div>

--000000000000c5bb0e05b01d14e0--


Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E3AC2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 11:36:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9A5238E2
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 11:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=loureiro-eng-br.20150623.gappssmtp.com header.i=@loureiro-eng-br.20150623.gappssmtp.com header.b="Z6kaUOGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9A5238E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loureiro.eng.br
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kM8Uo-00008J-Gd
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 07:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <helio@loureiro.eng.br>)
 id 1kM8Qh-0007nj-2M
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 07:31:51 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:36965)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <helio@loureiro.eng.br>)
 id 1kM8Qe-00067o-RP
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 07:31:50 -0400
Received: by mail-ed1-x541.google.com with SMTP id n22so5154191edt.4
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2020 04:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=loureiro-eng-br.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1lAOUjTx7vlZ1qpesw2jvlk3L5vFF7w++tSf7H13jFA=;
 b=Z6kaUOGYQnyenmwhk4bdd/c8F9rST0wJwCq5+sGknqc04gbGCncCM1SRcysuZ0VYEw
 8TfgIv04AQtBHXDlfssLTfXheCrH6NQ9tdm2bv1GWFEAr96SEO5YbJS1nrU+azfmYHR4
 FwtN7xomkglk8fJQ5Ejl2GgBtPXzhMJ1HSkaO/WqeU7u4MkxAw2uADOTc3cJOqwQiy84
 WvKF5MBkS6W8yGo7t8GqxjENkq8DQik32G9UqtX6Rq4qlCakVdOfpvwfh6x+kpT9jVz5
 YKT4WgLTY6cpOQdjSxvu6QNCXAznUTnRxae2gEBMfd/XlW/wLqbvqqM4mzDSEStRmFvd
 lQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1lAOUjTx7vlZ1qpesw2jvlk3L5vFF7w++tSf7H13jFA=;
 b=rvWrjxquyfy5l46Zkf2sRR+SNXUu/8R0NdiRYEzOprXRoykbbWumhut1ht0KuvGCev
 uLYcvHli/rcFiiO0dH68rDcHbuxaVRyYGNcQmKKkAmkO5BPoPte10z2qkPuTTDLcYQEW
 qDyljUIprUdW/bBhD/xTxY9PG73h0n+RxGz/vMHgakcur+CRV+490rSVzFEv1nVT31BB
 W4I8WpHlKg5V/6LpN32Lr3eZQpIcRlzX+sjSI+aTlSvXNarwQCZBKUqiNGNRnSq9ZJYq
 uy2OvRl3BoyoD1hO+dtstN0TgCrJeOwHYTtb7TYdcqxtlwkUnduZleiwQFGT6d/2WslW
 NSyw==
X-Gm-Message-State: AOAM532cTvvVW3W+rEOm84GVRLk3aMtkTWhwTB7zx/q68xzknkkCkc43
 AdQC0eYhVHGw1Vgl4pSuT5I3gQWXe1K60OBRJNCbaQ==
X-Google-Smtp-Source: ABdhPJwOPZlkIMQ3ttIfqa/Yk2rAFWKLeiLrOb968a8AcJDyu/26LzrmTuOPQWPiRgxr2fyfNMpiCAIQkgx/EZITTTs=
X-Received: by 2002:a05:6402:d09:: with SMTP id
 eb9mr6080567edb.219.1601119905896; 
 Sat, 26 Sep 2020 04:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-17-jsnow@redhat.com>
 <20200925011849.GI368253@localhost.localdomain>
 <5a392d78-cf26-7c75-e00e-bf913607c0ac@redhat.com>
 <CAPxLgJLSntAY5zaLJvJuPhA9bccGYpAe04j0nhcMdk94SSvtAA@mail.gmail.com>
 <52dfd3f1-c82a-e1e1-9f23-60bc15da76f1@redhat.com>
In-Reply-To: <52dfd3f1-c82a-e1e1-9f23-60bc15da76f1@redhat.com>
From: Helio Loureiro <helio@loureiro.eng.br>
Date: Sat, 26 Sep 2020 13:31:37 +0200
Message-ID: <CAPxLgJ+Kp48zr-rcFrtGJGBdkZKs3xkfXoCHeC2VdTe369aucA@mail.gmail.com>
Subject: Re: [PATCH 16/16] qapi/expr.py: Use an expression checker dispatch
 table
To: John Snow <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003bfb7405b035c768"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=helio@loureiro.eng.br; helo=mail-ed1-x541.google.com
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

--0000000000003bfb7405b035c768
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 25, 2020, 16:16 John Snow <jsnow@redhat.com> wrote:

> On 9/25/20 2:03 AM, Helio Loureiro wrote:
> > Hi,
> >
> > I would replace the word variable "kind" by "category".
> >
>
> Hi, welcome to the list!
>

Tkz!


> For patch reviews, we try to reply in-line, below the original post.
>

I realized that later.  It has been more than 20 years I don't use this
formating.  But if I intend to join the pack, I need to follow the pack.

>
>
(For more information on the QAPI Schema Language that we are parsing
> and validating here, see docs/devel/qapi-code-gen.txt if you are
> curious. Ultimately it is a JSON-like format that permits multiple
> objects per document and allows comments. We use these structures to
> generate types and command interfaces for our API protocol, QMP.)
>

Based on that I would suggest 'type_ref' instead to match the definitions
over there and since word 'type' itself is reserved.


>
>
./helio

>

--0000000000003bfb7405b035c768
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Sep 25, 2020, 16:16 John Snow &lt;<a href=3D"m=
ailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">On 9/25/20 2:03 AM, Helio Loureiro wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; I would replace the word variable &quot;kind&quot; by &quot;category&q=
uot;.<br>
&gt; <br>
<br>
Hi, welcome to the list!<br></blockquote></div></div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">Tkz!</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
For patch reviews, we try to reply in-line, below the original post.<br></b=
lockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I reali=
zed that later.=C2=A0 It has been more than 20 years I don&#39;t use this f=
ormating.=C2=A0 But if I intend to join the pack, I need to follow the pack=
.</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto"></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">
(For more information on the QAPI Schema Language that we are parsing <br>
and validating here, see docs/devel/qapi-code-gen.txt if you are <br>
curious. Ultimately it is a JSON-like format that permits multiple <br>
objects per document and allows comments. We use these structures to <br>
generate types and command interfaces for our API protocol, QMP.)<br></bloc=
kquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Based on t=
hat I would suggest &#39;type_ref&#39; instead to match the definitions ove=
r there and since word &#39;type&#39; itself is reserved.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex"><br></blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br></bl=
ockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">./helio<=
/div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">
</blockquote></div></div></div>

--0000000000003bfb7405b035c768--


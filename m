Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0F4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 816C420878
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFfI6rrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816C420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSR2k-0003sD-E8
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 16:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1kSPJl-00056c-7p
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 14:46:37 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:40251)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1kSPJh-0003Fb-Nh
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 14:46:35 -0400
Received: by mail-pl1-x631.google.com with SMTP id d23so330130pll.7
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 11:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PcuWGbu1A2Pg8e3pM9C4NEy0XTjKsY0NCVN1ZZJqJIM=;
 b=XFfI6rrD6vJ8FWwN6WFWyz5LvuH/AB8A98zD1aGQghB0bXFBzRLR+I8K1tbr9nKnEZ
 FgR+3PANKRKeyJW6e6xuByAhk9UouwJXeV74bVKJ0zCf0wqjZyGEOl/DFh4MRwiXa6gR
 260KpBkKqkBShm4rPysEiao4WueDBW/wQGPH0QguR4RtqLlXxSLkjS89iGD6LXb8dCpl
 WAYRF/iMDLC14lWLt8aes7X0yMbA8qMkZPJLCz5IpYygGpO2hcFRgo/W6ta+gUWgeJ5l
 XmN7w8qILQ3oNzRWkigNaYzMSfTHmMjxeTawb1j0gf/foouNqcNc75cp01PCJSK5IKR2
 bZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PcuWGbu1A2Pg8e3pM9C4NEy0XTjKsY0NCVN1ZZJqJIM=;
 b=dAWxBwo181Zowz8eixkBn95+qYqEc75/+qr9ODqdLAonubOWsroDh1Mr/BbqZFjmXj
 w8/7aihQSOW1JYD3qBIHgh/howdb9jhUOn2pZZf4/mVuC/25f+g9jFubZjUgsdgRfkRy
 fiRswv7r1CyXwhSNWfzT47AA3NFT7PFfggWBR4VPNvrNuQ0KXVgErGdQ7FpxDOuSbyxE
 /YeM+gfar+VXuzuUQ9clOECvWjKTc2EFnjDaViNrPpwyCinjt0cL7Fs9KYhD/rQ/8TPC
 9A/31WC0t0g7BCdrpJImmiSblCovDXVjdF5pLDlWyGfXTkOJoDf2JJxIMrWNkh9EN2SW
 Wujw==
X-Gm-Message-State: AOAM533NqmeIy5f2eB3xwGVH3z2yiR+B892tlXolgpSjimU4KfH8fAf8
 LZdtoTubFOMDbeArtlS41waVVq0LA46NKgS/iY0=
X-Google-Smtp-Source: ABdhPJxqFH5zOB0LJLDE8U75LlwUvc1xmTVoMDXpLKNmvnKfNbTFSIJNYhxkNu/7WGF4qDlNdXebZ+VUrqh7XvRWOFM=
X-Received: by 2002:a17:902:7242:b029:d4:c719:79ce with SMTP id
 c2-20020a1709027242b02900d4c71979cemr863265pll.26.1602614791753; Tue, 13 Oct
 2020 11:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Ai=tAypbso9yMy0jtyzbeHCweQ1FPgDaJ8=bXxFvBA6pZyLA@mail.gmail.com>
 <CA+Ai=tBJqLB7yDbd-kqzDhr+d+65K9r3DQsZrB2kGi9wF8BaiA@mail.gmail.com>
 <2d69f1ac-df97-9d70-d2e2-e9cf27cf9b0c@redhat.com>
 <CA+Ai=tCk-XX7yogRu=zoKxDv7okRHXibbnT9OoMs8XpHs9yDkA@mail.gmail.com>
 <a50f47d2-f5c6-49c0-779f-dfcaf05df5f9@redhat.com>
 <CA+Ai=tCDHWBLNToQ2HqMVmJtXxKzP40AuDqfWc=YQV3mggcc4Q@mail.gmail.com>
 <CA+Ai=tAVxNRNN1EP8LorOsYBm01f0ekmKCnMfcNH_eSqk5pFzg@mail.gmail.com>
 <CA+Ai=tBtSqigWwB4HNeZ8CT4JMEMBU2eEd47BCs2-QCEeBEARw@mail.gmail.com>
 <09b8a63d-06ab-4846-cbc0-69bd95ca8ead@redhat.com>
In-Reply-To: <09b8a63d-06ab-4846-cbc0-69bd95ca8ead@redhat.com>
From: Rohit Shinde <rohit.shinde12194@gmail.com>
Date: Tue, 13 Oct 2020 14:46:20 -0400
Message-ID: <CA+Ai=tCvVsUNuNZo-gMmsMaQtn+H6CqGstMGhuDgm8rNsf7V5A@mail.gmail.com>
Subject: Re: Contributor wanting to get started with simple contributions
To: John Snow <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005fd34705b191d538"
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=rohit.shinde12194@gmail.com; helo=mail-pl1-x631.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 13 Oct 2020 16:36:02 -0400
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, ehabkost@redhat.com,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005fd34705b191d538
Content-Type: text/plain; charset="UTF-8"

Hey John,

Sorry for the late reply! I was in the midst of a job change and couldn't
get time to get to this.

The work sounds interesting! I have a couple of questions regarding this:


   1. How do I actually build this part? I am familiar with building and
   using QEMU. Does the qapi parser get built along with the main code?
   2. If not, how do I start using this part and contributing to it?


Thanks,
Rohit.

On Tue, Sep 29, 2020 at 9:38 PM John Snow <jsnow@redhat.com> wrote:

> On 9/2/20 12:38 PM, Rohit Shinde wrote:
> > Hey John,
> >
> > I wanted to follow up on this, in case you missed my previous email :)
> >
> > Thanks,
> > Rohit.
> >
>
> Sorry Rohit, very buried in my work and haven't been doing a good job
> with my inbox.
>
> Right now, I am working on converting the QAPI parser module to the
> strictly typed mypy subset:
>
> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg09136.html
>
> There are six parts in all, that is part one. I am posting a v4 right
> now as I write this.
>
>
> Work that remains to be done after these six parts:
>
> - Get ./python/qemu passing under mypy/pylint/flake8 again. I have old
> patches for this that were on-list prior to the 5.1 release.
>
> - Move ./scripts/qapi to ./python/qemu/qapi/
>
> - Move ./python/qemu to ./python/qemu/core/
>
> - Create a "make check" style script that will run
> mypy/pylint/flake8/isort on all the code in ./python. (I have patches
> for this, too.)
>
> - Start investigating python scripts in ./scripts and consider moving
> them to ./python/qemu/tools, fixing them up to pass
> mypy/flake8/pylint/isort (etc) as I go. There are no existing patches to
> do this yet.
>
>
> Other work I am doing:
>
> - Investigating the use of Pydantic to replace ./scripts/qapi/expr.py
> - Investigating a YAML format for the QAPI parser
> - Building a JSON-SCHEMA output format for the QAPI generator
>
>
> > On Sat, Aug 29, 2020 at 1:14 AM Rohit Shinde
> > <rohit.shinde12194@gmail.com <mailto:rohit.shinde12194@gmail.com>>
> wrote:
> >
> >     Hey John,
> >
> >     Sorry to bother you! I just wanted to know if you had any thoughts
> >     on the mail I sent.
> >
> >     Is there anything I can pick up right now with regards to the Python
> >     package? You mentioned that linting is something that needs to be
> >     completed before we go ahead, so maybe I can start with that?
> >
> >     Thanks,
> >     Rohit.
> >
>
>

--0000000000005fd34705b191d538
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hey John,<div><br></div><div>Sorry for the late reply! I w=
as in the midst of a job change and couldn&#39;t get time to get to this.</=
div><div><br></div><div>The work sounds interesting! I have a couple of que=
stions regarding this:</div><div><br></div><div><ol><li>How do I actually b=
uild this part? I am familiar with building and using QEMU. Does the qapi p=
arser get built along with=C2=A0the main code?</li><li>If not, how do I sta=
rt using this part and contributing to it?</li></ol><div><br></div></div><d=
iv>Thanks,</div><div>Rohit.</div></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 29, 2020 at 9:38 PM John Snow =
&lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">jsnow@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n 9/2/20 12:38 PM, Rohit Shinde wrote:<br>
&gt; Hey John,<br>
&gt; <br>
&gt; I wanted to follow up on this, in case you missed my previous email :)=
<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Rohit.<br>
&gt; <br>
<br>
Sorry Rohit, very buried in my work and haven&#39;t been doing a good job <=
br>
with my inbox.<br>
<br>
Right now, I am working on converting the QAPI parser module to the <br>
strictly typed mypy subset:<br>
<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg09136.h=
tml" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/archive/htm=
l/qemu-devel/2020-09/msg09136.html</a><br>
<br>
There are six parts in all, that is part one. I am posting a v4 right <br>
now as I write this.<br>
<br>
<br>
Work that remains to be done after these six parts:<br>
<br>
- Get ./python/qemu passing under mypy/pylint/flake8 again. I have old <br>
patches for this that were on-list prior to the 5.1 release.<br>
<br>
- Move ./scripts/qapi to ./python/qemu/qapi/<br>
<br>
- Move ./python/qemu to ./python/qemu/core/<br>
<br>
- Create a &quot;make check&quot; style script that will run <br>
mypy/pylint/flake8/isort on all the code in ./python. (I have patches <br>
for this, too.)<br>
<br>
- Start investigating python scripts in ./scripts and consider moving <br>
them to ./python/qemu/tools, fixing them up to pass <br>
mypy/flake8/pylint/isort (etc) as I go. There are no existing patches to <b=
r>
do this yet.<br>
<br>
<br>
Other work I am doing:<br>
<br>
- Investigating the use of Pydantic to replace ./scripts/qapi/expr.py<br>
- Investigating a YAML format for the QAPI parser<br>
- Building a JSON-SCHEMA output format for the QAPI generator<br>
<br>
<br>
&gt; On Sat, Aug 29, 2020 at 1:14 AM Rohit Shinde <br>
&gt; &lt;<a href=3D"mailto:rohit.shinde12194@gmail.com" target=3D"_blank">r=
ohit.shinde12194@gmail.com</a> &lt;mailto:<a href=3D"mailto:rohit.shinde121=
94@gmail.com" target=3D"_blank">rohit.shinde12194@gmail.com</a>&gt;&gt; wro=
te:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hey John,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Sorry to bother you! I just wanted to know if you h=
ad any thoughts<br>
&gt;=C2=A0 =C2=A0 =C2=A0on the mail I sent.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Is there anything I can pick up right now with rega=
rds to the Python<br>
&gt;=C2=A0 =C2=A0 =C2=A0package? You mentioned that linting is something th=
at needs to be<br>
&gt;=C2=A0 =C2=A0 =C2=A0completed=C2=A0before we go ahead, so maybe I can s=
tart with that?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks,<br>
&gt;=C2=A0 =C2=A0 =C2=A0Rohit.<br>
&gt; <br>
<br>
</blockquote></div>

--0000000000005fd34705b191d538--


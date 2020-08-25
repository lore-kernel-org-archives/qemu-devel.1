Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8DEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 02:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B852D2067C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 02:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWkFdvWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B852D2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAOgR-0005Gs-W5
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 22:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1kAOfl-0004qf-EE
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 22:26:53 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:46143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1kAOfj-0004XO-EP
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 22:26:53 -0400
Received: by mail-pf1-x42d.google.com with SMTP id t185so3011236pfd.13
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 19:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c8qKziI075TS/H4gDlzJOi7RiQ4wsG4qIlvhPVMJ8mk=;
 b=aWkFdvWA53iCC2nozcbJdiwduiDVH7OaSY+XnOPUeIFk5tMO0/N2XDPrnmfI9P1PuX
 dKYwMUNRr1cgm4dIyQV63YWvrMr4lRW88cVpKoaLMmKTjc9jI+BIkhBzyKs6fjSpwuZD
 vh5ukpz/VBCdPv/YtoKtD0ogYPIZCwR+i6TiFu/cUEa1nIqdw+80ajDK21sc4qHrtNE+
 CeQhskA1Mdmu5X0hW5JUBWh1xs7pqWhk/ZxzeDjEJO2fK7ZVs7REXQ1n5BV/6qUHHqT3
 LUYuEzBsjykSWFtccvivbEHFb4dyhyTgtNcByC0UixmsA85kBnERo/HbrlDZpNmLnfrn
 yhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c8qKziI075TS/H4gDlzJOi7RiQ4wsG4qIlvhPVMJ8mk=;
 b=FS2yT8RpK7yH3RFo76XMwcuR1L1w8cfKOP8+iXvc4DADrGKuk51t5FlUccYqrhTt51
 JGRjSztrdnr+RNS0Uzi/1sMRjWTe8VHs5F70UJdqmsUPFbrQA5dTJkQ930ahohOsHVIV
 x9wKGd7np1K4dB6TZ9eaHS+bS25Us6+V5+k2Mst4W/4vOsApWlk/94M95qsi0qI3JKwg
 tayBQ73ajasUy5HJ4+ptf3mfqzPrnOhl+OssK5+eukUzOB1YlpqwBK0bGnibhD41S3st
 nCPjZRb2kafOw87JZkNngOTRNb+KLIw+3HPj4n1rYUBOuWqM0wVcZanXWt4jwP4qY7sG
 9Y8g==
X-Gm-Message-State: AOAM530jnK7LymRAqQTBE4JvmNZokdezW+K4AcOfzoTmUsqRpuoPh6Dc
 8h2KC0/uMvBWbPN/vliTyhNR3JdfYOHNCwBFCYCKk8htfM4=
X-Google-Smtp-Source: ABdhPJz44aqcIE3REIaTV/A+psdj1D9dKeSUZDmN/8nf7OsPVMIXTV+MkfkBjt6L8Mgfh3bqgl9Tm+zzwRM05QVKPxU=
X-Received: by 2002:a17:902:a60f:: with SMTP id
 u15mr5876202plq.239.1598322409135; 
 Mon, 24 Aug 2020 19:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Ai=tAypbso9yMy0jtyzbeHCweQ1FPgDaJ8=bXxFvBA6pZyLA@mail.gmail.com>
In-Reply-To: <CA+Ai=tAypbso9yMy0jtyzbeHCweQ1FPgDaJ8=bXxFvBA6pZyLA@mail.gmail.com>
From: Rohit Shinde <rohit.shinde12194@gmail.com>
Date: Mon, 24 Aug 2020 22:26:38 -0400
Message-ID: <CA+Ai=tBJqLB7yDbd-kqzDhr+d+65K9r3DQsZrB2kGi9wF8BaiA@mail.gmail.com>
Subject: Re: Contributor wanting to get started with simple contributions
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000006ee0e605adaa6fdb"
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=rohit.shinde12194@gmail.com; helo=mail-pf1-x42d.google.com
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
Cc: jsnow@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006ee0e605adaa6fdb
Content-Type: text/plain; charset="UTF-8"

Hey John,

I sent this email a couple of weeks ago to the qemu mailing list since I
didn't really know who to approach.

I am interested in contributing to the python-qemu package. I have quite a
bit of experience in Python, but no experience in packaging libraries.
Whatever you mentioned in the reply to my comment on the bug, was pretty
interesting. I would like to get started with at least ensuring that all
python code is flake8/pylint compliant.

Do let me know what you think of this.

Thanks,
Rohit.

On Thu, Aug 13, 2020 at 7:18 AM Rohit Shinde <rohit.shinde12194@gmail.com>
wrote:

> Hello everyone,
>
> I am a hobby programmer (working as an SDE in the industry) and I have
> been observing qemu for quite a while. I have always wanted to contribute
> but I couldn't manage my time. I am good at Java and Python but quite a bit
> rusty with C++ and C (although working with it will not be a problem, I
> might have to google more than usual). On the theory side, I have a good
> grasp of data structures and algorithms and a decent understanding of OS
> and Compilers.
>
> I have built qemu from source and I have my machine setup for git-publish
> via email.
>
> I would like to start contributing with one of the bite sized tasks
> mentioned in the wiki page. The one that interests me and which I think is
> the easiest are the sections on "Compiler Driven Cleanup" and "Dead Code
> Removal". I think this is a good way to get introduced to the codebase.
>
> I plan to stay and become a long term contributor. Is there any CS theory
> that I would need to know other than what I mentioned above? Is it possible
> to "learn on the go"?
>
> I realize this is quite a long email and I would like to thank everyone in
> advance for reading this!
>
> Regards,
> Rohit.
>

--0000000000006ee0e605adaa6fdb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hey John,<div><br></div><div>I sent this email a couple of=
 weeks ago to the qemu mailing list since I didn&#39;t really know who to a=
pproach.</div><div><br></div><div>I am interested in contributing to the py=
thon-qemu package. I have quite a bit of experience in Python, but no exper=
ience in packaging libraries. Whatever you mentioned in the reply to my com=
ment on the bug, was pretty interesting. I would like to get started with a=
t least ensuring that all python code is flake8/pylint compliant.=C2=A0</di=
v><div><br></div><div>Do let me know what you think of this.</div><div><br>=
</div><div>Thanks,</div><div>Rohit.</div></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 13, 2020 at 7:18 AM Ro=
hit Shinde &lt;<a href=3D"mailto:rohit.shinde12194@gmail.com">rohit.shinde1=
2194@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><div dir=3D"ltr">Hello everyone,<div><br></div><div>I am a ho=
bby programmer (working as an SDE in the industry) and I have been observin=
g qemu for quite a while. I have always wanted to contribute but I couldn&#=
39;t manage my time. I am good at Java and Python but quite a bit rusty wit=
h C++ and C (although working with it will not be a problem, I might have t=
o google more than usual). On the theory side, I have a good grasp of data =
structures and algorithms and a decent understanding of OS and Compilers.</=
div><div><br></div><div>I have built qemu from source and I have my machine=
 setup for git-publish via email.=C2=A0<br></div><div><br></div><div>I woul=
d like to start contributing with one of the bite sized tasks mentioned in =
the wiki page. The one that interests me and which I think is the easiest a=
re the sections on &quot;Compiler Driven Cleanup&quot; and &quot;Dead Code =
Removal&quot;. I think this is a good way to get introduced to the codebase=
.</div><div><br></div><div>I plan to stay and become a long term contributo=
r. Is there any CS theory that I would need to know other than what I menti=
oned above? Is it possible to &quot;learn on the go&quot;?</div><div><br></=
div><div>I realize this is quite a long email and I would like to thank eve=
ryone in advance for reading this!</div><div><br></div><div>Regards,<br>Roh=
it.</div></div>
</blockquote></div>

--0000000000006ee0e605adaa6fdb--


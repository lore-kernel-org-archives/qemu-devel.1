Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB85EC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 11:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9461720715
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 11:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuMZTypK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9461720715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6BGZ-0002Gz-OM
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 07:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1k6BFz-0001lt-DQ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 07:18:51 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f]:54381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1k6BFx-0003o6-N5
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 07:18:51 -0400
Received: by mail-pj1-x102f.google.com with SMTP id mt12so2624984pjb.4
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 04:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=n6tS5XJnYLyP+0lIRg7iZwm7rfALb5D19cXho3NAfH8=;
 b=fuMZTypKi2WuCTWXp7qA8zRQyfZwBr6LWY67JTZ+zj+AtwZKfdZSb+Rph1pfkUhE/u
 4Vl/jvSczPQG9UCo1h2Wnle59+dm/ayKrwOgfKDAbiSi/VivpOH0fSRXP14kAV1nHGIC
 zU4CZGC36qory1DrHZNKsR4rwoXyuraZJ+9Knn+r7XRJzbo6bI/dFnlHz/wUN814coMJ
 q/rji1DUbKi3LrxXSd6xOfXC8UrK8uXtsSXVmbC7XdPWsAcq1/xrh/mj+8YIaR3d1Tz2
 kpUPXGWkExItBZWtVX16pipKte42EcCTk31daOsF4KD/vpXosZ2XTDg1IIre0GXCOCvM
 uNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=n6tS5XJnYLyP+0lIRg7iZwm7rfALb5D19cXho3NAfH8=;
 b=AkBO4jcwSTmD356tHNqiBoY02CQlOIqXeMzRnMoZ1LEHsBY1rDhMpmsmAhFD1w9D34
 TO5jFeKPRQcQnGYTKVBP/rjWWVU5krQZf+w1FKkzAIDoKa/iYaKcnF0M1CQ5is0tCSg/
 zyJ5HioutJy+sGsWmHr3C9sBmVo6z1MUQXP5w0YHWRP2kn3Zq0LSQ/YvZO0u6AZfU/2I
 IFkZvq84jORNAcgqZjVUp4Whn9sZyhDdVe6umR8XxGPOX89SyNsQB8GvFV+o+HHc0BIJ
 NHMutn5rOqLiB9I+vLnPX+sF8ZJekN27XKX+pHlt2dYSxg9WFPQbUq/nGw+0Q7ga5Pwu
 Mzpw==
X-Gm-Message-State: AOAM532jFQsYtTCqMD07S4CdlkKNZqjR2tZBDGg2yegN3/pelIpdcsPW
 lKzBBa3T+Y4QsmJkkdLi1eAoLZgK6U7IITFlimkTpIxQlcs=
X-Google-Smtp-Source: ABdhPJxgEcQHh1ydSUtDe9HY/nFGF/+I7p9Rr9ecn2Rr8NvRaYaDaeh2VxdB0wcM4woyRcc8rEOAk1wRZdbgnaEE3nc=
X-Received: by 2002:a17:90b:4c46:: with SMTP id
 np6mr4586520pjb.201.1597317527540; 
 Thu, 13 Aug 2020 04:18:47 -0700 (PDT)
MIME-Version: 1.0
From: Rohit Shinde <rohit.shinde12194@gmail.com>
Date: Thu, 13 Aug 2020 04:18:36 -0700
Message-ID: <CA+Ai=tAypbso9yMy0jtyzbeHCweQ1FPgDaJ8=bXxFvBA6pZyLA@mail.gmail.com>
Subject: Contributor wanting to get started with simple contributions
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d2970f05acc07748"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=rohit.shinde12194@gmail.com; helo=mail-pj1-x102f.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d2970f05acc07748
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

I am a hobby programmer (working as an SDE in the industry) and I have been
observing qemu for quite a while. I have always wanted to contribute but I
couldn't manage my time. I am good at Java and Python but quite a bit rusty
with C++ and C (although working with it will not be a problem, I might
have to google more than usual). On the theory side, I have a good grasp of
data structures and algorithms and a decent understanding of OS and
Compilers.

I have built qemu from source and I have my machine setup for git-publish
via email.

I would like to start contributing with one of the bite sized tasks
mentioned in the wiki page. The one that interests me and which I think is
the easiest are the sections on "Compiler Driven Cleanup" and "Dead Code
Removal". I think this is a good way to get introduced to the codebase.

I plan to stay and become a long term contributor. Is there any CS theory
that I would need to know other than what I mentioned above? Is it possible
to "learn on the go"?

I realize this is quite a long email and I would like to thank everyone in
advance for reading this!

Regards,
Rohit.

--000000000000d2970f05acc07748
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello everyone,<div><br></div><div>I am a hobby programmer=
 (working as an SDE in the industry) and I have been observing qemu for qui=
te a while. I have always wanted to contribute but I couldn&#39;t manage my=
 time. I am good at Java and Python but quite a bit rusty with C++ and C (a=
lthough working with it will not be a problem, I might have to google more =
than usual). On the theory side, I have a good grasp of data structures and=
 algorithms and a decent understanding of OS and Compilers.</div><div><br><=
/div><div>I have built qemu from source and I have my machine setup for git=
-publish via email.=C2=A0<br></div><div><br></div><div>I would like to star=
t contributing with one of the bite sized tasks mentioned in the wiki page.=
 The one that interests me and which I think is the easiest are the section=
s on &quot;Compiler Driven Cleanup&quot; and &quot;Dead Code Removal&quot;.=
 I think this is a good way to get introduced to the codebase.</div><div><b=
r></div><div>I plan to stay and become a long term contributor. Is there an=
y CS theory that I would need to know other than what I mentioned above? Is=
 it possible to &quot;learn on the go&quot;?</div><div><br></div><div>I rea=
lize this is quite a long email and I would like to thank everyone in advan=
ce for reading this!</div><div><br></div><div>Regards,<br>Rohit.</div></div=
>

--000000000000d2970f05acc07748--


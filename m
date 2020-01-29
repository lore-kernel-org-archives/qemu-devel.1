Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564C6C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:32:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9BA20716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAqb89EH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9BA20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwjhj-0002pB-Bm
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 04:32:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1iwjga-00023c-LU
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:31:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1iwjgZ-00023j-Jq
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:31:00 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:39513)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>)
 id 1iwjgX-000212-29; Wed, 29 Jan 2020 04:30:57 -0500
Received: by mail-ot1-x32b.google.com with SMTP id 77so14900043oty.6;
 Wed, 29 Jan 2020 01:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1nidJn4TpMHPwHjg1Q8KqftSQN0wR/SmnvkXiE1Sje4=;
 b=oAqb89EHzPEWa3J9wOS0b0rUmVr9eYzPNPKK7BXe3GE3cIpjzuXE+X06vwu9DXyq7g
 h/+bQWI5K0T9UZ/TovfmEwYDE2N6wjlszbY2dQUD/IcXY9DvuslVcB2xbUNJuxexiEsv
 MkmbRC18tfP1MCGMB0PnD1ewYZrFDDLH4AEoWCxD5pZN+wYkZdgPLviLJHdJvncO1R6w
 GpGNsV0+WhK9OClWOvLz4tBIgamUbXrYvuveBfSZ8GP53opmRIhMQ8M9cqZv4mTSNVG5
 Fo2gZelM19CQ24hIssA7S6r/Nc+sFW2mfp4FPD7Z9GC9++QlKkNGzaNYP5ALyYwI9Lce
 ruWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1nidJn4TpMHPwHjg1Q8KqftSQN0wR/SmnvkXiE1Sje4=;
 b=FX9BqG5QuMgaFiYAeXkmhY0cx16qcKP4XdK4hNr17Pb91fBZ09joTtt7DtyRj2jSqX
 R+ziLFIalnpygF+fBtu/tO+G4K85OZsoLILEy/NUy6Fk5tgtWe5qUr1NIQmTKG9XR0u0
 4Sg22K/IIMPwUB11Wu5nZu2XUCrOyUdJ4AVdldaiEivSgz76u/IRTEeG6+rbqOJyt+y0
 vfYjH4UcsPgZEAAgHOrx0eevJAGyCoGid0JUHz10Jrt4yUid04FM5g/V1yameS4ZRR4k
 TRC/temDQ5H9bQjdDKigLvToovC+KLh+o/jFEhPX3DrgVhgwHmV98bQhmo+6UmC5tUi0
 R97A==
X-Gm-Message-State: APjAAAU94ViaQHld7GikSVZYN4OFgCLkX2nr0PqkZOHqKsXRqzuhlNzY
 o9OQyHSJPMpXwQ8EuG3XhEXllFPN3H3hh1BNwIk=
X-Google-Smtp-Source: APXvYqw6RtZyK3hvdBy7IZF8RFlr7p/RsdgJsdbtZhWH5VXIIXzCC3Pb5rio5JC23sBdQg9Dpn5C1lBM3ORwbX79SZU=
X-Received: by 2002:a9d:4711:: with SMTP id a17mr20509122otf.233.1580290256126; 
 Wed, 29 Jan 2020 01:30:56 -0800 (PST)
MIME-Version: 1.0
References: <CABLmASG93Fz-=XR45Z7pcaUkF8De3EdZbS_=901w_vhYUPiuXg@mail.gmail.com>
 <331cc94e-38d0-9259-337a-ce759ed8edba@linaro.org>
In-Reply-To: <331cc94e-38d0-9259-337a-ce759ed8edba@linaro.org>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Wed, 29 Jan 2020 10:30:45 +0100
Message-ID: <CABLmASFOU7j=OCMVT9df5irSRNSHKxXYXo3dWrODOyZZp=Xp6w@mail.gmail.com>
Subject: Re: Performance hit in qemu-system-ppc
To: Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc <qemu-ppc@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000005bc712059d43ff17"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
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
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005bc712059d43ff17
Content-Type: text/plain; charset="UTF-8"

On Tue, Jan 28, 2020 at 7:30 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 1/25/20 3:30 PM, Howard Spoelstra wrote:
> > I noticed a considerable (~20%) slowdown in the cpu performance of
> qemu-system-ppc.
>
> ENOINFO.
>
> For what test case?  This should not have been on any hot path.
>
>
Hi,
I tested Mac OS 9.2 and 10.3/4 with qemu-system-ppc built from 4.2 and
current master like this:

Command line:
./qemu-system-ppc -L pc-bios -boot c -M mac99,via=pmu -m 512 \
-serial stdio -sdl \
-hda 9.2.img (10.3.img|10.4.img)

Mac OS 9.2 MacBench 5.0 reports processor speed:
4.2: ~190%
Master: ~160%

Mac OSX 10.3.9 Skidmarks 4.0.1 test: specific drop in performance of
MPEG(INT) test:
4.2: 118%
Master: 100%

Mac OS 10.4.11 Skidmarks 4.0.1 test: specific drop in performance of
MPEG(INT) test:
4.2: 117%
Master: 99%

Best,
Howard

--0000000000005bc712059d43ff17
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 28, 2020 at 7:30 PM Richa=
rd Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org" target=3D"=
_blank">richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On 1/25/20 3:30 PM, Howard Spoelstra wr=
ote:<br>
&gt; I noticed a considerable (~20%) slowdown in the cpu performance of qem=
u-system-ppc.<br>
<br>
ENOINFO.<br>
<br>
For what test case?=C2=A0 This should not have been on any hot path.<br>
<br></blockquote><div><br></div><div>Hi, <br></div><div>I tested Mac OS 9.2=
 and 10.3/4 with qemu-system-ppc built from 4.2 and current master like thi=
s:<br><br>Command line:<br>./qemu-system-ppc -L pc-bios -boot c -M mac99,vi=
a=3Dpmu -m 512 \<br>-serial stdio -sdl \<br>-hda 9.2.img (10.3.img|10.4.img=
)<br><br>Mac OS 9.2 MacBench 5.0 reports processor speed:<br>4.2: ~190%<br>=
Master: ~160%<br><br>Mac OSX 10.3.9 Skidmarks 4.0.1 test: specific drop in =
performance of MPEG(INT) test:<br>4.2: 118% =C2=A0<br>Master: 100% <br><br>=
Mac OS 10.4.11 Skidmarks 4.0.1 test: specific drop in performance of MPEG(I=
NT) test:<br>4.2: 117%<br>Master: 99%</div><div><br> </div><div>Best,</div>=
<div>Howard<br></div></div></div>

--0000000000005bc712059d43ff17--


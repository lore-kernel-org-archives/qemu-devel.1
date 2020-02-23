Return-Path: <SRS0=CqNf=4L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE75C35671
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 14:18:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C676020637
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 14:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RO3ma/wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C676020637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5s5q-0004AR-Sj
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 09:18:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1j5s5D-0003TG-HS
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 09:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1j5s5C-0007Xg-2j
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 09:18:11 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:34886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>)
 id 1j5s5B-0007Wh-SB; Sun, 23 Feb 2020 09:18:10 -0500
Received: by mail-ot1-x335.google.com with SMTP id r16so6416591otd.2;
 Sun, 23 Feb 2020 06:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=if7wXQCWLEZc0WoR5XCVPOSRcIA6i4wWmZCqypawi3g=;
 b=RO3ma/wxzOD+zAnAGKuF53uJNm5dLdFeFChBYUWqjm3F8sHJnxaVE/hdYJ77q2QSqs
 r49bRfgozteFPWb08rgfm5LMvCsliC6dBbr4LI6wj8mKmjFsFpsmQO8tvD/rtiiEkI3I
 ipZJP9lyVRm8R7TU9NuTBvrsNHJpzXgW2qAGC1Q9z3uGZs08cTTD1AWXyH1KzeZB4jEj
 +S0pcY9OfOuor50oEr2O9AKLh85cgr6TbCDMhBcJKGS9pa+8jzcSjAw/7ioTsoX2I54L
 oWV+mKc23I8N2ZYKz7EYV3aHr92MHH8iH6NAZJd6eD7rCxDv6DCZ7LJLUJ/ITClRIHes
 TEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=if7wXQCWLEZc0WoR5XCVPOSRcIA6i4wWmZCqypawi3g=;
 b=SAmno2yWK3mNMQkw6Htvn1dJrIOMAJEFDjIPSgvxkBz3+JLy0R/2xS6SucPldzSKKp
 trsDJMsdB+7+yHn8ZhNV6sZqluXJ3+zLtPakIU3QEoqbrxKd2lQTjPJDsUrNho8ugkLC
 rKwLQxP26c66Cfy0ubw6LU1m6Be22DWf3Ml+BNptoPG7oV34qRMSnEJWVWnGRDLKr5Xh
 gxyhGDTykPlwaeBhGqdctsNQjvRzKpA4mygNmD7vK5OsdvBK6qhEtzZNoiqZy1zLDsoe
 p60djhNGlJqgQAvBef3SIeYfDEGXWZQQFYN+XY80KmlyLue+TjcPMBDYRoWLtX46X1Xa
 0rxQ==
X-Gm-Message-State: APjAAAXZscaHNVulWJWjgHLUTKh5FgMhqP3o1dY6e7TtNRpNsXRwy1Qt
 pg/CCHe8qFFf0sOUWS/Ah+92SDnx1cfe6jSWIro=
X-Google-Smtp-Source: APXvYqwGQvuMiUo/GbKxuLiH4Jhy4G8KHu731W6NCCNht3uECELxfz0QPkHypDFIN/FH2Wd9J4z3+xtX2eUv/DgRjco=
X-Received: by 2002:a05:6830:1e76:: with SMTP id
 m22mr32264787otr.295.1582467488204; 
 Sun, 23 Feb 2020 06:18:08 -0800 (PST)
MIME-Version: 1.0
References: <20200218012228.7336-1-programmingkidx@gmail.com>
 <CABLmASEMHLr=Q-7vVWcsHs0Yd9B4y7LOjgf_pwozb6soHuRZmw@mail.gmail.com>
 <C774280A-DB79-4C5B-816C-6E97816FDB78@gmail.com>
 <CABLmASGM+qu7QfNOgiFe7nK8+nNGJ=GqHi3tQUcHKq-jGwJu6g@mail.gmail.com>
In-Reply-To: <CABLmASGM+qu7QfNOgiFe7nK8+nNGJ=GqHi3tQUcHKq-jGwJu6g@mail.gmail.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Sun, 23 Feb 2020 15:17:56 +0100
Message-ID: <CABLmASHJXCw47UfAeHihTwxRd_CSH3S7TfdsoOV5yDWmcFfmDw@mail.gmail.com>
Subject: Re: [PATCH v4] Implement the Screamer sound chip for the mac99
 machine type
To: Programmingkid <programmingkidx@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000080cc11059f3eec43"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000080cc11059f3eec43
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 21, 2020 at 1:09 PM Howard Spoelstra <hsp.cat7@gmail.com> wrote:

>
>
> The current screamer-enabled builds for OSX and Windows are on
> www.emaculation.com ;-)
> As you see from testing, there are reasons why the patches from Mark's
> screamer branch are not in master yet, and these have not all been
> addressed. There still needs to be testing on Linux and certainly on
> Windows builds, and from what I mentioned above that might not be plain
> sailing.
> I guess I'll wait with providing new builds when the patches for both
> openbios and qemu are reviewed and in some repo from which I can build
> easily.
>
> Best,
> Howard
>

Hi,

There is indeed an issue when building your code for Windows.
Whereas the current screamer from Mark just plays sound, a build with your
patches will not.
I need to Ctrl-Alt-G to exit grab, click on the command (cmd.exe) window in
which the Qemu textual output is showing and then grab the mouse again to
get sound. A simple grab exit/grab cycle is not enough, a click somewhere
outside the Qemu window will also not do. Only a click to activate the
command window and then grab again. Happens with both GTK and SDL GUIs.

Command line is:
qemu-system-ppc-master-screamer-john-v4.exe -L pc-bios -boot c -m 256 -M
mac99,via=pmu ^
-drive file=C:\mac-disks\9.2.img ^
-sdl -serial stdio ^
-bios openbios-qemu-screamer-john-v2.elf

Took me ages to find this regularity ;-)

Best,
Howard

--00000000000080cc11059f3eec43
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 21, 2020 at 1:09 PM Howar=
d Spoelstra &lt;<a href=3D"mailto:hsp.cat7@gmail.com">hsp.cat7@gmail.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><di=
v dir=3D"ltr"><br><div class=3D"gmail_quote"><div><br></div><div>The curren=
t screamer-enabled builds for OSX and Windows are on <a href=3D"http://www.=
emaculation.com" target=3D"_blank">www.emaculation.com</a> ;-)</div><div>As=
 you see from testing, there are reasons why the patches from Mark&#39;s sc=
reamer branch are not in master yet, and these have not all been addressed.=
 There still needs to be testing on Linux and certainly on Windows builds, =
and from what I mentioned above that might not be plain sailing. <br></div>=
<div>I guess I&#39;ll wait with providing new builds when the patches for b=
oth openbios and qemu are reviewed and in some repo from which I can build =
easily. </div><div><br></div><div>Best,</div><div>Howard<br></div></div></d=
iv></blockquote><div><br></div><div>Hi,</div><div><br></div><div>There is i=
ndeed an issue when building your code for Windows.</div><div>Whereas the c=
urrent screamer from Mark just plays sound, a build with your patches will =
not.<br></div><div>I need to Ctrl-Alt-G to exit grab, click on the command =
(cmd.exe) window in which the Qemu textual output is showing and then grab =
the mouse again to get sound. A simple grab exit/grab cycle is not enough, =
a click somewhere outside the Qemu window will also not do. Only a click to=
 activate the command window and then grab again. Happens with both GTK and=
 SDL GUIs.<br></div><div><br></div><div>Command line is:</div><div>qemu-sys=
tem-ppc-master-screamer-john-v4.exe -L pc-bios -boot c -m 256 -M mac99,via=
=3Dpmu ^<br>-drive file=3DC:\mac-disks\9.2.img ^<br>-sdl -serial stdio ^<br=
>-bios openbios-qemu-screamer-john-v2.elf</div><div><br></div><div>Took me =
ages to find this regularity ;-)<br></div><div><br></div><div>Best,</div><d=
iv>Howard<br></div></div></div>

--00000000000080cc11059f3eec43--


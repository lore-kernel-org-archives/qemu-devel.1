Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D246AC35673
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 02:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1D120675
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 02:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+T/peYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1D120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j63ZO-0003Es-MP
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 21:34:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1j63Yl-0002mj-KI
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 21:33:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <programmingkidx@gmail.com>) id 1j63Yh-0006GO-Md
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 21:33:27 -0500
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:44162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
 id 1j63Yh-0006GB-Gu; Sun, 23 Feb 2020 21:33:23 -0500
Received: by mail-yb1-xb41.google.com with SMTP id g206so3036925ybg.11;
 Sun, 23 Feb 2020 18:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=XTEuM8fj8Thm04+R0CuYnwk7SGBHoex9G3swEchP81w=;
 b=K+T/peYj2w3YJvT52Nph3vrgRTnvbCde1PZ33zJ5YMgBb0Zf09FkjIEsIDYDP6axXx
 tswotq6kg3j7wKacS7aqOZnkBhqhw6+/ffByVW0xPX2hwR3THEk3bMu1o6r6ExjN8R6K
 S3qOcXQZXJZ8Zj4NpIHHZ3aCLpsWt1GCZkyZG4pbPSyoVaJn7StrYwvxURsZx0rxCGn1
 Wq9+DYo8EnNuFkpKHgG8FfYFWd3Hd2zv6t1mCWzifWwagtftjmMerZ8p/qvHDvtVAeoq
 XkOi5P+6JdTJf6OdtYk9oX5vswPrXkJQv2i2MiXKiJ9/udT9qUKCj5sQ/AFy7id6AXow
 LtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=XTEuM8fj8Thm04+R0CuYnwk7SGBHoex9G3swEchP81w=;
 b=FyNyNjGF+5svU26MN0L+MQ401zd8laj37hj/ItYQ8Asf30xMMyNgBHIP7MsJlf4jA/
 hElO9ym7XrXM2StR7piS0mD0vB44DFfS7H6aTpZ161PcJ3FDWZHf90xRwcbSNscNj737
 iwrA8NZyu+u9m56YKqoU6pkk3+GM2a8J+rWxON4/Kz+yPaxgzD7OGtAFOHMsKWsKM+Yg
 WdSMhi7SXKNfLYcs4pTRFBy6pO7TK/I+aAAgleWms3dQb0qF3JejT8oZ7THQ412n0P3J
 S6GTkDJtpEo/fpztmuN2YCUPs0vMphrFflei/m0vRgqM0zgYbMhlRoPxGuwVnGkjaXt0
 fmBw==
X-Gm-Message-State: APjAAAVQOwT/3ht8e9lyDmIwyN1zMYNBrb6oYG6ppXzA1VD/L7SPaBPS
 g4D3yGt7mpJ8G1tl9nyicO4=
X-Google-Smtp-Source: APXvYqwRyWqfhgaYbto9fY2v2o3kx6WdGU3WEU96atN9/sKvD/drPpJDPAhmKSoESggsuw65UHC9jQ==
X-Received: by 2002:a25:b9d0:: with SMTP id y16mr43971438ybj.378.1582511602505; 
 Sun, 23 Feb 2020 18:33:22 -0800 (PST)
Received: from [192.168.0.5] (d149-67-30-58.try.wideopenwest.com.
 [67.149.58.30])
 by smtp.gmail.com with ESMTPSA id g29sm4745341ywk.31.2020.02.23.18.33.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 23 Feb 2020 18:33:21 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v4] Implement the Screamer sound chip for the mac99
 machine type
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <CABLmASHJXCw47UfAeHihTwxRd_CSH3S7TfdsoOV5yDWmcFfmDw@mail.gmail.com>
Date: Sun, 23 Feb 2020 21:33:19 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <621CCF17-24BA-4F59-B38E-1E2E00DD0787@gmail.com>
References: <20200218012228.7336-1-programmingkidx@gmail.com>
 <CABLmASEMHLr=Q-7vVWcsHs0Yd9B4y7LOjgf_pwozb6soHuRZmw@mail.gmail.com>
 <C774280A-DB79-4C5B-816C-6E97816FDB78@gmail.com>
 <CABLmASGM+qu7QfNOgiFe7nK8+nNGJ=GqHi3tQUcHKq-jGwJu6g@mail.gmail.com>
 <CABLmASHJXCw47UfAeHihTwxRd_CSH3S7TfdsoOV5yDWmcFfmDw@mail.gmail.com>
To: Howard Spoelstra <hsp.cat7@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
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


> On Feb 23, 2020, at 9:17 AM, Howard Spoelstra <hsp.cat7@gmail.com> =
wrote:
>=20
>=20
>=20
> On Fri, Feb 21, 2020 at 1:09 PM Howard Spoelstra <hsp.cat7@gmail.com> =
wrote:
>=20
>=20
> The current screamer-enabled builds for OSX and Windows are on =
www.emaculation.com ;-)
> As you see from testing, there are reasons why the patches from Mark's =
screamer branch are not in master yet, and these have not all been =
addressed. There still needs to be testing on Linux and certainly on =
Windows builds, and from what I mentioned above that might not be plain =
sailing.=20
> I guess I'll wait with providing new builds when the patches for both =
openbios and qemu are reviewed and in some repo from which I can build =
easily.
>=20
> Best,
> Howard
>=20
> Hi,
>=20
> There is indeed an issue when building your code for Windows.
> Whereas the current screamer from Mark just plays sound, a build with =
your patches will not.
> I need to Ctrl-Alt-G to exit grab, click on the command (cmd.exe) =
window in which the Qemu textual output is showing and then grab the =
mouse again to get sound. A simple grab exit/grab cycle is not enough, a =
click somewhere outside the Qemu window will also not do. Only a click =
to activate the command window and then grab again. Happens with both =
GTK and SDL GUIs.
>=20
> Command line is:
> qemu-system-ppc-master-screamer-john-v4.exe -L pc-bios -boot c -m 256 =
-M mac99,via=3Dpmu ^
> -drive file=3DC:\mac-disks\9.2.img ^
> -sdl -serial stdio ^
> -bios openbios-qemu-screamer-john-v2.elf
>=20
> Took me ages to find this regularity ;-)
>=20
> Best,
> Howard

Thank you very much for catching this problem. Could you send me your =
Windows binary of QEMU that uses my patch. I would like to see if I can =
reproduce the problem on my computer.=20=


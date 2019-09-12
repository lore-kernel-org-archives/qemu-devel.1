Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8360C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E3420693
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hKMJ26ye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E3420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8NWF-0006Tt-FO
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 07:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8NTj-0004in-BJ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8NTe-0000CX-Vr
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:41:34 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:52651)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8NTd-0000Bh-3B
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:41:30 -0400
Received: by mail-wm1-x330.google.com with SMTP id x2so1780405wmj.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 04:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=/NwkzWfPZgfq0Bqf0mBxPSl/Xw9KJk0rkb+vY/zMOQk=;
 b=hKMJ26yeuLTImXxyD8brFshwFTL8Ho9k+6W8gs4EtLo575dNqq8lOhvcFi0ciP4wDN
 OF932QzoON2JPdV2VOu8h85x0WoYuW5qJPTot32FoeSGmN4R6M5/NISBZZdh0g/Z1wSL
 P06/cpXZayEYj+9GfYBkmGTQMrUgtNFdq/QMoLl0zZT70V9/UdiYUgECAGxCatkLn0bZ
 87MGVG0laXP671IB/LT+tNeJtGTY+le63tCAveKV1nitWU4gX9IVQ6dTQh8DcIyG1EmR
 SdHvk69MVnGTyV7qPL6BK3Bf8PKcj1pN8rjm8bShbCWJvNrawjkGXaXyceGV6gVusDuB
 wBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=/NwkzWfPZgfq0Bqf0mBxPSl/Xw9KJk0rkb+vY/zMOQk=;
 b=HNhsZHNzPSDXuAJpUJlBlGJOBsUqiNUTRBrIccyyN2XtTEstBD4f0A1QfTe4mmfDbQ
 7fJMwaAz/cwvH4oYCYFlCPhSdwjWiQllj8a/KHD5a5pgSNj7cjvPZubDIjPpJkG9+P06
 gheKHOK2+sUe/ZoqNmn14Md2WIcVdOIXZVciGR5KAjzV2gfPZSrUdmxylfpWoGlmFF26
 nPPxQFVagK85645QdwMF50jsxhbKY6jFEufG6z3eoblGlx4GRvOxi8DontvHP91mVLB7
 T7uZvaIWvaAV53OgrHJ87iP3/1YTB9dY6hw9ObyQh78RS2BJqnLKcod/3KSac4lec3E3
 QmRw==
X-Gm-Message-State: APjAAAVTy2tOuJ4oYcX96dtifO+WcXzSu+P5++H5o8PvIGA4hY2GiPw2
 /bEU0vm9+oZzlUNRS98lRS5+Ig==
X-Google-Smtp-Source: APXvYqzeEqBWg34yRD1UNzw08vnlKQhGrGf6FZBAcL/OrOUNbwnPdEj0S3iFUUZcBvxkgOx/WTSTBg==
X-Received: by 2002:a1c:7513:: with SMTP id o19mr7800350wmc.126.1568288487047; 
 Thu, 12 Sep 2019 04:41:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 33sm27615229wra.41.2019.09.12.04.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 04:41:26 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 82D921FF87;
 Thu, 12 Sep 2019 12:41:25 +0100 (BST)
References: <tencent_3156C5EA2695B7CD53C6114C@qq.com>
 <CAL1e-=hWOXgnTbC0Y2v_CMZOMmQLgdToBAsi+XaW7+9uyN55CA@mail.gmail.com>
 <tencent_23ACCA1A48AFB09124C52E70@qq.com> <87blvy99y9.fsf@linaro.org>
 <tencent_0E8715864EBBAA153BB730E2@qq.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Libo Zhou <zhlb29@foxmail.com>
In-reply-to: <tencent_0E8715864EBBAA153BB730E2@qq.com>
Date: Thu, 12 Sep 2019 12:41:25 +0100
Message-ID: <87h85hzqqi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
Subject: Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
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
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Libo Zhou <zhlb29@foxmail.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>
>> The gdbstub should allow you do full introspection and adding
>> additional registers is fairly easy, see mips_cpu_gdb_read_register func=
tion
>> in  target/mips/gdbstub.c.
>
>
>
> Hi Alex and Aleksandar,
>
>
> Now I can connect gdb to qemu successfully. And I can use this command
> to show all the register contents in a gdb session.

You will need to update gdb-xml/$ARCH.xml and the appropriate
arch_read/write register functions in gdbstub.

Alternatively look at commits:

  commit 200bf5b7ffea635079cc05fdfb363372b9544ce7
  Author: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
  commit 9c513e786d85cc58b8ba56a482566f759e0835b6
  Author: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
  commit 1f16378718fa87d63f70d0797f4546a88d8e3dd7
  Author: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>

Where Abdallah added a dynamic xml generation to expose all the ARM
system registers to gdbstub. The details may be different for the MIPS
backend but from the gdbstub point of view its the same. Provide a
system description in xml and the arch specific helpers to get and set
the values.

>
>
> (gdb) layout regs
>
>
> However, I will need to add some more registers to the CPU. Does adding n=
ew registers in gdbstub.c also show the new registers in the TUI?
> I doubt it because when I modified the regnames[] in translate.c, the reg=
isters' names didn't change in gdb.
>
>
>
> Cheers,
> Libo
>
>
>
>> Alex Benn=C3=A9e


--
Alex Benn=C3=A9e


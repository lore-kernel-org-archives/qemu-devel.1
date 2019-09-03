Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43945C3A5A5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 09:46:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18B9206BB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 09:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDlyWg1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18B9206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i55Nu-000321-HZ
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 05:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i55Ms-00026r-Sa
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i55Mr-0004pL-Rj
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:44:54 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:40208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i55Mr-0004p7-Mn
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:44:53 -0400
Received: by mail-oi1-x22c.google.com with SMTP id b80so5384943oii.7
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 02:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Gt+Klj498QmKd81rjkNr809+nWdH3KIcyWRKsiTLkek=;
 b=FDlyWg1icsDzqzRO3pY+mH+yqPXRVGk4nd7wXUwfkLVGJywY2NV+9vpPxZC+54c7vs
 jTfuBU1/cU/+axFevLqqWppqlRbtm7nz8WAoF3GSIzphExu/0FOmUjB+7+ojJHygcaGD
 2B8nysZUEWYI/EAwg7d3H1ieanwZ0/tnmIjyetyWYkPgAN75A94dN2R/C1AA1rtszVhU
 3K/6NHHo2islaaFxtn1NWtexP/u6bQoKXej95RKou2oA1UNF+oPQNTJWgH7VWCAAPWr+
 A8jOOmjvrgHo1XJstUtBFx+YXEZzDO8dO9uIgar1nMWDCGWTjyCtUyXDVHFnMhfjwnpw
 UM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Gt+Klj498QmKd81rjkNr809+nWdH3KIcyWRKsiTLkek=;
 b=h1xraFAuDT75avoFwscCfOgnvbfb/lO94VIW+HKhNAgUtmF/sxA6YitjXN82n2/PPx
 vPKRkMc+nifLF+EekaVEhWyvJwoxANNNZ9d7vjALyiQyifDU+PzJeAd2vSLJoriwOnhN
 2/9vf2e2JcYs0XD5zLoBt8p/PFq7kgNreBspVg07lXyErPvMntIj6FJKybE8cfl2fph5
 jsI1XLsBBJhl9fedhjV9qcKOCglyg191+wfmbZOCTr/iErkckrd+dRmJtjgtjXcne9SI
 BGk1Mb7Fm9TNFd2S7jnj5X9HzTZ5fdj8RGNHnl1AzmTnnc0YSe1XPyixJLP17SY+lFBL
 BJIA==
X-Gm-Message-State: APjAAAU0S1HnzSwOSZfAOvQhpiAd3EMwbkXkDxNps0ZnimiL3QhblGrf
 3UbtYk9gaPJFKqDVMcJk1oGGQ8vS4XAvCrzD+Q4=
X-Google-Smtp-Source: APXvYqw+YbAK6tdmb/PaRo40NdgpJnxHeapQPeiWhHxk2arRqCDj6LoYk0EdnNDQE2lXnx3NheO6XN4b2rdnuULLsh4=
X-Received: by 2002:aca:7291:: with SMTP id p139mr6737118oic.53.1567503892835; 
 Tue, 03 Sep 2019 02:44:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP;
 Tue, 3 Sep 2019 02:44:52 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP;
 Tue, 3 Sep 2019 02:44:52 -0700 (PDT)
In-Reply-To: <CAL1e-=jAnpxiQgXG3jY00d7shxv-evXUPg_YztficjQ=0U18Xg@mail.gmail.com>
References: <tencent_61024D4F136E131E2B085A7DACEA1593D007@qq.com>
 <CAL1e-=jAnpxiQgXG3jY00d7shxv-evXUPg_YztficjQ=0U18Xg@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 3 Sep 2019 11:44:52 +0200
Message-ID: <CAL1e-=icFw_0P04X4fzCROD-Wt=fH=QLV7cFCbY0A0x_+-Gx9w@mail.gmail.com>
To: Libo Zhou <zhlb29@foxmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] Uncaught target signal 11 (Segmentation Faullt)
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.09.2019. 18.08, "Aleksandar Markovic" <aleksandar.m.mail@gmail.com> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
>
> 02.09.2019. 06.17, "Libo Zhou" <zhlb29@foxmail.com> =D1=98=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > I am trying to run a simple MIPS program with QEMU user mode.
> >
> >
> >
> > Host: Ubuntu 18.04 LTS on x86_64
> > QEMU config: ../configure --target-list=3Dmips-linux-user
> >
> > Cross Compiler: sudo apt install gcc-mips-linux-gnu
> >
> >
> > My test.c is simple: int main(void) {int a =3D 1; int b =3D2; int c; c =
=3D a
+ b; return 0;}
> > After compiling it with "mips-linux-gnu-gcc test.c -o test", I ran it
with "./qemu-mips -L /usr/mips-linux-gnu test", then I got the following
error message:
> > qemu: uncaught target signal 11 (Segmentation fault) - core dumped
> >
> >
> > Does anyone have a solution to this? Thank you in advance.
> >
>
> Hi, Libo.
>
> Please try this:
>
> cd /usr/mips-linux-gnu
> sudo mkdir etc
> sudo ldconfig -c etc/ld.do.cache -r .
>
> ... and start qemu as you described.
>

Or, unless you really need dynamicly linked executables, compile with
"-static", and you will never need "-L" QEMU switch, and will never have
the problem you described.

> Sincerely,
> Aleksandar
>
> >
> > Cheers,
> > Libo

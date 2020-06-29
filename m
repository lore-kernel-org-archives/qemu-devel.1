Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF32BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 20:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B162120656
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 20:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kuXOXSJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B162120656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq0P6-0002Ra-Qp
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 16:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdenber@gmx.com>) id 1jq0Li-0008JE-My
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 16:25:54 -0400
Received: from mout.gmx.net ([212.227.15.15]:40143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdenber@gmx.com>) id 1jq0Lg-00038X-93
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 16:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1593462345;
 bh=Y2pYV1UNQxkJcE8T1u5CPk0I4HSm2BPsILx6ihMGB2c=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=kuXOXSJZ9/Mpj2ecd6UygR57s9mkTyOkw/4aHae7ODajjgfW84xg0feiotGGgQ0Gs
 Agy+kt9iMw5vZshKuE0gk2olqYQI4dWB2Zuqbn/NrZh+UPYW3moHVNP4ZTgB232mLl
 Q+dub10SJLfdwaygMiykBL51FpIhPHLRRH+qZpBE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.5] ([8.9.81.230]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MIdiZ-1jeEFo26HF-00EfXx; Mon, 29
 Jun 2020 22:25:45 +0200
Subject: Re: Building in Solaris 11.4
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <5EF3C648.4060506@gmx.com> <5EF772B6.2010901@gmx.com>
 <fcdd4b6c-eec5-2bfd-1004-8ac86e80bf0e@redhat.com>
From: Michele Denber <mdenber@gmx.com>
Message-ID: <5EFA4E46.3090101@gmx.com>
Date: Mon, 29 Jun 2020 16:25:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <fcdd4b6c-eec5-2bfd-1004-8ac86e80bf0e@redhat.com>
Content-Type: multipart/alternative;
 boundary="------------010600080603070107020204"
X-Provags-ID: V03:K1:ueCjlcZgfaKZ7vHLcH+3mdS7y5IgXpUL3Fp4DlLSfxZNSZOVF7E
 lNY7uxW5k1aij+Vvz4H7m5rIp0XHOmPxLArNxsTuimQd4k8m8568bjAYhHquSpg4xTMf1wS
 0e2Wj+PuYOwXO1s9UmpnnwE0WL1kxTrxE78FXsmHxWVzTO8m6wX5JV4KH3qxGT4zFIzYSOM
 OJd721w03C6emGPmYopzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h7F4d9Yh8aE=:50PfPEvwQvVWpj4sDDSJki
 8WpdfQ1hyeFfbjOleE+JRZO3Ab9+4UAoR6IqLg5Q9evmLeenYRbTFB5EWn70em1oZDvTujqkB
 hkui2UZyxOQ4Bn9KiMPtgSrjyyFSoEJA45VUo4BgNdw7hvTBwrsuXBR6sc4tprDDUZsY63P6N
 CYd/X9miMvDsx+9uEmeb0xuLZNm0yQnN/XcbXeWsvTgAe7L25j5p2pcZR9WzBvkSVTWoYFoeW
 oY9/PT+mly7seS1X4Nojfp5QGKINGoMNvTg6opN86JOOnDr5eRFa3UoLxp768coD3cLAo8vaM
 wXXLHFn6s9c1q8M2lzHoVRN65b1eXD7CiyOAo7MmsvFudBJDf5lAQFvUCJowfKIeW3A8dlU+5
 rhoNs300ZaV73PRQaoDny3FFLK8uEa5dD2u3uqsSS3dKgegGNIt8hv6asLpRJp3qvLsh78Uji
 5mHNW0qhQO8jR07Yaja86q16LED7QTwSDKwZs7b1W2CSBSFdPZN0aHogfzr4Ah7/2Gdj0UgZe
 72fKqydv/uxfBKyMD2s8pBrR+7MLzBSrOD9HiWIwqjffyeU63WQh/897OJGFdM5pZbZmqoZQx
 ww1a5A+3WhwSVMGHr0M7KueSXIjoYBajCjd3JJHmxIBQBMMAHPZ5Rz0h5Yopj8dVnOpc2IcAs
 3cNqcZUo1ZopZS8C/Nc9CY9L/sLWdWVd8+Pky60UV3WajXfcvLdqRvDL+aOo+aw9BIrisNxQ7
 /ovkKvh+jFqyUWC1tde06W68DyKDDIJcX9x3qJrkTIMQAnrstFYe71lOzf9v2aPYDFHFzRjcC
 kWomViOlzFTIMW5LCAcdMhmBUE/dMCadZiMKmHY9vse9OsQJAm2Q4XT7reEAlsBK1VEyobJlq
 lOdtgv5WQGB1iZtyGh0380aghkI5wM+yZy9f8DHoV9beHIr4Gx3jAhdtO0S4f8bOokNAXEZmI
 twbPlWV20Ti2xGoVOhCTfPD7nhv4m46XMVX3thqb9XuyLg2Da0WRs3xpu8Jh4Dz1kEi3X7qGA
 O9y8jNgbIqO6kR1hcxM/nD6f7a6qRjzZMQpCBkcRoCZLR0zdr3UQeP0YdDQRFmso52oL8TStU
 4yQZDvhVUCV8HQtB5+2/q5A83915Fr+m1iz7z1cTU5XAueF6McUIS1PUynwFf5xknt7uN9Dr8
 LwWeCSvX4NNwjQRS6HfaLf0RaOlhGBhMRh1/E/mul449QUcHDrAzvx+YjAUg3M0xnzctzb/ql
 ZjzkMmgxFcf2SjCCY
Received-SPF: pass client-ip=212.227.15.15; envelope-from=mdenber@gmx.com;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 16:25:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Peter Tribble <peter.tribble@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------010600080603070107020204
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 06-29-2020 8:12 AM, Thomas Huth wrote:
> ...
> It's not the same bug as last year, but a new one: Seems like newer
> versions of Solaris now have this functions in their libraries!
Yes - I just checked. Solaris 10 does not have openpty, but Solaris 11.4
indeed does have it
> So what you want is something like this (completely untested):

So just to make sure I have this right - I save that code into a patch
file and then apply it where?  At the qemu-5.0.0 level?  Then run
configure again?

Right now I'm looking at that "struct dirent" problem in gmake I
mentioned a few days ago.  I will try the Haiku patch offered by PMM.

             - MIchele


--------------010600080603070107020204
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div class=3D"moz-cite-prefix">On 06-29-2020 8:12 AM, Thomas Huth
      wrote:<br>
    </div>
    <blockquote
      cite=3D"mid:fcdd4b6c-eec5-2bfd-1004-8ac86e80bf0e@redhat.com"
      type=3D"cite">...<br>
      It's not the same bug as last year, but a new one: Seems like
      newer versions of Solaris now have this functions in their
      libraries!</blockquote>
    Yes - <font face=3D"Times New Roman, Times, serif">I just checked.=C2=
=A0
      Solaris 10 does not have openpty, but Solaris 11.4 indeed does
      have it<br>
    </font>
    <blockquote
      cite=3D"mid:fcdd4b6c-eec5-2bfd-1004-8ac86e80bf0e@redhat.com"
      type=3D"cite"> So what you want is something like this (completely
      untested):
      <br>
    </blockquote>
    <br>
    So just to make sure I have this right - I save that code into a
    patch file and then apply it where?=C2=A0 At the qemu-5.0.0 level?=C2=
=A0 Then
    run configure again?<br>
    <br>
    Right now I'm looking at that "struct dirent" problem in gmake I
    mentioned a few days ago.=C2=A0 I will try the Haiku patch offered by=

    PMM.<br>
    <br>
    =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 - MIchele<br=
>
    <br>
  </body>
</html>

--------------010600080603070107020204--


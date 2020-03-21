Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB304C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 05:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B999B20714
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 05:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B999B20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fam-schranz.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFWWu-0000qT-3T
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 01:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <holger@fam-schranz.de>) id 1jFWWK-0000RT-IL
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 01:18:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <holger@fam-schranz.de>) id 1jFWWJ-0005JT-Am
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 01:18:04 -0400
Received: from smtp2.goneo.de ([85.220.129.33]:50762)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <holger@fam-schranz.de>)
 id 1jFWWJ-0005JC-1y
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 01:18:03 -0400
Received: from localhost (localhost [127.0.0.1])
 by smtp2.goneo.de (Postfix) with ESMTP id 5CA7424144A;
 Sat, 21 Mar 2020 06:18:00 +0100 (CET)
X-Virus-Scanned: by goneo
Received: from smtp2.goneo.de ([127.0.0.1])
 by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AyK6inMzzxQQ; Sat, 21 Mar 2020 06:17:59 +0100 (CET)
Received: from famserver.fritz.box (p5B2A9B11.dip0.t-ipconnect.de
 [91.42.155.17])
 by smtp2.goneo.de (Postfix) with ESMTPSA id 22C072414C9;
 Sat, 21 Mar 2020 06:17:59 +0100 (CET)
Subject: Re: Qemu on Windows 10 - no acceleration found
To: Jerry Geis <jerry.geis@gmail.com>, Stefan Weil <sw@weilnetz.de>
References: <CABr8-B4RQo3OT6ogt7J=OWGhOpD6LqHt9zkp7dZTmqifiPCtyA@mail.gmail.com>
 <f51c571b-5eda-7837-36bb-9dfd3be39eb9@weilnetz.de>
 <CABr8-B5fCLfLk39f9s-4TyV+0iQbqHborKyV_SR1PsdCHXRNkg@mail.gmail.com>
From: Holger Schranz <holger@fam-schranz.de>
Message-ID: <a08ac331-3aab-b1d5-b5a8-0f9863b37cb8@fam-schranz.de>
Date: Sat, 21 Mar 2020 06:17:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CABr8-B5fCLfLk39f9s-4TyV+0iQbqHborKyV_SR1PsdCHXRNkg@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------99F0D13C9624EF4AB571490D"
Content-Language: de-DE
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 85.220.129.33
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------99F0D13C9624EF4AB571490D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Jerry,

have you read the instructtions on Intel:

https://github.com/intel/haxm/wiki/Installation-Instructions-on-Windows

May be this helps you

Best regards

Holger

Am 20.03.20 um 21:22 schrieb Jerry Geis:
> So I tried --enable-whpx and I get Invalid option. Im on=C2=A0Windows 1=
0=20
> and QEMU 4.2.0
>
> I'm confused.=C2=A0 Then I don't know where to download the HAXM. The p=
lace=20
> I found is GIT and it wants the user to compile it. I was looking for=20
> just an EXE.
>
> Thanks
>
> Jerry

--------------99F0D13C9624EF4AB571490D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <font size=3D"+1"><tt>Hi Jerry,</tt><tt><br>
      </tt><tt><br>
      </tt><tt>have you read the instructtions on Intel:</tt><tt><br>
      </tt><tt><br>
      </tt><tt><a class=3D"moz-txt-link-freetext" href=3D"https://github.=
com/intel/haxm/wiki/Installation-Instructions-on-Windows">https://github.=
com/intel/haxm/wiki/Installation-Instructions-on-Windows</a></tt><tt><br>
      </tt><tt><br>
      </tt><tt>May be this helps you</tt><tt><br>
      </tt><tt><br>
      </tt><tt>Best regards</tt><tt><br>
      </tt><tt><br>
      </tt><tt>Holger</tt><tt><br>
      </tt></font>
    <div class=3D"moz-cite-prefix"><font size=3D"+1"><tt><br>
          Am 20.03.20 um 21:22 schrieb Jerry Geis:</tt><tt><br>
        </tt></font></div>
    <blockquote type=3D"cite"
cite=3D"mid:CABr8-B5fCLfLk39f9s-4TyV+0iQbqHborKyV_SR1PsdCHXRNkg@mail.gmai=
l.com"><font
        size=3D"+1"><tt>
        </tt></font>
      <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DU=
TF-8">
      <div dir=3D"ltr">So I tried --enable-whpx and I get Invalid option.
        Im on=C2=A0Windows 10 and QEMU 4.2.0
        <div><br>
        </div>
        <div>I'm confused.=C2=A0 Then I don't know where to download the
          HAXM. The place I found is GIT and it wants the user to
          compile it. I was looking for just an EXE.</div>
        <div><br>
        </div>
        <div>Thanks</div>
        <div><br>
        </div>
        <div>Jerry</div>
      </div>
    </blockquote>
  </body>
</html>

--------------99F0D13C9624EF4AB571490D--


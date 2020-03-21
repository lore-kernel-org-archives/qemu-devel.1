Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76907C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 05:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A89120739
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 05:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A89120739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fam-schranz.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFWlN-0003Uk-El
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 01:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <holger@fam-schranz.de>) id 1jFWkh-00035o-GP
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 01:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <holger@fam-schranz.de>) id 1jFWkf-0001bv-M3
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 01:32:55 -0400
Received: from smtp3-1.goneo.de ([85.220.129.38]:59892)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <holger@fam-schranz.de>)
 id 1jFWkf-0001Xi-8p
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 01:32:53 -0400
Received: from localhost (localhost [127.0.0.1])
 by smtp3.goneo.de (Postfix) with ESMTP id 2E89A2402A1;
 Sat, 21 Mar 2020 06:32:51 +0100 (CET)
X-Virus-Scanned: by goneo
Received: from smtp3.goneo.de ([127.0.0.1])
 by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jRAmUdREa_R4; Sat, 21 Mar 2020 06:32:49 +0100 (CET)
Received: from famserver.fritz.box (p5B2A9B11.dip0.t-ipconnect.de
 [91.42.155.17])
 by smtp3.goneo.de (Postfix) with ESMTPSA id 5264A24003B;
 Sat, 21 Mar 2020 06:32:49 +0100 (CET)
Subject: Re: Qemu on Windows 10 - no acceleration found
From: Holger Schranz <holger@fam-schranz.de>
To: Jerry Geis <jerry.geis@gmail.com>, Stefan Weil <sw@weilnetz.de>
References: <CABr8-B4RQo3OT6ogt7J=OWGhOpD6LqHt9zkp7dZTmqifiPCtyA@mail.gmail.com>
 <f51c571b-5eda-7837-36bb-9dfd3be39eb9@weilnetz.de>
 <CABr8-B5fCLfLk39f9s-4TyV+0iQbqHborKyV_SR1PsdCHXRNkg@mail.gmail.com>
 <a08ac331-3aab-b1d5-b5a8-0f9863b37cb8@fam-schranz.de>
Message-ID: <75c39dc1-fbaf-ee08-a7e1-7b7193af8617@fam-schranz.de>
Date: Sat, 21 Mar 2020 06:32:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a08ac331-3aab-b1d5-b5a8-0f9863b37cb8@fam-schranz.de>
Content-Type: multipart/alternative;
 boundary="------------13FCB998C10EDC49B3739D50"
Content-Language: de-DE
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 85.220.129.38
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
--------------13FCB998C10EDC49B3739D50
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

... To early in the morning ...

It is on GitHub...

on Github:
https://github.com/intel/haxm/releases/tag/v7.5.6

others:
https://www.softpedia.com/get/Programming/Other-Programming-Files/Intel-H=
ardware-Accelerated-Execution-Manager.shtml
https://www.filecroco.com/download-intel-hardware-accelerated-execution-m=
anager/

Best regards

Holger

Am 21.03.20 um 06:17 schrieb Holger Schranz:
> Hi Jerry,
>
> have you read the instructtions on Intel:
>
> https://github.com/intel/haxm/wiki/Installation-Instructions-on-Windows
>
> May be this helps you
>
> Best regards
>
> Holger
>
> Am 20.03.20 um 21:22 schrieb Jerry Geis:
>> So I tried --enable-whpx and I get Invalid option. Im on=C2=A0Windows =
10=20
>> and QEMU 4.2.0
>>
>> I'm confused.=C2=A0 Then I don't know where to download the HAXM. The=20
>> place I found is GIT and it wants the user to compile it. I was=20
>> looking for just an EXE.
>>
>> Thanks
>>
>> Jerry

--------------13FCB998C10EDC49B3739D50
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <tt>... To early in the morning ... <br>
      <br>
      It is on GitHub...<br>
      <br>
      on Github:<br>
      <a class=3D"moz-txt-link-freetext" href=3D"https://github.com/intel=
/haxm/releases/tag/v7.5.6">https://github.com/intel/haxm/releases/tag/v7.=
5.6</a><br>
      <br>
      others:<br>
<a class=3D"moz-txt-link-freetext" href=3D"https://www.softpedia.com/get/=
Programming/Other-Programming-Files/Intel-Hardware-Accelerated-Execution-=
Manager.shtml">https://www.softpedia.com/get/Programming/Other-Programmin=
g-Files/Intel-Hardware-Accelerated-Execution-Manager.shtml</a><br>
<a class=3D"moz-txt-link-freetext" href=3D"https://www.filecroco.com/down=
load-intel-hardware-accelerated-execution-manager/">https://www.filecroco=
.com/download-intel-hardware-accelerated-execution-manager/</a><br>
      <br>
      Best regards<br>
      <br>
      Holger<br>
    </tt><br>
    <div class=3D"moz-cite-prefix">Am 21.03.20 um 06:17 schrieb Holger
      Schranz:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:a08ac331-3aab-b1d5-b5a8-0f9863b37cb8@fam-schranz.de">
      <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DU=
TF-8">
      <font size=3D"+1"><tt>Hi Jerry,</tt><tt><br>
        </tt><tt><br>
        </tt><tt>have you read the instructtions on Intel:</tt><tt><br>
        </tt><tt><br>
        </tt><tt><a class=3D"moz-txt-link-freetext"
href=3D"https://github.com/intel/haxm/wiki/Installation-Instructions-on-W=
indows"
            moz-do-not-send=3D"true">https://github.com/intel/haxm/wiki/I=
nstallation-Instructions-on-Windows</a></tt><tt><br>
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
          size=3D"+1"><tt> </tt></font>
        <meta http-equiv=3D"content-type" content=3D"text/html;
          charset=3DUTF-8">
        <div dir=3D"ltr">So I tried --enable-whpx and I get Invalid
          option. Im on=C2=A0Windows 10 and QEMU 4.2.0
          <div><br>
          </div>
          <div>I'm confused.=C2=A0 Then I don't know where to download th=
e
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
    </blockquote>
  </body>
</html>

--------------13FCB998C10EDC49B3739D50--


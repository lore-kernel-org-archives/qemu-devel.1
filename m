Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_FONT_FACE_BAD,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C096C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 16:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0470520724
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 16:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ANLpNF6L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0470520724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpDgC-00065u-1J
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 12:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdenber@gmx.com>) id 1jpDd1-0005Km-Hm
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 12:24:31 -0400
Received: from mout.gmx.net ([212.227.15.19]:33027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdenber@gmx.com>) id 1jpDcx-0000dw-9J
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 12:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1593275064;
 bh=gPMQU9Q+/7ZznWw3jFr3bzYzrwrcEfwmaI1izMK5aus=;
 h=X-UI-Sender-Class:Date:From:To:Subject:References:In-Reply-To;
 b=ANLpNF6L0jtN6SLzlQvc2QQRbiRTwOuDBmHoy+HQi+itE9/aIErTKGk4UWcneo7zi
 KMt9h7Ohy5faRj/cTVeMHApUCkeY/mo4OTF0XXf+m9UekZRKLG7DLtaJ9B0UV3KMEm
 3Bi66txcZBdYGNPQ6t8jcd9Y6tLvg+VV0KFI6VvE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.78] ([8.9.81.230]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEV3I-1jdclR3oR0-00G1WA for
 <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 18:24:24 +0200
Message-ID: <5EF772B6.2010901@gmx.com>
Date: Sat, 27 Jun 2020 12:24:22 -0400
From: Michele Denber <mdenber@gmx.com>
User-Agent: Mozilla/5.0 (X11; SunOS sun4v;
 rv:10.0.7) Gecko/20121005 Thunderbird/10.0.7
MIME-Version: 1.0
To: qemu-devel@nongnu.org
Subject: Re: Building in Solaris 11.4
References: <5EF3C648.4060506@gmx.com>
In-Reply-To: <5EF3C648.4060506@gmx.com>
Content-Type: multipart/alternative;
 boundary="------------090901000407080401030805"
X-Provags-ID: V03:K1:6toK1WQcg6Bc5rq2xDBlFIJtc8WhL9SHa5qvHdZfgAjc+BColo6
 iMRJSGl2VSdQm96tOof/g/bHjREohnnFyrnTgUMT/SWyzzwLzkmAfrL5s8KEirdG0ZKR/mL
 ClluVpcv+7YoxoYKOHuNSwGuSTB3yUdVWoDR9Mv8aDl3hmkGKKOygOjxzs0Qk9hHqcnsLhn
 Ez5bgOGbTTfV9ZXBWRmTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uQHzYSa8Yqs=:xo1czQZS8OTDE8Y5sJaaTh
 RNFlk7S2jipH2OKKGCMRM5eI3F7G8iV3HExn+Dx2tWW12rCxBNoIAMyD6wZ8nBi0wV/MHQAaS
 mnXYDV9QPWRJtLcWSjAYV4UbeXEZ7bN6pucalf3vo3VAbKY29JPYh7F/nKAOobTEZTRFUaPjj
 xGmefrhR6B1cIY0g2mBIdAUnT9EcT67P/gykujlXspJzvFXau89RYcuNmbyQcjsYlTD0cBQND
 swcMZoGJtQF/AoY7zeEDIt5gUfAS4u4li9SX5UHjGzKq6rsbFg8F81lyGnIzMyBr9WXGprPTL
 c2GXNfB8EinoVrDrgqyIa6vLx4gMbDz0b+7A2YCCjaCtoEtcXcNskmuwrjJ43EtKH/Ke6jOzF
 knVzH9y5y3izUzZT5B2izFtQ210U0t6v9kbH82UjRtDaVRs124zIahpV1GkYgKUaUnZUWzS9j
 J6DalMOeJz+6LygWMI/GRNEZ5IdN5loZspu7Lm1Fq2iGm3ptUlvXeuZljZCvHnYYhgQHPkoSJ
 HzV0MEW9rBQ80d0Hz/3X3s2Rm3Ula/MiI4QNV/iUvYakw4XZwbu92uWepJvSLNbQGTYRnzxlT
 l2b9W0y/eyh5GEl8Ra1BXHLWXkiB3hN7Bh9pOKVBMTsIn6FR98xWJRLHw36TtiB6znYqy+YLs
 eVIrSTv855hQPFWme2w+4JFgTpF8n21qIOn9ocnCfnYO4BII3QPCbISxY0ZPfI1x2H7EHh328
 ciRVtZmdV+yKLb5wzKp5uvKvpCPzxIJQrdFTh7vwJiSfxk26q82lqS6rmoP3maHnFRGVLSYpY
 zG2EenM4TpKls6aa1hGOrXYhnIu31g62zKOLLsbUaa6sVmOnuD18cwx9f5Gg5pH2wY7izV00j
 4eS1g5pWS9N3VqADtEzpTTsI/KFncltSQ08Q0rxKCaw7xZg/81n0BHSkbBCx/QLbg3/g0U0+w
 +gEX+uGNlPL8Mex3+2XrL0AviJtB6M4LUr5KuRlbZdxAL7+U+vnDtpgcv/WBOjl+y+bANyfGO
 97qN6ulo5iKPkNNLbeYJITV3jOYpO/8A6KK1ZWW46q2YXPr3UYmfWXPD/ePPutkTl8wvFk946
 n0gdiYAYodBHjppZWmVWIIzgmIL7+2Rm0GFZvWTXs3XBdysiIVDqKXY9Hid3P7BTK4C4GDoVk
 Ghv/+lTGoIQ47664psbxolXJPigdw+ugRK4AnNPT4eBBXFT/w5yul1qmeI1g0w839f3EI=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=mdenber@gmx.com;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 12:24:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, HTML_FONT_FACE_BAD=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

This is a multi-part message in MIME format.
--------------090901000407080401030805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Well the make ran for a while and then stopped here:


root@hemlock:~/qemu-5.0.0# gmake -j16
...
   CC      util/bitops.o
util/qemu-openpty.c:56:12: error: static declaration of
\u2018openpty\u2019 follows non-static declaration
  static int openpty(int *amaster, int *aslave, char *name,
             ^~~~~~~
In file included from /usr/include/termios.h:8:0,
                  from util/qemu-openpty.c:48:
/usr/include/sys/termios.h:538:12: note: previous declaration of
\u2018openpty\u2019 was here
  extern int openpty(int *, int *, char *, struct termios *, struct
winsize *);
             ^~~~~~~
gmake: *** [/export/home/denber/qemu-5.0.0/rules.mak:69:
util/qemu-openpty.o] Error 1

Interestingly, I ran across this openpty issue last year while building
QEMU 2.12 in Solaris 10, here: https://bugs.launchpad.net/qemu/+bug/177725=
2

It looks like the change to fix that issue (missing openpty in Solaris)
is having some trouble.  I'm not a good enough C programmer to figure it
out.  Remove the openpty declaration from util/openpty.c perhaps?

             - Michele



--------------090901000407080401030805
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Well the make ran for a while and then stopped here:<br>
    <br>
    <br>
    <small><font face="Courier New, Courier, monospace"><a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a>
        gmake -j16<br>
        ...<br>
        &nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; util/bitops.o<br>
        util/qemu-openpty.c:56:12: error: static declaration of
        \u2018openpty\u2019 follows non-static declaration<br>
        &nbsp;static int openpty(int *amaster, int *aslave, char *name,<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~~<br>
        In file included from /usr/include/termios.h:8:0,<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from util/qemu-openpty.c:48:<br>
        /usr/include/sys/termios.h:538:12: note: previous declaration of
        \u2018openpty\u2019 was here<br>
        &nbsp;extern int openpty(int *, int *, char *, struct termios *,
        struct winsize *);<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~~<br>
        gmake: *** [/export/home/denber/qemu-5.0.0/rules.mak:69:
        util/qemu-openpty.o] Error 1</font></small><br>
    <br>
    Interestingly, I ran across this openpty issue last year while
    building QEMU 2.12 in Solaris 10, here: <small><font face="Courier
        New, Courier, monospace"><a class="moz-txt-link-freetext" href="https://bugs.launchpad.net/qemu/+bug/1777252">https://bugs.launchpad.net/qemu/+bug/1777252</a></font></small><br>
    <br>
    It looks like the change to fix that issue (missing openpty in
    Solaris) is having some trouble.&nbsp; I'm not a good enough C programmer
    to figure it out.&nbsp; Remove the openpty declaration from
    util/openpty.c perhaps?<br>
    <br>
    &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; - Michele<br>
    <br>
    <br>
  </body>
</html>

--------------090901000407080401030805--


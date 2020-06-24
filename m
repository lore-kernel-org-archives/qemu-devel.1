Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC822C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 13:20:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 783DE20738
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 13:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MioF8cYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783DE20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo5KD-0008HR-Lf
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 09:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1jo5D3-0005RG-MT
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 09:13:02 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:39260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1jo5D1-0002i2-Hi
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 09:13:01 -0400
Received: by mail-oi1-x22e.google.com with SMTP id w17so1066432oie.6
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=FC86DfyMXM/Mif3M1HKO5ViyQ8w+5Bb/MaAQaddai0M=;
 b=MioF8cYvAhL1dwH3hDjXBIy/eXr9m6+9BgG5SAyMInh9/MfHd8LPWre3jqezZvlE73
 /bwxZP1xZ4WlJYQrwnRecZpn2zMj9ndlWg93C6mqix9j7TWXLp+VF175vmoMfR+jqqBb
 KbUiIa84rPvq6h9q+IwSddlU8IuWViXqaOsCcLvhhy7AOscBq1eMQjksxIuL6jxKhvwa
 L3TlsGma1HeSlymzhc6hFBPFWE+3DDNa5uN8yx/Cj6IqbhP3BNlE0pO5kMUZpz+vAiiJ
 ydrUC/Ex3MDiKJU6V3FKNKVGYeUbnF7vxlx0tqNtKknwb/YL8Db5bP76aDR4eLqGLICW
 aUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=FC86DfyMXM/Mif3M1HKO5ViyQ8w+5Bb/MaAQaddai0M=;
 b=KDf7xQ0/3eLkX/AM1AkMwxa1++0s/b02JHNGWhgZRKH3m3YdJSbOLPni339CF8VAlB
 M1FbICd2cpln5g7kcWoFuVvsnrtizk3JNCzCjt1H+YXfylABzRWhn59cPyvT+fyoQQkx
 d8iSqTx9uLadgoAaWIPNhNOnvMa1+Ig9+WwiHSp+MGITjwZH5AHYAUR3n4ytc0v2pNmr
 plT0jVA2zOAe+ZsnWxkaBIs5ivv7OaKpcDckHPYhGpn/s+xDlGl/xtWU/J06SF0y5qjg
 ENToYktbbE/2OeqXtxp5IfyHUZOdQUfWZat/DSdzm5mYXP+vQUb5oZ3zJs0HrBU/gGLe
 sY8Q==
X-Gm-Message-State: AOAM531itDwZhJQ+I0c8MOWIhkhvq/ZLb/EN34MbtswkeUSnZr7f5viH
 POJpFWiPkYrT639XQQjiLuSjgmBXi/DfaAhHqKMZ6Nk8yzg=
X-Google-Smtp-Source: ABdhPJwpltI/TrUPqmhS84uGA2ki25p7AWlQHIV0eHLMDKpyZbMqzBtOqSLozaz690Ji4CspWwliX8IyiEtdOspYlhU=
X-Received: by 2002:aca:574b:: with SMTP id l72mr20074080oib.59.1593004377565; 
 Wed, 24 Jun 2020 06:12:57 -0700 (PDT)
MIME-Version: 1.0
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Wed, 24 Jun 2020 15:12:46 +0200
Message-ID: <CABLmASGaZDBz_9dGeVi3kaePyRxv6YdwxUd2bBLhyQtsVaYi2Q@mail.gmail.com>
Subject: lib-usb related linking error with msys2 build
To: qemu-devel qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000000cf0c805a8d43c30"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=hsp.cat7@gmail.com; helo=mail-oi1-x22e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

--0000000000000cf0c805a8d43c30
Content-Type: text/plain; charset="UTF-8"

Hi all,

I get the following error compiling qemu-system-ppc from current master
with msys2 (fully updated)

./configure --cross-prefix=x86_64-w64-mingw32- --target-list=ppc-softmmu
--enable-gtk --enable-sdl

C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.1.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
../hw/usb/host-libusb.o: in function `usb_host_open':
C:\msys64\home\hsp\src\qemu-master/hw/usb/host-libusb.c:913: undefined
reference to `libusb_wrap_sys_device'
collect2.exe: error: ld returned 1 exit status
make[1]: *** [Makefile:208: qemu-system-ppcw.exe] Error 1
make: *** [Makefile:527: ppc-softmmu/all] Error 2

I tracked it down to commit:

$ git bisect bad
9f815e83e983d247a3cd67579d2d9c1765adc644 is the first bad commit
commit 9f815e83e983d247a3cd67579d2d9c1765adc644
Author: Gerd Hoffmann <kraxel@redhat.com>
Date:   Fri Jun 5 14:59:52 2020 +0200

    usb: add hostdevice property to usb-host

    The new property allows to specify usb host device name.  Uses standard
    qemu_open(), so both file system path (/dev/bus/usb/$bus/$dev on linux)
    and file descriptor passing can be used.

    Requires libusb 1.0.23 or newer.  The hostdevice property is only
    present in case qemu is compiled against a new enough library version,
    so the presence of the property can be used for feature detection.

    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
    Message-Id: <20200605125952.13113-1-kraxel@redhat.com>

 hw/usb/host-libusb.c | 75
++++++++++++++++++++++++++++++++++++++++++----------
 hw/usb/trace-events  |  1 +
 2 files changed, 62 insertions(+), 14 deletions(-)

According to msys2, the following libusb is provided:
Group(s):Repo(s)mingw32, mingw64 Version: 1.0.23-1Upstream URL:
https://libusb.info/Arch Linux:1.0.23 GIT Version:1.0.23-1 License(s)LGPLBinary
Packages:mingw-w64-i686-libusbmingw-w64-x86_64-libusb
Thanks for looking into this.

Best,
Howard

--0000000000000cf0c805a8d43c30
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div><div>Hi all,<br></div><div><br></div><div>I=
 get the following error compiling qemu-system-ppc from current master with=
 msys2 (fully updated)</div><div><br></div><div>./configure --cross-prefix=
=3Dx86_64-w64-mingw32- --target-list=3Dppc-softmmu --enable-gtk --enable-sd=
l<br></div><div><br></div><div>C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-=
mingw32/10.1.0/../../../../x86_64-w64-mingw32/bin/ld.exe: ../hw/usb/host-li=
busb.o: in function `usb_host_open&#39;:</div>C:\msys64\home\hsp\src\qemu-m=
aster/hw/usb/host-libusb.c:913: undefined reference to `libusb_wrap_sys_dev=
ice&#39;<br>collect2.exe: error: ld returned 1 exit status<br>make[1]: *** =
[Makefile:208: qemu-system-ppcw.exe] Error 1<br><div>make: *** [Makefile:52=
7: ppc-softmmu/all] Error 2</div><div><br></div><div>I tracked it down to c=
ommit:</div><div> <br></div><div>$ git bisect bad<br>9f815e83e983d247a3cd67=
579d2d9c1765adc644 is the first bad commit<br>commit 9f815e83e983d247a3cd67=
579d2d9c1765adc644<br>Author: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@re=
dhat.com">kraxel@redhat.com</a>&gt;<br>Date: =C2=A0 Fri Jun 5 14:59:52 2020=
 +0200<br><br>=C2=A0 =C2=A0 usb: add hostdevice property to usb-host<br><br=
>=C2=A0 =C2=A0 The new property allows to specify usb host device name.=C2=
=A0 Uses standard<br>=C2=A0 =C2=A0 qemu_open(), so both file system path (/=
dev/bus/usb/$bus/$dev on linux)<br>=C2=A0 =C2=A0 and file descriptor passin=
g can be used.<br><br>=C2=A0 =C2=A0 Requires libusb 1.0.23 or newer.=C2=A0 =
The hostdevice property is only<br>=C2=A0 =C2=A0 present in case qemu is co=
mpiled against a new enough library version,<br>=C2=A0 =C2=A0 so the presen=
ce of the property can be used for feature detection.<br><br>=C2=A0 =C2=A0 =
Signed-off-by: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com">kraxe=
l@redhat.com</a>&gt;<br>=C2=A0 =C2=A0 Message-Id: &lt;<a href=3D"mailto:202=
00605125952.13113-1-kraxel@redhat.com">20200605125952.13113-1-kraxel@redhat=
.com</a>&gt;<br><br>=C2=A0hw/usb/host-libusb.c | 75 +++++++++++++++++++++++=
+++++++++++++++++++----------<br>=C2=A0hw/usb/trace-events =C2=A0| =C2=A01 =
+<br>=C2=A02 files changed, 62 insertions(+), 14 deletions(-)<br></div><div=
><br></div><div>According to msys2, the following libusb is provided:</div>=
<div>
<div class=3D"gmail-card-body gmail-overflow-auto">

   =20

    <dl class=3D"gmail-row"><dt class=3D"gmail-col-sm-3 gmail-text-sm-right=
">Group(s):</dt><dt class=3D"gmail-col-sm-3 gmail-text-sm-right">Repo(s)min=
gw32,=20
       =20
        mingw64
       =20
      </dt><dt class=3D"gmail-col-sm-3 gmail-text-sm-right">Version: 1.0.23=
-1</dt><dt class=3D"gmail-col-sm-3 gmail-text-sm-right">Upstream URL: <a hr=
ef=3D"https://libusb.info/">https://libusb.info/</a></dt><dt class=3D"gmail=
-col-sm-3 gmail-text-sm-right">Arch Linux:1.0.23
           =20
        </dt><dt class=3D"gmail-col-sm-3 gmail-text-sm-right">GIT Version:1=
.0.23-1
       =20
      </dt><dt class=3D"gmail-col-sm-3 gmail-text-sm-right">License(s)</dt>=
<dd class=3D"gmail-col-sm-9">LGPL</dd><dt class=3D"gmail-col-sm-3 gmail-tex=
t-sm-right">Binary Packages:</dt><dt class=3D"gmail-col-sm-3 gmail-text-sm-=
right">mingw-w64-i686-libusb</dt><dt class=3D"gmail-col-sm-3 gmail-text-sm-=
right">mingw-w64-x86_64-libusb<br></dt></dl></div><div class=3D"gmail-card-=
body gmail-overflow-auto">
      Thanks for looking into this.</div><div class=3D"gmail-card-body gmai=
l-overflow-auto"><br></div><div class=3D"gmail-card-body gmail-overflow-aut=
o">Best,</div><div class=3D"gmail-card-body gmail-overflow-auto">Howard<br>
  </div>

</div></div>

--0000000000000cf0c805a8d43c30--


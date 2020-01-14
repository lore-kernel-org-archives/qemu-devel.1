Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A72C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:15:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D3B82467D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdNDg1dZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3B82467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irMya-0003Ae-Kt
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 09:15:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1irMvv-0000Bz-4c
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:12:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1irMvt-00018H-B8
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:12:39 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f]:43588)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1irMvs-00017z-Vd
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:12:37 -0500
Received: by mail-lf1-x12f.google.com with SMTP id 9so9935986lfq.10
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 06:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c6aDZ++wOdLMIFVrq+X1pnnUBQ0kq5myRMIjD3Ij3EE=;
 b=gdNDg1dZAPFQuXhoIWgk+9zr5bOmRp79cLdI6kTncL2ShcnsDKkCMIXp9HjL+lse80
 62F5QHeOUfOrYCE60pe3fdHD5l8DqYj/+M3C21q2wK09qSLupsdrK1Jl9sBk6trYmW3x
 lisNcDb2HIxMuCNg94WN0jCo8cG+AxF8u/+V4+YvpKW4kdfYTsBC14N50RG8PRY2Ry9G
 +LjkC3uwVfu8UpTLbfcsI3QP7oiiia0xsc5PP+X3fRTfXA90nmYOVhmPkJm4dm2n7JYX
 yCJxP7yyeYuh4Gsl4kjCkzV4cGONHIg7qZaufwR3B+n9XIRWklksFmRAmx+YNO2PBRIg
 RfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c6aDZ++wOdLMIFVrq+X1pnnUBQ0kq5myRMIjD3Ij3EE=;
 b=DRSit7gxVUGLPucohiFJpbHS3Fo/oHzWIj3Glh76cRsx+bclJ1VOXIugNz0D6vcbZ2
 7TVx+SsWXQPPI9AIplb6SqOBivJ0E3mnV28oFIK+wcS2OxF7ycA6HfqvXlQYeq5tWwEO
 lbP8DgCN+CKjQWJPZJFd0Q52uyGqSPDgPIWi0tczfzGO6vafcmBEoeHaukxWQrkn91wB
 u4q8qySp6wHfaKVk1SHSKl3o0zqccGhjW8WWcOhVPo80BEJe/CoYcpgOp4AYKoLQlwMV
 rnO3WO8C/xqHgOCi6ivl865OhpiDDyp6VhTPGlMNAXmiYULKq0MgTOGeQHXMY/BwpquV
 3PjQ==
X-Gm-Message-State: APjAAAWKECpz2K749D8eDXmc/0GRbmt2mntk2lQ2ML450PNI2GyUAAJ8
 QkMXEOF9+h72IGM/fhkUZJii/tmrTrGSn7IIoNEF1gCYH8s=
X-Google-Smtp-Source: APXvYqyW8dFcl5j5BmSALb2ntxTzXwGY8YCRLpTKe784ysYAAo/OIkmMTJ2zyP6scaQJCXuaZOPUlxVT5ac963JSgeM=
X-Received: by 2002:a19:2389:: with SMTP id j131mr1640557lfj.86.1579011155173; 
 Tue, 14 Jan 2020 06:12:35 -0800 (PST)
MIME-Version: 1.0
References: <20200113045704.12318-1-coiby.xu@gmail.com>
 <157889287819.17824.5639853317020239861@37313f22b938>
In-Reply-To: <157889287819.17824.5639853317020239861@37313f22b938>
From: Coiby Xu <coiby.xu@gmail.com>
Date: Tue, 14 Jan 2020 22:11:58 +0800
Message-ID: <CAJAkqrV=pv0=S8jUYR2VzWtJ=_ZcoAknV1TM2YPo1wvP9uJ81A@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] vhost-user block device backend implementation
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000000266c059c1a2f43"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::12f
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000000266c059c1a2f43
Content-Type: text/plain; charset="UTF-8"

It fails MinGW because libvhost-user depends on eventfd which is a
Linux-specific feature. Now fixed in v2.

On Mon, Jan 13, 2020 at 1:21 PM <no-reply@patchew.org> wrote:

> Patchew URL:
> https://patchew.org/QEMU/20200113045704.12318-1-coiby.xu@gmail.com/
>
>
>
> Hi,
>
> This series failed the docker-mingw@fedora build test. Please find the
> testing commands and
> their output below. If you have Docker installed, you can probably
> reproduce it
> locally.
>
> === TEST SCRIPT BEGIN ===
> #! /bin/bash
> export ARCH=x86_64
> make docker-image-fedora V=1 NETWORK=1
> time make docker-test-mingw@fedora J=14 NETWORK=1
> === TEST SCRIPT END ===
>
>   CC      chardev/char-ringbuf.o
>   CC      chardev/char-serial.o
>   CC      chardev/char-socket.o
> /tmp/qemu-test/src/contrib/libvhost-user/libvhost-user.c:26:10: fatal
> error: sys/socket.h: No such file or directory
>  #include <sys/socket.h>
>           ^~~~~~~~~~~~~~
> compilation terminated.
> make: *** [/tmp/qemu-test/src/rules.mak:69:
> contrib/libvhost-user/libvhost-user.o] Error 1
> make: *** Waiting for unfinished jobs....
> In file included from /tmp/qemu-test/src/include/block/vhost-user.h:3,
>                  from /tmp/qemu-test/src/blockdev-vu.c:2:
> /tmp/qemu-test/src/contrib/libvhost-user/libvhost-user.h:20:10: fatal
> error: sys/poll.h: No such file or directory
>  #include <sys/poll.h>
>           ^~~~~~~~~~~~
> compilation terminated.
> make: *** [/tmp/qemu-test/src/rules.mak:69: blockdev-vu.o] Error 1
> In file included from /tmp/qemu-test/src/include/block/vhost-user.h:3,
>                  from /tmp/qemu-test/src/qemu-vu.c:22:
> /tmp/qemu-test/src/contrib/libvhost-user/libvhost-user.h:20:10: fatal
> error: sys/poll.h: No such file or directory
>  #include <sys/poll.h>
>           ^~~~~~~~~~~~
> compilation terminated.
> make: *** [/tmp/qemu-test/src/rules.mak:69: qemu-vu.o] Error 1
> In file included from
> /tmp/qemu-test/src/contrib/libvhost-user/libvhost-user-glib.h:19,
>                  from
> /tmp/qemu-test/src/contrib/libvhost-user/libvhost-user-glib.c:17:
> /tmp/qemu-test/src/contrib/libvhost-user/libvhost-user.h:20:10: fatal
> error: sys/poll.h: No such file or directory
>  #include <sys/poll.h>
>           ^~~~~~~~~~~~
> compilation terminated.
> make: *** [/tmp/qemu-test/src/rules.mak:69:
> contrib/libvhost-user/libvhost-user-glib.o] Error 1
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 662, in <module>
>     sys.exit(main())
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run',
> '--label', 'com.qemu.instance.uuid=5a27a9b1f81649c88588b26500a2460e', '-u',
> '1003', '--security-opt', 'seccomp=unconfined', '--rm', '-e',
> 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14',
> '-e', 'DEBUG=', '-e', 'SHOW_ENV=', '-e', 'CCACHE_DIR=/var/tmp/ccache',
> '-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v',
> '/var/tmp/patchew-tester-tmp-z0m6vw52/src/docker-src.2020-01-13-00.19.17.20483:/var/tmp/qemu:z,ro',
> 'qemu:fedora', '/var/tmp/qemu/run', 'test-mingw']' returned non-zero exit
> status 2.
>
> filter=--filter=label=com.qemu.instance.uuid=5a27a9b1f81649c88588b26500a2460e
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-z0m6vw52/src'
> make: *** [docker-run-test-mingw@fedora] Error 2
>
> real    2m1.128s
> user    0m6.706s
>
>
> The full log is available at
>
> http://patchew.org/logs/20200113045704.12318-1-coiby.xu@gmail.com/testing.docker-mingw@fedora/?type=message
> .
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com



-- 
*Best regards,*
*Coiby*

--00000000000000266c059c1a2f43
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">It fails MinGW because libvhost-user depends on eventfd wh=
ich is a Linux-specific feature. Now fixed in v2.</div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 13, 2020 at 1:=
21 PM &lt;<a href=3D"mailto:no-reply@patchew.org">no-reply@patchew.org</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Patch=
ew URL: <a href=3D"https://patchew.org/QEMU/20200113045704.12318-1-coiby.xu=
@gmail.com/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QEMU/=
20200113045704.12318-1-coiby.xu@gmail.com/</a><br>
<br>
<br>
<br>
Hi,<br>
<br>
This series failed the docker-mingw@fedora build test. Please find the test=
ing commands and<br>
their output below. If you have Docker installed, you can probably reproduc=
e it<br>
locally.<br>
<br>
=3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D<br>
#! /bin/bash<br>
export ARCH=3Dx86_64<br>
make docker-image-fedora V=3D1 NETWORK=3D1<br>
time make docker-test-mingw@fedora J=3D14 NETWORK=3D1<br>
=3D=3D=3D TEST SCRIPT END =3D=3D=3D<br>
<br>
=C2=A0 CC=C2=A0 =C2=A0 =C2=A0 chardev/char-ringbuf.o<br>
=C2=A0 CC=C2=A0 =C2=A0 =C2=A0 chardev/char-serial.o<br>
=C2=A0 CC=C2=A0 =C2=A0 =C2=A0 chardev/char-socket.o<br>
/tmp/qemu-test/src/contrib/libvhost-user/libvhost-user.c:26:10: fatal error=
: sys/socket.h: No such file or directory<br>
=C2=A0#include &lt;sys/socket.h&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~<br>
compilation terminated.<br>
make: *** [/tmp/qemu-test/src/rules.mak:69: contrib/libvhost-user/libvhost-=
user.o] Error 1<br>
make: *** Waiting for unfinished jobs....<br>
In file included from /tmp/qemu-test/src/include/block/vhost-user.h:3,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /tmp/qem=
u-test/src/blockdev-vu.c:2:<br>
/tmp/qemu-test/src/contrib/libvhost-user/libvhost-user.h:20:10: fatal error=
: sys/poll.h: No such file or directory<br>
=C2=A0#include &lt;sys/poll.h&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~<br>
compilation terminated.<br>
make: *** [/tmp/qemu-test/src/rules.mak:69: blockdev-vu.o] Error 1<br>
In file included from /tmp/qemu-test/src/include/block/vhost-user.h:3,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /tmp/qem=
u-test/src/qemu-vu.c:22:<br>
/tmp/qemu-test/src/contrib/libvhost-user/libvhost-user.h:20:10: fatal error=
: sys/poll.h: No such file or directory<br>
=C2=A0#include &lt;sys/poll.h&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~<br>
compilation terminated.<br>
make: *** [/tmp/qemu-test/src/rules.mak:69: qemu-vu.o] Error 1<br>
In file included from /tmp/qemu-test/src/contrib/libvhost-user/libvhost-use=
r-glib.h:19,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /tmp/qem=
u-test/src/contrib/libvhost-user/libvhost-user-glib.c:17:<br>
/tmp/qemu-test/src/contrib/libvhost-user/libvhost-user.h:20:10: fatal error=
: sys/poll.h: No such file or directory<br>
=C2=A0#include &lt;sys/poll.h&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~<br>
compilation terminated.<br>
make: *** [/tmp/qemu-test/src/rules.mak:69: contrib/libvhost-user/libvhost-=
user-glib.o] Error 1<br>
Traceback (most recent call last):<br>
=C2=A0 File &quot;./tests/docker/docker.py&quot;, line 662, in &lt;module&g=
t;<br>
=C2=A0 =C2=A0 sys.exit(main())<br>
---<br>
=C2=A0 =C2=A0 raise CalledProcessError(retcode, cmd)<br>
subprocess.CalledProcessError: Command &#39;[&#39;sudo&#39;, &#39;-n&#39;, =
&#39;docker&#39;, &#39;run&#39;, &#39;--label&#39;, &#39;com.qemu.instance.=
uuid=3D5a27a9b1f81649c88588b26500a2460e&#39;, &#39;-u&#39;, &#39;1003&#39;,=
 &#39;--security-opt&#39;, &#39;seccomp=3Dunconfined&#39;, &#39;--rm&#39;, =
&#39;-e&#39;, &#39;TARGET_LIST=3D&#39;, &#39;-e&#39;, &#39;EXTRA_CONFIGURE_=
OPTS=3D&#39;, &#39;-e&#39;, &#39;V=3D&#39;, &#39;-e&#39;, &#39;J=3D14&#39;,=
 &#39;-e&#39;, &#39;DEBUG=3D&#39;, &#39;-e&#39;, &#39;SHOW_ENV=3D&#39;, &#3=
9;-e&#39;, &#39;CCACHE_DIR=3D/var/tmp/ccache&#39;, &#39;-v&#39;, &#39;/home=
/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z&#39;, &#39;-v&#39;, &=
#39;/var/tmp/patchew-tester-tmp-z0m6vw52/src/docker-src.2020-01-13-00.19.17=
.20483:/var/tmp/qemu:z,ro&#39;, &#39;qemu:fedora&#39;, &#39;/var/tmp/qemu/r=
un&#39;, &#39;test-mingw&#39;]&#39; returned non-zero exit status 2.<br>
filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3D5a27a9b1f81649c88588b2=
6500a2460e<br>
make[1]: *** [docker-run] Error 1<br>
make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-z0m6vw52/src&#39;<b=
r>
make: *** [docker-run-test-mingw@fedora] Error 2<br>
<br>
real=C2=A0 =C2=A0 2m1.128s<br>
user=C2=A0 =C2=A0 0m6.706s<br>
<br>
<br>
The full log is available at<br>
<a href=3D"http://patchew.org/logs/20200113045704.12318-1-coiby.xu@gmail.co=
m/testing.docker-mingw@fedora/?type=3Dmessage" rel=3D"noreferrer" target=3D=
"_blank">http://patchew.org/logs/20200113045704.12318-1-coiby.xu@gmail.com/=
testing.docker-mingw@fedora/?type=3Dmessage</a>.<br>
---<br>
Email generated automatically by Patchew [<a href=3D"https://patchew.org/" =
rel=3D"noreferrer" target=3D"_blank">https://patchew.org/</a>].<br>
Please send your feedback to <a href=3D"mailto:patchew-devel@redhat.com" ta=
rget=3D"_blank">patchew-devel@redhat.com</a></blockquote></div><br clear=3D=
"all"><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div=
 dir=3D"ltr"><div><div dir=3D"ltr"><div><i>Best regards,</i></div><font col=
or=3D"#00cccc"><i>Coiby</i></font><div><font color=3D"#00cccc"><br></font><=
/div></div></div></div></div>

--00000000000000266c059c1a2f43--


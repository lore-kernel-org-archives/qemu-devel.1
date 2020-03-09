Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6523CC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:00:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 399682051A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 399682051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBH5S-0001gs-Ei
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 08:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jBH4h-00017Y-8p
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jBH4f-0005IF-T0
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:59:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37747)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jBH4f-0005I2-Mw
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:59:57 -0400
Received: from mail-vk1-f200.google.com ([209.85.221.200])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jBH4d-0008I7-HX
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:59:55 +0000
Received: by mail-vk1-f200.google.com with SMTP id h197so4474195vka.5
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 04:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9Ytp8AqQGjFgizgGUQ0EjgNRrDDmpM186F2/SVyLqyI=;
 b=JgFvBNV9Uir2pjOp567HFYBetOjPexnXcMExBO5up2XMeLGLWnMJP6bJ03dc4El6ND
 HEuCWsbgf2igR/worQzJFhY5sGkn4D6b8C5pdwbs6kv+Tx+vEn6XKs9/U+gAmFvw4DFJ
 Wdb/G/Z0hozFJzUTRr3UhYm9NHtWVvOXyCQRNyd+anHgIM+AVRBztDiyzoT4kTPM4YjZ
 wmZ7h60ptNODek2HJuWiWlvfPUh6n4dAUjBfFhU/v/tWWGyAlBhYN1LnlxXYNS3goie3
 Tf53i+jpwZBOboX5+vkwjLN6JDWes4zJprM3dE7sn6nCyy/4HjACJiHk1ttzL9LbKu1w
 K4zg==
X-Gm-Message-State: ANhLgQ0V1/5hLC3n8TH9oNv+eXXBK9RuOgK9lxQBY5FXx7G+K8urCZIq
 bPjWCENkUCDscmbcAkF693ZOilfjHpbCgNICgAHSG4uxXLivjb7St4RlEBRhW2VPDTD9xAM83cs
 /Awy7uf9uw9+q6qELo9P+SKkbguTZ3gbbpPfdldgsTeD//ElT
X-Received: by 2002:a1f:2d4f:: with SMTP id t76mr347799vkt.58.1583755194449;
 Mon, 09 Mar 2020 04:59:54 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvnHjxSe3RAdAYLYKA5JTRWlwtqK7ECGUZYpH/f8FE06XUhlRWzE2FLFm9FfN3NEywPzMaJAKDj1VBLWS5grjc=
X-Received: by 2002:a1f:2d4f:: with SMTP id t76mr347787vkt.58.1583755194219;
 Mon, 09 Mar 2020 04:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200306132648.27577-1-christian.ehrhardt@canonical.com>
 <158350570928.14529.1394498842582357817@39012742ff91>
In-Reply-To: <158350570928.14529.1394498842582357817@39012742ff91>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Mon, 9 Mar 2020 12:59:28 +0100
Message-ID: <CAATJJ0Lc0RSpx2KFFhTYoXSrVhMLjr3Kh8M34WJ-tvzut_SdTg@mail.gmail.com>
Subject: Re: [PATCH] modules: load modules from versioned /var/run dir
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000c37ec705a06abda2"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 91.189.89.112
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c37ec705a06abda2
Content-Type: text/plain; charset="UTF-8"

On Fri, Mar 6, 2020 at 3:42 PM <no-reply@patchew.org> wrote:

> Patchew URL:
> https://patchew.org/QEMU/20200306132648.27577-1-christian.ehrhardt@canonical.com/
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
> File: "/tmp/qemu-nsis\qemu-doc.html" -> no files found.
> Usage: File [/nonfatal] [/a] ([/r] [/x filespec [...]] filespec [...] |
>    /oname=outfile one_file_only)
> Error in script "/tmp/qemu-test/src/qemu.nsi" on line 180 -- aborting
> creation process
> make: *** [Makefile:1162: qemu-setup-4.2.50.exe] Error 1
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 664, in <module>
>     sys.exit(main())
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run',
> '--label', 'com.qemu.instance.uuid=d78ae1bf94024f7c8a0255eb0d63c8f1', '-u',
> '1003', '--security-opt', 'seccomp=unconfined', '--rm', '-e',
> 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14',
> '-e', 'DEBUG=', '-e', 'SHOW_ENV=', '-e', 'CCACHE_DIR=/var/tmp/ccache',
> '-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v',
> '/var/tmp/patchew-tester-tmp-zbg82xrb/src/docker-src.2020-03-06-09.38.41.1852:/var/tmp/qemu:z,ro',
> 'qemu:fedora', '/var/tmp/qemu/run', 'test-mingw']' returned non-zero exit
> status 2.
>
> filter=--filter=label=com.qemu.instance.uuid=d78ae1bf94024f7c8a0255eb0d63c8f1
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-zbg82xrb/src'
> make: *** [docker-run-test-mingw@fedora] Error 2
>
> real    3m8.711s
> user    0m7.969s
>
>
> The full log is available at
>
> http://patchew.org/logs/20200306132648.27577-1-christian.ehrhardt@canonical.com/testing.docker-mingw@fedora/?type=message
> .
>

This is a false-positive - at least not due to my proposed patch.
I've not even remotely touched qemu-doc.

The test build even runs with config:
  module support    no
Which even means all my changes except the include are removed by the
preprocessor.

Do I need to do anything to reset the state of this patch to not be marked
as failed?


> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com



-- 
Christian Ehrhardt
Staff Engineer, Ubuntu Server
Canonical Ltd

--000000000000c37ec705a06abda2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 6, 2020 at 3:42 PM &lt;<a=
 href=3D"mailto:no-reply@patchew.org">no-reply@patchew.org</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Patchew URL: <a h=
ref=3D"https://patchew.org/QEMU/20200306132648.27577-1-christian.ehrhardt@c=
anonical.com/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QEM=
U/20200306132648.27577-1-christian.ehrhardt@canonical.com/</a><br>
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
File: &quot;/tmp/qemu-nsis\qemu-doc.html&quot; -&gt; no files found.<br>
Usage: File [/nonfatal] [/a] ([/r] [/x filespec [...]] filespec [...] |<br>
=C2=A0 =C2=A0/oname=3Doutfile one_file_only)<br>
Error in script &quot;/tmp/qemu-test/src/qemu.nsi&quot; on line 180 -- abor=
ting creation process<br>
make: *** [Makefile:1162: qemu-setup-4.2.50.exe] Error 1<br>
Traceback (most recent call last):<br>
=C2=A0 File &quot;./tests/docker/docker.py&quot;, line 664, in &lt;module&g=
t;<br>
=C2=A0 =C2=A0 sys.exit(main())<br>
---<br>
=C2=A0 =C2=A0 raise CalledProcessError(retcode, cmd)<br>
subprocess.CalledProcessError: Command &#39;[&#39;sudo&#39;, &#39;-n&#39;, =
&#39;docker&#39;, &#39;run&#39;, &#39;--label&#39;, &#39;com.qemu.instance.=
uuid=3Dd78ae1bf94024f7c8a0255eb0d63c8f1&#39;, &#39;-u&#39;, &#39;1003&#39;,=
 &#39;--security-opt&#39;, &#39;seccomp=3Dunconfined&#39;, &#39;--rm&#39;, =
&#39;-e&#39;, &#39;TARGET_LIST=3D&#39;, &#39;-e&#39;, &#39;EXTRA_CONFIGURE_=
OPTS=3D&#39;, &#39;-e&#39;, &#39;V=3D&#39;, &#39;-e&#39;, &#39;J=3D14&#39;,=
 &#39;-e&#39;, &#39;DEBUG=3D&#39;, &#39;-e&#39;, &#39;SHOW_ENV=3D&#39;, &#3=
9;-e&#39;, &#39;CCACHE_DIR=3D/var/tmp/ccache&#39;, &#39;-v&#39;, &#39;/home=
/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z&#39;, &#39;-v&#39;, &=
#39;/var/tmp/patchew-tester-tmp-zbg82xrb/src/docker-src.2020-03-06-09.38.41=
.1852:/var/tmp/qemu:z,ro&#39;, &#39;qemu:fedora&#39;, &#39;/var/tmp/qemu/ru=
n&#39;, &#39;test-mingw&#39;]&#39; returned non-zero exit status 2.<br>
filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3Dd78ae1bf94024f7c8a0255=
eb0d63c8f1<br>
make[1]: *** [docker-run] Error 1<br>
make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-zbg82xrb/src&#39;<b=
r>
make: *** [docker-run-test-mingw@fedora] Error 2<br>
<br>
real=C2=A0 =C2=A0 3m8.711s<br>
user=C2=A0 =C2=A0 0m7.969s<br>
<br>
<br>
The full log is available at<br>
<a href=3D"http://patchew.org/logs/20200306132648.27577-1-christian.ehrhard=
t@canonical.com/testing.docker-mingw@fedora/?type=3Dmessage" rel=3D"norefer=
rer" target=3D"_blank">http://patchew.org/logs/20200306132648.27577-1-chris=
tian.ehrhardt@canonical.com/testing.docker-mingw@fedora/?type=3Dmessage</a>=
.<br></blockquote><div><br></div><div>This is a false-positive - at least n=
ot due to my proposed patch.</div><div>I&#39;ve not even remotely touched q=
emu-doc.</div><div><br></div><div>The test build even runs with config:<br>=
=C2=A0 module support =C2=A0 =C2=A0no<br></div><div>Which even means all my=
 changes except the include are removed by the preprocessor.</div><div><br>=
</div><div>Do I need to do anything to reset the state of this patch to not=
 be marked as failed?</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
---<br>
Email generated automatically by Patchew [<a href=3D"https://patchew.org/" =
rel=3D"noreferrer" target=3D"_blank">https://patchew.org/</a>].<br>
Please send your feedback to <a href=3D"mailto:patchew-devel@redhat.com" ta=
rget=3D"_blank">patchew-devel@redhat.com</a></blockquote></div><br clear=3D=
"all"><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">Chri=
stian Ehrhardt<br>Staff Engineer, Ubuntu Server<br>Canonical Ltd</div></div=
>

--000000000000c37ec705a06abda2--


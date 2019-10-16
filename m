Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BF7FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 15:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7A2D2168B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 15:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTPoJKI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A2D2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKlT9-0003DX-0T
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 11:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhangckid@gmail.com>) id 1iKlRe-0002PP-6d
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 11:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhangckid@gmail.com>) id 1iKlRc-0006ML-U0
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 11:42:38 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:53077)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1iKlRc-0006Lc-N4
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 11:42:36 -0400
Received: by mail-wm1-x32b.google.com with SMTP id r19so3461199wmh.2
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 08:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LkqQ56lA27jSejxOOrh5xi1NExgaKzur1hoeSTEhR68=;
 b=dTPoJKI82BAbrySEqP9qJHpZQQFqMFssv/mxXBa7cBSsCHATDSr4lqnD1terUFkF3K
 y72vKTtSvNarXWAVVMT+6m+ZRkOPhZnx6sqi32dyRRAxwUC6KIFhxUcfvsm6gpKCMQdB
 ELaq92COrPfULPMx5fdEbUm926rB8GbpFFUVJZaKIHkno/9YKg7Ecf2I6HMRKmQArR+D
 7J2AE2LOCy2TfbwIYt7PJgWJ7qZEFrdiI/2VL6ki19amX01sKtMNXmqeMXkLKkHDbYDI
 PpEd+TBl+WqTaAL2bUgxbyvgxSqPl1Cj2peI5o9alkaQEAsROQHzTeiwDBSn6iabbeJv
 gvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LkqQ56lA27jSejxOOrh5xi1NExgaKzur1hoeSTEhR68=;
 b=gQvxKBtDeW8Ix3asfj9FovN5FEkrOT1eFWKksXA5/7p4fveyjvOcAmKxKQkxMsMQz4
 QxWpYpc4GQYn7YY/YQEZnsdSJ+1N0iVXDUMknkGOoZ0ycJ5cXFjvGqhYn+rRULyxQPHp
 I6wMhBzrXUKMQUNxKC+oNPgTUND3+s1Z1zqPXkXtvw/Yexmij1qCOeMo8F4NOoqoWbHN
 RlUwacX75olLeuBTAWgo4x3sVivrAqvz/BL7wtGJKdp0flbSUAWigagjKN16zl4Ehkpi
 /jL3Tam5xVswkLgq2hjTWkwDFaydGKYHyPVjkIxQIRpOwTHP5eV/Tg1Xwj+vnru7ZPPZ
 3mqA==
X-Gm-Message-State: APjAAAXOZxPKy63KIuAZdzX8oQpJTqjQRJ1AP+LIk4ugXXbpQVZo98Q6
 LQlDg1eA/gPnnbgbWUW/xyTd4bdA1xTaoZdk4ddm3A==
X-Google-Smtp-Source: APXvYqzrQ7i8CWKG+GmSE9sA9BIUuHz6bCYQnn8Wx6wVK2EYKXDDWgviUm/LM0FbJc36efyuL+mq3sGf5ezj18Zq9Xg=
X-Received: by 2002:a1c:39d7:: with SMTP id g206mr4120895wma.7.1571240554816; 
 Wed, 16 Oct 2019 08:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191016112209.9024-1-chen.zhang@intel.com>
 <157124010247.15388.11052477009886074916@37313f22b938>
In-Reply-To: <157124010247.15388.11052477009886074916@37313f22b938>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 16 Oct 2019 23:35:46 +0800
Message-ID: <CAK3tnv++zs8uybmO+coo455f6MOjcs3vXKvWAb_on0Zuq5O5uw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Introduce Advanced Watch Dog module
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000206862059508f341"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Cc: Zhang Chen <chen.zhang@intel.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000206862059508f341
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 16, 2019 at 11:35 PM <no-reply@patchew.org> wrote:

> Patchew URL:
> https://patchew.org/QEMU/20191016112209.9024-1-chen.zhang@intel.com/
>
>
>
> Hi,
>
> This series failed the docker-quick@centos7 build test. Please find the
> testing commands and
> their output below. If you have Docker installed, you can probably
> reproduce it
> locally.
>
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> make docker-image-centos7 V=1 NETWORK=1
> time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
> === TEST SCRIPT END ===
>
> Clone of 'https://git.qemu.org/git/dtc.git' into submodule path 'dtc'
> failed
> failed to update submodule dtc
> Submodule 'dtc' (https://git.qemu.org/git/dtc.git) unregistered for path
> 'dtc'
> make[1]: ***
> [/var/tmp/patchew-tester-tmp-2eq69u33/src/docker-src.2019-10-16-11.34.59.10123]
> Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-2eq69u33/src'
> make: *** [docker-run-test-quick@centos7] Error 2
>
>
It looks this problem dose not caused by my patch series?

Thanks
Zhang Chen


> real    0m3.762s
> user    0m2.349s
>
>
> The full log is available at
>
> http://patchew.org/logs/20191016112209.9024-1-chen.zhang@intel.com/testing.docker-quick@centos7/?type=message
> .
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

--000000000000206862059508f341
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 16, 2019 at 11:35 PM &lt;=
<a href=3D"mailto:no-reply@patchew.org">no-reply@patchew.org</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Patchew URL: <a=
 href=3D"https://patchew.org/QEMU/20191016112209.9024-1-chen.zhang@intel.co=
m/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QEMU/201910161=
12209.9024-1-chen.zhang@intel.com/</a><br>
<br>
<br>
<br>
Hi,<br>
<br>
This series failed the docker-quick@centos7 build test. Please find the tes=
ting commands and<br>
their output below. If you have Docker installed, you can probably reproduc=
e it<br>
locally.<br>
<br>
=3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D<br>
#!/bin/bash<br>
make docker-image-centos7 V=3D1 NETWORK=3D1<br>
time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1<br>
=3D=3D=3D TEST SCRIPT END =3D=3D=3D<br>
<br>
Clone of &#39;<a href=3D"https://git.qemu.org/git/dtc.git" rel=3D"noreferre=
r" target=3D"_blank">https://git.qemu.org/git/dtc.git</a>&#39; into submodu=
le path &#39;dtc&#39; failed<br>
failed to update submodule dtc<br>
Submodule &#39;dtc&#39; (<a href=3D"https://git.qemu.org/git/dtc.git" rel=
=3D"noreferrer" target=3D"_blank">https://git.qemu.org/git/dtc.git</a>) unr=
egistered for path &#39;dtc&#39;<br>
make[1]: *** [/var/tmp/patchew-tester-tmp-2eq69u33/src/docker-src.2019-10-1=
6-11.34.59.10123] Error 1<br>
make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-2eq69u33/src&#39;<b=
r>
make: *** [docker-run-test-quick@centos7] Error 2<br>
<br></blockquote><div><br></div><div>It looks this problem dose not caused =
by my patch series?</div><div><br></div><div>Thanks</div><div>Zhang Chen</d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
real=C2=A0 =C2=A0 0m3.762s<br>
user=C2=A0 =C2=A0 0m2.349s<br>
<br>
<br>
The full log is available at<br>
<a href=3D"http://patchew.org/logs/20191016112209.9024-1-chen.zhang@intel.c=
om/testing.docker-quick@centos7/?type=3Dmessage" rel=3D"noreferrer" target=
=3D"_blank">http://patchew.org/logs/20191016112209.9024-1-chen.zhang@intel.=
com/testing.docker-quick@centos7/?type=3Dmessage</a>.<br>
---<br>
Email generated automatically by Patchew [<a href=3D"https://patchew.org/" =
rel=3D"noreferrer" target=3D"_blank">https://patchew.org/</a>].<br>
Please send your feedback to <a href=3D"mailto:patchew-devel@redhat.com" ta=
rget=3D"_blank">patchew-devel@redhat.com</a></blockquote></div></div>

--000000000000206862059508f341--


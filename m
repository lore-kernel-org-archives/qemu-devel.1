Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB7FC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:03:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5703A20897
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2i/Yw2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5703A20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDkCy-0007Pw-GZ
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDkCN-0006h2-EA
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:02:23 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f]:38606)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDkCG-0005v1-4U
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:02:23 -0400
Received: by mail-lj1-x22f.google.com with SMTP id w3so2495915ljo.5
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 01:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=CnguauLaNJeSLQOzZvYdwas+eFHqPKw6ECzVmP+MFM4=;
 b=J2i/Yw2ek53IcOepGUoVzACeo1ZWlMBbkFDVRcQEiEJ/FZkEtzr81QKkTwwm099gSK
 aOvD4+b/ygnYAFxJIPWiEYxhcgPkcfZ+CIV6ASeKzfyCnpA7RJpPZIw3qx8h1ybyXMb1
 VltPKVpEMlVTiRhC9t53F3HIIIL6E0sa5p+WyZcYz/cpOug/v4aGCJKVFTJo71Vz4XQE
 Es9D355TTftBXlhHUxhSD8ucpAFRJ0XtzpauMNe4767qxb6jkufaZ1lSGeljZU7nFkLF
 eIAD0Idz6HmP/oyHa73sHW5yzyUtZ7xJzaWBzlvdO8wkxHKO+NhY6wx6t1Xy+gU1hQoV
 WdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=CnguauLaNJeSLQOzZvYdwas+eFHqPKw6ECzVmP+MFM4=;
 b=OaAp+vfmFkzl7+mUxmpSY/9d3j6dh4MniWeivxSGUF6VwE9rEZuoYCygRcWmPAlalK
 tn456vjkFWieLNtJFuWPk0YY8xkKZ/+K4eGo8OpE6tGqDEislYyFzWWuURcUF6bk+LKP
 sfHdOvJD92DlEbUlU9xZS4d26J9xrKJjP4lvmhlZLJz8gfX1AwlC2d+L73edxlYGUbT/
 qS8l8m4AnVsefJqPwDT7DpLKN5xT1JRDuaSGDReEvwBNZ1x8gtXhmsvuZnLJQCosvTWC
 /KrjSa4UvvCHy5C8v8wwtqyI+6kFZF9t5oNqtWJ+0S3UKS1uNc1D8CNudB3MfSGJbuJ8
 zT9w==
X-Gm-Message-State: AOAM532kk8UJU845SRCC0GAT2KYK94adgHNAJXmcKHVn0t+wYIrbrNQU
 4S7F8NfDiiHHua0vRK7aSKU5SshVOTkg8Ml1JxjZvrTW4IolbQ==
X-Google-Smtp-Source: ABdhPJyxe3/ZoFMHjf05oLR9T4g5lZx3H7i8Sc9dagwIluPPGhgrS7bA+LOa1ma2hv7fpIfg4mtdiRfGSn8wTfdlUVo=
X-Received: by 2002:a05:651c:1119:: with SMTP id
 d25mr586063ljo.300.1599120133971; 
 Thu, 03 Sep 2020 01:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200903074313.1498-1-luoyonggang@gmail.com>
 <CABgObfaR7nO2b2ndhDoc9rEFRbVU5mT0ozzgFzKA3fx7Xrw2_g@mail.gmail.com>
In-Reply-To: <CABgObfaR7nO2b2ndhDoc9rEFRbVU5mT0ozzgFzKA3fx7Xrw2_g@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 3 Sep 2020 16:02:02 +0800
Message-ID: <CAE2XoE9XsZhvpMK0ebu=MdqCwYiAekJFdeYka=H3Pcbugeu_Vw@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] Green the msys2 CI make
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000089e38405ae642bdd"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x22f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000089e38405ae642bdd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2020 at 3:58 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> Please send patches more slowly. You already have several queued, and
> resending them only adds confusion.
>
> OK, sorry for that.

> Paolo
>
> Il gio 3 set 2020, 09:43 Yonggang Luo <luoyonggang@gmail.com> ha scritto:
>
>> Also it's fixes issues about make check
>>
>> Yonggang Luo (12):
>>   configure: fixes dtc not cloned when running msys2 CI
>>   meson: Convert undefsym.sh to undefsym.py
>>   tcg: Fixes dup_const link error
>>   tests: handling signal on win32 properly
>>   configure: Fix include and linkage issue on msys2
>>   block: Fixes nfs on msys2/mingw
>>   osdep: These function are only available on Non-Win32 system.
>>   ci: fixes msys2 build by upgrading capstone to 4.0.2
>>   stubs: qemu_notify_event have no need to stub
>>   meson: Fixes qapi tests.
>>   tests: Disable test-image-locking that not works under Win32
>>   ci: Enable msys2 ci in cirrus
>>
>>  .cirrus.yml                         |   108 +-
>>  block/nfs.c                         |  1812 +--
>>  capstone                            |     2 +-
>>  configure                           | 16560 +++++++++++++-------------
>>  include/qemu/osdep.h                |  1372 +--
>>  include/tcg/tcg.h                   |  2898 ++---
>>  meson.build                         |  2994 ++---
>>  scripts/ci/windows/msys2_build.sh   |    33 +
>>  scripts/ci/windows/msys2_install.sh |    31 +
>>  scripts/undefsym.py                 |    57 +
>>  scripts/undefsym.sh                 |    20 -
>>  stubs/notify-event.c                |     8 +-
>>  tcg/tcg-op-gvec.c                   |  7012 +++++------
>>  tests/Makefile.include              |  1086 +-
>>  tests/qapi-schema/meson.build       |   451 +-
>>  tests/test-replication.c            |  1214 +-
>>  16 files changed, 17904 insertions(+), 17754 deletions(-)
>>  create mode 100644 scripts/ci/windows/msys2_build.sh
>>  create mode 100644 scripts/ci/windows/msys2_install.sh
>>  create mode 100644 scripts/undefsym.py
>>  delete mode 100755 scripts/undefsym.sh
>>
>> --
>> 2.28.0.windows.1
>>
>>
>>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000089e38405ae642bdd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Sep 3, 2020 at 3:58 PM Paolo Bonzini &lt;<a href=3D=
"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"auto">Please se=
nd patches more slowly. You already have several queued, and resending them=
 only adds confusion.<div dir=3D"auto"><br></div></div></blockquote><div>OK=
, sorry for that.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><div dir=3D"auto"><div dir=3D"auto"></div><div dir=3D"auto">Paolo</div>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
Il gio 3 set 2020, 09:43 Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gma=
il.com" target=3D"_blank">luoyonggang@gmail.com</a>&gt; ha scritto:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">Also it&#39;s fixes iss=
ues about make check<br>
<br>
Yonggang Luo (12):<br>
=C2=A0 configure: fixes dtc not cloned when running msys2 CI<br>
=C2=A0 meson: Convert undefsym.sh to undefsym.py<br>
=C2=A0 tcg: Fixes dup_const link error<br>
=C2=A0 tests: handling signal on win32 properly<br>
=C2=A0 configure: Fix include and linkage issue on msys2<br>
=C2=A0 block: Fixes nfs on msys2/mingw<br>
=C2=A0 osdep: These function are only available on Non-Win32 system.<br>
=C2=A0 ci: fixes msys2 build by upgrading capstone to 4.0.2<br>
=C2=A0 stubs: qemu_notify_event have no need to stub<br>
=C2=A0 meson: Fixes qapi tests.<br>
=C2=A0 tests: Disable test-image-locking that not works under Win32<br>
=C2=A0 ci: Enable msys2 ci in cirrus<br>
<br>
=C2=A0.cirrus.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0108 +-<br>
=C2=A0block/nfs.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1812 +--<br>
=C2=A0capstone=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A02 +-<br>
=C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 16560 +++++++++++++-------------<br=
>
=C2=A0include/qemu/osdep.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 1372 +--<br>
=C2=A0include/tcg/tcg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 2898 ++---<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2994 ++---<br>
=C2=A0scripts/ci/windows/msys2_build.sh=C2=A0 =C2=A0|=C2=A0 =C2=A0 33 +<br>
=C2=A0scripts/ci/windows/msys2_install.sh |=C2=A0 =C2=A0 31 +<br>
=C2=A0scripts/undefsym.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 57 +<br>
=C2=A0scripts/undefsym.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 20 -<br>
=C2=A0stubs/notify-event.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 =C2=A08 +-<br>
=C2=A0tcg/tcg-op-gvec.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 7012 +++++------<br>
=C2=A0tests/Makefile.include=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 1086 +-<br>
=C2=A0tests/qapi-schema/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A0451 +-<br>
=C2=A0tests/test-replication.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 1214 +-<br>
=C2=A016 files changed, 17904 insertions(+), 17754 deletions(-)<br>
=C2=A0create mode 100644 scripts/ci/windows/msys2_build.sh<br>
=C2=A0create mode 100644 scripts/ci/windows/msys2_install.sh<br>
=C2=A0create mode 100644 scripts/undefsym.py<br>
=C2=A0delete mode 100755 scripts/undefsym.sh<br>
<br>
-- <br>
2.28.0.windows.1<br>
<br>
<br>
</blockquote></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--00000000000089e38405ae642bdd--


Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B099BC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79B42208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X1TTHvtv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B42208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51318 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcx2a-0007Dj-MP
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 15:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42923)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcwpl-0003xV-5b
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcwpi-0006h9-Iv
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:58:25 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:33032)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcwpi-0006em-AI
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:58:22 -0400
Received: by mail-ot1-x335.google.com with SMTP id p4so729374oti.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 11:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vOC5waeg1fC7+3PNA9ugNh6FosdwOiiGKM2oKNXjJaY=;
 b=X1TTHvtv/xkWFlV/mJ0hui8X8qHOYLhl1W2UWXd7Gy+eHvrhdti3++9cKEP8yMmolT
 +3J0sd7lOri44Zy0XJh7RDP86Wp6Rn214CRAYEQ5uyMgT0L0Cn3sJJOL7IZMnpIvx2+z
 w6RXjh+QQjpan3+d1t32M/hoPObQFV5LTCdQzMxiOXcgHp7PbmyWYK+8nlZIY5sQ7G5p
 Sf72jYhlZAHyAzIWe4Gl9T8WBh4D4MHk/C/3ARhO69iQ0Iih+Sy/9noEaaaM8NRvX4ec
 FduQkj6KJldPKmS9s098xS/qmUMee8SA2dlPAQtYb0ikGCIN4sm4L4/Q3dU94TVlMMov
 iMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vOC5waeg1fC7+3PNA9ugNh6FosdwOiiGKM2oKNXjJaY=;
 b=CNAdeH/uHbjlPEgOzE4B9POFwwb4P19BPyMENQ8SWfsreOXlKk+Jg0GhUIWZtj22SD
 PbiD2zgd+H/GBuyiqX2aDuL7TOKbJ4ubL5Ac0qh0Q2keWoPZgD49w3tnvqPyIBbG/jx+
 FW8wP16Ams7qvfYrH36UqEmSoQw1iQDKWXoJPxaXFh6OZW/qoal1nmHgjXM2W1olXqPz
 iehU1668qoP8TXnZ9L1hGmFypPaR0BHtIHZ/VdyG3nHzrXJb6U57qZnTiUJff9Ua65hh
 F+fiDlOJgs7q0S7LOS+g9RtNiHmjgtxc+5H+xlpaYtZ6TCAKfCWbOd1GtM9ErI73QYtt
 Ozaw==
X-Gm-Message-State: APjAAAU8OQQIJcVa7WtMEItouj7yO0gQ0vnIHQoNtREVxc6au7MsEaqg
 iNj3blv44kNyL58i1+qpWl5DyrG4dvOqwe0DZt9LLQ==
X-Google-Smtp-Source: APXvYqyuBWecUexA6b5tW2OK5RrfCGVeByjoFKDV6VcHsVvYcQ8ZO3fULABIQdt+gDbeSbPBPYVQh6I7lZbFQZrHqgg=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr223281otj.97.1560797901111;
 Mon, 17 Jun 2019 11:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190617184903.19436-1-armbru@redhat.com>
In-Reply-To: <20190617184903.19436-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jun 2019 19:58:09 +0100
Message-ID: <CAFEAcA9M0kEikXajCWX9BUtLU87P6=KHvbEWoW6xVq0Y7xvueQ@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
Subject: Re: [Qemu-devel] [PULL 00/16] Monitor patches for 2019-06-17
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Jun 2019 at 19:51, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 076243ffe6c1b687e9e6d98348c3bf3398df78=
f3:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-docs-20190617'=
 into staging (2019-06-17 16:41:25 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2019-06-17
>
> for you to fetch changes up to 092b8737c5e7695c4b9caa3b4eedc66763632755:
>
>   vl: Deprecate -mon pretty=3D... for HMP monitors (2019-06-17 20:36:56 +=
0200)
>
> ----------------------------------------------------------------
> Monitor patches for 2019-06-17
>

Hi; I'm afraid this doesn't compile:

Most hosts (ppc64, s390, aarch64, aarch32, osx, and possibly
the others too though they haven't failed immediately) fail
something like this:

/home/pm215/qemu/monitor/misc.c: In function =E2=80=98netdev_del_completion=
=E2=80=99:
/home/pm215/qemu/monitor/misc.c:2165:9: error: implicit declaration of
function =E2=80=98qemu_find_opts_err=E2=80=99 [-Werror=3Dimplicit-function-=
declaration]
         opts =3D qemu_opts_find(qemu_find_opts_err("netdev", NULL), name);
         ^
/home/pm215/qemu/monitor/misc.c:2165:9: error: nested extern
declaration of =E2=80=98qemu_find_opts_err=E2=80=99 [-Werror=3Dnested-exter=
ns]
/home/pm215/qemu/monitor/misc.c:2165:9: error: passing argument 1 of
=E2=80=98qemu_opts_find=E2=80=99 makes pointer from integer without a cast =
[-Werror]
In file included from /home/pm215/qemu/monitor/misc.c:64:0:
/home/pm215/qemu/include/qemu/option.h:105:11: note: expected =E2=80=98stru=
ct
QemuOptsList *=E2=80=99 but argument is of type =E2=80=98int=E2=80=99
 QemuOpts *qemu_opts_find(QemuOptsList *list, const char *id);
           ^
cc1: all warnings being treated as errors


windows is a bit different:

/home/petmay01/qemu-for-merges/monitor/hmp.c: In function 'file_completion'=
:
/home/petmay01/qemu-for-merges/monitor/hmp.c:1113:5: error: unknown
type name 'DIR'
     DIR *ffs;
     ^
/home/petmay01/qemu-for-merges/monitor/hmp.c:1135:11: error: implicit
declaration of function 'opendir'
[-Werror=3Dimplicit-function-declaration]
     ffs =3D opendir(path);
           ^
/home/petmay01/qemu-for-merges/monitor/hmp.c:1135:5: error: nested
extern declaration of 'opendir' [-Werror=3Dnested-externs]
     ffs =3D opendir(path);
     ^
/home/petmay01/qemu-for-merges/monitor/hmp.c:1135:9: error: assignment
makes pointer from integer without a cast [-Werror=3Dint-conversion]
     ffs =3D opendir(path);
         ^
/home/petmay01/qemu-for-merges/monitor/hmp.c:1141:13: error: implicit
declaration of function 'readdir'
[-Werror=3Dimplicit-function-declaration]
         d =3D readdir(ffs);
             ^
/home/petmay01/qemu-for-merges/monitor/hmp.c:1141:9: error: nested
extern declaration of 'readdir' [-Werror=3Dnested-externs]
         d =3D readdir(ffs);
         ^
/home/petmay01/qemu-for-merges/monitor/hmp.c:1141:11: error:
assignment makes pointer from integer without a cast
[-Werror=3Dint-conversion]
         d =3D readdir(ffs);
           ^
/home/petmay01/qemu-for-merges/monitor/hmp.c:1146:21: error:
dereferencing pointer to incomplete type 'struct dirent'
         if (strcmp(d->d_name, ".") =3D=3D 0 || strcmp(d->d_name, "..") =3D=
=3D 0) {
                     ^
/home/petmay01/qemu-for-merges/monitor/hmp.c:1166:5: error: implicit
declaration of function 'closedir'
[-Werror=3Dimplicit-function-declaration]
     closedir(ffs);
     ^
/home/petmay01/qemu-for-merges/monitor/hmp.c:1166:5: error: nested
extern declaration of 'closedir' [-Werror=3Dnested-externs]

thanks
-- PMM


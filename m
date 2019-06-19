Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10853C43613
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 23:52:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA2320851
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 23:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA2320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42596 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdkNU-0000rd-4Y
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 19:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54166)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlureau@redhat.com>) id 1hdkJD-000546-M5
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 19:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1hdk8u-0006B9-Ej
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 19:37:29 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41239)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1hdk8u-0006AJ-9V
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 19:37:28 -0400
Received: by mail-ot1-f65.google.com with SMTP id 43so832585otf.8
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 16:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tqBv8ZkDQd9FZbHH96sKnDZMeY5Wv08jbJ8X8hxiNKg=;
 b=rqiq1WbIjw7XhP6ngaS5cRgyoR75Qu03SqXPkUGr4mG/x/RJw9QYKbst/cw0w8T1zw
 t/MBQlAPUOhJSbFdTS8FOsFSQGNXbO0Jka603Coino02UMDZ9444SoDvGltyHZouF4KE
 MIXrsHmEI3SJc+pOOn5gE0TYPDhQ29y4aC3Wpx98u3aIGWyAjFNJujSTAJDugzltaWaw
 DlusQB2KOqRJcINwH4hn9TY3ohoZIXkTma3/0K1R2bsmvAmXmeUGFFbcnj8MMw1SvRxz
 vETXFDl9qTMqrIX9pqP8FaT55K6jCb6SlqYWXtF/azoY5OaaQYDCMl6TSwvRwmyOYDmy
 x77A==
X-Gm-Message-State: APjAAAVBx1zrhMKMnKsR7hevLIQ9kHFmSJ6z46DTmJovAu3HQOsknWc3
 HYkFIOjzAiDMQIp0+6V1nUBgVJkEJC4j1f/rsNSPVw==
X-Google-Smtp-Source: APXvYqydofnc7Chcla55z4rtggjiApItS4WHgiVYFMV9C60J032bAOYvjiAXJMROLr7ie10bChiHopNnyCIm5cndJ9E=
X-Received: by 2002:a9d:6d12:: with SMTP id o18mr8714107otp.166.1560987447493; 
 Wed, 19 Jun 2019 16:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190619201050.19040-1-armbru@redhat.com>
 <20190619201050.19040-16-armbru@redhat.com>
In-Reply-To: <20190619201050.19040-16-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 20 Jun 2019 01:37:16 +0200
Message-ID: <CAMxuvayQ_BM1p4W5LvF2iEUKZzNepEDEuHYn4Xww_9jfhz_1MQ@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.65
Subject: Re: [Qemu-devel] [PATCH 15/17] dump: Move the code to dump/
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
Cc: "Wolf, Kevin" <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 19, 2019 at 10:10 PM Markus Armbruster <armbru@redhat.com> wrot=
e:
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  MAINTAINERS                   | 2 +-
>  Makefile.target               | 3 +--
>  dump/Makefile.objs            | 2 ++
>  dump.c =3D> dump/dump.c         | 0
>  win_dump.c =3D> dump/win_dump.c | 0
>  win_dump.h =3D> dump/win_dump.h | 0
>  6 files changed, 4 insertions(+), 3 deletions(-)
>  create mode 100644 dump/Makefile.objs
>  rename dump.c =3D> dump/dump.c (100%)
>  rename win_dump.c =3D> dump/win_dump.c (100%)
>  rename win_dump.h =3D> dump/win_dump.h (100%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea110e99ca..a3fdda015f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1850,7 +1850,7 @@ F: include/sysemu/device_tree.h
>  Dump
>  S: Supported
>  M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> -F: dump.c
> +F: dump/dump.c
>  F: hw/misc/vmcoreinfo.c
>  F: include/hw/misc/vmcoreinfo.h
>  F: include/sysemu/dump-arch.h
> diff --git a/Makefile.target b/Makefile.target
> index 167ae2174e..a6919e0caf 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -150,13 +150,12 @@ endif #CONFIG_BSD_USER
>  ifdef CONFIG_SOFTMMU
>  obj-y +=3D arch_init.o cpus.o gdbstub.o balloon.o ioport.o
>  obj-y +=3D qtest.o
> +obj-y +=3D dump/
>  obj-y +=3D hw/
>  obj-y +=3D monitor/
>  obj-y +=3D qapi/
>  obj-y +=3D memory.o
>  obj-y +=3D memory_mapping.o
> -obj-y +=3D dump.o
> -obj-$(TARGET_X86_64) +=3D win_dump.o
>  obj-y +=3D migration/ram.o
>  LIBS :=3D $(libs_softmmu) $(LIBS)
>
> diff --git a/dump/Makefile.objs b/dump/Makefile.objs
> new file mode 100644
> index 0000000000..ea6b074967
> --- /dev/null
> +++ b/dump/Makefile.objs
> @@ -0,0 +1,2 @@
> +obj-y +=3D dump.o
> +obj-$(TARGET_X86_64) +=3D win_dump.o
> diff --git a/dump.c b/dump/dump.c
> similarity index 100%
> rename from dump.c
> rename to dump/dump.c
> diff --git a/win_dump.c b/dump/win_dump.c
> similarity index 100%
> rename from win_dump.c
> rename to dump/win_dump.c
> diff --git a/win_dump.h b/dump/win_dump.h
> similarity index 100%
> rename from win_dump.h
> rename to dump/win_dump.h
> --
> 2.21.0
>


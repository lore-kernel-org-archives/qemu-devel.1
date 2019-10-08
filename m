Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF657C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96C2B2070B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C2B2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHrNK-0004Bz-5v
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 11:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iHrLR-0002hc-0d
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iHrLO-0005BV-9X
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:24:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42764)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iHrLO-0005Ae-3p
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:24:10 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 97BC881DFF
 for <qemu-devel@nongnu.org>; Tue,  8 Oct 2019 15:24:08 +0000 (UTC)
Received: by mail-oi1-f199.google.com with SMTP id r67so10523854oif.18
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 08:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bzOmYQJewAD87cYIIqXUY5II3HO/40im1mjq18p1WiU=;
 b=HPINUwZ6UwuXBzfO/4+HxuD2fXt82HmkBKGFvV4aDuF6bDf5NprT34j02S6Zuzt+4j
 NplszDcSEYSSd7vFLQK60tyex6Pmmt1ZNT9cu2Jy9ZqNEv63chsA9QD9JHCYW9HwpkUz
 B+1xE5UJpWSE8rM3TeQ+j+1Qpg19QDjuwfzJG7UKMh7SoomVPzvFCP+S6eJYZPjsHDtK
 2/V9AKfwtPquZFYpB0Sq9MO8R2wZJuw96eKrqDcRcw6rIJm6sHUjEzWm0iO8nsxKMsRq
 Wz4iDhc3mCgH1To44taV6IJbYIK6CzciVcPPrnS+ZJyC7CPJkQNypQNWdCVXmoxnMU+D
 5y0g==
X-Gm-Message-State: APjAAAWufjkIteV1jRsdvsfgKT7+OFUT162plmpnZcdKKy9Ita4iZ5Xj
 NQld6SJROJkuvj7mUbtdC6HHInD3GoaJ5y3T0V8NfPzMKaPrThjLKP83ZsH0dPwofeJhDvM1P+k
 1+W97dsnjA9b07BYFM9RlC+Y2xOC60Hs=
X-Received: by 2002:a05:6830:1649:: with SMTP id
 h9mr24264044otr.38.1570548248112; 
 Tue, 08 Oct 2019 08:24:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwEHYDe6vAtrlTTs2FwT4TPxmHFdPzhsMdrzslBMW2CQgi1aVuPJ7kNBbEXNu3bT6azcneEHEUXJdpu1wFU11Y=
X-Received: by 2002:a05:6830:1649:: with SMTP id
 h9mr24264029otr.38.1570548247864; 
 Tue, 08 Oct 2019 08:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191008142539.7793-1-philmd@redhat.com>
 <20191008143455.8524-1-philmd@redhat.com>
In-Reply-To: <20191008143455.8524-1-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 8 Oct 2019 19:23:56 +0400
Message-ID: <CAMxuvawO28bNsjygDB5FsT_SDTrcbmh5v-NJKJ7SbViB9P2aYw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] hw/misc/vmcoreinfo: Add comment about reset handler
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 8, 2019 at 6:35 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> The VM coreinfo device does not sit on a bus, so it won't be
> reset automatically. This is why it calls qemu_register_reset().
>
> Add a comment about it, so we don't convert its reset handler
> to a DeviceReset method.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/misc/vmcoreinfo.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
> index 326a3ce8f4..a9d718fc23 100644
> --- a/hw/misc/vmcoreinfo.c
> +++ b/hw/misc/vmcoreinfo.c
> @@ -61,6 +61,10 @@ static void vmcoreinfo_realize(DeviceState *dev, Error=
 **errp)
>                               NULL, fw_cfg_vmci_write, s,
>                               &s->vmcoreinfo, sizeof(s->vmcoreinfo), fals=
e);
>
> +    /*
> +     * This device requires to register a global reset because it is
> +     * not plugged to a bus (which, as its QOM parent, would reset it).
> +     */
>      qemu_register_reset(vmcoreinfo_reset, dev);
>      vmcoreinfo_state =3D s;
>  }
> --
> 2.21.0
>


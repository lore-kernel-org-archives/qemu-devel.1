Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD2CC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C54A20679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tuMigwee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C54A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDugC-0007Iw-F5
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDtf9-0000go-Se
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDtf8-0005rc-SC
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:36:27 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jDtf8-0005bI-IQ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:36:26 -0400
Received: by mail-wm1-x343.google.com with SMTP id a132so18628309wme.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oDwAzBZlgB39jRCpkcihyqHHCaQGuXTIEAAajYTFEKg=;
 b=tuMigwee2moRpbGiK9cz/lTnAq6hg0iP3HlZq3hSsImUI5r4vwIplsjbcVZt1whvhv
 Iv+MysfPeTtZqIRfd9+mQNE2EDUA2Q/rxISj6Mw8T2wwHxR+FYGnB8W9OdMxjXOhp0Fa
 ud3/DGaO+ysD2hLQD7ejUemdoux+YimgIFHDm8w8QHcAmJ14NTAEVbrnhv5HX16UKcXi
 he/9LynfH7WkoluZmoVAFyMrL0+RBDgHHtyLtsLPErceFZ/o6R4o6SZ6W0e8+qXt1MA+
 LKfPSwht3kuuwuFY/+PQex4dZqL3oWWX5RyXKxvWrFeAU2NYjl7UFKcLXqQ1EH2SQqqW
 C3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oDwAzBZlgB39jRCpkcihyqHHCaQGuXTIEAAajYTFEKg=;
 b=SpIQiK+H4+bt3vCLk4j088O36cKvSu6dNb7kAyHepeNvgCfXbxUgzYKbQaYOnAcRc6
 vZJ+GzVtIC2LRB4BzeUvcx82VmUbUD/KNP3QHn3ojpx/JDDaUQAACI3e9tjKjKFHEFn1
 1b2Ts7ovuR1j3tPhRQKwQG1A3J7PhgzX1GqLzlwNVHYcI9jTYbJLl7XGVunccEJ2tnnr
 QBrGSGb+Sm+OMM8M8/PHWV/6Hf5LtSg3e8xKp6KVmQ4btXaHaVFaUfeB83p4XF77m8mP
 5Jx81f/DlgjORWhQSn1o9uVdhW0a9H8yzCLytZ0B3N4O08h+gaIvGuKO34KvkfEiJO1C
 bwFQ==
X-Gm-Message-State: ANhLgQ35xx0lRdeZ111tZvS2zHyvIAB1i3l+JHxppVvRue6keey4VD8x
 mm/ML/J+sZYF+K+UpAn//7HatOCk6LvGZmLyabg=
X-Google-Smtp-Source: ADFU+vvuty5CCRvHlwo7fjPpPuU6yaZedjGtXZamSuRJ6zyKRa4baMdUqUSmgCwBNtMr8G7jlXEtFPeuPS56J4S0CdI=
X-Received: by 2002:a7b:c153:: with SMTP id z19mr188884wmi.37.1584380185249;
 Mon, 16 Mar 2020 10:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-25-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-25-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Mar 2020 18:36:13 +0100
Message-ID: <CAJ+F1CLGr7HYp3kAfjGXgPwxcGAyaPOmkN3+7s_oV-XHVdOVPw@mail.gmail.com>
Subject: Re: [PATCH v3 24/34] qapi: Replace qmp_dispatch()'s TODO comment by
 an explanation
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Sun, Mar 15, 2020 at 3:48 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/qmp-dispatch.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index 112d29a9ab..fb53687ce9 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -164,7 +164,11 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QObject *r=
equest,
>          g_assert(!ret);
>          return NULL;
>      } else if (!ret) {
> -        /* TODO turn into assertion */
> +        /*
> +         * When the command's schema has no 'returns', cmd->fn()
> +         * leaves @ret null.  The QMP spec calls for an the empty

"for an"

Can we assert that the command's schema has no 'returns' in this case?

> +         * object then; supply it.
> +         */
>          ret =3D QOBJECT(qdict_new());
>      }
>
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau


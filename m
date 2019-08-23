Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53961C3A5A4
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E09E2173E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLrfszei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E09E2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Jbq-0002XI-4p
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 20:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i1JJ7-0008Mv-Fc
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:49:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i1JJ6-00043S-Eb
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:49:25 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38818)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i1JJ2-0003yq-Bb; Fri, 23 Aug 2019 19:49:20 -0400
Received: by mail-ot1-x341.google.com with SMTP id r20so10288600ota.5;
 Fri, 23 Aug 2019 16:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=GDZjD+DLwOQGXTvn+lxnFGRBmiGUflL7uU0HzcIxmDw=;
 b=BLrfszeizZllNR9+cd7L8KgG5ZsJ91Tcu10IZuL5l6OnbpqOskWSkvSnE7VSlNRLrH
 ipTIXkz1PsfuGnu4AR1pzJHphVcT3WDYtoglt070IY+9eRguhMojDHwcyygpmqJo8mCi
 02zeR1dlUaIU5AY430TRPAqKlfPQzi17GJgZMkGh6tW4HdzDzw86JLLv4AvtK/Nwtkbt
 87zb5DQZrdRmgdTIZMY9dbY0+4JmRpt9iFrWTBvKASO6uCFHvMegZV5VglyxLfieFoP9
 49B87HKiLVHJIKj4jy1sUXkMrH/t3tcYMrueGB3ndYaQx1BoX0abUn1RJDgL3C63W9nz
 vvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=GDZjD+DLwOQGXTvn+lxnFGRBmiGUflL7uU0HzcIxmDw=;
 b=TdZEOnYPJz0cbu1eLeeOwtwjtTJxkDFvEf5wflaHpRTDCxwZ5q/CQ7T1cMhFcXg6Oe
 +vOXBM2t260UhQaqnuq/e8gNiXAZeZ6XtPJEISmDsYLOaR2ndXUyOtMC9Q2mmAA5ExVF
 tSyvczsHCML1hK4221iLTNc+MihHwsKsCU2B+h7jjglClgkclpOcYS6bfqA1N1w6afkc
 78P8kYndljiP24If63DRId8BpXkjbRnB2/kPpHGuDdUWqJjVdlrKQMstVfsO5vLI9iWe
 UN04ejDsWyY0h1o77x7vzRlZlYSAQ5eCSQGR5ErpASm2Tdd7n1uqiImOCJc5h/M+8V4o
 jKrQ==
X-Gm-Message-State: APjAAAXe8MRF/WM9BFQovDr7F0uxiokMtpr/VZ3u6J6HnCPqREVMY4Ti
 fLcJNMjh11em0AXZklv8s9vLtPJq9Ou3bq1o3dA=
X-Google-Smtp-Source: APXvYqz8T03T+k1hn/p5CHQhDDNRR+LCEIq2wM3DkvIAPlVtG5KvCtbBMQ7afvwcZu5HliAWGDV2GmPXrsAfjE34ioA=
X-Received: by 2002:a05:6830:15cc:: with SMTP id
 j12mr6174900otr.64.1566604158204; 
 Fri, 23 Aug 2019 16:49:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Fri, 23 Aug 2019 16:49:17
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Fri, 23 Aug 2019 16:49:17
 -0700 (PDT)
In-Reply-To: <874l2876kx.fsf@dusky.pond.sub.org>
References: <20190822230916.576-1-philmd@redhat.com>
 <874l2876kx.fsf@dusky.pond.sub.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 24 Aug 2019 01:49:17 +0200
Message-ID: <CAL1e-=hvVp4i=s_Wr0iKy5UO7kH6xw3QR0Ms4_v_tobJSM2wRA@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 0/3] mailmap: Clean up
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
Cc: qemu-trivial@nongnu.org, alex.bennee@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.08.2019. 08.13, "Markus Armbruster" <armbru@redhat.com> =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>
> > Trivial cleanup of .mailmap to have a nice 'git shortlog' output.
> >
> > Philippe Mathieu-Daud=C3=A9 (3):
> >   mailmap: Reorder by sections
> >   mailmap: Update philmd email address
> >   mailmap: Add many entries to improve 'git shortlog' statistics
> >
> >  .mailmap | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 115 insertions(+), 8 deletions(-)
>
> Series
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> However, it increases the difference to contrib/gitdm/aliases.

Alex' initial gitdm effort, as I understood it, was not meant to cover all
history from 2007 or so, but just to give reasonable statistics for 2018
(amd future years).

In that light, .mailmap and gitdm aliases do not need to be equivalent.

But perhaps Alex would now want gitdm to be used for all QEMU history? Is
this desirable?

Aleksandar

> I'm just
> as guilty; my recent "[PATCH 2/2] contrib/gitdm: Add armbru@pond.sub.org
> to group-map-redhat" updates only that. and not .mailmap.
>
> Perhaps we want to keep the two in sync manually.  We should then add
> suitable comments to each file.
>
> Could we instead teach gitdm to use .mailmap, and ditch
> contrib/gitdm/aliases?
>
> aliases' format is documented in gitdm's README.  Each line maps a
> non-canonical e-mail address to a canonical one.
>
> .mailmap's format is documented in git-shortlog(1).  It can do a bit
> more.  Even the common part differs: it has two addresses in different
> order *boggle*.
>

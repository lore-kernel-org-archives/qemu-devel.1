Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93B5C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 21:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F9EF206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 21:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjYYSiNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9EF206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1HRi-0008DP-OE
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 17:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1i1HQH-00078u-De
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 17:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1i1HQG-0003os-Fk
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 17:48:41 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:47052)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1i1HQG-0003mD-7Z
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 17:48:40 -0400
Received: by mail-wr1-x444.google.com with SMTP id z1so9837328wru.13
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 14:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9ZYR30G2jI8Z6c67UJMLohCmbviZ62WBfuFGEhXwIFA=;
 b=EjYYSiNzp1jGoFKTTWXW/Gew2ZgDIUTO3kh3SjlC1FufUgtC1+7GjtI6ljUolp16hK
 KNvc/QAIvtbS6YPudmOwDAU4ZFeUC+gHQVD5YKVQDLaLFB0eyvaVoqxMhxN6viDXjn0l
 aRZl10LrGDhgI+LK8o3g8DhYZRZkFnz57YSLCu8XUXHaWDXrvu4i6awKQHdhiaSAbGK3
 RptiJCEKPQDperKUzi6hDLCTdpDzQcMtjTEY3KXlGc0R+V8nZds5uf9J/1Mrn/MQxCI3
 MSAjbuMnCMUKFcsqns3E/rZ1wzKgSR8EvM7R2uTFWx0KOzGfu8kLDmlL+blTJNnzZBqk
 knwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9ZYR30G2jI8Z6c67UJMLohCmbviZ62WBfuFGEhXwIFA=;
 b=Bvp60jY/Rza4Lb7pHlDArCTX4mDqEfKyNl/NqcqyMbphEd4mZQToAtqVfV05T8DS/E
 HUx4nxJPERFpxGYWIYy9mn7dd6bF+OwH6bvaZy0m8u+MDdiiMwYAi4opx8WpktBeGOXn
 qIYX+Jz8EpK5NoZw9vSHe6MgKVrS+epBDfFQQGrhoS6WBZ5XyztDslhgNb9rOR5BcM/Y
 yFV2GX8UQOtjY+gcbnLo69Eak1pXDMKaH88vazkzwDBAJ9wt+EMOPEovyLa59lN5D/eH
 3fPyxFYjEKaO5h6Yvu96IcSFe3sGQKpRs8oCxtxuZc6KCo1nItnswXMkvnKWZwicGT8q
 BI5A==
X-Gm-Message-State: APjAAAXpe4bQiLlTKO5qcoVJEVV32zkDisGJr8mQYT4AgQuqZET/v4Fp
 W1JiY4R1YtU0Ocg2hxupntc/DWqZB+e9RQr8OTQ=
X-Google-Smtp-Source: APXvYqyPOO2KPpiypPNZc6CNNFMeZm5hXVupcX5kXqw9Y9q9RpZQFGS8JJu/VJZ97v1cmQm26MOs+W68LJRVvP0pBzw=
X-Received: by 2002:a05:6000:12c3:: with SMTP id
 l3mr7477161wrx.100.1566596917205; 
 Fri, 23 Aug 2019 14:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190823163931.7442-1-berrange@redhat.com>
In-Reply-To: <20190823163931.7442-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 24 Aug 2019 01:48:25 +0400
Message-ID: <CAJ+F1CJsYQDAMwD9pHifGzFT=vPanBeKrCDvYmzqO522MeLhgg@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 0/4] docs: add docs about use of automatic
 cleanup functions
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Aug 23, 2019 at 8:41 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> This is ostensibly about adding docs for the g_autofree/g_autoptr
> macros. As part of doing that, however, the existing HACKING doc
> is merged into the CODING_STYLE doc and the text is converted to
> markdown with a table of contents.

Why not rst, so it can integrate with the rest of qemu sphinx doc?

(markdown is quite poor when it comes to documenting code or
cross-referencing etc)



>
> Daniel P. Berrang=C3=A9 (4):
>   docs: convert CODING_STYLE and HACKING to markdown syntax
>   docs: merge HACKING.md contents into CODING_STYLE.md
>   docs: document use of automatic cleanup functions in glib
>   docs: add table of contents to CODING_STYLE.md
>
>  CODING_STYLE    | 216 -----------------
>  CODING_STYLE.md | 613 ++++++++++++++++++++++++++++++++++++++++++++++++
>  HACKING         | 257 --------------------
>  README          |   2 +-
>  4 files changed, 614 insertions(+), 474 deletions(-)
>  delete mode 100644 CODING_STYLE
>  create mode 100644 CODING_STYLE.md
>  delete mode 100644 HACKING
>
> --
> 2.21.0
>
>


--=20
Marc-Andr=C3=A9 Lureau


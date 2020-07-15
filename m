Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB0CC433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 15:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A46142065E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 15:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARCArE6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46142065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvjDO-0002lC-Nk
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 11:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jvjCX-00025N-8H
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 11:20:05 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jvjCV-0001At-Mg
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 11:20:04 -0400
Received: by mail-ot1-x341.google.com with SMTP id 5so1721440oty.11
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 08:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DieFAP7dW/+WPl1wQsezQ1P/uIed9Sx79hgMBR1mXGo=;
 b=ARCArE6+vftQmR9VKx9jTMhU7uxDKdnW2MRPUJZEaCDd8lVZlg2JgGKAU1at0yJEO5
 vRX+y2gGC7gopxeVzTTT/jI9lw6igZ3rxPHCVoxMbRKdmfBZ7IYTdkieSwHxMvfRREqF
 ppTBfjJP8h6OtnMbE9H86o6zprvLsf+FonEfuB7zkvhi04u8Dj88kSw2SvvLytcLWcoQ
 uahJ9Gqjr9qUAhV1k21+V58jI4MxWHp3zZyEGrscfQvuGsgG36eB8njqcdAFQJHzeUNz
 NfWOyT+HVwdLyRRP1fJlwn9YEKarc2f0ze3P7NrWlb88sfb7Xptoy6pMgwn9EY4WFwZ+
 AHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DieFAP7dW/+WPl1wQsezQ1P/uIed9Sx79hgMBR1mXGo=;
 b=X9p+TEBWHyMk8Tzb7cDEnq+yR1Rulp6AN7zJWQ5sMpQURplVv9jJWSzsVQyWCLY5+b
 8/Ym6OAMken8MkcbauCPsm/6H5SJyp0M/CKFwV5ncDYgztUAlLftzoQ3noqS3WkkyN15
 q2sHBi9tBzZGQQDj6IVfyiygIwd7y+U764nq8044TjWIysMCAZYOAHBciW0M0FhkcWHY
 YsWHoLQCIuBJejzS4e2BCi3ydPJhXVZBh9wraCM0sKygJJucMBrLAgv8RNTnk9+Ayos0
 Y2zMAzhFr/l83axGzHShXQaRGYjP5INrijVMj7/tRW1sgR98FXtxmOL3fFZ39LTmY/WV
 /wTQ==
X-Gm-Message-State: AOAM531RLWPQzzua3L/EWOabimMU27ntVShUuTS3R3YfDY3TGYGZYYZB
 gjdBRmGL+kc4/WX4ogERvogrOTXWfuMHv0h6skc=
X-Google-Smtp-Source: ABdhPJybP+zOPIGhmynqI1XwXvTPHM5v/7bwkSfvuRSmIDAyjJy6bwkh2XYQ+NzDkagte4NwRDCi1ikCEyhFnW29ct8=
X-Received: by 2002:a05:6830:15c3:: with SMTP id
 j3mr78841otr.353.1594826402378; 
 Wed, 15 Jul 2020 08:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200714160202.3121879-1-armbru@redhat.com>
 <20200714160202.3121879-3-armbru@redhat.com>
In-Reply-To: <20200714160202.3121879-3-armbru@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 15 Jul 2020 23:19:26 +0800
Message-ID: <CAKXe6SJMJr03VgLGTdO8Xd1cYuDTBGUbe3PiKedvdtddmTsQ5g@mail.gmail.com>
Subject: Re: [PATCH for-5.1 2/5] qom: Plug memory leak in "info qom-tree"
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8812:05=E5=86=99=E9=81=93=EF=BC=9A
>
> Commit e8c9e65816 "qom: Make "info qom-tree" show children sorted"
> created a memory leak, because I didn't realize
> object_get_canonical_path_component()'s value needs to be freed.
>
> Reproducer:
>
>     $ qemu-system-x86_64 -nodefaults -display none -S -monitor stdio
>     QEMU 5.0.50 monitor - type 'help' for more information
>     (qemu) info qom-tree
>
> This leaks some 4500 path components, 12-13 characters on average,
> i.e. roughly 100kBytes depending on the allocator.  A couple of
> hundred "info qom-tree" here, a couple of hundred there, and soon
> enough we're talking about real memory.
>
> Plug the leak.
>
> Fixes: e8c9e65816f5dbfe18ad3b2be938d0d8192d459a
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

I have also send out this patch.
I hope the maintainer will pick your patch.

Thanks,
Li Qiang

> ---
>  qom/qom-hmp-cmds.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
> index 9ed8bb1c9f..aaacadacca 100644
> --- a/qom/qom-hmp-cmds.c
> +++ b/qom/qom-hmp-cmds.c
> @@ -96,8 +96,10 @@ static void print_qom_composition(Monitor *mon, Object=
 *obj, int indent);
>
>  static int qom_composition_compare(const void *a, const void *b, void *i=
gnore)
>  {
> -    return g_strcmp0(a ? object_get_canonical_path_component(a) : NULL,
> -                     b ? object_get_canonical_path_component(b) : NULL);
> +    g_autofree char *ac =3D object_get_canonical_path_component(a);
> +    g_autofree char *bc =3D object_get_canonical_path_component(b);
> +
> +    return g_strcmp0(ac, bc);
>  }
>
>  static int insert_qom_composition_child(Object *obj, void *opaque)
> --
> 2.26.2
>
>


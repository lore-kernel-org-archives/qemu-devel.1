Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B200C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 20:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE08206D4
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 20:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MeCRnp3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE08206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3QEy-0008BQ-9a
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 16:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3QEJ-0007hT-Aa
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 16:41:43 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3QEE-000689-C1
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 16:41:42 -0400
Received: by mail-ot1-x342.google.com with SMTP id h16so14375679oti.7
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 13:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=56lTE6Yn48eYbbnrbtiEUvbxsjuTwdnLJdBv+VjKung=;
 b=MeCRnp3+fzQiH8WKuIqtsUiqBTL1USmHK0WHyUpYRTG75XyWBm3ClGC6cLELUlJiWI
 v6nBfTGluNP+WolOgtJ794jXTGdGmJuwAdr7rKkP7cZlQa4PKtW99TOPeUUpYUsbyf7t
 K8H0PPDza9ucSmqCTn5ginDlzoF3aeav0NVmIrpng7B61YY+1B6PLI5Tjiws1wwuA2H3
 PiKGgTdjA6Hqy9YEz3UlVhyjiHUFux2JAjTWhBnq5gpZ3kVC3tpw3tUTOGr6Tf6pk9zk
 FsUZk+E5nVNbAx3bmqhhdhwKkbm53iiCnCVTkO5CLTsxpwRX4QeCRx+aUQI57U2Tjn2Y
 x7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=56lTE6Yn48eYbbnrbtiEUvbxsjuTwdnLJdBv+VjKung=;
 b=AfoG+iq3KWhn3wLcTvk5Pg9RJAIW4J+SY+ssA6L8vfxOisyObdOFjMNr+rijsyf8V1
 Yc2rtuhYYw+H7b2YZOq3pVWbSib44ARX1uhz5JhRITAuvBB8Z21yFLrNGS36y0qe+RXv
 UULZzFe5/nKNe4XQzmhITgse5MS1y3BB74V3kDsOdsHC+73/yDkDxUD8hRtPh8VQcalj
 IhV92CZUv8LdEUql2iwzKJfMZ/VgTVGDmSG9yl9k0yixBL6n2xtBHBPXsL2kjRZ6iq5x
 YFS97br+24WNXMNqGIZUuOzOEhFA2Dcx9cKwLlRaR9xhhEn/GyBh7DGCbVb65hrkhugm
 qICA==
X-Gm-Message-State: AOAM531bUqx75+oZyFp2VQY98xXZvL6unUnJvNWRB7sn5luy69HeMWmo
 yxKfGS6gZLYn/jpgb7bGxNh3k+uOaIaVRMaEESchmg==
X-Google-Smtp-Source: ABdhPJxW5FWiGkqMYJrWhPAadkMkQip67LQ18ukcKwNhVlB+DVTh2dr1Ok82L0ET7GPoB/1lmiDK/JOUi+kdfR7zJUM=
X-Received: by 2002:a9d:3b61:: with SMTP id z88mr4422244otb.135.1596660096947; 
 Wed, 05 Aug 2020 13:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200805194812.1735218-1-ehabkost@redhat.com>
In-Reply-To: <20200805194812.1735218-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 5 Aug 2020 21:41:25 +0100
Message-ID: <CAFEAcA8-REfRgq=713Tq9PfSNmRPZVzBKmLzoWLauZjqF5q5eQ@mail.gmail.com>
Subject: Re: [PATCH] ide: Get rid of IDEDrive struct
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Aug 2020 at 20:49, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The struct had a single field (IDEDevice dev), and is only used
> in the QOM type declarations and property lists.  We can simply
> use the IDEDevice struct directly instead.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> @@ -327,7 +323,6 @@ static void ide_hd_class_init(ObjectClass *klass, void *data)
>  static const TypeInfo ide_hd_info = {
>      .name          = "ide-hd",
>      .parent        = TYPE_IDE_DEVICE,
> -    .instance_size = sizeof(IDEDrive),
>      .class_init    = ide_hd_class_init,
>  };

This is one of those areas where this change works and reduces
amount of code, but on the other hand it means the QOM type
doesn't follow the common pattern for a leaf type of:
 * it has a struct
 * it has cast macros that cast to that struct
 * the typeinfo instance_size is the size of that struct
(it wasn't exactly following this pattern before, of course).

We define in https://wiki.qemu.org/Documentation/QOMConventions
(in the 'When to create class types and macros' bit at the bottom)
what we expect for whether to provide class cast macros/a
class struct/class_size in the TypeInfo, essentially recommending
that types follow one of two patterns (simple leaf class with no
methods or class members, vs everything else) even if in a
particular case you could take a short-cut and not define
everything. We haven't really defined similar "this is the
standard pattern, provide it all even if you don't strictly
need it" rules for the instance struct/macros. Maybe we should?

Just a thought, not a nak; I know we have quite a number
of types that take this kind of "we don't really need to
provide all the standard QOM macros/structs/etc" approach
(some of which I wrote!).

thanks
-- PMM


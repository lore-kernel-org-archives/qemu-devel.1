Return-Path: <SRS0=L55N=BT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB98C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 06:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4E02206C0
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 06:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E02206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4exh-0003dX-Sc
	for qemu-devel@archiver.kernel.org; Sun, 09 Aug 2020 02:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paulburton89@gmail.com>)
 id 1k4ewm-00035v-MA; Sun, 09 Aug 2020 02:36:45 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paulburton89@gmail.com>)
 id 1k4ewk-0000pS-TN; Sun, 09 Aug 2020 02:36:44 -0400
Received: by mail-oi1-f193.google.com with SMTP id o21so5989282oie.12;
 Sat, 08 Aug 2020 23:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=o8oOH1CAijstfPClf55haIpg1h2dcOqUJrPHuZ9nxtg=;
 b=sjYSpgyRH6PgAlDMG1frb19W4pCG8X6Tu0tng7armCfIuvt8da8KPZAsJGu/gQ/T61
 TY77JJDEFlLJw3MTu5cQgBS5VMiBlX45bgaE2wOmRm8/0YDrOJA8kfBfvAD3QhnbJL63
 5rqrIYMn7YAvz34WID/at9Gr07TyTdJHa9NKKprMzGBlT6HxM9u8+HRXLmAV1eS+Hah+
 QCAHJC3QPQy7BHis8+4z1Di07dm8caU7EjDhqf2RI0cX28CujSUHns1B2kMbkOOXOAD5
 3YujwNBv7qQcweAGJ16wghb8JH2ef3X3+PfRoI+HHQz9MFDc0Ryyyj1BOxvjk5yeVtlW
 crUA==
X-Gm-Message-State: AOAM530iGJKFBWdEhnsZRn+Jn4zUqsgrDJGW2SCmXznfMCNoA8sfAiWR
 /WpHiE31HIq/ZvXgdVbSDHlR02QB5yJEZg==
X-Google-Smtp-Source: ABdhPJw2z+GXCU4Wy3iwdltSfBOJAphb7viuejwtwKwrXT/cTmjc12BlsY5UQXyputhZ/MV4AunMEQ==
X-Received: by 2002:aca:d68a:: with SMTP id n132mr17474914oig.16.1596955000397; 
 Sat, 08 Aug 2020 23:36:40 -0700 (PDT)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com.
 [209.85.210.48])
 by smtp.gmail.com with ESMTPSA id p189sm1369031oia.18.2020.08.08.23.36.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Aug 2020 23:36:40 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id c4so4825282otf.12;
 Sat, 08 Aug 2020 23:36:39 -0700 (PDT)
X-Received: by 2002:a9d:1b62:: with SMTP id l89mr7850057otl.145.1596954999610; 
 Sat, 08 Aug 2020 23:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200707022544.24925-1-f4bug@amsat.org>
 <19b2c623-7c8e-fd93-290f-86498b85caf5@amsat.org>
 <932a272b-bc80-f6e4-d51e-32e2222f540c@amsat.org>
In-Reply-To: <932a272b-bc80-f6e4-d51e-32e2222f540c@amsat.org>
From: Paul Burton <paulburton@kernel.org>
Date: Sat, 8 Aug 2020 23:35:28 -0700
X-Gmail-Original-Message-ID: <CAG0y8xk6qEzTXup7jJojmLK9n4KWTCq_z9FULeyyru7Ux3iM_Q@mail.gmail.com>
Message-ID: <CAG0y8xk6qEzTXup7jJojmLK9n4KWTCq_z9FULeyyru7Ux3iM_Q@mail.gmail.com>
Subject: Re: [PATCH v2] .mailmap: Update Paul Burton email address
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.167.193;
 envelope-from=paulburton89@gmail.com; helo=mail-oi1-f193.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/09 02:36:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Thu, Aug 6, 2020 at 6:50 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
> ping, as I'm still receiving "The recipient email address is
> incorrect or does not exist in this domain." from wavecomp.com...
>
> On 7/16/20 8:56 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Paul,
> >
> > Do you mind Acking this patch? QEMU's get_maintainer.pl
> > still selects pburton@wavecomp.com for various of your
> > contributions and wavesemi.com (where wavecomp.com seems
> > redirected) keeps sending "The recipient email address is
> > incorrect or does not exist in this domain."

Sure, sorry for the delay:

  Acked-by: Paul Burton <paulburton@kernel.org>

> > In case you don't want to receive any more emails from the
> > QEMU mailing list, you can Nack this patch, so I'll have a
> > good reason to insist with the alternative to have a
> > 'ignore .mailmap', suggested here:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg717757.html

I'm happy to continue receiving mail, though right now realistically I
don't have the time to do much with it. Perhaps that might change in
the future.

Thanks,
    Paul


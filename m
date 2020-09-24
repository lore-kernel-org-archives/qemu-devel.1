Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF17EC4727D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:14:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51822212CC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yRpmKNde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51822212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLS19-0001hl-4A
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 10:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLS0Q-0001HS-VJ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:13:54 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:38576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLS0I-0001mw-Mb
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:13:54 -0400
Received: by mail-ej1-x641.google.com with SMTP id gx22so4715798ejb.5
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 07:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nUOVrpmC7WGmlNcFm4nyKVE00d/h3eBFoS0GDRj2zVk=;
 b=yRpmKNdeXAdlaBAy6uSf0Lr951vGe/sAN+AA+RUMAA57q7j+RhvvP8Kzs0CgjYhEFD
 /vJZfGxDBX0UuVpv8yivQ/URfFBEY0SV0rS0u+yZ6Oh0mVos07JxALUpp7wM3O6BoSwS
 ii4CVQTOVysGdvMOYEW+01iKpPhmCX6VY499r7cuMabI79/8hAKC2pwb/9fGmwH6Yrc3
 SQNTc4FZOcxGMM3MuIbBg7uvpL0gJr3742YIjv9bNoHaotQvjAX6TuZ7/Yas1yXo9qGY
 ISMQ+k/CXmPfB/A3NgczeHWzjL3OJjogjn+Tl9ijLI4d5JvkGQ8uTHJTaHv1BVHogH3b
 JE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nUOVrpmC7WGmlNcFm4nyKVE00d/h3eBFoS0GDRj2zVk=;
 b=ucgSQVT8KWERXOqgxxeojfVlajqo1Dkkkmf8pclqhzxrsB7AeslW6ehLXgzQv7zaFy
 WSEb7VYDexzPAci0SGV3iR5GIJKPuLgZvzINtKebnW5InKSax3pia0Yj/UDekF73coeW
 ypH9VQQRuzmFLO7TktHs1Ol4wKHHubkfbP4VwSIi6ltO8z1FI6zxFxUxxHHamkUs7hjM
 iraHY4OiW4Dkq/FYO76t3EKY7cXfzNU9Yl2MTnoJKsVteUZUw5yaF91A7fj3D9qZ+uws
 rpP7uvhSfNb7dnMBoi+98z3VgL2p1J7+Rzy4IfqHcyKqmoJmYh+V8+2ifXRHGTR/9vsn
 viPA==
X-Gm-Message-State: AOAM532vi/sBI/tTVDBkBARmqTYN23OIBXRYx9BDMI5ng9enoLy1GGTf
 cmrM3zLLbk/3lzArX5OyZEidxX1mNKBgW+a49Qpyww==
X-Google-Smtp-Source: ABdhPJyw6lOsH+uKQiN820W2t+jNZpWpvHy/V+50K/1HoNamI+XOemDrdQP+WwFNhMHMLueSIFAReYvOURp+i5KP6Ao=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr136302ejv.56.1600956823332; 
 Thu, 24 Sep 2020 07:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <CAFEAcA9cyKVwONYuzG3oPcQQ9sibpdtetCjcBe3133gd09Aa9w@mail.gmail.com>
 <87d0314nmp.fsf@dusky.pond.sub.org>
 <CAFEAcA9ABUwa_TnyczsO+TtSncX0hHwN7_zgyGGWP6nWtEkdDQ@mail.gmail.com>
 <87eenhzget.fsf@dusky.pond.sub.org>
 <CAFEAcA_zWkthoVGr+6NbjqsWvrinJ1R6gVaA2HAVauOy8ENGDA@mail.gmail.com>
In-Reply-To: <CAFEAcA_zWkthoVGr+6NbjqsWvrinJ1R6gVaA2HAVauOy8ENGDA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Sep 2020 15:13:32 +0100
Message-ID: <CAFEAcA9enJKCjDeAaW6AOz8Udxh5fOVznOzC56rjg3G+5NNCCA@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] Convert QAPI doc comments to generate rST
 instead of texinfo
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Sep 2020 at 17:05, Peter Maydell <peter.maydell@linaro.org> wrote:
> On Fri, 4 Sep 2020 at 16:54, Markus Armbruster <armbru@redhat.com> wrote:
> > visit_module() lets you see the modules.
> >
> > visit_include() lets you see the includes.  The same module can be
> > included multiple times.  Having to filter that out would be annoying.
>
> I don't think you'd need to filter it out for this use case -- I
> assume Sphinx would just ignore the unnecessary extra dependency
> information. But if visit_module() does what we want and you
> recommend it I'll look at that.

visit_module() seems to work. I notice it gets called with None
before it's called with the filename of the top level qapi-schema.json,
but it's easy enough to ignore the 'None' call...

thanks
-- PMM


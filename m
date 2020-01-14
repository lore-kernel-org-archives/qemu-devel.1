Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A5CC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:17:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485A624672
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YxPC+qVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485A624672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irKC5-0002Zg-JS
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 06:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1irKAH-00016n-4w
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:15:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1irKAF-0003k1-N8
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:15:16 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40413)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1irKAF-0003jX-G9
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:15:15 -0500
Received: by mail-oi1-x241.google.com with SMTP id c77so11409522oib.7
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 03:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PkanoPOF5W/d/hIfHK4PAFGtwOaU4hbXASfwdt4t1fw=;
 b=YxPC+qVt6GrgMiu1O8iO+pr+mnGgcEyhNOeRzBmBe5upCK0aFMk9JSclW1Q3f3n7rc
 AnANnZAtomXAgUCh6D/CMPwd849AQC9fMo2clNn1V0+4HnP88i2E4IYwE+a/dxye+EIJ
 xaUgxSIlpz/Fgf4bE5qa1GUvse3ZkouljAp4LxavLq/Mwg0hyxWJ/NgIB0eNiFyE7Nr2
 hX0WKtvkKUue1kHUwetnSIGMV8YtNXRDxVd2e/wAgshGxYnEUfO84gmrMlUYiYL5PzXB
 ePTU1+k4IOGRSvntsjekyqK6BRDkq1YMKxGE1KEtIVTGOgTlT+SloAU09nOZpOyqI3iE
 UEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PkanoPOF5W/d/hIfHK4PAFGtwOaU4hbXASfwdt4t1fw=;
 b=ZJK6Yf5OifvyDe647oCLYQGrsTF37CXqNq1+JbbEgHfRYBzLtdfUOLND2uLZVfLb7T
 dqzrcGIJSe+eogEOAytiNbSf5KP9uRRhf4h5bfRORwBwRBolnkHELsGNvdRW9rOXe284
 Uyxrrt9tPeZD6b6IVeqWWkWlq0YdG0hpf5pGpYeiOj7sOcKWlbwZ3kZfhZCAluI819Zl
 I6RS4iYzdl1I+qgsecH7spiqi/ZXbqPibrfOABT76/Ea3FMzFthe1kmztgfEWbu4RDWf
 sdBHebWPc8kPnlWo0qpgfLH5mmCi0BfD+j15HZNYZKCaYNv/IDY4svoWDbnXIOmHbdu2
 GYzA==
X-Gm-Message-State: APjAAAXMyp3LwAxCH6pojDPmhSLigR4zd/vDL8HIYAXzLv3/fAiVqiN0
 MrxUA+g6am5sNUWqP42fIzt6/1p240fhXw2FsDyceQ==
X-Google-Smtp-Source: APXvYqypf0ZfJKHlMImBuL1jeI6uYQQr5UJYZzE34zITVIwmVXCK3n1+gA4IVcbLjJ2MzTkFVdvqnEMcK878iC5VRMY=
X-Received: by 2002:aca:f484:: with SMTP id s126mr15418659oih.48.1579000514604; 
 Tue, 14 Jan 2020 03:15:14 -0800 (PST)
MIME-Version: 1.0
References: <20200114092606.1761-1-quintela@redhat.com>
In-Reply-To: <20200114092606.1761-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Jan 2020 11:15:03 +0000
Message-ID: <CAFEAcA-7aLrp4n9gtD=0MzmMDpzNyJCUpOmY2XPxNOun5MKeGA@mail.gmail.com>
Subject: Re: [PULL 00/29] Migration pull patches (second try)
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Laurent Vivier <lvivier@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jan 2020 at 09:26, Juan Quintela <quintela@redhat.com> wrote:
>
> The following changes since commit 3c8a6575985b1652b45bfa670b5e1907d642cfa0:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200113-pull-request' into staging (2020-01-13 14:19:57 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/juanquintela/qemu.git tags/migration-pull-pull-request
>
> for you to fetch changes up to 4eafab585c091050b5ae63130f46fe46ac919c3a:
>
>   migration: Support QLIST migration (2020-01-14 10:17:12 +0100)
>
> ----------------------------------------------------------------
> Migration pull request
> - updated QList patch
> - initialize local msg variable
>
> ----------------------------------------------------------------

Still fails on hosts where ram_addr_t is 32 bits.
Looks like you still haven't got the fix for the problem
Dan pointed out where multifd_save_setup() is using the
wrong type when it calculates p->packetlen to allocate the
data structure.

thanks
-- PMM


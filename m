Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5F4C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B564720828
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mf99tiKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B564720828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2aC7-00024z-DK
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 08:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2a9o-0000wf-Fx
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2a9n-00032b-7n
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:01:04 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38893)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2a9n-00032F-26
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:01:03 -0400
Received: by mail-ot1-x341.google.com with SMTP id r20so18372284ota.5
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 05:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S6oqYQ+qGNQP3qQKYGLj/r5nF6Wrh1QkhSlHg/ZPbxs=;
 b=mf99tiKzbLDPQ6ef6v/giZKYX2tdOxVCHKUVfoST+HH6bopUlFc8iiQYxupIz3rZH4
 o7+CGU0Ojjka6he+fFxrgA3oQROsF40AWDNnO0cQusWfGoh3RYw1CYaX6gTUhnjqJaEu
 WCnk3MHgq49HrdD56mpLhQjUZazJm/1sodMb4TK1A4261JdqUlYRMqCvJQOy6CwA5mSN
 VfveUfDgyhgIhirSVA96RkV+GhtGHQMK2lJ3eFoTEXUgIZL7guU9SU8uygiaSEQqIQCO
 FnFQ+JUx2SyjKA1HOtk8MQz0Uql7ON1rSq7DIK2CYPPXGIv/6OuW5YrbwmHQWAoBCq6K
 WbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S6oqYQ+qGNQP3qQKYGLj/r5nF6Wrh1QkhSlHg/ZPbxs=;
 b=CcSkkxVffjom8ZE89bBq/NJTmlgDgWhwKaRXvtPgw5MiiWie+7qLrqjXRVvnnKKapK
 Lw4PT9w0TGxr6OYTzbGjbaGX3RIS84zMGWS1BXtPx875X+dzOnZCbOw4W1aT+PLf0eu7
 zo1nU07czGerFNq04xt65AfqFmRMyCsPWj9JuPyzFsMlYm+7399FDTAO6jABAScdrP53
 hQc+vxNytxfgzndpj0ZYcvgld/XUZznreDSBvk5ubg+iJwQYj0M2wne5IARbOYcSAIw5
 01spgNa2vgA++R9Sm2euKmT1M2mAmVgTNoM2DlxeUND26AydDFxBmEQ+r95Or6hT6AZ7
 YJVA==
X-Gm-Message-State: APjAAAUnWXdIbvtGQfIJYl9S6ORwMe7KIquwDxMJIjNSdYNLq48gll4v
 yIfvEzAYUNuXzX3cx9MDS8LWWzLl4mTKQmqbqDs5Gw==
X-Google-Smtp-Source: APXvYqz7V93IYohrQEkC6cSpgx7dZgqSoQ+n9sfcnlEY9iDg+rAGc1ehXlFhzf+ocehVRWtmFa3VFP/Z3jEkYy83UKE=
X-Received: by 2002:a9d:5e10:: with SMTP id d16mr2915206oti.91.1566907261814; 
 Tue, 27 Aug 2019 05:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <1566495734-23297-1-git-send-email-pbonzini@redhat.com>
 <9492af41-2125-9543-203a-312f0cd9087c@redhat.com>
 <CAFEAcA__BNnW4oSyv4iTAd7rsMUfcjyNJgk0nOwbkRQtmLj9jQ@mail.gmail.com>
 <dd473e9b-716d-cd9f-47bd-433d2b17687d@redhat.com>
 <CAFEAcA81qUSMqpMTCrs9-vgj7Wmji2dCDkYrQ91wxmhTiP83Xw@mail.gmail.com>
 <dd60f779-8349-1d0d-eb86-645e2e1b0808@redhat.com>
In-Reply-To: <dd60f779-8349-1d0d-eb86-645e2e1b0808@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2019 13:00:50 +0100
Message-ID: <CAFEAcA9i1p6XR8Bc83uHD88EWrtmU-aN_PsuZYNAAFgpgWoZgQ@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH] modules-test: fix const cast
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 at 13:10, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 23/08/19 14:07, Peter Maydell wrote:
> >> Are you going to apply this and "[PATCH] modules-test: ui-spice-app is
> >> not built as module" to qemu.git directly?
> > Is the other one also needed as a build fix ?
>
> Yes, otherwise the test fails (it didn't fail in the meson tree).

Both this fix and the ui-spice-app one are now in master, but
the 'enable-modules' Travis build still seems to be consistently
failing -- could somebody take a look, please?

thanks
-- PMM


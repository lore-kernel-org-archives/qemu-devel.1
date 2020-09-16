Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0CBC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B10020770
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZL24bEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B10020770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWfA-0005cp-GT
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIWaY-00089V-Jw
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:31:06 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f]:38043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIWaV-0005lB-Qd
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:31:05 -0400
Received: by mail-ej1-x62f.google.com with SMTP id i22so10097816eja.5
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 05:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QsyQtjBhgMML5i8VvWbY33ngdnJBXWnt6l+KWleGPgk=;
 b=GZL24bEfymwqljYwg/If5iriLNmgMyrnA6a8kdaumLrqPzCvBtc09/V9yRwYIWh6oZ
 fo04TNxyOGv5PV33R+J6Fry3uwGfRpWxr7Y5Jj76x8FIoO2sYyga7z6tPsFjlJhTMNjN
 R6j2J5cZASRNIKtjTByvr6KKCMupndVXX7sFixmn+41J8V+nLcS5KutsMb8MCTyMIZP2
 cgv06dTSqSGy75qYFKacUDmG9L9T3bJZJK3mBjzksIkPJLDXx/BWJm/V2Lmz/COej3KL
 sG9SS5dcTuoCY4bdNG0IkexI2lEmvNA/6LipoI0EnCH5Y9LHH4Gx80K22eWu5ObFNsxk
 gz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QsyQtjBhgMML5i8VvWbY33ngdnJBXWnt6l+KWleGPgk=;
 b=q4fLG6cwBSm9LM2fGBHFwDwD/igEdbzJ1ITaSUOczzz9q0MqFsDokjghi9FwhwAI6A
 i2CLOaDiku9P0geS7quKbuUClg3sX6WrJ+J0Y0bnAii8qfWvjZecpxm/diadoRiqnqce
 UZULJyjrWnmauN11aXR3S+iQ6qYLEjZoPX7sgBvRai3bNZiPTo3clrgkZXLQnG59IgCG
 YEAutQ2v9SOVSqgctS/iN0fDZBNbjFVVngRHVu4M5/hOx8AfBVmKRt2KI8dCoed8eZtT
 ZX0cS+lDbGMlsJLPbvIkCnD800kLCfpy6oK4Q8PNGs6xW8B/BdkCgoQOZnwm02D4+UX5
 QbBg==
X-Gm-Message-State: AOAM531rYHb3DTz17+aU5+YqZLkZUV4btfwiecwAQGhjqgk16J/TH3IV
 GFIswqeUt7sc7X1JNrlgbjyOrgW/2w0Z/eX7wwtVrw==
X-Google-Smtp-Source: ABdhPJwAH/mWssB/HpqxczgSKW0Nt4qnSVpmKYRJbBIflMdUYL73ryvAhLdLM7Z8ui5944GJ9DFlvCE9/+VZQjf9aVo=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr24516517ejk.407.1600259461348; 
 Wed, 16 Sep 2020 05:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <875z8eupyp.fsf@dusky.pond.sub.org>
In-Reply-To: <875z8eupyp.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 16 Sep 2020 13:30:49 +0100
Message-ID: <CAFEAcA8q8J1n2UqsNbHgNwEedA8pZ6fNA7obCR1REN-33nvmkg@mail.gmail.com>
Subject: Re: Python 3.5 EOL; when can require 3.6?
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Sep 2020 at 08:43, Markus Armbruster <armbru@redhat.com> wrote:
> We require Python 3.5.  It will reach its "end of life" at the end of
> September 2020[*].  Any reason not to require 3.6 for 5.2?  qemu-iotests
> already does for its Python parts.

I think these things really ought to start with the converse question:
what is the important new thing that 3.6 brings to the table that
makes it worth moving our minimum requirement forward ?
If our code still works on 3.5 and there's nothing we really want to
do to the code that would be awkward to do without insisting on
3.6, why should we irritate users by arbitrarily bumping the version
requirement ?

Also as Dan notes upstream's EOL policies aren't very relevant,
because our policy is based on what distros ship.

My broader point of view: C does not have any kind of infrastructure
like Rust's cargo or node's npm that makes it easy for a project to
say "we depend on these versions of these other packages" and
have them be satisified in a fairly painless-to-the-end-user/distro
way. So I prefer to take the approach of being as conservative as
possible about what we depend on, because the alternative tends
to be either pain for the person trying to compile QEMU (when they
have to scrabble around finding and building dependencies they
don't have conveniently to hand) or pain for us (when we have
to ship a dependency as a submodule). The default should be
"leave the version dependency where it is", not "bump the version
dependency as soon as we can".

thanks
-- PMM


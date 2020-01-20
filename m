Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC6FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 12:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C3922314
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 12:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cWHwDmFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C3922314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itWZz-00014r-RR
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 07:54:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1itWYo-0007pt-9W
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:53:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1itWYn-0006EF-4q
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:53:41 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34830)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1itWYm-0006DF-Ua
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:53:41 -0500
Received: by mail-ot1-x343.google.com with SMTP id i15so28581751oto.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 04:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rPUQgxbNt28v+xZioZ+TnIb4xogo0q0DUKu1Ga1Zxg4=;
 b=cWHwDmFfrsC1kOeUFLjnxVNhtcz3qCdwcA4OOoPBv9zIX7+CRUb1xziMxyu17Zu2GP
 332URyZYKPctyeHtp9T4I1Dgn/0l8PTID9FrfI+ike6/+DWqaMJ+CJzfybuIAaba9urP
 RW5WbBXxH+ZWDlNPfvHXY+K066d+fAFBd6ogT9W0IHyAjfpAcS2fSRqOSfYsiYrUcYd1
 u5HVy6umdhnSWl7dWr+ESWzEY3MthSqLSNijz3PPEq+5eMpD512snDMUul97wM/Zgl/B
 Tj75OXH2pQgB+daURObngReDOWAiHdmbb5vBdhyjG13IAIdhg3U18GSZ68uBGRTZPHU/
 6yUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rPUQgxbNt28v+xZioZ+TnIb4xogo0q0DUKu1Ga1Zxg4=;
 b=uKmz1nTH9sETGx7tC+q0HZWJuXYlNflK7OkZVPQn4lFAzxO6gcePk0WkUj/oHWUpEE
 NZ+CYSQb42c8muS7LBTGx3bxxZuvOqUEpxB+TPvRbZpF1A0qJrCwMp3pGiWBbjFkDof8
 ukuglA5VFSE1a8gJf050BrawXdCr+3ApBxEBqdulS0PkKglHTE7Rr8tcIK1cuXJeLeZe
 14T2EmrfwlkwW7Gt+etgNJZ1+1KMhuQoGPzJOceOAKm5y6mmUmr7evPNkE4KFkjzAWsx
 ssxm6300Ae6xgvNNgKef3MWHe65aspaJL+cXfiZd7sdiyKmoMrv1lSlrueUUr5YqZUVC
 +Eyw==
X-Gm-Message-State: APjAAAVrDhaC9lGhIxFH6V6TkwpeMgEe6aHngjhU9lq3NeZ++jNPGqPd
 XVJ1wKdZKHjYH6SRN4Dsircqz+xorHm9RhkfgYPPiQ==
X-Google-Smtp-Source: APXvYqxwrv4RSH81e/ccWBksf+JP+s+RGoApkNNrPaZzuSZxjhmODz+v4sy4weVEdiZ2+nGvJzHP+4YbER9BF+ts7Ms=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr15815021otd.91.1579524820215; 
 Mon, 20 Jan 2020 04:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20200116202558.31473-1-armbru@redhat.com>
In-Reply-To: <20200116202558.31473-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jan 2020 12:53:28 +0000
Message-ID: <CAFEAcA-2thEDyV9CdTgWdYbeq7hCjg8KCoy7jdomgancM0Mqww@mail.gmail.com>
Subject: Re: [PATCH] qapi: Fix code generation with Python 3.5
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jan 2020 at 20:27, Markus Armbruster <armbru@redhat.com> wrote:
>
> Recent commit 3e7fb5811b "qapi: Fix code generation for empty modules"
> modules" switched QAPISchema.visit() from
>
>     for entity in self._entity_list:
>
> effectively to
>
>     for mod in self._module_dict.values():
>         for entity in mod._entity_list:
>
> Visits in the same order as long as .values() is in insertion order.
> That's the case only for Python 3.6 and later.  Before, it's in some
> arbitrary order, which results in broken generated code.
>
> Fix by making self._module_dict an OrderedDict rather than a dict.
>
> Fixes: 3e7fb5811baab213dcc7149c3aa69442d683c26c
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> --


Applied to master as a buildfix, thanks.

-- PMM


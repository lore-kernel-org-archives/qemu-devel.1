Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FACEC3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 15:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AED6208E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 15:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LqxOifj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AED6208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5XH3-0007Kf-Ur
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 11:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5XDd-0005c7-SY
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 11:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5XDc-0002vE-Iu
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 11:29:13 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42789)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5XDc-0002up-D5
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 11:29:12 -0400
Received: by mail-ot1-x344.google.com with SMTP id c10so9646149otd.9
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 08:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XPiysgzzrlwavoBUqF0ZebF8dpHpsfevKm0wvL+5BIg=;
 b=LqxOifj4VDOq4X0Zjx1P6moqAtFDzGjv+nOA8TLau0uGAjL8/x0ZoqYwONK+SCg240
 4EECn5pjxcmq1BeifRcDsG9xI5yX9n6D3nm+jlcG674UACvlRYdcTBWvc7+uZS4XcOxP
 3Kv8TNO5JlzVkfmHV0wpnDYr7WjkXoV24LGJL9mTAFCS3jvH2XbZKkOOh43A68rXfsFI
 QgTvjNzNID/SMvp9tL4yInoiq/FWOvZUN12IfSh9s+4HK8iP2V6+vqTU3ELhvnvmq5dE
 Wib9BhrvempQ+WAg+2t5UCSfF/GisYLo6uGenfCSOR788ZNCoUhGNoV275MdHXmQasO7
 VbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XPiysgzzrlwavoBUqF0ZebF8dpHpsfevKm0wvL+5BIg=;
 b=kzdsYgIfsbwjIstQS+OlHmGj1MN3dYGmMMmRdus9CNqtEMCpIXniw5VcD9ZZCVRQCJ
 dA69ejLuJ+urWHFn4GbYJYOoSAP/joF/scEkVk6N8NdrSV6gO1utmqk25Shgs1pyFivl
 1eM7rdoK2K0ujqtmy2/0fdOT58/vZz0g30nvz9ayV3F2J5Fx85vtf3Q2kBu6cAoNC6ZB
 PFs9mU0yB9yxdJ4AV4oweVrIRrLXdueEPC2zqrCk8FfbZKuoj1JCnHEhc6I8QosROrYk
 Ie4Wkii/ix2FbNYkiq7T4fr+mXn+JBckuQqxF41LpGvuQHTzcbmuPqcQX/iUqGieqBE3
 OUaw==
X-Gm-Message-State: APjAAAVyhy7ltoKaciVBSr4C0LlHTLOtQ6lMOmtYdW62iSwjc3mmh6t1
 VjxniCQ7BFEVtxtBtj6T11NRXz+iPC4wEFd0zwVHJg==
X-Google-Smtp-Source: APXvYqwUmFP1ztTG6k/Mh7CRAwVveunOgK5dfJwWMEAsbvA1QY31i33KDkAjPUUoPrKbvFrEAyh5x5SoWQwObaGVEoY=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr34244058oti.135.1567610951615; 
 Wed, 04 Sep 2019 08:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190904062915.6488-1-quintela@redhat.com>
In-Reply-To: <20190904062915.6488-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Sep 2019 16:29:00 +0100
Message-ID: <CAFEAcA-U5xAn9TYGb6KRxkFiHy7nn5s73VsyhAGifnVmWBMUDA@mail.gmail.com>
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL 0/5] Fail patches
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Sep 2019 at 07:34, Juan Quintela <quintela@redhat.com> wrote:
>
> The following changes since commit 3483534ec314f6057e66966bfceaa9df02c28fbf:
>
>   Merge remote-tracking branch 'remotes/cleber/tags/python-next-pull-request' into staging (2019-09-03 16:48:37 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/juanquintela/qemu.git tags/fail-pull-request
>
> for you to fetch changes up to 0705e56496d2b155b5796c6b28d4110e5bcbd5d8:
>
>   multifd: Use number of channels as listen backlog (2019-09-03 23:24:42 +0200)
>
> ----------------------------------------------------------------
> Fix multifd with big number of channels
>
> As all of it is migration, danp told me to do the pull myself.
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM


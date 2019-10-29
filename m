Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674AACA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 21:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F6AA205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 21:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dp8SHQZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6AA205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPYwD-0007Ib-08
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 17:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iPYp8-0004y9-8s
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 17:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iPYp7-0005YL-5O
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 17:14:42 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:41396)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iPYp6-0004sh-S2
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 17:14:41 -0400
Received: by mail-oi1-x233.google.com with SMTP id g81so104011oib.8
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 14:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p6AwMAyYssP3pOykxQW2iNqfvcUdI9A8ccj9rhin2+s=;
 b=dp8SHQZ1khQfs0xcMf55KB1TnRcwE+ON5myVpjG87EIFhrpkBH6AEkPdcyTY9Vtp4e
 7dM5wuYpFfi9Y1rthDeX11GhghP5Rz/ZdMcuC7/a0F0SdhP+fOOFtc1lKJGHFS9JqWfv
 kSDuTRajpYVQoGOm2lzxWnCm6ZL0VsATikMi870NJklq/4gOOUCxdMlND/hEwUO1RAIv
 K605/FS/nW9vQ98CEsXZ1jbYee6S/b0ctxddTbHd+7VoM8jVXA56WB2FxwVxd/jTTAl1
 RDYUmpZ24BW6QOVBKPj8YH1DGnn9pSIO+NfEgEbEUfx7e/OkyzNIYoPDeHRRKdyRUWPx
 Q00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p6AwMAyYssP3pOykxQW2iNqfvcUdI9A8ccj9rhin2+s=;
 b=Oc80hJ4+BWOiQ1iXAKZq2v7NUVZBKenUQzdpzCOQ30xMbs25ECUFRb00CwKFF+bkdb
 zhJ8pjljXaJEF6zhFJEBzMZCpuA0k0e+7C6hGCX66xLaLLgtG0HtfcF3xGytsu6P4wC2
 /rUBwgi959G9WYGtY/O1BAdidpseiUYlj5k5er54/+wCKI/Y137d7lSV+qE6zLmah+n2
 MrSvf1/E7Xh5PvajPU2L8LDnJxHSqc2uMjlyv6yBsckIQvIWOj5s8yGK+zjfe2VWcQfS
 pxE/EHySuC6IzO4rnEUAm4X3EAYXSCzwX532KlNUHsOB3jtHZXIOngnQTnC2o9Rr2X/P
 mqlw==
X-Gm-Message-State: APjAAAWaRfLuHOMMXyKHQoGek3ZvW8fgPLYVirzw/zmf1ToBq9PWKE+M
 /I5MVT82d0m6qzjhKO5yMJSSYYqBowbTrxnc0o1aBA==
X-Google-Smtp-Source: APXvYqzppRFgwoY+G+aeJAx+Y0Ks1jdqZ2Nq5mOwkeYM0DbNsVuTG3ieUyD47FjSJZOvKYnxsptZ768kKvh8Z4NQ0+Q=
X-Received: by 2002:aca:3e8a:: with SMTP id l132mr1805315oia.146.1572383623228; 
 Tue, 29 Oct 2019 14:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191028235002.17691-1-crosa@redhat.com>
In-Reply-To: <20191028235002.17691-1-crosa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Oct 2019 21:13:45 +0000
Message-ID: <CAFEAcA9_ycm2nyJeAR-Y43VT6o6zkrUykNXJPQKYv8os107_wg@mail.gmail.com>
Subject: Re: [PULL 0/16] Python (acceptance tests) queue, 2019-10-28
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::233
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Oct 2019 at 23:50, Cleber Rosa <crosa@redhat.com> wrote:
>
> The following changes since commit aaffb853359829a37daaf883c773e8320b55c723:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019-10-28' into staging (2019-10-28 14:40:01 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/clebergnu/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to efdb45bfd72745038909dfd1e970a827cb8d5d7e:
>
>   tests/boot_linux_console: Run BusyBox on 5KEc 64-bit cpu (2019-10-28 19:04:04 -0400)
>
> ----------------------------------------------------------------

Hi; unless my scripts are driving gpg wrong, this seems to
have been signed with an expired gpg key:

gpg: Signature made Mon 28 Oct 2019 23:43:11 GMT
gpg:                using RSA key 7ABB96EB8B46B94D5E0FE9BB657E8D33A5F209F3
gpg: Good signature from "Cleber Rosa <crosa@redhat.com>" [expired]
gpg: Note: This key has expired!
Primary key fingerprint: 7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3


thanks
-- PMM


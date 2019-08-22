Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028AFC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 17:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C12E523407
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 17:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b4U8cefl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12E523407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0qoe-00055Y-1I
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 13:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i0qnP-00044E-DL
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:22:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i0qnN-0002Gi-QJ
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:22:47 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:37531)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i0qnN-0002GB-LF
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:22:45 -0400
Received: by mail-oi1-x229.google.com with SMTP id b25so4970686oib.4
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 10:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=b7Os2zPX887jxZFCMNAZGEH7Uv4sRCC6BXaQ3msmskU=;
 b=b4U8ceflAKMgvejL7cFRDPL8F+TmEUP7CpDMFbfYceHfTAKUh1wfDRLNsKRJNKdWiy
 mNJjwSHTqo0XWDw/bVc/a7wfYY+XWH6+mOusPPLwmWr/YgoM9xZzdbv72pM1m1+utnnr
 1qqQC3p4pa0vIY/s7jmcK3aSfbZtFbqSr/+ROM3wnEGHNlSvuQLXL/nqpU9NG3aQYV8N
 CNWkY8lDB1IDtqnx9xDOqbiNOWpW/AEHf0VN38mtBACNU71ufq2ogwi6Sm1tgS1yltge
 5Mg1qSxgZ0DWjFkZL/gj9kltQpVyT1dvTti+nz2b60c21KvA9gK5LLX0L0J07mny6VJB
 4aWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=b7Os2zPX887jxZFCMNAZGEH7Uv4sRCC6BXaQ3msmskU=;
 b=nwYv+YJjY2434JJxiHpkamaSLC6qQJ3Sl/j8K7RP+IDhiqR3PS+7S7MigOWLE/GABJ
 k21t0WUY0lWKe1l3dBFPjMETJ+rPwe6dk7eJ4s8i8eZHYRbjPeQSqu4qs561ZUUGLd9o
 XezdT//UIf18ijp3UJS0pZi+v/XSYZoXwhSNvMR2djygE9l3rqTTTcX5MmRXElO+iNNn
 FmrHW9AqCs8mX67uwq4vakuoH57jdFtkSFwqvtnVsCwfQc6bWJXEfph1xbkFkacz0hpK
 aNZKyFbgHOuiCzHsrdQULcFFZpsVUsJ8uADkN4erwey/dMyaWdf7J/peWfby3l2uI0k2
 Qnxg==
X-Gm-Message-State: APjAAAXAgppS3It/gOaJWkIk0rMuw6VR3L2DJbW9CBKoYC4q2poVrShP
 0R7FBGrfm1Q8Y83bxOwNwkPTIdGsP21sVFXVs6unLQ==
X-Google-Smtp-Source: APXvYqydCvxBAw+OPuh4RtUGLmgL+gnyQ9wiHWKgHgf7pxM2Zqwxdz3mn57qATg/qr9cv1pYVwqK+xWwnGbds9O9FLA=
X-Received: by 2002:aca:4814:: with SMTP id v20mr193441oia.98.1566494564688;
 Thu, 22 Aug 2019 10:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Aug 2019 18:22:33 +0100
Message-ID: <CAFEAcA8fuvkNKYWPEfobSh+3e-BbpPvStXJRvkWxODRY6DwTSQ@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::229
Subject: Re: [Qemu-devel] [PULL 00/13] Misc patches for 2019-08-21
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

On Wed, 21 Aug 2019 at 18:40, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit e65472c7bc413d79faa61eb1d05c540b039458=
94:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.2-20190821=
' into staging (2019-08-21 14:04:17 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 78d01598aea85841f0e4f8baf62c42b76230a81c:
>
>   char-socket: Lock tcp_chr_disconnect() and socket_reconnect_timeout() (=
2019-08-21 16:31:59 +0200)
>
> ----------------------------------------------------------------
> * Longstanding chardev race condition fix (Berto)
> * Cleanups and tests from the Meson POC (Marc-Andr=C3=A9, myself)
> * Coalesced range cleanup (Peter)
>
> ----------------------------------------------------------------
> Alberto Garcia (2):
>       main-loop: Fix GSource leak in qio_task_thread_worker()
>       char-socket: Lock tcp_chr_disconnect() and socket_reconnect_timeout=
()
>
> Marc-Andr=C3=A9 Lureau (5):
>       module: use g_hash_table_add()
>       module: return success on module load
>       tests: add module loading test
>       configure: remove AUTOCONF_HOST
>       minikconf: don't print CONFIG_FOO=3Dn lines
>
> Paolo Bonzini (2):
>       qemu-ga: clean up TOOLS variable
>       configure: define CONFIG_TOOLS here
>
> Peter Xu (4):
>       memory: Refactor memory_region_clear_coalescing
>       memory: Split zones when do coalesced_io_del()
>       memory: Remove has_coalesced_range counter
>       memory: Fix up memory_region_{add|del}_coalescing

This seems to cause a compile failure on one of the travis
build configs (the --enable-modules one):

tests/modules-test.c: In function 'test_modules_load':
tests/modules-test.c:7:25: error: initialization discards 'const'
qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
     const char **args =3D data;
                         ^

First failing travis build:
https://travis-ci.org/qemu/qemu/builds/575361859

thanks
-- PMM


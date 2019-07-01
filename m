Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82097C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0BC214AE
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0BC214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhxHY-00052N-KW
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 10:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50305)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhwz3-0005nI-FE
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:08:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhwz2-0005g3-3W
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:08:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37479)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hhwz1-0005fL-T6
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:08:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14so14036370wrr.4
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 07:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d1BtY+n2SJPoGt3rBOyafGxigKB7TJ5SR8J1DQ3Hgq0=;
 b=UgVt92XvMrdx2KHW+kVyU8kMCNClpi3jFCUPf/98yWncjL90xZIFz/SgKLLT4LDlpg
 vOygLIshqnTV3QxN8k5cgxS+yu4Ytn6QL78SaCQU2SHQyMY/nWVaRujgFIJm4bnVunQC
 KB3XcH0twPycgFPGVO6uV6TxV1OB/Ti+XJsjbhbmF7kDOWIq2wYOdG+mADFXYnyrKu6y
 9s0UBSiKlJSp9APlmuZ/r+l8dWk69lRNlUVZikjZIXYCMvF73wqBl3AcVxPivcYQ2IwS
 mQQfp7XELuf9aWo+zrPSEel0mc3Ud79NxHaESZ8CqS7PaVTBxmBub9NY7tKhvJPpyvgY
 nBYg==
X-Gm-Message-State: APjAAAWSUGM9m/AWJfOUvMWabtm+RO2lWm4ugWkNTga8EReofpBUKnYp
 lHvm+Cs+LIg9k7CEcuPfylj39w==
X-Google-Smtp-Source: APXvYqx6VLq7Bji2v6U6C1l5EgagQIFkznlXdRJ8iZ7UW+rsSxNcZXsZ5txskkyxqfZkegzVpK6EBQ==
X-Received: by 2002:a5d:5386:: with SMTP id d6mr11264166wrv.207.1561990118908; 
 Mon, 01 Jul 2019 07:08:38 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id o6sm26025058wra.27.2019.07.01.07.08.37
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 07:08:37 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190614100718.14019-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ffa261f9-0841-0c59-56c8-551f17fb61aa@redhat.com>
Date: Mon, 1 Jul 2019 16:08:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614100718.14019-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v2 0/9] configure: Fix softmmu --static
 linking
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Bharata B Rao <bharata@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Niels de Vos <ndevos@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 12:07 PM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> Apparently QEMU static linking is slowly bitroting. Obviously it
> depends the libraries an user has installed, anyway it seems there
> are not much testing done.
> 
> This series fixes few issues, enough to build QEMU on a Ubuntu
> 18.04 host.
> 
> Peter commented on v1:
> 
>   The main reason for supporting static linking is so we can build
>   the user-mode emulators. Almost always the problems with
>   static linking the softmmu binaries and the tools are
>   issues with the distro's packaging of the static libraries
>   (pkg-config files which specify things that don't work for
>   static is a common one).
> 
>   So we could put in a lot of checking of "is what pkg-config
>   tells us broken". Or we could just say "we don't support static
>   linking for anything except the usermode binaries". We
>   should probably phase in deprecation of that because it's
>   possible somebody's using it seriously, but it seems like
>   a fairly weird thing to do to me.
> 
> I share his view on this (restricting static linking to qemu-user)
> but since the work was already done when I read his comment, I still
> send the v2.

Alex, any comment?

Patch #1 could go via trivial@, the other should be made obsolete by the
Paolo's switch to Meson.

> Since v1:
> - pkg-config already use the '--static' argument, do not add it twice
> - Fixed x86_64 host builds (was missing GTK and OpenGL patches)
> - Added Niels R-b tag on the first patch
> - The Travis-CI job now succeeds:
>   https://travis-ci.org/philmd/qemu/jobs/545653697 (6 min 7 sec)
> 
> Regards,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (9):
>   configure: Only generate GLUSTERFS variables if glusterfs is usable
>   configure: Link test before auto-enabling GlusterFS libraries
>   configure: Link test before auto-enabling libusb library
>   configure: Link test before auto-enabling libusbredir library
>   configure: Link test before auto-enabling PulseAudio library
>   configure: Link test before auto-enabling OpenGL libraries
>   configure: Link test before auto-enabling GTK libraries
>   tests/docker: Kludge for missing libunistring.so symlink on Ubuntu
>     18.04
>   .travis.yml: Test softmmu static linking
> 
>  .travis.yml                                |   5 +
>  configure                                  | 121 ++++++++++++++++-----
>  tests/docker/dockerfiles/ubuntu1804.docker |   4 +
>  3 files changed, 100 insertions(+), 30 deletions(-)
> 


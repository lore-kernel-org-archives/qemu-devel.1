Return-Path: <SRS0=hUdw=VK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8742C742D7
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 15:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B27A920651
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 15:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27A920651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmKGm-0002ht-HO
	for qemu-devel@archiver.kernel.org; Sat, 13 Jul 2019 11:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38303)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hmKGb-0002Dp-5O
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 11:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hmKGZ-0007UV-WB
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 11:48:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36851)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hmKGZ-0007SZ-QH
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 11:48:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so7277850wme.1
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2019 08:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lIQy/xM/lkJzHsC+uIrWgHZXPYT6lr3GMot/wp5sWa8=;
 b=Z/ouzL0BodjR76BpB/NDpOeN9v/RFDRe8etuQdByRWjhkgv7epiFh/hslvOzrP3m+E
 1FQ7eaIbliTet2r4qaXu/YToQQqNCrb67wJkVFPvjQl5/Asnycz5P49U4FYQpbMskApa
 pQEJOwjZnTathxaX2SflUKIP5hdc9FZ4IxE+3IGCPi1GpADuGt6+jDOjOqdLhZcNjhpa
 NU4XWdZkO00FWDEFVyfzzdKzC+61PEDhmJvOX5vZAsiJUK4XqzhnqYw/X4jg0objdY1c
 kUWCwChfluop1lzlpzRats39PVvMMg1CukXvANrD1+GPd+gGRmlzUaIXxqnWYXN7ozyb
 qxGA==
X-Gm-Message-State: APjAAAXd9TdKzQRpYbseQvtEhYGe+JOyCUm3OmIPauH2CNEXuPy/1Vsj
 0bcgJj/6TQKxdw93epghUf8/Bw==
X-Google-Smtp-Source: APXvYqwHvxtIsPnmw/yE7JqVF5MRuvi16G2ZUMzLkFUnfxBVpy9SDmn2dgl60WSFYZO8ahw42oJ6jQ==
X-Received: by 2002:a1c:cb0a:: with SMTP id b10mr15080885wmg.41.1563032930290; 
 Sat, 13 Jul 2019 08:48:50 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id o20sm28700297wrh.8.2019.07.13.08.48.49
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sat, 13 Jul 2019 08:48:49 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190712111849.9006-1-alex.bennee@linaro.org>
 <20190712111849.9006-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <189b17fc-fdba-5ccc-d018-6fbd27c6babd@redhat.com>
Date: Sat, 13 Jul 2019 17:48:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190712111849.9006-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v1 1/7] tests/docker: add test-misc for
 building tools & docs
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/19 1:18 PM, Alex Bennée wrote:
> Add yet another test type so we cna quickly exercise the miscellaneous

"cna" -> "can"

> build products of the build system under various docer configurations.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/test-misc | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100755 tests/docker/test-misc
> 
> diff --git a/tests/docker/test-misc b/tests/docker/test-misc
> new file mode 100755
> index 00000000000..d480afedca7
> --- /dev/null
> +++ b/tests/docker/test-misc
> @@ -0,0 +1,22 @@
> +#!/bin/bash -e
> +#
> +# Build the miscellaneous components
> +#
> +# Copyright (c) 2019 Linaro Ltd.
> +#
> +# Authors:
> +#  Alex Bennée <alex.bennee@linaro.org>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or later.
> +# See the COPYING file in the top-level directory.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +. common.rc
> +
> +cd "$BUILD_DIR"
> +
> +# build everything else but QEMU
> +configure_qemu --disable-user --disable-system --enable-docs --enable-tools
> +build_qemu
> +install_qemu
> 

I got:

$ make docker-test-misc@debian-win32-cross
  BUILD   debian9
  GEN
/home/phil/source/qemu/docker-src.2019-07-13-17.03.48.3829/qemu.tar
  BUILD   debian9-mxe
usage: git archive [<options>] <tree-ish> [<path>...]
   or: git archive --list
   or: git archive --remote <repo> [--exec <cmd>] [<options>] <tree-ish>
[<path>...]
   or: git archive --remote <repo> [--exec <cmd>] --list

    --format <fmt>        archive format
    --prefix <prefix>     prepend prefix to each pathname in the archive
    -o, --output <file>   write the archive to this file
    --worktree-attributes
                          read .gitattributes in working directory
    -v, --verbose         report archived files on stderr
    -0                    store only
    -1                    compress faster
    -9                    compress better

    -l, --list            list supported archive formats

    --remote <repo>       retrieve the archive from remote repository <repo>
    --exec <command>      path to the remote git-upload-archive command

failed to archive qemu
make[1]: *** [tests/docker/Makefile.include:31:
qemu/docker-src.2019-07-13-17.03.48.3829] Error 1

And remembered some script/archive patch on the list:
https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg02073.html

With it amended this works correctly, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>


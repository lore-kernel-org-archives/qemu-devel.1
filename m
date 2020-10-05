Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02A8C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 18:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46DD920853
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 18:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY+IDdBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DD920853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPUxc-00080l-CJ
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 14:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPUwb-00075D-7P; Mon, 05 Oct 2020 14:10:41 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPUwZ-0002he-K9; Mon, 05 Oct 2020 14:10:40 -0400
Received: by mail-wr1-x444.google.com with SMTP id j2so10656354wrx.7;
 Mon, 05 Oct 2020 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CpaNmaE2A4vrdGSVgW1x31bx0b9/zaNNiQl4Y9Qy+N4=;
 b=VY+IDdBq2yXuOEqXASHiC+360f5x9G9tFWEoASfuIxOdUzd56oOmJCmamjewRRRv+K
 VgESjQOlhehNJgDhnF1/5owrrMEuuVj6VgQCGhiLCZNBSCDrEPkyp1hQmbLSN4nwCGOQ
 ynG8NACOmDA0Zr0qyhaQ3Y/nZ+OH6HXTtEt2nbmNMdOoBe5BcrRsfsl6hw4CzJnTSI1h
 OubKlL8iVqOXRnMxyFpsfMUKXjtIxGmu6mTc3Flt9nX+v4u+BWgCE4ckI/fOutjTDX+r
 NGJOHAHg4WXAHc/8b66VkReAwsCBgHzfunCHcpvWqfs+NfJ+r7cmS9phDMTL7syF8bYi
 uyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CpaNmaE2A4vrdGSVgW1x31bx0b9/zaNNiQl4Y9Qy+N4=;
 b=SXIUmMdTLs8/LmR2vb4zMGwH608JHuV6wYJMhtC7FWNue7vm4euTyqd4i7HX9tTloe
 xUpC+FOr5hHYp3PIzcV+sXa0pN7bRNK0rl/MrrwExm4G4Fv1jTZJ2EDF69H6c8X51N9H
 eOzWjXHDMGk9x5LlY/83b+7DVa7R8Cn9sFF1RZxJ1Abyu60zDiR5dmi54vb7QsnyU1Pq
 /qVcVbi6Jt42Z1em+HnhKiwWIfz40hQ2l1vLmkjstaAlo4/BzbiYrCQheBxZbWy10rFg
 zLchDTl7hy+JBijCtMqUX753maSPiyMfEDNP/xw+q7CfyfmEvhe7bEH/5BfO3x2qH1v3
 ioEg==
X-Gm-Message-State: AOAM533Wu9dv+uUYg2cBF7gBsRYjqT5mcAPvqukhT15J3ZhXUFZwRvDo
 iNnup4p8dZm9udfPlPNmClA=
X-Google-Smtp-Source: ABdhPJzkwECfGJ2JiliKQbgadvDMwlrNhu/ssBW4R4SGIpQLwVuT4x1tWNkJNyYrDXV3urGlGFp3Yw==
X-Received: by 2002:a5d:5281:: with SMTP id c1mr657718wrv.184.1601921437696;
 Mon, 05 Oct 2020 11:10:37 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id b8sm479161wmb.4.2020.10.05.11.10.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 11:10:37 -0700 (PDT)
Subject: Re: [PATCH v2] scripts: Convert qemu-version.sh to qemu-version.py
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20201005172109.416-1-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <afc7c5df-8103-9317-7002-d74b14b30be8@amsat.org>
Date: Mon, 5 Oct 2020 20:10:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005172109.416-1-luoyonggang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/5/20 7:21 PM, Yonggang Luo wrote:
> The sh script are harder to maintain for compatible different
> xsh environment
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---

What are the changes since v1?

>  meson.build             |  2 +-
>  scripts/qemu-version.py | 30 ++++++++++++++++++++++++++++++
>  scripts/qemu-version.sh | 25 -------------------------
>  3 files changed, 31 insertions(+), 26 deletions(-)
>  create mode 100644 scripts/qemu-version.py
>  delete mode 100755 scripts/qemu-version.sh
> 
> diff --git a/meson.build b/meson.build
> index 95a532bd29..20f653b6eb 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1072,7 +1072,7 @@ tracetool = [
>     '--backend=' + config_host['TRACE_BACKENDS']
>  ]
>  
> -qemu_version_cmd = [find_program('scripts/qemu-version.sh'),
> +qemu_version_cmd = [find_program('scripts/qemu-version.py'),
>                      meson.current_source_dir(),
>                      config_host['PKGVERSION'], meson.project_version()]
>  qemu_version = custom_target('qemu-version.h',
> diff --git a/scripts/qemu-version.py b/scripts/qemu-version.py
> new file mode 100644
> index 0000000000..384c54027d
> --- /dev/null
> +++ b/scripts/qemu-version.py
> @@ -0,0 +1,30 @@
> +#!/usr/bin/env python3
> +
> +# Script for retrieve qemu git version information
> +# and output to stdout as QEMU_PKGVERSION and QEMU_FULL_VERSION header
> +# Author: Yonggang Luo <luoyonggang@gmail.com>
> +
> +import sys
> +import subprocess
> +
> +def main(args):
> +    if len(args) <= 3:
> +        sys.exit(0)
> +
> +    dir = args[1]
> +    pkgversion = args[2]
> +    version = args[3]
> +    pc = subprocess.run(['git', 'describe', '--match', "'v*'", '--dirty', '--always'],
> +        stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, cwd=dir)
> +    if pc.returncode == 0:
> +        pkgversion = pc.stdout.decode('utf8').strip()
> +    fullversion = version
> +    if len(pkgversion) > 0:
> +        fullversion = "{} ({})".format(version, pkgversion)
> +
> +    version_header = '''#define QEMU_PKGVERSION "{}"
> +#define QEMU_FULL_VERSION "{}"'''.format(pkgversion, fullversion)
> +    sys.stdout.buffer.write(version_header.encode('utf8'))
> +
> +if __name__ == "__main__":
> +    main(sys.argv)
> diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh
> deleted file mode 100755
> index 03128c56a2..0000000000
> --- a/scripts/qemu-version.sh
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -#!/bin/sh
> -
> -set -eu
> -
> -dir="$1"
> -pkgversion="$2"
> -version="$3"
> -
> -if [ -z "$pkgversion" ]; then
> -    cd "$dir"
> -    if [ -e .git ]; then
> -        pkgversion=$(git describe --match 'v*' --dirty | echo "")
> -    fi
> -fi
> -
> -if [ -n "$pkgversion" ]; then
> -    fullversion="$version ($pkgversion)"
> -else
> -    fullversion="$version"
> -fi
> -
> -cat <<EOF
> -#define QEMU_PKGVERSION "$pkgversion"
> -#define QEMU_FULL_VERSION "$fullversion"
> -EOF
> 


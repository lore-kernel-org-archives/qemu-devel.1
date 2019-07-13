Return-Path: <SRS0=hUdw=VK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4E7C742A7
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 15:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7788F2064A
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 15:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7788F2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmKH1-0003Yr-Lu
	for qemu-devel@archiver.kernel.org; Sat, 13 Jul 2019 11:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38417)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hmKGs-0003AK-1t
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 11:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hmKGr-0007tY-0x
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 11:49:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50586)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hmKGq-0007rM-Qk
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 11:49:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so11385484wml.0
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2019 08:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=is2KaPdmMu3TgMdoyRmVt5/nY5qiOb2rSl/6MqntYAc=;
 b=VvX2tNHyTwzvM5s0ENKJxQzcLmSZEo2EKfsxLuUc3Aoc4FTkpxiW0ttFBdcn3mSFcP
 WYl2lW6veibv9czyBjNnwPGz+rDESPbkGLEJfLpWW6AKqvWIyS101PtCOfKf1Fko5mav
 midavU2jXPNRNV8zZkE4m0L00L+uDstBCaEmjDD0weHt2zjL13yP9T8NC6yeKetN6xzg
 z5XtX/m72Er/sMeUmq92Bjj2HrIO/wAHAo03OcJWpzoOo+qBqolyZnwJn0JueqLFKRfO
 Sti+X+YKtuaOz+ZGxwoTmw7X6uDsP4odSvSAb3/XAlC1e1MFaKikHxOAYzh10y0YNJub
 rrSA==
X-Gm-Message-State: APjAAAXIPda9nxzrZazOsiNcg182A0ccukEGz8r+wC3rKiY6UaGOc7+1
 fnCUjDm/TaHYAvmHyYEkLg7kiA==
X-Google-Smtp-Source: APXvYqzlNR39AGowmk6oUMzlRrZU9/TJ/FgJ5QJgFonwMjaf0Kdf83pwWEtyQluLUd40faTODmTymA==
X-Received: by 2002:a1c:c706:: with SMTP id x6mr14876919wmf.162.1563032947885; 
 Sat, 13 Jul 2019 08:49:07 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id t3sm6960627wmi.6.2019.07.13.08.49.07
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sat, 13 Jul 2019 08:49:07 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20190708200250.12017-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0b0c6aea-2e85-b1f0-2ba2-e55f5538d2c3@redhat.com>
Date: Sat, 13 Jul 2019 17:49:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190708200250.12017-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH] archive-source: also create a stash for
 submodules
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
Cc: Fam Zheng <fam@euphon.net>, thuth@redhat.com, alex.bennee@linaro.org,
 kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/19 10:02 PM, Marc-André Lureau wrote:
> "git archive" fails when a submodule has a modification, because "git
> stash create" doesn't handle submodules. Let's teach our
> archive-source.sh to handle modifications in submodules the same way
> as qemu tree, by creating a stash.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/archive-source.sh | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> index ca94e49978..fb5d6b3918 100755
> --- a/scripts/archive-source.sh
> +++ b/scripts/archive-source.sh
> @@ -39,14 +39,16 @@ function cleanup() {
>  }
>  trap "cleanup" 0 1 2 3 15
>  
> -if git diff-index --quiet HEAD -- &>/dev/null
> -then
> -    HEAD=HEAD
> -else
> -    HEAD=$(git stash create)
> -fi
> +function tree_ish() {
> +    local retval='HEAD'
> +    if ! git diff-index --quiet --ignore-submodules=all HEAD -- &>/dev/null
> +    then
> +        retval=$(git stash create)
> +    fi
> +    echo "$retval"
> +}
>  
> -git archive --format tar $HEAD > "$tar_file"
> +git archive --format tar "$(tree_ish)" > "$tar_file"
>  test $? -ne 0 && error "failed to archive qemu"
>  for sm in $submodules; do
>      status="$(git submodule status "$sm")"
> @@ -62,7 +64,7 @@ for sm in $submodules; do
>              echo "WARNING: submodule $sm is out of sync"
>              ;;
>      esac
> -    (cd $sm; git archive --format tar --prefix "$sm/" $smhash) > "$sub_file"
> +    (cd $sm; git archive --format tar --prefix "$sm/" $(tree_ish)) > "$sub_file"
>      test $? -ne 0 && error "failed to archive submodule $sm ($smhash)"
>      tar --concatenate --file "$tar_file" "$sub_file"
>      test $? -ne 0 && error "failed append submodule $sm to $tar_file"
> 

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>


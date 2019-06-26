Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9B6C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 10:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCEB32146E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 10:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCEB32146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg5JV-0004vo-0g
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 06:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53503)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hg5Hj-0003VD-QP
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hg5Hc-00009x-SA
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:36:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39534)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hg5Hc-00005M-Hw
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:36:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so2122933wrt.6
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 03:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KPuiPjm7xq0ovAYMZCME3pW2JQA1lVlZC4jFWPZN04U=;
 b=UZBikKGtqfvCqB2MQ5vMEw/oT9iYXlW0FCBfk2cviv1GF0EVi1kB2J7L/zsc3uBIbx
 PWJLcR0/bycPRtROsbVOpsIHomfGoY5IWOwZVvr77mAcQiaaqRRUx6kkazLQLHZoSLTc
 WRcXCKkFMSygWqsXCRt6EQzK4hn0WimrQ3z2M6Ku+Ikkty0OwUeU5jiBB9cmzqg7QsbX
 Dt3H67X70KM4lKbl8F2KBDUwX6cpDkcEjuizLj0kMPnlRsBywtRMI+/zxvPmaYOyF2Ds
 N4b/abe6/diYeT6fMkExmaXTGg/9MHglTX54Ty/H87cq2nQEsQ2LF2dl/MQUAeryWZc0
 B5fQ==
X-Gm-Message-State: APjAAAW9kr4kwMJx2+EZquixwnRiNQAwK09JE4xHjR6ivX7bBkNFL+dn
 Kf9IfkvS9NtYIrHpMj5wCMtLZfBhVnY=
X-Google-Smtp-Source: APXvYqydRuAUaf6iFI2FeEdRsArHvgRvqRP6wbMc6CdMvcYVvGukefk8vcaMHUN4Nn7frAkiXAaPqw==
X-Received: by 2002:a5d:4f8e:: with SMTP id d14mr3041123wru.193.1561545367273; 
 Wed, 26 Jun 2019 03:36:07 -0700 (PDT)
Received: from [10.201.33.53] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id 90sm37312886wrn.97.2019.06.26.03.36.06
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 03:36:06 -0700 (PDT)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190625211955.15664-1-mreitz@redhat.com>
 <20190625211955.15664-2-mreitz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e083ea16-c7b6-2dea-6fd1-9d50ddb87e2e@redhat.com>
Date: Wed, 26 Jun 2019 12:36:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190625211955.15664-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v2 1/5] iotests: Add -display none to the
 qemu options
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/19 11:19 PM, Max Reitz wrote:
> Without this argument, qemu will print an angry message about not being
> able to connect to a display server if $DISPLAY is not set.  For me,
> that breaks iotests.supported_formats() because it thus only sees
> ["Could", "not", "connect"] as the supported formats.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/qemu-iotests/check | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index f925606cc5..f2a0df8af2 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -581,13 +581,13 @@ export QEMU_PROG="$(type -p "$QEMU_PROG")"
>  
>  case "$QEMU_PROG" in
>      *qemu-system-arm|*qemu-system-aarch64)
> -        export QEMU_OPTIONS="-nodefaults -machine virt,accel=qtest"
> +        export QEMU_OPTIONS="-nodefaults -display none -machine virt,accel=qtest"
>          ;;
>      *qemu-system-tricore)
> -        export QEMU_OPTIONS="-nodefaults -machine tricore_testboard,accel=qtest"
> +        export QEMU_OPTIONS="-nodefaults -display none -machine tricore_testboard,accel=qtest"
>          ;;
>      *)
> -        export QEMU_OPTIONS="-nodefaults -machine accel=qtest"
> +        export QEMU_OPTIONS="-nodefaults -display none -machine accel=qtest"
>          ;;
>  esac
>  
> 


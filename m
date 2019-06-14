Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2756EC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 03:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F015121537
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 03:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F015121537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48134 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbd7C-0002Yc-A1
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 23:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50724)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbd6T-00026c-Ae
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 23:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbd6S-0001Wn-Bx
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 23:42:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33066)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbd6S-0001W9-60
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 23:42:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so7917665wme.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 20:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WVxT9XoOVZ4Fr3i/9zcefUNT44BRY8UeYEIiUvoii1o=;
 b=Uw4s8D0x73DFYcCA2iNpyaQcgXhha/ljIYS9yuue191tczJbqNjEoTxMb2ceHlIwNK
 2PBjfkAvVqP3+X9w+JJSQ7owTpqhZP93kboTbXvH5mnzeEzC5//lTUZf1pH1NLGT9dZ+
 0IW3S/1r9sPPkWw+sM+c2KOCB1d202QnnvF6uo6DbzxTF5inr9mnDwTzjt+SmP+18tPC
 4Dwfq1yunXIwOAJ5YCq+0yfZ9rTy/hK3rt9YKvG1O89q/VJVId8jcTPX2jL7ogzK6Rzt
 whd6Tg6wPNPms0Ypl1PVL5NW9Vpog2sKW+eQIN15qJ2CE9df8q/dD96FowiDSNa31snr
 apVg==
X-Gm-Message-State: APjAAAUL1QTgPQRmg+KTDZ6CQQJ5fkcjt8/kOg3UsEp00b245fz6P2oN
 LrGz7GMKg1JkHUwLNnIEf0OoIPLenMQ=
X-Google-Smtp-Source: APXvYqxMot9SaG+9sx1ILjAL9NXz43LMHvwgcK/D4LrrY5QnBQueM8ol3nqxv/3QufHuY3uQWwofBg==
X-Received: by 2002:a1c:20d0:: with SMTP id g199mr5718906wmg.79.1560483730606; 
 Thu, 13 Jun 2019 20:42:10 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id k82sm2137771wma.15.2019.06.13.20.42.09
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 20:42:09 -0700 (PDT)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190613183727.28774-1-mreitz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <231c911f-09d6-49c0-de3b-e789362e31b7@redhat.com>
Date: Fri, 14 Jun 2019 05:42:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190613183727.28774-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH] iotests: Hide timestamps for skipped tests
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

On 6/13/19 8:37 PM, Max Reitz wrote:
> Currently, the "thistime" variable is not reinitialized on every loop
> iteration.  This leads to tests that do not yield a run time (because
> they failed or were skipped) printing the run time of the previous test
> that did.  Fix that by reinitializing "thistime" for every test.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/check | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index 44ebf24080..f925606cc5 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -773,6 +773,7 @@ do
>      printdiff=false # show diff to reference output?
>      status=""       # test result summary
>      results=""      # test result details
> +    thistime=""     # time the test took
>  
>      if [ -n "$TESTS_REMAINING_LOG" ] ; then
>          sed -e "s/$seq//" -e 's/  / /' -e 's/^ *//' $TESTS_REMAINING_LOG > $TESTS_REMAINING_LOG.tmp
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


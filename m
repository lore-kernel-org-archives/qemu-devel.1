Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91841C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 658C921855
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658C921855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFIdB-0000LD-GN
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 09:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iFIc7-0007ct-Id
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iFIc6-0000HF-BN
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:54:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50848)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iFIc6-0000G9-5j
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:54:50 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4532D2BF7B
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2019 13:54:49 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id v13so6013033wrq.23
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 06:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G4hjzxtC5CNlcVL42t+wni3mQb1uel0PHen453AFqE0=;
 b=mAJMpCdP3prjYrlwYsBJWiITS2DHwmPZ9kpwGN/FTf6nyBAwGkdSmb4KeHQt4llpo3
 zd02oJsKhNy+mwS+h7Jl3Yl6Jk4JhKahkpQCwmr1FQMiSZLvxPakY6yLcz2lHD4PwQPT
 JqoGnGlFTDYJLlm/pEixhN63UUkuQxZV16oxNbzfsfWXze8stwcbQvKV/C2cyqMbI02R
 WESDictYL4N0yeqyzyLyqls6YPfg67H76vjqezN/xznPDsPlfv92liCM/GhP0W6+wNkc
 P4AzCj05A6wNsrNVM7sye5zPKhBOIhDHUKIrufKvR4A8vtJCCGZRfNEirsZbHwi6TdHH
 Q0aw==
X-Gm-Message-State: APjAAAUjCfE4LkkaLQCQo3IMIbOpVIuIbKD+EUsRd89HqqgVtRqoi9KP
 rC8IYsFxC+7XKPdaBDV0EYxM8uAWcS2EoS20zNhDUrMHdJ/dgDbMWm1qaF1W+128BZHR8I5gCi0
 mFbZa2MPtfN6uuEs=
X-Received: by 2002:a1c:7ec4:: with SMTP id z187mr3753314wmc.94.1569938088062; 
 Tue, 01 Oct 2019 06:54:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyJ6oLDLC5F0muXOBS5U7vuFsiPgqwM15OxXomeUy60Umf8vxnLj6DE2/jAbjQRiOkueqDAuA==
X-Received: by 2002:a1c:7ec4:: with SMTP id z187mr3753298wmc.94.1569938087873; 
 Tue, 01 Oct 2019 06:54:47 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id s19sm17332662wrb.14.2019.10.01.06.54.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2019 06:54:47 -0700 (PDT)
Subject: Re: [PATCH 0/3] Some win32 fixes
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Nelson Chen <nelson@mindflakes.com>
References: <20191001132609.23184-1-marcandre.lureau@redhat.com>
 <8bc51230-963b-e9e2-25ea-9719223c5c79@redhat.com>
 <CAFEAcA8SZnh7iyf5ebChJ=Seu+u7thuhzmLayoYnpa69u+_K-Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <58330557-6f23-1477-c603-3ef758d66a60@redhat.com>
Date: Tue, 1 Oct 2019 15:54:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8SZnh7iyf5ebChJ=Seu+u7thuhzmLayoYnpa69u+_K-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 3:44 PM, Peter Maydell wrote:
> On Tue, 1 Oct 2019 at 14:43, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 01/10/19 15:26, Marc-Andr=C3=A9 Lureau wrote:
>>> hmm, do we have any automated testing/CI on Windows (beside just
>>> cross-compilation)?
>>
>> Nope. :(
>=20
> I did wonder whether it would be possible to get 'make check'
> passing under Wine, but never investigated...

Nelson Chen started to use Azure CI:

https://github.com/nelsonjchen/nc-qemu/blob/master/.azure/msys2-build.sh

He posted some notes here:

https://mindflakes.com/projects/nc-qemu/

I have this link in my CI TODO to try to upstream it and run 'make=20
check' but it is not a high priority.


Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F6BC4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 459CA2089F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459CA2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7NK0-0000hU-9r
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 13:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i7NIz-0000DD-CH
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:18:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i7NIu-0001fw-T7
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:18:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40618)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i7NIu-0001fI-Lw
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:18:16 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 98B7D80F91
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 17:18:15 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id q12so17089383qkm.22
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 10:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ky7kTju+fceh4bytfuiKGrRtFIiAmv5mxeAcxWwerzU=;
 b=JUvVF2FjZ+18Pu56apTn0vCVSLNrfEZsxawH8sC835eadsA6yuCRkG7ERepyM8bEJz
 r9Kn5X9mqa9FsQ4UaJCl0Whhyp+aYxlQYvmqhB8gpPrW3QOsADy6Q+rYPC8eEaE/+q2H
 5pWUNMVFwMTgtBsX6PjykS4FxeCx9PINcmflwxOjnVaPml0k4X0ie7Hm1bSrwdM8npvj
 IJdhgYT56KYg5JkBvxkbMR3/R2hC34iBblFE/o7cB4ifSINO6REWGL+ZJBiSAYhAJ3Dq
 Fk11qA8dJYaS5C+oiaTBymZV7b0gPqLIi4rvGBxk3iSusvZgynjF8hTvs2yvgfT5D3MX
 hdFQ==
X-Gm-Message-State: APjAAAW1/D3hm9sbPsScPN5Yht0C5VQOf7CFtzYyiAAZ2TDzYCkDtgoR
 pr6XuUXi3kH5lPmD3MXcufagJQ4+LQzMZqpYs619YCrHnHV5DnFRhCF1VxTc9tVUev5lYIXzLVM
 +JsGpaHr8PIviiPs=
X-Received: by 2002:a37:6789:: with SMTP id b131mr3489332qkc.358.1568049493925; 
 Mon, 09 Sep 2019 10:18:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy6CZvFCoL+OBCV9k+bBWlEpnIE7z1P1aXJEZG2YqWo8EYdfn/GTVa4+XrwE1B03KvAHpbhvg==
X-Received: by 2002:a37:6789:: with SMTP id b131mr3489293qkc.358.1568049493630; 
 Mon, 09 Sep 2019 10:18:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4580:a289:2f55:eec1?
 ([2001:b07:6468:f312:4580:a289:2f55:eec1])
 by smtp.gmail.com with ESMTPSA id b16sm21809535wrh.5.2019.09.09.10.18.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2019 10:18:12 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Li Qiang <liq3ea@gmail.com>
References: <20190831153922.121308-1-liq3ea@163.com>
 <156726640099.4971.12196429235488580695@5dec9699b7de>
 <CAKXe6SKO60x5MGW22iDQuKh=JLByQVULJpwD+0DffpzeG231xw@mail.gmail.com>
 <20190902090230.GC30123@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <cfc93fb1-ec3c-fddc-85ac-17bb839a89c1@redhat.com>
Date: Mon, 9 Sep 2019 19:18:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902090230.GC30123@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] vnc: fix memory leak when vnc disconnect
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
Cc: Ying Fang <fangying1@huawei.com>, =?UTF-8?B?5p2O5by6?= <liq3ea@163.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/19 11:02, Daniel P. Berrang=C3=A9 wrote:
>>> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
>>> ERROR: spaces required around that '*' (ctx:WxB)
>>> #118: FILE: ui/vnc-enc-tight.c:355:
>>> +        data =3D (uint##bpp##_t *)vs->tight->tight.buffer;          =
      \
>>>                                ^
>>>
>>>
>> Hello Paolo and the Checkpatch maintainers,
>>
>> I also see this error in scripts/checkpatch.pl.
>> However when I add sapces around '*". I got following error:
>>
>> ERROR: space prohibited before that close parenthesis ')'
>>
>> #124: FILE: ui/vnc-enc-tight.c:355:
>>
>> +        data =3D (uint##bpp##_t * )vs->tight->tight.buffer;          =
     \
>>
>>
>>
>> So I'm confused how to make checkpatch.pl happy.
>>
>>
>> Any one has suggests? Or we need a patch for checkpatch.pl?
> Either ignore this patch warning, or figure out how to fix
> checkpatch.pl though the latter quite be quite hard

checkpatch is confuesd by ##.  It's probably possible to do something
like commit e20122ff0faf07cb701d35e39e106d1783c07725 to fix it, but your
patch is okay without the space after "*".

Paolo


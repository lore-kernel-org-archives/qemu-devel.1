Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A410BC4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 14:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D5820863
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 14:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D5820863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Kda-0000mQ-MU
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 10:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i7Kbm-0007Ul-H6
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i7Kbl-00057t-Ln
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:25:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53086)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i7Kbl-00057O-Gz
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:25:33 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AF53881DEB
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 14:25:32 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id b15so7441304wrp.21
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 07:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6w791Bd9pUK/mmv+PL5aTud1Gw/4iC6iU1XHwOL8vvQ=;
 b=UV4A3MRFti7MF5DiiKmZ8UWqjjMcwgrRFf/YRt75MYCbX3MGWgqfjVpCjOjKlZBHvw
 pCDr49wN8jWd7fgV/OtfeKZ3AWAKOmbnHYUr1txOYeCMKVaYqRhJXm45/Bq6Snoqv5ob
 XsVR5y3csHA5o049ITXfUpXmfLHcduUFjRLyk9OjXe8d3/T2xRRF4usZqaWXiWhgXwyj
 9T5P1UTwdhe6/jVQdzz/LaTiivQDg7dxUI8S7HUTDq7bEoPxJVvx5y1Rw5rAsjCu7qt2
 0AfCt37MBdQ7mMs9o12Dt38/18AmqBQgW2jx01ETFvSdBX/cN9MsHVMrIILMh1n+v54T
 FDQw==
X-Gm-Message-State: APjAAAWEthBGH9+dozho9PUFUOU09iuivzfcS7oo/hhiYmcrd0I7PgFL
 peUGUp7fLkHT2QzGYCA5ZqkOyAuch5Oi7582DmvrxbINNjJCuTU8kE3pKvfEy3yRG92PkA7+ZaL
 klMI9VDS/yuuozLA=
X-Received: by 2002:adf:f486:: with SMTP id l6mr18196841wro.232.1568039131394; 
 Mon, 09 Sep 2019 07:25:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw1JHedB8qJ+xhCqogEekWcc4aEQNYI/oRDzJWc/nP5F7zyTMVukDFpDiddekoetRWosOF1gQ==
X-Received: by 2002:adf:f486:: with SMTP id l6mr18196828wro.232.1568039131158; 
 Mon, 09 Sep 2019 07:25:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4580:a289:2f55:eec1?
 ([2001:b07:6468:f312:4580:a289:2f55:eec1])
 by smtp.gmail.com with ESMTPSA id i93sm14995627wri.57.2019.09.09.07.25.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2019 07:25:30 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190829165036.9773-1-berrange@redhat.com>
 <20190829165036.9773-2-berrange@redhat.com>
 <15ffac7c-e7f2-17e4-f4e5-e54500ae3ecb@redhat.com>
 <20190909131510.GG24509@redhat.com>
 <429ee8e3-e6ce-5a37-f4fe-a8408b1cc7b9@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4babad28-f2d2-40d1-fc5b-6eaac479676a@redhat.com>
Date: Mon, 9 Sep 2019 16:25:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <429ee8e3-e6ce-5a37-f4fe-a8408b1cc7b9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/4] docs: convert README,
 CODING_STYLE and HACKING to RST syntax
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/09/19 15:20, Philippe Mathieu-Daud=C3=A9 wrote:
>> Doh. If we care about NSIS, we really need to have it being tested by
>> some part of our CI system, and by pre-merge build tests.
>=20
> I believe Stefan Weil does, since he regularly sends fixes or opens LP
> bugs during freeze time.
>=20
> We do build nsis/win32 with CI, but for some reason patchew was down.
>=20
> I'm not sure we should duplicate the build on another CI, we should
> rather setup something to watch patchew and warn us when it goes down.

I'm not sure what happened since I (obviously) was not monitoring
patchew during my vacation.  However, the recent Python 3 port of
docker.py bumped the requirement to Python 3.6 to run "make docker"
tests, and this broke patchew which had an older version.  I have now
updated the tester.

Paolo


Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E159FC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:20:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6BA62080F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BA62080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBKiJ-00047C-Tl
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 11:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBKfQ-0001QK-31
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:17:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBKfO-0000l2-R5
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:17:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42468)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBKfO-0000ke-7C
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:17:50 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6DF3C8553A
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 15:17:49 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id c188so1101286wmd.9
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 08:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ba0DkmVxjzyjZ1gWYbvilORb5HjRSlU0ZAjenofWjjQ=;
 b=SEmuKpd6Csa/blDYrBdye627MVlLSADzH6GV9UR+b75NXHm1ZSian9rR9SmeMqHJ9r
 SZYXCHLJocAUqEGnlTDgEAlWSE4vpgdL6ZI+wLSRW9awafGXE8UxUU55sxgbCJrahbkr
 Zdo/KDjoA8BgGdM5Ro97qgBRsjEWKuzG8/DOrjWYkP3hPUa4h9dzXEOWlmhGI2DmbOIK
 /P5BdZY2ybsb6Sk010fdAervO0/uwEBoYNTTuyUgS+sZVtU0svUFGnT7RzYyXohP0anU
 IL+tyl6W+sBXX4ilbmUKBiUj8QeFDcuBPEZSExdWzIQzUCK271GXuH/t/4foLRFgb4xP
 Va5A==
X-Gm-Message-State: APjAAAVYUcJpGbidbgE96b1FNu7RbyY3XlonRWM93dK15ee9gmLX3lSb
 hHFPEKqBNnde0IC3LLyS8xI17O8Q4hl1UbP1BizdZITQ2F39je+24qXageW8+VRhp4hPzuf9yvT
 L3lFru0Z1HajyiOQ=
X-Received: by 2002:adf:fac3:: with SMTP id a3mr12783629wrs.24.1568992668241; 
 Fri, 20 Sep 2019 08:17:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxfsPmuTKJ3PQisnZ3kwB6ouumJOZSHUyyx8sP/BbJkD+LoPEuT7jC2Rrz+J6Y43+mk+iMbJg==
X-Received: by 2002:adf:fac3:: with SMTP id a3mr12783614wrs.24.1568992668062; 
 Fri, 20 Sep 2019 08:17:48 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id c10sm4058872wrf.58.2019.09.20.08.17.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2019 08:17:47 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] testing: Build WHPX enabled binaries
To: qemu-devel@nongnu.org, Justin Terry <juterry@microsoft.com>
References: <20190920113329.16787-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <01f2f0ee-a288-921a-58f4-78aeb4d457e1@redhat.com>
Date: Fri, 20 Sep 2019 17:17:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190920113329.16787-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/19 1:33 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Add a job to cross-build QEMU with WHPX enabled.
>=20
> Since the WHPX is currently broken, include the patch required to have
> successful Shippable build.
>=20
> I previously included the WHPX headers shared by the Android project,
> and Daniel asked me to check the EULA. While trying to manually
> install the Windows SDK, I noticed the installer fetches archives
> directly, kindly asking where they are stored via the /fwlink API.
> Do the same, fetch the required archives and extract them. No need
> to accept EULA...
>=20
> Docker build the image first, then build QEMU in a instance of this
> image. The image is internal to Shippable, the instances are not
> reachable and are thrown once the build is finished. What we collect
> from Shippable is the console output of QEMU build process, and if
> the build process succeed or failed. So far we do not redistribute
> the image or built binaries.
>=20
> Philippe Mathieu-Daud=C3=A9 (3):
>   target/i386: Fix broken build with WHPX enabled
>   tests/docker: Add fedora-win10sdk-cross image
>   .shippable.yml: Build WHPX enabled binaries

FWIW here is the result of this series:
https://app.shippable.com/github/philmd/qemu/runs/516/11/console
Duration 17 minutes (1076 seconds)

4m49s building the qemu:fedora-win10sdk-cross docker image,
11m10s building WHPX QEMU.


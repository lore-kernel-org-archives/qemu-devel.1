Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B736EC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE1921929
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE1921929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAuZz-0007lA-Rz
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 07:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAuXz-0005rH-0C
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAuVc-0007Ic-JH
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:22:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49620)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAuVc-0007He-CG
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:22:00 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 596793D966
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 11:21:59 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id b6so915499wrx.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 04:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V8Qi6YIZsSk4K1u6ymiMYe7zk7pD+I3EAOFJScn8y9Q=;
 b=DqdeN+pApfqGmbrAnO687zjELUCLwMsg65S7Sly8atOezU6EmdeqpFge10G/jxRdzB
 CG/0XvGOzIspQemKlksc+J5r7jhr1octMDGHjvwbgUiCp+TeBRY1JgVnJ1MrDYhpw/KY
 fQrZvJlRzhYS1KbPpQIuFNTriYrrpG7Kytisu0Da/RhI2tJu1m6QT6ItdMK7xSKYZJAQ
 zwdIihbLyFn/QqkI55o3L0/OA+9BDyP9S6nHz9PlejMPUorch3s+m9oZXzv0dfiMBxyS
 ALU6SGHm3HY0GIXnEOdMRjVZmXSaU6rk+qzCZM3rNfbcLsw2MJ+0eUmn8Ulu8ay6O3kB
 NpNQ==
X-Gm-Message-State: APjAAAU5YIGZ85r4WfMbCRmetCKYXUeSpLArzIeAwc3Xoqasl77cYLpy
 pS8nR2/Q4sJLPxgI5rClZVwHQHOJZHdFEnZKMgjruVbQJUFiKAyp5EwPI4VXtrD3wg5IG67oPwo
 qwYmKHmDPoTzl3pA=
X-Received: by 2002:a05:600c:a:: with SMTP id g10mr2268823wmc.71.1568892118168; 
 Thu, 19 Sep 2019 04:21:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxlxVOoB8xcgR1vlyLX7agksQGKsgEH+AaAovBQNaOT56CJYrDTgm61wP00cqiMfyT2fYTDmQ==
X-Received: by 2002:a05:600c:a:: with SMTP id g10mr2268799wmc.71.1568892117954; 
 Thu, 19 Sep 2019 04:21:57 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id l10sm13551000wrh.20.2019.09.19.04.21.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 04:21:57 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190919105932.19412-1-philmd@redhat.com>
 <2be4643a-44c4-32c3-5a71-7b7a279ea370@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ff8cdf37-c7b0-fb15-c2b1-6ccf74dc5033@redhat.com>
Date: Thu, 19 Sep 2019 13:21:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2be4643a-44c4-32c3-5a71-7b7a279ea370@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] testing: Build WHPX enabled binaries
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
Cc: Fam Zheng <fam@euphon.net>, Lucian Petrut <lpetrut@cloudbasesolutions.com>,
 Stefan Weil <sw@weilnetz.de>, Justin Terry <juterry@microsoft.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Ilias Maratos <i.maratos@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/19 1:09 PM, Thomas Huth wrote:
> On 19/09/2019 12.59, Philippe Mathieu-Daud=C3=A9 wrote:
>> Add a job to cross-build QEMU with WHPX enabled.
>>
>> Use the Win10SDK headers from the Android Project, as commented
>> in https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03842.html
>>
>> Based-on: <20190918121101.30690-1-philmd@redhat.com>
>> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03844.html
>>
>> Philippe Mathieu-Daud=C3=A9 (2):
>>   tests/docker: Add fedora-win10sdk-cross image
>>   .shippable.yml: Build WHPX enabled binaries
>>
>>  .shippable.yml                                |  2 ++
>>  tests/docker/Makefile.include                 |  1 +
>>  .../dockerfiles/fedora-win10sdk-cross.docker  | 21 ++++++++++++++++++=
+
>>  3 files changed, 24 insertions(+)
>>  create mode 100644 tests/docker/dockerfiles/fedora-win10sdk-cross.doc=
ker
>=20
> Don't you want to include a fix for the #include "hw/boards.h" problem
> in your series? ... or is it not happening with your builds here?

Ah Based-on is for Patchew, and this series need to be tested by
Shippable... you are right.
Well, this is a good opportunity to see the job catch the WHPX failure
reported :)


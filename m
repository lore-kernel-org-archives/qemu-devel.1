Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A60ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6231921835
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dEPJWEO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6231921835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK1lV-00061e-Iu
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 10:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK1kY-0004sZ-5W
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK1kW-0000wN-Tp
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:55:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39531)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK1kW-0000vZ-NC
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:55:04 -0400
Received: by mail-wr1-x443.google.com with SMTP id r3so20116770wrj.6
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 07:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=aRWxH1JfTTiqvlLzFjhP7nbm/gPTTuUWJYa2sB0USI4=;
 b=dEPJWEO3Q0PDlJP/5TdVvfVsBZHuVReYuCmwPHiXQMrRiPNU66j20zikzcHypwRYy/
 IH0hilwo21juA2xUWy1Ivf3Wmj6/e2gCzcj8YOUnLy3WmXyVC2iftcpchPDzrQ9czndK
 nMSxxenzZnNkz+q8UgMb84Py4W/b0p5L/JYgwskj7IV91Tl1C2zHHjQR+2lPJcs+cWEN
 robDWYDBuNk2XzQxnsBVvkjTZVNKeGUaDHuC61+/pPDSbcLWoR3EJy+pIzGLnKg/GiF+
 moiCCI4tR+yawI0OQEnd7kr/uASeKdqxTukuBsdoNKeUHO93f6BQObOGkBqCNGoMSE4L
 qU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=aRWxH1JfTTiqvlLzFjhP7nbm/gPTTuUWJYa2sB0USI4=;
 b=Z0QXslGiPCFBVRNt4l3WCT9w6RvPBqSbacsASvMld+z5niHwVytq3jBUSZxT1An/pG
 IUBWCBYTSzegWIGF24WOqwY9Ec0AXUXAwo76xINmwWQx2u3/ViTrCk2FTOd2/LBcPuWl
 M8YcTKY7E2FU2/np0MJ+VNGDfwgNqXooRCVM/ZU4Bs2AniUAOS3d12QRuz0VTuH6vR2g
 Z0ywQVxOwYwQ00/jlS4fn6j/lowAmTljUf3AEuQx5wvQ0tjffem6QNiXV5cekR6JWGdL
 pumbBw3q96XYq4lvkW7hp/xhmEL1WbQmQFsh2CRslzk0B5N1P+ZgW6FrsD3t2S6y9mk0
 2OUg==
X-Gm-Message-State: APjAAAU7k6M5oaww0vRHsd2qcykoSSfUFYe1JMyMfAcWDV0Ej0D9aWFm
 aPUMNtzpecg5crVjaJopwI2/Lg==
X-Google-Smtp-Source: APXvYqyAE9X8SgoCGLKpTikFFYl80/dpidfhYKm4nr/UovEsSu2jBdQ9KQbQLR1XkI+uUBW71ouhJQ==
X-Received: by 2002:a5d:46ca:: with SMTP id g10mr11709579wrs.193.1571064903368; 
 Mon, 14 Oct 2019 07:55:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y5sm18544704wma.14.2019.10.14.07.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 07:55:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 169B61FF87;
 Mon, 14 Oct 2019 15:55:02 +0100 (BST)
References: <20191014135905.24364-1-alex.bennee@linaro.org>
 <20191014135905.24364-2-alex.bennee@linaro.org>
 <a18c0078-dcb2-f55e-55eb-8328bc465bca@gmail.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Subject: Re: [PATCH v1 1/5] contrib/gitdm: add more entries individuals and
 academics
In-reply-to: <a18c0078-dcb2-f55e-55eb-8328bc465bca@gmail.com>
Date: Mon, 14 Oct 2019 15:55:01 +0100
Message-ID: <87wod7ml6i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com> writes:

> Hello Alex,
>
> I confirm my email address, I worked on qemu during the 2018 Google
> Summer of Code.

Is that an Acked-by: then?

>
> Thanks,
> Emanuele
>
> On 14/10/2019 15:59, Alex Benn=C3=A9e wrote:
>> Again this is guess work based on public websites. Please confirm.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
>> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>> Cc: "K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <dirty.ice.hu@gmail.com>
>> Cc: Li Qiang <liq3ea@gmail.com>
>> Cc: Li Qiang <liq3ea@163.com>
>> ---
>>   contrib/gitdm/group-map-academics   | 3 +++
>>   contrib/gitdm/group-map-individuals | 4 ++++
>>   2 files changed, 7 insertions(+)
>>
>> diff --git a/contrib/gitdm/group-map-academics b/contrib/gitdm/group-map=
-academics
>> index 08f9d81d13..5cbb9d84c8 100644
>> --- a/contrib/gitdm/group-map-academics
>> +++ b/contrib/gitdm/group-map-academics
>> @@ -12,3 +12,6 @@ ispras.ru
>>   # Columbia University
>>   cs.columbia.edu
>>   cota@braap.org
>> +
>> +# University of Paderborn
>> +uni-paderborn.de
>> diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-m=
ap-individuals
>> index 1c84717438..301071b98b 100644
>> --- a/contrib/gitdm/group-map-individuals
>> +++ b/contrib/gitdm/group-map-individuals
>> @@ -14,3 +14,7 @@ noring@nocrew.org
>>   samuel.thibault@ens-lyon.org
>>   aurelien@aurel32.net
>>   balaton@eik.bme.hu
>> +e.emanuelegiuseppe@gmail.com
>> +dirty.ice.hu@gmail.com
>> +liq3ea@163.com
>> +liq3ea@gmail.com


--
Alex Benn=C3=A9e


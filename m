Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133C9C52D45
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:16:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D298C24690
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBVmASE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D298C24690
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7JxM-0000Cz-4X
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7Jva-0006Kh-PA
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:14:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7JvZ-0007zC-Rz
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:14:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36276
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7JvZ-0007yw-NR
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:14:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582812853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+6QaBvd1omaQhxvagnLbfbJHdpxdBsKKR2E+sIeo7Q4=;
 b=dBVmASE7o2n2+n6XqEPMwhCpmKjsT7idypgWKMv0YZMeSQWCB3aTg9xex+y5tWJwcKCTqV
 j+JflJD5ATFBF4X0WZldw/rVfY8Ep0GXTQFJUgF1Xp1Oy1bkBYBYfH7S6ooz/gOnKK/PQp
 bu6BfksEzPFgtog+LMr8TWjh8tNpAIg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-A3agR9OyPFiYff_SJUf0Dw-1; Thu, 27 Feb 2020 09:14:11 -0500
X-MC-Unique: A3agR9OyPFiYff_SJUf0Dw-1
Received: by mail-wr1-f69.google.com with SMTP id z1so1364497wrs.9
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 06:14:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+6QaBvd1omaQhxvagnLbfbJHdpxdBsKKR2E+sIeo7Q4=;
 b=FvRHBa8Khe0Tqq05Gvxw5HWzIncQfBlGFLy92ORAIfZVB6jBG/WDb7yBk8dTpN0ZS1
 N0FflQrSApeC7ptLYpc2X8bor/31a7FpDIvzTabu2hypqFy9fFIGLDef4sI6Annj5gAk
 4vPEIADWqN1Tw0BnD1cVJf2YNRGtFKRq0WqcS2WosVR1URIVQ/AqlsAbwVvAM4zeWsHd
 Uh9lRbeAbI7WCYFppN0OhTUzvPz5ILhYCJJkp2cZPpuYEC7TSVxivX1K5sUteiiHTqcE
 /Iao9PdNvgBO+hehgTA4I2yu5EjbjWGlytdG8WQlOVEd4I7jU8FCIMU6KnlJO7Kqfd3l
 YnLg==
X-Gm-Message-State: APjAAAVhoL+UNWUS/xBkteOdBoQet5rw+wcIxoKKgW8VsPmRmRTc4w73
 hpyIj1WxqNyhEbtBFW/9yAfd8Z4D6CRRhdk91KVZuTtOIItS74CABVpiH4amEkpfCuMoQmTcJeO
 9caLXOs0OXVxGgK8=
X-Received: by 2002:a05:600c:2c44:: with SMTP id
 r4mr5399281wmg.140.1582812850559; 
 Thu, 27 Feb 2020 06:14:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqwx+5n+O1dqGcWc8+z9vHBIlAspEQmL3F6gvyoS6nz8Jy8IMT1CW3//zP7a2t5vL2vmZDGPPQ==
X-Received: by 2002:a05:600c:2c44:: with SMTP id
 r4mr5399265wmg.140.1582812850367; 
 Thu, 27 Feb 2020 06:14:10 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id n13sm8160935wmd.21.2020.02.27.06.14.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 06:14:09 -0800 (PST)
Subject: Re: [PATCH v6 7/9] iotests: ignore import warnings from pylint
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200227000639.9644-1-jsnow@redhat.com>
 <20200227000639.9644-8-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <02d688f5-2104-ff45-e174-c61b1c25d7cb@redhat.com>
Date: Thu, 27 Feb 2020 15:14:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227000639.9644-8-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 1:06 AM, John Snow wrote:
> The right way to solve this is to come up with a virtual environment
> infrastructure that sets all the paths correctly, and/or to create
> installable python modules that can be imported normally.
> 
> That's hard, so just silence this error for now.

I'm tempted to NAck this and require an "installable python module"...

Let's discuss why it is that hard!

> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 60c4c7f736..214f59995e 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -30,6 +30,7 @@
>   from collections import OrderedDict
>   from typing import Collection
>   
> +# pylint: disable=import-error, wrong-import-position
>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
>   from qemu import qtest
>   
> 



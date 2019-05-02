Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22167C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E859A20652
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E859A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53966 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMEIj-00035u-2V
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 12:11:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMEHv-0002jE-8t
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMEHr-0001AI-8S
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:10:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMEHi-000119-6L
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:10:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id t76so3639253wmt.1
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 09:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=+x+RoT++2pHzo0YIOme475LoPNFTahWJYuMgkUwUK5Q=;
	b=XYTsoAcP60GE6nc6r0siUOyPjSvz9HYsDBknbqWA2c3U22XZjOfCOPj+StQIgx1Fuj
	GPvGpj5rRA0I5BGawoDxm+J+1lmOvNW17dAbjKQGlMK3YoxUH0JUHOW7I93dTrwFYfO0
	otPtZkbLkwleutNlwbPT6houztZEoRvGRXMQo/fdN17dlGBMcU5Xb+E/s1nNpDY2lASz
	g0Nxtd4Bt6f9+qMIF04vZq3P2UgkAnLqGdS/khpJ3qR7xCiWUPAbDpFzFs13CyALEcXe
	NGO+zK+zeRQLhaU9uJwtJ3pyhHER8zV/UhiCPETypsoULCwNl9nt/EPdKPNmUKvEnqsv
	qy3A==
X-Gm-Message-State: APjAAAWccp0zmzmnlkLz9Q8+A5kilY2lDMGAKQns0ZhDSB2VYx7y+WkJ
	W9Yji1tQKlx7HpqzboAuq+0H0JaF3bU=
X-Google-Smtp-Source: APXvYqylJx1oOBCnljNtmlAe7mabVPqhfzUAdWOyB2f5N2QOxV6MVAsUGQ370ZYuqioU9YAqOP8AuQ==
X-Received: by 2002:a1c:c287:: with SMTP id s129mr2990223wmf.63.1556813403191; 
	Thu, 02 May 2019 09:10:03 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	e5sm31818271wrh.79.2019.05.02.09.10.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 02 May 2019 09:10:02 -0700 (PDT)
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>
References: <20190502155516.12415-1-cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <40bc015c-710a-c731-74cb-ebf082fb8f57@redhat.com>
Date: Thu, 2 May 2019 18:10:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502155516.12415-1-cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH] s390/ipl: cast to SCSIDevice directly
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502161000.j_73a5xZJqQ0VIq_LpDi27f-bXfAeTGLMy2IIBQUc2Y@z>

On 5/2/19 5:55 PM, Cornelia Huck wrote:
> Coverity notes that the result of object_dynamic_cast() to
> SCSIDevice is not checked in s390_gen_initial_iplp(); as
> we know that we always have a SCSIDevice in that branch,
> we can instead cast via SCSI_DEVICE directly.
> 
> Coverity: CID 1401098
> Fixes: 44445d8668f4 ("s390 vfio-ccw: Add bootindex property and IPLB data")
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/ipl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index d0cc06a05fd0..b93750c14eac 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -374,8 +374,7 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>      if (ccw_dev) {
>          switch (devtype) {
>          case CCW_DEVTYPE_SCSI:
> -            sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
> -                                                           TYPE_SCSI_DEVICE);
> +            sd = SCSI_DEVICE(dev_st);
>              ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
>              ipl->iplb.blk0_len =
>                  cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


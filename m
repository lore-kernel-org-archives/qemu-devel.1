Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D7FC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE3822327
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE3822327
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37278 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGOUh-0005CW-5C
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:51:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hGOTE-0004P4-9B
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hGOTD-0003MW-Ez
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:49:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hGOTD-0003GO-7B
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:49:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id q16so25472724wmj.3
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 06:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=HVKK906KNEy6oWQT8utm04vxUSnctf0Fq3KUesE03EQ=;
	b=NoDwr/+Qp2t7eoTDCARX799U4XZvNnpd5GhXZNB39/bZdjwKC4J336JzqPMNwzwU/F
	S4Sryy0ePtD9Kp4B4TpgpyXr/oCDKo0ufQQMeYQ5FmTPW8/bXuqbVkWyqHmOyvi7V2OF
	YtniP+1dCkjXuNw5gBCOoPJUV0/Z30domNh3HO6v0F3/Cqx8XqGxsspMba0VUkCIkwaM
	HFzoP3jz3MBSpAmtj3AeUg4mriSWT8D83I1x/30FPANcMnEMRj7gM6XnJ4xTnTj3vOV4
	IVHY2h0qX7qAukspccwUgg/XAaWYquCshQmsnYxplOfIzDdz/BtsVppAADfLoPGn8zcX
	671g==
X-Gm-Message-State: APjAAAUacd1C/T68wsyX+NyYrIZTAZbpeBS1IioXaQ2BSUanXW0YfQ3U
	9RcPF/AwJCvfHqYz93NWwajdM0gPpqU=
X-Google-Smtp-Source: APXvYqzcsEPy9ibb1gI0rJfH3wcV2KCtcwikhsVJnFOQ20W7lVuUavMRxOc8dpoOcFBcE85YQH6s9w==
X-Received: by 2002:a1c:6c09:: with SMTP id h9mr26458533wmc.130.1555422587755; 
	Tue, 16 Apr 2019 06:49:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac27:aac4:c65c:6eb?
	([2001:b07:6468:f312:ac27:aac4:c65c:6eb])
	by smtp.gmail.com with ESMTPSA id
	91sm10680875wra.86.2019.04.16.06.49.46
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 06:49:47 -0700 (PDT)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20190415135746.7571-1-mlevitsk@redhat.com>
	<20190415135746.7571-5-mlevitsk@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <db949b72-40f1-137e-42a0-2682ff79f64b@redhat.com>
Date: Tue, 16 Apr 2019 15:49:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415135746.7571-5-mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 4/5] block/nvme: add support
 for write zeros
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416134945.Aua0iwQ-VOw6UUxXYrSwSs1GzbmMiG3IRKcMBh0xwyw@z>

On 15/04/19 15:57, Maxim Levitsky wrote:
> +#define NVME_ID_NS_DLFEAT_READ_BEHAVIER(dlfeat)     ((dlfeat) & 0x3)
> +#define NVME_ID_NS_DLFEAT_READ_BEHAVIER_UNDEFINED  0
> +#define NVME_ID_NS_DLFEAT_READ_BEHAVIER_ZEROS  1
> +#define NVME_ID_NS_DLFEAT_READ_BEHAVIER_ONES   2
> +
> +

s/BEHAVIER/BEHAVIOR/

Paolo


Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D801EC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 16:50:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC45A233FC
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 16:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC45A233FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0qHx-0007DJ-RK
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 12:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0qFy-0006MY-N0
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0qFx-0004xd-Fw
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:48:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32850)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0qFx-0004xA-9z
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:48:13 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 697E4C05683F
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 16:48:12 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id h8so3470116wrb.11
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 09:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QLlYFHwpJOD4nkeNNYtEvH7y1VwfbxfUTKLq7kJ70vg=;
 b=ISg+UCHExFuP9JnvCx14SSbgLWHDxhlz+d9uAibPDi33Euay56BTHB03PDdvi7Vx8x
 Z8ErrEckZA2sQARRpaNeyWshcj6ohbNRlXfEpwL+Dd0cp5j6bjrraPtZ+gDPeWf++RIe
 prhvpus1OXJ52O8sJxCwsZqwbowPEOYGdHmPL5S2PDykL4Qt+aRSDzaKmTzZpAbF3bpk
 a0dxfg96XgBJ/GVrcQjAvgkXAEZMdPJPPmNHFv5vsm28gI22OCutGZgcoDuhw1HTfQRV
 Zj4k5zZycw84KTQiZG+1ywn1MqINIKZy9wuL6eqh7ZJnsp+R9+ICXv/elzN4je2IrVDa
 9YKg==
X-Gm-Message-State: APjAAAXohHPOrwbKIoyi3E6ZOsEjobLWKDUPx8MFKJfFUPZJVxQ/ymOi
 mP8a3gFiLLNrey+mWsZ9Zyx28SABca6B5wgsfudXnKIotx9nTdy0UzjcKkcK/pA5iaAolodwgDe
 ukKvkhiP5SJjMNGs=
X-Received: by 2002:a1c:a6c8:: with SMTP id p191mr7162888wme.99.1566492491007; 
 Thu, 22 Aug 2019 09:48:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzlpZzyDx6/pUArfQ2xNwHZN1yH5SCqrCSEVyYS0d5eBN5Bug35GYrRj/TDBFToqF95CcXbTw==
X-Received: by 2002:a1c:a6c8:: with SMTP id p191mr7162858wme.99.1566492490707; 
 Thu, 22 Aug 2019 09:48:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:21b9:ff1f:a96c:9fb3?
 ([2001:b07:6468:f312:21b9:ff1f:a96c:9fb3])
 by smtp.gmail.com with ESMTPSA id o129sm57035wmb.41.2019.08.22.09.48.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2019 09:48:10 -0700 (PDT)
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <CAFEAcA8kEKVcRu62+VGDkzRj2J87QPxzjg05dCHszeBC6X76pg@mail.gmail.com>
 <20190822114747.GS3267@redhat.com> <20190822163150.GA3332@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9caf3a64-0841-dde6-3413-a77dc80e22bd@redhat.com>
Date: Thu, 22 Aug 2019 18:48:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822163150.GA3332@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] more automated/public CI for QEMU pullreqs
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Samuel Ortiz <sameo@linux.intel.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/08/19 18:31, Dr. David Alan Gilbert wrote:
>> With both these points in mind, I think it is  pretty hard sell to
>> say we should write & maintain a custom CI system just for QEMU
>> unless it is offering major compelling functionality we can't do
>> without.

In theory I agree.

In practice, the major compelling functionality is portability.  If it
is true that setting up runners is problematic even on aarch64, frankly
GitLab CI is dead on arrival.  If it is not true, then I'd be very happy
to use GitLab CI too.

Paolo

> I'd agree; and I'd also find it useful to have runners setup for
> Gitlab CI for related things (it would be useful for the virtio-fs
> stuff);  if there are problems on other architectures then we should
> find some go wranglers to go fix it.


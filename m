Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE241C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 17:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABA932199C
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 17:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA932199C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpbrp-0006k9-N7
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 13:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47569)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hpbrf-0006LU-L8
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 13:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hpbre-0003Zb-LX
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 13:12:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hpbre-0003Z7-Fn
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 13:12:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so40180897wrt.6
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 10:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sBJkMkHBr8sArYcTbDYX3ynNelVqMzdYi7Duy6AYZW0=;
 b=ruDuDIc0sfR6QLTDxbr/kbCPybT8A16OGsOU7Tq+LWrKPUn0oKTjfVsaOuj2RcbLSz
 160Cgs+teC4EaK7HGP4f0dblvXCvAOjv5AZiKRk0KT8kL+Kl/36pTfgQOpRpPbSHDFxU
 npdqReNMloH2BsmhoofToXSb2x3PoimgX+hOfTLnyrlIOd+49MhvvkaMlWaUmIDnO2WG
 RG9Ac7vJNzAsiwsBrcoIYhciOlzjL1sIvcRUQ4LG5oehJ9ohVR4ClJ0wjNtPNvZeAcdo
 g7bfdGiN8SrWR3v5r4gDBVzkVms2JwOylK3c7+FVtmwDq5KZYA78srsYsXYKBEs5sbYx
 MOcA==
X-Gm-Message-State: APjAAAWbse7ySZe+6hnK/lYh3wbhk5cqflhMXwu/S0lSstb85RbkdBMY
 7X/hXGIC3o6ofkRbnQMBOwtOZg==
X-Google-Smtp-Source: APXvYqx/haeEKNZfooxc6MrUSsINnl1lyA5+ETDsmJoEogRReLl3QmrcO3vrLcfZVihwPLWTW5ULOA==
X-Received: by 2002:adf:db50:: with SMTP id f16mr63765164wrj.214.1563815561487; 
 Mon, 22 Jul 2019 10:12:41 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id b8sm50877541wmh.46.2019.07.22.10.12.40
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 10:12:40 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20190722161657.8188-1-pbonzini@redhat.com>
 <20190722161657.8188-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e6ed117b-9a9b-8752-eaeb-f108fe1f8146@redhat.com>
Date: Mon, 22 Jul 2019 19:12:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190722161657.8188-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PULL 1/2] virtio-scsi: fixed
 virtio_scsi_ctx_check failed when detaching scsi disk
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
Cc: Zhengui li <lizhengui@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

On 7/22/19 6:16 PM, Paolo Bonzini wrote:
> From: Zhengui li <lizhengui@huawei.com>
> 
> commit a6f230c move blockbackend back to main AioContext on unplug. It set the AioContext of
> SCSIDevice to the main AioContex, but s->ctx is still the iothread AioContexï¼ˆif the scsi controller
> is configure with iothreadï¼‰. So if there are having in-flight requests during unplug, a failing assertion
> happend. The bt is below:

Patch v2 uses some weird utf-8 parenthesis instead of ï¼ˆ ï¼‰.


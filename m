Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E821FC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBFE921929
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFE921929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAucq-0003uf-AG
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 07:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iAuY1-0005sQ-H5
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:24:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iAuPI-0004Dk-UJ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:15:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47722)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iAuPI-0004C6-Ob
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:15:28 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E1784369AC
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 11:15:27 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id s25so1444542wmh.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 04:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PwxkuA9Fta2/xMsPNhKg8aTRVvMjXHQn/kkB9GFcmVw=;
 b=Tn1rnfJnwwz7wkhXogmKiVWpvDI6MsHAKjp/r5F03Gv5RD99LdE/+63F6ECz2xpn0Z
 k3j2wR1JRL652/MJCVLg7OFkPF6Mp8T40pqOrFa0KqLdW0krPDlE0fF7dtcjLZRQdPwS
 ZaXsuI0+1SjM1k8tOnubm+tROjYNEh5EujVhQZw5ykdPFLUTVWvUA0FE9KgltzWZhNQD
 jaxC7X/QdH6dODsZac2n2i7W8fcKDUfaZlToFxfhwX8PTd/evav9hstX7Yc2My1TJ5o0
 90VxT06zWxP5gtjJ17oeAa0dh89/ZnnUGa4rcPamftER7fPrtEgLkE9HG/icidcqx0Qx
 sj6A==
X-Gm-Message-State: APjAAAUfr0bVCnI/BFjH1h7GJ/YAAgNqHK0GChPg2WpqGaFWyXrwYj2g
 SkIwzBMV0/DKfrIFBdisjG8k6ev+Cz8KmcBcs5UPpeWWSmgwHU3WcPMBufTOAUOw/080wW3Lzj4
 JvY3BCRONb3ca0VM=
X-Received: by 2002:a1c:4384:: with SMTP id q126mr2609773wma.153.1568891726608; 
 Thu, 19 Sep 2019 04:15:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyXh/+X6SkPqxz+sBlP6s+IHiZKHy2N2KvWwGsTEcP6hqVo5AV3MIpVVfrgifaDkg3A5cLpjg==
X-Received: by 2002:a1c:4384:: with SMTP id q126mr2609756wma.153.1568891726380; 
 Thu, 19 Sep 2019 04:15:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8?
 ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
 by smtp.gmail.com with ESMTPSA id s12sm14260632wra.82.2019.09.19.04.15.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 04:15:25 -0700 (PDT)
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-3-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9bd3100e-0e14-46c1-e086-29b3b26a41d4@redhat.com>
Date: Thu, 19 Sep 2019 13:15:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918231846.22538-3-alxndr@bu.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 02/22] libqos: Rename i2c_send and
 i2c_recv
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
Cc: Laurent Vivier <lvivier@redhat.com>, "bsd@redhat.com" <bsd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/09/19 01:19, Oleinik, Alexander wrote:
> The names i2c_send and i2c_recv collide with functions defined in
> hw/i2c/core.c. This causes an error when linking against libqos and
> softmmu simultaneously (for example when using qtest inproc). Rename the
> libqos functions to avoid this.

I'd prefer "qi2c_{send,recv}" since that is consistent with "qvirtio_"
functions and with the name of the "QI2CDevice" struct.

Paolo


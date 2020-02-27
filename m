Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F62C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93FD624650
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqpFIolF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FD624650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7KYs-000170-QD
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:54:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j7KYE-0000fb-1p
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:54:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j7KYD-0007J7-2s
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:54:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41405
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j7KYC-0007Iq-NF
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:54:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582815248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ihts6RM/pMgl6AdESCxV8dplR3qmKs6vhYSbqioStAs=;
 b=dqpFIolFLTu7uREIYkJA4TclNqutFRnTEzjAG/laM4ph5F9MALzvcFRcvgHom8DgfHBFrL
 I7UU+QVVtAObUFOlZegVrctycS2Ehj6iaUGLkxssd5+O6HdQpnSmJrSaBwT4950O1wihoZ
 3kcZVH1Sd/plkw0hVtbh/W3q857ExqQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-MbCXHOHfNLyCb6RCw_98Vg-1; Thu, 27 Feb 2020 09:54:02 -0500
X-MC-Unique: MbCXHOHfNLyCb6RCw_98Vg-1
Received: by mail-wr1-f70.google.com with SMTP id z1so1410714wrs.9
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 06:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ihts6RM/pMgl6AdESCxV8dplR3qmKs6vhYSbqioStAs=;
 b=BzS3MzQprgX5JukXh6WkPvyTx+pKYCdnl0mxRLDIB0ZgzOUK56RXHVgXN/iLc5PV4S
 I22eCyppgz0stFHY8cnYwR9pYEDRMtkYn8VZO+77jDCebmVR1nqKA0EZfSCvoUCdJyjx
 m3dDHTKckMa3VQFt8OxaXeKrDJmXYOSeVFCKLvdqNGjCiiw2avssguFOX7FGG1qMLL/B
 iSfuziFzLQYzbXhIcD/OHVVxQgNUWhwh9XdgOjzf3OjQbYmg0kApdDcP6XGRvOY2ydBx
 KXc3M59jV/sttuqWibGWZWfIiA8BOGlu81HsmHfV9hmoukYuMkxDULtuoN017au2HuB2
 pyIA==
X-Gm-Message-State: APjAAAVSOMPGfaZMxH6ZFkeL4kodhRrfwWOb7XUPBBfuxH2gPsN92i5+
 dMIptxx5wextCl3JZzuQA4J0qKZszxI5iCvODWLBD/GktOsFZ8f8LAM5p7ae/4yW/aCtyyw5Ar0
 1/nuOLtnocUo2Y70=
X-Received: by 2002:a7b:cc69:: with SMTP id n9mr5858900wmj.163.1582815241658; 
 Thu, 27 Feb 2020 06:54:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqzyrAuyGo/J3Wd833qy4r30XPF/bgzdG8FZkm4v9F8wM06owdZsI/ALQXczEXWMzIVN6LY33w==
X-Received: by 2002:a7b:cc69:: with SMTP id n9mr5858873wmj.163.1582815241379; 
 Thu, 27 Feb 2020 06:54:01 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:d0d9:ea10:9775:f33f?
 ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id a13sm8452551wrp.93.2020.02.27.06.54.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 06:54:00 -0800 (PST)
Subject: Re: [PATCH 14/18] docs/system: Convert qemu-cpu-models.texi to rST
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200226113034.6741-1-pbonzini@redhat.com>
 <20200226113034.6741-15-pbonzini@redhat.com>
 <CAFEAcA8Ts30UXsexhTgaEFTDV06nV6SrZsLjpayH1PNFd=f+Bg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c6037a6-2e53-b4d5-1d5d-9f83da4401a7@redhat.com>
Date: Thu, 27 Feb 2020 15:54:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Ts30UXsexhTgaEFTDV06nV6SrZsLjpayH1PNFd=f+Bg@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/02/20 15:01, Peter Maydell wrote:
>> diff --git a/docs/system/defs.rst.inc b/docs/system/defs.rst.inc
>> new file mode 100644
>> index 0000000000..bf50b442b2
>> --- /dev/null
>> +++ b/docs/system/defs.rst.inc
>> @@ -0,0 +1,2 @@
>> +.. |qemu_system| replace:: ``qemu-system-x86_64``
>> +.. |qemu_system_x86| replace:: ``qemu_system_x86``
> Just noticed that you define qemu_system_x86 but never use it.

Indeed, and the definition also makes no sense (should be
qemu-system-x86_64 instead).

Paolo



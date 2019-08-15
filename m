Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDF7C3A59C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7177F20644
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7177F20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43703 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyIHO-0002OB-UL
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 12:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hyIEY-0008PI-8c
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hyIES-0003St-OZ
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:04:13 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:36425)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hyIES-0003Ql-I9
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:04:08 -0400
Received: by mail-wm1-f49.google.com with SMTP id g67so1691479wme.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 09:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=12CmPXDKohJIalirQWLIymjm76aqAmjolo9JFT55CfI=;
 b=uR2hGCyn5ynH1lKjOOQQQj6WHKvGfhoSXy+ZqtWTu2hXloJx0Judku2wlj6kYBzh8m
 i2yjGQVSxCD830JaYfC/u/h/01nEqEFfYxfCn4Sp5amNjyQHAh9DL+SpUlBt9L7RdTYC
 C0yn4dloxgJ2yrEKsO4OafIVv6kpsdmkULMb1XXmsBk6l7wYCXnIOD7CPhUnLq6PNbUC
 wuScB5V1w0JLIUEyU7wyKNVhJgvqNyeMjt/Riq2Er9CNOZFkVEFr4V/E4yuxzkjs7Pkz
 1oqYBa4v4yXt40uke9UU/B/9daykWbpxoPSw/QZ27Iii9Fy0DCQaqGJ3sXm6atW0XpXa
 zKcg==
X-Gm-Message-State: APjAAAU8OLyOHNELiqRmEr8K8AykTOAmZXGqeaT7wyhfcicv4mnAg93S
 nSxhYCMto+hCd7kxzgmuWzuqtg==
X-Google-Smtp-Source: APXvYqyCgR9nyP3oIWWPvbZlOfkCKQomPMTsxIfhP9S+ZkYqKC0bUJHNEYieFprlEnuxW+YpF+UTyg==
X-Received: by 2002:a1c:4c02:: with SMTP id z2mr3669896wmf.92.1565885046124;
 Thu, 15 Aug 2019 09:04:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2cae:66cd:dd43:92d9?
 ([2001:b07:6468:f312:2cae:66cd:dd43:92d9])
 by smtp.gmail.com with ESMTPSA id c1sm1465195wmc.40.2019.08.15.09.04.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2019 09:04:05 -0700 (PDT)
To: "Yao, Jiewen" <jiewen.yao@intel.com>, Laszlo Ersek <lersek@redhat.com>,
 edk2-devel-groups-io <devel@edk2.groups.io>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <effa5e32-be1e-4703-4419-8866b7754e2d@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75B680@shsmsx102.ccr.corp.intel.com>
 <047801f8-624a-2300-3cf7-1daa1395ce59@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75E4E9@shsmsx102.ccr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f71b97ee-7add-6c18-bdce-a08fbb6be28c@redhat.com>
Date: Thu, 15 Aug 2019 18:04:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <74D8A39837DF1E4DA445A8C0B3885C503F75E4E9@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.49
Subject: Re: [Qemu-devel] CPU hotplug using SMM with QEMU+OVMF
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
Cc: "Chen, Yingwen" <yingwen.chen@intel.com>,
 Phillip Goerl <phillip.goerl@oracle.com>,
 qemu devel list <qemu-devel@nongnu.org>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 edk2-rfc-groups-io <rfc@edk2.groups.io>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/08/19 11:55, Yao, Jiewen wrote:
> Hi Paolo
> I am not sure what do you mean - "You do not need a reset vector ...".
> If so, where is the first instruction of the new CPU in the virtualization environment?
> Please help me understand that at first. Then we can continue the discussion.

The BSP starts running from 0xFFFFFFF0.  APs do not start running at all
and just sit waiting for an INIT-SIPI-SIPI sequence.  Please see my
proposal in the reply to Laszlo.

Paolo


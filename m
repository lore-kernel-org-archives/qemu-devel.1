Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA4FC74A2B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 14:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A23CA20651
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 14:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23CA20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlDn0-00031S-0b
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 10:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53349)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hlDm1-0001zY-BH
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 10:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hlDm0-00053c-8N
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 10:40:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54938)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hlDm0-0004ug-0s
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 10:40:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so2583740wme.4
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 07:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OnM8VyA9wrgkRhHh4+ZoRo0oCaq8f707rZZcoro2yNQ=;
 b=K2GVXQcILQM/EWgDp1iioNJHf7eltR6hignbXDQ+aLYYyvbo+enJVEBb75A++scnMZ
 y1kfDTaGH15e7zZLy2JxlWKSiTXQtjcZhHjCjSHfaE5iFm0QtwhJ08e5XOu5yMeHcXGG
 EZMnM/Z9G7igYwwRsy/RN3F9rhv6kU2AjwaHU1110mEfwY9i8Y3nJq/1OajH5crd+j5R
 HRHOv4wzvWCT+GwBON0lL1QEckvWkTgXmLSsiQCWp46XOFC6WuLGGJ9ZxMlx2DBNbGld
 JFpdyXb97G5ds8P5yLz+XVmRmj6URuPi68xFzIYX84MlycgGQufTGy5SQgzzDWfdwqNG
 7pGQ==
X-Gm-Message-State: APjAAAWInWi7EgaBsUOL5hdQEc0XcdAB7Gz0oHUl3LmOS2cA00mU/PNb
 J4X1aHlVsNTIGXcJGELViJhrlFUo2hA=
X-Google-Smtp-Source: APXvYqwfgOGy6rWTzlfTk1O/pnfe6R7cTya132xBdijr1Vm8JUFpkZGSFTbZZCf2csX6vPe/p8huxQ==
X-Received: by 2002:a7b:ce88:: with SMTP id q8mr5822057wmj.89.1562769635507;
 Wed, 10 Jul 2019 07:40:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab?
 ([2001:b07:6468:f312:d066:6881:ec69:75ab])
 by smtp.gmail.com with ESMTPSA id r12sm3068171wrt.95.2019.07.10.07.40.34
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 07:40:34 -0700 (PDT)
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
 <1561116620-22245-23-git-send-email-pbonzini@redhat.com>
 <e253d736-8cf5-0c5c-5766-ee71ad808cfd@siemens.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7431700b-0bfd-32e6-e9f2-64608f8ba6b9@redhat.com>
Date: Wed, 10 Jul 2019 16:40:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <e253d736-8cf5-0c5c-5766-ee71ad808cfd@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PULL 22/25] target/i386: kvm: Add nested
 migration blocker only when kernel lacks required capabilities
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
Cc: Liran Alon <liran.alon@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/07/19 20:31, Jan Kiszka wrote:
>> -    if (cpu_has_nested_virt(env) && !env->nested_state) {
>> +    if (kvm_enabled() && cpu_has_vmx(env) && !env->nested_state) {
>>          error_report("Guest enabled nested virtualization but kernel "
>>                  "does not support saving of nested state");
>>          return -EINVAL;
>>
> Starting with this commit latest (bisection issue...), running Jailhouse in a
> guest first stalls L1 (looks like we lose interrupts), and if I try to reset
> that VM, I lose my host as well:

If 5.2 is still broken, can you gather a dump of KVM_SET_NESTED_STATE's
payload?

Paolo


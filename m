Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245E6C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F16A12175B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16A12175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40926 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbRfD-0004Z2-Hr
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 11:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33729)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hbQLN-0004SP-VY
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hbQLL-0004hN-Gf
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:04:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54616)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hbQLL-0004ge-8j
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:04:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id g135so10355252wme.4
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 07:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ollIy1Fp/Zaw8IHRH+U3RjWOz+tnLVhyW4Bsgd3tbjw=;
 b=ENVg7kLvCB92uvOx7riKy2lCK1BCYheotZdpusHvZtRVGd9W7NURJe0IJuBkPoCHCt
 2NWKFeiDS46QBxYxy84IKSn5ASlOpX1Gp9uOFKmsA7l4IM0HeYl5qG3L41K0WDeObwcl
 YZcAk/Hn3GT29XUptBE2WWaR+OLX7W/DhelaNJ9GwD1WxNdX1hZRSlmxn78b79iJOETL
 0RYVc9AX/EBHV1SpXtnpmKBK2tw3Kcdzua1tGYUR1lIvgybKMBjuIvfFFP3b1FKdaiWG
 Hpm+us6KWidzpsalOGUGuYI/B88IW3WuOZuAOGIwU/hsh2ScR4oCqVAoy7RQO/PjUZF4
 g+YQ==
X-Gm-Message-State: APjAAAU5Ihf+vGVypDLPhMI+Ks9AMvfGTlaoTCW0nl9BzEshM2gRB1u4
 jrh9rTbJWjih92tFLq0dZ2JCvw==
X-Google-Smtp-Source: APXvYqwlVbsNkhJ8O1C/nucOPOidy/f/JqsO1OTbG8GBOHHFV78eJajJIiZejKA6ACgRY2o1eyMPew==
X-Received: by 2002:a7b:c344:: with SMTP id l4mr3776244wmj.59.1560434681891;
 Thu, 13 Jun 2019 07:04:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:56e1:adff:fed9:caf0?
 ([2001:b07:6468:f312:56e1:adff:fed9:caf0])
 by smtp.gmail.com with ESMTPSA id h8sm2611904wmf.12.2019.06.13.07.04.40
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 07:04:41 -0700 (PDT)
To: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20181214025849.84274-1-aik@ozlabs.ru>
 <8727c6e5-006c-20e5-cb6b-be525154e184@redhat.com>
 <bda42f7c-9068-3c4d-d839-7f6c52561cc9@ozlabs.ru>
 <69a29694-b777-721a-eafd-4ff38c457f6d@redhat.com>
 <db36d006-3bdc-47fe-9987-519440446c4e@ozlabs.ru>
 <20190103173753.GJ2316@work-vm>
 <d4b8695c-3d37-ba92-d62b-e067b77274c8@ozlabs.ru>
 <20190207114953.GB2773@work-vm>
 <16486ff4-eb62-b4f2-78f8-a1ec7e3fbb0b@redhat.com>
 <30a5a208-249f-106e-f885-94caf9b82970@ozlabs.ru>
 <f346fdcb-1849-3397-7f4c-2d6ee07fcd7c@ozlabs.ru>
 <aca6d2ae-806f-55b3-d9d5-f5a2cfd760b9@ozlabs.ru>
 <a66cc0e6-3629-8f07-65d3-aefff9dcd2d5@ozlabs.ru>
 <467c5374-34e6-c8d4-26c1-246f5cf31ec6@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <450356ef-c10b-f42d-1050-7084b06abe8f@redhat.com>
Date: Thu, 13 Jun 2019 16:04:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <467c5374-34e6-c8d4-26c1-246f5cf31ec6@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH qemu v2] hmp: Print if memory section is
 registered with an accelerator
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/06/19 07:07, Alexey Kardashevskiy wrote:
> +        if (as == &address_space_memory) {
> +            system_as = true;
> +        }
>      }

Ah no, wait... On x86, there are two KVM address spaces, so you have to
pass "as" to has_memory.  To detect KVM address spaces, you can allocate
an array with kvm_check_extension(kvm, KVM_CAP_MULTI_ADDRESS_SPACE)
elements (default 1 if the capability is not available), and fill it in
kvm_memory_listener_register.  Then you an search for the address space
in that array, it's very small and cheap.

Promise to merge quickly with that change.

Thanks,

Paolo


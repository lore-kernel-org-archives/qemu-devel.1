Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC7AC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:09:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3EE2078E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bF/ytiWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3EE2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGGiT-00072t-Ur
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 03:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kGGgq-00057L-RR
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 03:08:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36419
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kGGgp-0002TB-9r
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 03:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599721694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/H4Uu1wy+G6iibdT+5/lLcjn+HOv3NmsU986xOmN/8=;
 b=bF/ytiWTiI+cb8AcVNfW0dSjObWQopim3+ErMXetc+LWBzfRV9P8wIWpspLl3qJJTkGXks
 1OdOgstb1A8vHfFsONOBqPbCecczevlM/WRidQvDpttnH8CgK8Kg2pVr/13jBMI+mWTjDE
 XJaBPpt4d2KK8JhYLAjV2d//Rolb8gI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-xb3zd0wRPvaW79iMCmckrQ-1; Thu, 10 Sep 2020 03:08:12 -0400
X-MC-Unique: xb3zd0wRPvaW79iMCmckrQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E314A1882FC5;
 Thu, 10 Sep 2020 07:08:10 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-86.ams2.redhat.com [10.36.112.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 683198357E;
 Thu, 10 Sep 2020 07:08:03 +0000 (UTC)
Subject: Re: [PATCH 6/6] target/i386/kvm: Rename host_tsx_blacklisted() as
 host_tsx_broken()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200910070131.435543-1-philmd@redhat.com>
 <20200910070131.435543-7-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <118a4cae-f220-8224-52ac-26a1795ac071@redhat.com>
Date: Thu, 10 Sep 2020 09:08:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200910070131.435543-7-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 01:44:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Joel Stanley <joel@jms.id.au>, qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/09/2020 09.01, Philippe Mathieu-Daudé wrote:
> In order to use inclusive terminology, rename host_tsx_blacklisted()
> as host_tsx_broken().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  target/i386/kvm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 205b68bc0ce..3d640a8decf 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -302,7 +302,7 @@ static int get_para_features(KVMState *s)
>      return features;
>  }
>  
> -static bool host_tsx_blacklisted(void)
> +static bool host_tsx_broken(void)
>  {
>      int family, model, stepping;\
>      char vendor[CPUID_VENDOR_SZ + 1];
> @@ -408,7 +408,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
>      } else if (function == 6 && reg == R_EAX) {
>          ret |= CPUID_6_EAX_ARAT; /* safe to allow because of emulated APIC */
>      } else if (function == 7 && index == 0 && reg == R_EBX) {
> -        if (host_tsx_blacklisted()) {
> +        if (host_tsx_broken()) {
>              ret &= ~(CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_HLE);
>          }
>      } else if (function == 7 && index == 0 && reg == R_EDX) {
> 

Looking at commit 40e80ee4113, the term "broken" seems to be a good
replacement here.

Reviewed-by: Thomas Huth <thuth@redhat.com>



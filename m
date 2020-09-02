Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06077C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 09:55:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3FA42084C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 09:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VuNFhjra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3FA42084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDPUf-0004DM-TW
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 05:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDPTR-0002wU-2U
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 05:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDPTO-0007ba-Hs
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 05:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599040473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hAN/+UgVuutpK9WRPwmoCgiOBIRb3PSn9SRbUPevmNQ=;
 b=VuNFhjracb1jWnw3RyAXywgtD3/drk8vQZTIT+09Ec7B+Dsz/y+h2KFF2ppuoMecJceYrg
 CFgaTpMoY1zjpcE6cO/2aMHSFKVePzEVQQaQH7ScOKq2NkfT/tYAAOPiLxS8VLqdvO4A2t
 m+whd+XzGe99L55ALFn494/aQjCab8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-ATs-m8ZMMLWkY5VhGvb_eQ-1; Wed, 02 Sep 2020 05:54:32 -0400
X-MC-Unique: ATs-m8ZMMLWkY5VhGvb_eQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3CD118A224D;
 Wed,  2 Sep 2020 09:54:30 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-129.ams2.redhat.com [10.36.112.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C488A7E333;
 Wed,  2 Sep 2020 09:54:24 +0000 (UTC)
Subject: Re: [PATCH 1/5] tests/qtest/ipmi-kcs: Fix assert side-effect
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200902080801.160652-1-philmd@redhat.com>
 <20200902080801.160652-2-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9007792c-9482-d5c7-09f3-3ce282862a68@redhat.com>
Date: Wed, 2 Sep 2020 11:54:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200902080801.160652-2-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Corey Minyard <minyard@acm.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/2020 10.07, Philippe Mathieu-Daudé wrote:
> Fix assert side-effect reported by Coverity:
> 
>   /qemu/tests/qtest/ipmi-kcs-test.c: 84 in kcs_wait_obf()
>   83         while (IPMI_KCS_CMDREG_GET_OBF() == 0) {
>   >>>     CID 1432368:  Incorrect expression  (ASSERT_SIDE_EFFECT)
>   >>>     Argument "--count" of g_assert() has a side effect.  The containing function might work differently in a non-debug build.
>   84             g_assert(--count != 0);
> 
> Reported-by: Coverity (CID 1432368)
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  tests/qtest/ipmi-kcs-test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/ipmi-kcs-test.c b/tests/qtest/ipmi-kcs-test.c
> index 693a6aacb52..fc0a918c8d1 100644
> --- a/tests/qtest/ipmi-kcs-test.c
> +++ b/tests/qtest/ipmi-kcs-test.c
> @@ -81,7 +81,8 @@ static void kcs_wait_obf(void)
>  {
>      unsigned int count = 1000;
>      while (IPMI_KCS_CMDREG_GET_OBF() == 0) {
> -        g_assert(--count != 0);
> +        --count;
> +        g_assert(count != 0);
>      }
>  }
>  
> 

You could also use g_assert_true() instead. Anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>



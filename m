Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F047DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E4A206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLLsyVum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E4A206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyI9h-0005Yk-0I
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 13:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jyI6v-0001jZ-Fc
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 13:00:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59308
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jyI6s-0003JX-UM
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 13:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595437250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GBKL2KDH0DuQCsm41OIUEbJpyWb36ZTlR0ekcnDwbOE=;
 b=WLLsyVum8smFNiaa4GZrWvHoiu0CRoOBA3OM6oXTQGqeH5yJFyTUMEtOfo/h5ye4qQ5o6U
 sweA1riWsa6VhsrHLdUVeOGOox2+HHKYUheyOdvo1TPK6eKkFJC6trptZzCJmRx7P3FDh2
 V1XdZaoX2ezLrfJJM1+QS6QKwIgXCl0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-ckgGDMVAO-yC0EIobFMM0A-1; Wed, 22 Jul 2020 13:00:42 -0400
X-MC-Unique: ckgGDMVAO-yC0EIobFMM0A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 444E31902EA1;
 Wed, 22 Jul 2020 17:00:40 +0000 (UTC)
Received: from localhost (unknown [10.10.67.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F7FD8BEC6;
 Wed, 22 Jul 2020 17:00:33 +0000 (UTC)
Date: Wed, 22 Jul 2020 13:00:32 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC PATCH v2 9/9] target/s390x: Use start-powered-off CPUState
 property
Message-ID: <20200722170032.GN1274972@habkost.net>
References: <20200722035016.469075-1-bauerman@linux.ibm.com>
 <20200722035016.469075-10-bauerman@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200722035016.469075-10-bauerman@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:34:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 22, 2020 at 12:50:16AM -0300, Thiago Jung Bauermann wrote:
> Instead of setting CPUState::halted to 1 in s390_cpu_initfn(), use the
> start-powered-off property which makes cpu_common_reset() initialize it to
> 1 in common code.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  target/s390x/cpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> NB: I was only able to test that this patch builds. I wasn't able to
> run it.
> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 08eb674d22..d3a14af1d9 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -291,7 +291,8 @@ static void s390_cpu_initfn(Object *obj)
>      S390CPU *cpu = S390_CPU(obj);
>  
>      cpu_set_cpustate_pointers(cpu);
> -    cs->halted = 1;
> +    object_property_set_bool(OBJECT(cs), "start-powered-off", true,
> +                             &error_abort);

Is this really OK?  s390 CPUs don't seem to set halted=1 on reset
today.


>      cs->exception_index = EXCP_HLT;
>  #if !defined(CONFIG_USER_ONLY)
>      object_property_add(obj, "crash-information", "GuestPanicInformation",
> 

-- 
Eduardo



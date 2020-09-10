Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73072C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:16:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F8C2078B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhUCx5sb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F8C2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGGop-0004If-UC
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 03:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kGGnh-0003Mk-Qf
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 03:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55253)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kGGnf-0003DJ-IA
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 03:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599722118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NujrVkwgQXomRFqBptCRf8I5qXyjyjT+dpDlxDqalIs=;
 b=DhUCx5sbS11FicIidga+LdQdZ+Yq/JDl8uk3YjUavRmsY7LZ1uvH+/gGzbWwaLgU4iZ8j+
 OiDo02K1dBfg7nyK/matjMkjJvSTXYbCnKm7QXh0y48QCic9E8a1xR5kL+5vwvZd0R9ZQ6
 q8q2NjkPvRI7vg1JSVkJ21sTb3jxe9U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-7ObhZB0GNoSSa78vWCPA5A-1; Thu, 10 Sep 2020 03:15:14 -0400
X-MC-Unique: 7ObhZB0GNoSSa78vWCPA5A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 191ECEF4EE;
 Thu, 10 Sep 2020 07:15:12 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-86.ams2.redhat.com [10.36.112.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDFEC5D9E8;
 Thu, 10 Sep 2020 07:15:03 +0000 (UTC)
Subject: Re: [PATCH 5/6] hw/pci-host/q35: Rename PCI 'black hole as '(memory)
 hole'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200910070131.435543-1-philmd@redhat.com>
 <20200910070131.435543-6-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7dbdef90-1ca6-bf27-7084-af0c716d01d9@redhat.com>
Date: Thu, 10 Sep 2020 09:15:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200910070131.435543-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 02:38:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
> In order to use inclusive terminology, rename "blackhole"
> as "(memory)hole".

A black hole is a well-known astronomical term, which is simply named
that way since it absorbes all light. I doubt that anybody could get
upset by this term?

> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/hw/pci-host/q35.h |  4 ++--
>  hw/pci-host/q35.c         | 38 +++++++++++++++++++-------------------
>  tests/qtest/q35-test.c    |  2 +-
>  3 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
> index 070305f83df..0fb90aca18b 100644
> --- a/include/hw/pci-host/q35.h
> +++ b/include/hw/pci-host/q35.h
> @@ -48,8 +48,8 @@ typedef struct MCHPCIState {
>      PAMMemoryRegion pam_regions[13];
>      MemoryRegion smram_region, open_high_smram;
>      MemoryRegion smram, low_smram, high_smram;
> -    MemoryRegion tseg_blackhole, tseg_window;
> -    MemoryRegion smbase_blackhole, smbase_window;
> +    MemoryRegion tseg_hole, tseg_window;
> +    MemoryRegion smbase_hole, smbase_window;

Maybe rather use smbase_memhole and tseg_memhole?

 Thomas



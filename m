Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B3DC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:13:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F8AC206EB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cdkgch77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8AC206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD59o-0004cW-6r
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 08:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kD59A-0003o2-SC
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:12:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25934
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kD599-0005l2-3t
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598962337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bXZM9FCUGiCJDHpzHHsEm8NqWmRAp2G9xa5LhVjAZu0=;
 b=Cdkgch77lTIzU167kuDuR8rG0EwNlTuWWS0YKjL2ALSTf1hWK6qnNXfgBGv1j0wQFBUXwD
 qqLV9JvQYjihYNUJQMS3dNsY74X1Hn71kXMefc9hYpNO1atGsPY826P4U1/fT+WYRfQdW7
 FpJ0IAcSSRopCR+BUkZ+7YvIO8dtmzE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-Ic8SnDFBNtGnY-l-SRn0AA-1; Tue, 01 Sep 2020 08:12:14 -0400
X-MC-Unique: Ic8SnDFBNtGnY-l-SRn0AA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A0061DDF1;
 Tue,  1 Sep 2020 12:12:13 +0000 (UTC)
Received: from imammedo-mac (unknown [10.40.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E55910013C4;
 Tue,  1 Sep 2020 12:12:08 +0000 (UTC)
Date: Tue, 1 Sep 2020 14:12:06 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v6 02/10] Revert "target/i386: Enable new apic id
 encoding for EPYC based cpus models"
Message-ID: <20200901141206.5c1638b0@imammedo-mac>
In-Reply-To: <159889933756.21294.13999336052652073520.stgit@naples-babu.amd.com>
References: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
 <159889933756.21294.13999336052652073520.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 23:17:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 31 Aug 2020 13:42:17 -0500
Babu Moger <babu.moger@amd.com> wrote:

> This reverts commit 247b18c593ec298446645af8d5d28911daf653b1.
> 
> Remove the EPYC specific apicid decoding and use the generic
> default decoding.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/i386/cpu.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 173e6f4a07..c9c1e681c2 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3995,7 +3995,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
>          .xlevel = 0x8000001E,
>          .model_id = "AMD EPYC Processor",
>          .cache_info = &epyc_cache_info,
> -        .use_epyc_apic_id_encoding = 1,
>          .versions = (X86CPUVersionDefinition[]) {
>              { .version = 1 },
>              {
> @@ -4123,7 +4122,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
>          .xlevel = 0x8000001E,
>          .model_id = "AMD EPYC-Rome Processor",
>          .cache_info = &epyc_rome_cache_info,
> -        .use_epyc_apic_id_encoding = 1,
>      },
>  };
>  
> 



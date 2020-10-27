Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166E1C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76993222C8
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ev5Ms2KW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76993222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQZB-00037G-CC
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 11:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kXQ5Q-0007S7-VC
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 10:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kXQ5N-0001sr-Ak
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 10:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603809387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CtN+IGDJS4flg55gW0A8MfWbaR3bWf0hVnh0joF1o4Y=;
 b=ev5Ms2KWXETxRbBXsvslt6JAb3xnhD7JdlB1OAxmUKLTHZNShPzDe63PzJpq0+b51u5ACx
 FSUynlKKoKqqU4jogEqkbKvs9GOqDlYAEyxPCbI2REDSyf8VU/xbVWrWInOuu4CnEy8ytC
 94PI8JJAbWWbEAvcawxATRvQdXiaklw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-D3V2cTgyPGeNGR3nUKkNzQ-1; Tue, 27 Oct 2020 10:36:25 -0400
X-MC-Unique: D3V2cTgyPGeNGR3nUKkNzQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D67D6409A;
 Tue, 27 Oct 2020 14:36:24 +0000 (UTC)
Received: from localhost (unknown [10.40.208.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F5521992F;
 Tue, 27 Oct 2020 14:36:14 +0000 (UTC)
Date: Tue, 27 Oct 2020 15:36:12 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 2/2] acpi/crs: Support ranges > 32b for hosts
Message-ID: <20201027153612.35e9faac@redhat.com>
In-Reply-To: <20201026193924.985014-2-ben.widawsky@intel.com>
References: <20201026193924.985014-1-ben.widawsky@intel.com>
 <20201026193924.985014-2-ben.widawsky@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, mst@redhat.com, jusual@redhat.com,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 12:39:24 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> According to PCIe spec 5.0 Type 1 header space Base Address Registers
> are defined by 7.5.1.2.1 Base Address Registers (same as Type 0). The
> _CRS region should allow for the same range (up to 64b). Prior to this
> change, any host bridge utilizing more than 32b for the BAR would have
> the address truncated and likely lead to conflicts when the operating
> systems reads the _CRS object.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Looks good to me, so

Reviewed-by: Igor Mammedov <imammedo@redhat.com>


CCing,
Michael to have a send pair of eyes on it 

but I wonder how/why ivshm (which might have quite large BAR) works.

PS:
please use git's --cover-letter option to create multi-patch series,
in the future

> 
> ---
> I don't think this effects any code currently in QEMU. You'd need to
> have a host bridge which has a BAR, and that BAR wants to be > 32b. I've
> hit this because I have a modified PXB device that does advertise a 64b
> BAR. Also, you'd need a platform that cares about ACPI, which, many do
> not.
> ---
>  hw/i386/acpi-build.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index df13abecf4..75604bdc74 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -789,8 +789,14 @@ static Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set)
>                  crs_range_insert(temp_range_set.io_ranges,
>                                   range_base, range_limit);
>              } else { /* "memory" */
> -                crs_range_insert(temp_range_set.mem_ranges,
> -                                 range_base, range_limit);
> +                uint64_t length = range_limit - range_base + 1;
> +                if (range_limit <= UINT32_MAX && length <= UINT32_MAX) {
> +                    crs_range_insert(temp_range_set.mem_ranges, range_base,
> +                                     range_limit);
> +                } else {
> +                    crs_range_insert(temp_range_set.mem_64bit_ranges,
> +                                     range_base, range_limit);
> +                }
>              }
>          }
>  



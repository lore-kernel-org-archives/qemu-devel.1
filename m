Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E60BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4862D23D1F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ChYraETO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4862D23D1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpsPu-0005pR-IJ
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 07:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jpsN8-0000bh-J6
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:54:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34635
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jpsN7-0007Hz-2u
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593431688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MA4RJ+nyLMtDN8blcjMCsuUsVD6JKUlppo2AmhvmQxQ=;
 b=ChYraETOSMRwFmrlQBLtGoMxgz+u5uHsI2Xx07jpTYs3TrAObdlWJz/xNPoH78Yjnz3SDG
 kg0pcYishtFBIEzPXFjf8VW0boCfyl/44S0l0/09fLLzO7jGqzwCr4HL+rKr7jYGFqGmdM
 sLcSh9tida+RxHBRsCvaipQ1ME0ST5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-QjMNog3pMwuXLeCYtIkA4A-1; Mon, 29 Jun 2020 07:54:45 -0400
X-MC-Unique: QjMNog3pMwuXLeCYtIkA4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 866BE107ACCD;
 Mon, 29 Jun 2020 11:54:44 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.195.222])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1868A1A835;
 Mon, 29 Jun 2020 11:54:36 +0000 (UTC)
Date: Mon, 29 Jun 2020 13:54:33 +0200
From: Andrew Jones <drjones@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v10 12/12] tests/acpi: update expected data files
Message-ID: <20200629115433.guw3qrmldfyshpma@kamzik.brq.redhat.com>
References: <20200619091905.21676-1-kraxel@redhat.com>
 <20200619091905.21676-13-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200619091905.21676-13-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:03:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 19, 2020 at 11:19:05AM +0200, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  tests/data/acpi/pc/DSDT           | Bin 5014 -> 4934 bytes
>  tests/data/acpi/pc/DSDT.acpihmat  | Bin 6338 -> 6258 bytes
>  tests/data/acpi/pc/DSDT.bridge    | Bin 6873 -> 6793 bytes
>  tests/data/acpi/pc/DSDT.cphp      | Bin 5477 -> 5397 bytes
>  tests/data/acpi/pc/DSDT.dimmpxm   | Bin 6667 -> 6587 bytes
>  tests/data/acpi/pc/DSDT.ipmikcs   | Bin 5086 -> 5006 bytes
>  tests/data/acpi/pc/DSDT.memhp     | Bin 6373 -> 6293 bytes
>  tests/data/acpi/pc/DSDT.numamem   | Bin 5020 -> 4940 bytes
>  tests/data/acpi/q35/DSDT          | Bin 7752 -> 7678 bytes
>  tests/data/acpi/q35/DSDT.acpihmat | Bin 9076 -> 9002 bytes
>  tests/data/acpi/q35/DSDT.bridge   | Bin 7769 -> 7695 bytes
>  tests/data/acpi/q35/DSDT.cphp     | Bin 8215 -> 8141 bytes
>  tests/data/acpi/q35/DSDT.dimmpxm  | Bin 9405 -> 9331 bytes
>  tests/data/acpi/q35/DSDT.ipmibt   | Bin 7827 -> 7753 bytes
>  tests/data/acpi/q35/DSDT.memhp    | Bin 9111 -> 9037 bytes
>  tests/data/acpi/q35/DSDT.mmio64   | Bin 8882 -> 8808 bytes
>  tests/data/acpi/q35/DSDT.numamem  | Bin 7758 -> 7684 bytes
>  tests/data/acpi/q35/DSDT.tis      | Bin 8357 -> 8283 bytes
>  18 files changed, 0 insertions(+), 0 deletions(-)
>

Hi Gerd and Michael,

Shouldn't this patch also include the removal of these files from
tests/qtest/bios-tables-test-allowed-diff.h?

Thanks,
drew



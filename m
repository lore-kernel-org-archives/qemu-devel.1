Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E824C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88D520661
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxTKNlhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88D520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxct-0000hu-3E
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVxab-0006N6-My
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:26:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40129
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVxaa-0002pf-Ss
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588685184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RiC+afvSlaGKTwLYF84n8Ug7KRRzE+KqEhvzmOpLiV4=;
 b=TxTKNlhrkoIXXdR1T0PxaNHC0jTGV+jaOXYuzJ45ZaEYPolIDY0JF7Vd+5m/3HS0THDsgJ
 W2fLTumgrP4dOBOfCJKrCiVySKS44rROHJAdVPhKQTbAxCpWj0wGI45uGqSy983s+d/eiB
 fW82Wl7dwB9brkcmqtS7iMwsiLyGEU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-BdbSSrVHN9enwPYSzcHMUg-1; Tue, 05 May 2020 09:26:20 -0400
X-MC-Unique: BdbSSrVHN9enwPYSzcHMUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 339728018A5;
 Tue,  5 May 2020 13:26:19 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43E4164425;
 Tue,  5 May 2020 13:26:06 +0000 (UTC)
Date: Tue, 5 May 2020 15:26:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v4 11/13] acpi: simplify build_isa_devices_aml()
Message-ID: <20200505152605.0eabb726@redhat.com>
In-Reply-To: <20200505113843.22012-12-kraxel@redhat.com>
References: <20200505113843.22012-1-kraxel@redhat.com>
 <20200505113843.22012-12-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  5 May 2020 13:38:41 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> x86 machines can have a single ISA bus only.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/acpi-build.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index cb3913d2ee76..1922868f3401 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1061,19 +1061,14 @@ static void build_hpet_aml(Aml *table)
>  static void build_isa_devices_aml(Aml *table)
>  {
>      bool ambiguous;
> -
> -    Aml *scope = aml_scope("_SB.PCI0.ISA");
>      Object *obj = object_resolve_path_type("", TYPE_ISA_BUS, &ambiguous);
> +    Aml *scope;
>  
> -    if (ambiguous) {
> -        error_report("Multiple ISA busses, unable to define IPMI ACPI data");
> -    } else if (!obj) {
> -        error_report("No ISA bus, unable to define IPMI ACPI data");
> -    } else {
> -        build_acpi_ipmi_devices(scope, BUS(obj), "\\_SB.PCI0.ISA");
> -        isa_build_aml(ISA_BUS(obj), scope);
> -    }
> +    assert(obj && !ambiguous);
>  
> +    scope = aml_scope("_SB.PCI0.ISA");
> +    build_acpi_ipmi_devices(scope, BUS(obj), "\\_SB.PCI0.ISA");
> +    isa_build_aml(ISA_BUS(obj), scope);
>      aml_append(table, scope);
>  }
>  



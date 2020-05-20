Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EB0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3209A207C4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JO5Gx3XO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3209A207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbLqk-0003TT-3t
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 06:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jbLq3-0002Wx-TP
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:20:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55142
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jbLq3-0007lJ-9D
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589970038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ZsK6xl1dfxU5WOkwJPI4pMEWhC0KpylpcZ83S5ySqk=;
 b=JO5Gx3XOEeqtQkLImmNFfNLHNBQAv/oO5g1ld1XW+bB/bmZG+ZcYXrwRoj36yBt9MetFcV
 QVBu2CopllJO96pqsJ0Wn3K/x6FpJincTZrRMvqOhObeBC4m6tnLWaSMs4ZNk/Dir04d6E
 C9gqhw7gqpfLjhJgImX9bdg4i8/ddk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-PDaE8ZFANBW2TCWJnE7UqQ-1; Wed, 20 May 2020 06:20:34 -0400
X-MC-Unique: PDaE8ZFANBW2TCWJnE7UqQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1501800688;
 Wed, 20 May 2020 10:20:33 +0000 (UTC)
Received: from nas.mammed.net (unknown [10.40.193.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 773615D9CA;
 Wed, 20 May 2020 10:20:22 +0000 (UTC)
Date: Wed, 20 May 2020 12:20:20 +0200
From: Igor Mammedow <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 15/16] acpi: drop build_piix4_pm()
Message-ID: <20200520122020.2fd0be10@nas.mammed.net>
In-Reply-To: <20200515150421.25479-16-kraxel@redhat.com>
References: <20200515150421.25479-1-kraxel@redhat.com>
 <20200515150421.25479-16-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 May 2020 17:04:20 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> The _SB.PCI0.PX13.P13C opregion (holds isa device enable bits)
> is not used any more, remove it from DSDT.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Igor Mammedow <imammedo@redhat.com>

> ---
>  hw/i386/acpi-build.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 765409a90eb6..c1e63cce5e8e 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1441,21 +1441,6 @@ static void build_q35_isa_bridge(Aml *table)
>      aml_append(table, scope);
>  }
>  
> -static void build_piix4_pm(Aml *table)
> -{
> -    Aml *dev;
> -    Aml *scope;
> -
> -    scope =  aml_scope("_SB.PCI0");
> -    dev = aml_device("PX13");
> -    aml_append(dev, aml_name_decl("_ADR", aml_int(0x00010003)));
> -
> -    aml_append(dev, aml_operation_region("P13C", AML_PCI_CONFIG,
> -                                         aml_int(0x00), 0xff));
> -    aml_append(scope, dev);
> -    aml_append(table, scope);
> -}
> -
>  static void build_piix4_isa_bridge(Aml *table)
>  {
>      Aml *dev;
> @@ -1607,7 +1592,6 @@ build_dsdt(GArray *table_data, BIOSLinker
> *linker, aml_append(dsdt, sb_scope);
>  
>          build_hpet_aml(dsdt);
> -        build_piix4_pm(dsdt);
>          build_piix4_isa_bridge(dsdt);
>          build_isa_devices_aml(dsdt);
>          build_piix4_pci_hotplug(dsdt);



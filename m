Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77274C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 14:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C6C9206D5
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 14:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+6I1p7B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6C9206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWKpi-0007hM-7i
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 10:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jWKoo-00079o-W2
 for qemu-devel@nongnu.org; Wed, 06 May 2020 10:14:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31470
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jWKon-0005zl-EH
 for qemu-devel@nongnu.org; Wed, 06 May 2020 10:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588774475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZYDmO9a7To9sfnVrEBL2sRTsCYG/PXL1h5B/xDgPfNs=;
 b=d+6I1p7Bif0a3PPhWdC0UwdyOp+LmGEhQJQveIsrgwo280ZZDU3nZFzsjCt7hQQyxVc66W
 7ndUmPmhDJZnTtAdffuYmvHDK3LUPXC2mG//5z4ygHjWccuoQTMipFJ3Dk3X8k27HSgaGX
 Om5hvjXfxOmC265+/TEkdlIkYe1grs0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-UpUnQHbGNWS0oA2TNAqVKA-1; Wed, 06 May 2020 10:14:32 -0400
X-MC-Unique: UpUnQHbGNWS0oA2TNAqVKA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8546A18FE86A;
 Wed,  6 May 2020 14:14:31 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ADA5D1001B07;
 Wed,  6 May 2020 14:14:20 +0000 (UTC)
Date: Wed, 6 May 2020 16:14:19 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 09/13] microvm: add minimal acpi support
Message-ID: <20200506161419.3d17e26a@redhat.com>
In-Reply-To: <20200506103549.yplkfmv3uqdbeumt@sirius.home.kraxel.org>
References: <20200505134305.22666-1-kraxel@redhat.com>
 <20200505134305.22666-10-kraxel@redhat.com>
 <20200505172037.2bd55d6e@redhat.com>
 <20200506103549.yplkfmv3uqdbeumt@sirius.home.kraxel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 05:50:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 6 May 2020 12:35:49 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> > > +/* FIXME: copy & paste */
> > > +static void acpi_dsdt_add_power_button(Aml *scope)
> > > +{
> > > +    Aml *dev = aml_device(ACPI_POWER_BUTTON_DEVICE);
> > > +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C0C")));
> > > +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> > > +    aml_append(scope, dev);
> > > +}  
> > 
> > could be unified with ARM's version  
> 
> Yep.  Suggestions for a good place?  hw/acpi/aml-build.c ?
sounds good to me

> 
> > > +    acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
> > > +    acpi_align_size(tables->linker->cmd_blob, ACPI_BUILD_ALIGN_SIZE);  
> > I'd drop these as that was mostly to counter various migration issues on legacy  
> 
> Dropped.
> 
> take care,
>   Gerd
> 
> 



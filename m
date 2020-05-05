Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37ADC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9E29206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7dcGZK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E29206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxoe-00068i-SR
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVxns-0004wk-12
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:40:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23559
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVxnr-0000Py-5p
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588686006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pMohc8dCOo9kS1QYgc0URJecy8YubcN34NeeF2iyZeA=;
 b=A7dcGZK52EjLw33NadYx/U85bRZd51lEVOxtLq8qaK2my3vlwvDoi0P6hPQD6IRsHrJs4R
 +ONi5/nuCtIpp1l+MsqnvheI5OrdYk5/N0om7EIwKeWp4lbTC5KAl+mFpYiahAr7rpOMJ8
 ZbTmKeE6w8Z/0zUWCairEnHwEkCxFas=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-Y5-0Yb-NPtaXDvORimfw3A-1; Tue, 05 May 2020 09:40:05 -0400
X-MC-Unique: Y5-0Yb-NPtaXDvORimfw3A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1232D107ACF4;
 Tue,  5 May 2020 13:40:03 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0CDB60621;
 Tue,  5 May 2020 13:39:50 +0000 (UTC)
Date: Tue, 5 May 2020 15:39:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v4 13/13] floppy: make isa_fdc_get_drive_max_chs static
Message-ID: <20200505153949.0e912bd3@redhat.com>
In-Reply-To: <20200505113843.22012-14-kraxel@redhat.com>
References: <20200505113843.22012-1-kraxel@redhat.com>
 <20200505113843.22012-14-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 03:48:16
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

On Tue,  5 May 2020 13:38:43 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> acpi aml generator needs this, but it is in floppy code now
> so we can make the function static.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/block/fdc.h | 2 --
>  hw/block/fdc.c         | 4 ++--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
> index c15ff4c62315..5d71cf972268 100644
> --- a/include/hw/block/fdc.h
> +++ b/include/hw/block/fdc.h
> @@ -16,7 +16,5 @@ void sun4m_fdctrl_init(qemu_irq irq, hwaddr io_base,
>                         DriveInfo **fds, qemu_irq *fdc_tc);
>  
>  FloppyDriveType isa_fdc_get_drive_type(ISADevice *fdc, int i);
> -void isa_fdc_get_drive_max_chs(FloppyDriveType type,
> -                               uint8_t *maxc, uint8_t *maxh, uint8_t *maxs);
>  
>  #endif
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 40faa088b5f7..499a580b993c 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -2744,8 +2744,8 @@ FloppyDriveType isa_fdc_get_drive_type(ISADevice *fdc, int i)
>      return isa->state.drives[i].drive;
>  }
>  
> -void isa_fdc_get_drive_max_chs(FloppyDriveType type,
> -                               uint8_t *maxc, uint8_t *maxh, uint8_t *maxs)
> +static void isa_fdc_get_drive_max_chs(FloppyDriveType type, uint8_t *maxc,
> +                                      uint8_t *maxh, uint8_t *maxs)
>  {
>      const FDFormat *fdf;
>  



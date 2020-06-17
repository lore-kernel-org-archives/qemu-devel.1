Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CF3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:41:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 206EC212CC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCkOChrw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206EC212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlTdW-0001an-Aa
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 04:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jlTcm-0000rb-Eo
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:40:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22346
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jlTci-0006ke-O3
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592383243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=pfY4NB5w6XxrphGXxmJIvFsPPManCdRM0d4dpGR/bi8=;
 b=CCkOChrwFZEJUm/8LT5CBTUYASVBVLGAZhaJBBxQS9Ml5Wq3UvTxQ3RXYWs26ky/T2qpOK
 JddmfhQsMj4bSdInFDSDH5+DC8CRq33epr8V+UHH47E74t7k0GEuV964IGlN2g1sEnuh9O
 99bmFZA5O1ztnBuAgRlcolzFf+TqSHE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-3ASRbLviMq67iV9hBmJ-LQ-1; Wed, 17 Jun 2020 04:40:41 -0400
X-MC-Unique: 3ASRbLviMq67iV9hBmJ-LQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 565348C31FA;
 Wed, 17 Jun 2020 08:40:38 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-131.ams2.redhat.com [10.36.112.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C56E5EE0E;
 Wed, 17 Jun 2020 08:40:25 +0000 (UTC)
Subject: Re: [PATCH v9 02/10] acpi: move aml builder code for floppy device
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200617071138.11159-1-kraxel@redhat.com>
 <20200617071138.11159-3-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <62ad00f7-c7f2-ed80-01a3-8d8c6aa9fba9@redhat.com>
Date: Wed, 17 Jun 2020 10:40:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200617071138.11159-3-kraxel@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/06/2020 09.11, Gerd Hoffmann wrote:
> DSDT change: isa device order changes in case MI1 (ipmi) is present.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/block/fdc.c                  |  83 ++++++++++++++++++++++++++++++++
>  hw/i386/acpi-build.c            |  83 --------------------------------
>  stubs/cmos.c                    |   7 +++
>  stubs/Makefile.objs             |   1 +
>  tests/data/acpi/pc/DSDT.ipmikcs | Bin 5086 -> 5086 bytes
>  5 files changed, 91 insertions(+), 83 deletions(-)
>  create mode 100644 stubs/cmos.c

Hmm, not all targets that use CONFIG_FDC also have ACPI ... would it be
possible to move the ACPI-related code into a new file, say fdc-acpi.c,
instead and only compile that if both, CONFIG_FDC and CONFIG_ACPI are
enabled?

 Thomas



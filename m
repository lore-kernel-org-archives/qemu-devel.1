Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D27FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:51:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4D902068F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYLFr5gr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D902068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juuBR-0000F1-Ub
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1juuAa-00080G-9Y
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:50:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44723
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1juuAY-0001n8-D7
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594630237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qiS/70F0hm0hRqFFQ94OcfkKszzC7depaWsuZ83TtYs=;
 b=EYLFr5grr1ZnmgPnaxv5g7on/+H7pkeln8UDtBv0KQV/cXO6HWeSnFdwmRy7cSsJi77w6s
 HjZVrbnfFI7DW/K0pN1W4JrEAAn5urNTfv/rEtPtlivAFq1R6CUGOgVIdaPVrpURgMeV9j
 DcN5KJWgnN1kpDTDC5rfVgd7coMC68I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-gU83_B7CPhelEM9qgj4BFw-1; Mon, 13 Jul 2020 04:50:34 -0400
X-MC-Unique: gU83_B7CPhelEM9qgj4BFw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67240100CCC0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 08:50:33 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-114-76.ams2.redhat.com [10.36.114.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A6C912C24F;
 Mon, 13 Jul 2020 08:50:27 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 4D78B3E048E; Mon, 13 Jul 2020 10:50:26 +0200 (CEST)
Date: Mon, 13 Jul 2020 10:50:26 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] MAINTAINERS: Cover the firmware JSON schema
Message-ID: <20200713085026.GL24474@paraplu>
References: <20200703183450.32398-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703183450.32398-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 03, 2020 at 08:34:50PM +0200, Philippe Mathieu-Daudé wrote:

(Was on PTO; just catching up.)

> Add an entry to cover firmware.json (see commit 3a0adfc9bf:
> schema that describes the different uses and properties of
> virtual machine firmware).
> 
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Kashyap Chamarthy <kchamart@redhat.com>
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Suggested-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Since RFC v1:
> - Added Daniel & Kashyap as reviewer
> - Added myself as co-maintainer with Laszlo
> 
> Based on a comment from Laszlo:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg604925.html
> Background info from Kashyap:
> https://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg01978.html
> ---

Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com> 

>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dec252f38b..64bcea658d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2601,6 +2601,14 @@ F: include/hw/i2c/smbus_master.h
>  F: include/hw/i2c/smbus_slave.h
>  F: include/hw/i2c/smbus_eeprom.h
>  
> +Firmware schema specifications
> +M: Laszlo Ersek <lersek@redhat.com>
> +M: Philippe Mathieu-Daudé <philmd@redhat.com>
> +R: Daniel P. Berrange <berrange@redhat.com>
> +R: Kashyap Chamarthy <kchamart@redhat.com>
> +S: Maintained
> +F: docs/interop/firmware.json
> +
>  EDK2 Firmware
>  M: Laszlo Ersek <lersek@redhat.com>
>  M: Philippe Mathieu-Daudé <philmd@redhat.com>
> -- 
> 2.21.3
> 

-- 
/kashyap



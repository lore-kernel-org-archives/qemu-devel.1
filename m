Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00FDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:00:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88DCF206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLJfbklr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88DCF206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsp55-0004Tl-P6
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 11:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jsp4H-0003bW-Ji
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 10:59:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32848
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jsp4F-0001Jx-SG
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 10:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594133970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRFBEFQA4aqU9wYDWHRKrElE1LW+6BtejFrfNGzPAYg=;
 b=hLJfbklrHvTx50uHxljrSghtJfUEkzMAY/BQJaD7IkgACGo2LXRLGhaHYOD26FM8/QJg/P
 EKy9eii3KPXducwouGp4ogWo2nXRPoqODW0j/7b6e1Q67tk+ixKRFygMBR/unJLzX+Bxeh
 Q6aKWTnZUjKpQltmiURsywDrruZAB3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-d2YQSLC_N52PjkLqABtZiQ-1; Tue, 07 Jul 2020 10:59:26 -0400
X-MC-Unique: d2YQSLC_N52PjkLqABtZiQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB13D8005B0
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2020 14:59:25 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-90.ams2.redhat.com
 [10.36.114.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2EBCF797E8;
 Tue,  7 Jul 2020 14:59:19 +0000 (UTC)
Subject: Re: [PATCH v2] MAINTAINERS: Cover the firmware JSON schema
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200703183450.32398-1-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <25e37ce6-848c-8993-265e-3d047ce30c12@redhat.com>
Date: Tue, 7 Jul 2020 16:59:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200703183450.32398-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:46:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kashyap Chamarthy <kchamart@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/03/20 20:34, Philippe Mathieu-Daudé wrote:
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
> 

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thank you!
Laszlo



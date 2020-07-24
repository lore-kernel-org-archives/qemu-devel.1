Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473C6C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 04:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07FFE206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 04:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OfBVdtoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FFE206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jypOR-0001cc-Aa
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 00:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jypJQ-0008NP-Kf
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 00:28:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52457
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jypJO-0000IS-6p
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 00:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595564876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=/Sg0J4R+QSQ9MEhufoVMFTHZOZhrVjT0sHOnOHpE4ck=;
 b=OfBVdtoF/dKuuk/xKcEGL1AUh9PMbd90UePHAzzq/shT2G9HFqIMLT+C5grSh8QqafFcDO
 GwWU5fmfN/a82z85d16q5Ym+4t9h38Vle2JuIDN29y1j8FtDAzIteiSzSET+4Tm9AXIopH
 bU4tnZY0tg6vA2+AT+NbiytUvzFZK4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-9V1PDo9nM3qMft2hGJCk1A-1; Fri, 24 Jul 2020 00:27:53 -0400
X-MC-Unique: 9V1PDo9nM3qMft2hGJCk1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5449A8015F4;
 Fri, 24 Jul 2020 04:27:52 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-77.ams2.redhat.com [10.36.112.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EDE25C1BD;
 Fri, 24 Jul 2020 04:27:44 +0000 (UTC)
Subject: Re: [PATCH] hw/input/virtio-input-hid.c: Don't undef CONFIG_CURSES
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200723192457.28136-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <02eb937a-ecf9-f453-4853-0d27ff3cb961@redhat.com>
Date: Fri, 24 Jul 2020 06:27:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200723192457.28136-1-peter.maydell@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:00:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/07/2020 21.24, Peter Maydell wrote:
> virtio-input-hid.c undefines CONFIG_CURSES before including
> ui/console.h. However since commits e2f82e924d057935 and b0766612d16da18
> that header does not have behaviour dependent on CONFIG_CURSES.
> Remove the now-unneeded undef.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> NB: tested with 'make check' only.
> 
>  hw/input/virtio-input-hid.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
> index 09cf2609854..a7a244a95db 100644
> --- a/hw/input/virtio-input-hid.c
> +++ b/hw/input/virtio-input-hid.c
> @@ -12,7 +12,6 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/virtio/virtio-input.h"
>  
> -#undef CONFIG_CURSES
>  #include "ui/console.h"
>  
>  #include "standard-headers/linux/input.h"
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>



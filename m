Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44932C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 09:49:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E33C2072E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 09:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+Q5M3WV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E33C2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxou2-0004oT-CD
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 05:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jxotO-0003ys-GE
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 05:48:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38023
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jxotM-0004W0-RP
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 05:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595324935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tOJ+oh49DyDuh/999wqe2owLearUGseo9Wje3mkwjOc=;
 b=h+Q5M3WVgnJsGwz6q+lzD3Iw7N0rsYl0JZqQkrTT3bWzdYb9ISX0OwF13ZNw6MHAU5CaZx
 1PlFLzDSeK1/jfgO1VdlwaJ+2tM4+EvcrvKVggAOu5R9XHGO6PZLYVV1z4youEdeybGgcJ
 q4pMYZzaRuWGPJ9sapjgGr/KFOiAZ4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-DMLxgRkdP9CFdIqVYU2r0g-1; Tue, 21 Jul 2020 05:48:54 -0400
X-MC-Unique: DMLxgRkdP9CFdIqVYU2r0g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5E898014D4;
 Tue, 21 Jul 2020 09:48:52 +0000 (UTC)
Received: from kaapi (unknown [10.33.36.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC2B01A888;
 Tue, 21 Jul 2020 09:48:45 +0000 (UTC)
Date: Tue, 21 Jul 2020 15:18:42 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 5/9] nvram: add nrf51_soc flash read method
In-Reply-To: <03c8f705-9e6c-9369-c547-eb09ede77fc1@redhat.com>
Message-ID: <nycvar.YSQ.7.78.906.2007211517160.4380@xnncv>
References: <20200624185523.762240-1-ppandit@redhat.com>
 <20200624185523.762240-6-ppandit@redhat.com>
 <CAKXe6SKBYpdouoN=C_NZawLOnDMYjDU2X3c2CsCv7X7rPym1Rg@mail.gmail.com>
 <CAFEAcA8s8-OCmKEJsp6bJXBXH+JiyxrtSbHPiLimCj8+xz3obw@mail.gmail.com>
 <nycvar.YSQ.7.78.906.2007211212380.4380@xnncv>
 <03c8f705-9e6c-9369-c547-eb09ede77fc1@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 boundary="-1463810047-1617661618-1595324932=:4380"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:30:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
---1463810047-1617661618-1595324932=:4380
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

+-- On Tue, 21 Jul 2020, Philippe Mathieu-Daudé wrote --+
| On 7/21/20 8:47 AM, P J P wrote:
| > +-- On Thu, 16 Jul 2020, Peter Maydell wrote --+
| > | > The 'flash_ops' is for ROM, though I don't see where it calls 
| > | > 'memory_region_rom_device_set_romd' to ROMD, so this MR is in MMIO 
| > | > mode and it needs a read callback.
| > | 
| > | I think that 'romd mode' (ie reads-go-directly-to-RAM) is the default: 
| > | memory_region_initfn() sets romd_mode to true. So unless the device 
| > | actively calls memory_region_rom_device_set_romd(mr, false) then the 
| > | read callback can't be reached.
| > 
| > So, we go with g_assert_not_reached() ? We seem to have differing opinions 
| > about these callbacks.
| 
| - Callback missing because we neglected to implement the
|   hardware behavior:
| 
|   => qemu_log_mask(LOG_UNIMP, ...)
| 
| - Callback missing because the access is illegal on hardware
|   (write on read-only register, read on write-only register):
| 
|   => qemu_log_mask(LOG_GUEST_ERROR, ...)
| 
| - Impossible situation unrelated to the hardware/guest behavior
|   (problem in QEMU design)
| 
|   => g_assert_not_reached()
| 
| Note, when we runs QEMU with LOG_UNIMP/LOG_GUEST_ERROR enabled,
| we are usually interested in what address the guest is accessing,
| and in the write case, what value is written.

Okay, preparing a revised patch series.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-1617661618-1595324932=:4380--



Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF69BC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 06:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B872B206E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 06:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCexSJWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B872B206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxm5O-0007Yg-2S
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 02:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jxm4L-00077A-3o
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 02:48:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24855
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jxm4I-0007B5-Fl
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 02:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595314080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m6NkPO0QiFMaunc5HgLvHMDilFBkxKbiW/erhLglKZI=;
 b=bCexSJWRx01lBzBx4vEvzXUikhHcquuvxOlX6FQgUlapm2FW+THB2qjtP84y3U1IkyQfvm
 2FXh34zBvWIiDvKs4lzLPGhwDop6l2tSN0JvR44+JD721rY+9qn+n2ypvXgEt1Ox+tf3Y5
 k/OSSCSOnGOwFY3f1KjNwbBYOa7rIWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-gjkQGT32MXGzGC-UwVYa3A-1; Tue, 21 Jul 2020 02:47:58 -0400
X-MC-Unique: gjkQGT32MXGzGC-UwVYa3A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33F8F91270;
 Tue, 21 Jul 2020 06:47:57 +0000 (UTC)
Received: from kaapi (unknown [10.33.36.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5505B5D9CA;
 Tue, 21 Jul 2020 06:47:50 +0000 (UTC)
Date: Tue, 21 Jul 2020 12:17:47 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 5/9] nvram: add nrf51_soc flash read method
In-Reply-To: <CAFEAcA8s8-OCmKEJsp6bJXBXH+JiyxrtSbHPiLimCj8+xz3obw@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.78.906.2007211212380.4380@xnncv>
References: <20200624185523.762240-1-ppandit@redhat.com>
 <20200624185523.762240-6-ppandit@redhat.com>
 <CAKXe6SKBYpdouoN=C_NZawLOnDMYjDU2X3c2CsCv7X7rPym1Rg@mail.gmail.com>
 <CAFEAcA8s8-OCmKEJsp6bJXBXH+JiyxrtSbHPiLimCj8+xz3obw@mail.gmail.com>
MIME-Version: 1.0
Content-ID: <nycvar.YSQ.7.78.906.2007211217050.4380@xnncv>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 BOUNDARY="-1463810047-232955485-1595313981=:4380"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:30:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_CHARSET_FARAWAY=2.45, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
---1463810047-232955485-1595313981=:4380
Content-Type: text/plain; CHARSET=ISO-2022-JP
Content-ID: <nycvar.YSQ.7.78.906.2007211217051.4380@xnncv>

+-- On Thu, 16 Jul 2020, Peter Maydell wrote --+
| > P J P <ppandit@redhat.com> 于2020年6月25日周四 上午3:01写道：
| > > +static uint64_t flash_read(void *opaque, hwaddr offset, unsigned size)
| > > +{
| > > +    NRF51NVMState *s = NRF51_NVM(opaque);
| > > +
| > > +    assert(offset + size <= s->flash_size);
| > > +    return ldl_le_p(s->storage + offset);
| > > +}
| >
| > The 'flash_ops' is for ROM, though I don't see where it calls 
| > 'memory_region_rom_device_set_romd' to ROMD, so this MR is in MMIO mode 
| > and it needs a read callback.
| 
| I think that 'romd mode' (ie reads-go-directly-to-RAM) is the default: 
| memory_region_initfn() sets romd_mode to true. So unless the device actively 
| calls memory_region_rom_device_set_romd(mr, false) then the read callback 
| can't be reached.

So, we go with g_assert_not_reached() ? We seem to have differing opinions 
about these callbacks.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-232955485-1595313981=:4380--



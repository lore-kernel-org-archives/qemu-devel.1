Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E41C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A5C23D1F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUwrxtsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A5C23D1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpsPv-0005sn-Ug
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 07:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jpsNv-0002Pm-Ma
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:55:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44264
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jpsNt-0007RB-N0
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593431737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GasQesvhlLHhC9Dq4DfXt8SrRUVvus/peOpzLMWHgr0=;
 b=WUwrxtsryxJC5jbJAyk6NWUvZeFUkoFc8Rh6evnlrsQwz585ry2fjMrYkgCrN2AhkmkmZc
 Ao633d0gGb7NZVTB6KUgR2ToCyQn8zLcBoe73teAcu+pYzBBq/U9jleEry60TEMWr1pp/M
 QpBzsNY0S4HI3g2+SDJQ+/ZV00WVG4s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-0M0ZfkB6MdGQz_kXsc-C9g-1; Mon, 29 Jun 2020 07:55:33 -0400
X-MC-Unique: 0M0ZfkB6MdGQz_kXsc-C9g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03CFE8015F0;
 Mon, 29 Jun 2020 11:55:32 +0000 (UTC)
Received: from kaapi (ovpn-112-133.phx2.redhat.com [10.3.112.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3F9A60BF3;
 Mon, 29 Jun 2020 11:55:23 +0000 (UTC)
Date: Mon, 29 Jun 2020 17:25:21 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [PATCH v2 5/9] nvram: add nrf51_soc flash read method
In-Reply-To: <CAKXe6SKBYpdouoN=C_NZawLOnDMYjDU2X3c2CsCv7X7rPym1Rg@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.77.849.2006291718520.92950@xnncv>
References: <20200624185523.762240-1-ppandit@redhat.com>
 <20200624185523.762240-6-ppandit@redhat.com>
 <CAKXe6SKBYpdouoN=C_NZawLOnDMYjDU2X3c2CsCv7X7rPym1Rg@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 boundary="-1463810047-42251937-1593431731=:92950"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:10:03
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
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
---1463810047-42251937-1593431731=:92950
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

  Hello Li,

+-- On Mon, 29 Jun 2020, Li Qiang wrote --+
| P J P <ppandit@redhat.com> 于2020年6月25日周四 上午3:01写道：
| > Update v2: return ldl_le_p()
| >   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg04972.html
| >
| > +static uint64_t flash_read(void *opaque, hwaddr offset, unsigned size)
| > +{
| > +    NRF51NVMState *s = NRF51_NVM(opaque);
| > +
| > +    assert(offset + size <= s->flash_size);
| > +    return ldl_le_p(s->storage + offset);
| > +}
| 
| However as the origin code doesn't provide a read callback. So why here we 
| return something?
| 
| I prefer here just 'qemu_log_mask(LOG_UNIMP, "%s not implemented\n", 
| __func__);' as other patches does.

Earlier patch v1 did that. It was suggested to return ldl_le_p(), as that's a 
valid return IIUC, instead of a zero(0), in case flash_read() is called.

Thanks so much for the reviews. I'll send a revised series with due updates.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-42251937-1593431731=:92950--



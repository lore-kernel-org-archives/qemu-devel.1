Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2F0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C953220709
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqNTK+F4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C953220709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joO2Z-0000Uf-51
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 05:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1joO1y-0008Ui-Ii
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:18:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27648
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1joO1w-0000oc-JO
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593076727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2aIncgJn1mHPs/W76R1xeTdToleS9l/4w984hW85V0I=;
 b=KqNTK+F43woX6mBchgtGiRltXg3OVONNHEu7uHYO526G9LnDy5GGZeiLAm7E4VJCmiGWm4
 fbp/yClcTNair7VxydwLYVgyoZhF0Lf3LLR+uAYZiAzFQMzVMzh7XauN+RKE5t0sDT9Vlb
 FcTanxRQVO2+UyWWzLvvutgHyA/VE8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-Lavkkz58MhWhN6rRl9bi5Q-1; Thu, 25 Jun 2020 05:18:44 -0400
X-MC-Unique: Lavkkz58MhWhN6rRl9bi5Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E37C0EC1A0;
 Thu, 25 Jun 2020 09:18:42 +0000 (UTC)
Received: from kaapi (unknown [10.74.8.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBDD661981;
 Thu, 25 Jun 2020 09:18:35 +0000 (UTC)
Date: Thu, 25 Jun 2020 14:48:32 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 7/9] tz-ppc: add dummy read/write methods
In-Reply-To: <7ffe6cd9-fc23-3fdf-6c57-7bb0af0dd030@redhat.com>
Message-ID: <nycvar.YSQ.7.77.849.2006251427210.92950@xnncv>
References: <20200624185523.762240-1-ppandit@redhat.com>
 <20200624185523.762240-8-ppandit@redhat.com>
 <7ffe6cd9-fc23-3fdf-6c57-7bb0af0dd030@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 boundary="-1463810047-199314216-1593076722=:92950"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
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
---1463810047-199314216-1593076722=:92950
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

+-- On Thu, 25 Jun 2020, Philippe Mathieu-Daudé wrote --+
| > @@ -196,7 +196,22 @@ static bool tz_ppc_dummy_accepts(void *opaque, hwaddr addr,
| >      g_assert_not_reached();
| 
| This is a shame we now have to fill the read/write handlers for
| unreachable code :( 
|
| > +static uint64_t tz_ppc_dummy_read(void *opaque, hwaddr addr, unsigned size)
| 
| I'd instead use a clearer:
|        g_assert_not_reached();
| 
| > +static void tz_ppc_dummy_write(void *opaque, hwaddr addr,
| 
| Ditto:
|        g_assert_not_reached();

This will likely be called in tz_ppc_dummy_accepts() above. Do we still want 
to revise this patch? considering read/write callbacks are unreachable.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-199314216-1593076722=:92950--



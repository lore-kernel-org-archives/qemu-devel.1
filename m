Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EDEC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA0D206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBu7Biot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA0D206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw7C1-0005b7-9N
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 12:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jw7Aq-0004Af-7V
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:55:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30410
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jw7An-00045c-I3
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594918552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pQSzv+L9p/tPTT6GgApGa3XaD3YaVzw488JYyQUO+Sw=;
 b=eBu7BiotdlyRXliha9AMWQEqcrkk5+GHo879CIdYINzV4HlGnRfEy6F1Y08+nAW6PIToWN
 fV5SL3kvFmqYSmgutjtBDQ8uVgIcmcbgLrMr5dNtJq5Xap2hnT3Nt10Z5UbJXRNvA2bKUx
 3ObrPRmFuKSjdkdA/YYTMdR4rvXZkC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-CAfyDSscMQ-hjS2Zw8LXcg-1; Thu, 16 Jul 2020 12:55:48 -0400
X-MC-Unique: CAfyDSscMQ-hjS2Zw8LXcg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CEDC1083CCC;
 Thu, 16 Jul 2020 16:55:46 +0000 (UTC)
Received: from kaapi (unknown [10.40.192.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C85B6FEF7;
 Thu, 16 Jul 2020 16:55:32 +0000 (UTC)
Date: Thu, 16 Jul 2020 22:25:29 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 8/9] imx7-ccm: add digprog mmio write method
In-Reply-To: <CAFEAcA83oGZMFS40m2rcFF+b-k_B1=e5QORwPAN68e1zjhqDHQ@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.78.906.2007162217590.950384@xnncv>
References: <20200630122710.1119158-1-ppandit@redhat.com>
 <20200630122710.1119158-9-ppandit@redhat.com>
 <CAFEAcA83oGZMFS40m2rcFF+b-k_B1=e5QORwPAN68e1zjhqDHQ@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 19:36:06
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
Cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Thu, 16 Jul 2020, Peter Maydell wrote --+
| > +static void imx7_digprog_write(void *opaque, hwaddr addr,
| > +                                        uint64_t data, unsigned size)
| > +{
| > +    qemu_log_mask(LOG_UNIMP, "%s not implemented\n", __func__);
| > +}
| 
| This covers a single register (DIGPROG) which is read-only (it returns a 
| silicon revision number). So this is not a LOG_UNIMP, but a LOG_GUEST_ERROR:
| 
|      qemu_log_mask(LOG_GUEST_ERROR, "Guest write to read-only
| ANALOG_DIGPROG register\n");

Should this be g_assert_not_reached() in that case?

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D



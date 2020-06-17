Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7E0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 17:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4715A21556
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 17:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RG7Q0350"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4715A21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlcKa-0002Hx-J2
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 13:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jlcK1-0001r7-3U
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 13:58:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52478
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jlcJy-00012r-7H
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 13:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592416677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GU8V17kDPOCGVjYyRW/VfK0zMJsb0nTAVOmJji8R1kI=;
 b=RG7Q0350i6X4LR3kuOipCDDXchDmd4hK+rqkkbi8wX7ziJjcSHqfrxDLr7z+kTK3EgN4kC
 IEFPgv8ritZg4FnYcjdXtj1yCneJd8C3rq5A11tbhgm3szAskM6SHWXB1JhvDsJ2ISZwz5
 gUcNuQJ1xtZTO2T/M5CUCbg2HS1aCpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-lTu9-5miP2ar78PudjdZig-1; Wed, 17 Jun 2020 13:57:50 -0400
X-MC-Unique: lTu9-5miP2ar78PudjdZig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80581BFC3;
 Wed, 17 Jun 2020 17:57:48 +0000 (UTC)
Received: from kaapi (vpn2-54-83.bne.redhat.com [10.64.54.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71EA86ED96;
 Wed, 17 Jun 2020 17:57:37 +0000 (UTC)
Date: Wed, 17 Jun 2020 23:27:33 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/6] Add various undefined MMIO r/w functions
In-Reply-To: <053a1d95-56ec-80da-cebf-51f920e86daa@redhat.com>
Message-ID: <nycvar.YSQ.7.77.849.2006172323260.92950@xnncv>
References: <20200617053934.122642-1-ppandit@redhat.com>
 <20200617063956.GA12597@umbus.fritz.box> <20200617070621.29051d4b@x1.home>
 <8357f8a5-83e3-47a7-57c9-b88edfa3812c@redhat.com>
 <053a1d95-56ec-80da-cebf-51f920e86daa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 boundary="-1463810047-698280064-1592416667=:92950"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
---1463810047-698280064-1592416667=:92950
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

+-- On Wed, 17 Jun 2020, Paolo Bonzini wrote --+
| On 17/06/20 15:20, Philippe Mathieu-Daudé wrote:
| > On 6/17/20 3:06 PM, Alex Williamson wrote:
| >> On Wed, 17 Jun 2020 16:39:56 +1000
| >> David Gibson <david@gibson.dropbear.id.au> wrote:
| >>> Hrm.  If this is such a common problem, maybe we should just add a NULL 
| >>> check in the common paths.
| >>
| >> +1, clearly the behavior is already expected.  Thanks,
| >
| > 20 months ago Peter suggested:
| > 
| > "assert that every MemoryRegionOps has pointers to callbacks
| >  in it, when it is registered in memory_region_init_io() and
| >  memory_region_init_rom_device_nomigrate()."
| > 
| > https://www.mail-archive.com/qemu-devel@nongnu.org/msg573310.html
| > 
| > Li Qiang refers to this post from Paolo:
| > 
| >>  static const MemoryRegionOps notdirty_mem_ops = {
| >> +    .read = notdirty_mem_read,
| >>      .write = notdirty_mem_write,
| >>      .valid.accepts = notdirty_mem_accepts,
| >>      .endianness = DEVICE_NATIVE_ENDIAN,
| > 
| > "This cannot happen, since TLB_NOTDIRTY is only added
| >  to the addr_write member (see accel/tcg/cputlb.c)."
| 
| I'm now okay with asserting it, as long as notdirty_mem_read abort()s.

Okay, I'm preparing a revised patch.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-698280064-1592416667=:92950--



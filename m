Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24DBC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 17:40:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F32D20716
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 17:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eesrp0Vs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F32D20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7j7C-00053O-Rm
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 13:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1k7j6I-0004ZT-Cp
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 13:39:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21624
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1k7j6F-0006fT-Ow
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 13:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597685947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2odN6IEiamiWMKclWwZO2gVz2L4Px7ApPcvK3oklb54=;
 b=eesrp0VsHtbC5C5QCosc2+rRonAKy8UiC+qURCKtQQSjZl9SzZPhe/nMPGj13BkmqhcDyu
 s3bc6TQ5TqxywZr60JVsbpt1tZ2r8UWNUdfelCzbomSjcZgXx7Gk3VH0pBnJtrCPDse75O
 VUqXrW3I8NB/+nuOldQ0i91SYUFDpE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-gJTbOLU4Ona0KrNygzam3w-1; Mon, 17 Aug 2020 13:39:03 -0400
X-MC-Unique: gJTbOLU4Ona0KrNygzam3w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 515405200;
 Mon, 17 Aug 2020 17:39:02 +0000 (UTC)
Received: from kaapi (unknown [10.74.8.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F1995D9D2;
 Mon, 17 Aug 2020 17:38:54 +0000 (UTC)
Date: Mon, 17 Aug 2020 23:08:51 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v4 0/9] memory: assert and define MemoryRegionOps callbacks
In-Reply-To: <1bfaf72e-35ee-fce6-9894-c5346af78742@amsat.org>
Message-ID: <nycvar.YSQ.7.78.906.2008172304280.306228@xnncv>
References: <20200811114133.672647-1-ppandit@redhat.com>
 <c43dbd57-f22f-27f0-d6b3-77734be76631@amsat.org>
 <nycvar.YSQ.7.78.906.2008170954360.306228@xnncv>
 <1bfaf72e-35ee-fce6-9894-c5346af78742@amsat.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 boundary="-1463810047-10410216-1597685941=:306228"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 00:24:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Li Qiang <liq3ea@gmail.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
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
---1463810047-10410216-1597685941=:306228
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

+-- On Mon, 17 Aug 2020, Philippe Mathieu-Daudé wrote --+
| On 8/17/20 7:02 AM, P J P wrote:
| > +-- On Sun, 16 Aug 2020, Philippe Mathieu-Daudé wrote --+
| > | What about read_with_attrs()/write_with_attrs()? It seems they are part 
| > | of the same problem.
| > 
| > * read/write_with_attrs function is called if read/write callback is not 
| >   defined
| > 
| >   ../softmmu/memory.c
| >     if (mr->ops->write) {
| >                     ... memory_region_write_accessor, mr,
| >     } else {
| >                     ... memory_region_write_with_attrs_accessor,
| > 
| >   So, defining read/write methods may also address read/write_with_attrs 
| >   issue?
| > 
| > * $ grep -Eri -A 5 -B 5 '(\.read_with_attrs|\.write_with_attrs)' . | fpaste
| > 
| >    -> https://paste.centos.org/view/386c9597
| > 
| >   It doesn't show an occurrence where one of the read/write_with_attrs is 
| >   missing.
| > 
| > * Nevertheless, if we need to define read/write_with_attrs routines, because 
| >   memory_region_init_io() would assert(3) for them
| > 
| >   could that be a subsequent patch series please?
| 
| Yes no problem, I was just wondering and wasn't sure.


@Peter, @Paolo: (To confirm)
   Do we ping/reach out to respective maintainers for merging this series?


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-10410216-1597685941=:306228--



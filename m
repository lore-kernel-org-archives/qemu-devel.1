Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2EFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0604C207F7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JS83RI5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0604C207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBGiq-0007pv-94
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kBGhu-0006qg-2l
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:08:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50560
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kBGhs-0001ne-As
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598530119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0WlMvbT+0MGAERyzHsg0xQd45Dy4x3t0pMpsJ/BFdh4=;
 b=JS83RI5P4ktjUTAzeN/Ld66OmPqK3/7FJ0KuSonHGpkWVL2wVlSPfa3aGod1sHZiOIGRVY
 WCreHdrhE/VzvheHGzL9YzJhxQQOrFjxtvh3/jQvduT9HY2q4sEZqyttkNgh9uNthEusiI
 StOkeOalYjIBEAX1WbfBG7l64Vc5LGM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-nD0WEnj9OTe9nYJqUXlQ3g-1; Thu, 27 Aug 2020 08:08:33 -0400
X-MC-Unique: nD0WEnj9OTe9nYJqUXlQ3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F98B873016;
 Thu, 27 Aug 2020 12:08:31 +0000 (UTC)
Received: from kaapi (ovpn-112-91.phx2.redhat.com [10.3.112.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3307160FC2;
 Thu, 27 Aug 2020 12:08:24 +0000 (UTC)
Date: Thu, 27 Aug 2020 17:38:22 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v4 0/9] memory: assert and define MemoryRegionOps callbacks
In-Reply-To: <nycvar.YSQ.7.78.906.2008172304280.306228@xnncv>
Message-ID: <nycvar.YSQ.7.78.906.2008271737080.306228@xnncv>
References: <20200811114133.672647-1-ppandit@redhat.com>
 <c43dbd57-f22f-27f0-d6b3-77734be76631@amsat.org>
 <nycvar.YSQ.7.78.906.2008170954360.306228@xnncv>
 <1bfaf72e-35ee-fce6-9894-c5346af78742@amsat.org>
 <nycvar.YSQ.7.78.906.2008172304280.306228@xnncv>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 boundary="-1463810047-1108616725-1598530111=:306228"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Li Qiang <liq3ea@gmail.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
---1463810047-1108616725-1598530111=:306228
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

+-- On Mon, 17 Aug 2020, P J P wrote --+
| +-- On Mon, 17 Aug 2020, Philippe Mathieu-Daudé wrote --+
| | On 8/17/20 7:02 AM, P J P wrote:
| | > +-- On Sun, 16 Aug 2020, Philippe Mathieu-Daudé wrote --+
| | > | What about read_with_attrs()/write_with_attrs()? It seems they are part 
| | > | of the same problem.
| | > 
| | > * read/write_with_attrs function is called if read/write callback is not 
| | >   defined
| | > 
| | >   ../softmmu/memory.c
| | >     if (mr->ops->write) {
| | >                     ... memory_region_write_accessor, mr,
| | >     } else {
| | >                     ... memory_region_write_with_attrs_accessor,
| | > 
| | >   So, defining read/write methods may also address read/write_with_attrs 
| | >   issue?
| | > 
| | > * $ grep -Eri -A 5 -B 5 '(\.read_with_attrs|\.write_with_attrs)' . | fpaste
| | > 
| | >    -> https://paste.centos.org/view/386c9597
| | > 
| | >   It doesn't show an occurrence where one of the read/write_with_attrs is 
| | >   missing.
| | > 
| | > * Nevertheless, if we need to define read/write_with_attrs routines, because 
| | >   memory_region_init_io() would assert(3) for them
| | > 
| | >   could that be a subsequent patch series please?
| | 
| | Yes no problem, I was just wondering and wasn't sure.
| 
| @Peter, @Paolo: (To confirm)
|    Do we ping/reach out to respective maintainers for merging this series?


Ping...!
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-1108616725-1598530111=:306228--



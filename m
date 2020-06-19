Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5B3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 088542078D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7SCoFT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088542078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmEax-00011C-3l
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 06:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jmEa6-0000as-7A
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:49:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20571
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jmEa4-0002T8-JS
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592563747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Vx7y6ZveRd98cdP4HDxNoIEoTnxxQBNXXjuifzTY2Y=;
 b=O7SCoFT8LpS0zNmbWRHaH7r+VNkOOm2Xbw0pVDKqA36FgDHfnheYua+uERLSFQY09rYqbI
 2PJ5ygrC4/HpmB03Y2T8AQbxJtCcYOLOft+LkRhfiUn62ig9AggHMJ5Na29OhhIcKJe4Ef
 jXgFJOWuMXdqrI5lL9+aFTiGnMnfzig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-VcgrLBXkOMCryhixbLZeXw-1; Fri, 19 Jun 2020 06:49:05 -0400
X-MC-Unique: VcgrLBXkOMCryhixbLZeXw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81887107ACCA;
 Fri, 19 Jun 2020 10:49:04 +0000 (UTC)
Received: from kaapi (ovpn-112-26.phx2.redhat.com [10.3.112.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 03078707C6;
 Fri, 19 Jun 2020 10:48:57 +0000 (UTC)
Date: Fri, 19 Jun 2020 16:18:55 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1] memory: assert MemoryRegionOps callbacks are
 defined
In-Reply-To: <51f137f0-89ee-e130-a43e-c82d0b3623fa@redhat.com>
Message-ID: <nycvar.YSQ.7.77.849.2006191022400.92950@xnncv>
References: <20200618121218.215808-1-ppandit@redhat.com>
 <87r1ucv7pe.fsf@linaro.org> <51f137f0-89ee-e130-a43e-c82d0b3623fa@redhat.com>
MIME-Version: 1.0
Content-ID: <nycvar.YSQ.7.77.849.2006191558160.92950@xnncv>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 BOUNDARY="-1463810047-392425560-1592542694=:92950"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:45:39
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
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
---1463810047-392425560-1592542694=:92950
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <nycvar.YSQ.7.77.849.2006191558161.92950@xnncv>

+-- On Thu, 18 Jun 2020, Paolo Bonzini wrote --+
| On 18/06/20 15:12, Alex Bennée wrote:
| > If you look at memory_region_dispatch_write you can see that 
| > mr->ops->write being empty is acceptable because it implies 
| > mr->ops->write_with_attrs is set instead. I think the same is true for 
| > read so I think you need something more like:
| > 
| >      assert(ops->read || ops->read_with_attrs);
| >      assert(ops->write || ops->write_with_attrs);
| 
| Also, !ops is acceptable since you have a couple lines below:
| 
|     mr->ops = ops ? ops : &unassigned_mem_ops;

  Oops! :(
 
| Needless to say, this is something that the submitter should have done,
| not the reviewer.

  Sorry, I should've considered full effects of the patch, not just fixing the 
NULL dereference issue at hand. Sorry about the haste, I'll be careful in 
future.


| > Also doesn't this break a load of running stuff without fixes for all the 
| > various missing bits? How far does make check-acceptance get?

I tried to run '$ make check-acceptance', it's breaking with time-out error.

urllib.error.URLError: <urlopen error [Errno 110] Connection timed out>
urllib.error.URLError: <urlopen error [Errno 110] Connection timed out>
...
make: *** [../qemu/tests/Makefile.include:933: get-vm-image-fedora-31-ppc64le] Error 1


| This might actually be really close with the above assertions fixed.
| For example, commit 08565552f7 ("cputlb: Move NOTDIRTY handling from I/O
| path to TLB path", 2019-09-25) got rid of io_mem_notdirty.
| 
| The only cases I found with "git grep" are:
| 
| - tz_ppc_dummy_ops which is broken and should just use NULL ops
| 
| - hw/nvram/nrf51_nvm.c's flash_ops which is fixed if ROMD regions are
| changed not to require a read callback.
| 
| - designware_pci_host_msi_ops which is broken and should have a dummy
| read callback.


ie. we add these routines along with the assertions here, right?

Earlier patch series adds routines for nrf51_nvm and designware. I'll add 
r/w routines for tz_ppc_dummy_ops.

Thank you so much for the review.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-392425560-1592542694=:92950--



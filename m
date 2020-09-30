Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9458EC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 06:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051AA2074B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 06:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmuDwKA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051AA2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNVG7-0004Ub-V5
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 02:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kNVFO-0003lG-47
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 02:05:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kNVFK-0006VU-W5
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 02:05:49 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601445945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+SiL/tjKWwdaeI7ZJyEWwgz04nvq8BG0z/T6u0w6vtc=;
 b=LmuDwKA+Fq/vrztWCxeDIkqBQuzsvlj91gEuviNBcOodsz51t1oicDiWCij7/I7SuVx8jp
 6PGHcvapsZfO7Mv+ocfYaO9W1i8QR/miLGxror6g51VX899w0p13Rol5yyLwi9Hg4CBon0
 g0seh9jvHVWv8O+ue9bljF8s1QaCPfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-nA7SF7KEMUu7ijCSQMioXQ-1; Wed, 30 Sep 2020 02:05:41 -0400
X-MC-Unique: nA7SF7KEMUu7ijCSQMioXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC6CA64083;
 Wed, 30 Sep 2020 06:05:39 +0000 (UTC)
Received: from kaapi (unknown [10.40.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DDCA5C1CF;
 Wed, 30 Sep 2020 06:05:30 +0000 (UTC)
Date: Wed, 30 Sep 2020 11:35:28 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 9/9] memory: assert MemoryRegionOps callbacks are
 defined
In-Reply-To: <4b55545d-6ab1-59e3-b825-91ccba8f4e17@redhat.com>
Message-ID: <nycvar.YSQ.7.78.906.2009301134350.10832@xnncv>
References: <20200811114133.672647-1-ppandit@redhat.com>
 <20200811114133.672647-10-ppandit@redhat.com>
 <4b55545d-6ab1-59e3-b825-91ccba8f4e17@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 boundary="-1463810047-1801558578-1601445939=:10832"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
---1463810047-1801558578-1601445939=:10832
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

+-- On Wed, 16 Sep 2020, Philippe Mathieu-Daudé wrote --+
| On 8/11/20 1:41 PM, P J P wrote:
| > When registering a MemoryRegionOps object, assert that its
| > read/write callback methods are defined. This avoids potential
| > guest crash via a NULL pointer dereference.
| > 
| > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
| > Reviewed-by: Li Qiang <liq3ea@gmail.com>
| > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
| > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
| 
| Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
| 
| > ---
| >  softmmu/memory.c | 10 +++++++++-
| >  1 file changed, 9 insertions(+), 1 deletion(-)
| > 
| > Update v4: add Reviewed-by tag
| >   -> https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg05324.html
| > 
| > diff --git a/softmmu/memory.c b/softmmu/memory.c
| > index af25987518..1f4b37b3a6 100644
| > --- a/softmmu/memory.c
| > +++ b/softmmu/memory.c
| > @@ -1485,7 +1485,13 @@ void memory_region_init_io(MemoryRegion *mr,
| >                             uint64_t size)
| >  {
| >      memory_region_init(mr, owner, name, size);
| > -    mr->ops = ops ? ops : &unassigned_mem_ops;
| > +    if (ops) {
| > +        assert(ops->read || ops->read_with_attrs);
| > +        assert(ops->write || ops->write_with_attrs);
| > +        mr->ops = ops;
| > +    } else {
| > +        mr->ops = &unassigned_mem_ops;
| > +    }
| >      mr->opaque = opaque;
| >      mr->terminates = true;
| >  }
| > @@ -1663,6 +1669,8 @@ void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
| >  {
| >      Error *err = NULL;
| >      assert(ops);
| > +    assert(ops->read || ops->read_with_attrs);
| > +    assert(ops->write || ops->write_with_attrs);
| >      memory_region_init(mr, owner, name, size);
| >      mr->ops = ops;
| >      mr->opaque = opaque;
| > 

@Paolo...ping!

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-1801558578-1601445939=:10832--



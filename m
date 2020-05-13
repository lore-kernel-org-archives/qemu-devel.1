Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A083C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 19:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95F520659
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 19:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AvJuwuaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95F520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYxB6-00088V-5Q
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 15:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jYx9W-0006om-JF
 for qemu-devel@nongnu.org; Wed, 13 May 2020 15:34:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33292
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jYx9U-0001dI-SL
 for qemu-devel@nongnu.org; Wed, 13 May 2020 15:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589398487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kev0EluC/vB1M89Gqno6mpH6Lo6Lkng/GKwXhpzecDM=;
 b=AvJuwuaqt2SVxiVGoPPj56fVf4ecSwhfWy/ILz2W/KVz7kBl/S0+UYeLLrkk+aZI+M4t8I
 tojcMbsFuOrHT2Ge+w8M+N/xTHl8eLl/rteBYsV4qfZIKTeeRzAjFqgd1P468jW5dosviH
 xncHCB4VCqCi1EUBrITzYFFhyYY/Uno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-pqsC7G97NmGWcBt0p91b8g-1; Wed, 13 May 2020 15:34:45 -0400
X-MC-Unique: pqsC7G97NmGWcBt0p91b8g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9591C19067E5;
 Wed, 13 May 2020 19:34:44 +0000 (UTC)
Received: from kaapi (unknown [10.74.9.109])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5330275286;
 Wed, 13 May 2020 19:34:36 +0000 (UTC)
Date: Thu, 14 May 2020 01:04:33 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: "Ding, Ren" <rding@gatech.edu>, Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH 0/2] use unsigned type for MegasasState fields
In-Reply-To: <1F5C89FF-377C-48F4-B873-B1E88274566B@gatech.edu>
Message-ID: <nycvar.YSQ.7.76.2005140056040.1451610@xnncv>
References: <20200507105718.1319187-1-ppandit@redhat.com>
 <26201c24-c483-85a7-2f4b-b3cc56d4b8b7@redhat.com>
 <nycvar.YSQ.7.76.2005122357030.1451610@xnncv>
 <20200512190803.o6vr2shjmhsplsjx@mozz.bu.edu>
 <20200512194759.nb42yurlnynr5yrw@mozz.bu.edu>
 <nycvar.YSQ.7.76.2005131905010.1451610@xnncv>
 <20200513142043.lfcamp5j43ke5md4@mozz.bu.edu>
 <nycvar.YSQ.7.76.2005132016550.1451610@xnncv>
 <1F5C89FF-377C-48F4-B873-B1E88274566B@gatech.edu>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 boundary="-1463810047-864374864-1589398483=:1451610"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 03:05:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

---1463810047-864374864-1589398483=:1451610
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

  Hello Ren, Alex,

+-- On Wed, 13 May 2020, Ding, Ren wrote --+
| We couldn’t reproduce the bug with the patch provided by our reproducer 
| earlier, though we did not dig into the details of it. Meanwhile, we do also 
| see the null pointer dereference crash with the current upstream 
| (https://bugs.launchpad.net/qemu/+bug/1878259).

* Yes, I was able to reproduce both OOB access and NULL dereference issues 
  with Alex's reproducers.

* I have sent revised patches v2 with you in CC. I've tested the patches, 
  still please kindly confirm if they work for you OR if you see anything 
  amiss.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-864374864-1589398483=:1451610--



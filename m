Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5904C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D32E217D4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D32E217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htXVY-0000ST-Vu
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 09:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49196)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1htXUU-00083B-Kf
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:21:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1htXUS-0001kL-Ul
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:21:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47862)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1htXUS-0001jG-Kx
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:21:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 82C8F882FD
 for <qemu-devel@nongnu.org>; Fri,  2 Aug 2019 13:20:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-51.ams2.redhat.com
 [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5271660BF4;
 Fri,  2 Aug 2019 13:20:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D76131138619; Fri,  2 Aug 2019 15:20:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-25-armbru@redhat.com>
 <487183bd-5437-af05-4a6e-73543570d2c6@redhat.com>
Date: Fri, 02 Aug 2019 15:20:56 +0200
In-Reply-To: <487183bd-5437-af05-4a6e-73543570d2c6@redhat.com> (Paolo
 Bonzini's message of "Fri, 2 Aug 2019 11:53:27 +0200")
Message-ID: <87d0hnitzb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 02 Aug 2019 13:20:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 24/28] Include sysemu/hostmem.h less
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 26/07/19 14:05, Markus Armbruster wrote:
>> Move the HostMemoryBackend typedef from sysemu/hostmem.h to
>> qemu/typedefs.h.  This renders a few inclusions of sysemu/hostmem.h
>> superflouous; drop them.
>
> I think this can also qualify for qemu/typedefs.h, even though this
> patch is also into diminishing returns (sysemu/hostmem.h is only
> included in a dozen files).

Yes, hostmem.h is fairly harmless: ~250 out of 6600 objects in my "build
everything" tree before this patch, 130 after, 110 after the next one.

If I remember correctly, this patch helps making the remaining ones
strict improvements, i.e. counts go only down.

Since you don't seem to mind, I'll keep it.


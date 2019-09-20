Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AA4C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 17:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F019A208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 17:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F019A208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBMiN-0006QS-3Q
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 13:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tasleson@redhat.com>) id 1iBMhi-0005yy-M8
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tasleson@redhat.com>) id 1iBMhh-00048b-KY
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:28:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52664)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tasleson@redhat.com>) id 1iBMhh-000469-EB
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:28:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AC068C058CB8;
 Fri, 20 Sep 2019 17:28:20 +0000 (UTC)
Received: from [10.3.112.12] (ovpn-112-12.phx2.redhat.com [10.3.112.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E07E05D6B0;
 Fri, 20 Sep 2019 17:28:19 +0000 (UTC)
Subject: Re: [RFC 0/4] POC: Generating realistic block errors
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20190919194847.18518-1-tasleson@redhat.com>
 <20190920092226.GH14365@stefanha-x1.localdomain>
From: Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Message-ID: <32a302d7-b85a-991b-4366-2a82e38a9382@redhat.com>
Date: Fri, 20 Sep 2019 12:28:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920092226.GH14365@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 20 Sep 2019 17:28:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Reply-To: tasleson@redhat.com
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/19 4:22 AM, Stefan Hajnoczi wrote:
> blkdebug is purely at the QEMU block layer level.  It is not aware of
> storage controller-specific error information or features.  If you want
> to inject NVMe- or SCSI-specific errors that make no sense in QEMU's
> block layer, then trying to do it in blkdebug becomes a layering
> violation.  This justifies adding a new error injection feature directly
> into AHCI, virtio-scsi, NVMe, etc devices.

Good discussion point...

In my opening use case for this POC I'm generically trying to create an
unrecoverable media error for a specific sector.  For each of the
different device types it's different on how that error is conveyed and
the associated data in transfer.

If we return EIO on a read_aio, that must be translated into transport
specific error right?  I really need to try out blkdebug and see what is
seen in the guest.  Maybe I'm upside down on the layering too :-)

> What I like about blkdebug is the state machine and relatively powerful
> tests that this enables.  It makes sense to reuse those for storage
> controller-specific error injection too.  In the future we may wish to
> reuse it for network cards and other emulated devices too!
> 
> Perhaps the error injection "engine" (the core blkdebug code) can be
> extracted and reused?

I think VMs are a great way to test all different error paths, just not
those specific to storage so if we could make this generic that would be
great.


I also elaborated about this a bit in one of my other responses, but
I'll reiterate here a bit too.  If we could design a suitable callback
interface utilizing qapi I think we could move the state machine/logic
out of QEMU all together.  So that the test code could contain this
logic which would allow all types of behavior that we haven't even
thought of to exist outside of QEMU and not require changes to QEMU to
exploit.

-Tony


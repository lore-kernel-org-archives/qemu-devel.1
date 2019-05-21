Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA313C46460
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 19:20:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857AF217D7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 19:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857AF217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58265 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTAJG-0002QE-Nc
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 15:20:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1hTAH2-0000dW-Te
	for qemu-devel@nongnu.org; Tue, 21 May 2019 15:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1hTAH1-00012y-EM
	for qemu-devel@nongnu.org; Tue, 21 May 2019 15:18:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1hTAH1-00012M-8I
	for qemu-devel@nongnu.org; Tue, 21 May 2019 15:18:07 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 48FBFC05CDFC
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 19:18:01 +0000 (UTC)
Received: from localhost (ovpn-117-77.ams2.redhat.com [10.36.117.77])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BEBF19499;
	Tue, 21 May 2019 19:17:56 +0000 (UTC)
Date: Tue, 21 May 2019 21:17:54 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190521191754.pucxooeeema2hudu@jenstp.localdomain>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190521060725-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190521060725-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Tue, 21 May 2019 19:18:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/4] add failover feature for assigned
 network devices
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
	aadam@redhat.com, qemu-devel@nongnu.org, laine@redhat.com, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 21, 2019 at 06:10:19AM -0400, Michael S. Tsirkin wrote:
>On Fri, May 17, 2019 at 02:58:16PM +0200, Jens Freimann wrote:
>> I'm grateful for any remarks or ideas!
>>
>> Thanks!
>
>Hi Jens!
>Overall I like the patches. Thanks!
>
>Could you please tell us a bit more about other hardware: does this work
>more or less universally across vendors? were any other cards tested?

Thank you, I have tested only Mellanox and XL710 so far but am working
on testing with more nics at the moment. I think there's a few more
things to work out with the patches (especially the unplug before
migration) which should give me a bit more time to test other cards.

Also I haven't yet tested unplug with surprise removal. My understanding
is that device_del was switched from using surprise removal to
attention button etc. a while back. So I'll have to find out first how
to try removing a card with surprise removal in qemu. 

regards,
Jens  


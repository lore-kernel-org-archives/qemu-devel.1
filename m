Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2ECC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:50:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F34208C0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F34208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fsf.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50874 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZJwv-0003UM-Og
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 14:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37522)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <iank@fsf.org>) id 1hZHSE-0002Yp-3Q
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 12:10:59 -0400
Received: from mail.fsf.org ([209.51.188.13]:34092)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <iank@fsf.org>) id 1hZHSE-0002NR-0K
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 12:10:58 -0400
Received: from li.iankelling.org ([72.14.176.105]:58020
 helo=mail.iankelling.org)
 by mail.fsf.org with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.69) (envelope-from <iank@fsf.org>) id 1hZHSD-0000Zo-Ls
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 12:10:57 -0400
Received: from iank by mail.iankelling.org with local (Exim 4.86_2)
 (envelope-from <iank@fsf.org>) id 1hZHSC-0000uB-4E
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 12:10:56 -0400
References: <87v9xiuryy.fsf@fsf.org>
User-agent: mu4e 1.1.0; emacs 27.0.50
From: Ian Kelling <iank@fsf.org>
To: qemu devel list <qemu-devel@nongnu.org>
In-reply-to: <87v9xiuryy.fsf@fsf.org>
Date: Fri, 07 Jun 2019 12:10:56 -0400
Message-ID: <8736kl4bqn.fsf@fsf.org>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by mail.fsf.org: GNU/Linux 2.2.x-3.x [generic]
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
Subject: Re: [Qemu-devel] lists.nongnu.org was upgraded today,
 one issue is still being worked out
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Ian Kelling <iank@fsf.org> writes:

> The server is sending mail using a new ip which is causing a higher than
> average number of mail servers telling us to retry and send later as
> they hopefully decide we are legitimate. The only big provider doing
> this is yahoo, others are small enough that if messages aren't coming as
> normal, you should probably be able to get your email server sysadmin to
> open the pipe. Yahoo has a long history of being unfriendly to mailing
> list messages in various ways, so its not totally unusual. My plan is to
> monitor the situation and if it doesn't improve in the next day or so, I
> will give the new server its old ip and see if that fixes it.

Update: More servers decided they didn't like our new ip, so I switched
it back which seems to have fixed things. The mail queue is slowly going
down as messages are retried based on exim's prescribed waiting periods,
it should take a few hours.

Messages are accessible in the archive of course:
https://lists.nongnu.org/archive/html/qemu-devel/2019-06/threads.html
https://lists.gnu.org/archive/mbox/qemu-devel/

-- 
Ian Kelling | Senior Systems Administrator, Free Software Foundation
GPG Key: B125 F60B 7B28 7FF6 A2B7  DF8F 170A F0E2 9542 95DF
https://fsf.org | https://gnu.org


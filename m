Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5A2C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 08:15:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B2C2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 08:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B2C2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHNfY-000508-1P
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 04:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@proxmox.com>) id 1jHNeu-0004St-Ca
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 04:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dietmar@proxmox.com>) id 1jHNet-000503-AK
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 04:14:36 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:14456)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dietmar@proxmox.com>) id 1jHNet-0004xN-31
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 04:14:35 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 09593428A3;
 Thu, 26 Mar 2020 09:14:24 +0100 (CET)
Date: Thu, 26 Mar 2020 09:14:22 +0100 (CET)
From: Dietmar Maurer <dietmar@proxmox.com>
To: Sergio Lopez <slp@redhat.com>
Message-ID: <914048944.11.1585210462162@webmail.proxmox.com>
In-Reply-To: <20200326074924.r4lmqqpeaizywkds@dritchie>
References: <2007060575.48.1585048408879@webmail.proxmox.com>
 <1512602350.59.1585056617632@webmail.proxmox.com>
 <1806708761.60.1585056799652@webmail.proxmox.com>
 <32c10c76-1c9f-3a6a-4410-09eebad0f6f3@redhat.com>
 <20200325081312.7wtz6crlgotsw5ul@dritchie>
 <20200325114639.rxwhs7h4bkxhkgsu@dritchie>
 <523142611.32.1585139388758@webmail.proxmox.com>
 <20200325123905.4mygg2ljie7prtbc@dritchie>
 <1427176168.41.1585150848553@webmail.proxmox.com>
 <20200326074924.r4lmqqpeaizywkds@dritchie>
Subject: Re: backup transaction with io-thread core dumps
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.2-Rev22
X-Originating-Client: open-xchange-appsuite
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.186.127.180
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
Reply-To: Dietmar Maurer <dietmar@proxmox.com>
Cc: kwolf@redhat.com, "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> > > > So the solution is to disable backups when using io-threads?
> > > >
> > > 
> > > I meant forbidding transactions with completion-mode == grouped. It
> > > would be still possible running transactions (and thus, backups) with
> > > completion-mode == individual, which is the default.
> > 
> > As mentioned earlier, even a totally simple/normal backup job fails when
> > using io-threads and the VM is under load. It results in a total
> > VM freeze!
> > 
> 
> This is definitely a different issue. I'll take a look at it today.

Thanks. Stefan found a way to avoid that bug with:

https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg07749.html

But there are doubts that this is the correct way to fix it ...



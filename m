Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3DAECE58E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3614E206C2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3614E206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHoMC-0007JD-D8
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 08:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iHoL9-0006em-H1
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iHoL8-0008Pd-8y
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:11:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37170)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iHoL8-0008O6-3R
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:11:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 31B9911A24;
 Tue,  8 Oct 2019 12:11:40 +0000 (UTC)
Received: from gondolin (dhcp-192-202.str.redhat.com [10.33.192.202])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2623C5C1D4;
 Tue,  8 Oct 2019 12:11:37 +0000 (UTC)
Date: Tue, 8 Oct 2019 14:11:35 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Bug 1847232 <1847232@bugs.launchpad.net>
Subject: Re: [Bug 1847232] [NEW] qemu TCG in s390x mode issue with
 calculating HASH
Message-ID: <20191008141135.11f5a065.cohuck@redhat.com>
In-Reply-To: <157053356610.22354.6751604707489617887.malonedeb@gac.canonical.com>
References: <157053356610.22354.6751604707489617887.malonedeb@gac.canonical.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 08 Oct 2019 12:11:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Ivan Warren <ivan@vmfacility.fr>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 08 Oct 2019 11:19:25 -0000
Ivan Warren via <qemu-devel@nongnu.org> wrote:

> Public bug reported:
> 
> When using go on s390x on Debian x64 (buster) (host) and debian s390x
> (sid) (guest) I run into the following problem :
> 
> The following occurs while trying to build a custom project :
> 
> go: github.com/FactomProject/basen@v0.0.0-20150613233007-fe3947df716e:
> Get
> https://proxy.golang.org/github.com/%21factom%21project/basen/@v/v0.0.0-20150613233007-fe3947df716e.mod:
> local error: tls: bad record MAC
> 
> Doing a git bisect I find that this problem only occurs on and after
> commit 08ef92d556c584c7faf594ff3af46df456276e1b
> 
> Before that commit, all works fine. Past this commit, build always
> fails.

What version are you using? Current master?

Can you please share your command line?

> 
> Without any proof, It looks like a hash calculation bug related to using
> z/Arch vector facilities...

Not an unreasonable guess, cc:ing David in case he has seen that before.


Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F47C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A167520679
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4NB+Lcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A167520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j477u-0002pv-SZ
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j4773-0001yI-NQ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:56:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j4772-0001o5-PQ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:56:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34735
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j4771-0001n1-Kf
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582048607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HN0+wmv8R3vhHhNC+f7SZPrh40UGZTsLblff16JKBCg=;
 b=O4NB+Lcs1iO8yiTtADMohqaikKxk+UjDNbmEDRVlpmqgxrc08F4WClvnUHdDFsjE8BF2UM
 qVSoBOUnLRo7tsuC2twgIOceD5gy9XVe/lxzlm0zLtTcj1APX/3chRjCCkiHHUTzG4O2Rr
 9xo0cJJZ8UZ4HdYng7YfPYQUwO+CtVI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-F3JeYo5KM5G8zwV65WzVPQ-1; Tue, 18 Feb 2020 12:56:44 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C193107ACC7;
 Tue, 18 Feb 2020 17:56:42 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EDE8A8B561;
 Tue, 18 Feb 2020 17:56:40 +0000 (UTC)
Date: Tue, 18 Feb 2020 18:56:38 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Linux headers updates (was: Re: [PATCH 00/22] linux-user: generate
 syscall_nr.sh)
Message-ID: <20200218185638.7a626b30.cohuck@redhat.com>
In-Reply-To: <CAL1e-=hSSeOi9+sHofSpqPyBU_o2O0GHjBbc91eZRyBGSg==mA@mail.gmail.com>
References: <20200217223558.863199-1-laurent@vivier.eu>
 <20200218152748.63d608af.cohuck@redhat.com>
 <0769c184-dc34-c022-1986-698c6650bac1@vivier.eu>
 <20200218181551.6dff3ec2.cohuck@redhat.com>
 <CAL1e-=hSSeOi9+sHofSpqPyBU_o2O0GHjBbc91eZRyBGSg==mA@mail.gmail.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: F3JeYo5KM5G8zwV65WzVPQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Feb 2020 18:46:54 +0100
Aleksandar Markovic <aleksandar.m.mail@gmail.com> wrote:

> On Tuesday, February 18, 2020, Cornelia Huck <cohuck@redhat.com> wrote:

> > That said, I'll probably queue a headers update on the s390-next branch
> > right now (against current Linus master),  
> 
> 
> >  
> Hi, Cornelia,
> 
> I am not stopping you from updating headers from Linus' master, however, I
> think a better practice would be to do regular updates from each stable
> kernel release (the last one is 5.5), rather than from an arbitrary
> kernel-du-jour, which may be the subject of change (including reverts) wrt
> headers between two stable releases.

I disagree. Not being able to do an update for a whole three months
would block any of the features relying on kernel interfaces for the
same time (or even longer, if the kernel release schedule aligns badly
with QEMU freeze.)

Issues with things being reverted in the Linux headers have been rare
(and the ones I remember were because we did not merge from Linus
master, but from some other tree that changed before being merged). I
don't think it is worth slowing down development because of those rare
issues.



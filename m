Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A256C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:17:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007F12175B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007F12175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38658 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTpT0-0006Fw-6g
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 11:17:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laine@redhat.com>) id 1hTpRF-0005Ge-3r
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laine@redhat.com>) id 1hTpR5-0007er-V4
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:15:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laine@redhat.com>) id 1hTpR2-0007HI-GC
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:15:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9DFD5946F
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 15:14:38 +0000 (UTC)
Received: from vhost2.laine.org (ovpn-116-191.phx2.redhat.com [10.3.116.191])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 422996840B;
	Thu, 23 May 2019 15:14:32 +0000 (UTC)
To: qemu-devel@nongnu.org
References: <20190523145840.11774-1-dgilbert@redhat.com>
From: Laine Stump <laine@redhat.com>
Message-ID: <b2b2e120-e350-da29-929c-8695095a5ab1@redhat.com>
Date: Thu, 23 May 2019 11:14:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523145840.11774-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Thu, 23 May 2019 15:14:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] network announce; interface selection
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
Cc: jasowang@redhat.com, "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>,
	armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 10:58 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Laine asked for some extra features on the network announce support;
> this is the first one of them.
> It allows you to send an announce on a subset of the interfaces.
> 
> Note since we've still only got one timer, if you start one announce
> on an interface and then you start a second announce on another
> interface, the first one gets cancelled even if it's part way through.
> [That's the other feature Laine would like, but I need to think about
> that a bit more.

I have a question without trying to read/understand the code: Does the 
restricted interface list persist to future self-announces? (e.g. one 
that is internally initiated by qemu) Or does it only apply to the 
current new self-announce? (Hopefully the latter)

> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> 
> Dr. David Alan Gilbert (2):
>    net/announce: Allow optional list of interfaces
>    net/announce: Add HMP optional interface list
> 
>   hmp-commands.hx        |  6 ++++--
>   hmp.c                  | 38 +++++++++++++++++++++++++++++++++++++-
>   include/net/announce.h |  2 +-
>   net/announce.c         | 39 ++++++++++++++++++++++++++++++++-------
>   net/trace-events       |  2 +-
>   qapi/net.json          |  8 +++++---
>   6 files changed, 80 insertions(+), 15 deletions(-)
> 



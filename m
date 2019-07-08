Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7659C606C1
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 16:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B119520693
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 16:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B119520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkWsS-000633-0l
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 12:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54021)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hkWrN-0005SW-DM
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 12:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hkWrM-0000xR-IE
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 12:51:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46658)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hkWrK-0000vv-JA; Mon, 08 Jul 2019 12:51:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C5BFD30ADC8E;
 Mon,  8 Jul 2019 16:51:16 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-204.ams2.redhat.com [10.36.116.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A5ECE2B9D1;
 Mon,  8 Jul 2019 16:51:13 +0000 (UTC)
Date: Mon, 8 Jul 2019 18:51:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190708165112.GA14296@linux.fritz.box>
References: <20190705152812.26438-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705152812.26438-1-eblake@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 08 Jul 2019 16:51:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1] qcow2: Allow -o compat=v3 during
 qemu-img amend
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
Cc: qemu-devel@nongnu.org, "open list:qcow2" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 05.07.2019 um 17:28 hat Eric Blake geschrieben:
> Commit b76b4f60 allowed '-o compat=v3' as an alias for the
> less-appealing '-o compat=1.1' for 'qemu-img create' since we want to
> use the QMP form as much as possible, but forgot to do likewise for
> qemu-img amend.  Also, it doesn't help that '-o help' doesn't list our
> new preferred spellings.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

This broke qemu-iotests 082. Please send a follow-up to update the
reference output.

Kevin


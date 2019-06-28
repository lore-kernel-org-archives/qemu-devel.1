Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA55EC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:28:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD232064A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD232064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgso2-0004yD-0z
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 11:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51397)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hgsV8-0006HA-VI
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hgsV7-0000W2-TW
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:09:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41120)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hgsV4-0000Pa-8t; Fri, 28 Jun 2019 11:09:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0502A6EB95;
 Fri, 28 Jun 2019 15:09:14 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A316626E58;
 Fri, 28 Jun 2019 15:09:12 +0000 (UTC)
Date: Fri, 28 Jun 2019 17:09:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Message-ID: <20190628150911.GP5179@dhcp-200-226.str.redhat.com>
References: <20190627135914.xlzohrdwr6mz2aq3@perseus.local>
 <4453cfc4-cff7-c004-1f4c-7cab462e4661@virtuozzo.com>
 <w51a7e3domn.fsf@maestria.local.igalia.com>
 <434b102d-9d8e-ccc2-cb53-7f49a3fbd6fb@virtuozzo.com>
 <w51r27dixcm.fsf@maestria.local.igalia.com>
 <20190628145708.GN5179@dhcp-200-226.str.redhat.com>
 <w51o92hiwi2.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51o92hiwi2.fsf@maestria.local.igalia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 28 Jun 2019 15:09:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] Re-evaluating subcluster allocation for
 qcow2 images
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
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.06.2019 um 17:02 hat Alberto Garcia geschrieben:
> On Fri 28 Jun 2019 04:57:08 PM CEST, Kevin Wolf wrote:
> > Am 28.06.2019 um 16:43 hat Alberto Garcia geschrieben:
> >> On Thu 27 Jun 2019 06:05:55 PM CEST, Denis Lunev wrote:
> >> > Please note, I am not talking now about your case with COW. Here the
> >> > allocation is performed on the sub-cluster basis, i.e. the abscence of
> >> > the sub-cluster in the image means hole on that offset. This is
> >> > important difference.
> >> 
> >> I mentioned the possibility that if you have a case like 2MB / 64KB
> >> and you write to an empty cluster then you could allocate the
> >> necessary subclusters, and additionally fallocate() the space of the
> >> whole cluster (2MB) in order to try to keep it contiguous.
> >> 
> >> With this we would lose the space saving advantage of having
> >> subclusters. But perhaps that would work for smaller cluster sizes
> >> (it would mitigate the fragmentation problem).
> >
> > There seem to be use cases for both ways. So does this need to be an
> > option?
> 
> Probably a runtime option, or a heuristic that decides what to do
> depending on the cluster size.

How would the heuristic decide whether the user wants to save disk space
or whether they consider avoiding fragmentation (i.e. performance) more
important?

Kevin


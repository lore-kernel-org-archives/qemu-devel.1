Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A10C4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 08:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510BE2086A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 08:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510BE2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iErLI-0004t4-C5
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 04:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iErJl-00044M-9Q
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 04:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iErJi-0004wk-Px
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 04:46:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41098)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iErJi-0004nd-J8
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 04:46:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E891418C8914;
 Mon, 30 Sep 2019 08:45:58 +0000 (UTC)
Received: from work-vm (ovpn-117-232.ams2.redhat.com [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A8005D9CA;
 Mon, 30 Sep 2019 08:45:54 +0000 (UTC)
Date: Mon, 30 Sep 2019 09:45:51 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: Arch info lost in "info cpus"
Message-ID: <20190930084551.GB2759@work-vm>
References: <87blv2i5ha.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blv2i5ha.fsf@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Mon, 30 Sep 2019 08:45:58 +0000 (UTC)
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
Cc: imammedo@redhat.com, tao3.xu@intel.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com, mihajlov@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Sergio Lopez (slp@redhat.com) wrote:
> Hi,
> 
> Commit 137b5cb6ab565cb3781d5337591e155932b4230e (hmp: change
> hmp_info_cpus to use query-cpus-fast) updated the "info cpus" commit to
> make it more lightweight, but also removed the ability to get the
> architecture specific status of each vCPU.
> 
> This information was really useful to diagnose certain Guest issues,
> without the need of using GDB, which is more intrusive and requires
> enabling it in advance.
> 
> Is there an alternative way of getting something equivalent to what
> "info cpus" provided previously (in 2.10)?

Even the qemp equivalent, query-cpus is deprecated.
(Although we do call the underlying query-cpus in 'info numa' as well)

Dave

> Thanks,
> Sergio.


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


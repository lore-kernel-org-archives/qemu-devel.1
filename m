Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98141C388F9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 12:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF05D206A4
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 12:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF05D206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=movementarian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbNJ9-0001V4-Tf
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 07:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <movement@li1368-133.members.linode.com>)
 id 1kbNIQ-0000zu-Ec
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 07:26:18 -0500
Received: from ssh.movementarian.org ([2a01:7e00::f03c:92ff:fefb:3ad2]:46142
 helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <movement@li1368-133.members.linode.com>)
 id 1kbNIO-0003Un-I3
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 07:26:18 -0500
Received: from movement by movementarian.org with local (Exim 4.93)
 (envelope-from <movement@li1368-133.members.linode.com>)
 id 1kbNI9-001zzA-Be; Sat, 07 Nov 2020 12:26:01 +0000
Date: Sat, 7 Nov 2020 12:26:01 +0000
From: John Levon <levon@movementarian.org>
To: John G Johnson <john.g.johnson@oracle.com>
Subject: Re: [PATCH v5] introduce vfio-user protocol specification
Message-ID: <20201107122601.GA476582@li1368-133.members.linode.com>
References: <1594984851-59327-1-git-send-email-thanos.makatos@nutanix.com>
 <20201028161005.115810-1-thanos.makatos@nutanix.com>
 <SN1PR02MB3725C85DCD4BF652FF6FBB8D8B170@SN1PR02MB3725.namprd02.prod.outlook.com>
 <20201030170306.GA2544852@li1368-133.members.linode.com>
 <MW2PR02MB3723D387485067C65D31D2328B100@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20201102114126.GA54031@li1368-133.members.linode.com>
 <MW2PR02MB3723F4DDEA3486981AAA9F088B100@MW2PR02MB3723.namprd02.prod.outlook.com>
 <D1778D86-151D-4A67-9E2F-B49061A53FD3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D1778D86-151D-4A67-9E2F-B49061A53FD3@oracle.com>
X-Url: http://www.movementarian.org/
Received-SPF: none client-ip=2a01:7e00::f03c:92ff:fefb:3ad2;
 envelope-from=movement@li1368-133.members.linode.com; helo=movementarian.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 20
X-Spam_score: 2.0
X-Spam_bar: ++
X-Spam_report: (2.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, KHOP_HELO_FCRDNS=0.276,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_FAIL=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: "benjamin.walker@intel.com" <benjamin.walker@intel.com>,
 "tomassetti.andrea@gmail.com" <tomassetti.andrea@gmail.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "james.r.harris@intel.com" <james.r.harris@intel.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "yuvalkashtan@gmail.com" <yuvalkashtan@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "tina.zhang@intel.com" <tina.zhang@intel.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 "ismael@linux.com" <ismael@linux.com>,
 "Kanth.Ghatraju@oracle.com" <Kanth.Ghatraju@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 "xiuchun.lu@intel.com" <xiuchun.lu@intel.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "changpeng.liu@intel.com" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 05, 2020 at 05:50:27PM -0800, John G Johnson wrote:

> 	The idea behind the version IDs is to identify incompatible protocol
> changes as major versions, and compatible changes as minor versions.  What
> would be the purpose of the third version type?

Well, like any patch version, it'd be for identifying versions on the other side
for reporting, debugging purposes. Not imply anything about the protocol
version. But it's not a big deal.

> 	The thing that makes parsing the JSON easier is knowing the version
> beforehand so the parser knows what keys to expect, so I’d like to promote
> major and minor to separate fields in the packet from being embedded at an
> arbitrary points in the JSON string.

I agree that'd be a sensible change (and then I wonder if the little bit of JSON
is actually useful any more).

> >> So can we switch it now so the initial setup is a send/recv too?
> > 
> > I'm fine with that but would first like to hear back from John in case he objects.
> 
> 
> 	I think I write that section, and just switched client and server.  The code
> is written as client proposes, server responds; this is the better model.

Hah, great, thanks.

regards
john


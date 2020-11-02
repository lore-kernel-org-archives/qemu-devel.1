Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3015CC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA3C207C3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA3C207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=movementarian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZYDv-0005Yi-At
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 06:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <movement@li1368-133.members.linode.com>)
 id 1kZYDO-00058D-TR
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:41:34 -0500
Received: from ssh.movementarian.org ([2a01:7e00::f03c:92ff:fefb:3ad2]:52058
 helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <movement@li1368-133.members.linode.com>)
 id 1kZYDM-0005t2-PZ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:41:34 -0500
Received: from movement by movementarian.org with local (Exim 4.93)
 (envelope-from <movement@li1368-133.members.linode.com>)
 id 1kZYDG-000F3U-Ma; Mon, 02 Nov 2020 11:41:26 +0000
Date: Mon, 2 Nov 2020 11:41:26 +0000
From: John Levon <levon@movementarian.org>
To: Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH v5] introduce vfio-user protocol specification
Message-ID: <20201102114126.GA54031@li1368-133.members.linode.com>
References: <1594984851-59327-1-git-send-email-thanos.makatos@nutanix.com>
 <20201028161005.115810-1-thanos.makatos@nutanix.com>
 <SN1PR02MB3725C85DCD4BF652FF6FBB8D8B170@SN1PR02MB3725.namprd02.prod.outlook.com>
 <20201030170306.GA2544852@li1368-133.members.linode.com>
 <MW2PR02MB3723D387485067C65D31D2328B100@MW2PR02MB3723.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR02MB3723D387485067C65D31D2328B100@MW2PR02MB3723.namprd02.prod.outlook.com>
X-Url: http://www.movementarian.org/
Received-SPF: none client-ip=2a01:7e00::f03c:92ff:fefb:3ad2;
 envelope-from=movement@li1368-133.members.linode.com; helo=movementarian.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, KHOP_HELO_FCRDNS=0.399,
 SPF_HELO_FAIL=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "james.r.harris@intel.com" <james.r.harris@intel.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 "yuvalkashtan@gmail.com" <yuvalkashtan@gmail.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "tina.zhang@intel.com" <tina.zhang@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 "ismael@linux.com" <ismael@linux.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 "xiuchun.lu@intel.com" <xiuchun.lu@intel.com>,
 "tomassetti.andrea@gmail.com" <tomassetti.andrea@gmail.com>,
 "changpeng.liu@intel.com" <changpeng.liu@intel.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Kanth.Ghatraju@oracle.com" <Kanth.Ghatraju@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 02, 2020 at 11:29:23AM +0000, Thanos Makatos wrote:

> > +==============+========+=================================
> > ==================+
> > > | version      | object | ``{"major": <number>, "minor": <number>}``        |
> > > |              |        |                                                   |
> > > |              |        | Version supported by the sender, e.g. "0.1".      |
> > 
> > It seems quite unlikely but this should specify it's strings not floating point
> > values maybe?
> > 
> > Definitely applies to max_fds too.
> 
> major and minor are JSON numbers and specifically integers.

It is debatable as to whether there is such a thing as a JSON integer :)

> The rationale behind this is to simplify parsing. Is specifying that
> major/minor/max_fds should be an interger sufficient to clear any vagueness
> here?

I suppose that's OK as long as we never want a 0.1.1 or whatever. I'm not sure
it simplifies parsing, but maybe it does.

> > > Versioning and Feature Support
> > > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > Upon accepting a connection, the server must send a VFIO_USER_VERSION
> > message
> > > proposing a protocol version and a set of capabilities. The client compares
> > > these with the versions and capabilities it supports and sends a
> > > VFIO_USER_VERSION reply according to the following rules.
> > 
> > I'm curious if there was a specific reason it's this way around, when it seems
> > more natural for the client to propose first, and the server to reply?
> 
> I'm not aware of any specific reason.

So can we switch it now so the initial setup is a send/recv too?

thanks
john


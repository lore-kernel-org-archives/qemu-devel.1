Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBDAC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 17:20:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D881247D5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 17:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="JTKO4jEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D881247D5
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXp7y-0002Ww-84
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 13:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kXp6r-0000qd-Tx; Wed, 28 Oct 2020 13:19:41 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:59598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kXp6p-0006Lo-AW; Wed, 28 Oct 2020 13:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1603905579;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Npeg9RZb1Tly7Z0t91E59nEXfv/QG3/W/1wUJKzHhIE=;
 b=JTKO4jEcrO5AKwh+wTfjnB3g3HrjTzz9/4f+SmcIHcD2yI1t7NkLFK6T
 Dxm/UpvwBnKdhaNPx+MHz4IwtoR35D47kcTn9ZWGozNnRnOT+Azh3uZqm
 JfzZMoF+6SNTqlm5T+4+hbCJYWu4G/RdHuj9kFb6xGqpp4BGi9nKmaNSJ E=;
Authentication-Results: esa2.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: iikfO2KoDd/NeTU9BHnPy8TnuxMH8CB0Pvk8lnQMskI0bps4u3MRBem7FcFDB4fa1t+IP5iYMR
 mwt12iQolkNS/K/QMyznQrunRasdA+g9bMIBY2Hs3w1UbQAKHAMfHE3ApVQd8oZ33Y5dU0RTSQ
 mcibb7/JQZ+BJTSs1Kxp5LFGwIsQOMVoVcYjiHje2BS3bWsnnDc4cIXagPTYdgQXqJKoKhHjte
 Kw7xYzmbBOTkWzsiskSwLT+o7sqpPd5WFhgXltylaVxwiE/J8cSoZ0g90UTlh4aIy6MNCUPrhY
 ZDY=
X-SBRS: None
X-MesageID: 29999047
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,427,1596513600"; d="scan'208";a="29999047"
Date: Wed, 28 Oct 2020 17:19:26 +0000
To: John Snow <jsnow@redhat.com>
CC: <qemu-devel@nongnu.org>, Paul Durrant <paul@xen.org>, Stefano Stabellini
 <sstabellini@kernel.org>, <qemu-block@nongnu.org>
Subject: Re: [PATCH v2] xen: rework pci_piix3_xen_ide_unplug
Message-ID: <20201028171926.GF2214@perard.uk.xensource.com>
References: <20201027154058.495112-1-anthony.perard@citrix.com>
 <e7d2fef8-a697-398e-4b3b-bf247aac01a5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e7d2fef8-a697-398e-4b3b-bf247aac01a5@redhat.com>
Received-SPF: pass client-ip=216.71.145.153;
 envelope-from=anthony.perard@citrix.com; helo=esa2.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 13:19:35
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Anthony PERARD <anthony.perard@citrix.com>
From: Anthony PERARD via <qemu-devel@nongnu.org>

On Tue, Oct 27, 2020 at 01:33:32PM -0400, John Snow wrote:
> On 10/27/20 11:40 AM, Anthony PERARD wrote:
> > From: Anthony PERARD <anthony.perard@citrix.com>
> > 
> > This is to allow IDE disks to be unplugged when adding to QEMU via:
> >      -drive file=/root/disk_file,if=none,id=ide-disk0,format=raw
> >      -device ide-hd,drive=ide-disk0,bus=ide.0,unit=0
> > 
> > as the current code only works for disk added with:
> >      -drive file=/root/disk_file,if=ide,index=0,media=disk,format=raw
> > 
> > Since the code already have the IDE controller as `dev`, we don't need
> > to use the legacy DriveInfo to find all the drive we want to unplug.
> > We can simply use `blk` from the controller, as it kind of was already
> > assume to be the same, by setting it to NULL.
> > 
> > Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> 
> Acked-by: John Snow <jsnow@redhat.com>
> 
> Do you need me to send a PR for this?

No, that's fine, I can do the PR since it's all xen code.

Thanks,

-- 
Anthony PERARD


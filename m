Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80CDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D8A12063A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlaUnqiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8A12063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyykZ-0004gD-NP
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 10:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyyjd-0003y9-LO
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:31:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50006
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyyjb-0004Su-Mv
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595601098;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Gc3581YuDgh8Ndx9OFE1UyjwREri5Wk8g+QEsrt8vuY=;
 b=MlaUnqiUNOpIXD22x7/EdU1vmqCr3Esyk3EScMhmYoSUodXiidihoVY78ZnvoJn2k9dIvn
 he8Ga6hhPqBiCuy+8xrDI7gyWJWL5Aj5eT+KusRXa9tBjOjpWH6eFiyLUQDcxeYNxsL/GG
 2Iab+GlR4Lj1orIL4GWZzBSVBMGZLUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-sirau-jSP1SLSWhsoFvEoQ-1; Fri, 24 Jul 2020 10:31:33 -0400
X-MC-Unique: sirau-jSP1SLSWhsoFvEoQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0044D107ACCA;
 Fri, 24 Jul 2020 14:31:32 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCFBD6932B;
 Fri, 24 Jul 2020 14:31:26 +0000 (UTC)
Date: Fri, 24 Jul 2020 15:31:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Possible regression with VGA and resolutions in Windows 10?
Message-ID: <20200724143123.GF3146350@redhat.com>
References: <24909a16-be74-7516-b5c5-08bdc743a553@proxmox.com>
 <20200724094120.dptmucij4phzd3od@sirius.home.kraxel.org>
 <1ee13b41-3ed7-8dd4-99b7-e325e95878d5@proxmox.com>
 <20200724141032.jmub3zixekeyy3x3@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20200724141032.jmub3zixekeyy3x3@sirius.home.kraxel.org>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:00:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Aaron Lauterer <a.lauterer@proxmox.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 24, 2020 at 04:10:32PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > The behavior is similar when setting a custom resolution with the xres
> > and yres parameters. Setting it the first time works fine and it is
> > shown along with the short list. Setting it to something different on
> > the next boot will not be recognized unless the display adapter is
> > uninstalled and the VM rebooted.
> 
> Interesting.  Seems Windows caches the list of resolutions (or the edid
> blob) somewhere in the registry instead of loading it on every boot.
> I've seen simliar behavior with usb device info.
> 
> [ something for the 5.1 release notes I think, thanks for testing this ]

Do we need to be disabling edid in the old machine types to prevent this
change in guest ABI due to the changed BIOS ?

eg existing VMs using a versioned machine type shouldn't suddenly get edid
enabled where previously it was not present. Only VMs using the new 5.1 or
unversioned machine types should see the change in behaviour.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



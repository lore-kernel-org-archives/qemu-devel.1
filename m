Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF8AC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 11:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6EF821789
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 11:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYcKvwKo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6EF821789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaIOj-0005jJ-Tf
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 06:55:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53689)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iaI0V-00047z-Ot
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:30:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iaI0Q-0001rS-Tw
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:30:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46341
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iaI0P-0001nL-GN
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:30:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574940637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kfo2fE9iiEDRp7+mq/qNcsEdSe0jZED3P9/5jUO5Y/A=;
 b=CYcKvwKomU1KYFGaR6BUFeTTAJZM4xJ+/rJxztPr1ZA9Ymu0fO8EVIFm4DRAtgTKsxVgBP
 9sy5zD9l49bUS8R9bijzzqSbR1lUDrcGq6AN/KfVFqt/0Pjs4qR+maCUiZZBswqxIsDqnK
 7XFygLAOTW5TZ50GYadHOM9X/pYsLio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-xRJ1FGEEPwa68Y-lwoZ_FQ-1; Thu, 28 Nov 2019 06:30:25 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96953911E8;
 Thu, 28 Nov 2019 11:30:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com
 [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54DE35D6C8;
 Thu, 28 Nov 2019 11:30:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8B905A1E0; Thu, 28 Nov 2019 12:30:23 +0100 (CET)
Date: Thu, 28 Nov 2019 12:30:23 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: aaron.zakhrov@gmail.com
Subject: Re: [RFC 0/1] ATI R300 emulated grpahics card V2
Message-ID: <20191128113023.gdw63adoooqlider@sirius.home.kraxel.org>
References: <20191128064350.20727-1-aaron.zakhrov@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191128064350.20727-1-aaron.zakhrov@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: xRJ1FGEEPwa68Y-lwoZ_FQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 28, 2019 at 12:13:49PM +0530, aaron.zakhrov@gmail.com wrote:
> From: Aaron Dominick <aaron.zakhrov@gmail.com>
>=20
> This is the cleaned up patchset to my previous RFC patch set.
> I could not reliably clean up my previous commits so I deleted my fork an=
d started from scratch.
> The patch looks like a lot of changes but most of it is just register def=
initions copied from the kernel radeon DRM tree.

Adding headers should be a separate patch.

Qemu has some infrastructure to sync files with the linux kernel tree
(see scripts/update-linux-headers.sh).  It's intended for uapi include
files though, so it might not work for you.  Also the register specs are
not going to change, so future updates are unlikely, so doing a one-time
manual copy wouldn't be too bad maintenance-wise.

The code should probably be integrated with the existing ati-vga instead
of just copying the code, i.e. it'll be "-device ati-vga,model=3Dr300".
As far I know crtc programming doesn't change much across models, so
there should be a good chunk of shareable code.

The infrastructure to branch into model-specific code is pretty rough
right now, we might refine that, for example with some helper functions
(ati_get_model() returning an enum, or ati_is_$model() functions
returning bool, or both).

Patches usually should pass scripts/checkpatch.pl codestyle checking.
We can make exceptions when reasonable (headers copied from elsewhere
for example).

> What I have implemented so far seems to get a Linux guest to load the
> DRM and KMS drivers but it cannot find any CRTCs.

Might be the vgabios tables are lacking information,
see https://git.seabios.org/cgit/seabios.git/tree/vgasrc/ati-tables.S

Might be i2c emulation needs tweaks (so EDID fetch works).

Trouble-shooting linux guests shouldn't be too hard, you have the source
code so you can check what the driver tries to do and you can add debug
printk's to trace where exactly things are failing ;)

HTH,
  Gerd



Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EB1C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7799F20C09
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMbRABbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7799F20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGPdw-00041o-Jg
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 12:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGPcT-0002kV-6Z
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:40:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40117
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGPcR-00028t-5d
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599756018;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vEZhC8icudMXBaphx1/uzZwMhVlrPxsvLkUdIK3gbtA=;
 b=NMbRABbMT4lazj4u9nO41PZViBorr3QEFqgUeI/7aS0TV223VFKD8BxAovEXTyf3nnfJjK
 xKcY1Tdh4af7BebuQKBxQ/wXCmMZaNUr01mdGGyo1G9XkT1yVWqWKby4zYzyLHGgQc9kqj
 dxX4gU46ScMNGDwE6QgBxV4ldJlxvfw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-d244PSCVPUGdQZSk2L1DIA-1; Thu, 10 Sep 2020 12:40:12 -0400
X-MC-Unique: d244PSCVPUGdQZSk2L1DIA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 855B218B9EDC;
 Thu, 10 Sep 2020 16:40:11 +0000 (UTC)
Received: from redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 90FD45C221;
 Thu, 10 Sep 2020 16:40:06 +0000 (UTC)
Date: Thu, 10 Sep 2020 17:40:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 08/10] pc-bios: refresh edk2 build artifacts for
 edk2-stable202008
Message-ID: <20200910164003.GH1083348@redhat.com>
References: <20200908072939.30178-1-lersek@redhat.com>
 <20200908072939.30178-9-lersek@redhat.com>
 <b2037644-bf48-e86f-23e3-f2c68e7ddc1f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b2037644-bf48-e86f-23e3-f2c68e7ddc1f@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:38:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 10, 2020 at 06:32:28PM +0200, Philippe Mathieu-Daudé wrote:
> +GitLab team & Gerd (for building firmwares)
> 
> On 9/8/20 9:29 AM, Laszlo Ersek wrote:

> Now I remember why I kept that patch on hold.
> 
> The CI idea is to have reproducible builds if possible.

NB it isn't going to eb truly reproducible because the docker
env we're building in is liable to change each time we run it,
either because we've updated the base OS, or "apt update" pulls
in different content set. At the least, we should likely record
the full set of packages installed in the container, alongside
the blob in qemu.git, so we have a strong record of the toolchain
used.

> When the submodule is updated (or the QEMU scripts containing the
> -D defines), it triggers the 'build-edk2' job which produce these
> same binaries.
> My original idea was to push the tag on GitLab that triggers the
> job, then download the produced binaries, test them, then commit
> them.
> 
> With your series, I get these binaries:
> https://gitlab.com/philmd/qemu/-/jobs/731618363/artifacts/browse/pc-bios/
> 
> However they differ with yours, for example:
> 
> 0000 6100: 00 00 00 00 00 00 00 00  00 00 00 00 2F 68 6F 6D  ........
> ..../hom
> 0000 6110: 65 2F 6C 61 63 6F 73 2F  73 72 63 2F 75 70 73 74  e/lacos/
> src/upst
> 0000 6120: 72 65 61 6D 2F 71 65 6D  75 2F 72 6F 6D 73 2F 65  ream/qem
> u/roms/e
> 0000 6130: 64 6B 32 2F 42 75 69 6C  64 2F 41 72 6D 56 69 72  dk2/Buil
> d/ArmVir
> 0000 6140: 74 51 65 6D 75 2D 41 41  52 43 48 36 34 2F 44 45  tQemu-AA
> RCH64/DE
> 0000 6150: 42 55 47 5F 47 43 43 35  2F 41 41 52 43 48 36 34  BUG_GCC5
> /AARCH64
> 0000 6160: 2F 41 72 6D 50 6C 61 74  66 6F 72 6D 50 6B 67 2F  /ArmPlat
> formPkg/
> 0000 6170: 50 72 65 50 65 69 43 6F  72 65 2F 50 72 65 50 65  PrePeiCo
> re/PrePe
> 0000 6180: 69 43 6F 72 65 55 6E 69  43 6F 72 65 2F 44 45 42  iCoreUni
> Core/DEB
> 0000 6190: 55 47 2F 41 72 6D 50 6C  61 74 66 6F 72 6D 50 72  UG/ArmPl
> atformPr
> 0000 61A0: 65 50 65 69 43 6F 72 65  2E 64 6C 6C 00 00 00 00  ePeiCore
> .dll....
> 
> 0000 6100: 00 00 00 00 00 00 00 00  00 00 00 00 2F 62 75 69  ........
> ..../bui
> 0000 6110: 6C 64 73 2F 70 68 69 6C  6D 64 2F 71 65 6D 75 2F  lds/phil
> md/qemu/
> 0000 6120: 72 6F 6D 73 2F 65 64 6B  32 2F 42 75 69 6C 64 2F  roms/edk
> 2/Build/
> 0000 6130: 41 72 6D 56 69 72 74 51  65 6D 75 2D 41 41 52 43  ArmVirtQ
> emu-AARC
> 0000 6140: 48 36 34 2F 44 45 42 55  47 5F 47 43 43 35 2F 41  H64/DEBU
> G_GCC5/A
> 0000 6150: 41 52 43 48 36 34 2F 41  72 6D 50 6C 61 74 66 6F  ARCH64/A
> rmPlatfo
> 0000 6160: 72 6D 50 6B 67 2F 50 72  65 50 65 69 43 6F 72 65  rmPkg/Pr
> ePeiCore
> 0000 6170: 2F 50 72 65 50 65 69 43  6F 72 65 55 6E 69 43 6F  /PrePeiC
> oreUniCo
> 0000 6180: 72 65 2F 44 45 42 55 47  2F 41 72 6D 50 6C 61 74  re/DEBUG
> /ArmPlat
> 0000 6190: 66 6F 72 6D 50 72 65 50  65 69 43 6F 72 65 2E 64  formPreP
> eiCore.d
> 0000 61A0: 6C 6C 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ll......
> ........
> 
> For now this is not a blocker, but we should consider switching to
> this workflow at some point (caring about all the files that really
> need to be archived, maybe debug symbols etc...).
> 
> w.r.t. your patch:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Regards,
> 
> Phil.
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



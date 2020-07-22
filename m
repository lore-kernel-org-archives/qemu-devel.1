Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0174C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A294A20729
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUVc7WMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A294A20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyDno-0005Au-VZ
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 08:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyDn7-0004kQ-75
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:24:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27244
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyDn5-0000J0-BW
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595420646;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=R7x4Ww9MA0eMek6LSgt0j2+VaNYNO2tGfasYmyqjdYI=;
 b=gUVc7WMb7cFmtdxz06slhiaUcL7GbzsdFt3vCbqZR6Bh/e96E76DzL8BSIB+KhBQBSCPmI
 nYptMks8c8kvUPtruM0HMi3fbLwmgdcALGzwzKm3ZJkWCmM24/hdBONiBBtDNyWY+HlZ5W
 I234zbWwVqEjIQo5UJ3C/8UR7TnMrNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-1N75UC-IPrScS476j4P0rA-1; Wed, 22 Jul 2020 08:23:56 -0400
X-MC-Unique: 1N75UC-IPrScS476j4P0rA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC27B8014D4;
 Wed, 22 Jul 2020 12:23:55 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D903C2B5BF;
 Wed, 22 Jul 2020 12:23:50 +0000 (UTC)
Date: Wed, 22 Jul 2020 13:23:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: https booting
Message-ID: <20200722122347.GF2324845@redhat.com>
References: <20200722120827.dq72uabrk26nllra@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20200722120827.dq72uabrk26nllra@sirius.home.kraxel.org>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 21:28:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: ipxe-devel@lists.ipxe.org,
 =?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>, qemu-devel@nongnu.org,
 crobinso@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 22, 2020 at 02:08:27PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> With the world moving to use https by default people start to ask for
> https being enabled by default for the qemu boot roms.
> 
> We could simply flip the DOWNLOAD_PROTO_HTTPS switch in
> src/config/qemu/general.h (ipxe git repo).  Note that this would only
> affect booting in bios mode, for uefi qemu uses the efidrv builds which
> implies https support is in the hands of the uefi firmware (edk2/ovmf).
> 
> After looking at https://ipxe.org/cfg/crosscert I'm not convinced this
> is a good idea though.  This would likely put quite some load to
> ca.ipxe.org.  Also that machine becomes a single point of failure for
> worldwide ipxe https boot, and looking through the mailing list I've
> seen we already had (at least) two outages this year.
> 
> What happens if you sent crosscert to the empty string?
> Will ipxe fail or will it boot without cert verification?
> 
> What does it take to mirror http://ca.ipxe.org/auto/?
> Just "wget -r" everything and serve it?
> 
> How does edk2 handle the root ca problem?

There are two fw_cfg paths

  - etc/edk2/https/ciphers
  - etc/edk2/https/cacerts

The first sets the cipher algorithms that are permitted and their
priority, the second sets the CA certificate bundle.

There's some recently merged code in QEMU to simplify the setup
of the ciphers data via the "tls-cipher-suites" object, but
ultimately libvirt is responsible for passing suitable -fw_cfg
args to QEMU to populate both.

I'd suggest that iPXE needs to support the equivalent kind of
concept, both CA certs, and the cipher priority.

The rationale is that the OS vendor defines CA certs and cipher
priority for the host OS, with optional local administrator
override. Any firmware QEMU runs needs to honour the host OS
settings in this area, so we should have a mechanism for pass
in the relevant data from the host for iPXE IMHO.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59325C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 16:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E9B520657
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 16:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9B520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs8S1-0001B9-FM
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 12:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58510)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hs8Rc-0000iX-0X
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hs8Ra-0001gC-Tp
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:24:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hs8Ra-0001fg-OB
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:24:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 153C1A76C
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 16:24:14 +0000 (UTC)
Received: from work-vm (ovpn-117-222.ams2.redhat.com [10.36.117.222])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 959A45D704;
 Mon, 29 Jul 2019 16:24:08 +0000 (UTC)
Date: Mon, 29 Jul 2019 17:24:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190729162406.GI2756@work-vm>
References: <20190729155909.22804-1-dgilbert@redhat.com>
 <20190729160314.GS32718@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190729160314.GS32718@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 29 Jul 2019 16:24:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [for 4.1 PATCH] Revert "hw: report invalid
 disable-legacy|modern usage for virtio-1-only devs"
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
Cc: cohuck@redhat.com, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Mon, Jul 29, 2019 at 04:59:09PM +0100, Dr. David Alan Gilbert (git) =
wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > This reverts commit f2784eed306449c3d04a71a05ed6463b8289aedf
> > since that accidentally removes the PCIe capabilities from virtio
> > devices because virtio_pci_dc_realize is called before the new 'mode'
> > flag is set.
> > I keep the expanded hw_compat entry because we've lost the ability to
> > do 'optional'.
>=20
> That was the commit immediately following. If you revert
> 8fa70dbd8bb478d9483c1da3e9976a2d86b3f9a0 first, then this
> one would likely revert cleanly.

OK, double revert coming up.

Dave

>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


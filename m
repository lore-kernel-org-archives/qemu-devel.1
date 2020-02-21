Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A6DC35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 12:04:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216E124656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 12:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gfCYnRzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216E124656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j572d-0000Wa-C9
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 07:04:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j571t-0008Hs-6j
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 07:03:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j571s-0004P7-7R
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 07:03:37 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41721
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j571s-0004OO-3d
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 07:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582286615;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cxipq/1hL6aCzIrHprqnU+mgo/ZpntAfk0ptcHjttoY=;
 b=gfCYnRzBoHvw3mV7MhrtnMWX1WRtrrEOq1HSltZTRCuWmlg7GZCnhIjDoMvj8WIkKY/fNI
 QpxYCUoZLKOdCDpbiXbKAveav2dM1xgwvtc0bNqrvO58HeKepmC1pWqWyk27RcVzfPOwYY
 KMyfufiTv4VsM0/6Xw3vC+2DXhNPzWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-IfaQ-Ma0NJmn52rY9AFIpg-1; Fri, 21 Feb 2020 07:03:28 -0500
X-MC-Unique: IfaQ-Ma0NJmn52rY9AFIpg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9993B94D85
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 12:03:27 +0000 (UTC)
Received: from redhat.com (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B7A86E3EE;
 Fri, 21 Feb 2020 12:03:17 +0000 (UTC)
Date: Fri, 21 Feb 2020 12:03:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laine Stump <laine@redhat.com>
Subject: Re: [PATCH] pcie_root_port: Add disable_hotplug option
Message-ID: <20200221120315.GB628613@redhat.com>
References: <20200218161717.386723-1-jusual@redhat.com>
 <d872dcc7-9275-1354-ce6a-7dd52ac33929@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d872dcc7-9275-1354-ce6a-7dd52ac33929@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 18, 2020 at 12:18:04PM -0500, Laine Stump wrote:
> On 2/18/20 11:17 AM, Julia Suvorova wrote:
> > Make hot-plug/hot-unplug on PCIe Root Ports optional to allow libvirt
> > to manage it and restrict unplug for the entire machine. This is going
> > to prevent user-initiated unplug in guests (Windows mostly).
> > Usage:
> >      -device pcie-root-port,disable-hotplug=3Dtrue,...
>=20
> Double negatives (e.g. "disable-hotplug=3Dfalse") tend to confuse simple =
minds
> like mine. Would it be any more difficult to make the name of the option
> positive instead (e.g. "enable-hotplug") with the default set to "true"?

Or simply  "hotpluggable=3Don|off"


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|



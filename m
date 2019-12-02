Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC07C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53EF620718
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1gmFH5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EF620718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibipt-0004W2-9A
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 05:21:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ibioD-00036S-OO
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:20:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ibioC-0002UT-Ip
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:20:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47803
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ibioC-0002Sx-E6
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575281999;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tlaipvYQs1aka4YaUnAxL/VGEfgmMitZKRRdrRlwtmo=;
 b=M1gmFH5Hy0nbnuqGWYIFZnj6UnTOYZkYYqfjjs2wIhQlYUdH6vwmSphdYIhOiREqwAmlnn
 c10yfJEp+k14SfSa+8tglBEgU1uwFgPb7oSBRvR37N+tplVlVid4b4wuGTVYFzT8vhRfDl
 ZeRIFekpvt/fxrL2GsBQ1CWXB5wwS48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-gnrX6VgcMXyuj_CRZkMQvg-1; Mon, 02 Dec 2019 05:19:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0987A800D4C;
 Mon,  2 Dec 2019 10:19:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D1AE5D9E5;
 Mon,  2 Dec 2019 10:19:39 +0000 (UTC)
Date: Mon, 2 Dec 2019 10:19:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 00/21] Error handling fixes, may contain 4.2 material
Message-ID: <20191202101937.GB4184266@redhat.com>
References: <20191130194240.10517-1-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191130194240.10517-1-armbru@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: gnrX6VgcMXyuj_CRZkMQvg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 vsementsov@virtuozzo.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Nishanth Aravamudan <naravamudan@digitalocean.com>,
 Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Nov 30, 2019 at 08:42:19PM +0100, Markus Armbruster wrote:
> PATCH 2-4 fix crash bugs.  Including them would be a no-brainer at
> -rc0.  But we're post -rc3, and even for crash bugs we require a
> certain likelihood of users getting bitten.
>=20
> Jens, please assess impact of PATCH 2's crash bug.
>=20
> Kevin, please do the same for PATCH 3.
>=20
> Daniel, please do the same for PATCH 4.


The code has existed like this since 2.5.0, and its not a security
issue, so I can't see any justification for putting it into 4.2
at the last minute.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|



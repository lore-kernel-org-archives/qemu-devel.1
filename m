Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737D0C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 17:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A1B20866
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 17:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aU0XIKnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A1B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inQPX-0007gp-Ag
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 12:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1inQKB-0002Tx-4n
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 12:01:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1inQK9-0005u1-L1
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 12:01:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43710
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1inQK9-0005r5-E0
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 12:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578070880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TEA1+FifX10N0zD3ogZpUDyFkg7B+HLkuUQbWjjPE+Q=;
 b=aU0XIKnkUSScRZyQWYViEGEgXU9g3XsLHtA9oAbfu0AOiRgWR7Ce2Mb/FLXTY5PhZJgx8u
 ojXk1fkD2y8EwjqS8QglGChc6l7kepnzK21KIYm0waq6mQNhD2r6/dX9g343hYXhmHzfGy
 ZYaoT4zWmUeXiLbXvoUVEcK0QdhCqbA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-1uvCcUn_NeKz4y_3ICPCjw-1; Fri, 03 Jan 2020 12:01:19 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1457477
 for <qemu-devel@nongnu.org>; Fri,  3 Jan 2020 17:01:18 +0000 (UTC)
Received: from work-vm (ovpn-117-78.ams2.redhat.com [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD7086609E;
 Fri,  3 Jan 2020 17:01:16 +0000 (UTC)
Date: Fri, 3 Jan 2020 17:01:14 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 01/10] migration: Increase default number of multifd
 channels to 16
Message-ID: <20200103170114.GO3804@work-vm>
References: <20191218020119.3776-1-quintela@redhat.com>
 <20191218020119.3776-2-quintela@redhat.com>
 <20200103165832.GU2753983@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200103165832.GU2753983@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 1uvCcUn_NeKz4y_3ICPCjw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Wed, Dec 18, 2019 at 03:01:10AM +0100, Juan Quintela wrote:
> > We can scale much better with 16, so we can scale to higher numbers.
>=20
> What was the test scenario showing such scaling ?
>=20
> In the real world I'm sceptical that virt hosts will have
> 16 otherwise idle CPU cores available that are permissible
> to use for migration, or indeed whether they'll have network
> bandwidth available to allow 16 cores to saturate the link.

With TLS or compression, the network bandwidth could easily be there.

Dave

>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



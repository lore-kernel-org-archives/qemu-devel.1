Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1813EC35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57242168B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egKrhI4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57242168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ak9-00067e-4D
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 13:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j1aj8-0005Hg-CR
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:57:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j1aj5-0006yC-PF
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:57:41 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35829
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j1aj5-0006ue-D3
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581447458;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bzurVOrsVu08Xn65eKTOSc6rt1lI2cwbt5ZWDDa6Zu4=;
 b=egKrhI4IUdPLGDOsJ7Hx5f8l/mgyRss+MrDwgFsbbJ0BvrZLHPhDO3CH/1kBpgPNIsTrZB
 OHNtIjDvi7K1C91Xm3h4MaB42jTjt4s2s37ihCVyWwYlCHvJV21SdpcWZZkPWKklTAgn02
 nSf1HB7kx2v0wxZHwFWC5YQylTeBboA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-wa2X5h2qORK2XsvmujfzIQ-1; Tue, 11 Feb 2020 13:57:35 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43111DB62
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 18:57:34 +0000 (UTC)
Received: from redhat.com (ovpn-112-49.ams2.redhat.com [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D79E81001E91;
 Tue, 11 Feb 2020 18:57:31 +0000 (UTC)
Date: Tue, 11 Feb 2020 18:57:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 4/8] multifd: Add multifd-zlib-level parameter
Message-ID: <20200211185728.GQ55376@redhat.com>
References: <20200129115655.10414-1-quintela@redhat.com>
 <20200129115655.10414-5-quintela@redhat.com>
 <87eevhxtfv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87eevhxtfv.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: wa2X5h2qORK2XsvmujfzIQ-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 30, 2020 at 09:03:00AM +0100, Markus Armbruster wrote:
> Juan Quintela <quintela@redhat.com> writes:
>=20
> > It will indicate which level use for compression.
> >
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
>=20
> This is slightly confusing (there is no zlib compression), unless you
> peek at the next patch (which adds zlib compression).
>=20
> Three ways to make it less confusing:
>=20
> * Squash the two commits
>=20
> * Swap them: first add zlib compression with level hardcoded to 1, then
>   make the level configurable.
>=20
> * Have the first commit explain itself better.  Something like
>=20
>     multifd: Add multifd-zlib-level parameter
>=20
>     This parameter specifies zlib compression level.  The next patch
>     will put it to use.

Wouldn't the "normal" best practice for QAPI design be to use a
enum and discriminated union. eg

  { 'enum': 'MigrationCompression',
     'data': ['none', 'zlib'] }

  { 'struct': 'MigrationCompressionParamsZLib',
    'data': { 'compression-level' } }

  { 'union':  'MigrationCompressionParams',
    'base': { 'mode': 'MigrationCompression' },
    'discriminator': 'mode',
    'data': {
      'zlib': 'MigrationCompressionParamsZLib',
    }

Of course this is quite different from how migration parameters are
done today. Maybe it makes sense to stick with the flat list of
migration parameters for consistency & ignore normal QAPI design
practice ?


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|



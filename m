Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2B2C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 761F8207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxkjn1eC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761F8207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioooV-0002Cm-F0
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:22:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iooIr-0000xW-DQ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:49:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iooIp-0005rs-Po
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:49:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55178
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iooIp-0005rQ-M3
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578401383;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ddkwZHIwvsKmyCpSkC4mGiKhT+5QLXENIZJE+XzURNY=;
 b=fxkjn1eCGEL+x592wHDUJyW0qDG4jwG8ttYaqhc+D60MXug4FVGefeynTEQI+ZtPySA6Rn
 gOByh8UbtLo2NPaDieE2NPvub05hlQ+vLlkN81Jr8EWuQ3ONYJIr8M+x5xhe8WovKUbVG5
 dohIcRkegKWpzwbCGDx/XbV68uFHpaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-8A7GgNgmOquVlgKx2olTfQ-1; Tue, 07 Jan 2020 07:49:41 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53244802C96
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 12:49:40 +0000 (UTC)
Received: from redhat.com (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 364731036D1B;
 Tue,  7 Jan 2020 12:49:37 +0000 (UTC)
Date: Tue, 7 Jan 2020 12:49:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v2 01/10] migration: Increase default number of multifd
 channels to 16
Message-ID: <20200107124934.GK3368802@redhat.com>
References: <20191218020119.3776-1-quintela@redhat.com>
 <20191218020119.3776-2-quintela@redhat.com>
 <20200103165832.GU2753983@redhat.com> <87mub4xurf.fsf@trasno.org>
MIME-Version: 1.0
In-Reply-To: <87mub4xurf.fsf@trasno.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 8A7GgNgmOquVlgKx2olTfQ-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 03, 2020 at 07:25:08PM +0100, Juan Quintela wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > On Wed, Dec 18, 2019 at 03:01:10AM +0100, Juan Quintela wrote:
> >> We can scale much better with 16, so we can scale to higher numbers.
> >
> > What was the test scenario showing such scaling ?
>=20
> On my test hardware, with 2 channels we can saturate around 8Gigabit max,
> more than that, and the migration thread is not fast enough to fill the
> network bandwidth.
>=20
> With 8 that is enough to fill whatever we can find.
> We used to have a bug where we were getting trouble with more channels
> than cores.  That was the initial reason why the default was so low.
>=20
> So, pros/cons are:
> - have low value (2).  We are backwards compatible, but we are not using
>   all  bandwith.  Notice that we will dectect the error before 5.0 is
>   out and print a good error message.
>=20
> - have high value (I tested 8 and 16).  Found no performance loss when
>   moving to lower bandwidth limits, and clearly we were able to saturate
>   the higher speeds (I tested on localhost, so I had big enough bandwidth=
)
>=20
>=20
> > In the real world I'm sceptical that virt hosts will have
> > 16 otherwise idle CPU cores available that are permissible
> > to use for migration, or indeed whether they'll have network
> > bandwidth available to allow 16 cores to saturate the link.
>=20
> The problem here is that if you have such a host, and you want to have
> high speed migration, you need to configure it.  My measumermets are
> that high number of channels don't affect performance with low
> bandwidth, but low number of channels affect performance with high
> bandwidth speed.

I'm not concerned about impact on performance of migration on a
low bandwidth link, rather I'm concerned about impact on performance
of other guests on the host. It will cause migration to contend with
other guest's vCPUs and network traffic.=20

> So, if we want to have something that works "automatically" everywhere,
> we need to put it to at least 8.  Or we can trust that management app
> will do the right thing.

Aren't we still setting the bandwidth limit to MB bandwidth out of the
box, so we already require mgmt app to change settings to use more
bandwidth ?=20

> If you are using a low value of bandwidth, the only difference with 16
> channels is that you are using a bit more memory (just the space for the
> stacks) and that you are having less contention for the locks (but with
> low bandwidth you are not having contention anyways).
>=20
> So,  I think that the question is:
> - What does libvirt prefferes

Libvirt doesn't really have an opinion in this case. I believe we'll
always set the number of channels on both src & dst, so we don't
see the defaults.

> - What does ovirt/openstack preffer

Libvirt should insulate them from any change in defaults in QEMU
in this case, but always explicitly setting channels on src & dst
to match.

> - Do we really want that the user "have" to configure that value

Right so this is the key quesiton - for a user not using libvirt
or a libvirt based mgmt app, what we do want out out of the box
migration to be tuned for ?

If we want to maximise migration performance, at cost of anything
else, then we can change the migration channels count, but probably
also ought to remove the 32MB bandwidth cap as no useful guest with
active apps will succeed migration with a 32MB cap.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|



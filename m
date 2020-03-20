Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0393FC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C489F20739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GK1VtT/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C489F20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFM4l-0002CB-0N
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 14:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jFM33-0000nb-QS
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jFM32-0000K1-4p
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:07:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:47929)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jFM32-0000Jp-0p
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584727627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DBs0wVljz8VFF+RSStNVIDJs5Nk6tUJrzUMX4YcTepM=;
 b=GK1VtT/DhOzNVyeLimM2/WmPrj5kfo5hPt41YQLx6JsfrpyoO0qtkqu8VuOpQvfnQPvZdX
 Zq7c+Ar3vpFRHTSkYUCn74sHmylJCHt+Cf1Xz2FlgWncP7iwWkVX0BD+IbU848fH8nf/ok
 kXimQpLbmcGFRcCaAxnQH2kjTeDdivQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-0roZtBYfMQKVybpXMmTRIQ-1; Fri, 20 Mar 2020 14:07:05 -0400
X-MC-Unique: 0roZtBYfMQKVybpXMmTRIQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70E401857BE8;
 Fri, 20 Mar 2020 18:07:04 +0000 (UTC)
Received: from work-vm (ovpn-114-236.ams2.redhat.com [10.36.114.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 605251001925;
 Fri, 20 Mar 2020 18:07:03 +0000 (UTC)
Date: Fri, 20 Mar 2020 18:07:00 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] monitor/hmp-cmds: fix bad indentation in 'info
 migrate_parameters' cmd output
Message-ID: <20200320180700.GF3464@work-vm>
References: <20200320130013.418557-1-maozhongyi@cmss.chinamobile.com>
 <878sjv11xm.fsf@dusky.pond.sub.org> <20200320173117.GE3464@work-vm>
 <20200320174901.GO2608355@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200320174901.GO2608355@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Fri, Mar 20, 2020 at 05:31:17PM +0000, Dr. David Alan Gilbert wrote:
> > (Rearranging the text a bit)
> >=20
> > * Markus Armbruster (armbru@redhat.com) wrote:
> >=20
> > > David (cc'ed) should be able to tell us which fix is right.
> > >=20
> > > @tls_creds and @tls_hostname look like they could have the same issue=
.
> >=20
> > A certain Markus removed the Null checks in 8cc99dc because 4af245d
> > guaranteed they would be None-Null for tls-creds/hostname - so we
> > should be OK for those.
> >=20
> > But tls-authz came along a lot later in d2f1d29 and doesn't
> > seem to have the initialisation, which is now in
> > migration_instance_init.
> >=20
> > So I *think* the fix for this is to do the modern equivalent of 4af245d
> > :
> >=20
> > diff --git a/migration/migration.c b/migration/migration.c
> > index c1d88ace7f..0bc1b93277 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -3686,6 +3686,7 @@ static void migration_instance_init(Object *obj)
> > =20
> >      params->tls_hostname =3D g_strdup("");
> >      params->tls_creds =3D g_strdup("");
> > +    params->tls_authz =3D g_strdup("");
> > =20
> >      /* Set has_* up only for parameter checks */
> >      params->has_compress_level =3D true;
> >=20
> > Copying in Dan to check that wouldn't break tls.
>=20
> It *will* break TLS, because it will cause the TLS code to lookup
> an object with the ID of "".  NULL must be preserved when calling
> the TLS APIs.

OK, good I asked...

> The assignment of "" to tls_hostname would also have broken TLS,
> so the migration_tls_channel_connect method had to turn it back
> into a real NULL.
>=20
> The use of "" for tls_creds will similarly cause it to try and
> lookup an object with ID of "", and fail. That one's harmless
> though, because it would also fail if it were NULL.

OK.

It looks like the output of query-migrate-parameters though already
turns it into "", so I don't think you can tell it's NULL from that:

{"QMP": {"version": {"qemu": {"micro": 0, "minor": 2, "major": 4}, "package=
": "qemu-4.2.0-4.fc31"}, "capabilities": ["oob"]}}
{ "execute": "qmp_capabilities" }
{"return": {}}
{ "execute": "query-migrate-parameters" }
{"return": {"xbzrle-cache-size": 67108864, "cpu-throttle-initial": 20, "ann=
ounce-max": 550, "decompress-threads": 2, "compress-threads": 8, "compress-=
level": 1, "multifd-channels": 2, "announce-initial": 50, "block-incrementa=
l": false, "compress-wait-thread": true, "downtime-limit": 300, "tls-authz"=
: "", "announce-rounds": 5, "announce-step": 100, "tls-creds": "", "max-cpu=
-throttle": 99, "max-postcopy-bandwidth": 0, "tls-hostname": "", "max-bandw=
idth": 33554432, "x-checkpoint-delay": 20000, "cpu-throttle-increment": 10}=
}

I'm not sure who turns a Null into a "" but I guess it's somewhere in
the json output iterator.

So we can fix this problem either in qmp_query_migrate_parameters
and just strdup a "", or substitute it in hmp_info_migrate_parameters.

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



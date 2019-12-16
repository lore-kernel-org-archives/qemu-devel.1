Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C647FC2D0CF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 09:59:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9344E205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 09:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7csbSio"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9344E205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ign9m-0000Y9-Jv
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 04:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ign98-00006B-F5
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 04:58:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ign94-0007tf-Sl
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 04:58:32 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33986
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ign94-0007sL-F7
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 04:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576490308;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xTB95OczKley658wIGoCYElGnHeDhivyoYytrtHljbg=;
 b=G7csbSioAS11P0kBez7yFhYGHsWLeYnMoy2s5O3WwKNu5UfgRORDZNRLsnDQF6hIdf3YDl
 zt2v01VEVTrqStdhecKlL4fL2aizMa3mRE0KKQoMBt+CiYiHGuBBu0G2MyP/IlDjg+NMtP
 pbDyFknHyXmLqZju0lX1he2pOJtbw/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-xXYLmmtMM96xgkIfs1KBsA-1; Mon, 16 Dec 2019 04:58:21 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B349100550E
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 09:58:21 +0000 (UTC)
Received: from redhat.com (ovpn-112-24.ams2.redhat.com [10.36.112.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6661119C7F;
 Mon, 16 Dec 2019 09:58:16 +0000 (UTC)
Date: Mon, 16 Dec 2019 09:58:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v6 8/8] tests: add dbus-vmstate-test
Message-ID: <20191216095812.GC3313@redhat.com>
References: <20191211134506.1803403-1-marcandre.lureau@redhat.com>
 <20191211134506.1803403-9-marcandre.lureau@redhat.com>
 <20191213182015.GR3713@work-vm>
MIME-Version: 1.0
In-Reply-To: <20191213182015.GR3713@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: xXYLmmtMM96xgkIfs1KBsA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: mprivozn@redhat.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 13, 2019 at 06:20:15PM +0000, Dr. David Alan Gilbert wrote:
> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@redhat.com) wrote:
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> > +static gboolean
> > +vmstate_save(VMState1 *object, GDBusMethodInvocation *invocation,
> > +             gpointer user_data)
> > +{
> > +    TestServer *h =3D user_data;
> > +    GVariant *var;
> > +
> > +    var =3D g_variant_new_fixed_array(G_VARIANT_TYPE_BYTE,
> > +                                    h->id->data, h->id->size, sizeof(c=
har));
> > +    g_dbus_method_invocation_return_value(invocation,
> > +                                          g_variant_new("(@ay)", var))=
;
> > +    h->save_called =3D true;
> > +
> > +    return TRUE;
> > +}
> > +
> > +static gboolean
> > +wait_for_migration_complete(gpointer user_data)
>=20
> It's a shame we don't have a way to share this with migration-test.c;
> we occasionally add more debug/cases in there.

Easy enough to create a tests/migration-helpers.{c,h} file to share
code between tests.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|



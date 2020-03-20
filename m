Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29480C4332E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 20:26:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E920E2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 20:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7Csntj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E920E2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFOEC-0006wK-2K
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 16:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jFODX-0006X8-2G
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 16:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jFODV-0000H3-31
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 16:26:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:29252)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jFODU-0000FC-Ul
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 16:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584735964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6dSOr+4iuiqS8f3wpACLB8OrPMRjyYLjRMmsisBy138=;
 b=Y7Csntj8YNBQUSKX516Xwx8Oj9aUNsol+cyPxAAELjNaL8NeDgbxZfbOmk1P0PFD0lV0lK
 dh6GGapfeQ2yjLrC/ZFqhJE9h6kAz0IbeMpnzdrMRigWYk2kZ03nTg4hLm2OBA7tMYwPD3
 GiNYdTsbTlrZ9sNwNV5DhvRAOuUB9cg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-MZUF94t2MpCOfC1os31y3w-1; Fri, 20 Mar 2020 16:26:02 -0400
X-MC-Unique: MZUF94t2MpCOfC1os31y3w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91C19A0CC2;
 Fri, 20 Mar 2020 20:26:01 +0000 (UTC)
Received: from work-vm (ovpn-114-236.ams2.redhat.com [10.36.114.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C2FD41001938;
 Fri, 20 Mar 2020 20:25:57 +0000 (UTC)
Date: Fri, 20 Mar 2020 20:25:55 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PULL 2/3] hmp: Update info vnc
Message-ID: <20200320202555.GJ3464@work-vm>
References: <20170717093839.15341-1-kraxel@redhat.com>
 <20170717093839.15341-3-kraxel@redhat.com>
 <CAFEAcA8MWO5bo65Jv=QX=9ucB2xCyShnBRQ7Sow6UCEs58+-Tw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8MWO5bo65Jv=QX=9ucB2xCyShnBRQ7Sow6UCEs58+-Tw@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Mon, 17 Jul 2017 at 10:40, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > The QMP query-vnc interfaces have gained a lot more information that
> > the HMP interfaces hasn't got yet. Update it.
> >
> > Note the output format has changed, but this is HMP so that's OK.
>=20
> Hi; another "ancient change Coverity has only just noticed has
> a problem" email :-)   This is CID 1421932. It looks like any
> "info vnc" will leak memory if there are any VNC servers to
> display info about...
>=20
> >  void hmp_info_vnc(Monitor *mon, const QDict *qdict)
> >  {
> > -    VncInfo *info;
> > +    VncInfo2List *info2l;
> >      Error *err =3D NULL;
> > -    VncClientInfoList *client;
> >
> > -    info =3D qmp_query_vnc(&err);
> > +    info2l =3D qmp_query_vnc_servers(&err);
>=20
> Here we get a list of VNC servers, which is allocated memory...
>=20
> >      if (err) {
> >          error_report_err(err);
> >          return;
> >      }
> > -
> > -    if (!info->enabled) {
> > -        monitor_printf(mon, "Server: disabled\n");
> > -        goto out;
> > -    }
> > -
> > -    monitor_printf(mon, "Server:\n");
> > -    if (info->has_host && info->has_service) {
> > -        monitor_printf(mon, "     address: %s:%s\n", info->host, info-=
>service);
> > -    }
> > -    if (info->has_auth) {
> > -        monitor_printf(mon, "        auth: %s\n", info->auth);
> > +    if (!info2l) {
> > +        monitor_printf(mon, "None\n");
> > +        return;
> >      }
> >
> > -    if (!info->has_clients || info->clients =3D=3D NULL) {
> > -        monitor_printf(mon, "Client: none\n");
> > -    } else {
> > -        for (client =3D info->clients; client; client =3D client->next=
) {
> > -            monitor_printf(mon, "Client:\n");
> > -            monitor_printf(mon, "     address: %s:%s\n",
> > -                           client->value->host,
> > -                           client->value->service);
> > -            monitor_printf(mon, "  x509_dname: %s\n",
> > -                           client->value->x509_dname ?
> > -                           client->value->x509_dname : "none");
> > -            monitor_printf(mon, "    username: %s\n",
> > -                           client->value->has_sasl_username ?
> > -                           client->value->sasl_username : "none");
> > +    while (info2l) {
> > +        VncInfo2 *info =3D info2l->value;
> > +        monitor_printf(mon, "%s:\n", info->id);
> > +        hmp_info_vnc_servers(mon, info->server);
> > +        hmp_info_vnc_clients(mon, info->clients);
> > +        if (!info->server) {
> > +            /* The server entry displays its auth, we only
> > +             * need to display in the case of 'reverse' connections
> > +             * where there's no server.
> > +             */
> > +            hmp_info_vnc_authcrypt(mon, "  ", info->auth,
> > +                               info->has_vencrypt ? &info->vencrypt : =
NULL);
> > +        }
> > +        if (info->has_display) {
> > +            monitor_printf(mon, "  Display: %s\n", info->display);
> >          }
> > +        info2l =3D info2l->next;
>=20
> ...but the loop iteration here updates 'info2l' as it goes along...
>=20
> >      }
> >
> > -out:
> > -    qapi_free_VncInfo(info);
> > +    qapi_free_VncInfo2List(info2l);
>=20
> ...so here we end up passing NULL to qapi_free_VncInfo2List(),
> which will do nothing, leaking the whole list.
>=20
> Would somebody like to send a patch?

Oops, yes I can look at that; I guess something along the lines of an
info2l_orig  and free that at the end.

Dave

> thanks
> -- PMM
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



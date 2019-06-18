Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1379CC31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 09:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E05102080A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 09:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05102080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55232 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdAYW-0003FS-0T
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 05:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53146)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hdAY2-0002o1-98
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 05:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hdAY0-0002tW-TR
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 05:37:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27714)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hdAY0-0002sA-Ky
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 05:37:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ED024308A963
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 09:36:58 +0000 (UTC)
Received: from work-vm (ovpn-117-76.ams2.redhat.com [10.36.117.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C6A981860;
 Tue, 18 Jun 2019 09:36:52 +0000 (UTC)
Date: Tue, 18 Jun 2019 10:36:49 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Message-ID: <20190618093649.GE2850@work-vm>
References: <20190613095924.21908-1-dgilbert@redhat.com>
 <20190613095924.21908-2-dgilbert@redhat.com>
 <36dd4c3b-334c-1a6c-74ca-3b3f06cbffbc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36dd4c3b-334c-1a6c-74ca-3b3f06cbffbc@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 18 Jun 2019 09:36:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 1/5] net/announce: Allow optional list
 of interfaces
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
Cc: qemu-devel@nongnu.org, laine@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Jason Wang (jasowang@redhat.com) wrote:
>=20
> On 2019/6/13 =E4=B8=8B=E5=8D=885:59, Dr. David Alan Gilbert (git) wrote=
:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > Allow the caller to restrict the set of interfaces that announces are
> > sent on.  The default is still to send on all interfaces.
> >=20
> > e.g.
> >=20
> >    { "execute": "announce-self", "arguments": { "initial": 50, "max":=
 550, "rounds": 5, "step": 50, "interfaces": ["vn2", "vn1"] } }
> >=20
> > This doesn't affect the behaviour of migraiton announcments.
> >=20
> > Note: There's still only one timer for the qmp command, so that
> > performing an 'announce-self' on one list of interfaces followed
> > by another 'announce-self' on another list will stop the announces
> > on the existing set.
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >   include/net/announce.h |  2 +-
> >   net/announce.c         | 39 ++++++++++++++++++++++++++++++++-------
> >   net/trace-events       |  2 +-
> >   qapi/net.json          | 11 ++++++++---
> >   4 files changed, 42 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/include/net/announce.h b/include/net/announce.h
> > index 04a035f679..773470428b 100644
> > --- a/include/net/announce.h
> > +++ b/include/net/announce.h
> > @@ -22,7 +22,7 @@ struct AnnounceTimer {
> >   /* Returns: update the timer to the next time point */
> >   int64_t qemu_announce_timer_step(AnnounceTimer *timer);
> > -/* Delete the underlying timer */
> > +/* Delete the underlying timer and other data */
> >   void qemu_announce_timer_del(AnnounceTimer *timer);
> >   /*
> > diff --git a/net/announce.c b/net/announce.c
> > index 91e9a6e267..1ce42b571d 100644
> > --- a/net/announce.c
> > +++ b/net/announce.c
> > @@ -38,6 +38,8 @@ void qemu_announce_timer_del(AnnounceTimer *timer)
> >           timer_free(timer->tm);
> >           timer->tm =3D NULL;
> >       }
> > +    qapi_free_strList(timer->params.interfaces);
> > +    timer->params.interfaces =3D NULL;
> >   }
> >   /*
> > @@ -96,24 +98,47 @@ static int announce_self_create(uint8_t *buf,
> >   static void qemu_announce_self_iter(NICState *nic, void *opaque)
> >   {
> > +    AnnounceTimer *timer =3D opaque;
> >       uint8_t buf[60];
> >       int len;
> > +    bool skip;
> > +
> > +    if (timer->params.has_interfaces) {
> > +        strList *entry =3D timer->params.interfaces;
> > +        /* Skip unless we find our name in the requested list */
> > +        skip =3D true;
> > +
> > +        while (entry) {
> > +            if (!strcmp(entry->value, nic->ncs->name)) {
> > +                /* Found us */
> > +                skip =3D false;
> > +                break;
> > +            }
> > +            entry =3D entry->next;
> > +        }
> > +    } else {
> > +        skip =3D false;
> > +    }
>=20
>=20
> I wonder whether or not it's better to filter the name on the caller.

Doing it this way means I don't have to worry about any hotplug that
might happen during the announce period.

Dave

> Thanks
>=20
>=20
> > +
> > +    trace_qemu_announce_self_iter(nic->ncs->name,
> > +                                  qemu_ether_ntoa(&nic->conf->macadd=
r), skip);
> > -    trace_qemu_announce_self_iter(qemu_ether_ntoa(&nic->conf->macadd=
r));
> > -    len =3D announce_self_create(buf, nic->conf->macaddr.a);
> > +    if (!skip) {
> > +        len =3D announce_self_create(buf, nic->conf->macaddr.a);
> > -    qemu_send_packet_raw(qemu_get_queue(nic), buf, len);
> > +        qemu_send_packet_raw(qemu_get_queue(nic), buf, len);
> > -    /* if the NIC provides it's own announcement support, use it as =
well */
> > -    if (nic->ncs->info->announce) {
> > -        nic->ncs->info->announce(nic->ncs);
> > +        /* if the NIC provides it's own announcement support, use it=
 as well */
> > +        if (nic->ncs->info->announce) {
> > +            nic->ncs->info->announce(nic->ncs);
> > +        }
> >       }
> >   }
> >   static void qemu_announce_self_once(void *opaque)
> >   {
> >       AnnounceTimer *timer =3D (AnnounceTimer *)opaque;
> > -    qemu_foreach_nic(qemu_announce_self_iter, NULL);
> > +    qemu_foreach_nic(qemu_announce_self_iter, timer);
> >       if (--timer->round) {
> >           qemu_announce_timer_step(timer);
> > diff --git a/net/trace-events b/net/trace-events
> > index a7937f3f3a..875ef2a0f3 100644
> > --- a/net/trace-events
> > +++ b/net/trace-events
> > @@ -1,7 +1,7 @@
> >   # See docs/devel/tracing.txt for syntax documentation.
> >   # announce.c
> > -qemu_announce_self_iter(const char *mac) "%s"
> > +qemu_announce_self_iter(const char *name, const char *mac, int skip)=
 "%s:%s skip: %d"
> >   # vhost-user.c
> >   vhost_user_event(const char *chr, int event) "chr: %s got event: %d=
"
> > diff --git a/qapi/net.json b/qapi/net.json
> > index 5f7bff1637..6f2cd4f530 100644
> > --- a/qapi/net.json
> > +++ b/qapi/net.json
> > @@ -699,6 +699,9 @@
> >   #
> >   # @step: Delay increase (in ms) after each self-announcement attemp=
t
> >   #
> > +# @interfaces: An optional list of interface names, which restricts =
the
> > +#        announcement to the listed interfaces. (Since 4.1)
> > +#
> >   # Since: 4.0
> >   ##
> > @@ -706,7 +709,8 @@
> >     'data': { 'initial': 'int',
> >               'max': 'int',
> >               'rounds': 'int',
> > -            'step': 'int' } }
> > +            'step': 'int',
> > +            '*interfaces': ['str'] } }
> >   ##
> >   # @announce-self:
> > @@ -718,9 +722,10 @@
> >   #
> >   # Example:
> >   #
> > -# -> { "execute": "announce-self"
> > +# -> { "execute": "announce-self",
> >   #      "arguments": {
> > -#          "initial": 50, "max": 550, "rounds": 10, "step": 50 } }
> > +#          "initial": 50, "max": 550, "rounds": 10, "step": 50,
> > +#          "interfaces": ["vn2", "vn3"] } }
> >   # <- { "return": {} }
> >   #
> >   # Since: 4.0
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


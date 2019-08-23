Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1E4C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 06:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 060552070B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 06:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Fukge7El"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060552070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i132l-0004Ax-WB
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 02:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1i12xR-0003AT-Se
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 02:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1i12xP-0004wu-Br
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 02:21:57 -0400
Received: from mout.web.de ([212.227.15.14]:48491)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1i12xO-0004qK-VS
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 02:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1566541289;
 bh=fHTyIKZ652Sv/4MYdI9jfS36DxqlaDDWUOU2KuTc1sE=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Fukge7El6A3rXKiJAG//vpwFQJ1NyCOM8NaxV58pVc6Rm+869sQFEjRJZ7sE98RI+
 rUaekbxJIPYMTjT6cMOEQGTXSU0zTzxVwaqxbPUhoOglkzeTzKs1lLVmp0cuIdAaRj
 lzbaj1Py7+W8ySdcw+UIra+srbf4pam9fuo78ooU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.7]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LwHmQ-1iJBSQ3Sdq-0183Cs; Fri, 23
 Aug 2019 08:21:28 +0200
Date: Fri, 23 Aug 2019 08:21:25 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Message-ID: <20190823082125.499095d7@luklap>
In-Reply-To: <9CFF81C0F6B98A43A459C9EDAD400D780622D3DC@shsmsx102.ccr.corp.intel.com>
References: <cover.1565894837.git.lukasstraub2@web.de>
 <6643a807a5f4c5ceb2f09e0718e97e5f968577f7.1565894837.git.lukasstraub2@web.de>
 <9CFF81C0F6B98A43A459C9EDAD400D780622D3DC@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kjii+kW8PDxwrBIc5ntAMm072yhErhtNR4AzOZXpY6MAYkQj5os
 H6zq2x5KOzXUcqWCQpFfDAi0lyCn8rMOpjTeBynb0O+Z3zVJ0SF127s95M5a/IeciAvMCZ6
 xynzwMXjR6wvFgPfAsGA/d338VYw0zme+fXahpPPf7R505mtDgMDaoICjzpzugWH3mwT47Z
 O87SQPIUyOVdDk26TvbUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:68+VypoXaCM=:cGnCFbig8fndNicm0nljdB
 hpF0gYiEXnFMWqbbvyoVklIsAieOmmQm6+RWKOjg4TJ0RUuzIQnv8vRD0MM4RtHIkkJbQ4LZm
 t72e+SQGuwMjxH3eQp63aBYdne6Nc2j+woGNw1uBxUTmJKICy3cYdbZ4RAxtdWHrldPqLR9Zu
 G2kvL3HQqaHlzpmhOh7yU9pXMkLi4z0FeXCt6NyOGYmwYVeVVhBR9Q9jvO+ES1YP+P5xKvmOB
 WC/KiVRNWnTYr7fm8ukyaYBfhHh5K+WCKwuv4ltaxLTD645HkBzGLO6OLE+07JqfEF3S3Ha6w
 bKx4kCHJaIKE8D3hHBwYBHV+IgIcofy3bzCeanrv3oludYCIr5KOkgt+aAMGpZCbG2g2uy1Le
 XHGv4KAQe4xPdE6BgXKPrfHQOKHouLrOpsc3a0ZlNHlULXJdR17hudRWjPGZm4jDShL7LNW4R
 wJHCvztgIVVH0zKK+9OnHiyyvohq4o3Ahklio4S6q1mgCJCGGRjdng5Nm3pa2ghKCJnHVciXS
 zgYGd+ymgquJ/syDOLU3TDp4bQCT9YEgAy3NN/pqBN6Y98xIuq6d5NSxr2EPSwKRVfmq3AgFF
 Y+K/+8Rbvi4ZjzJBqxniUFGEvcnxAFtWua482ilr3JD3negFEXMGlhcA6brQW0VFMeylSO/My
 RyKkVkK+ywmwWCrEFHj0buHniobHsDJrVsQ0I5UK9Bp0toy8kkPjRm59IPAw7fSKHYADA20o/
 V/+Ew5sE8rpdgPQctTDfcBb8Nh6O/GyTQzaQ3OJT79YuviDzUG5CsM2T/hFyk/ijcSWdIfTeV
 ThLKvR/HC2/c32cuP13azLc2KllNm+bRcdjeCxX2TuzECMxUAnGAJbZiXVpnJnV9mjmH3sgkZ
 F7O4oNCSmtNpEaxYG1gpPiydUT9cpUpIl3Z4VCz5N/Apgit6HDntr+h/CFi7VGpVOQEPEN1Lm
 /tJVGSC/8Jn2GvL8gX/PLxDvPTVYjF1kjV8dX+xe7HrZCBi+NJih48SwRP369q3lIUe2qnBkG
 sG0+YdRGOpbwhuWIhSk/ALeH5mla+3bstuEkOTeLIGin30qkGaWkDnIQ7P0KpVYGsSuArQPHr
 CGzpZ4qORTE0oVydgscik+XduZcXCw3cd0l8EKo+mA9cFb7LwrBoBniKj0R6hY38/gXq9vlYO
 GoriM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.14
Subject: Re: [Qemu-devel] [PATCH v2 2/3] net/filter.c: Add Options to insert
 filters anywhere in the filter list
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
Cc: Wen Congyang <wencongyang2@huawei.com>, Jason Wang <jasowang@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 03:24:02 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> > -----Original Message-----
> > From: Lukas Straub [mailto:lukasstraub2@web.de]
> > Sent: Friday, August 16, 2019 2:49 AM
> > To: qemu-devel <qemu-devel@nongnu.org>
> > Cc: Zhang, Chen <chen.zhang@intel.com>; Jason Wang
> > <jasowang@redhat.com>; Wen Congyang <wencongyang2@huawei.com>; Xie
> > Changlong <xiechanglong.d@gmail.com>
> > Subject: [PATCH v2 2/3] net/filter.c: Add Options to insert filters an=
ywhere in
> > the filter list
> >
> > To switch the Secondary to Primary, we need to insert new filters befo=
re the
> > filter-rewriter.
> >
> > Add the options insert=3D and position=3D to be able to insert filters=
 anywhere in the
> > filter list.
> >
> > position should be either "head", "tail" or the id of another filter.
> > insert should be either "before" or "after" to specify where to insert=
 the new
> > filter relative to the one specified with position.
> >
>
> Hi Lukas,
>
> It looks no need to add the "insert =3D xxx" for this operation.
> For example:
>
> We have 3 net-filters, the running order like that:
>
> Fiter1   ---------->   Filter2 ------------> Filter3
>
> If we want to add another filter between filter1 and filter2.
> The "Position =3D head, insert =3D after" always seam with "position =3D=
 filter2 id, insert =3D before".

Hi Zhang,
The insert=3D parameter is ignored if position=3Dhead or tail. It always I=
nserts at the head (before Filter1) or the tail (after Filter3) of the Lis=
t in these cases.

> It seems the "insert" is a redundant args.
> So I think it is enough with the "position", we can make the "insert" al=
ways equal "after" except the "head".

Yes, we still could do it without it, but its more convenient with the ins=
ert=3D parameter. For example our Case with inserting before the rewriter:

'filter-mirror', 'id': 'm0', 'props': { 'insert': 'before', 'position': 'r=
ew0', 'netdev': 'hn0', 'queue': 'tx', 'outdev': 'mirror0' }
'filter-redirector', 'id': 'redire0', 'props': { 'insert': 'before', 'posi=
tion': 'rew0', 'netdev': 'hn0', 'queue': 'rx', 'indev': 'compare_out' }
'filter-redirector', 'id': 'redire1', 'props': { 'insert': 'before', 'posi=
tion': 'rew0', 'netdev': 'hn0', 'queue': 'rx', 'outdev': 'compare0' }

You see directly that here 3 Filters are inserted before the rewriter.

would have to become:

'filter-mirror', 'id': 'm0', 'props': { 'position': 'head', 'netdev': 'hn0=
', 'queue': 'tx', 'outdev': 'mirror0' }
'filter-redirector', 'id': 'redire0', 'props': { 'position': 'm0', 'netdev=
': 'hn0', 'queue': 'rx', 'indev': 'compare_out' }
'filter-redirector', 'id': 'redire1', 'props': { 'position': 'redire0', 'n=
etdev': 'hn0', 'queue': 'rx', 'outdev': 'compare0' }

Which is less obvious.

Regards,
Lukas Straub

>
> Thanks
> Zhang Chen
>
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  include/net/filter.h |  2 ++
> >  net/filter.c         | 71 +++++++++++++++++++++++++++++++++++++++++++=
-
> >  qemu-options.hx      | 10 +++----
> >  3 files changed, 77 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/net/filter.h b/include/net/filter.h index
> > 49da666ac0..355c178f75 100644
> > --- a/include/net/filter.h
> > +++ b/include/net/filter.h
> > @@ -62,6 +62,8 @@ struct NetFilterState {
> >      NetClientState *netdev;
> >      NetFilterDirection direction;
> >      bool on;
> > +    char *position;
> > +    bool insert_before;
> >      QTAILQ_ENTRY(NetFilterState) next;
> >  };
> >
> > diff --git a/net/filter.c b/net/filter.c index 28d1930db7..309fd778df =
100644
> > --- a/net/filter.c
> > +++ b/net/filter.c
> > @@ -171,11 +171,47 @@ static void netfilter_set_status(Object *obj, co=
nst
> > char *str, Error **errp)
> >      }
> >  }
> >
> > +static char *netfilter_get_position(Object *obj, Error **errp) {
> > +    NetFilterState *nf =3D NETFILTER(obj);
> > +
> > +    return g_strdup(nf->position);
> > +}
> > +
> > +static void netfilter_set_position(Object *obj, const char *str, Erro=
r
> > +**errp) {
> > +    NetFilterState *nf =3D NETFILTER(obj);
> > +
> > +    nf->position =3D g_strdup(str);
> > +}
> > +
> > +static char *netfilter_get_insert(Object *obj, Error **errp) {
> > +    NetFilterState *nf =3D NETFILTER(obj);
> > +
> > +    return nf->insert_before ? g_strdup("before") : g_strdup("after")=
;
> > +}
> > +
> > +static void netfilter_set_insert(Object *obj, const char *str, Error
> > +**errp) {
> > +    NetFilterState *nf =3D NETFILTER(obj);
> > +
> > +    if (strcmp(str, "before") && strcmp(str, "after")) {
> > +        error_setg(errp, "Invalid value for netfilter insert, "
> > +                         "should be 'head' or 'tail'");
> > +        return;
> > +    }
> > +
> > +    nf->insert_before =3D !strcmp(str, "before"); }
> > +
> >  static void netfilter_init(Object *obj)  {
> >      NetFilterState *nf =3D NETFILTER(obj);
> >
> >      nf->on =3D true;
> > +    nf->insert_before =3D false;
> > +    nf->position =3D g_strdup("tail");
> >
> >      object_property_add_str(obj, "netdev",
> >                              netfilter_get_netdev_id, netfilter_set_ne=
tdev_id, @@ -187,11
> > +223,18 @@ static void netfilter_init(Object *obj)
> >      object_property_add_str(obj, "status",
> >                              netfilter_get_status, netfilter_set_statu=
s,
> >                              NULL);
> > +    object_property_add_str(obj, "position",
> > +                            netfilter_get_position, netfilter_set_pos=
ition,
> > +                            NULL);
> > +    object_property_add_str(obj, "insert",
> > +                            netfilter_get_insert, netfilter_set_inser=
t,
> > +                            NULL);
> >  }
> >
> >  static void netfilter_complete(UserCreatable *uc, Error **errp)  {
> >      NetFilterState *nf =3D NETFILTER(uc);
> > +    NetFilterState *position =3D NULL;
> >      NetClientState *ncs[MAX_QUEUE_NUM];
> >      NetFilterClass *nfc =3D NETFILTER_GET_CLASS(uc);
> >      int queues;
> > @@ -219,6 +262,20 @@ static void netfilter_complete(UserCreatable *uc,
> > Error **errp)
> >          return;
> >      }
> >
> > +    if (strcmp(nf->position, "head") && strcmp(nf->position, "tail"))=
 {
> > +        /* Search for the position to insert before/after */
> > +        Object *container;
> > +        Object *obj;
> > +
> > +        container =3D object_get_objects_root();
> > +        obj =3D object_resolve_path_component(container, nf->position=
);
> > +        if (!obj) {
> > +            error_setg(errp, "filter '%s' not found", nf->position);
> > +            return;
> > +        }
> > +        position =3D NETFILTER(obj);
> > +    }
> > +
> >      nf->netdev =3D ncs[0];
> >
> >      if (nfc->setup) {
> > @@ -228,7 +285,18 @@ static void netfilter_complete(UserCreatable *uc,
> > Error **errp)
> >              return;
> >          }
> >      }
> > -    QTAILQ_INSERT_TAIL(&nf->netdev->filters, nf, next);
> > +
> > +    if (position) {
> > +        if (nf->insert_before) {
> > +            QTAILQ_INSERT_BEFORE(position, nf, next);
> > +        } else {
> > +            QTAILQ_INSERT_AFTER(&nf->netdev->filters, position, nf, n=
ext);
> > +        }
> > +    } else if (!strcmp(nf->position, "head")) {
> > +        QTAILQ_INSERT_HEAD(&nf->netdev->filters, nf, next);
> > +    } else if (!strcmp(nf->position, "tail")) {
> > +        QTAILQ_INSERT_TAIL(&nf->netdev->filters, nf, next);
> > +    }
> >  }
> >
> >  static void netfilter_finalize(Object *obj) @@ -245,6 +313,7 @@ stati=
c void
> > netfilter_finalize(Object *obj)
> >          QTAILQ_REMOVE(&nf->netdev->filters, nf, next);
> >      }
> >      g_free(nf->netdev_id);
> > +    g_free(nf->position);
> >  }
> >
> >  static void default_handle_event(NetFilterState *nf, int event, Error=
 **errp)
> > diff --git a/qemu-options.hx b/qemu-options.hx index 08749a3391..f0a47=
a0746
> > 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -4368,7 +4368,7 @@ applications, they can do this through this para=
meter.
> > Its format is  a gnutls priority string as described at
> > @url{https://gnutls.org/manual/html_node/Priority-Strings.html}.
> >
> > -@item -object filter-
> > buffer,id=3D@var{id},netdev=3D@var{netdevid},interval=3D@var{t}[,queue=
=3D@var{all|r
> > x|tx}][,status=3D@var{on|off}]
> > +@item -object
> > +filter-buffer,id=3D@var{id},netdev=3D@var{netdevid},interval=3D@var{t=
}[,queue
> > +=3D@var{all|rx|tx}][,status=3D@var{on|off}][,position=3D@var{head|tai=
l|id}][,
> > +insert=3D@var{after|before}]
> >
> >  Interval @var{t} can't be 0, this filter batches the packet delivery:=
 all  packets
> > arriving in a given interval on netdev @var{netdevid} are delayed @@ -=
4387,11
> > +4387,11 @@ queue @var{all|rx|tx} is an option that can be applied to =
any
> > netfilter.
> >  @option{tx}: the filter is attached to the transmit queue of the netd=
ev,
> >               where it will receive packets sent by the netdev.
> >
> > -@item -object filter-
> > mirror,id=3D@var{id},netdev=3D@var{netdevid},outdev=3D@var{chardevid},=
queue=3D@v
> > ar{all|rx|tx}[,vnet_hdr_support]
> > +@item -object
> > +filter-mirror,id=3D@var{id},netdev=3D@var{netdevid},outdev=3D@var{cha=
rdevid},
> > +queue=3D@var{all|rx|tx}[,vnet_hdr_support][,position=3D@var{head|tail=
|id}][
> > +,insert=3D@var{after|before}]
> >
> >  filter-mirror on netdev @var{netdevid},mirror net packet to
> > chardev@var{chardevid}, if it has the vnet_hdr_support flag, filter-mi=
rror will
> > mirror packet with vnet_hdr_len.
> >
> > -@item -object filter-
> > redirector,id=3D@var{id},netdev=3D@var{netdevid},indev=3D@var{chardevi=
d},outdev=3D
> > @var{chardevid},queue=3D@var{all|rx|tx}[,vnet_hdr_support]
> > +@item -object
> > +filter-redirector,id=3D@var{id},netdev=3D@var{netdevid},indev=3D@var{=
chardevi
> > +d},outdev=3D@var{chardevid},queue=3D@var{all|rx|tx}[,vnet_hdr_support=
][,pos
> > +ition=3D@var{head|tail|id}][,insert=3D@var{after|before}]
> >
> >  filter-redirector on netdev @var{netdevid},redirect filter's net pack=
et to
> > chardev  @var{chardevid},and redirect indev's packet to filter.if it h=
as the
> > vnet_hdr_support flag, @@ -4400,7 +4400,7 @@ Create a filter-redirecto=
r we
> > need to differ outdev id from indev id, id can not  be the same. we ca=
n just use
> > indev or outdev, but at least one of indev or outdev  need to be speci=
fied.
> >
> > -@item -object filter-
> > rewriter,id=3D@var{id},netdev=3D@var{netdevid},queue=3D@var{all|rx|tx}=
,[vnet_hdr_
> > support]
> > +@item -object
> > +filter-rewriter,id=3D@var{id},netdev=3D@var{netdevid},queue=3D@var{al=
l|rx|tx}
> > +,[vnet_hdr_support][,position=3D@var{head|tail|id}][,insert=3D@var{af=
ter|be
> > +fore}]
> >
> >  Filter-rewriter is a part of COLO project.It will rewrite tcp packet =
to  secondary
> > from primary to keep secondary tcp connection,and rewrite @@ -4413,7
> > +4413,7 @@ colo secondary:
> >  -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dre=
d1
> >  -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall
> >
> > -@item -object filter-
> > dump,id=3D@var{id},netdev=3D@var{dev}[,file=3D@var{filename}][,maxlen=
=3D@var{len}]
> > +@item -object
> > +filter-dump,id=3D@var{id},netdev=3D@var{dev}[,file=3D@var{filename}][=
,maxlen=3D
> > +@var{len}][,position=3D@var{head|tail|id}][,insert=3D@var{after|befor=
e}]
> >
> >  Dump the network traffic on netdev @var{dev} to the file specified by
> > @var{filename}. At most @var{len} bytes (64k by default) per packet ar=
e stored.
> > --
> > 2.20.1
>



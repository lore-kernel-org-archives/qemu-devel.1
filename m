Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1DCC49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 20:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D39721019
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 20:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D39721019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7mWN-0004gZ-85
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 16:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1i7mVU-0004Ho-2T
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 16:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1i7mVR-0000Pp-7y
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 16:12:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:13749)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1i7mVQ-0000Ic-Ub
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 16:12:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Sep 2019 13:12:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,490,1559545200"; d="scan'208";a="209441766"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga004.fm.intel.com with ESMTP; 10 Sep 2019 13:12:48 -0700
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 10 Sep 2019 13:12:48 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX155.amr.corp.intel.com (10.18.116.71) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 10 Sep 2019 13:12:48 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.113]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.53]) with mapi id 14.03.0439.000;
 Wed, 11 Sep 2019 04:12:46 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v4 3/4] net/filter.c: Add Options to insert filters
 anywhere in the filter list
Thread-Index: AQHVZ8CaT0gcOKe01kmL9/Hq7puDHKclVlVw
Date: Tue, 10 Sep 2019 20:12:45 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D7806264100@shsmsx102.ccr.corp.intel.com>
References: <cover.1568110100.git.lukasstraub2@web.de>
 <77d2eb7d0ce8a1887a575119e21ce0a06d4af533.1568110100.git.lukasstraub2@web.de>
In-Reply-To: <77d2eb7d0ce8a1887a575119e21ce0a06d4af533.1568110100.git.lukasstraub2@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDAzNzFkMjktYTc2YS00ZjE0LWIyYzgtNmM5YThiNTNiYjY2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSWVGTmQyWVJvTlI5MnFcLytJVEtheDArMWl5Z011N1pCWG1jWFdvZ2lhMW5RakZcL1AxYlBxMTdLUmtBTWNtK0h5In0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
Subject: Re: [Qemu-devel] [PATCH v4 3/4] net/filter.c: Add Options to insert
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Jason Wang <jasowang@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> -----Original Message-----
> From: Lukas Straub <lukasstraub2@web.de>
> Sent: Tuesday, September 10, 2019 6:15 PM
> To: qemu-devel <qemu-devel@nongnu.org>
> Cc: Zhang, Chen <chen.zhang@intel.com>; Jason Wang
> <jasowang@redhat.com>; Wen Congyang <wencongyang2@huawei.com>;
> Xie Changlong <xiechanglong.d@gmail.com>; kwolf@redhat.com;
> mreitz@redhat.com
> Subject: [PATCH v4 3/4] net/filter.c: Add Options to insert filters anywh=
ere in
> the filter list
>=20
> To switch the Secondary to Primary, we need to insert new filters before =
the
> filter-rewriter.
>=20
> Add the options insert=3D and position=3D to be able to insert filters an=
ywhere in
> the filter list.
>=20
> position should be either "head", "tail" or the id of another filter.

In current patch, we cannot distinguish the real "head/tail" or the ID =3D =
"head/tail".
And in real environment we can't order users reserve the "head/tail" as key=
words.
So, I think we can use position=3DID-xxxx/head/tail to solve this issue, or=
 do you have any other idea?

Thanks
Zhang Chen

> insert should be either "before" or "behind" to specify where to insert t=
he
> new filter relative to the one specified with position.
>=20
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  include/net/filter.h |  2 ++
>  net/filter.c         | 78
> +++++++++++++++++++++++++++++++++++++++++++-
>  qemu-options.hx      | 10 +++---
>  3 files changed, 84 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/net/filter.h b/include/net/filter.h index
> 49da666ac0..22a723305b 100644
> --- a/include/net/filter.h
> +++ b/include/net/filter.h
> @@ -62,6 +62,8 @@ struct NetFilterState {
>      NetClientState *netdev;
>      NetFilterDirection direction;
>      bool on;
> +    char *position;
> +    bool insert_before_flag;
>      QTAILQ_ENTRY(NetFilterState) next;
>  };
>=20
> diff --git a/net/filter.c b/net/filter.c index 28d1930db7..eb0e9849a5 100=
644
> --- a/net/filter.c
> +++ b/net/filter.c
> @@ -171,11 +171,47 @@ static void netfilter_set_status(Object *obj, const
> char *str, Error **errp)
>      }
>  }
>=20
> +static char *netfilter_get_position(Object *obj, Error **errp) {
> +    NetFilterState *nf =3D NETFILTER(obj);
> +
> +    return g_strdup(nf->position);
> +}
> +
> +static void netfilter_set_position(Object *obj, const char *str, Error
> +**errp) {
> +    NetFilterState *nf =3D NETFILTER(obj);
> +
> +    nf->position =3D g_strdup(str);
> +}
> +
> +static char *netfilter_get_insert(Object *obj, Error **errp) {
> +    NetFilterState *nf =3D NETFILTER(obj);
> +
> +    return nf->insert_before_flag ? g_strdup("before") :
> +g_strdup("behind"); }
> +
> +static void netfilter_set_insert(Object *obj, const char *str, Error
> +**errp) {
> +    NetFilterState *nf =3D NETFILTER(obj);
> +
> +    if (strcmp(str, "before") && strcmp(str, "behind")) {
> +        error_setg(errp, "Invalid value for netfilter insert, "
> +                         "should be 'before' or 'behind'");
> +        return;
> +    }
> +
> +    nf->insert_before_flag =3D !strcmp(str, "before"); }
> +
>  static void netfilter_init(Object *obj)  {
>      NetFilterState *nf =3D NETFILTER(obj);
>=20
>      nf->on =3D true;
> +    nf->insert_before_flag =3D false;
> +    nf->position =3D g_strdup("tail");
>=20
>      object_property_add_str(obj, "netdev",
>                              netfilter_get_netdev_id, netfilter_set_netde=
v_id, @@ -
> 187,11 +223,18 @@ static void netfilter_init(Object *obj)
>      object_property_add_str(obj, "status",
>                              netfilter_get_status, netfilter_set_status,
>                              NULL);
> +    object_property_add_str(obj, "position",
> +                            netfilter_get_position, netfilter_set_positi=
on,
> +                            NULL);
> +    object_property_add_str(obj, "insert",
> +                            netfilter_get_insert, netfilter_set_insert,
> +                            NULL);
>  }
>=20
>  static void netfilter_complete(UserCreatable *uc, Error **errp)  {
>      NetFilterState *nf =3D NETFILTER(uc);
> +    NetFilterState *position =3D NULL;
>      NetClientState *ncs[MAX_QUEUE_NUM];
>      NetFilterClass *nfc =3D NETFILTER_GET_CLASS(uc);
>      int queues;
> @@ -219,6 +262,27 @@ static void netfilter_complete(UserCreatable *uc,
> Error **errp)
>          return;
>      }
>=20
> +    if (strcmp(nf->position, "head") && strcmp(nf->position, "tail")) {
> +        /* Search for the position to insert before/behind */
> +        Object *container;
> +        Object *obj;
> +
> +        container =3D object_get_objects_root();
> +        obj =3D object_resolve_path_component(container, nf->position);
> +        if (!obj) {
> +            error_setg(errp, "filter '%s' not found", nf->position);
> +            return;
> +        }
> +
> +        position =3D NETFILTER(obj);
> +
> +        if (position->netdev !=3D ncs[0]) {
> +            error_setg(errp, "filter '%s' belongs to a different netdev"=
,
> +                        nf->position);
> +            return;
> +        }
> +    }
> +
>      nf->netdev =3D ncs[0];
>=20
>      if (nfc->setup) {
> @@ -228,7 +292,18 @@ static void netfilter_complete(UserCreatable *uc,
> Error **errp)
>              return;
>          }
>      }
> -    QTAILQ_INSERT_TAIL(&nf->netdev->filters, nf, next);
> +
> +    if (position) {
> +        if (nf->insert_before_flag) {
> +            QTAILQ_INSERT_BEFORE(position, nf, next);
> +        } else {
> +            QTAILQ_INSERT_AFTER(&nf->netdev->filters, position, nf, next=
);
> +        }
> +    } else if (!strcmp(nf->position, "head")) {
> +        QTAILQ_INSERT_HEAD(&nf->netdev->filters, nf, next);
> +    } else if (!strcmp(nf->position, "tail")) {
> +        QTAILQ_INSERT_TAIL(&nf->netdev->filters, nf, next);
> +    }
>  }
>=20
>  static void netfilter_finalize(Object *obj) @@ -245,6 +320,7 @@ static v=
oid
> netfilter_finalize(Object *obj)
>          QTAILQ_REMOVE(&nf->netdev->filters, nf, next);
>      }
>      g_free(nf->netdev_id);
> +    g_free(nf->position);
>  }
>=20
>  static void default_handle_event(NetFilterState *nf, int event, Error **=
errp)
> diff --git a/qemu-options.hx b/qemu-options.hx index
> 08749a3391..1fd294a10f 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4368,7 +4368,7 @@ applications, they can do this through this
> parameter. Its format is  a gnutls priority string as described at
> @url{https://gnutls.org/manual/html_node/Priority-Strings.html}.
>=20
> -@item -object filter-
> buffer,id=3D@var{id},netdev=3D@var{netdevid},interval=3D@var{t}[,queue=3D=
@var{
> all|rx|tx}][,status=3D@var{on|off}]
> +@item -object
> +filter-buffer,id=3D@var{id},netdev=3D@var{netdevid},interval=3D@var{t}[,=
queue
> +=3D@var{all|rx|tx}][,status=3D@var{on|off}][,position=3D@var{head|tail|i=
d}][,
> +insert=3D@var{behind|before}]
>=20
>  Interval @var{t} can't be 0, this filter batches the packet delivery: al=
l  packets
> arriving in a given interval on netdev @var{netdevid} are delayed @@ -
> 4387,11 +4387,11 @@ queue @var{all|rx|tx} is an option that can be applie=
d
> to any netfilter.
>  @option{tx}: the filter is attached to the transmit queue of the netdev,
>               where it will receive packets sent by the netdev.
>=20
> -@item -object filter-
> mirror,id=3D@var{id},netdev=3D@var{netdevid},outdev=3D@var{chardevid},que=
ue
> =3D@var{all|rx|tx}[,vnet_hdr_support]
> +@item -object
> +filter-mirror,id=3D@var{id},netdev=3D@var{netdevid},outdev=3D@var{charde=
vid},
> +queue=3D@var{all|rx|tx}[,vnet_hdr_support][,position=3D@var{head|tail|id=
}][
> +,insert=3D@var{behind|before}]
>=20
>  filter-mirror on netdev @var{netdevid},mirror net packet to
> chardev@var{chardevid}, if it has the vnet_hdr_support flag, filter-mirro=
r will
> mirror packet with vnet_hdr_len.
>=20
> -@item -object filter-
> redirector,id=3D@var{id},netdev=3D@var{netdevid},indev=3D@var{chardevid},=
out
> dev=3D@var{chardevid},queue=3D@var{all|rx|tx}[,vnet_hdr_support]
> +@item -object
> +filter-redirector,id=3D@var{id},netdev=3D@var{netdevid},indev=3D@var{cha=
rdevi
> +d},outdev=3D@var{chardevid},queue=3D@var{all|rx|tx}[,vnet_hdr_support][,=
p
> os
> +ition=3D@var{head|tail|id}][,insert=3D@var{behind|before}]
>=20
>  filter-redirector on netdev @var{netdevid},redirect filter's net packet =
to
> chardev  @var{chardevid},and redirect indev's packet to filter.if it has =
the
> vnet_hdr_support flag, @@ -4400,7 +4400,7 @@ Create a filter-redirector
> we need to differ outdev id from indev id, id can not  be the same. we ca=
n
> just use indev or outdev, but at least one of indev or outdev  need to be
> specified.
>=20
> -@item -object filter-
> rewriter,id=3D@var{id},netdev=3D@var{netdevid},queue=3D@var{all|rx|tx},[v=
net_
> hdr_support]
> +@item -object
> +filter-rewriter,id=3D@var{id},netdev=3D@var{netdevid},queue=3D@var{all|r=
x|tx}
> +,[vnet_hdr_support][,position=3D@var{head|tail|id}][,insert=3D@var{behin=
d|b
> +efore}]
>=20
>  Filter-rewriter is a part of COLO project.It will rewrite tcp packet to
> secondary from primary to keep secondary tcp connection,and rewrite @@ -
> 4413,7 +4413,7 @@ colo secondary:
>  -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dred1
>  -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall
>=20
> -@item -object filter-
> dump,id=3D@var{id},netdev=3D@var{dev}[,file=3D@var{filename}][,maxlen=3D@=
var{
> len}]
> +@item -object
> +filter-
> dump,id=3D@var{id},netdev=3D@var{dev}[,file=3D@var{filename}][,maxlen=3D
> +@var{len}][,position=3D@var{head|tail|id}][,insert=3D@var{behind|before}=
]
>=20
>  Dump the network traffic on netdev @var{dev} to the file specified by
> @var{filename}. At most @var{len} bytes (64k by default) per packet are
> stored.
> --
> 2.20.1



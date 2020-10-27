Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400D7C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:03:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2706A21556
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="C56oQK4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2706A21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXJ10-0007B9-A4
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 03:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXIyD-0005ot-AO; Tue, 27 Oct 2020 03:00:37 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:38797 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXIy6-0002sF-Sk; Tue, 27 Oct 2020 03:00:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CL2ds1SPjz9sT6; Tue, 27 Oct 2020 18:00:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603782017;
 bh=cp3L5CU7RVg3LFHqf2W5ubdpLFUc6OI2ba+eb4vhiLk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C56oQK4PcTRIoyCRRWgD4n5VAxPBRxe7XfjkTBw5+GL8iJMQ3RmKnVqiOh6K4CMVg
 1vTzCsUggpHuzILpVn+VyWlr0/XeUXlmSG0BdxTnCX8gFpwE0dKpb5ASeRNGwOOVDR
 42rMljmw9GYYBQekB6hzT+eg/JxMQHeH52d+Nh6k=
Date: Tue, 27 Oct 2020 17:39:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v6 11/11] qapi: Use QAPI_LIST_ADD() where possible
Message-ID: <20201027063956.GB351557@yekko.fritz.box>
References: <20201027050556.269064-1-eblake@redhat.com>
 <20201027050556.269064-12-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
In-Reply-To: <20201027050556.269064-12-eblake@redhat.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, pkrempa@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 David Hildenbrand <david@redhat.com>, armbru@redhat.com,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "open list:S390 KVM CPUs" <qemu-s390x@nongnu.org>,
 "open list:GLUSTER" <integration@gluster.org>, stefanha@redhat.com,
 Richard Henderson <rth@twiddle.net>, kwolf@redhat.com,
 vsementsov@virtuozzo.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, rjones@redhat.com,
 Max Reitz <mreitz@redhat.com>, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2020 at 12:05:56AM -0500, Eric Blake wrote:
> Anywhere we create a list of just one item or by prepending items
> (typically because order doesn't matter), we can use the now-public
> macro.  But places where we must keep the list in order by appending
> remain open-coded.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  docs/devel/writing-qmp-commands.txt | 13 +++------
>  hw/net/rocker/rocker_fp.h           |  2 +-
>  block/gluster.c                     | 19 +++++--------
>  chardev/char.c                      | 21 +++++++--------
>  hw/core/machine.c                   |  6 +----
>  hw/net/rocker/rocker.c              |  8 +++---
>  hw/net/rocker/rocker_fp.c           | 14 +++++-----
>  hw/net/virtio-net.c                 | 21 +++++----------
>  migration/migration.c               |  7 ++---
>  migration/postcopy-ram.c            |  7 ++---
>  monitor/hmp-cmds.c                  | 11 ++++----
>  qemu-img.c                          |  5 ++--
>  qga/commands-posix.c                | 13 +++------
>  qga/commands-win32.c                | 17 +++---------
>  qga/commands.c                      |  6 +----
>  qom/qom-qmp-cmds.c                  | 29 ++++++--------------
>  target/arm/helper.c                 |  6 +----
>  target/arm/monitor.c                | 13 ++-------
>  target/i386/cpu.c                   |  6 +----
>  target/mips/helper.c                |  6 +----
>  target/s390x/cpu_models.c           | 12 ++-------
>  tests/test-clone-visitor.c          |  7 ++---
>  tests/test-qobject-output-visitor.c | 42 ++++++++++++++---------------
>  tests/test-visitor-serialization.c  |  5 +---
>  trace/qmp.c                         | 22 +++++++--------
>  ui/vnc.c                            | 21 +++++----------
>  util/qemu-config.c                  | 14 +++-------
>  target/ppc/translate_init.c.inc     | 12 ++-------

ppc parts
Acked-by: David Gibson <david@gibson.dropbear.id.au>

>  28 files changed, 119 insertions(+), 246 deletions(-)
>=20
> diff --git a/docs/devel/writing-qmp-commands.txt b/docs/devel/writing-qmp=
-commands.txt
> index 46a6c48683f5..3e11eeaa1893 100644
> --- a/docs/devel/writing-qmp-commands.txt
> +++ b/docs/devel/writing-qmp-commands.txt
> @@ -531,15 +531,10 @@ TimerAlarmMethodList *qmp_query_alarm_methods(Error=
 **errp)
>      bool current =3D true;
>=20
>      for (p =3D alarm_timers; p->name; p++) {
> -        TimerAlarmMethodList *info =3D g_malloc0(sizeof(*info));
> -        info->value =3D g_malloc0(sizeof(*info->value));
> -        info->value->method_name =3D g_strdup(p->name);
> -        info->value->current =3D current;
> -
> -        current =3D false;
> -
> -        info->next =3D method_list;
> -        method_list =3D info;
> +	TimerAlarmMethod *value =3D g_new0(TimerAlarmMethod, 1);
> +        value->method_name =3D g_strdup(p->name);
> +        value->current =3D current;
> +        QAPI_LIST_ADD(method_list, value);
>      }
>=20
>      return method_list;
> diff --git a/hw/net/rocker/rocker_fp.h b/hw/net/rocker/rocker_fp.h
> index dbe1dd329a4b..4cb0bb9ccf81 100644
> --- a/hw/net/rocker/rocker_fp.h
> +++ b/hw/net/rocker/rocker_fp.h
> @@ -28,7 +28,7 @@ int fp_port_eg(FpPort *port, const struct iovec *iov, i=
nt iovcnt);
>=20
>  char *fp_port_get_name(FpPort *port);
>  bool fp_port_get_link_up(FpPort *port);
> -void fp_port_get_info(FpPort *port, RockerPortList *info);
> +void fp_port_get_info(FpPort *port, RockerPort *info);
>  void fp_port_get_macaddr(FpPort *port, MACAddr *macaddr);
>  void fp_port_set_macaddr(FpPort *port, MACAddr *macaddr);
>  uint8_t fp_port_get_learning(FpPort *port);
> diff --git a/block/gluster.c b/block/gluster.c
> index 4f1448e2bc88..cf446c23f85d 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -359,8 +359,8 @@ static int qemu_gluster_parse_uri(BlockdevOptionsGlus=
ter *gconf,
>          return -EINVAL;
>      }
>=20
> -    gconf->server =3D g_new0(SocketAddressList, 1);
> -    gconf->server->value =3D gsconf =3D g_new0(SocketAddress, 1);
> +    gsconf =3D g_new0(SocketAddress, 1);
> +    QAPI_LIST_ADD(gconf->server, gsconf);
>=20
>      /* transport */
>      if (!uri->scheme || !strcmp(uri->scheme, "gluster")) {
> @@ -514,7 +514,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGlu=
ster *gconf,
>  {
>      QemuOpts *opts;
>      SocketAddress *gsconf =3D NULL;
> -    SocketAddressList *curr =3D NULL;
> +    SocketAddressList **curr;
>      QDict *backing_options =3D NULL;
>      Error *local_err =3D NULL;
>      char *str =3D NULL;
> @@ -547,6 +547,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGlu=
ster *gconf,
>      }
>      gconf->path =3D g_strdup(ptr);
>      qemu_opts_del(opts);
> +    curr =3D &gconf->server;
>=20
>      for (i =3D 0; i < num_servers; i++) {
>          str =3D g_strdup_printf(GLUSTER_OPT_SERVER_PATTERN"%d.", i);
> @@ -655,15 +656,9 @@ static int qemu_gluster_parse_json(BlockdevOptionsGl=
uster *gconf,
>              qemu_opts_del(opts);
>          }
>=20
> -        if (gconf->server =3D=3D NULL) {
> -            gconf->server =3D g_new0(SocketAddressList, 1);
> -            gconf->server->value =3D gsconf;
> -            curr =3D gconf->server;
> -        } else {
> -            curr->next =3D g_new0(SocketAddressList, 1);
> -            curr->next->value =3D gsconf;
> -            curr =3D curr->next;
> -        }
> +        *curr =3D g_new0(SocketAddressList, 1);
> +        (*curr)->value =3D gsconf;
> +        curr =3D &(*curr)->next;
>          gsconf =3D NULL;
>=20
>          qobject_unref(backing_options);
> diff --git a/chardev/char.c b/chardev/char.c
> index 78553125d311..8dd7ef4c5935 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -776,15 +776,14 @@ static int qmp_query_chardev_foreach(Object *obj, v=
oid *data)
>  {
>      Chardev *chr =3D CHARDEV(obj);
>      ChardevInfoList **list =3D data;
> -    ChardevInfoList *info =3D g_malloc0(sizeof(*info));
> +    ChardevInfo *value;
>=20
> -    info->value =3D g_malloc0(sizeof(*info->value));
> -    info->value->label =3D g_strdup(chr->label);
> -    info->value->filename =3D g_strdup(chr->filename);
> -    info->value->frontend_open =3D chr->be && chr->be->fe_open;
> +    value =3D g_malloc0(sizeof(*value));
> +    value->label =3D g_strdup(chr->label);
> +    value->filename =3D g_strdup(chr->filename);
> +    value->frontend_open =3D chr->be && chr->be->fe_open;
>=20
> -    info->next =3D *list;
> -    *list =3D info;
> +    QAPI_LIST_ADD(*list, value);
>=20
>      return 0;
>  }
> @@ -803,12 +802,10 @@ static void
>  qmp_prepend_backend(const char *name, void *opaque)
>  {
>      ChardevBackendInfoList **list =3D opaque;
> -    ChardevBackendInfoList *info =3D g_malloc0(sizeof(*info));
> +    ChardevBackendInfo *value =3D g_new0(ChardevBackendInfo, 1);
>=20
> -    info->value =3D g_malloc0(sizeof(*info->value));
> -    info->value->name =3D g_strdup(name);
> -    info->next =3D *list;
> -    *list =3D info;
> +    value->name =3D g_strdup(name);
> +    QAPI_LIST_ADD(*list, value);
>  }
>=20
>  ChardevBackendInfoList *qmp_query_chardev_backends(Error **errp)
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index c5e0e79e6dbc..a05c4739ca7a 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -492,11 +492,7 @@ static void machine_set_nvdimm_persistence(Object *o=
bj, const char *value,
>=20
>  void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const char=
 *type)
>  {
> -    strList *item =3D g_new0(strList, 1);
> -
> -    item->value =3D g_strdup(type);
> -    item->next =3D mc->allowed_dynamic_sysbus_devices;
> -    mc->allowed_dynamic_sysbus_devices =3D item;
> +    QAPI_LIST_ADD(mc->allowed_dynamic_sysbus_devices, g_strdup(type));
>  }
>=20
>  static void validate_sysbus_device(SysBusDevice *sbdev, void *opaque)
> diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
> index 1af1e6fa2f9b..a1137e11ff48 100644
> --- a/hw/net/rocker/rocker.c
> +++ b/hw/net/rocker/rocker.c
> @@ -127,13 +127,11 @@ RockerPortList *qmp_query_rocker_ports(const char *=
name, Error **errp)
>      }
>=20
>      for (i =3D r->fp_ports - 1; i >=3D 0; i--) {
> -        RockerPortList *info =3D g_malloc0(sizeof(*info));
> -        info->value =3D g_malloc0(sizeof(*info->value));
> +        RockerPort *value =3D g_malloc0(sizeof(*value));
>          struct fp_port *port =3D r->fp_port[i];
>=20
> -        fp_port_get_info(port, info);
> -        info->next =3D list;
> -        list =3D info;
> +        fp_port_get_info(port, value);
> +        QAPI_LIST_ADD(list, value);
>      }
>=20
>      return list;
> diff --git a/hw/net/rocker/rocker_fp.c b/hw/net/rocker/rocker_fp.c
> index 4aa7da79b81d..a616e709292e 100644
> --- a/hw/net/rocker/rocker_fp.c
> +++ b/hw/net/rocker/rocker_fp.c
> @@ -51,14 +51,14 @@ bool fp_port_get_link_up(FpPort *port)
>      return !qemu_get_queue(port->nic)->link_down;
>  }
>=20
> -void fp_port_get_info(FpPort *port, RockerPortList *info)
> +void fp_port_get_info(FpPort *port, RockerPort *value)
>  {
> -    info->value->name =3D g_strdup(port->name);
> -    info->value->enabled =3D port->enabled;
> -    info->value->link_up =3D fp_port_get_link_up(port);
> -    info->value->speed =3D port->speed;
> -    info->value->duplex =3D port->duplex;
> -    info->value->autoneg =3D port->autoneg;
> +    value->name =3D g_strdup(port->name);
> +    value->enabled =3D port->enabled;
> +    value->link_up =3D fp_port_get_link_up(port);
> +    value->speed =3D port->speed;
> +    value->duplex =3D port->duplex;
> +    value->autoneg =3D port->autoneg;
>  }
>=20
>  void fp_port_get_macaddr(FpPort *port, MACAddr *macaddr)
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 277289d56e76..6b13d3ca3c8f 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -437,17 +437,14 @@ static void rxfilter_notify(NetClientState *nc)
>=20
>  static intList *get_vlan_table(VirtIONet *n)
>  {
> -    intList *list, *entry;
> +    intList *list;
>      int i, j;
>=20
>      list =3D NULL;
>      for (i =3D 0; i < MAX_VLAN >> 5; i++) {
>          for (j =3D 0; n->vlans[i] && j <=3D 0x1f; j++) {
>              if (n->vlans[i] & (1U << j)) {
> -                entry =3D g_malloc0(sizeof(*entry));
> -                entry->value =3D (i << 5) + j;
> -                entry->next =3D list;
> -                list =3D entry;
> +                QAPI_LIST_ADD(list, (i << 5) + j);
>              }
>          }
>      }
> @@ -460,7 +457,7 @@ static RxFilterInfo *virtio_net_query_rxfilter(NetCli=
entState *nc)
>      VirtIONet *n =3D qemu_get_nic_opaque(nc);
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
>      RxFilterInfo *info;
> -    strList *str_list, *entry;
> +    strList *str_list;
>      int i;
>=20
>      info =3D g_malloc0(sizeof(*info));
> @@ -491,19 +488,15 @@ static RxFilterInfo *virtio_net_query_rxfilter(NetC=
lientState *nc)
>=20
>      str_list =3D NULL;
>      for (i =3D 0; i < n->mac_table.first_multi; i++) {
> -        entry =3D g_malloc0(sizeof(*entry));
> -        entry->value =3D qemu_mac_strdup_printf(n->mac_table.macs + i * =
ETH_ALEN);
> -        entry->next =3D str_list;
> -        str_list =3D entry;
> +        QAPI_LIST_ADD(str_list,
> +                      qemu_mac_strdup_printf(n->mac_table.macs + i * ETH=
_ALEN));
>      }
>      info->unicast_table =3D str_list;
>=20
>      str_list =3D NULL;
>      for (i =3D n->mac_table.first_multi; i < n->mac_table.in_use; i++) {
> -        entry =3D g_malloc0(sizeof(*entry));
> -        entry->value =3D qemu_mac_strdup_printf(n->mac_table.macs + i * =
ETH_ALEN);
> -        entry->next =3D str_list;
> -        str_list =3D entry;
> +        QAPI_LIST_ADD(str_list,
> +                      qemu_mac_strdup_printf(n->mac_table.macs + i * ETH=
_ALEN));
>      }
>      info->multicast_table =3D str_list;
>      info->vlan_table =3D get_vlan_table(n);
> diff --git a/migration/migration.c b/migration/migration.c
> index deb6005b8d37..239a7e430214 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -368,12 +368,9 @@ int migration_incoming_enable_colo(void)
>  void migrate_add_address(SocketAddress *address)
>  {
>      MigrationIncomingState *mis =3D migration_incoming_get_current();
> -    SocketAddressList *addrs;
>=20
> -    addrs =3D g_new0(SocketAddressList, 1);
> -    addrs->next =3D mis->socket_address_list;
> -    mis->socket_address_list =3D addrs;
> -    addrs->value =3D QAPI_CLONE(SocketAddress, address);
> +    QAPI_LIST_ADD(mis->socket_address_list,
> +                  QAPI_CLONE(SocketAddress, address));
>  }
>=20
>  void qemu_start_incoming_migration(const char *uri, Error **errp)
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 0a2f88a87d06..18ac7e06c581 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -145,14 +145,11 @@ static struct PostcopyBlocktimeContext *blocktime_c=
ontext_new(void)
>  static uint32List *get_vcpu_blocktime_list(PostcopyBlocktimeContext *ctx)
>  {
>      MachineState *ms =3D MACHINE(qdev_get_machine());
> -    uint32List *list =3D NULL, *entry =3D NULL;
> +    uint32List *list =3D NULL;
>      int i;
>=20
>      for (i =3D ms->smp.cpus - 1; i >=3D 0; i--) {
> -        entry =3D g_new0(uint32List, 1);
> -        entry->value =3D ctx->vcpu_blocktime[i];
> -        entry->next =3D list;
> -        list =3D entry;
> +        QAPI_LIST_ADD(list, ctx->vcpu_blocktime[i]);
>      }
>=20
>      return list;
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 9789f4277f50..629c3d1bf741 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -1248,7 +1248,8 @@ void hmp_migrate_set_capability(Monitor *mon, const=
 QDict *qdict)
>      const char *cap =3D qdict_get_str(qdict, "capability");
>      bool state =3D qdict_get_bool(qdict, "state");
>      Error *err =3D NULL;
> -    MigrationCapabilityStatusList *caps =3D g_malloc0(sizeof(*caps));
> +    MigrationCapabilityStatusList *caps =3D NULL;
> +    MigrationCapabilityStatus *value =3D NULL;
>      int val;
>=20
>      val =3D qapi_enum_parse(&MigrationCapability_lookup, cap, -1, &err);
> @@ -1256,10 +1257,10 @@ void hmp_migrate_set_capability(Monitor *mon, con=
st QDict *qdict)
>          goto end;
>      }
>=20
> -    caps->value =3D g_malloc0(sizeof(*caps->value));
> -    caps->value->capability =3D val;
> -    caps->value->state =3D state;
> -    caps->next =3D NULL;
> +    value =3D g_malloc0(sizeof(*value));
> +    value->capability =3D val;
> +    value->state =3D state;
> +    QAPI_LIST_ADD(caps, value);
>      qmp_migrate_set_capabilities(caps, &err);
>=20
>  end:
> diff --git a/qemu-img.c b/qemu-img.c
> index 2103507936ea..4cfa8bccc5e7 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1643,14 +1643,13 @@ static void do_dirty_bitmap_merge(const char *dst=
_node, const char *dst_name,
>                                    Error **errp)
>  {
>      BlockDirtyBitmapMergeSource *merge_src;
> -    BlockDirtyBitmapMergeSourceList *list;
> +    BlockDirtyBitmapMergeSourceList *list =3D NULL;
>=20
>      merge_src =3D g_new0(BlockDirtyBitmapMergeSource, 1);
>      merge_src->type =3D QTYPE_QDICT;
>      merge_src->u.external.node =3D g_strdup(src_node);
>      merge_src->u.external.name =3D g_strdup(src_name);
> -    list =3D g_new0(BlockDirtyBitmapMergeSourceList, 1);
> -    list->value =3D merge_src;
> +    QAPI_LIST_ADD(list, merge_src);
>      qmp_block_dirty_bitmap_merge(dst_node, dst_name, list, errp);
>      qapi_free_BlockDirtyBitmapMergeSourceList(list);
>  }
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 3bffee99d4c9..06540425ded2 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1211,7 +1211,7 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error=
 **errp)
>  {
>      FsMountList mounts;
>      struct FsMount *mount;
> -    GuestFilesystemInfoList *new, *ret =3D NULL;
> +    GuestFilesystemInfoList *ret =3D NULL;
>      Error *local_err =3D NULL;
>=20
>      QTAILQ_INIT(&mounts);
> @@ -1224,10 +1224,7 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Erro=
r **errp)
>      QTAILQ_FOREACH(mount, &mounts, next) {
>          g_debug("Building guest fsinfo for '%s'", mount->dirname);
>=20
> -        new =3D g_malloc0(sizeof(*ret));
> -        new->value =3D build_guest_fsinfo(mount, &local_err);
> -        new->next =3D ret;
> -        ret =3D new;
> +        QAPI_LIST_ADD(ret, build_guest_fsinfo(mount, &local_err));
>          if (local_err) {
>              error_propagate(errp, local_err);
>              qapi_free_GuestFilesystemInfoList(ret);
> @@ -1493,7 +1490,6 @@ GuestFilesystemTrimResponse *
>  qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
>  {
>      GuestFilesystemTrimResponse *response;
> -    GuestFilesystemTrimResultList *list;
>      GuestFilesystemTrimResult *result;
>      int ret =3D 0;
>      FsMountList mounts;
> @@ -1517,10 +1513,7 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum=
, Error **errp)
>          result =3D g_malloc0(sizeof(*result));
>          result->path =3D g_strdup(mount->dirname);
>=20
> -        list =3D g_malloc0(sizeof(*list));
> -        list->value =3D result;
> -        list->next =3D response->paths;
> -        response->paths =3D list;
> +        QAPI_LIST_ADD(response->paths, result);
>=20
>          fd =3D qemu_open_old(mount->dirname, O_RDONLY);
>          if (fd =3D=3D -1) {
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 0c3c05484f5f..cc5736c3bba8 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -926,10 +926,8 @@ static GuestDiskAddressList *build_guest_disk_info(c=
har *guid, Error **errp)
>                  error_free(local_err);
>                  goto out;
>              }
> -            list =3D g_malloc0(sizeof(*list));
> -            list->value =3D disk;
> +            QAPI_LIST_ADD(list, disk);
>              disk =3D NULL;
> -            list->next =3D NULL;
>              goto out;
>          } else {
>              error_setg_win32(errp, GetLastError(),
> @@ -1064,7 +1062,7 @@ free:
>  GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
>  {
>      HANDLE vol_h;
> -    GuestFilesystemInfoList *new, *ret =3D NULL;
> +    GuestFilesystemInfoList *ret =3D NULL;
>      char guid[256];
>=20
>      vol_h =3D FindFirstVolume(guid, sizeof(guid));
> @@ -1082,10 +1080,7 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Erro=
r **errp)
>              error_free(local_err);
>              continue;
>          }
> -        new =3D g_malloc(sizeof(*ret));
> -        new->value =3D info;
> -        new->next =3D ret;
> -        ret =3D new;
> +        QAPI_LIST_ADD(ret, info);
>      } while (FindNextVolume(vol_h, guid, sizeof(guid)));
>=20
>      if (GetLastError() !=3D ERROR_NO_MORE_FILES) {
> @@ -1268,11 +1263,7 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum=
, Error **errp)
>=20
>          res->path =3D path;
>=20
> -        list =3D g_new0(GuestFilesystemTrimResultList, 1);
> -        list->value =3D res;
> -        list->next =3D resp->paths;
> -
> -        resp->paths =3D list;
> +        QAPI_LIST_ADD(resp->paths, res);
>=20
>          memset(argv, 0, sizeof(argv));
>          argv[0] =3D (gchar *)"defrag.exe";
> diff --git a/qga/commands.c b/qga/commands.c
> index 3dcd5fbe5c4d..27118df6caea 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -66,17 +66,13 @@ static void qmp_command_info(const QmpCommand *cmd, v=
oid *opaque)
>  {
>      GuestAgentInfo *info =3D opaque;
>      GuestAgentCommandInfo *cmd_info;
> -    GuestAgentCommandInfoList *cmd_info_list;
>=20
>      cmd_info =3D g_new0(GuestAgentCommandInfo, 1);
>      cmd_info->name =3D g_strdup(qmp_command_name(cmd));
>      cmd_info->enabled =3D qmp_command_is_enabled(cmd);
>      cmd_info->success_response =3D qmp_has_success_response(cmd);
>=20
> -    cmd_info_list =3D g_new0(GuestAgentCommandInfoList, 1);
> -    cmd_info_list->value =3D cmd_info;
> -    cmd_info_list->next =3D info->supported_commands;
> -    info->supported_commands =3D cmd_info_list;
> +    QAPI_LIST_ADD(info->supported_commands, cmd_info);
>  }
>=20
>  struct GuestAgentInfo *qmp_guest_info(Error **errp)
> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> index 310ab2d0481d..5ac9272ffeea 100644
> --- a/qom/qom-qmp-cmds.c
> +++ b/qom/qom-qmp-cmds.c
> @@ -46,14 +46,12 @@ ObjectPropertyInfoList *qmp_qom_list(const char *path=
, Error **errp)
>=20
>      object_property_iter_init(&iter, obj);
>      while ((prop =3D object_property_iter_next(&iter))) {
> -        ObjectPropertyInfoList *entry =3D g_malloc0(sizeof(*entry));
> +        ObjectPropertyInfo *value =3D g_malloc0(sizeof(ObjectPropertyInf=
o));
>=20
> -        entry->value =3D g_malloc0(sizeof(ObjectPropertyInfo));
> -        entry->next =3D props;
> -        props =3D entry;
> +        QAPI_LIST_ADD(props, value);
>=20
> -        entry->value->name =3D g_strdup(prop->name);
> -        entry->value->type =3D g_strdup(prop->type);
> +        value->name =3D g_strdup(prop->name);
> +        value->type =3D g_strdup(prop->type);
>      }
>=20
>      return props;
> @@ -90,7 +88,7 @@ QObject *qmp_qom_get(const char *path, const char *prop=
erty, Error **errp)
>=20
>  static void qom_list_types_tramp(ObjectClass *klass, void *data)
>  {
> -    ObjectTypeInfoList *e, **pret =3D data;
> +    ObjectTypeInfoList **pret =3D data;
>      ObjectTypeInfo *info;
>      ObjectClass *parent =3D object_class_get_parent(klass);
>=20
> @@ -102,10 +100,7 @@ static void qom_list_types_tramp(ObjectClass *klass,=
 void *data)
>          info->parent =3D g_strdup(object_class_get_name(parent));
>      }
>=20
> -    e =3D g_malloc0(sizeof(*e));
> -    e->value =3D info;
> -    e->next =3D *pret;
> -    *pret =3D e;
> +    QAPI_LIST_ADD(*pret, info);
>  }
>=20
>  ObjectTypeInfoList *qmp_qom_list_types(bool has_implements,
> @@ -155,7 +150,6 @@ ObjectPropertyInfoList *qmp_device_list_properties(co=
nst char *typename,
>      object_property_iter_init(&iter, obj);
>      while ((prop =3D object_property_iter_next(&iter))) {
>          ObjectPropertyInfo *info;
> -        ObjectPropertyInfoList *entry;
>=20
>          /* Skip Object and DeviceState properties */
>          if (strcmp(prop->name, "type") =3D=3D 0 ||
> @@ -181,10 +175,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(c=
onst char *typename,
>          info->default_value =3D qobject_ref(prop->defval);
>          info->has_default_value =3D !!info->default_value;
>=20
> -        entry =3D g_malloc0(sizeof(*entry));
> -        entry->value =3D info;
> -        entry->next =3D prop_list;
> -        prop_list =3D entry;
> +        QAPI_LIST_ADD(prop_list, info);
>      }
>=20
>      object_unref(obj);
> @@ -222,7 +213,6 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const=
 char *typename,
>      }
>      while ((prop =3D object_property_iter_next(&iter))) {
>          ObjectPropertyInfo *info;
> -        ObjectPropertyInfoList *entry;
>=20
>          info =3D g_malloc0(sizeof(*info));
>          info->name =3D g_strdup(prop->name);
> @@ -230,10 +220,7 @@ ObjectPropertyInfoList *qmp_qom_list_properties(cons=
t char *typename,
>          info->has_description =3D !!prop->description;
>          info->description =3D g_strdup(prop->description);
>=20
> -        entry =3D g_malloc0(sizeof(*entry));
> -        entry->value =3D info;
> -        entry->next =3D prop_list;
> -        prop_list =3D entry;
> +        QAPI_LIST_ADD(prop_list, info);
>      }
>=20
>      object_unref(obj);
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 97bb6b8c01b4..df150f3c3eeb 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8293,7 +8293,6 @@ static void arm_cpu_add_definition(gpointer data, g=
pointer user_data)
>  {
>      ObjectClass *oc =3D data;
>      CpuDefinitionInfoList **cpu_list =3D user_data;
> -    CpuDefinitionInfoList *entry;
>      CpuDefinitionInfo *info;
>      const char *typename;
>=20
> @@ -8303,10 +8302,7 @@ static void arm_cpu_add_definition(gpointer data, =
gpointer user_data)
>                             strlen(typename) - strlen("-" TYPE_ARM_CPU));
>      info->q_typename =3D g_strdup(typename);
>=20
> -    entry =3D g_malloc0(sizeof(*entry));
> -    entry->value =3D info;
> -    entry->next =3D *cpu_list;
> -    *cpu_list =3D entry;
> +    QAPI_LIST_ADD(*cpu_list, info);
>  }
>=20
>  CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
> diff --git a/target/arm/monitor.c b/target/arm/monitor.c
> index 169d8a64b651..771101656535 100644
> --- a/target/arm/monitor.c
> +++ b/target/arm/monitor.c
> @@ -42,15 +42,6 @@ static GICCapability *gic_cap_new(int version)
>      return cap;
>  }
>=20
> -static GICCapabilityList *gic_cap_list_add(GICCapabilityList *head,
> -                                           GICCapability *cap)
> -{
> -    GICCapabilityList *item =3D g_new0(GICCapabilityList, 1);
> -    item->value =3D cap;
> -    item->next =3D head;
> -    return item;
> -}
> -
>  static inline void gic_cap_kvm_probe(GICCapability *v2, GICCapability *v=
3)
>  {
>  #ifdef CONFIG_KVM
> @@ -84,8 +75,8 @@ GICCapabilityList *qmp_query_gic_capabilities(Error **e=
rrp)
>=20
>      gic_cap_kvm_probe(v2, v3);
>=20
> -    head =3D gic_cap_list_add(head, v2);
> -    head =3D gic_cap_list_add(head, v3);
> +    QAPI_LIST_ADD(head, v2);
> +    QAPI_LIST_ADD(head, v3);
>=20
>      return head;
>  }
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 0d8606958e9e..9ae6661f97e3 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4984,7 +4984,6 @@ static void x86_cpu_definition_entry(gpointer data,=
 gpointer user_data)
>      ObjectClass *oc =3D data;
>      X86CPUClass *cc =3D X86_CPU_CLASS(oc);
>      CpuDefinitionInfoList **cpu_list =3D user_data;
> -    CpuDefinitionInfoList *entry;
>      CpuDefinitionInfo *info;
>=20
>      info =3D g_malloc0(sizeof(*info));
> @@ -5009,10 +5008,7 @@ static void x86_cpu_definition_entry(gpointer data=
, gpointer user_data)
>          info->has_alias_of =3D !!info->alias_of;
>      }
>=20
> -    entry =3D g_malloc0(sizeof(*entry));
> -    entry->value =3D info;
> -    entry->next =3D *cpu_list;
> -    *cpu_list =3D entry;
> +    QAPI_LIST_ADD(*cpu_list, info);
>  }
>=20
>  CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index afd78b1990be..036bacc24b22 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -1502,7 +1502,6 @@ static void mips_cpu_add_definition(gpointer data, =
gpointer user_data)
>  {
>      ObjectClass *oc =3D data;
>      CpuDefinitionInfoList **cpu_list =3D user_data;
> -    CpuDefinitionInfoList *entry;
>      CpuDefinitionInfo *info;
>      const char *typename;
>=20
> @@ -1512,10 +1511,7 @@ static void mips_cpu_add_definition(gpointer data,=
 gpointer user_data)
>                             strlen(typename) - strlen("-" TYPE_MIPS_CPU));
>      info->q_typename =3D g_strdup(typename);
>=20
> -    entry =3D g_malloc0(sizeof(*entry));
> -    entry->value =3D info;
> -    entry->next =3D *cpu_list;
> -    *cpu_list =3D entry;
> +    QAPI_LIST_ADD(*cpu_list, info);
>  }
>=20
>  CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 461e0b8f4a8d..a837ac66c9c8 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -427,7 +427,6 @@ static void create_cpu_model_list(ObjectClass *klass,=
 void *opaque)
>  {
>      struct CpuDefinitionInfoListData *cpu_list_data =3D opaque;
>      CpuDefinitionInfoList **cpu_list =3D &cpu_list_data->list;
> -    CpuDefinitionInfoList *entry;
>      CpuDefinitionInfo *info;
>      char *name =3D g_strdup(object_class_get_name(klass));
>      S390CPUClass *scc =3D S390_CPU_CLASS(klass);
> @@ -454,10 +453,7 @@ static void create_cpu_model_list(ObjectClass *klass=
, void *opaque)
>          object_unref(obj);
>      }
>=20
> -    entry =3D g_new0(CpuDefinitionInfoList, 1);
> -    entry->value =3D info;
> -    entry->next =3D *cpu_list;
> -    *cpu_list =3D entry;
> +    QAPI_LIST_ADD(*cpu_list, info);
>  }
>=20
>  CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
> @@ -624,12 +620,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion=
(CpuModelExpansionType type,
>  static void list_add_feat(const char *name, void *opaque)
>  {
>      strList **last =3D (strList **) opaque;
> -    strList *entry;
>=20
> -    entry =3D g_new0(strList, 1);
> -    entry->value =3D g_strdup(name);
> -    entry->next =3D *last;
> -    *last =3D entry;
> +    QAPI_LIST_ADD(*last, g_strdup(name));
>  }
>=20
>  CpuModelCompareInfo *qmp_query_cpu_model_comparison(CpuModelInfo *infoa,
> diff --git a/tests/test-clone-visitor.c b/tests/test-clone-visitor.c
> index 5e1e8b2f5e8a..03788d355130 100644
> --- a/tests/test-clone-visitor.c
> +++ b/tests/test-clone-visitor.c
> @@ -65,16 +65,13 @@ static void test_clone_alternate(void)
>=20
>  static void test_clone_list_union(void)
>  {
> -    uint8List *src, *dst;
> +    uint8List *src =3D NULL, *dst;
>      uint8List *tmp =3D NULL;
>      int i;
>=20
>      /* Build list in reverse */
>      for (i =3D 10; i; i--) {
> -        src =3D g_new0(uint8List, 1);
> -        src->next =3D tmp;
> -        src->value =3D i;
> -        tmp =3D src;
> +        QAPI_LIST_ADD(src, i);
>      }
>=20
>      dst =3D QAPI_CLONE(uint8List, src);
> diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-out=
put-visitor.c
> index 1c856d9bd20a..95487b139801 100644
> --- a/tests/test-qobject-output-visitor.c
> +++ b/tests/test-qobject-output-visitor.c
> @@ -223,7 +223,8 @@ static void test_visitor_out_list(TestOutputVisitorDa=
ta *data,
>                                    const void *unused)
>  {
>      const char *value_str =3D "list value";
> -    TestStructList *p, *head =3D NULL;
> +    TestStruct *value;
> +    TestStructList *head =3D NULL;
>      const int max_items =3D 10;
>      bool value_bool =3D true;
>      int value_int =3D 10;
> @@ -233,14 +234,12 @@ static void test_visitor_out_list(TestOutputVisitor=
Data *data,
>=20
>      /* Build the list in reverse order... */
>      for (i =3D 0; i < max_items; i++) {
> -        p =3D g_malloc0(sizeof(*p));
> -        p->value =3D g_malloc0(sizeof(*p->value));
> -        p->value->integer =3D value_int + (max_items - i - 1);
> -        p->value->boolean =3D value_bool;
> -        p->value->string =3D g_strdup(value_str);
> +        value =3D g_malloc0(sizeof(*value));
> +        value->integer =3D value_int + (max_items - i - 1);
> +        value->boolean =3D value_bool;
> +        value->string =3D g_strdup(value_str);
>=20
> -        p->next =3D head;
> -        head =3D p;
> +        QAPI_LIST_ADD(head, value);
>      }
>=20
>      visit_type_TestStructList(data->ov, NULL, &head, &error_abort);
> @@ -270,26 +269,25 @@ static void test_visitor_out_list(TestOutputVisitor=
Data *data,
>  static void test_visitor_out_list_qapi_free(TestOutputVisitorData *data,
>                                              const void *unused)
>  {
> -    UserDefTwoList *p, *head =3D NULL;
> +    UserDefTwo *value;
> +    UserDefTwoList *head =3D NULL;
>      const char string[] =3D "foo bar";
>      int i, max_count =3D 1024;
>=20
>      for (i =3D 0; i < max_count; i++) {
> -        p =3D g_malloc0(sizeof(*p));
> -        p->value =3D g_malloc0(sizeof(*p->value));
> +        value =3D g_malloc0(sizeof(*value));
>=20
> -        p->value->string0 =3D g_strdup(string);
> -        p->value->dict1 =3D g_new0(UserDefTwoDict, 1);
> -        p->value->dict1->string1 =3D g_strdup(string);
> -        p->value->dict1->dict2 =3D g_new0(UserDefTwoDictDict, 1);
> -        p->value->dict1->dict2->userdef =3D g_new0(UserDefOne, 1);
> -        p->value->dict1->dict2->userdef->string =3D g_strdup(string);
> -        p->value->dict1->dict2->userdef->integer =3D 42;
> -        p->value->dict1->dict2->string =3D g_strdup(string);
> -        p->value->dict1->has_dict3 =3D false;
> +        value->string0 =3D g_strdup(string);
> +        value->dict1 =3D g_new0(UserDefTwoDict, 1);
> +        value->dict1->string1 =3D g_strdup(string);
> +        value->dict1->dict2 =3D g_new0(UserDefTwoDictDict, 1);
> +        value->dict1->dict2->userdef =3D g_new0(UserDefOne, 1);
> +        value->dict1->dict2->userdef->string =3D g_strdup(string);
> +        value->dict1->dict2->userdef->integer =3D 42;
> +        value->dict1->dict2->string =3D g_strdup(string);
> +        value->dict1->has_dict3 =3D false;
>=20
> -        p->next =3D head;
> -        head =3D p;
> +        QAPI_LIST_ADD(head, value);
>      }
>=20
>      qapi_free_UserDefTwoList(head);
> diff --git a/tests/test-visitor-serialization.c b/tests/test-visitor-seri=
alization.c
> index 1c5a8b94ea87..efbf744fcf25 100644
> --- a/tests/test-visitor-serialization.c
> +++ b/tests/test-visitor-serialization.c
> @@ -704,10 +704,7 @@ static void test_nested_struct_list(gconstpointer op=
aque)
>      int i =3D 0;
>=20
>      for (i =3D 0; i < 8; i++) {
> -        tmp =3D g_new0(UserDefTwoList, 1);
> -        tmp->value =3D nested_struct_create();
> -        tmp->next =3D listp;
> -        listp =3D tmp;
> +        QAPI_LIST_ADD(listp, nested_struct_create());
>      }
>=20
>      ops->serialize(listp, &serialize_data, visit_nested_struct_list,
> diff --git a/trace/qmp.c b/trace/qmp.c
> index 38246e1aa692..8755835edabc 100644
> --- a/trace/qmp.c
> +++ b/trace/qmp.c
> @@ -92,39 +92,37 @@ TraceEventInfoList *qmp_trace_event_get_state(const c=
har *name,
>      /* Get states (all errors checked above) */
>      trace_event_iter_init(&iter, name);
>      while ((ev =3D trace_event_iter_next(&iter)) !=3D NULL) {
> -        TraceEventInfoList *elem;
> +        TraceEventInfo *value;
>          bool is_vcpu =3D trace_event_is_vcpu(ev);
>          if (has_vcpu && !is_vcpu) {
>              continue;
>          }
>=20
> -        elem =3D g_new(TraceEventInfoList, 1);
> -        elem->value =3D g_new(TraceEventInfo, 1);
> -        elem->value->vcpu =3D is_vcpu;
> -        elem->value->name =3D g_strdup(trace_event_get_name(ev));
> +        value =3D g_new(TraceEventInfo, 1);
> +        value->vcpu =3D is_vcpu;
> +        value->name =3D g_strdup(trace_event_get_name(ev));
>=20
>          if (!trace_event_get_state_static(ev)) {
> -            elem->value->state =3D TRACE_EVENT_STATE_UNAVAILABLE;
> +            value->state =3D TRACE_EVENT_STATE_UNAVAILABLE;
>          } else {
>              if (has_vcpu) {
>                  if (is_vcpu) {
>                      if (trace_event_get_vcpu_state_dynamic(cpu, ev)) {
> -                        elem->value->state =3D TRACE_EVENT_STATE_ENABLED;
> +                        value->state =3D TRACE_EVENT_STATE_ENABLED;
>                      } else {
> -                        elem->value->state =3D TRACE_EVENT_STATE_DISABLE=
D;
> +                        value->state =3D TRACE_EVENT_STATE_DISABLED;
>                      }
>                  }
>                  /* else: already skipped above */
>              } else {
>                  if (trace_event_get_state_dynamic(ev)) {
> -                    elem->value->state =3D TRACE_EVENT_STATE_ENABLED;
> +                    value->state =3D TRACE_EVENT_STATE_ENABLED;
>                  } else {
> -                    elem->value->state =3D TRACE_EVENT_STATE_DISABLED;
> +                    value->state =3D TRACE_EVENT_STATE_DISABLED;
>                  }
>              }
>          }
> -        elem->next =3D events;
> -        events =3D elem;
> +        QAPI_LIST_ADD(events, value);
>      }
>=20
>      return events;
> diff --git a/ui/vnc.c b/ui/vnc.c
> index f006aa1afdb2..f39cfc952906 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -365,14 +365,11 @@ static VncDisplay *vnc_display_find(const char *id)
>=20
>  static VncClientInfoList *qmp_query_client_list(VncDisplay *vd)
>  {
> -    VncClientInfoList *cinfo, *prev =3D NULL;
> +    VncClientInfoList *prev =3D NULL;
>      VncState *client;
>=20
>      QTAILQ_FOREACH(client, &vd->clients, next) {
> -        cinfo =3D g_new0(VncClientInfoList, 1);
> -        cinfo->value =3D qmp_query_vnc_client(client);
> -        cinfo->next =3D prev;
> -        prev =3D cinfo;
> +        QAPI_LIST_ADD(prev, qmp_query_vnc_client(client));
>      }
>      return prev;
>  }
> @@ -453,7 +450,6 @@ static VncServerInfo2List *qmp_query_server_entry(QIO=
ChannelSocket *ioc,
>                                                    int subauth,
>                                                    VncServerInfo2List *pr=
ev)
>  {
> -    VncServerInfo2List *list;
>      VncServerInfo2 *info;
>      Error *err =3D NULL;
>      SocketAddress *addr;
> @@ -476,10 +472,8 @@ static VncServerInfo2List *qmp_query_server_entry(QI=
OChannelSocket *ioc,
>      qmp_query_auth(auth, subauth, &info->auth,
>                     &info->vencrypt, &info->has_vencrypt);
>=20
> -    list =3D g_new0(VncServerInfo2List, 1);
> -    list->value =3D info;
> -    list->next =3D prev;
> -    return list;
> +    QAPI_LIST_ADD(prev, info);
> +    return prev;
>  }
>=20
>  static void qmp_query_auth(int auth, int subauth,
> @@ -554,7 +548,7 @@ static void qmp_query_auth(int auth, int subauth,
>=20
>  VncInfo2List *qmp_query_vnc_servers(Error **errp)
>  {
> -    VncInfo2List *item, *prev =3D NULL;
> +    VncInfo2List *prev =3D NULL;
>      VncInfo2 *info;
>      VncDisplay *vd;
>      DeviceState *dev;
> @@ -583,10 +577,7 @@ VncInfo2List *qmp_query_vnc_servers(Error **errp)
>                  vd->ws_subauth, info->server);
>          }
>=20
> -        item =3D g_new0(VncInfo2List, 1);
> -        item->value =3D info;
> -        item->next =3D prev;
> -        prev =3D item;
> +        QAPI_LIST_ADD(prev, info);
>      }
>      return prev;
>  }
> diff --git a/util/qemu-config.c b/util/qemu-config.c
> index 660f47b0050f..495ada45f3df 100644
> --- a/util/qemu-config.c
> +++ b/util/qemu-config.c
> @@ -55,7 +55,7 @@ QemuOpts *qemu_find_opts_singleton(const char *group)
>=20
>  static CommandLineParameterInfoList *query_option_descs(const QemuOptDes=
c *desc)
>  {
> -    CommandLineParameterInfoList *param_list =3D NULL, *entry;
> +    CommandLineParameterInfoList *param_list =3D NULL;
>      CommandLineParameterInfo *info;
>      int i;
>=20
> @@ -87,10 +87,7 @@ static CommandLineParameterInfoList *query_option_desc=
s(const QemuOptDesc *desc)
>              info->q_default =3D g_strdup(desc[i].def_value_str);
>          }
>=20
> -        entry =3D g_malloc0(sizeof(*entry));
> -        entry->value =3D info;
> -        entry->next =3D param_list;
> -        param_list =3D entry;
> +        QAPI_LIST_ADD(param_list, info);
>      }
>=20
>      return param_list;
> @@ -246,7 +243,7 @@ CommandLineOptionInfoList *qmp_query_command_line_opt=
ions(bool has_option,
>                                                            const char *op=
tion,
>                                                            Error **errp)
>  {
> -    CommandLineOptionInfoList *conf_list =3D NULL, *entry;
> +    CommandLineOptionInfoList *conf_list =3D NULL;
>      CommandLineOptionInfo *info;
>      int i;
>=20
> @@ -262,10 +259,7 @@ CommandLineOptionInfoList *qmp_query_command_line_op=
tions(bool has_option,
>                  info->parameters =3D
>                      query_option_descs(vm_config_groups[i]->desc);
>              }
> -            entry =3D g_malloc0(sizeof(*entry));
> -            entry->value =3D info;
> -            entry->next =3D conf_list;
> -            conf_list =3D entry;
> +            QAPI_LIST_ADD(conf_list, info);
>          }
>      }
>=20
> diff --git a/target/ppc/translate_init.c.inc b/target/ppc/translate_init.=
c.inc
> index bb66526280ef..5795d0e5af2c 100644
> --- a/target/ppc/translate_init.c.inc
> +++ b/target/ppc/translate_init.c.inc
> @@ -10621,7 +10621,6 @@ static void ppc_cpu_defs_entry(gpointer data, gpo=
inter user_data)
>      ObjectClass *oc =3D data;
>      CpuDefinitionInfoList **first =3D user_data;
>      const char *typename;
> -    CpuDefinitionInfoList *entry;
>      CpuDefinitionInfo *info;
>=20
>      typename =3D object_class_get_name(oc);
> @@ -10629,10 +10628,7 @@ static void ppc_cpu_defs_entry(gpointer data, gp=
ointer user_data)
>      info->name =3D g_strndup(typename,
>                             strlen(typename) - strlen(POWERPC_CPU_TYPE_SU=
FFIX));
>=20
> -    entry =3D g_malloc0(sizeof(*entry));
> -    entry->value =3D info;
> -    entry->next =3D *first;
> -    *first =3D entry;
> +    QAPI_LIST_ADD(*first, info);
>  }
>=20
>  CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
> @@ -10648,7 +10644,6 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(=
Error **errp)
>      for (i =3D 0; ppc_cpu_aliases[i].alias !=3D NULL; i++) {
>          PowerPCCPUAlias *alias =3D &ppc_cpu_aliases[i];
>          ObjectClass *oc;
> -        CpuDefinitionInfoList *entry;
>          CpuDefinitionInfo *info;
>=20
>          oc =3D ppc_cpu_class_by_name(alias->model);
> @@ -10660,10 +10655,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions=
(Error **errp)
>          info->name =3D g_strdup(alias->alias);
>          info->q_typename =3D g_strdup(object_class_get_name(oc));
>=20
> -        entry =3D g_malloc0(sizeof(*entry));
> -        entry->value =3D info;
> -        entry->next =3D cpu_list;
> -        cpu_list =3D entry;
> +        QAPI_LIST_ADD(cpu_list, info);
>      }
>=20
>      return cpu_list;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+XwLwACgkQbDjKyiDZ
s5ICxhAA3+7rRQGZ4kdkG+lD1qv1RO80+2e1ZiG3w75ynHQY7AXL1XCB5rkjNHaW
nRR55onOBati30wseT4m09Ulnlf18BhkHohmKbhm3CyEf3AsZxM6Mcm1mWUIE5fl
G1W8VoFWqG4F5LtTf2qeCZ/hFxJBDjxvkvKTfkQ/AZ5G4iioCHRwawfpsFRlGnov
8BorBB/W+jK7XNxjyBCFJkYrTTy7WTBWhHnO+JrguIfvUp2SjuRVKq1AFEPSrqNx
jsW3N08TfoQTmab7O75J6mm6C1G3bKLAZgW80sYrYmDiaSxPnTaaKc7YKXgG4Wd9
5+MyhokwSeAKRMle5OATXdjxUAtDWKz83H4WdvZr92RMziY9bY/SpZnE7yabvbjp
bGF0wU5dB2mDnOrluRDign0UQGhWPz4QS14SX1qB6JhI+y0HeF56BjDfzhqRZkld
t8FlE6RkN5a+D9e4izYWMcj3rRMGgOczbMBRGyF6w4T2Vlpm1ouLHoXvmTi2+FGQ
ibeuCaaMzXk3PevAEKkO7sfMegeY19zjSeK3P+2C0oNByOYTWbWbKmNpnKqBB5kz
9leW4u+Ilqe3wxyfxlVsZ9Qi7iMjGE9C3ECRPmmZ+mgo4ucnMeyowL5icWkF22Ne
Gur5TkYARLeYJflWr4JDHwzK9yNjDGhh2Ryl9N/TO+SO3Gywjwo=
=R4J7
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--


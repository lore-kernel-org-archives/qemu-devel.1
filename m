Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D85CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7378A20B7C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z34T5pWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7378A20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRga1-00029P-JL
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 12:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iRgY7-0008U7-NN
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iRgY5-0004ks-4T
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:53:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39192
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iRgY3-0004jh-1d
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572890029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bbV0ACUjwpEFkar9tiExq+Jt76hpcobjW8fekGqNoBY=;
 b=Z34T5pWYXi1Zu3pBEbKe8ngq6iQakTPFsmU0MOGssGX8c4fXKkrczUP1+B3U3Uy/gmPZnS
 tjBZs00evM1OV5BQs9IxRRMf8lKWg8rpcvAKNcz38ZnW324zbca37OSS1gaY3P42BA19BL
 GuC/a4B2CPGoV6KQ1djiP7/DccARoCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-RdCKxKvFO9OiKGhcDvP-UA-1; Mon, 04 Nov 2019 12:53:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72A66107ACC2;
 Mon,  4 Nov 2019 17:53:47 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 268A060874;
 Mon,  4 Nov 2019 17:53:44 +0000 (UTC)
Message-ID: <30a30dc76e52722cca274f7bbc5a16386644f7df.camel@redhat.com>
Subject: Re: [PATCH v2 2/2] nbd: Allow description when creating NBD blockdev
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Date: Mon, 04 Nov 2019 19:53:44 +0200
In-Reply-To: <20191010210018.22000-3-eblake@redhat.com>
References: <20191010210018.22000-1-eblake@redhat.com>
 <20191010210018.22000-3-eblake@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: RdCKxKvFO9OiKGhcDvP-UA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-10-10 at 16:00 -0500, Eric Blake wrote:
> Allow blockdevs to match the feature already present in qemu-nbd -D.
> Enhance iotest 223 to cover it.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qapi/block.json            | 8 +++++---
>  blockdev-nbd.c             | 9 ++++++++-
>  monitor/hmp-cmds.c         | 4 ++--
>  tests/qemu-iotests/223     | 2 +-
>  tests/qemu-iotests/223.out | 1 +
>  5 files changed, 17 insertions(+), 7 deletions(-)
>=20
> diff --git a/qapi/block.json b/qapi/block.json
> index 145c268bb646..a6617b5bd03a 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -250,9 +250,11 @@
>  # @name: Export name. If unspecified, the @device parameter is used as t=
he
>  #        export name. (Since 2.12)
>  #
> +# @description: Free-form description of the export. (Since 4.2)
> +#
>  # @writable: Whether clients should be able to write to the device via t=
he
>  #     NBD connection (default false).
> -
> +#
>  # @bitmap: Also export the dirty bitmap reachable from @device, so the
>  #          NBD client can use NBD_OPT_SET_META_CONTEXT with
>  #          "qemu:dirty-bitmap:NAME" to inspect the bitmap. (since 4.0)
> @@ -263,8 +265,8 @@
>  # Since: 1.3.0
>  ##
>  { 'command': 'nbd-server-add',
> -  'data': {'device': 'str', '*name': 'str', '*writable': 'bool',
> -           '*bitmap': 'str' } }
> +  'data': {'device': 'str', '*name': 'str', '*description': 'str',
> +           '*writable': 'bool', '*bitmap': 'str' } }
>=20
>  ##
>  # @NbdServerRemoveMode:
> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
> index 8c20baa4a4b9..de2f2ff71320 100644
> --- a/blockdev-nbd.c
> +++ b/blockdev-nbd.c
> @@ -144,6 +144,7 @@ void qmp_nbd_server_start(SocketAddressLegacy *addr,
>  }
>=20
>  void qmp_nbd_server_add(const char *device, bool has_name, const char *n=
ame,
> +                        bool has_description, const char *description,
>                          bool has_writable, bool writable,
>                          bool has_bitmap, const char *bitmap, Error **err=
p)
>  {
> @@ -167,6 +168,11 @@ void qmp_nbd_server_add(const char *device, bool has=
_name, const char *name,
>          return;
>      }
>=20
> +    if (has_description && strlen(description) > NBD_MAX_STRING_SIZE) {
> +        error_setg(errp, "description '%s' too long", description);
> +        return;
> +    }
> +
>      if (nbd_export_find(name)) {
>          error_setg(errp, "NBD server already has export named '%s'", nam=
e);
>          return;
> @@ -195,7 +201,8 @@ void qmp_nbd_server_add(const char *device, bool has_=
name, const char *name,
>          writable =3D false;
>      }
>=20
> -    exp =3D nbd_export_new(bs, 0, len, name, NULL, bitmap, !writable, !w=
ritable,
> +    exp =3D nbd_export_new(bs, 0, len, name, description, bitmap,
> +                         !writable, !writable,
>                           NULL, false, on_eject_blk, errp);
>      if (!exp) {
>          goto out;
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index b2551c16d129..574c6321c9d0 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -2352,7 +2352,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict=
 *qdict)
>              continue;
>          }
>=20
> -        qmp_nbd_server_add(info->value->device, false, NULL,
> +        qmp_nbd_server_add(info->value->device, false, NULL, false, NULL=
,
>                             true, writable, false, NULL, &local_err);
>=20
>          if (local_err !=3D NULL) {
> @@ -2374,7 +2374,7 @@ void hmp_nbd_server_add(Monitor *mon, const QDict *=
qdict)
>      bool writable =3D qdict_get_try_bool(qdict, "writable", false);
>      Error *local_err =3D NULL;
>=20
> -    qmp_nbd_server_add(device, !!name, name, true, writable,
> +    qmp_nbd_server_add(device, !!name, name, false, NULL, true, writable=
,
>                         false, NULL, &local_err);
>      hmp_handle_error(mon, &local_err);
>  }
> diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
> index 2ba3d8124b4f..06bdc96be48f 100755
> --- a/tests/qemu-iotests/223
> +++ b/tests/qemu-iotests/223
> @@ -144,7 +144,7 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-a=
dd",
>    "bitmap":"b3"}}' "error" # Missing bitmap
>  _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
>    "arguments":{"device":"n", "name":"n2", "writable":true,
> -  "bitmap":"b2"}}' "return"
> +  "description":"some text", "bitmap":"b2"}}' "return"
>  $QEMU_NBD_PROG -L -k "$TEST_DIR/nbd"
>=20
>  echo
> diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
> index 23b34fcd202e..16d597585b4f 100644
> --- a/tests/qemu-iotests/223.out
> +++ b/tests/qemu-iotests/223.out
> @@ -49,6 +49,7 @@ exports available: 2
>     base:allocation
>     qemu:dirty-bitmap:b
>   export: 'n2'
> +  description: some text
>    size:  4194304
>    flags: 0xced ( flush fua trim zeroes df cache fast-zero )
>    min block: 1

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
=09Maxim Levitsky



Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D72C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9B0206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cuZJ4a7k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9B0206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQrgU-0000km-N9
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jQrfW-0007gE-Bh
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jQrfV-0005nm-2x
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:06:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59465
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jQrfU-0005lc-I6
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587470781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1s3/Ds8XmK4JR0gA/g0XdG3tAFRqlFLKanToM9VHJOw=;
 b=cuZJ4a7kGFrMYxaLVUNq9jXPNZ9oDusuMB3d3z3Y/sp6iry4wxOwbDqx61Yo4Pj/GIrcri
 m5LRtuRExHaJtQjFhcogCPdolLBhMekDIktBZfd9QPvHVRuTJMxEMq0D15/25zAH6HQcJc
 1B1obtH01C/MGUTGlTnf8IYh27HLiL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-8q7FkXvNNNubhNQR2p2nTw-1; Tue, 21 Apr 2020 08:06:17 -0400
X-MC-Unique: 8q7FkXvNNNubhNQR2p2nTw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8EFF140D;
 Tue, 21 Apr 2020 12:06:14 +0000 (UTC)
Received: from work-vm (ovpn-115-8.ams2.redhat.com [10.36.115.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A69910372D5;
 Tue, 21 Apr 2020 12:05:46 +0000 (UTC)
Date: Tue, 21 Apr 2020 13:05:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Subject: Re: [PATCH 5/7] qapi: add filter-node-name to block-stream
Message-ID: <20200421120544.GI3029@work-vm>
References: <1587407806-109784-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1587407806-109784-6-git-send-email-andrey.shinkevich@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <1587407806-109784-6-git-send-email-andrey.shinkevich@virtuozzo.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 04:54:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org, mreitz@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Andrey Shinkevich (andrey.shinkevich@virtuozzo.com) wrote:
> Provide the possibility to pass the 'filter-node-name' parameter to the
> block-stream job as it is done for the commit block job.
>=20
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  block/stream.c            | 5 +++--
>  blockdev.c                | 8 +++++++-
>  include/block/block_int.h | 7 ++++++-
>  monitor/hmp-cmds.c        | 4 ++--
>  qapi/block-core.json      | 6 ++++++
>  5 files changed, 24 insertions(+), 6 deletions(-)
>=20
> diff --git a/block/stream.c b/block/stream.c
> index d8b4bbe..fab7923 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -229,7 +229,9 @@ static const BlockJobDriver stream_job_driver =3D {
>  void stream_start(const char *job_id, BlockDriverState *bs,
>                    BlockDriverState *base, const char *backing_file_str,
>                    int creation_flags, int64_t speed,
> -                  BlockdevOnError on_error, Error **errp)
> +                  BlockdevOnError on_error,
> +                  const char *filter_node_name,
> +                  Error **errp)
>  {
>      StreamBlockJob *s;
>      BlockDriverState *iter;
> @@ -265,7 +267,6 @@ void stream_start(const char *job_id, BlockDriverStat=
e *bs,
>      } else {
>          bdrv_unfreeze_chain(bottom_cow_node, above_base);
>      }
> -
>      /* Prevent concurrent jobs trying to modify the graph structure here=
, we
>       * already have our own plans. Also don't allow resize as the image =
size is
>       * queried only at the job start and then cached. */
> diff --git a/blockdev.c b/blockdev.c
> index 72d28ce..f275a64 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3242,6 +3242,7 @@ void qmp_block_stream(bool has_job_id, const char *=
job_id, const char *device,
>                        bool has_backing_file, const char *backing_file,
>                        bool has_speed, int64_t speed,
>                        bool has_on_error, BlockdevOnError on_error,
> +                      bool has_filter_node_name, const char *filter_node=
_name,
>                        bool has_auto_finalize, bool auto_finalize,
>                        bool has_auto_dismiss, bool auto_dismiss,
>                        Error **errp)
> @@ -3257,6 +3258,10 @@ void qmp_block_stream(bool has_job_id, const char =
*job_id, const char *device,
>          on_error =3D BLOCKDEV_ON_ERROR_REPORT;
>      }
> =20
> +    if (!has_filter_node_name) {
> +        filter_node_name =3D NULL;
> +    }
> +
>      bs =3D bdrv_lookup_bs(device, device, errp);
>      if (!bs) {
>          return;
> @@ -3324,7 +3329,8 @@ void qmp_block_stream(bool has_job_id, const char *=
job_id, const char *device,
>      }
> =20
>      stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
> -                 job_flags, has_speed ? speed : 0, on_error, &local_err)=
;
> +                 job_flags, has_speed ? speed : 0, on_error,
> +                 filter_node_name, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          goto out;
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 993bafc..5ac4891 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -1052,6 +1052,9 @@ int is_windows_drive(const char *filename);
>   *                  See @BlockJobCreateFlags
>   * @speed: The maximum speed, in bytes per second, or 0 for unlimited.
>   * @on_error: The action to take upon error.
> + * @filter_node_name: The node name that should be assigned to the filte=
r
> + * driver that the commit job inserts into the graph above @bs. NULL mea=
ns
> + * that a node name should be autogenerated.
>   * @errp: Error object.
>   *
>   * Start a streaming operation on @bs.  Clusters that are unallocated
> @@ -1064,7 +1067,9 @@ int is_windows_drive(const char *filename);
>  void stream_start(const char *job_id, BlockDriverState *bs,
>                    BlockDriverState *base, const char *backing_file_str,
>                    int creation_flags, int64_t speed,
> -                  BlockdevOnError on_error, Error **errp);
> +                  BlockdevOnError on_error,
> +                  const char *filter_node_name,
> +                  Error **errp);
> =20
>  /**
>   * commit_start:
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 5ca3ebe..0432ac9 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -2044,8 +2044,8 @@ void hmp_block_stream(Monitor *mon, const QDict *qd=
ict)
> =20
>      qmp_block_stream(true, device, device, base !=3D NULL, base, false, =
NULL,
>                       false, NULL, qdict_haskey(qdict, "speed"), speed, t=
rue,
> -                     BLOCKDEV_ON_ERROR_REPORT, false, false, false, fals=
e,
> -                     &error);
> +                     BLOCKDEV_ON_ERROR_REPORT, false, NULL, false, false=
,
> +                     false, false, &error);
> =20
>      hmp_handle_error(mon, &error);

That's moved now into block/monitor/block-hmp-cmds.c
Feel free to add the extra parameter to the HMP side as well!

Dave

>  }
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 3c54717..169f8ea 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2552,6 +2552,11 @@
>  #            'stop' and 'enospc' can only be used if the block device
>  #            supports io-status (see BlockInfo).  Since 1.3.
>  #
> +# @filter-node-name: the node name that should be assigned to the
> +#                    filter driver that the stream job inserts into the =
graph
> +#                    above @device. If this option is not given, a node =
name is
> +#                    autogenerated. (Since: 5.0)
> +#
>  # @auto-finalize: When false, this job will wait in a PENDING state afte=
r it has
>  #                 finished its work, waiting for @block-job-finalize bef=
ore
>  #                 making any block graph changes.
> @@ -2581,6 +2586,7 @@
>    'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
>              '*base-node': 'str', '*backing-file': 'str', '*speed': 'int'=
,
>              '*on-error': 'BlockdevOnError',
> +            '*filter-node-name': 'str',
>              '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
> =20
>  ##
> --=20
> 1.8.3.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



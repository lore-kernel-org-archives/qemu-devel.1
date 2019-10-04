Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B44CC47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 11:14:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2BDA215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 11:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fPPUd9lb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BDA215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGLXK-00010h-1I
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 07:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rkagan@virtuozzo.com>) id 1iGKgD-0006EW-KZ
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 06:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1iGKgB-0001ow-Jl
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 06:19:21 -0400
Received: from mail-bgr052101134063.outbound.protection.outlook.com
 ([52.101.134.63]:34035 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1iGKgA-0001n3-Uj; Fri, 04 Oct 2019 06:19:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3pgMxqO5UNKdXIFU7igrgnEFKOZoz+25mmzOK//9GbSCdVd8VIaspJsqNdIBKBwQGbJ7IKZzlzvgt/ujhYSip/122N/vpPKfPe4MLFKdGWbtEvNXtKIw3a9MxQhrgBqCSt7Ic0SRDAhm//hpZQiiKaHKmHMFWK5U71Dy3R7T5EHdxxCcW5BtrPruVm85SU0fk7dFTd6Vc0ti3U3KmkNdrDXfjnh/XNaIvAgF0JGo21nKZu4Ogn+adKpZn45Fp+jFZ6/kajTQI0MSo8SYkkHgRBzH3i1m4LE256OHs7iOISCtAaw4hDjZyTI+wOevfuhiemxJwtnxLS0mBBDY22fVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGWT9nlC8pbo6uXrFv0cC7HrnuRI5SC4CrvvQGIu+hE=;
 b=X7Gi1iW+isKmRm9KCIY2ssDkWEeCssYm+XWn7Tysy8Hh08MmLqoOF5lfp7owotsuj71y62SlEgJXDjtTIdOc4/4t5Gl8NqrkHCE2tRtf9HDAN0v506k0Al6J5+ziAgv/jt3W+hV3sJgt2Tfe1Un4qraKfpbBS1PUoEb4SVGv4v6xY0LigMD5CL0rL7brEtyj6MsTP9naOmqEiqFOCVD1eGQlBxrkmIc3SwluNYR9zE7xmq1jSt18KZtKSwVA6KyzNLn+UrhPIfW8Jpnc7nU6eKPRdAvHMRQo/hq4x0m4mnFch+INgM5Bmk9xZyVsXg/fciv4vjrwVDW52fKvgN9tSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGWT9nlC8pbo6uXrFv0cC7HrnuRI5SC4CrvvQGIu+hE=;
 b=fPPUd9lbALw9K719um9dMZTwnCPGGXmY1/Q2bQQD/K7A1mm4X3FxCu2ZDVoiNghK7M6qF7ii3IKfu5z3UQmcnUTpQFi63rFZtdagqpW3MWCBrrOrwba2M/JhGU/g43S88yPnF7DmNIynsdD+YOl8Mh3QRZSvVmoNT0DT+nVxB5g=
Received: from AM0PR08MB5537.eurprd08.prod.outlook.com (20.179.36.87) by
 AM0PR08MB5474.eurprd08.prod.outlook.com (52.132.214.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Fri, 4 Oct 2019 10:19:07 +0000
Received: from AM0PR08MB5537.eurprd08.prod.outlook.com
 ([fe80::a8ea:5223:db78:dd3]) by AM0PR08MB5537.eurprd08.prod.outlook.com
 ([fe80::a8ea:5223:db78:dd3%7]) with mapi id 15.20.2305.023; Fri, 4 Oct 2019
 10:19:06 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Subject: Re: [PATCH v2 3/6] qemu-nbd: add compression flag support
Thread-Topic: [PATCH v2 3/6] qemu-nbd: add compression flag support
Thread-Index: AQHVeS0iJ2te2IG9JEWf7vnSeJyp8KdKR/CA
Date: Fri, 4 Oct 2019 10:19:06 +0000
Message-ID: <20191004101903.GA4478@rkaganb.sw.ru>
References: <1570026166-748566-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1570026166-748566-4-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1570026166-748566-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.12.1 (2019-06-15)
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>,	Andrey Shinkevich
 <andrey.shinkevich@virtuozzo.com>,	qemu-devel@nongnu.org,
 qemu-block@nongnu.org, kwolf@redhat.com,	fam@euphon.net,
 vsementsov@virtuozzo.com, jsnow@redhat.com,	armbru@redhat.com,
 dgilbert@redhat.com, stefanha@redhat.com,	den@openvz.org, mreitz@redhat.com
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR0202CA0012.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::22) To AM0PR08MB5537.eurprd08.prod.outlook.com
 (2603:10a6:208:148::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79f515da-ae9b-4cd8-6d10-08d748b449d7
x-ms-traffictypediagnostic: AM0PR08MB5474:|AM0PR08MB5474:|AM0PR08MB5474:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB5474E2FF250AE5A9CF271C5EC99E0@AM0PR08MB5474.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 018093A9B5
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(346002)(366004)(39850400004)(376002)(396003)(136003)(199004)(189003)(54094003)(14444005)(256004)(66066001)(25786009)(316002)(86362001)(54906003)(58126008)(2906002)(3846002)(478600001)(14454004)(6116002)(8936002)(8676002)(81166006)(81156014)(446003)(1076003)(6862004)(66946007)(66476007)(66556008)(64756008)(66446008)(11346002)(486006)(5660300002)(6512007)(6436002)(33656002)(4326008)(26005)(186003)(76176011)(7736002)(305945005)(71200400001)(71190400001)(36756003)(99286004)(52116002)(386003)(6506007)(102836004)(476003)(6246003)(9686003)(229853002)(6486002)(6636002)(30126002);
 DIR:OUT; SFP:1501; SCL:5; SRVR:AM0PR08MB5474;
 H:AM0PR08MB5537.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AUiiZlyg5SiQX37W5x+j5BRBahInmfMzdx2xgrlpE2cLinCmsW/CUwaYSueLV/pYRM+IKh/RgBgoa3V6L+I1JGc8/jFVs/MWG+JZ8G2WqPzdhA2ey8bX0UShpblunPz6ULl5ViDgxEw6JsKrYH53pQQ1te99gBmRNgdGju2r2t83fSmvgmwbopcom/eqIn9fVhpd2GS3OWrPhjpdxo5EB1yX00iuBQzEpYPA5yIWa/DzLv1aXFWztz8Ifctt/bBSAR0QMC+1Aoogrq8gZ2G6EK6RDaHVdD+/hST+Q6kRwk0s2QWiBOxvsgMuyofwJnbIZwj390DDpREJqEzV5mgxk9UQVpeK0CTYjJwFq2n2Av1mlhoiCgv75e9Vhb3HNKLYqX/y21J42ogSSY8WJnn8vyViTup1zhpRNo9KyIhISOEyU7xenmvwMCGNrSFXCEVLPi5y86IhvoyMosGgh/6F1eYZDoyyiNh9a1E0QSbHtYWI9UO29ooam+SYNuMi8cii
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DA2C7CF1B894F441AE7FEB4D19CF1C7F@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f515da-ae9b-4cd8-6d10-08d748b449d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2019 10:19:06.7971 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GmfIhg7MZdBK911OUiXfK1Kb3zlP6Pf6IZZaQs8rN13GKBkoZx0OW2sz525mYvRY/4WyDsU41LuJNXRPYbdUMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5474
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.134.63
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 02, 2019 at 05:22:43PM +0300, Andrey Shinkevich wrote:
> Added possibility to write compressed data by using the
> blk_write_compressed. This action has the limitations of the format
> driver. For example we can't write compressed data over other.
> 
> $ ./qemu-img create -f qcow2 -o size=10G ./image.qcow2
> $ sudo ./qemu-nbd -c /dev/nbd0 ./image.qcow2
> $ sudo dd if=/dev/sda1 of=/dev/nbd0 bs=10M count=10
> 10+0 records in
> 10+0 records out
> 104857600 bytes (105 MB) copied, 0,0890581 s, 1,2 GB/s
> $ sudo ./qemu-nbd -d /dev/nbd0
> $ du -sh ./image.qcow2
> 101M    ./image.qcow2
> 
> $ ./qemu-img create -f qcow2 -o size=10G ./image.qcow2
> $ sudo ./qemu-nbd -C -c /dev/nbd0 ./image.qcow2
> $ sudo dd if=/dev/sda1 of=/dev/nbd0 bs=10M count=10
> 10+0 records in
> 10+0 records out
> 104857600 bytes (105 MB) copied, 0,076046 s, 1,4 GB/s
> $ sudo ./qemu-nbd -d /dev/nbd0
> $ du -sh ./image.qcow2
> 5,3M    ./image.qcow2
> 
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  blockdev-nbd.c      |  8 ++++++--
>  include/block/nbd.h | 11 +++++++++--
>  nbd/server.c        | 14 ++++++++++----
>  qemu-nbd.c          | 30 ++++++++++++++++++++++++++----
>  qemu-nbd.texi       |  2 ++
>  5 files changed, 53 insertions(+), 12 deletions(-)
> 
> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
> index 6a8b206..e83036b 100644
> --- a/blockdev-nbd.c
> +++ b/blockdev-nbd.c
> @@ -151,6 +151,7 @@ void qmp_nbd_server_add(const char *device, bool has_name, const char *name,
>      BlockBackend *on_eject_blk;
>      NBDExport *exp;
>      int64_t len;
> +    uint32_t iflags = 0;
>      AioContext *aio_context;
>  
>      if (!nbd_server) {
> @@ -189,9 +190,12 @@ void qmp_nbd_server_add(const char *device, bool has_name, const char *name,
>      if (bdrv_is_read_only(bs)) {
>          writable = false;
>      }
> +    if (!writable) {
> +        iflags = NBD_INTERNAL_FLAG_READONLY | NBD_INTERNAL_FLAG_SHARED;
> +    }
>  
> -    exp = nbd_export_new(bs, 0, len, name, NULL, bitmap, !writable, !writable,
> -                         NULL, false, on_eject_blk, errp);
> +    exp = nbd_export_new(bs, 0, len, name, NULL, bitmap, iflags, NULL,
> +                         on_eject_blk, errp);
>      if (!exp) {
>          goto out;
>      }
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index 316fd70..80be9d5 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -25,6 +25,13 @@
>  #include "crypto/tlscreds.h"
>  #include "qapi/error.h"
>  
> +enum {
> +    NBD_INTERNAL_FLAG_READONLY     = 1 << 0, /* Device is read-only */
> +    NBD_INTERNAL_FLAG_SHARED       = 1 << 1, /* Device can be shared */
> +    NBD_INTERNAL_FLAG_WRITETHROUGH = 1 << 2, /* Enable write cache */
> +    NBD_INTERNAL_FLAG_COMPRESS     = 1 << 3, /* Use compressed write */
> +};
> +
>  /* Handshake phase structs - this struct is passed on the wire */
>  
>  struct NBDOption {
> @@ -330,8 +337,8 @@ typedef struct NBDClient NBDClient;
>  
>  NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
>                            uint64_t size, const char *name, const char *desc,
> -                          const char *bitmap, bool readonly, bool shared,
> -                          void (*close)(NBDExport *), bool writethrough,
> +                          const char *bitmap, uint32_t iflags,
> +                          void (*close)(NBDExport *),
>                            BlockBackend *on_eject_blk, Error **errp);
>  void nbd_export_close(NBDExport *exp);
>  void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error **errp);
> diff --git a/nbd/server.c b/nbd/server.c
> index d8d1e62..cf3b75d 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -91,6 +91,7 @@ struct NBDExport {
>      uint16_t nbdflags;
>      QTAILQ_HEAD(, NBDClient) clients;
>      QTAILQ_ENTRY(NBDExport) next;
> +    uint32_t iflags;
>  
>      AioContext *ctx;
>  
> @@ -1471,13 +1472,14 @@ static void nbd_eject_notifier(Notifier *n, void *data)
>  
>  NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
>                            uint64_t size, const char *name, const char *desc,
> -                          const char *bitmap, bool readonly, bool shared,
> -                          void (*close)(NBDExport *), bool writethrough,
> +                          const char *bitmap, uint32_t iflags,
> +                          void (*close)(NBDExport *),
>                            BlockBackend *on_eject_blk, Error **errp)
>  {
>      AioContext *ctx;
>      BlockBackend *blk;
>      NBDExport *exp = g_new0(NBDExport, 1);
> +    bool readonly = iflags & NBD_INTERNAL_FLAG_READONLY;
>      uint64_t perm;
>      int ret;
>  
> @@ -1504,7 +1506,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
>      if (ret < 0) {
>          goto fail;
>      }
> -    blk_set_enable_write_cache(blk, !writethrough);
> +    blk_set_enable_write_cache(blk, !(iflags & NBD_INTERNAL_FLAG_WRITETHROUGH));
>      blk_set_allow_aio_context_change(blk, true);
>  
>      exp->refcount = 1;
> @@ -1518,13 +1520,14 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
>                       NBD_FLAG_SEND_FUA | NBD_FLAG_SEND_CACHE);
>      if (readonly) {
>          exp->nbdflags |= NBD_FLAG_READ_ONLY;
> -        if (shared) {
> +        if (iflags & NBD_INTERNAL_FLAG_SHARED) {
>              exp->nbdflags |= NBD_FLAG_CAN_MULTI_CONN;
>          }
>      } else {
>          exp->nbdflags |= (NBD_FLAG_SEND_TRIM | NBD_FLAG_SEND_WRITE_ZEROES |
>                            NBD_FLAG_SEND_FAST_ZERO);
>      }
> +    exp->iflags = iflags;
>      assert(size <= INT64_MAX - dev_offset);
>      exp->size = QEMU_ALIGN_DOWN(size, BDRV_SECTOR_SIZE);
>  
> @@ -2312,6 +2315,9 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>          if (request->flags & NBD_CMD_FLAG_FUA) {
>              flags |= BDRV_REQ_FUA;
>          }
> +        if (exp->iflags & NBD_INTERNAL_FLAG_COMPRESS) {
> +            flags |= BDRV_REQ_WRITE_COMPRESSED;
> +        }
>          ret = blk_pwrite(exp->blk, request->from + exp->dev_offset,
>                           data, request->len, flags);
>          return nbd_send_generic_reply(client, request->handle, ret,
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index 9032b6d..4163135 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -139,6 +139,7 @@ static void usage(const char *name)
>  "      --discard=MODE        set discard mode (ignore, unmap)\n"
>  "      --detect-zeroes=MODE  set detect-zeroes mode (off, on, unmap)\n"
>  "      --image-opts          treat FILE as a full set of image options\n"
> +"  -C, --compress            use data compression (if the target format supports it)\n"
>  "\n"
>  QEMU_HELP_BOTTOM "\n"
>      , name, name, NBD_DEFAULT_PORT, "DEVICE");
> @@ -602,6 +603,7 @@ int main(int argc, char **argv)
>      BlockDriverState *bs;
>      uint64_t dev_offset = 0;
>      bool readonly = false;
> +    uint32_t iflags = 0;
>      bool disconnect = false;
>      const char *bindto = NULL;
>      const char *port = NULL;
> @@ -610,7 +612,7 @@ int main(int argc, char **argv)
>      int64_t fd_size;
>      QemuOpts *sn_opts = NULL;
>      const char *sn_id_or_name = NULL;
> -    const char *sopt = "hVb:o:p:rsnP:c:dvk:e:f:tl:x:T:D:B:L";
> +    const char *sopt = "hVb:o:p:rsnCP:c:dvk:e:f:tl:x:T:D:B:L";
>      struct option lopt[] = {
>          { "help", no_argument, NULL, 'h' },
>          { "version", no_argument, NULL, 'V' },
> @@ -619,6 +621,7 @@ int main(int argc, char **argv)
>          { "socket", required_argument, NULL, 'k' },
>          { "offset", required_argument, NULL, 'o' },
>          { "read-only", no_argument, NULL, 'r' },
> +        { "compress", no_argument, NULL, 'C'},
>          { "partition", required_argument, NULL, 'P' },
>          { "bitmap", required_argument, NULL, 'B' },
>          { "connect", required_argument, NULL, 'c' },
> @@ -786,6 +789,9 @@ int main(int argc, char **argv)
>              readonly = true;
>              flags &= ~BDRV_O_RDWR;
>              break;
> +        case 'C':
> +            iflags |= NBD_INTERNAL_FLAG_COMPRESS;
> +            break;
>          case 'P':
>              warn_report("The '-P' option is deprecated; use --image-opts with "
>                          "a raw device wrapper for subset exports instead");
> @@ -1117,6 +1123,14 @@ int main(int argc, char **argv)
>  
>      blk_set_enable_write_cache(blk, !writethrough);
>  
> +    if ((iflags & NBD_INTERNAL_FLAG_COMPRESS) &&
> +        !(bs->drv && bs->drv->bdrv_co_pwritev_compressed_part))
> +    {
> +        error_report("Compression not supported for this file format %s",
> +                     argv[optind]);
> +        exit(EXIT_FAILURE);
> +    }
> +
>      if (sn_opts) {
>          ret = bdrv_snapshot_load_tmp(bs,
>                                       qemu_opt_get(sn_opts, SNAPSHOT_OPT_ID),
> @@ -1173,10 +1187,18 @@ int main(int argc, char **argv)
>          fd_size = limit;
>      }
>  
> +    if (writethrough) {
> +        iflags |= NBD_INTERNAL_FLAG_WRITETHROUGH;
> +    }
> +    if (readonly) {
> +        iflags |= NBD_INTERNAL_FLAG_READONLY;
> +    }
> +    if (shared > 1) {
> +        iflags |= NBD_INTERNAL_FLAG_SHARED;
> +    }
>      export = nbd_export_new(bs, dev_offset, fd_size, export_name,
> -                            export_description, bitmap, readonly, shared > 1,
> -                            nbd_export_closed, writethrough, NULL,
> -                            &error_fatal);
> +                            export_description, bitmap, iflags,
> +                            nbd_export_closed, NULL, &error_fatal);
>  
>      if (device) {
>  #if HAVE_NBD_DEVICE
> diff --git a/qemu-nbd.texi b/qemu-nbd.texi
> index 7f55657..26ea1ec 100644
> --- a/qemu-nbd.texi
> +++ b/qemu-nbd.texi
> @@ -55,6 +55,8 @@ Force the use of the block driver for format @var{fmt} instead of
>  auto-detecting.
>  @item -r, --read-only
>  Export the disk as read-only.
> +@item -C, --compress
> +Use data compression (if the target format supports it)
>  @item -P, --partition=@var{num}
>  Deprecated: Only expose MBR partition @var{num}.  Understands physical
>  partitions 1-4 and logical partition 5. New code should instead use

I wonder if we're better off adding a generic blockdev option instead,
so that all tools can benefit from it?

Roman.


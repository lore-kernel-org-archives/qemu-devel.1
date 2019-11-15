Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7E6C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B98D320728
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="duJ6mrtJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98D320728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVf5n-0008HU-Uh
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 12:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVf56-0007ki-3O
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVf54-0007mk-5n
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:08:24 -0500
Received: from mail-eopbgr130114.outbound.protection.outlook.com
 ([40.107.13.114]:37081 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVf4y-0007kT-GP; Fri, 15 Nov 2019 12:08:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eF+JgBecZHSBiV7FWDFhrZcj3tYnemE7sOc88WbhM/U857jCv/+QFYRNHy5tlvVr/6YZ09BwKuyW+VqlCYIQIA3AF2SRl9Gq2y8Zu/rvfKJqyiaUCn+Wpj0awovp4gd75IAW7pYfgbGjmEMWzheKFGeIyPZ/ezQUizn+BiDqXuns/z+Ssb0PxwBaobg0dD2ZysSsSD4myGGuRFs+aoCUE3Umm/xyQGkSVcYs7sRxWR2Sfony3Q1adq+dxgW7wo18SDqszq/KIXznRjdh2xcvw6qeM7sQbLN8d5V6DXQNFrHSVlIJdeu+m0RPX5Wp0qXc3K5eDgdJfm/zbj5JhSpxdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbNvp/WguWkQVxDJh4HiT3KtQ+jTrKY5//ypROtYK7g=;
 b=Se4SpWcBp5hbQvHXHk9IAqXb4/vo7uhgE62Ay2fzXottRif9mME2bLEO8Tr16oIb6KvYJc0HpXE+dFierxnBg5Q5qs8zlCvBiOS74lJ9FwWOnnAli/Z3VhkTv2Snwv3kG7yx424CVJoHuhbRPkhOiZCiLhXfQPIrBX7gpDhqQRjYupvILf2XUCwtvGy23W17jjb4A2fqtLBQI7NlaM9vMt+cSQgzYlNP0x1nzo7x/uWB9Hdxcb7h8fnwCfu2Pup5U5CO/0FBxEuMeqj5beP79XYlPTd5C8z+W7sUPTZ8P0utdl3TWlmYJrCwAMN44E8mVP/OLCg10bTOzgSs2BeAZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbNvp/WguWkQVxDJh4HiT3KtQ+jTrKY5//ypROtYK7g=;
 b=duJ6mrtJ4Y4MCFMYVU0YXjqckYHThdvSO0x9mwKHlDLyi38Bo/ldnubwM+Zc0Gx0EFFZatKXKxjFeEv41gwJOCvWVUtYyjXyfirpM0SyUA+Us3L8zKuiCyLdj9laOVHixV6KN/pRWkYp20qMhj2ZRf1DV2cCxUjTwQu06aV6nlQ=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3749.eurprd08.prod.outlook.com (20.178.91.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Fri, 15 Nov 2019 17:08:13 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.029; Fri, 15 Nov 2019
 17:08:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 3/4] nbd: Don't send oversize strings
Thread-Topic: [PATCH v3 3/4] nbd: Don't send oversize strings
Thread-Index: AQHVmpXEwzpiEJLLE0enpXE3MhZGqqeMeVmA
Date: Fri, 15 Nov 2019 17:08:13 +0000
Message-ID: <d9106b80-ee4c-ef0c-0e53-ef4e9ab9c906@virtuozzo.com>
References: <20191114024635.11363-1-eblake@redhat.com>
 <20191114024635.11363-4-eblake@redhat.com>
In-Reply-To: <20191114024635.11363-4-eblake@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0037.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::47) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191115200811059
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc3f37a1-1303-497a-00c1-08d769ee6634
x-ms-traffictypediagnostic: AM6PR08MB3749:
x-microsoft-antispam-prvs: <AM6PR08MB37498B52F6C1F7F2C84A3889C1700@AM6PR08MB3749.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(366004)(136003)(376002)(396003)(346002)(199004)(189003)(86362001)(71200400001)(71190400001)(66066001)(8936002)(386003)(66446008)(64756008)(66556008)(31686004)(81156014)(81166006)(8676002)(186003)(102836004)(2616005)(30864003)(54906003)(5660300002)(11346002)(446003)(305945005)(486006)(476003)(7736002)(52116002)(66476007)(110136005)(26005)(316002)(66946007)(6506007)(99286004)(4326008)(6436002)(478600001)(2501003)(31696002)(76176011)(36756003)(14444005)(256004)(2906002)(229853002)(6486002)(6246003)(6512007)(6116002)(3846002)(25786009)(14454004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3749;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QkO0ydEcMbJ6oORYcus9kl+z0cZZjFe/fyANTYI+wpFWO7+6ytp+ZFoaR0qseAipJgcUj498luffoiizDM46r8aib2xASa6Z0/AP3yMpm/mkN9SLMrFSpxdhF8eiQWE6KKSH9WNSYlMdAJUI7zLLMtSpaMHfUZj9nz4qDd5vhh1AZQZRAWmIqO2gwAAIQP08iLoe9BIRonh2joWNP7CwKPB+/SQvnOX78iRe6Bo6ypLkx345g1rKB211XzylFB6z8isVUIp1hyyc/Yj+hHUjMWPQmvINKQi6Aho4WuvHbs5gBwEQIfyHZOpnspz3+gmdLGOkD+dbrM39F0mk4r8nQQaBzH/82j5MhJC/f3u3Dnhsq/cUqvBvqP4tKn+QGtBW0ajdBPztbrf91oPrJeeWS5DX5XthMuQqWjamYYy/pxO2Z6thxmTh6/IleEuqaYXs
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <E5C4651549936048BC4B610364DE214F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3f37a1-1303-497a-00c1-08d769ee6634
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 17:08:13.5180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E1pr3C+kF3VCzVLWQVzpD9ExHx6mKyBpk6AayCqQkWJti2k2G/TZJOc9cyrTeoCWgTeC50UUMd9eSExebxBK+WrSDH/YpaA8mrMZb6lMzVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3749
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.114
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.11.2019 5:46, Eric Blake wrote:
> Qemu as server currently won't accept export names larger than 256
> bytes, nor create dirty bitmap names longer than 1023 bytes, so most
> uses of qemu as client or server have no reason to get anywhere near
> the NBD spec maximum of a 4k limit per string.
>=20
> However, we weren't actually enforcing things, ignoring when the
> remote side violates the protocol on input, and also having several
> code paths where we send oversize strings on output (for example,
> qemu-nbd --description could easily send more than 4k).  Tighten
> things up as follows:
>=20
> client:
> - Perform bounds check on export name and dirty bitmap request prior
>    to handing it to server
> - Validate that copied server replies are not too long (ignoring
>    NBD_INFO_* replies that are not copied is not too bad)
> server:
> - Perform bounds check on export name and description prior to
>    advertising it to client
> - Reject client name or metadata query that is too long
> - Adjust things to allow full 4k name limit rather than previous
>    256 byte limit
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Still, same doubt about putting over-sized strings into error messages. If =
you
decide to drop them, keep my r-b.

=3D=3D=3D=3D=3D=3D

Not very simple to review, as I need to check that all assertions will not =
fire.
Hope you don't mind me doing it here)

1.
nbd_send_meta_query checks export and query

    nbd_negotiate_simple_meta_context ^ info->name, info->x_dirty_bitmap/"b=
ase:allocation"

       nbd_receive_negotiate ^ info=3Dinfo
           (info->name proved by assert)

          nbd_client_connect ^ info=3Ds->info                              =
                          OK
              (s->info.x_dirty_bitmap =3D g_strdup(s->x_dirty_bitmap);
               s->info.name =3D g_strdup(s->export ?: "");
               s->export is set only in nbd_process_options() and checked i=
n it
               s->x_dirty_bitmap too)

          nbd_client_thread & info=3D local info, with name =3D "" and x_di=
rty_bitmap =3D NULL           OK


    nbd_list_meta_contexts ^ info->name, NULL/"qemu:"

       nbd_receive_export_list ^ info=3D&array[i]
           (array[count - 1].name =3D name;, name comes from nbd_receive_li=
st, where it is checked)  OK

2.
nbd_receive_negotiate check info->name
     (see 1.)

3.
nbd_negotiate_send_rep_list check exp->name and exp->description

    nbd_negotiate_handle_list                                              =
                        OK
        (does QTAILQ_FOREACH(exp, &exports, next)
         new exports comes from nbd_export_new() which checks name and desc=
 (by assertions))

4.
nbd_negotiate_handle_info checks exp->description                          =
                       OK
     (exp comes from nbd_export_find(name), from global exports, so it's OK=
)


5.
nbd_negotiate_send_meta_context checks  context

     nbd_negotiate_meta_queries ^ context =3D "base:allocation"/meta->exp->=
export_bitmap_context     OK
     (meta is filled inside the function, meta->exp =3D nbd_export_find(exp=
ort_name),

     and export_bitmap_context is set and asserted in  nbd_export_new

6.
nbd_export_new checks name and desc and bitmap (export_bitmap_context is ob=
vious)
     bitmap is found before assertion (which proves that name is shorter th=
an 1024)

     qmp_nbd_server_add ^ name NULL bitmap                                 =
                        OK
         name is checked

     main in qemu-nbd.c ^ export_name export_description bitmap            =
                        OK
         both export_name and export_description are checked.

> ---
>   include/block/nbd.h |  8 ++++----
>   block/nbd.c         | 10 ++++++++++
>   blockdev-nbd.c      |  5 +++++
>   nbd/client.c        | 18 +++++++++++++++---
>   nbd/server.c        | 20 +++++++++++++++-----
>   qemu-nbd.c          |  9 +++++++++
>   6 files changed, 58 insertions(+), 12 deletions(-)
>=20
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index c306423dc85c..7f46932d80f1 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -227,11 +227,11 @@ enum {
>   #define NBD_MAX_BUFFER_SIZE (32 * 1024 * 1024)
>=20
>   /*
> - * Maximum size of an export name. The NBD spec requires a minimum of
> - * 256 and recommends that servers support up to 4096; all users use
> - * malloc so we can bump this constant without worry.
> + * Maximum size of a protocol string (export name, meta context name,
> + * etc.).  Use malloc rather than stack allocation for storage of a
> + * string.
>    */
> -#define NBD_MAX_NAME_SIZE 256
> +#define NBD_MAX_STRING_SIZE 4096
>=20
>   /* Two types of reply structures */
>   #define NBD_SIMPLE_REPLY_MAGIC      0x67446698
> diff --git a/block/nbd.c b/block/nbd.c
> index 123976171cf4..5f18f78a9471 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -1832,6 +1832,10 @@ static int nbd_process_options(BlockDriverState *b=
s, QDict *options,
>       }
>=20
>       s->export =3D g_strdup(qemu_opt_get(opts, "export"));
> +    if (s->export && strlen(s->export) > NBD_MAX_STRING_SIZE) {
> +        error_setg(errp, "export name too long to send to server");
> +        goto error;
> +    }
>=20
>       s->tlscredsid =3D g_strdup(qemu_opt_get(opts, "tls-creds"));
>       if (s->tlscredsid) {
> @@ -1849,6 +1853,11 @@ static int nbd_process_options(BlockDriverState *b=
s, QDict *options,
>       }
>=20
>       s->x_dirty_bitmap =3D g_strdup(qemu_opt_get(opts, "x-dirty-bitmap")=
);
> +    if (s->x_dirty_bitmap && strlen(s->x_dirty_bitmap) > NBD_MAX_STRING_=
SIZE) {
> +        error_setg(errp, "x-dirty-bitmap query too long to send to serve=
r");
> +        goto error;
> +    }
> +
>       s->reconnect_delay =3D qemu_opt_get_number(opts, "reconnect-delay",=
 0);
>=20
>       ret =3D 0;
> @@ -1859,6 +1868,7 @@ static int nbd_process_options(BlockDriverState *bs=
, QDict *options,
>           qapi_free_SocketAddress(s->saddr);
>           g_free(s->export);
>           g_free(s->tlscredsid);
> +        g_free(s->x_dirty_bitmap);
>       }
>       qemu_opts_del(opts);
>       return ret;
> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
> index 6a8b206e1d74..8c20baa4a4b9 100644
> --- a/blockdev-nbd.c
> +++ b/blockdev-nbd.c
> @@ -162,6 +162,11 @@ void qmp_nbd_server_add(const char *device, bool has=
_name, const char *name,
>           name =3D device;
>       }
>=20
> +    if (strlen(name) > NBD_MAX_STRING_SIZE) {
> +        error_setg(errp, "export name '%s' too long", name);
> +        return;
> +    }
> +
>       if (nbd_export_find(name)) {
>           error_setg(errp, "NBD server already has export named '%s'", na=
me);
>           return;
> diff --git a/nbd/client.c b/nbd/client.c
> index f6733962b49b..ba173108baab 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -289,8 +289,8 @@ static int nbd_receive_list(QIOChannel *ioc, char **n=
ame, char **description,
>           return -1;
>       }
>       len -=3D sizeof(namelen);
> -    if (len < namelen) {
> -        error_setg(errp, "incorrect option name length");
> +    if (len < namelen || namelen > NBD_MAX_STRING_SIZE) {
> +        error_setg(errp, "incorrect name length in server's list respons=
e");
>           nbd_send_opt_abort(ioc);
>           return -1;
>       }
> @@ -303,6 +303,12 @@ static int nbd_receive_list(QIOChannel *ioc, char **=
name, char **description,
>       local_name[namelen] =3D '\0';
>       len -=3D namelen;
>       if (len) {
> +        if (len > NBD_MAX_STRING_SIZE) {
> +            error_setg(errp, "incorrect description length in server's "
> +                       "list response");
> +            nbd_send_opt_abort(ioc);
> +            return -1;
> +        }
>           local_desc =3D g_malloc(len + 1);
>           if (nbd_read(ioc, local_desc, len, "export description", errp) =
< 0) {
>               nbd_send_opt_abort(ioc);
> @@ -479,6 +485,10 @@ static int nbd_opt_info_or_go(QIOChannel *ioc, uint3=
2_t opt,
>               break;
>=20
>           default:
> +            /*
> +             * Not worth the bother to check if NBD_INFO_NAME or
> +             * NBD_INFO_DESCRIPTION exceed NBD_MAX_STRING_SIZE.
> +             */
>               trace_nbd_opt_info_unknown(type, nbd_info_lookup(type));
>               if (nbd_drop(ioc, len, errp) < 0) {
>                   error_prepend(errp, "Failed to read info payload: ");
> @@ -645,9 +655,11 @@ static int nbd_send_meta_query(QIOChannel *ioc, uint=
32_t opt,
>       char *p;
>=20
>       data_len =3D sizeof(export_len) + export_len + sizeof(queries);
> +    assert(export_len <=3D NBD_MAX_STRING_SIZE);
>       if (query) {
>           query_len =3D strlen(query);
>           data_len +=3D sizeof(query_len) + query_len;
> +        assert(query_len <=3D NBD_MAX_STRING_SIZE);
>       } else {
>           assert(opt =3D=3D NBD_OPT_LIST_META_CONTEXT);
>       }
> @@ -1009,7 +1021,7 @@ int nbd_receive_negotiate(AioContext *aio_context, =
QIOChannel *ioc,
>       bool zeroes;
>       bool base_allocation =3D info->base_allocation;
>=20
> -    assert(info->name);
> +    assert(info->name && strlen(info->name) <=3D NBD_MAX_STRING_SIZE);
>       trace_nbd_receive_negotiate_name(info->name);
>=20
>       result =3D nbd_start_negotiate(aio_context, ioc, tlscreds, hostname=
, outioc,
> diff --git a/nbd/server.c b/nbd/server.c
> index c63b76b22735..d28123c562be 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -321,7 +321,7 @@ static int nbd_opt_skip(NBDClient *client, size_t siz=
e, Error **errp)
>   /* nbd_opt_read_name
>    *
>    * Read a string with the format:
> - *   uint32_t len     (<=3D NBD_MAX_NAME_SIZE)
> + *   uint32_t len     (<=3D NBD_MAX_STRING_SIZE)
>    *   len bytes string (not 0-terminated)
>    *
>    * On success, @name will be allocated.
> @@ -344,7 +344,7 @@ static int nbd_opt_read_name(NBDClient *client, char =
**name, uint32_t *length,
>       }
>       len =3D cpu_to_be32(len);
>=20
> -    if (len > NBD_MAX_NAME_SIZE) {
> +    if (len > NBD_MAX_STRING_SIZE) {
>           return nbd_opt_invalid(client, errp,
>                                  "Invalid name length: %" PRIu32, len);
>       }
> @@ -379,6 +379,7 @@ static int nbd_negotiate_send_rep_list(NBDClient *cli=
ent, NBDExport *exp,
>       trace_nbd_negotiate_send_rep_list(name, desc);
>       name_len =3D strlen(name);
>       desc_len =3D strlen(desc);
> +    assert(name_len <=3D NBD_MAX_STRING_SIZE && desc_len <=3D NBD_MAX_ST=
RING_SIZE);
>       len =3D name_len + desc_len + sizeof(len);
>       ret =3D nbd_negotiate_send_rep_len(client, NBD_REP_SERVER, len, err=
p);
>       if (ret < 0) {
> @@ -445,7 +446,7 @@ static int nbd_negotiate_handle_export_name(NBDClient=
 *client, bool no_zeroes,
>           [10 .. 133]   reserved     (0) [unless no_zeroes]
>        */
>       trace_nbd_negotiate_handle_export_name();
> -    if (client->optlen > NBD_MAX_NAME_SIZE) {
> +    if (client->optlen > NBD_MAX_STRING_SIZE) {
>           error_setg(errp, "Bad length received");
>           return -EINVAL;
>       }
> @@ -613,6 +614,7 @@ static int nbd_negotiate_handle_info(NBDClient *clien=
t, Error **errp)
>       if (exp->description) {
>           size_t len =3D strlen(exp->description);
>=20
> +        assert(len <=3D NBD_MAX_STRING_SIZE);
>           rc =3D nbd_negotiate_send_info(client, NBD_INFO_DESCRIPTION,
>                                        len, exp->description, errp);
>           if (rc < 0) {
> @@ -757,6 +759,7 @@ static int nbd_negotiate_send_meta_context(NBDClient =
*client,
>           {.iov_base =3D (void *)context, .iov_len =3D strlen(context)}
>       };
>=20
> +    assert(iov[1].iov_len <=3D NBD_MAX_STRING_SIZE);
>       if (client->opt =3D=3D NBD_OPT_LIST_META_CONTEXT) {
>           context_id =3D 0;
>       }
> @@ -905,7 +908,7 @@ static int nbd_meta_qemu_query(NBDClient *client, NBD=
ExportMetaContexts *meta,
>    * Parse namespace name and call corresponding function to parse body o=
f the
>    * query.
>    *
> - * The only supported namespace now is 'base'.
> + * The only supported namespaces are 'base' and 'qemu'.
>    *
>    * The function aims not wasting time and memory to read long unknown n=
amespace
>    * names.
> @@ -931,6 +934,10 @@ static int nbd_negotiate_meta_query(NBDClient *clien=
t,
>       }
>       len =3D cpu_to_be32(len);
>=20
> +    if (len > NBD_MAX_STRING_SIZE) {
> +        trace_nbd_negotiate_meta_query_skip("length too long");
> +        return nbd_opt_skip(client, len, errp);
> +    }
>       if (len < ns_len) {
>           trace_nbd_negotiate_meta_query_skip("length too short");
>           return nbd_opt_skip(client, len, errp);
> @@ -1492,7 +1499,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uin=
t64_t dev_offset,
>        * access since the export could be available before migration hand=
over.
>        * ctx was acquired in the caller.
>        */
> -    assert(name);
> +    assert(name && strlen(name) <=3D NBD_MAX_STRING_SIZE);
>       ctx =3D bdrv_get_aio_context(bs);
>       bdrv_invalidate_cache(bs, NULL);
>=20
> @@ -1518,6 +1525,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uin=
t64_t dev_offset,
>       assert(dev_offset <=3D INT64_MAX);
>       exp->dev_offset =3D dev_offset;
>       exp->name =3D g_strdup(name);
> +    assert(!desc || strlen(desc) <=3D NBD_MAX_STRING_SIZE);
>       exp->description =3D g_strdup(desc);
>       exp->nbdflags =3D (NBD_FLAG_HAS_FLAGS | NBD_FLAG_SEND_FLUSH |
>                        NBD_FLAG_SEND_FUA | NBD_FLAG_SEND_CACHE);
> @@ -1564,8 +1572,10 @@ NBDExport *nbd_export_new(BlockDriverState *bs, ui=
nt64_t dev_offset,
>=20
>           bdrv_dirty_bitmap_set_busy(bm, true);
>           exp->export_bitmap =3D bm;
> +        assert(strlen(bitmap) <=3D BDRV_BITMAP_MAX_NAME_SIZE);
>           exp->export_bitmap_context =3D g_strdup_printf("qemu:dirty-bitm=
ap:%s",
>                                                        bitmap);
> +        assert(strlen(exp->export_bitmap_context) < NBD_MAX_STRING_SIZE)=
;
>       }
>=20
>       exp->close =3D close;
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index caacf0ed7379..108a51f7eb01 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -833,9 +833,18 @@ int main(int argc, char **argv)
>               break;
>           case 'x':
>               export_name =3D optarg;
> +            if (strlen(export_name) > NBD_MAX_STRING_SIZE) {
> +                error_report("export name '%s' too long", export_name);
> +                exit(EXIT_FAILURE);
> +            }
>               break;
>           case 'D':
>               export_description =3D optarg;
> +            if (strlen(export_description) > NBD_MAX_STRING_SIZE) {
> +                error_report("export description '%s' too long",
> +                             export_description);
> +                exit(EXIT_FAILURE);
> +            }
>               break;
>           case 'v':
>               verbose =3D 1;
>=20


--=20
Best regards,
Vladimir


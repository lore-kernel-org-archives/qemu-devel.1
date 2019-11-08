Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3115C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:14:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F9C20659
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qKwBiYRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F9C20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT51W-0001dw-NV
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 09:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iT4zB-0007Tj-1k
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:11:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iT4z9-0005od-Hu
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:11:36 -0500
Received: from mail-eopbgr00090.outbound.protection.outlook.com
 ([40.107.0.90]:20358 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iT4z9-0005nG-Bd; Fri, 08 Nov 2019 09:11:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mr0fSWOLkW77qem8EhCXnISs977m5qseFvNEacNECMG4kPunftjRrbRvQDxL6w/dL8b+oK9h/l56hfunPzTRTnYVAMOTFEGCb8/3cjUk/KQ6FglgkAJdDsfWOd5Kr6cI2Y3rNcLqzvR21A1faRJ21iQaDiQ1DTcWXyV5IkFajyivVhVfuW3xVj7lRjxn79Knz43j+vgKNa5G0kGmtVvdHqtaZJKrGsF9z1io9EtDKeYd3vFC+CpFIFwDCSVl+BjdW+e/PxEYTz7A8UcYeLp3CiUVdFWav2VIYExs+SZx+uCVdsXiaTb695FS+/e+eWwG/MfQ3PmKkPJJuN5odbOM/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZhQhe5scdDCEY8C4dx6E5E++neGvjd3BJqVrkl0lTs=;
 b=GNgo863yAFmsHdsSoMY7vcqpDkhOQ98lN+bX1VqSElSkU28wr6Ac5+aA+hkOASlFIq62v3gc/bqhmFPn8jN6PYqDHHBKZLUPRDMP7YUuXUKThXUv2wDtkbaYDGeiRPx/syz8KMaHWgp+yjnxsgjMDa64BYLKZ7ZSTH+kPD6xCvG8MgNRao9XzyZegH98OBIJ+KsHWRQyN12wmto2k2OW7MPE4Q2tqIjHcM/I0IQgGCtYzOj2947PN26k4LRB5uCZYEleNGLhwCrO7xNx8DobjSN7nKb+RoYc9qkxNs96RUdOABd/ES8qGU36YP1yZAtt+QRLVyY84AMtA97XnoDXVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZhQhe5scdDCEY8C4dx6E5E++neGvjd3BJqVrkl0lTs=;
 b=qKwBiYRvq4sXlc++zB26QM0dOt5TNXFRFoAe6Gt9s0MWFvaNfBqX+la3rppRaavVKi2/wZLm0YvMqei6jFLvDIKEEPNrXy/YcxRtPovSl+REpqIY+gVvjhy9w3gp14JYhUJDjD+xnHzZRD8fdQddaMrc6i2jFvQuBGKUieqFMl8=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB3761.eurprd08.prod.outlook.com (20.178.23.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Fri, 8 Nov 2019 14:11:32 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::41f0:981:fd75:9946]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::41f0:981:fd75:9946%3]) with mapi id 15.20.2430.023; Fri, 8 Nov 2019
 14:11:32 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v4 2/5] block: Use bdrv_qapi_perm_to_blk_perm()
Thread-Topic: [PATCH for-5.0 v4 2/5] block: Use bdrv_qapi_perm_to_blk_perm()
Thread-Index: AQHVljD1UHUge3tEFkSo3VwbyHKi/aeBUHMA
Date: Fri, 8 Nov 2019 14:11:32 +0000
Message-ID: <1dcdf6c3-a378-dd87-aa4d-840cfe2cd4ef@virtuozzo.com>
References: <20191108123455.39445-1-mreitz@redhat.com>
 <20191108123455.39445-3-mreitz@redhat.com>
In-Reply-To: <20191108123455.39445-3-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0003.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::13) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191108171130557
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcc6e1df-d6cc-4f23-ce15-08d764558e7c
x-ms-traffictypediagnostic: AM0PR08MB3761:
x-microsoft-antispam-prvs: <AM0PR08MB37610A3202BCEF50B0F64495C17B0@AM0PR08MB3761.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:565;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39840400004)(376002)(396003)(136003)(346002)(199004)(189003)(316002)(486006)(2501003)(110136005)(14454004)(52116002)(476003)(386003)(478600001)(66476007)(66556008)(66446008)(102836004)(64756008)(6246003)(6506007)(6512007)(11346002)(5660300002)(66946007)(229853002)(305945005)(2906002)(6436002)(54906003)(6486002)(76176011)(7736002)(186003)(256004)(8936002)(36756003)(86362001)(99286004)(2616005)(4326008)(446003)(8676002)(26005)(66066001)(71190400001)(3846002)(71200400001)(25786009)(31686004)(81156014)(81166006)(6116002)(31696002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3761;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UHqMxf0xfknTc3g4+GYBNEKNmA0xFLjq6lSem84OEA9wb+ApGCVRAZr9ceadxTBsbK9q8/ov1ShmImHEzDdPFWv53Wg+U0UIO43tQ8FzCANVip04Emx0yK+Q/uo59wGKLB/bN9rQ10yeusXQc2bl2rrJlPQrd0gQTAziNlsjf3IPgq2IOFKJZqLo6c6ak0R5CtLPcIoUW1uUCU2O1DadblDcwviPlQEoXxVeJ/Y/63Jog/+crTY7CS2hQv4uiTp5d/ov2X69xaABDiq5MEUeqtVJES1nFCKM2rpWQfFe/5yODcCZu7TkFxnQExTTzJYaWCgrqHF1XQqsp2yyBSKJhM8HtnME9XM/bEvsCklnGw9A/sgMMlwHQD6ZYW1GkcX15Wt0UO1cqZdit4C/IWgQsqAZq3LlPOG4CqwzUAj7cKK+uui3QdfIepq2gsfE7lEY
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <4A3182821A0C0945A6E9761CBD1C19D6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc6e1df-d6cc-4f23-ce15-08d764558e7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 14:11:32.2995 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wfLvL7Yx/29fMY3zeAhD+3yexX1Uj8HMe+MQmXdnDu+yQnbKea/ILVd8g+8gIgJ9jsvFvCWAuczfvra8olpGnXVfmQzIjT5BYl5/u2ojrq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3761
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.90
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

08.11.2019 15:34, Max Reitz wrote:
> We can save some LoC in xdbg_graph_add_edge() by using
> bdrv_qapi_perm_to_blk_perm().
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---
>   block.c | 29 ++++++++---------------------
>   1 file changed, 8 insertions(+), 21 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index 066433f3e2..ae279ff21f 100644
> --- a/block.c
> +++ b/block.c
> @@ -4870,36 +4870,23 @@ static void xdbg_graph_add_node(XDbgBlockGraphCon=
structor *gr, void *node,
>   static void xdbg_graph_add_edge(XDbgBlockGraphConstructor *gr, void *pa=
rent,
>                                   const BdrvChild *child)
>   {
> -    typedef struct {
> -        unsigned int flag;
> -        BlockPermission num;
> -    } PermissionMap;
> -
> -    static const PermissionMap permissions[] =3D {
> -        { BLK_PERM_CONSISTENT_READ, BLOCK_PERMISSION_CONSISTENT_READ },
> -        { BLK_PERM_WRITE,           BLOCK_PERMISSION_WRITE },
> -        { BLK_PERM_WRITE_UNCHANGED, BLOCK_PERMISSION_WRITE_UNCHANGED },
> -        { BLK_PERM_RESIZE,          BLOCK_PERMISSION_RESIZE },
> -        { BLK_PERM_GRAPH_MOD,       BLOCK_PERMISSION_GRAPH_MOD },
> -        { 0, 0 }
> -    };
> -    const PermissionMap *p;
> +    BlockPermission qapi_perm;
>       XDbgBlockGraphEdge *edge;
>  =20
> -    QEMU_BUILD_BUG_ON(1UL << (ARRAY_SIZE(permissions) - 1) !=3D BLK_PERM=
_ALL + 1);
> -
>       edge =3D g_new0(XDbgBlockGraphEdge, 1);
>  =20
>       edge->parent =3D xdbg_graph_node_num(gr, parent);
>       edge->child =3D xdbg_graph_node_num(gr, child->bs);
>       edge->name =3D g_strdup(child->name);
>  =20
> -    for (p =3D permissions; p->flag; p++) {
> -        if (p->flag & child->perm) {
> -            QAPI_LIST_ADD(edge->perm, p->num);
> +    for (qapi_perm =3D 0; qapi_perm < BLOCK_PERMISSION__MAX; qapi_perm++=
) {
> +        uint64_t flag =3D bdrv_qapi_perm_to_blk_perm(qapi_perm);
> +
> +        if (flag & child->perm) {
> +            QAPI_LIST_ADD(edge->perm, qapi_perm);
>           }
> -        if (p->flag & child->shared_perm) {
> -            QAPI_LIST_ADD(edge->shared_perm, p->num);
> +        if (flag & child->shared_perm) {
> +            QAPI_LIST_ADD(edge->shared_perm, qapi_perm);
>           }
>       }
>  =20
>=20


--=20
Best regards,
Vladimir


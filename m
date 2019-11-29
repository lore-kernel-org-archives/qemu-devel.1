Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860A1C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB9221774
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pd8CLBf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB9221774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaclg-0005Iy-E6
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 04:40:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iacfs-0001Ho-16
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:34:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iacfn-0007Z2-0t
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:34:48 -0500
Received: from mail-eopbgr150139.outbound.protection.outlook.com
 ([40.107.15.139]:14468 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iacfl-0007SW-5D; Fri, 29 Nov 2019 04:34:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rpp2noCnBfFAwKtn8Ni3S3fk4SBgSb83v+8jGLPbkYnyZX1OdNx2sp29e6CoV6eJz/yoeuUNdppIfolV84yNwv0O/1Zamd99dGcUtFahu6YYVnr8ydxxnkP4boOmyTNl4mASeAwH4UyLYDqPUD2CgMsGTgiKtk+LTIzIJ8YvJiPx7jG+ViLgwNPgB+oXOYAUhIvDBxMCuwP59h8GfVTnvC9pVBLqLsOK4kbXHJ0A3tduq8tL2Ti/EAysED338llPorqpRixC34N37hCDSOTFai08AIQ5TS7vtdrKStAU4yYW0QEJ6MoMQSA7iuIzsIGQmFZou+AKvpoJtFb8jtsgMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1y/HOWnexxqiTth4ig8+hlmOw//d/QmSdj570G5Y5I=;
 b=lQnZl37ciSofMUTVQixfUJGd9EI2OsQxv+ydqLTpHcxilYexsMdWDHNcBsoxJYFBGTa5A32OyIAjoy9dXG52zAK82Q/dLZTiXb6G+GiITu4RgsqisyxFV+ODWo5XgQbR8U3yIXf10EwgnfFG5dK84kQe/eJbA1jFl0g5bTMHCcheQWbL8ngwoBS52pAu4AIhitautm9K1LZosZD/IXxbOnJQsfsBF9s1++0IagAA6toRf94pyy93OLc9rWoWkTbPLeRPdoK+W6E9oAKA5cOyceToohBGfkbeayRlkgnpOGM7PQJmILD1cGo1Vb6MlPp0oAnRHyky0APsxBsYhaRiOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1y/HOWnexxqiTth4ig8+hlmOw//d/QmSdj570G5Y5I=;
 b=pd8CLBf5hU44g16X8YsS43jWtYPTrncGtcPPgs5swGbEhYAHJGDYiLJ/lkexYdeUjbwAkFVhR9sSeVHHi4gluEdEN9kFV3U/Ismxm5Igc3ZsUd5QQ82zNNgNR0HsgIIdKZN8nN0B+HXbnaQEnsJIhVfi8eJMTxS2bY8cwNccK1M=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4788.eurprd08.prod.outlook.com (10.255.96.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Fri, 29 Nov 2019 09:34:41 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 09:34:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 06/23] block: Add bdrv_recurse_can_replace()
Thread-Topic: [PATCH for-5.0 v2 06/23] block: Add bdrv_recurse_can_replace()
Thread-Index: AQHVmKl0WF/VLFkw5UGbjTiBCl5Dpaeh/xwA
Date: Fri, 29 Nov 2019 09:34:40 +0000
Message-ID: <5370cd61-413a-0208-541c-49894ad0c630@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-7-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-7-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0048.eurprd09.prod.outlook.com
 (2603:10a6:7:15::37) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191129123438644
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d995a12b-9175-41b7-7c4e-08d774af5bf2
x-ms-traffictypediagnostic: AM6PR08MB4788:
x-microsoft-antispam-prvs: <AM6PR08MB47884D9F2C4442DC930B8C30C1460@AM6PR08MB4788.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(396003)(136003)(39840400004)(366004)(189003)(199004)(64756008)(66556008)(66476007)(229853002)(66446008)(66946007)(7736002)(305945005)(36756003)(2906002)(31686004)(6246003)(6512007)(86362001)(6436002)(110136005)(186003)(478600001)(54906003)(446003)(99286004)(2616005)(4326008)(11346002)(316002)(31696002)(6486002)(102836004)(66066001)(71200400001)(71190400001)(76176011)(5660300002)(52116002)(26005)(256004)(14444005)(386003)(6506007)(25786009)(81166006)(81156014)(8676002)(14454004)(8936002)(2501003)(3846002)(6116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4788;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cPBia2joT7gppYx39Zm9jL+7iWZYePTPHqbYPwYFebTuNF+YIQVViyFfTVqS43l9kvygs4RvR7Y3yj9I0WAmDe4oEYG5nVEW8bRlqEhHjJeH77pY2tnRB3fDRqWpgqnHgmjV//S6/McN5XNbTGsDm1jxOdln7h0zB+thkqKkbekffVvl/LcusNYer6O7Nu7dhb/oAQ0Kc2mZvPCebAcQ9q6FeQtOFsnXCiMdqzuEVy+kNq5ZSEbMTPjOzaTzDh47t3oCZRpnM710/ktuGWUmnAs4oyQm5VXc8sSwWGecIJzLPQmaQ4CmXSdwOLHYTd0RDh/BYsmNMDZ+jZ1Y7ZEk3Ilq6T9s1KXeesgbZmA0A8+b2le5Q8Llvl/wKtE4ibkcfmsOzn9KsteQebdIuFMoYQ/yiNuz667JuNHsVzNUoC7xx61EhNbPKLzrRwS1oW+u
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <4C46167583989D4BA77629D248CC7976@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d995a12b-9175-41b7-7c4e-08d774af5bf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 09:34:41.0139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 01s58WZ325+0+hajWu/fp80hnKGW3MB/oNgt+/MO+h8R68kLjTkNICmpxzbW8d/iVkGn76AQAVd9tdNpMizSQsvcfFmOylI0v2Dl23JrfUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4788
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.139
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.11.2019 19:01, Max Reitz wrote:
> After a couple of follow-up patches, this function will replace
> bdrv_recurse_is_first_non_filter() in check_to_replace_node().
>=20
> bdrv_recurse_is_first_non_filter() is both not sufficiently specific for
> check_to_replace_node() (it allows cases that should not be allowed,
> like replacing child nodes of quorum with dissenting data that have more
> parents than just quorum), and it is too restrictive (it is perfectly
> fine to replace filters).
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block.c                   | 38 ++++++++++++++++++++++++++++++++++++++
>   include/block/block_int.h | 10 ++++++++++
>   2 files changed, 48 insertions(+)
>=20
> diff --git a/block.c b/block.c
> index 9b1049786a..de53addeb0 100644
> --- a/block.c
> +++ b/block.c
> @@ -6205,6 +6205,44 @@ bool bdrv_recurse_is_first_non_filter(BlockDriverS=
tate *bs,
>       return false;
>   }
>  =20
> +/*
> + * This function checks whether the given @to_replace is allowed to be
> + * replaced by a node that always shows the same data as @bs.  This is
> + * used for example to verify whether the mirror job can replace
> + * @to_replace by the target mirrored from @bs.
> + * To be replaceable, @bs and @to_replace may either be guaranteed to
> + * always show the same data (because they are only connected through
> + * filters), or some driver may allow replacing one of its children
> + * because it can guarantee that this child's data is not visible at
> + * all (for example, for dissenting quorum children that have no other
> + * parents).
> + */
> +bool bdrv_recurse_can_replace(BlockDriverState *bs,
> +                              BlockDriverState *to_replace)
> +{
> +    if (!bs || !bs->drv) {
> +        return false;
> +    }
> +
> +    if (bs =3D=3D to_replace) {
> +        return true;
> +    }
> +
> +    /* See what the driver can do */
> +    if (bs->drv->bdrv_recurse_can_replace) {
> +        return bs->drv->bdrv_recurse_can_replace(bs, to_replace);
> +    }
> +
> +    /* For filters without an own implementation, we can recurse on our =
own */
> +    if (bs->drv->is_filter) {
> +        BdrvChild *child =3D bs->file ?: bs->backing;

should we check that child !=3D NULL ?

> +        return bdrv_recurse_can_replace(child->bs, to_replace);
> +    }
> +
> +    /* Safe default */
> +    return false;
> +}
> +
>   BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
>                                           const char *node_name, Error **=
errp)
>   {
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index dd033d0b37..75f03dcc38 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -102,6 +102,13 @@ struct BlockDriver {
>        */
>       bool (*bdrv_recurse_is_first_non_filter)(BlockDriverState *bs,
>                                                BlockDriverState *candidat=
e);
> +    /*
> +     * Return true if @to_replace can be replaced by a BDS with the
> +     * same data as @bs without it affecting @bs's behavior (that is,
> +     * without it being visible to @bs's parents).
> +     */
> +    bool (*bdrv_recurse_can_replace)(BlockDriverState *bs,
> +                                     BlockDriverState *to_replace);
>  =20
>       int (*bdrv_probe)(const uint8_t *buf, int buf_size, const char *fil=
ename);
>       int (*bdrv_probe_device)(const char *filename);
> @@ -1264,6 +1271,9 @@ void bdrv_format_default_perms(BlockDriverState *bs=
, BdrvChild *c,
>                                  uint64_t perm, uint64_t shared,
>                                  uint64_t *nperm, uint64_t *nshared);
>  =20
> +bool bdrv_recurse_can_replace(BlockDriverState *bs,
> +                              BlockDriverState *to_replace);
> +
>   /*
>    * Default implementation for drivers to pass bdrv_co_block_status() to
>    * their file.
>=20


--=20
Best regards,
Vladimir


Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7734C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B09AC2084D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sUAixNRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09AC2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaeNA-0000sP-48
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 06:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iaeIX-0006N7-3z
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:18:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iaeIQ-0008Rm-Kk
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:18:48 -0500
Received: from mail-eopbgr20113.outbound.protection.outlook.com
 ([40.107.2.113]:46756 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iaeIN-0008KZ-P2; Fri, 29 Nov 2019 06:18:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvUpMU2ZMf0PTwnUvS6oEtFtXfXONmgn7a9/TJeupPAcdEQjbFbdbcEGyRsocEXnD00WCzgaprNSvcih3P9q6Cjb9Fs9BxF4pV9caRRktAMrij1UtHODrDKaoWAz7XNqjcQxhV6c/VJ+OCBWaEElfbrGbqduUs+PMmorc+w6hvw4UyoO3hyjSK0oKOjFXW5re4kKVcYGxRg7OOT3Z4dsBRncac/iURk1SQUXSFV8HaCDWZWJZCFdBCggYJSBDhQ4kTL78QDcch6e25986/SnTiSTaYEnkiAzwcreScbgJPF9+dUr80Y9+wpd3SMdwYrH/TOvA+RFnIRXBfphqjK2Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9oUcUVoOL0fDE9QaSgXZPXw/mKlYj5XyIu4OlxImM4=;
 b=IoTOjJ85hGa2LWWwi3Izcr8vfDRwbhdQsdBoLOswXUWszYnrDMfFpUMOJtFQZ76T/So3hwX7ozatb6jLwQdp7Pf1ewBvsKzGh6vcnWM8NmmurQ8yaCLu2ToONWsBwSjf29wr3BTAC/BAMD5ITySAKrTnxhdwpi+O16NWPSum73sxEakWQMKjWfZATTfK6xaz6a20pQJKtwPvCVOyxvr8WwgH4OYVNW8pwAttKeVQhcptT0hH8mR9xgIax/WoxxHE8xyeniAYNNK3c9RtApTXdUbIhdcyxoDiBd6Jmf3VWvvV9bIxUDy1MlVz6yzt3TSPY9YNOrr7codL7SGDaR70xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9oUcUVoOL0fDE9QaSgXZPXw/mKlYj5XyIu4OlxImM4=;
 b=sUAixNRL+aF840g6704/zvQz3HkCXwJdpGNmXn3sj7/hXqzHORF2bxc3BZvw3ri88dtQVYO7pZ9VEku5lScgcYd7DFARVEQJynfOcdK7i90poPM6kctJmNLMtNsYToHxH5NLn/S7s6eKGDnibHyJh8xperu1IcNc2REtzaqEU14=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4550.eurprd08.prod.outlook.com (20.179.18.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Fri, 29 Nov 2019 11:18:39 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 11:18:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 13/23] mirror: Double-check immediately before
 replacing
Thread-Topic: [PATCH for-5.0 v2 13/23] mirror: Double-check immediately before
 replacing
Thread-Index: AQHVmKmBOvSfRSt4Xky0bXKFn4jsKKeiHCqA
Date: Fri, 29 Nov 2019 11:18:39 +0000
Message-ID: <247c6f17-a425-0bb6-1c9f-a01a01cc3b37@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-14-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-14-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0003.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::13) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191129141837146
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 626a6a8c-447a-45fd-7374-08d774bde27b
x-ms-traffictypediagnostic: AM6PR08MB4550:
x-microsoft-antispam-prvs: <AM6PR08MB45509973C780DE95D3A0EB58C1460@AM6PR08MB4550.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(305945005)(66946007)(102836004)(26005)(186003)(66446008)(3846002)(36756003)(66476007)(66556008)(64756008)(6116002)(8676002)(229853002)(11346002)(7736002)(386003)(86362001)(31696002)(6506007)(71200400001)(6246003)(71190400001)(6512007)(446003)(2501003)(2616005)(81156014)(66066001)(5660300002)(81166006)(52116002)(14444005)(256004)(31686004)(54906003)(110136005)(316002)(14454004)(478600001)(6436002)(25786009)(6486002)(76176011)(4326008)(2906002)(8936002)(99286004)(14773001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4550;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mBFJNlpAoHKjLb8mFXodrPI3LXxIpwgsfSEMl5nT0rX99GsYv2zFZawYIK7pvDBGjhNgymwcPNqk50kTagWi1HRvWXhkuIsPZ5TZP/6TM1dwWrs/7a8T0K5jl7uHvzSKwEvM4vFGkv0QU2toqNy2YJjPCySpScxwiadfUXQjdqIlM8lkJFMlDti1hXjdyw8fMA6nBH7QxqsJic4zWRTAuy20h3gylW5UEzXC+j/Nk6DJ5no9itC2238Q3wr5I4kneWJ/F83mH37p1M9BPp9PZsz/jbafatIBk3qNAm59Xq6RquCOu9zIFH2b8uQaW2eon7UwN2xUFE5YjB8YUPgQJOhQiVMoSk3QtdwbTd4ix7XM4qV2AJ++Dc7T4QZYnKmW6OjeEJcnHWrIrlUmJGCBJ2BY/GzC36dusBgA8o6K/dOM1ROlrs309CkdGLXizr0f
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <BC3017140DEA8F419B0E5D6429F314BE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 626a6a8c-447a-45fd-7374-08d774bde27b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 11:18:39.5335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fNIx12o7Evwaf/gUr4cbqT7PRvWDGrNG+QknbBqLSFRNTPsWbgIxHOD8y3/klLZbSovyu3gwqK6mcNQGa/xgkxAef9dV6TWmBrcZ9sZgyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4550
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.113
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

11.11.2019 19:02, Max Reitz wrote:
> There is no guarantee that we can still replace the node we want to
> replace at the end of the mirror job.  Double-check by calling
> bdrv_recurse_can_replace().
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/mirror.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index f0f2d9dff1..68a4404666 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -695,7 +695,19 @@ static int mirror_exit_common(Job *job)
>            * drain potential other users of the BDS before changing the g=
raph. */
>           assert(s->in_drain);
>           bdrv_drained_begin(target_bs);
> -        bdrv_replace_node(to_replace, target_bs, &local_err);
> +        /*
> +         * Cannot use check_to_replace_node() here, because that would
> +         * check for an op blocker on @to_replace, and we have our own
> +         * there.
> +         */

interesting, that check_to_replace_node would acquire aio context of src..

Here we acquire aio context only if s->to_replace set (above this hunk).. I=
sn't it a bug?

If it is, it's preexisting, and not directly related to the patch, so here:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> +        if (bdrv_recurse_can_replace(src, to_replace)) {
> +            bdrv_replace_node(to_replace, target_bs, &local_err);
> +        } else {
> +            error_setg(&local_err, "Can no longer replace '%s' by '%s', =
"
> +                       "because it can no longer be guaranteed that doin=
g so "
> +                       "would not lead to an abrupt change of visible da=
ta",
> +                       to_replace->node_name, target_bs->node_name);
> +        }
>           bdrv_drained_end(target_bs);
>           if (local_err) {
>               error_report_err(local_err);
>=20


--=20
Best regards,
Vladimir


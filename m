Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372B8C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 06:48:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0365924655
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 06:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Cut52tIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0365924655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBYgb-0007ND-7z
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 02:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jBYfe-0006tw-1O
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 02:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jBYfc-0002EK-6L
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 02:47:17 -0400
Received: from mail-eopbgr80113.outbound.protection.outlook.com
 ([40.107.8.113]:34883 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jBYfW-0001qu-IB; Tue, 10 Mar 2020 02:47:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVRn/JpWJwDk+jXNu1qvMBr3cTbQPkHXU36f75MhKDp444yTTLlkwkx17+evUkRfRt7nOjSIHGiagSY2KZdGL9gQqq6F2Z3EPjsoYxDJ+S7qoSjc4N3bA7F0g3Ij7+TXDYtgnG+zTDDC+pZXepuRojx8DiKuCEM65aWiS/dxpLhSQ+z2mq6oQr6XIqkWrepKvfBVjHZgqexJpCfgSLh1Wj5e+eDo811P6WiCrQRrdoP+ifZ7/qkTXdMZcTEVelAgtDCM5zyauaoWiANe1FEHZ8oVIlS78Yr3Pb18bKLqw7gy8XAd6IjDilcuhS9Y4/rZveA4qckgmGfvM1Ul0LnIHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkRSGu1l0xSemgRLhlV9PX/SDiy8sJCdZflsNGYtWfc=;
 b=k8gvO6c7yaci4dbyuX1+npir5oDc/BKpwoZddanC1v2UIqaZBQDO81p3bIKb8UesFRR+aYwv1oxQA5QMbuX9Xao5ECLI3/P01ERzhuSVqrHL2TSrkREiOo9tOyjEpIVeQ8C7KT3orxZ92x49BA3zYE2EJlbj1UxnKCdrfDOJV0BswNLHcWmxw80Xidt4l6lMhoyyuB3YmqTWqC2lDjXdvBtfRP2JzF5+keMULxdKVpwNiQ5Bywv+Pb7MapK5OIw6/BUgbQcpCvcUojnnw4767Iwgk12C9zxHRiWY4PdKUdg/sTGcbnRB1Q75FbXqX1xnuWJqIm+OEJbA3aefJeRnBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkRSGu1l0xSemgRLhlV9PX/SDiy8sJCdZflsNGYtWfc=;
 b=Cut52tIuRCX0lRWsxd9OX0ehaL1Eju8xxPbdiR3ut5Yo9oJsyjGpNybTS/S+p3eFw15KbnpCWJeRSSbmGWSUgQw/y6RSAjQMmDNQ+BlXNDPfLTl88ZLuCqmrU5a6vjmjytmAsUpr7jFodl+GYta5lcRt2rZyq84Xn4tvIZCXCA8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5111.eurprd08.prod.outlook.com (10.255.122.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 10 Mar 2020 06:47:05 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2793.018; Tue, 10 Mar 2020
 06:47:05 +0000
Subject: Re: [PATCH v8 02/10] scripts: add coccinelle script to use auto
 propagated errp
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
 <20200306051536.27803-3-vsementsov@virtuozzo.com> <2464375.yLZ1CyT5Wr@silver>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200310094702631
Message-ID: <12482a0b-28f8-0a4b-cf3f-b2b390bf238e@virtuozzo.com>
Date: Tue, 10 Mar 2020 09:47:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <2464375.yLZ1CyT5Wr@silver>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0902CA0040.eurprd09.prod.outlook.com
 (2603:10a6:7:15::29) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0902CA0040.eurprd09.prod.outlook.com (2603:10a6:7:15::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16 via Frontend Transport; Tue, 10 Mar 2020 06:47:04 +0000
X-Tagtoolbar-Keys: D20200310094702631
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8729c123-68a8-4951-9bc5-08d7c4bed8ac
X-MS-TrafficTypeDiagnostic: AM6PR08MB5111:
X-Microsoft-Antispam-PRVS: <AM6PR08MB51119DC80AF35922FA1249D4C1FF0@AM6PR08MB5111.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(39850400004)(376002)(366004)(396003)(136003)(199004)(189003)(16526019)(2906002)(186003)(6486002)(52116002)(8676002)(26005)(16576012)(54906003)(36756003)(316002)(31686004)(5660300002)(4744005)(31696002)(66476007)(81156014)(2616005)(478600001)(7416002)(81166006)(956004)(8936002)(66946007)(66574012)(4326008)(66556008)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5111;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FgaOukhwEahABcGPAs9ARbVIdBdoW//mP9vmhc270HIa4LKSoLNsipnnT1vjJoJN+oJ6vjb9dxl5hZk7FOc8yfFZ1Zl8ZRuZTvakxhWaOTA6m6HAorK0KJ7lO7lD9FaunNfSyshSeW6uJKU4js1/ek6RvFErDWWf48Ko6Wp3UpZrAGfjREsRuhvQzGRtlxve+RDxninGiJleIr2Xi8LFh7/0ZglEqzpKp9FczJRCVGgAXhjlldm6IUOW8QCXHp+BFdjciwrPOtpHO4CTddAr8Xla+eMVS0bJwiJf5CSkVKQhSXbGDavltNoZBS2g5LSZYEy1yUpdPz2sOGEu7fZstm2ormj0oMxsblF/yP8T7EwzwUE+LhUX9OWwAhYFIklahfPhmKJfEkkdRLLvdZmtxsL1d1OWnmv2DG8H7tbgXN+gknhGUFRgqD7qz998ew0p
X-MS-Exchange-AntiSpam-MessageData: hBcwFhI5lsMLRzm4b/6RaWEpIsLMaOUI+XcfmqXJsalX8+C8ASbVFXJFMJrrBb11nocP19Hl/sVAUyauXNV2p0yGibh/ppWQ8kmeVI/jrnST1Orf+AqBA+WD0T6+q1PbhfGUBPd3tXRTmCZKuYRxBQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8729c123-68a8-4951-9bc5-08d7c4bed8ac
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 06:47:05.6544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 133W/ecAWhfGl2NSDwCwhKIPJiRbHHO20rTuhu7LTqzHgwuyKThJtet8yoKqsVBqwjhpj4xv9lSgar3O99e3G3QNeKltqcc6cv5hk9Eb/og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5111
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.113
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laszlo Ersek <lersek@redhat.com>,
 Greg Kurz <groug@kaod.org>, armbru@redhat.com,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

08.03.2020 22:09, Christian Schoenebeck wrote:
> On Freitag, 6. M=C3=A4rz 2020 06:15:28 CET Vladimir Sementsov-Ogievskiy w=
rote:
>> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci
>> b/scripts/coccinelle/auto-propagated-errp.cocci new file mode 100644
>> index 0000000000..bff274bd6d
>> --- /dev/null
>> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
>> @@ -0,0 +1,231 @@
>> +// Use ERRP_AUTO_PROPAGATE (see include/qapi/error.h)
>> +//
>> +// Copyright (c) 2020 Virtuozzo International GmbH.
>=20
> Just in case:
>=20
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

Hmm, seems this, and some other coccinelle scripts should be added to "Erro=
r reporting"
section.

>=20
> Best regards,
> Christian Schoenebeck
>=20
>=20
>=20


--=20
Best regards,
Vladimir


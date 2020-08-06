Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A44C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E805D22CF7
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="GLtvG6ce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E805D22CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3bAg-0002co-DQ
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 04:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1k3bA3-0002D0-Ac
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 04:22:03 -0400
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101]:62250)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1k3b9w-0007MK-Sv
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 04:22:02 -0400
IronPort-SDR: RJQi2G343fbyRqg5PGONtFPfoSx7Ydq9/m2B2mJRYxkKbJDiIooaNSOZfp64KRYXAHPSfOjhHK
 dIaMWjoWocSSdNh9VrldMrJmanaRAN5PhIc1AWiGkCAQCE3SW9n0BkVOSdvgWpfiUtvSk0pGRG
 1LcU1jKGi4OBBUvE0o96MhrkUfn2Huo3B+Rwb6A0VpY9ejAj/b442of2PaEwy+gRJd07GZdqPg
 PCbr1X+hsOcHI3iE2OWbI7WWs9GvbFaj6eMzedeHfB8AcW9BLYfghe0JPZ+e+SnTjDX82qyiKm
 pnQ=
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="16468998"
X-IronPort-AV: E=Sophos;i="5.75,441,1589209200"; d="scan'208";a="16468998"
Received: from mail-os2jpn01lp2050.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.50])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2020 17:21:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RM+VxqpKvf8AtOpuwKaqGibR5Q0ZEF/dkkJrgXHVEFnKPxh9znxVU018SNpY0si55AIYXTkQXie/H+wIkS6ZeM3hQC2PL0hC0xhlKL+XZRL8QjgXMpdP3USdm3F2mL0wlAzz0/zFMHmiI8m4KaWWWsLUgaSE/IzvcLSIpvXypKdVTDP2jwgQ0Zgddzy7OV8i+Rb+h+X4Ry5eCygrj4zPozqcAaWx/0VJVOBA8V2t7lP3Ye1UAbCMI7x5IOSF+JFzlZKw7Qy73DoOAKfBgUU/9uaZ821yQYHzLNoGZNz28JUPYXwOuRUpoJIjW5m7eRRMlhffHwptIEHvzPVktwGhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bniU8zPH+52MQmMc/EX4E81xCFPz4/8Bdos46VqOmc=;
 b=iodhjTXNPOuqv1moFqiW9Ld4SOGxAM+94YCYE/frODMatXiVM8Pq9RZzZUii1pFmhJ9j7nEtY3AimDWsZWKTtOHlEUK3+EB2NG4LhSU3icsxqQ9nXzpg1wbOEYvZOhfZfAvAylvpK5BKyN1NpxRu0wvgSegzmHeB7bzMBAz5kBvA61P7DRVC8K7cr3lwlVX3ANuFfY3PdlpiNXUdW8OLNRGt9YL8GvnjUxDZDUD+oe7FBGwYkTm04ErxCo2nsdwnXHclB2HIyxPzBD5QXjmNVFyPtL7yZP8kURKJgminx3mjIpV7j8AnC557PhAJhc/V7Cbz16f3E4KKxg9vCWpJKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bniU8zPH+52MQmMc/EX4E81xCFPz4/8Bdos46VqOmc=;
 b=GLtvG6ce/RATRHdUe9cZRwvmohnMPQBIhT+JFK8cgyC4rbLFOQVY4Dh15A+lvu7cB0zYFdZ3HxHVKSOTtuEjSvVZU4uAEymRT4Eeg+PUyycVdYBHldk6HcJya6tVyRU/CTPQqEJV4dJSbMq6tCdMA6VcjQCCJY0ca+y7SZwF0l8=
Received: from OSBPR01MB4582.jpnprd01.prod.outlook.com (2603:1096:604:74::21)
 by OSAPR01MB2210.jpnprd01.prod.outlook.com (2603:1096:603:1c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18; Thu, 6 Aug
 2020 08:21:45 +0000
Received: from OSBPR01MB4582.jpnprd01.prod.outlook.com
 ([fe80::d8f2:88cb:21f7:f426]) by OSBPR01MB4582.jpnprd01.prod.outlook.com
 ([fe80::d8f2:88cb:21f7:f426%3]) with mapi id 15.20.3239.021; Thu, 6 Aug 2020
 08:21:45 +0000
From: "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
To: 'Vivek Goyal' <vgoyal@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [Virtio-fs] [PATCH] virtiofsd: Disable remote posix locks by
 default
Thread-Topic: [Virtio-fs] [PATCH] virtiofsd: Disable remote posix locks by
 default
Thread-Index: AQHWZDG1j+TP8kU1ME2sQZoeeTEaZqkqynUg
Date: Thu, 6 Aug 2020 08:20:39 +0000
Deferred-Delivery: Thu, 6 Aug 2020 08:21:38 +0000
Message-ID: <OSBPR01MB4582AB9CD2DB32A48A8BB13FE5480@OSBPR01MB4582.jpnprd01.prod.outlook.com>
References: <20200727161841.GA54539@redhat.com>
In-Reply-To: <20200727161841.GA54539@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckermailid: 15c36ae158b242e8b2addb0eccccc124
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [118.155.224.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 306794f8-612d-45e1-e978-08d839e1c198
x-ms-traffictypediagnostic: OSAPR01MB2210:
x-microsoft-antispam-prvs: <OSAPR01MB2210F5E41E5B744709C1F39DE5480@OSAPR01MB2210.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U1ODWfq9fVoj+a9EuA+UU0yhA0KmrPseH/Q2/hRGLi8Ynq6+J6TqyJRqDw+VSp84l8ClhCIikl1to+F5s/jmPGbJGw2A1OL0WqeNEHN8RMEtaKcByjV+KPbVlZ7tpfSuszBVel7ZVAV6J8hlkF41knmWR/ccB13IHUwZ3w3v+Wzdi1eS9X4g8GRN4teUK+Aus92Fu/KxvH+0yNpMYZwNLSCs326PFKzn/guFfgnarb3vRP11CW09dfS4u631TPR/WcjA5qUn7eq6JKNibulBnKfQBZZsdty+AlWwTlYb/ZUYmCXTvTjsM373n16o/XluLB5l1rpoBUyQgxAz/quIC8ie5GkYtGimOFO25j2vwKLxj/zI32D47u/877XNAEXs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSBPR01MB4582.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(4326008)(478600001)(8676002)(71200400001)(83380400001)(8936002)(6666004)(86362001)(2906002)(7696005)(55016002)(66946007)(76116006)(85182001)(6506007)(186003)(5660300002)(316002)(110136005)(66446008)(9686003)(66476007)(26005)(66556008)(64756008)(52536014)(33656002)(777600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: yKek8HLpnaNyi9UOyrNS1fT2DOhLX39MsI9Jz0Ia0Y8TyxpYv5FQwwPwKs7RMS8WLvlxTFkorZTfyspypPjnG9N4QlzsI4hQKISn6+yNT62vQZbAWQJLglOF7II+3qoLtfB6dacqqI/+iZg3wlyWRm2HtAhynjK+rEvCtqkLWkPvrZ6wVKMbo17fttX+rZLAmqoEQl9dGjziNWfymMgUR3cluCglqrbv4ks/UtPICuqPOGx6RLnJyGQVyiZX5wu0Nv6EPWIiNrXbESPAXhSCfeUSdLYmQXXWtjxgSDPS7maXwkXMLB9KUDW13f4+oxoU0yLvxAzdr8aKYmdRtWSc4YC2S0Xl96O0zfsG+9Gqxznk/44BjrnKMSopl5CS63iS/yRkU7Ck/VNlQwQySKel+Rh/pVhsEBFe7hf2LiO6oQtlEfbsDOJxvtlPHKxujDPYlnrNKF8unQFSeN05AtEx5xVkvzS8JpMerPP8DQ7ma1FJU4/N/2fstVR/i1aVAmQVVhuPQZXjrIwAgFJRInFjEC3kWe0q+bNgfTiD4/ZLyVm4fl6m8HtTyTlNEb/tpKq9fKChpkgePq7Uv/JWBYgyzz8nIefxWpbhaYhwnrksBrAU07FSyaQxl2bSIeyOz51oWAfbm7Cjg+iVpsPjoDmgBw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4582.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 306794f8-612d-45e1-e978-08d839e1c198
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 08:21:45.1044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rN16A0qn1cs45kgwVx9J9HYrkWUfxTFI2UpKwICwK55IjDyQOn02g8JukgiYXH6jUByWIseNxPrWkFXw2tOafSYcHy6M87wc8aaec36Rs8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2210
Received-SPF: pass client-ip=68.232.156.101;
 envelope-from=misono.tomohiro@fujitsu.com; helo=esa14.fujitsucc.c3s2.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 04:21:50
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: virtio-fs-list <virtio-fs@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Right now we enable remote posix locks by default. That means when guest =
does a posix lock it sends request to server
> (virtiofsd). But currently we only support non-blocking posix lock and re=
turn -EOPNOTSUPP for blocking version.
>=20
> This means that existing applications which are doing blocking posix lock=
s get -EOPNOTSUPP and fail. To avoid this,
> people have been running virtiosd with option "-o no_posix_lock". For new=
 users it is still a surprise and trial and error
> takes them to this option.
>=20
> Given posix lock implementation is not complete in virtiofsd, disable it =
by default. This means that posix locks will work
> with-in applications in a guest but not across guests. Anyway we don't su=
pport sharing filesystem among different guests
> yet in virtiofs so this should not lead to any kind of surprise or regres=
sion and will make life little easier for virtiofs users.
>=20
> Reported-by: Aa Aa <jimbothom@yandex.com>
> Suggested-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

We should update docs/tools/virtiofsd.rst as well. Given that:
 Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>


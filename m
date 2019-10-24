Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE9ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:20:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B3620684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QtiOtFx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B3620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNaEO-0003gn-VE
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <den@virtuozzo.com>) id 1iNZtm-0002eA-6z
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1iNZtl-0001PG-31
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:59:18 -0400
Received: from mail-db5eur03on070b.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::70b]:62407
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>)
 id 1iNZth-0001Ko-66; Thu, 24 Oct 2019 05:59:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BS+F+P/3uZViK6/HBtmLjzJztpmkhJHRYBY8CA6WpJ633cVvLhNhsFW/Bdz9CsrbtXGDPiLn+5qdzdia2yob09RL+lILkUH8IeKAHC8kamGSGFGxjdd19NSiMydoH4MymiB//qAeRp42qFna9jyH1HLokzlLyE56Bvf9887SmfcLnDjt2093ZP2kX4aHvRG2j4Dh0z82vbWb/RKywRa/QqHGdQJ2h5kwBJPd/GcD00TktTYATvpVb8QxJE/kFFys4agwS+8VD/u4h0puF8cteMOQ5UdlEYJU2PQs6ohaZs5VO5vzJn+hqfmsVb54o5PJgfzVsXfSuO/A0wxHHKHw6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0qaHlVF/q3N1pnN5ZZOLZGXWoLNUSdE73M3fOJGfn0=;
 b=QWa4sRtsgTD9nTZvH3W+iHSohabgnLOIzHI2d7mgCq3X4Kn9hImA1EN2ypbJpFGiVFdyqKGc+n2o7IEJCRMPxvNmuFOwVH94kiGzu1Y90QgqruA88jzUbkWtSRGPCdW0BSol0Ihm6HMVwjCqK0Bc/tBKTi9hYf58gOUta1uaPmhHiJdPCof7JZufYXbiRCChyRWD8e9YsFV2xdccdd/O4QFbWnmrCNyRxW0BMQP05gUo0FRQDcdtP+cSsXsMA20WOGGkk+20a9l/si8vNMG0h9DtfGvZo2bXGRUNQNwe6ceSXSPBP64NDbOEhNUK50YuQc2iYCD+VfMBg+fMDX4ulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0qaHlVF/q3N1pnN5ZZOLZGXWoLNUSdE73M3fOJGfn0=;
 b=QtiOtFx6Klju4wQPsqHwpqmxo4EZTP4LLZQtIEzC9RyamhCABANaxu7qqbtaSde8hUIpFOELtvps0OtwoJEoT4fDv9LPFRB/KBfq7RP7raZVghwdsSstd5NWOw2YrxRy+yThP+j5hbjUbJePCcLrE85QkDztV3R6YlW6lxo/H3c=
Received: from DB6PR0801MB1702.eurprd08.prod.outlook.com (10.169.221.21) by
 DB6PR0801MB2103.eurprd08.prod.outlook.com (10.168.87.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Thu, 24 Oct 2019 09:59:11 +0000
Received: from DB6PR0801MB1702.eurprd08.prod.outlook.com
 ([fe80::f849:2ba0:2a0b:5b34]) by DB6PR0801MB1702.eurprd08.prod.outlook.com
 ([fe80::f849:2ba0:2a0b:5b34%7]) with mapi id 15.20.2347.030; Thu, 24 Oct 2019
 09:59:10 +0000
From: Denis Lunev <den@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 1/3] coroutine: Add qemu_co_mutex_assert_locked()
Thread-Topic: [PATCH 1/3] coroutine: Add qemu_co_mutex_assert_locked()
Thread-Index: AQHVibZNfmcmX5bV50OrRXkOJjjwradpj+yA
Date: Thu, 24 Oct 2019 09:59:10 +0000
Message-ID: <173e0a00-34e3-522a-4e9b-a33661e3f5ba@virtuozzo.com>
References: <20191023152620.13166-1-kwolf@redhat.com>
 <20191023152620.13166-2-kwolf@redhat.com>
In-Reply-To: <20191023152620.13166-2-kwolf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P195CA0021.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::31)
 To DB6PR0801MB1702.eurprd08.prod.outlook.com
 (2603:10a6:4:2f::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cacd686-f668-46ae-7d99-08d75868d131
x-ms-traffictypediagnostic: DB6PR0801MB2103:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0801MB2103BC16D25195E58E444195B66A0@DB6PR0801MB2103.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(396003)(376002)(136003)(39840400004)(51444003)(199004)(189003)(25786009)(71200400001)(14454004)(478600001)(256004)(81156014)(229853002)(305945005)(8676002)(36756003)(7736002)(486006)(54906003)(71190400001)(81166006)(14444005)(6486002)(6246003)(6436002)(5660300002)(6512007)(11346002)(2616005)(8936002)(476003)(76176011)(110136005)(86362001)(386003)(26005)(102836004)(53546011)(31686004)(4326008)(52116002)(186003)(446003)(99286004)(31696002)(316002)(66066001)(2906002)(66446008)(64756008)(66556008)(66476007)(66946007)(3846002)(6116002)(2501003)(6506007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB6PR0801MB2103;
 H:DB6PR0801MB1702.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 11MBOpK0omciYd/VfPfBSRA6kgzxYGFhynYvw9T/+BPyFmfONLdzqO+gdJGLgEQ6cWgsxCsT1+jXN0kqZJ4hMHFxNUKOmCYhiiE0T3diX69bn3uHeZ0ptd2gOu5XUJDPmtiAczy/Y2N7vbuee8Ug8rjtJzYzk+Vb4AJFsKsXN7ZpRYMnrVTkoWjnPEM3EX6ctJaFRO1nQa4eSdh8eM4MBVm4Apb3BLeursJ14U3MQPJYEv0tZSGrqbfNQSUhGL9t01BjPzA0e+iy9chH4oRvk50QJ8nafJmuZ9UAgAjWdSZoj47R6q9BkUwF/z1ShT5gi9aK6p57vcdpkwsmmwbJKM/Z0Hb4bSYqq4I56N1SARWdmd/UzN+gFJS1eftidRvwyI//AF3YWXHujCWmOfro399W6VSYOS4LyhTMJR3QYpkF/YYEl5DgESqu6KaOrR1k
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <2191336879F72543A4CB45BEB578DA80@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cacd686-f668-46ae-7d99-08d75868d131
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 09:59:10.7128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: umM64tc478rgNmufd27cNVXRbKcxAEIIRaZFH8BdZv4kCKgOq0g3FCQm6d0tga5s5gjocNj41YDTdPbFYRy1Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2103
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0a::70b
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
Cc: "psyhomb@gmail.com" <psyhomb@gmail.com>,
 "michael@weiser.dinsnail.net" <michael@weiser.dinsnail.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 6:26 PM, Kevin Wolf wrote:
> Some functions require that the caller holds a certain CoMutex for them
> to operate correctly. Add a function so that they can assert the lock is
> really held.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qemu/coroutine.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
> index 9801e7f5a4..a36bcfe5c8 100644
> --- a/include/qemu/coroutine.h
> +++ b/include/qemu/coroutine.h
> @@ -167,6 +167,13 @@ void coroutine_fn qemu_co_mutex_lock(CoMutex *mutex)=
;
>   */
>  void coroutine_fn qemu_co_mutex_unlock(CoMutex *mutex);
> =20
> +/**
> + * Assert that the current coroutine holds @mutex.
> + */
> +static inline coroutine_fn void qemu_co_mutex_assert_locked(CoMutex *mut=
ex)
> +{
> +    assert(mutex->locked && mutex->holder =3D=3D qemu_coroutine_self());
> +}
> =20
>  /**
>   * CoQueues are a mechanism to queue coroutines in order to continue exe=
cuting
I think that we should use atomic_read(&mutex->locked) and require barriers
working with holder.

Den


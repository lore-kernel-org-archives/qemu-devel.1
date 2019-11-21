Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C976EC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 925B92089D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TwLuCX6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 925B92089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXm8f-0006uT-Nn
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 08:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53563)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXm71-0005f0-Tz
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:03:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXm6w-0004TW-LH
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:03:07 -0500
Received: from mail-eopbgr50125.outbound.protection.outlook.com
 ([40.107.5.125]:25070 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iXm6v-0004SB-Uo; Thu, 21 Nov 2019 08:03:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SupmMRA61bta/58m9BtNJG2Am5T/HZgwk0XoYT+Zjpu+KEzWFmAWI3fXq+GB73Zg/teBDUoWqTHqGHVQoQfN35nCH7ZePFqq7912hnbZxv8wLUHElj53Oq8gWQDorL4QcIdQk9ZLXZjP04AtWOD0/38j7MOZ+sRABL30F947N+Yn/sxGOHPM/gQdCOD4GqjUEvDutPdIO0EH+cpvy/YIFv4r46nDwVKDq86Qnpv2VIygXpZb3Zu/HZy4AWGdobd+6x5OGvT7PmQWJfZSnCPSWKS5CxejTnN7C51g9VHQa/BMq3z9NMpvVUGfpM7vG0d/IDJ8ARd9qA7UyQI47P5OKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOILUkwJGcQySz5xlgX7hTQpadF8sqcbxyiwviVorHc=;
 b=DJgydeqXHlb52dq9K/smlmA6r8hs5DFRgLUx8kaiNjlllmqHmJb9zhIuqn1o/WMCkLLGuYpxij8W5jFQ6W0CzW/wggiV3F6YvLGnmYVoCSEMl2StFSVlz4hRFEVMVvHmIpuV3PTv2iZyeZrwEMjzC2NfBZ5HjErGmWBhJXq3qK5hndk2iiFDUTqEgmapAFFQI/3M03vQ03fL/7b7ymKFC91B0Ita7OeSq9t+ywZKiJOx63aH5ExsvLh74VfC1ueTjJLFoUIB+OnyBI9cElzEvuCnP7GTh/gHzUWSHkEWjXwYqg4WofN/YFWw3OmXSO2+LgGmuwntdz3wmyykqFqWVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOILUkwJGcQySz5xlgX7hTQpadF8sqcbxyiwviVorHc=;
 b=TwLuCX6PAXsjInQZZqJA5e2RkAFqWKWnbgIAqm64HdCy6Q5KFSIxGnVeI67PWOLlS7yST3vVdrzSNTYDmSfy11JEVUfWt5A5HU2acZMQJFzl8DFFATeezsda6OTcm598c5tacoP4ZcKrNxhbEwd3+EkWYV6/SVZpCQZfzTma/PM=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3365.eurprd08.prod.outlook.com (20.177.112.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Thu, 21 Nov 2019 13:02:58 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 13:02:58 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 6/6] iotests: Test committing to short backing file
Thread-Topic: [PATCH v2 6/6] iotests: Test committing to short backing file
Thread-Index: AQHVn9KxRltA7uNPbUqM02ssz4EKHKeVn5cAgAAAVgD//+EpgIAAF0AA
Date: Thu, 21 Nov 2019 13:02:58 +0000
Message-ID: <c2b90dda-d5e7-d2e5-73fd-ba9110ccb50a@virtuozzo.com>
References: <20191120184501.28159-1-kwolf@redhat.com>
 <20191120184501.28159-7-kwolf@redhat.com>
 <832ab7bc-07a2-bbe0-a567-71d416f8c1d3@virtuozzo.com>
 <f502ca13-0840-cb06-150a-cbf605a6c1ff@virtuozzo.com>
 <20191121113943.GF6007@linux.fritz.box>
In-Reply-To: <20191121113943.GF6007@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0011.eurprd03.prod.outlook.com
 (2603:10a6:3:76::21) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191121160256542
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d10180a-3f99-4693-9087-08d76e832202
x-ms-traffictypediagnostic: AM6PR08MB3365:
x-microsoft-antispam-prvs: <AM6PR08MB33652A541AED070C0A9DAB81C14E0@AM6PR08MB3365.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(346002)(136003)(39840400004)(376002)(199004)(189003)(6916009)(186003)(8676002)(2616005)(11346002)(81166006)(81156014)(6512007)(229853002)(36756003)(26005)(31686004)(52116002)(3846002)(102836004)(8936002)(25786009)(386003)(6506007)(76176011)(446003)(31696002)(66066001)(6246003)(6116002)(6486002)(64756008)(2906002)(478600001)(7736002)(66946007)(66476007)(66556008)(86362001)(5660300002)(316002)(6436002)(256004)(14454004)(14444005)(54906003)(71190400001)(71200400001)(66446008)(305945005)(4326008)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3365;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EaHU+WyHsZCTz4yNAo97RhjnM+RnZP0RLO+CkqouaSBllQYdMcKu1Xx8h0uRAROyolZmy7Z8WVEzcTwTq8xLrt3Kg2OVTRvuN43o3MHUfCe4yFnP6/aNon6arV7+8vZjZm5CXaFgqApLCY5+0umtYjxyO9S3TzDx+HLBb/9QPk8HubFZMC3NPMr/2tUwE0+uMJZmmWHezDPTixg+D92nDBE41bmg6P1Rn7r/8K4V0Dpo9H/4S36UL1XAPZ3Q1DwnNhgt8ePwsLC3JR/lGJkDWrExTJAuM9elcK94dQbhdVx7Q5u/jL5Pvlg9Wd9jePkg62DZiHagB/OlV9+QJYKVi2/POqZ4Wu3ssx79/rI8WDHPUf5UuIPfESrTrBu9ffJz5H2LoQwTBqvYoyv5wVHqYwbVS/RSlcaS8bAT+/UQ8fdzGtkyDeyrzxclvTT4gAQ2
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <3C46CF052BC2E941A8652DCFC54DE4D8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d10180a-3f99-4693-9087-08d76e832202
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 13:02:58.7758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J19oIZ2a7SN9KSu3yy0ZGhUfi4847Ofd0ZcVyesmropYUdZGGBNdXYqX98j1Qudc03XF+4dhw46YF0fD2d5KFPVwxJaPrllwgpNMm3BHV7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3365
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.125
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.11.2019 14:39, Kevin Wolf wrote:
> Am 21.11.2019 um 11:30 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 21.11.2019 13:28, Vladimir Sementsov-Ogievskiy wrote:
>>> 20.11.2019 21:45, Kevin Wolf wrote:
>>>> Signed-off-by: Kevin Wolf<kwolf@redhat.com>
>>>
>>> Hmm, allocating 7G will break tests on small disks, for example,
>>> on my 2G tmpfs.
>>>
>>> So, we probably should
>>> detect "+qemu-img: Failed to resize underlying file: Could not write ze=
ros for preallocation: No space left on device"
>>> errors and skip test. (better skip testcases, but it's not possible for=
 text-comparing tests :(
>>
>> Or could you just use smaller disks for resize? What is the purpose of s=
uch a big size?
>=20
> I want to exceed a 32 bit byte count for the write_zeroes operation so
> that it would break if patch 1 were missing. I guess I could reduce it
> to a little over 4 GB, but not less.
>=20
> Hm, though that is only for preallocation=3Doff, which shouldn't actually
> allocate the space anyway. I could use smaller sizes for falloc and
> full, even though I'm not sure if we're still testing these modes with
> sizes larger than INT_MAX anywhere.
>=20

Yes, preallocation=3Doff works for me with big disk, so this should work.


--=20
Best regards,
Vladimir


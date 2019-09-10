Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207B8C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:01:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFE06208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iTATHdPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE06208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7b5E-0000iH-Vf
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1i7b3e-0008HI-8r
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:59:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1i7b3c-0002cK-1L
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:59:25 -0400
Received: from mail-eopbgr150093.outbound.protection.outlook.com
 ([40.107.15.93]:19014 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1i7b3a-0002ZR-4Z; Tue, 10 Sep 2019 03:59:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvxX04ryLtf6TLN7FevIA8POCh+RV/3tAwOkkX4Siu6+LCPyBsFNAYbTODP7XhnfUJiJHl+xr8zpe1NKjl+oVsOuAxdSW57KYehz0vIpN+YLUaVbLBcIWRMNnR/bjXI9clb/1EessK9tHxO+9UUtRD2wkrxkDQd7y1hVqky8SxcW6hTFSpv/L9H/g53V31mYsI2a/jDRI8GzJtfK3Q2ypWba05dHkgce5qXJF0J0dVhkG8S6GfDEeI2hQGl/x6GpJ6gEl9CCj392arDpgFfBRnliAFjY1H4KlX5R7D2LqEIUba3zcWfrJVAKyf1vVelsQ6vj3HYxowsS+EPttxpI0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npamdzRQ3t48vw79Fgm7YZaBs4+B7KH7tUdMZ1MjJVQ=;
 b=lvd3CGXMZD68DHA+ZYU6KhVqag4us9EDGUs+6qz5nKAjnmeSaPYVzX+bE4McSZl/InMbT1vPCLi7N5AEohs2XQzhEM62fQJqQ+jWYCv0le8QFbXjvFYrt8J+PhRsUXSjzqo/OAn0hnZrlR7C72qif7yAUqoNZPtyhcYAvCXD0Cx3wX86Y+BwUUSe9Z3MR5hts5Ggj5QSeLLeXQfiIOvUUZdw877DNQN2dR/ER5pSZHe/WmtHLUnLyTb0rAHYxC8NBOivcGApJuNMAliaoAVkthqZ0iSusVpzvTuK6HYBkilVZTPap4CTQM/orbe6j5qv5pdJk0NTUGEOFFhbuz1K7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npamdzRQ3t48vw79Fgm7YZaBs4+B7KH7tUdMZ1MjJVQ=;
 b=iTATHdPmVMkOyrVA31DKVvmrlLLn/B3JgjpsiNoum5WoL3YWSg7RHNwvglMwtvotsbUjjnWBdr50mJCmdkelCyLNbSR6H5g09AXUX6SDKPH1UP/Pm63veb80gOQ33wclia0SolOh9v0MrtTfmX4Mto23Oz16yDoj90ls0nLEm38=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB5539.eurprd08.prod.outlook.com (20.179.33.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Tue, 10 Sep 2019 07:59:17 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::302b:b479:1322:9d31]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::302b:b479:1322:9d31%5]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 07:59:16 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Thread-Topic: [Qemu-block] [PULL v2 01/16] qemu-io: add pattern file for write
 command
Thread-Index: AQHVZzO3yntHTPj950CSI6fiM5MkuKckgeSAgAABGwCAAAniAA==
Date: Tue, 10 Sep 2019 07:59:16 +0000
Message-ID: <e8911603-6a6c-066b-a5f7-0e4bca80fba3@virtuozzo.com>
References: <20190903133553.6500-1-mreitz@redhat.com>
 <20190903133553.6500-2-mreitz@redhat.com>
 <CAFEAcA_Gpw14Hjr7rW0Z-9Ngj5Udbxv0ZEMZAo0W0PT0nCwe2g@mail.gmail.com>
 <3311e590-d2c1-2388-27cf-981c917881ab@redhat.com>
 <20190910072354.GB4446@localhost.localdomain>
In-Reply-To: <20190910072354.GB4446@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-originating-ip: [94.233.241.117]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b63e8fac-a5bc-4631-268d-08d735c4c738
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB5539; 
x-ms-traffictypediagnostic: AM0PR08MB5539:
x-microsoft-antispam-prvs: <AM0PR08MB55395283C8431819318B5341CFB60@AM0PR08MB5539.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(376002)(39840400004)(366004)(136003)(51914003)(199004)(189003)(446003)(66946007)(5660300002)(66556008)(14454004)(186003)(6506007)(53546011)(76116006)(316002)(229853002)(110136005)(6486002)(99286004)(54906003)(31686004)(76176011)(25786009)(6436002)(478600001)(26005)(4744005)(3846002)(102836004)(6512007)(64756008)(6116002)(256004)(14444005)(53936002)(8676002)(7736002)(81166006)(81156014)(86362001)(31696002)(476003)(66066001)(8936002)(2616005)(6246003)(4326008)(36756003)(71200400001)(71190400001)(11346002)(66476007)(66446008)(486006)(305945005)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5539;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Vt9zr1KGDNw2nKjFdL5ZHhF5chipxQLZh/jHDnb4N0QKs+7bf4VSaOi4as4P6IRja1EnlvNpfm4U4qfpP3hrmUcHGNUZwwrkPUpwQMB9EKMOGi+fbo00QY5HHmp7/0Sv9lKRXxXtc+qvIrWl2hXBz/RI+4ceYQKdke2NV+Dj0WQVLF98CZOSAkez5H4PAhIYizz82cmfXyI4LoY3xSecxbjMl8YJhwfXaTFo7eL/jjB3BCZKO+6orHInsUIuL3o3V3/cN6EcllR59+gL7GrKYLZMOksegwVs3LOsFYjqKUnMN7r5n40GlNaGz7640bFZmgo899VXePS+kHC7vwnJMCtxhbOXudJ5XClheQRFFD+eD/VkbesRBPqzQ7CvLDZn+q7oa9z90HmUIUQHlz0/bqwDsMhMdNBqEZJr4H9fKLM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <CDFE4671CF76174AAEFE6DE4D5A55CB4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b63e8fac-a5bc-4631-268d-08d735c4c738
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 07:59:16.6743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z85vHzv6mndpsJJDjC1nP9pF8tMQpGMxF65eJ9Dx7wCh2ZjV9Gje5Q1nPUE1idivutPnJ7tqp7d9t2H0slOJGvrlANc0l55fuT/RQ1oscII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5539
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.93
Subject: Re: [Qemu-devel] [Qemu-block] [PULL v2 01/16] qemu-io: add pattern
 file for write command
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10.09.2019 10:23, Kevin Wolf wrote:
> Am 10.09.2019 um 09:19 hat Max Reitz geschrieben:
>> On 09.09.19 19:26, Peter Maydell wrote:
>>> On Tue, 3 Sep 2019 at 14:35, Max Reitz <mreitz@redhat.com> wrote:
>>>> From: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>>>
>>>> The patch allows to provide a pattern file for write
>>>> command. There was no similar ability before.
>>>>
>>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>>> Message-id: 20190820164616.4072-1-dplotnikov@virtuozzo.com
>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>> [mreitz: Keep optstring in alphabetical order]
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> Hi; Coverity finds a FILE* leak in this code (CID 1405303):
>> Thanks for the heads-up.  Denis, do you want to write a patch?
> I already sent one.
>
> Kevin

It's too late for me. :(

Denis



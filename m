Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3862C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 17:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1A0206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 17:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="S3S/F4NN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1A0206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUwDk-0007xr-05
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 12:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sunilmut@microsoft.com>) id 1iUwCV-0007GT-Gd
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 12:13:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sunilmut@microsoft.com>) id 1iUwCQ-0003yV-9K
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 12:13:02 -0500
Received: from mail-dm3nam03on0723.outbound.protection.outlook.com
 ([2a01:111:f400:fe49::723]:19104
 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sunilmut@microsoft.com>)
 id 1iUwCP-0003wy-Gu
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 12:12:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvPyfbaG4q7Wrxrbnx4oY7myzlKyCf7eZtxMXxuKXlqpl5QobZ22I4DDcH5uPwsUhbSb7XSUafGiA9/WcwYEmR8n4S894rrcRiZcSasBOWa3fsiksBFeW1IS4YskDoVcI22/jKWsavusAT1sLhgSi6QwMp01v1Do8AnKrWyLH5+Suen1sBkHEY4aPqPRbocdQ+VAUGSuco+ssJWpzdXP0HXWfbaIwq9eXfMg8t+kjfQSzsHp4yW2Bgz1lZqfXxd6zNNwdwBsap6Q5ioBg+Q+xPFxkub64y7lwGuljYhgWqXDPUQDwFTtiw+Gr7TACPXdjwLVl5DtOvJ5f/A0iVj8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRCv8nXfFrSF9ARHX2Z+SYwlSU0qXPLG/+zDVoQnPgU=;
 b=c5JfxUbl6N20orBkb+ozr52z6y3uv1wuqjEEWwd0Et+VSKK1C3N5xk9KLIA3SHSPeTTnaDNpPSDDtbkfymcrUQpei2JeEvRSrF5Y9p6mIdnVS9iXK4gMEsV7T2wb/W60Hs6cTBCHBDlygYODqDV6UpzYBi0r8U221yV7sdkMYDfcAE7S2UOsL6fNokbcnnRR92gXw/MlWS51hB6ORAgvmEW1Ke5CEE4r9H+eeh8oj0XGenfxmaULS1l83hzL7yDTCd45XihmUxDCUM85jMB731Ys7Fy9LCDQt5k4iz5PmCKpY6GH2feB1bcwny8fs9HEJXqdsNBZim4VUYlsROg6dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRCv8nXfFrSF9ARHX2Z+SYwlSU0qXPLG/+zDVoQnPgU=;
 b=S3S/F4NNxhXHExbOE//GuArxiPFuxM/3TqmafFxitzRvnKYHinGik/WPG6Gg7SPgw63fkvbxHGay53p/HVKlB6051qfo895h4McijCkXVoGWD0guW+YndEIPpcgYVt2Vtho+RNFYVWaPIOCUwdGOQi/4edRtvYol16x3BlJo8vY=
Received: from MW2PR2101MB1116.namprd21.prod.outlook.com (52.132.149.33) by
 MW2PR2101MB1018.namprd21.prod.outlook.com (52.132.146.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.6; Wed, 13 Nov 2019 17:12:53 +0000
Received: from MW2PR2101MB1116.namprd21.prod.outlook.com
 ([fe80::121:8a4f:76a8:fd9]) by MW2PR2101MB1116.namprd21.prod.outlook.com
 ([fe80::121:8a4f:76a8:fd9%6]) with mapi id 15.20.2474.008; Wed, 13 Nov 2019
 17:12:53 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Eduardo
 Habkost <ehabkost@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, "Justin
 Terry (VM)" <juterry@microsoft.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Subject: RE: [PATCH] WHPX: refactor load library
Thread-Topic: [PATCH] WHPX: refactor load library
Thread-Index: AdWWczxfa/0gc1vPTEu6TOvflPR6ngDFYVqAAAJR6gAAK5kfgAAA49dQ
Date: Wed, 13 Nov 2019 17:12:53 +0000
Message-ID: <MW2PR2101MB11164BEA7CC7CECF86E5E8C6C0760@MW2PR2101MB1116.namprd21.prod.outlook.com>
References: <MW2PR2101MB1116386CFE4628B6767D6CDBC07B0@MW2PR2101MB1116.namprd21.prod.outlook.com>
 <MW2PR2101MB1116C3DF422DB5E301B74AEEC0770@MW2PR2101MB1116.namprd21.prod.outlook.com>
 <20191112194738.GF3812@habkost.net>
 <017bdcd1-4058-c717-619a-d8362ac089b7@redhat.com>
In-Reply-To: <017bdcd1-4058-c717-619a-d8362ac089b7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sunilmut@microsoft.com; 
x-originating-ip: [2001:4898:80e8:8:1cef:6b41:87e5:6afe]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f28989a2-be66-4cbb-a507-08d7685cb85d
x-ms-traffictypediagnostic: MW2PR2101MB1018:|MW2PR2101MB1018:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB101861368605A30E255627B8C0760@MW2PR2101MB1018.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(39860400002)(376002)(346002)(396003)(189003)(199004)(102836004)(71200400001)(33656002)(76116006)(229853002)(478600001)(81166006)(10290500003)(966005)(8676002)(66946007)(14444005)(446003)(256004)(8990500004)(86362001)(71190400001)(6506007)(14454004)(11346002)(99286004)(81156014)(46003)(186003)(476003)(7696005)(76176011)(486006)(4326008)(6246003)(8936002)(6436002)(6306002)(9686003)(22452003)(54906003)(25786009)(64756008)(74316002)(110136005)(52536014)(66476007)(305945005)(316002)(10090500001)(5660300002)(6116002)(66556008)(55016002)(2906002)(66446008)(7736002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1018;
 H:MW2PR2101MB1116.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 45V02+Se+RNN8aJKK6Jsk/vDnQE/zBURMePar3zT9Lz3AQSAKuKSCmIVIHI05Nf7WrXqqgWNaHZPKCaq7SczNh5nBEXN5rH3xrkcASf/WtzBHrII1ECFjEQSxKRrvwnQAIzIwZ6wbpulid4yR4v0RlRo0QrelmmL4E1ba3AQ7t0z87OxS/ju4qWVybG1Lpjf+5nXpt7mnh9Q9+YhEmSeXjUty4j88ElPcwMOEt73V/TRmbGQgu9ulFVhhrWhQS3oMZoxG0I0xXazzESO0fLB52oJU4KGDcEp6bAOPnrXaDvZAXHVqpf/Up9Q/VP2Ls0AF1knkVnqcYBEbcVJAM4YrF10qYzkT8KaZiFQTVd8qLTmR49rBzpxlwP/Raz2aaRh16ycAzZLeWoUIvXKmr74FzJpKLbvPttOBMU1M8VI07DXHSQTGXVsojgPz5n/perm
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f28989a2-be66-4cbb-a507-08d7685cb85d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 17:12:53.4639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yCZnHPJDUtae6vkPUoWhCRawS+Vnd1fNmUhdZLLgJVBn7UqCt1AafCOjJq8xKMINo0vdBsmmaoQvn2Yvd097XqPGSJadJCRlrpBBSEp9mQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1018
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe49::723
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Can we wait for approval from the Microsoft legal department first?
> So we can start testing WHPX builds, and reduce the possibilities to
> introduce regressions.
>=20
> Testing is ready, we are waiting for Microsoft to merge, see:
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.m=
ail-archive.com%2Fqemu-
> devel%40nongnu.org%2Fmsg646351.html&amp;data=3D02%7C01%7Csunilmut%40micro=
soft.com%7C41ce65aedecb47c7bd0d08d76857937d
> %7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637092597657121219&amp;sdat=
a=3Dtu0zZDIzlG%2F9lEU4SJi11%2B%2FX1JdHUt6PD
> 2teeYCMZ%2B8%3D&amp;reserved=3D0
>=20

Yes, we have escalated this to the right set of teams, including the legal
team. We are working through the processes here internally and will
update once we have something. Meanwhile, it would be good to see if
we can get these patches in.

> >
> > Sunil, Justin, would you like to be listed as maintainers or
> > designated reviewers for the WHPX code in QEMU?
>=20
> Great idea!
It's a valid and good point. I am discussing this internally here and
will get back.



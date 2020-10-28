Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23881C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:35:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F74824687
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="H919Pw1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F74824687
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXhra-0007hC-6T
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 05:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1kXhor-0005i3-NP
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 05:32:42 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:42954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1kXhom-0003u7-JT
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 05:32:37 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 09S9DgI5012178; Wed, 28 Oct 2020 02:32:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=BxREBPOTZAG9+GBZrkW5HAHy1PDVprgZsmoBO0D18Po=;
 b=H919Pw1xXTchCsev1wThqfEolJ879HjrfOO7MFOCxqdKh3tHMzyQvQBL2k82QrTQhZ6D
 eZtu70HxbyXepTUsxnC4H0d/uZUWd9seh3XA3bjFBxMy9vV24UfuE9xRAhIMnEQ7HwxG
 3N4/G0YZ8UhhSwB6QmbdRWNPNr1gM6hSWvnd6mWjZ1L47Bqtv6wpDg9i30uMFzWXAKxQ
 kf35PnGwFNtD/EDnYM8fu25Jk6bYAx8PuzE3xxlJWR6Fsb6xCXP6r7HCwc4dV/IJflWF
 liX4ntSOZdRUTIydSAsDVUSMPCPGMf0oUl+Y7+om/fQ7ehrkAX28tJMNY1ADZOIFcSgZ fA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by mx0b-002c1b01.pphosted.com with ESMTP id 34ckkg02r8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2020 02:32:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jltYanFBdBz7wV9ZkDys48ocVRly23sxW1+Bc6SjrUE3fYrA/bYqyexG9hH4iXAmpHnYZw6aKY8JAPpbShsWUnX1Z4+sYVaCGyoTaUCVMyygUPohyxQ5HCDGSR7b2u3u2TRZbBQipB91uNpgySNp08+tzsosortLK7gGqGLQ+JFnKNEAsvQko508MzvUsEVUXv9De6nZ2k5s/Z6U+1AdPirGV6iN5Ozac3TdqFQgblhVIw2PodZY4EQB2ypG2ARfCPuDGjNVUyFN4TGZYZAd1eqDtCCdxgJXFWvigqhVRy8RseaOPNf3250NLhWaiVzentbu+NALuiNHy99J4WXT9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxREBPOTZAG9+GBZrkW5HAHy1PDVprgZsmoBO0D18Po=;
 b=UtwJ5DmqxsPUIoki/d1oY5IdighmAVv/DO/WONS9MWY1Oa6I9P25YN+MhNs8JRQcCztQDJu5rGdEy8BrbjmpH9wa7CBwFRIbnW3f20IYPZP3Fbx/lCP5drG8Ug/IpaDQL2Cy+TJ4wFEGrx/4sIQOQIetqQuC8dIydVn8g9mdQjQJprXAJIMfLUkZnHXeH0MQZHRr6S5sQBxCzvojwG+rXSTQRXI37wf5dBvfHhMsAMgH+uKFqTAmJE1LMiGuZBk+rl9exiS5mSayTviQGH7QnmVJAgPcRFuMPHp/SZyflaBLe4mCnCGygBl8gUJ96u3YPmtnHcC2J8mqLF2T9ecNeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MW2PR02MB3723.namprd02.prod.outlook.com (2603:10b6:907:2::32)
 by MWHPR0201MB3404.namprd02.prod.outlook.com (2603:10b6:301:7d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Wed, 28 Oct
 2020 09:32:17 +0000
Received: from MW2PR02MB3723.namprd02.prod.outlook.com
 ([fe80::81cb:c77a:ef0:84e0]) by MW2PR02MB3723.namprd02.prod.outlook.com
 ([fe80::81cb:c77a:ef0:84e0%5]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 09:32:17 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: Out-of-Process Device Emulation session at KVM Forum 2020
Thread-Topic: Out-of-Process Device Emulation session at KVM Forum 2020
Thread-Index: AQHWrHPc6iSycZlvN0m0r0GCbG+HcamsvrSQ
Date: Wed, 28 Oct 2020 09:32:17 +0000
Message-ID: <MW2PR02MB3723F97DA47F8747CB92E4418B170@MW2PR02MB3723.namprd02.prod.outlook.com>
References: <20201027151400.GA138065@stefanha-x1.localdomain>
In-Reply-To: <20201027151400.GA138065@stefanha-x1.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [78.149.9.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3253d52d-a8ba-4289-29bf-08d87b245ca2
x-ms-traffictypediagnostic: MWHPR0201MB3404:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR0201MB3404D22036CAB7E52B39D9408B170@MWHPR0201MB3404.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tfmTNJLLmI6EnVOyN1XdVKhnttNxzdSYVUGk7maqsinf5GSEILZ968G3fag7oqPdUpj1ZkTXMeow9DCzumpAh2in2Ut2pk+/oFRnf/m1ivWNNnKBCCXWV4AUB689pBjyfxGKuLKUydV2S05WZxWoCAgg3uBQRdXg3ck7uL7KT9VIY9yaQe8eum78vhArmtGOqdQK3oNy3TQWTd0X8xAbPb18xo2xvWtogDeQUtpjt9g/qEKvBg+NjpIgbDRDmUFSk+iJVgQnVMHUjFow6Ii4a5dahMh+DX+62VvZMD559A11mcfM5Qqgl3bF8TjOgstBlEdCi+xxY2C843BDwaUzqIJYRNhyVt8VUzi8paIYWCte/kg5eeSD5O0iCEAiolK5hvf3m0OPnYQVYLIro/2diQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR02MB3723.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(366004)(396003)(376002)(346002)(39860400002)(66446008)(33656002)(5660300002)(52536014)(110136005)(71200400001)(64756008)(9686003)(2906002)(8936002)(44832011)(54906003)(8676002)(55016002)(53546011)(316002)(186003)(55236004)(7416002)(7696005)(6506007)(66476007)(76116006)(66946007)(66556008)(86362001)(26005)(478600001)(4326008)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: e/DWSdoJlns+Hkt75phIpUrR14dD9pZl7O800g06n2ZaJ0V1dh6HGjMp9d/EBR9CfJJkH6ut7CmOOgOxmNWh90H4RZpvWZGfGxFiEaTbAOUVYgnZjrUWrvTUyOYTrOxdEF9SGsUxvJbKtx/1QKlmOYWD6vOyuj8lOWJMrIGSgPhH1d8Gzr1xh3DevClhqX3fai39dY1MEOeHRBTNRDCwcSgjB0+8EUY8pcz617osg+BbDzLw6gG+EXb0zOtwyJ1/tO99QoPe7TpvsVU0D7A41Soc6oxxMm+7lKXxohFLYOtg3U5ygfHAcEN8K84xTNZx5DbpU//A9gr3+DMhfUfAiMQ5BFEU0yiTtSyxprJIaKb2R1jo9N39STof3fU4aI303IfYiddNEBJKXjoLC7GMkpmDydI0eqq9iwBkc4hCNsqetFRclVyK4eqIutyOxuvejZ/74dW+UvY1gKRGWo1DrIU+oALz1J61Rc1XAmmGvaSDgJaaMm3IcegX0cyMVD73UeJ5pq+RyeFNiAkU6TM+EGSXpIx5Te1yQ6Ja4ekOSEfUmW3iDXTSCUEuPx2vk4Sa4kIpKE5saON2WAVGXwClvdq63Ng9hPuZudLZvl+aW4G9fMDoF1h7KHrS1QfZ03A1/X0fqJWiPTl9VzK7UOMn8g==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR02MB3723.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3253d52d-a8ba-4289-29bf-08d87b245ca2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 09:32:17.5246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NkU3H0YHY7W7FYH6+BBSWHg7fU7WNNHYCMsswMV69BLinqA4wPaI7TvMDZb3H9flnLpRSt9MVJeNkIBSwF29je/bj18jawaaD4XNPP4M3L0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3404
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-10-28_04:2020-10-26,
 2020-10-28 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 05:32:29
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 "mst@redhat.com" <mtsirkin@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "slp@redhat.com" <slp@redhat.com>, "kraxel@redhat.com" <kraxel@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Stefan Hajnoczi <stefanha@redhat.com>
> Sent: 27 October 2020 15:14
> To: qemu-devel@nongnu.org
> Cc: Alex Benn=E9e <alex.bennee@linaro.org>; mst@redhat.com
> <mtsirkin@redhat.com>; john.g.johnson@oracle.com; Elena Ufimtseva
> <elena.ufimtseva@oracle.com>; kraxel@redhat.com;
> jag.raman@oracle.com; Thanos Makatos <thanos.makatos@nutanix.com>;
> Felipe Franciosi <felipe@nutanix.com>; Marc-Andr=E9 Lureau
> <marcandre.lureau@redhat.com>; slp@redhat.com; David Gibson
> <david@gibson.dropbear.id.au>
> Subject: Out-of-Process Device Emulation session at KVM Forum 2020
>=20
> There will be a birds-of-a-feather session at KVM Forum, a chance for
> us to get together and discuss Out-of-Process Device Emulation.
>=20
> Please send suggestions for the agenda!
>=20
> These sessions are a good opportunity to reach agreement on topics that
> are hard to discuss via mailing lists.
>=20
> Ideas:
>  * How will we decide that the protocol is stable? Can third-party
>    applications like DPDK/SPDK use the protocol in the meantime?
>  * QEMU build system requirements: how to configure and build device
>    emulator binaries?
>  * Common sandboxing solution shared between C and Rust-based binaries?
>    minijail (https://github.com/google/minijail)? bubblewrap
>    (https://github.com/containers/bubblewrap)? systemd-run?
>=20
> Stefan

Here are a couple of issues we'd also like to talk about:

Fast switching from polling to interrupt-based notifications: when a single
process is emulating multiple devices then it might be more efficient to po=
ll
instead of relying on interrupts for notifications. However, during periods=
 when
the guests are mostly idle, polling might unnecessary, so we'd like to be a=
ble
switch to interrupt-based notifications at a low cost.

Device throttling during live migration: a device can easily dirty huge amo=
unts
of guest RAM which results in live migration taking too long or making it h=
ard
to estimate progress. Ideally, we'd like to be able to instruct an out-of-p=
rocess
device emulator to make sure it won't dirty too many guest pages during a
specified window of time.


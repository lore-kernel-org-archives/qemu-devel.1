Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1C2CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC86222C5
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="VxpFG6ul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC86222C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLS5g-0000lb-Pf
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 09:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1iLO07-0006Lr-F1
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 04:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1iLO05-0002VI-Mr
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 04:52:46 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90]:13950)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1iLO05-0002TW-93
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 04:52:45 -0400
IronPort-SDR: TvwyDs5hKwW0xLB8/gway/boXHO/hd+oTz9eqYUaw31e8kKT/w5cc+Eh3tCy/HgiW70lskYjvS
 tizczSTZDR2e4DaGPxLYJQ4qPZMze+7YdzQELL38JwDwjWoCa2Ixv1l8sOj8qN4DayoyR3ukgH
 KBdz5CIsWWEcHwAjeR3BfjTiOcN2ZQYrVY5fym83W7jU7lxY9hlM8RBbKWYPyYSHQsFXPm6ctu
 AlcLEOfUtFSjCb/zafXssksTMidbssIq1UNyk8ReedKCPPKI8nSzD61mrzBgyQRnipHWE0mBgL
 Jy0=
X-IronPort-AV: E=McAfee;i="6000,8403,9413"; a="6984672"
X-IronPort-AV: E=Sophos;i="5.67,311,1566831600"; 
   d="scan'208";a="6984672"
Received: from mail-os2jpn01lp2058.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.58])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA384;
 18 Oct 2019 17:52:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWTCnz8FMvrfKYtmfhvcXNH4U5haMAnkdXM4vSDI36+qBahaQz7slF9aXjt+TYN5EGSDhfPrAPASJqiuEJ4bs0F22Egoc6Uimfd9gqaBRGHCqCxoa4FRmV8RiBZXY8t3G/EzFTlICWmw4kdO/zsLeUB5u0IVhRcLyNrepxwGn5pyCDnWNBpCMQPUlpj1PDTi4HqXIR1tP7QqM9nrPf4oc+ZGOeoXGYmuRb0a3fjBmeqqUlG/S6c3WCog7ZFE/7Cbu3wZo5OXcdy/xciI50BNV1+FK2U1fScHeuuGnnG+sWxYdsKogRIj13BesdRWRiXJK+hDdd8r/aguXQHi3NuKCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juc6GNuKcyXpuUYv6naPnNX7n61FrJvqDNyd1qQNmfA=;
 b=KimEBl+s/AGELrwV90u0mcNjqnfEB3DIpZPyTJpuV0KRpQDzLsGXfyoCzTk1fqkRoINKEebOZauEvTppVFbrI28u8pw44i6rQ3brabQCDugD9twIpdGvPoLfpcztF+n4+Qojlo+uO+vlgdzpYUSknpocunTgFNJvRUlZJCb2N5uaCrTU1RRQzEAhYkKvwitt5/4Fi5CgDhba5XvZ6Fbx6K7LJ38/j5bB2P2Jvw/2lCCyW7ut2QJXcXpBqzyEks1Wmux9qYBlrvxTJWs8ImdXumDvr+tcQWXQHS1oV0OEPnxlGOPXRLWeLmF/fCtVrnftGJpzDjj4YaLuYPs0FZIVIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juc6GNuKcyXpuUYv6naPnNX7n61FrJvqDNyd1qQNmfA=;
 b=VxpFG6ulXvLPv0wY1dGqQV50D0kntB5kNCtxWOGgj3Yxsk0Xu7wcWevT0ue3eaM9NBdjBeHMb0ESj7qUr1dR313nmGrFGx/lX7pApiLO6pfWymeT1QfmnTB0rRKATBj2O0CQc4sutuKKxr3Q1/qB77mrZIGUSMyBdL8LUsnKnRE=
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com (20.178.96.203) by
 OSBPR01MB3975.jpnprd01.prod.outlook.com (20.178.98.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.19; Fri, 18 Oct 2019 08:52:35 +0000
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::4cef:c2a5:21f3:9f3c]) by OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::4cef:c2a5:21f3:9f3c%5]) with mapi id 15.20.2347.024; Fri, 18 Oct 2019
 08:52:35 +0000
From: "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
To: 'Miklos Szeredi' <mszeredi@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>
Subject: RE: [Virtio-fs] [PATCH 0/2] virtiofsd: Two fix for xattr operation
Thread-Topic: [Virtio-fs] [PATCH 0/2] virtiofsd: Two fix for xattr operation
Thread-Index: AQHVhAzKQZ3C+LAwOU6GUtVH7zwjF6denLQAgAAV7YCAAE/kgIAACs2AgADyiACAAAqG4A==
Date: Fri, 18 Oct 2019 08:51:20 +0000
Deferred-Delivery: Fri, 18 Oct 2019 08:52:18 +0000
Message-ID: <OSBPR01MB37835DC3A2F179AFD3A9074BE56C0@OSBPR01MB3783.jpnprd01.prod.outlook.com>
References: <20191016103754.2047-1-misono.tomohiro@jp.fujitsu.com>
 <20191017100528.GA24790@stefanha-x1.localdomain>
 <CAOssrKfR=sfE1RzOXzvPbdQg-g7i5-f8W9y8bWFnO=gyJ2VMsg@mail.gmail.com>
 <20191017160953.GC1266@stefanha-x1.localdomain>
 <CAOssrKejcfVWXw6Nu1owyEeofTdVp6BNx4bL91ma2g7bg9-nmg@mail.gmail.com>
 <CAOssrKdbAT5s=CYG6PBtE6OYdqgwG8vp9T6QMJpwZ7X3tKjPmg@mail.gmail.com>
In-Reply-To: <CAOssrKdbAT5s=CYG6PBtE6OYdqgwG8vp9T6QMJpwZ7X3tKjPmg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 0e05e2926b934e8183c712e3e83f4af2
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=misono.tomohiro@fujitsu.com; 
x-originating-ip: [114.160.30.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccc9d58b-0f65-41f4-ba00-08d753a885a3
x-ms-traffictypediagnostic: OSBPR01MB3975:
x-microsoft-antispam-prvs: <OSBPR01MB39751303780B5974797FA206E56C0@OSBPR01MB3975.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(66556008)(66946007)(71200400001)(71190400001)(26005)(102836004)(11346002)(446003)(2906002)(25786009)(476003)(6666004)(186003)(478600001)(14454004)(66476007)(64756008)(316002)(76116006)(66446008)(9686003)(256004)(55016002)(8676002)(229853002)(74316002)(5024004)(486006)(6246003)(305945005)(8936002)(54906003)(7736002)(86362001)(81156014)(6436002)(52536014)(76176011)(7696005)(99286004)(3846002)(85182001)(5660300002)(66066001)(6116002)(33656002)(81166006)(110136005)(4326008)(6506007)(4744005)(777600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:OSBPR01MB3975;
 H:OSBPR01MB3783.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dlpnj+GNdAqdQ+thxSKWqIDCCJNRUnMEAyAH+4jTeO31yrydu1s82CEfnutAqisAWBrbpPPA1TkGcHr3RbgBEo4vHx1rCpLj8iR6ityE0WqnX0DJZjBkhOcx+lWYM9cKNQ2UnazlPxND251GCcZbvVjhCIhjtSLb5Y17m0GLiGaqD43ykkNJvaNrDIYbSnVzMCYQDUN7jcRQCBy6vFsKyV88WqSD7LPVjxP9TcOy/OxBusXEE1sWmfYBjZigy14mhjncjcrn+j5Z4ur6PtroR6DODaHfd3tVOyykkvetEeRjJLfjvD+5R3N0fOwF8P0L5IOlZOIi6HVQyCJr0lJo1eZ7wwX6jA3XIZ42HoDNaWus5RJ4OuBf2lx8CVTboQMZMEBrha+bt8FWFKTWh4TYslaa0rUZRo3qToiApJl3p6E=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc9d58b-0f65-41f4-ba00-08d753a885a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 08:52:35.6985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fVBwK4TLvsKzNfvy1859fXJZwJCB8esb4U3pU/ZxsTm02AoMdJc0hcQHMSveojBaBz1DKO43XRMn2iV2LF+l7/MmEzl09rz7F/HLWAedn+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3975
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.159.90
X-Mailman-Approved-At: Fri, 18 Oct 2019 09:12:18 -0400
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
Cc: "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiA+IEV2ZW4gc2ltcGxlcjogYWxsb3cgT19QQVRIIGRlc2NyaXB0b3JzIGZvciBmKnhhdHRyKCku
DQo+IA0KPiBBdHRhY2hlZCBwYXRjaC4gIFdpbGwgcG9zdCBzaG9ydGx5Lg0KPiANCj4gSG93ZXZl
ciwgSSB0aGluayBpdCB3b3VsZCBtYWtlIHNlbnNlIHRvIGZpeCB2aXJ0aW9mc2QgYXMgd2VsbCwg
YXMgdGhpcyB3aWxsIHRha2UgdGltZSB0byBwZXJjb2xhdGUgZG93biwgZXZlbiBpZiBBbCBkb2Vz
bid0IGZpbmQNCj4gYW55dGhpbmcgd3Jvbmcgd2l0aCBpdC4NCg0KVGhhbmtzIGZvciB5b3UgY29t
bWVudHMuDQoNClRob3VnaCBJJ20gc3RpbGwgbGVhcm5pbmcgdmlydGlvZnNkIGNvZGUsIGlmIG5v
Ym9keSB3aWxsIHRyeSBJJ20gd2lsbGluZyB0byB3b3JrIG9uIHRoaXMuDQoNCj4gRG9pbmcgdW5z
aGFyZShDTE9ORV9GUykgYWZ0ZXIgdGhyZWFkIHN0YXJ0dXAgc2VlbXMgc2FmZSwgdGhvdWdoIG11
c3QgYmUgY2FyZWZ1bCB0byBjaGFuZ2UgdGhlIHdvcmtpbmcgZGlyZWN0b3J5IHRvIHRoZSByb290
IG9mDQo+IHRoZSBtb3VudA0KPiAqYmVmb3JlKiBzdGFydGluZyBhbnkgdGhyZWFkcy4NCg0KSSB0
aGluayB3b3JraW5nIGRpcmVjdHJ5IGlzIGNoYW5nZWQgaW4gc2V0dXBfc2FuZGJveCgpIC0+IHNl
dHVwX21vdW50X25hbWVzcGFjZSgpIC0+IHNldHVwX3Bpdm90X3Jvb3QoKS4NClNvLCBjYW4gd2Ug
anVzdCBhZGQgdW5zaGFyZShDTE9ORV9GUykgaW4gZnZfcXVldWVfd29ya2VyKCk/DQoNClNvcnJ5
IGlmIEknbSB0b3RhbGx5IG1pc3VuZGVyc3Rvb2QgdGhlIHNpdHVhdGlvbi4NCg0KVGhhbmtzLA0K
TWlzb25vDQo=


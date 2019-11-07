Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A79C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD9C02178F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LhKYnILS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9C02178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSmAf-0007xL-H9
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 13:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1iSm5n-00031A-8K
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:01:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1iSm5e-0005mo-H6
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:01:05 -0500
Received: from mail-dm3nam03on0603.outbound.protection.outlook.com
 ([2a01:111:f400:fe49::603]:21216
 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1iSm5d-0005gc-WA
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:01:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3XfG6dLeERmrnRbNf5IGPO/3QQU/3QnfYZ6uecB+H5r0WOxhA7m9Sc+/TO8jNyiLsgzikghTHMNiuBTvNQ2ZxP6odOGnlm5fNQvYQr2lLNNnpEVtfPiNZkVu4uKrYl2Ztpys4nwSmrPT4D/paNvUYc6jELgKvUoddYYNov9e90aPbLpuNDx/LtYtepB+fa+6hGKx5m32E9JzbOH7O+TIbhyvEFloV4Y2R7tzmyUf884g04P/9g5NsRDLmpK1xUQKumIXx5T6co/RKLHJNy3qA+gE4k0NkF/vs+6Z2RMz8RgOuOK/Ok0ddztMTY7xhkplzLb6TbtXiawaeLT9OtdpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWQK/op92GJ6o3BnNFgX17C5v1XK8hOupLnsnxirdSU=;
 b=kYUT8omROAQnzcNVLjGS0EF3g4ZVBhpCSB/OCrPbVPmrM1Qqr72MInqiPcbudwQWqckzswbDvsW37TRrtpKy/jBp2O+lKTNVcSXt8yEMYawK7p2BfI4UwdsnPwzU1gutlc/CsrbPiBla/0By3uDcFE7dk6zYOI+SjscgaPYC8SgYSdPCwGP5G6lqR9caCL2OY1YgVhBAaS2m/gYVpx5uazHEuAu9veosonDHmQ/MnWDoz+TASmkKUt9n00VAmSktmjmQQOhUEcur9ZfrxSMeoH5gqWXnJ6J9fXz0AowI1nnPX5MvIhQPMwni3bVw/+ku6VLoJzXdRxWTyBPTNtwN+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWQK/op92GJ6o3BnNFgX17C5v1XK8hOupLnsnxirdSU=;
 b=LhKYnILSwSxj1QnPzynBXMKhh3hKtiAXNWn3rJ78gl2GmaW664VjGOioQXLhIHQXWi4+STew7e9RrB7pM6HEtzHdRiEzYFFrsFY8UVEZKmbSvTGovbqdeO76D+2rssrPPykTFUVlJFbwSQphVJBOMy/J0qa7vgnDib9leRRDVuA=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1196.namprd12.prod.outlook.com (10.168.237.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 18:00:51 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2430.023; Thu, 7 Nov 2019
 18:00:51 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com"
 <ehabkost@redhat.com>
Subject: [PATCH v2 0/2] Add support for 2nd generation AMD EPYC processors
Thread-Topic: [PATCH v2 0/2] Add support for 2nd generation AMD EPYC processors
Thread-Index: AQHVlZVKlNa46GpTP0GcaGPXkSHo3Q==
Date: Thu, 7 Nov 2019 18:00:51 +0000
Message-ID: <157314957337.23828.3860599077487615762.stgit@naples-babu.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0092.namprd12.prod.outlook.com
 (2603:10b6:802:21::27) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 97a451f6-de3e-400e-f711-08d763ac6d2f
x-ms-traffictypediagnostic: DM5PR12MB1196:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1196D663B85F164E9DACDBA295780@DM5PR12MB1196.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(189003)(199004)(66946007)(86362001)(66476007)(7736002)(66446008)(64756008)(66556008)(386003)(26005)(102836004)(52116002)(71190400001)(103116003)(25786009)(3846002)(2201001)(6116002)(6506007)(71200400001)(478600001)(256004)(14454004)(66066001)(966005)(8936002)(4744005)(110136005)(81166006)(81156014)(6306002)(6512007)(305945005)(2501003)(8676002)(5660300002)(186003)(99286004)(6486002)(476003)(4326008)(316002)(6436002)(486006)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1196;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wfGX1uwVmSxU9rXRPXVw9OHUEcX5SEEqMerIejmkhRlPOi4lfo3/IrPeaTa6IhVl2UzDGBwDDlfdrzMJiGoG1olvgyuj8pUDbLrJKoMI2M6zuEvFpJsWTI1emxfJB/iTYNdZrnK7d6hvVeeyGfLrR3hFpnzrB6DgRRCEV2MshgRalvzKgug8Y1YMpE8vsX6mHcC5muVxoAnDRGjWHriqdsV6hKW3J/DSZafbIssOEfwnNVcwUJKm7SJhIqiUTR7Qg3/kQkR9gijnsQ8h3j4yITaupQitu1TrzWEJi3n6NSqWrZLAjTTyDiPHhkXC/Bm6Kxg+i1IuKtISZbg57+X5+7nh53CvVjDXn49xU+Ma28tSCJcB0VkSMk7ZF1VL5oLitQFy2zQEz4fVS5fHELktozD56689nTz6MemmO8N1kyjBmp3HUuGCRFp6ySp5jNVxFvBLDk3i1m1E/QqUFSTyWwzPpndzaDD7Cs6HswB3l0k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55A98777EABA714BA331B810C4A5AC32@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a451f6-de3e-400e-f711-08d763ac6d2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 18:00:51.4788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7GfitWPMaPUXDb/iZkwjSopKb3dbM3HexcJBDQtoCX1DEis6dO7rA9FsAtOFfCZY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1196
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe49::603
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZvbGxvd2luZyBzZXJpZXMgYWRkcyB0aGUgc3VwcG9ydCBmb3IgMm5kIGdlbmVyYXRpb24g
QU1EIEVQWUMgUHJvY2Vzc29ycw0Kb24gcWVtdSBndWVzdHMuIFRoZSBtb2RlbCBkaXNwbGF5IG5h
bWUgZm9yIDJuZCBnZW5lcmF0aW9uIHdpbGwgYmUgRVBZQy1Sb21lLg0KDQpBbHNvIGZpeGVzIGZl
dyBtaXNzZWQgY3B1IGZlYXR1cmUgYml0cyBpbiAxc3QgZ2VuZXJhdGlvbiBFUFlDIG1vZGVscy4N
Cg0KVGhlIFJlZmVyZW5jZSBkb2N1bWVudHMgYXJlIGF2YWlsYWJsZSBhdA0KaHR0cHM6Ly9kZXZl
bG9wZXIuYW1kLmNvbS93cC1jb250ZW50L3Jlc291cmNlcy81NTgwM18wLjU0LVBVQi5wZGYNCmh0
dHBzOi8vd3d3LmFtZC5jb20vc3lzdGVtL2ZpbGVzL1RlY2hEb2NzLzI0NTk0LnBkZg0KDQotLS0N
CnYyOiBVc2VkIHRoZSB2ZXJzaW9uZWQgQ1BVIG1vZGVscyBpbnN0ZWFkIG9mIG1hY2hpbmUtdHlw
ZS1iYXNlZCBDUFUNCiAgICBjb21wYXRpYmlsaXR5IChjb21tZW50ZWQgYnkgRWR1YXJkbykuDQoN
CkJhYnUgTW9nZXIgKDIpOg0KICAgICAgaTM4NjogQWRkIG1pc3NpbmcgY3B1IGZlYXR1cmUgYml0
cyBpbiBFUFlDIG1vZGVsDQogICAgICBpMzg2OiBBZGQgMm5kIEdlbmVyYXRpb24gQU1EIEVQWUMg
cHJvY2Vzc29ycw0KDQoNCiB0YXJnZXQvaTM4Ni9jcHUuYyB8ICAxMTkgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCiB0YXJnZXQvaTM4Ni9jcHUu
aCB8ICAgIDIgKw0KIDIgZmlsZXMgY2hhbmdlZCwgMTE2IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pDQoNCi0tDQo=


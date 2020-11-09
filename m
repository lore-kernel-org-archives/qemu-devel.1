Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE96C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 12:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5464720789
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 12:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="jVbxeViK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5464720789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc5zH-0006gM-VL
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 07:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1kc5xF-0005aL-Rj
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 07:07:25 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:31928)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1kc5xB-0002T2-Uq
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 07:07:24 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0A9C3srd008536; Mon, 9 Nov 2020 04:07:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=Nclaw+JGjHer4nVd/yq2ts2yVjaKdj6sw3KVKjajIaI=;
 b=jVbxeViKp8h+cn4vJAQxZ/YdaofOpMI+9R02HXbi9UXhAg9PvL5zcCrhzEEGJ+0fneof
 WBsjp+LuvY0JBeT9jFiYroOI162dMFuHCdqBF6wDmVJYmsc99PGDCdkMY+yCyjh5b/H4
 rTEZnfBSlk1Ds3dJbbU4mrtavtVu/dJEjL8COeONqWlKvP18ezI/pi+SSpdMKwaE4kAk
 V/7zJeRB3lQIz0iJNSoxgyhEV+a24HRlmUF8fZnunm8iOuFYI8FdKyx6PuQrHigXb1JV
 jkiGT5eyIbpJmuUeUHLAi4yu54Os8dKWD5YlrKQXZ5ZKeGOetJa8pnyEsQiSiyjLnzn2 Tw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by mx0b-002c1b01.pphosted.com with ESMTP id 34nurak7c6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2020 04:07:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/GnivQf4vkGPFFFbfPsYRZwsjC0r7L1uWTzeV/UFaNj7eSFZ0RrZROffWAbk/qIwyG/W1NfAvZ4d0CJE8JEbY3vgCPXm6bMxT0ZKfJhJ3xsnDwlPsl4WF+Bl89urVEf/ov0kdNqecyZVAmGeBOJDNQoqScQ7SkIHxWc7+cfc5Y/O0iiAhduQPRRaDkzZRhxt2L2nalD4UY5olP4mkcXsJL5Dlb4Xjb7PHsRs2rHpZS+eqT9F0XdSKtwKi3J/dWhYBtD3oeWv+zUtlOxSgEAM3m6pSwwXjsBFRThKxVsV31Gx38NCvYDe24VsD8Zgow/LjMA70Xjhpi7tWiKALxcOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nclaw+JGjHer4nVd/yq2ts2yVjaKdj6sw3KVKjajIaI=;
 b=OE0ZThBZNskKrJNgQLoJYw+jRqtyMvhmP9EPXnOsITPVsq7+YsYrjnwiBKuJjCwuKZ17cFrk1QWp3I6HFs/an4ZZbdGkaBqqbUYyGdP6iIps3wSiueP+Lip1TopPMB2ol81bF3beVncR/8/6vP749ZvXcIbV/cP5H/9DHDsrhtelk4js6UCJcYQNNajlnadt65482Zv0rr7+bYR3X+xSleLbsKyV56vSN881bVJ4+tohJQHNXH8pe0CbvKlbUzRf3b0YgpD3qV9HO/2xvQUDPHSDWcBqclTkH9EqG1ZQdlazNrUd54DjaAqoHRzWcTUa4pl7KV/lyR4yKov7xwKv9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from SN1PR02MB3725.namprd02.prod.outlook.com (2603:10b6:802:32::10)
 by SN6PR02MB4720.namprd02.prod.outlook.com (2603:10b6:805:98::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Mon, 9 Nov
 2020 12:07:12 +0000
Received: from SN1PR02MB3725.namprd02.prod.outlook.com
 ([fe80::2849:50fb:b1b2:cc24]) by SN1PR02MB3725.namprd02.prod.outlook.com
 ([fe80::2849:50fb:b1b2:cc24%3]) with mapi id 15.20.3541.024; Mon, 9 Nov 2020
 12:07:12 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: John Levon <levon@movementarian.org>, John G Johnson
 <john.g.johnson@oracle.com>
Subject: RE: [PATCH v5] introduce vfio-user protocol specification
Thread-Topic: [PATCH v5] introduce vfio-user protocol specification
Thread-Index: AQHWrUTVjUvP5pU8VEG/kGG39PR4hqmtNlfQgAMsMQCABFmqAIAAA3UAgAABbyCABaLGgIACQ+iAgAMe6NA=
Date: Mon, 9 Nov 2020 12:07:11 +0000
Message-ID: <SN1PR02MB37256F5113DAD564D7156B498BEA0@SN1PR02MB3725.namprd02.prod.outlook.com>
References: <1594984851-59327-1-git-send-email-thanos.makatos@nutanix.com>
 <20201028161005.115810-1-thanos.makatos@nutanix.com>
 <SN1PR02MB3725C85DCD4BF652FF6FBB8D8B170@SN1PR02MB3725.namprd02.prod.outlook.com>
 <20201030170306.GA2544852@li1368-133.members.linode.com>
 <MW2PR02MB3723D387485067C65D31D2328B100@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20201102114126.GA54031@li1368-133.members.linode.com>
 <MW2PR02MB3723F4DDEA3486981AAA9F088B100@MW2PR02MB3723.namprd02.prod.outlook.com>
 <D1778D86-151D-4A67-9E2F-B49061A53FD3@oracle.com>
 <20201107122601.GA476582@li1368-133.members.linode.com>
In-Reply-To: <20201107122601.GA476582@li1368-133.members.linode.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: movementarian.org; dkim=none (message not signed)
 header.d=none;movementarian.org; dmarc=none action=none
 header.from=nutanix.com;
x-originating-ip: [78.149.9.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4351119-0d25-4e7d-7e01-08d884a7fd93
x-ms-traffictypediagnostic: SN6PR02MB4720:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR02MB47204DEA7D8482B961C722CF8BEA0@SN6PR02MB4720.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lPkWVIU6x6vePOeM/puNwHjTJWBq1wO2sGZ4qqs+N4qgVTvgSGmh5lSVSWj3reYji0aB7HSekv0uySaVWNAdmZ3uXCnrY0VRJoRMXdWGtm68SUJQ9LQDlw65jsMW3NUcxf8+YqiaU2mBdrYkN1079PQ/LdENER0wJdQfmzdmLrMWYRBV0LR29JxjjCFYBCfrKevhvFE1RUv+LYThCCPHXgTaAmaNtE53j7IFgQ1JdvYZp3oDY0ckgjh14BcbVJchXW9MnsnZ9Q0VDVU12/XIjEMjgSKqRuUq9e5/ufWg6DQqjFH132RrRLh2N7uwHJZp2moJ4t19Vs2Ycsk7gG0T3w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR02MB3725.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(396003)(346002)(136003)(376002)(366004)(6506007)(53546011)(33656002)(316002)(2906002)(7416002)(8936002)(7696005)(83380400001)(110136005)(44832011)(4326008)(54906003)(66946007)(86362001)(8676002)(76116006)(55016002)(478600001)(9686003)(26005)(64756008)(66556008)(66476007)(71200400001)(186003)(66446008)(5660300002)(52536014)(55236004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: TGj2DxHRql4Yb0Y74hHRV8DxZ8Bh8ZEp907IPvVduN93+aIT8Yh89A9JYKuFUdzoDjJQ8EkFhqLPS5o3pnWpvPkRh0oN5443OlT7s9TQSeC9tGwolTgadq2x2lntDL0jdZ4+7Y1LcuIGZ/H5h1S8vT5/N4XGKmAr2Exi0txpAXwRtFCZaQyiVK7qnHNjx6Jxu0lpmbUHynpnRuoFzK0GIqp9idQAW6zBChZrZkEbtPoww+XKwGg2wFW9K1JeyMRgL1QpforIGxz5qTv0ey2swAntloBHLAVMUPOIkJqEa56UaRv7fi6EwIz7oiQrJY/NZ3+R5VTfk5kFjRXcClKJAIM/7BwNggpGuKSBDe8Ll7E3k86nF99BDDy6veOSmXHuA2JYSfaYY4aJwvGnqIgI8THU7naBgHxDyl/61hrHXMr8zIdgmqdvKDH1iWcYKujrBDlfeJrqDAQ9WcYMgtyRdJkqLslyRuGx0oGb86CglmYdZIZBps0NItQMRh+JRKmvvQA0oA2ME+LuEpi7wVv8sJ7CJAt2m/CotdQdl611d4dxDLOZUxV9Y+ZhOaYzijbHceR0dOsZozm4OT+28CfX2piG2TBwYSmjtVSiutncZgj6wGo8VoLzAMqFPdVlYC7wR3uZ32SvX1K2yTTWJ/kMWQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR02MB3725.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4351119-0d25-4e7d-7e01-08d884a7fd93
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 12:07:12.0092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RmKtWJsN/Ai9XTbFyWyw7CtammBCoGPH1x5klhmqZNtvmoY9As7BZguKlbf0yggD3ggtXfwNcG7u6pEaCkxeEPC27WQhCei0HiIBpDbKD4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4720
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-09_02:2020-11-05,
 2020-11-09 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 07:07:20
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
Cc: "benjamin.walker@intel.com" <benjamin.walker@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "james.r.harris@intel.com" <james.r.harris@intel.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "yuvalkashtan@gmail.com" <yuvalkashtan@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "tina.zhang@intel.com" <tina.zhang@intel.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 "ismael@linux.com" <ismael@linux.com>,
 "Kanth.Ghatraju@oracle.com" <Kanth.Ghatraju@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 "xiuchun.lu@intel.com" <xiuchun.lu@intel.com>,
 "tomassetti.andrea@gmail.com" <tomassetti.andrea@gmail.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "changpeng.liu@intel.com" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9obiBMZXZvbiA8bGV2
b25AbW92ZW1lbnRhcmlhbi5vcmc+DQo+IFNlbnQ6IDA3IE5vdmVtYmVyIDIwMjAgMTI6MjYNCj4g
VG86IEpvaG4gRyBKb2huc29uIDxqb2huLmcuam9obnNvbkBvcmFjbGUuY29tPg0KPiBDYzogVGhh
bm9zIE1ha2F0b3MgPHRoYW5vcy5tYWthdG9zQG51dGFuaXguY29tPjsNCj4gYmVuamFtaW4ud2Fs
a2VyQGludGVsLmNvbTsgRWxlbmEgVWZpbXRzZXZhDQo+IDxlbGVuYS51ZmltdHNldmFAb3JhY2xl
LmNvbT47IHRvbWFzc2V0dGkuYW5kcmVhQGdtYWlsLmNvbTsNCj4gamFnLnJhbWFuQG9yYWNsZS5j
b207IGphbWVzLnIuaGFycmlzQGludGVsLmNvbTsgU3dhcG5pbCBJbmdsZQ0KPiA8c3dhcG5pbC5p
bmdsZUBudXRhbml4LmNvbT47IHl1dmFsa2FzaHRhbkBnbWFpbC5jb207DQo+IGtvbnJhZC53aWxr
QG9yYWNsZS5jb207IEthbnRoLkdoYXRyYWp1QG9yYWNsZS5jb207IHFlbXUtDQo+IGRldmVsQG5v
bmdudS5vcmc7IHRpbmEuemhhbmdAaW50ZWwuY29tOyBpc21hZWxAbGludXguY29tOw0KPiBhbGV4
LndpbGxpYW1zb25AcmVkaGF0LmNvbTsgU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQu
Y29tPjsNCj4gRmVsaXBlIEZyYW5jaW9zaSA8ZmVsaXBlQG51dGFuaXguY29tPjsgeGl1Y2h1bi5s
dUBpbnRlbC5jb207IE1hcmMtQW5kcsOpDQo+IEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUByZWRo
YXQuY29tPjsgUmFwaGFlbCBOb3J3aXR6DQo+IDxyYXBoYWVsLm5vcndpdHpAbnV0YW5peC5jb20+
OyBjaGFuZ3BlbmcubGl1QGludGVsLmNvbTsNCj4gZGdpbGJlcnRAcmVkaGF0LmNvbQ0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHY1XSBpbnRyb2R1Y2UgdmZpby11c2VyIHByb3RvY29sIHNwZWNpZmlj
YXRpb24NCj4gDQo+IE9uIFRodSwgTm92IDA1LCAyMDIwIGF0IDA1OjUwOjI3UE0gLTA4MDAsIEpv
aG4gRyBKb2huc29uIHdyb3RlOg0KPiANCj4gPiAJVGhlIGlkZWEgYmVoaW5kIHRoZSB2ZXJzaW9u
IElEcyBpcyB0byBpZGVudGlmeSBpbmNvbXBhdGlibGUgcHJvdG9jb2wNCj4gPiBjaGFuZ2VzIGFz
IG1ham9yIHZlcnNpb25zLCBhbmQgY29tcGF0aWJsZSBjaGFuZ2VzIGFzIG1pbm9yIHZlcnNpb25z
Lg0KPiBXaGF0DQo+ID4gd291bGQgYmUgdGhlIHB1cnBvc2Ugb2YgdGhlIHRoaXJkIHZlcnNpb24g
dHlwZT8NCj4gDQo+IFdlbGwsIGxpa2UgYW55IHBhdGNoIHZlcnNpb24sIGl0J2QgYmUgZm9yIGlk
ZW50aWZ5aW5nIHZlcnNpb25zIG9uIHRoZSBvdGhlciBzaWRlDQo+IGZvciByZXBvcnRpbmcsIGRl
YnVnZ2luZyBwdXJwb3Nlcy4gTm90IGltcGx5IGFueXRoaW5nIGFib3V0IHRoZSBwcm90b2NvbA0K
PiB2ZXJzaW9uLiBCdXQgaXQncyBub3QgYSBiaWcgZGVhbC4NCj4gDQo+ID4gCVRoZSB0aGluZyB0
aGF0IG1ha2VzIHBhcnNpbmcgdGhlIEpTT04gZWFzaWVyIGlzIGtub3dpbmcgdGhlIHZlcnNpb24N
Cj4gPiBiZWZvcmVoYW5kIHNvIHRoZSBwYXJzZXIga25vd3Mgd2hhdCBrZXlzIHRvIGV4cGVjdCwg
c28gSeKAmWQgbGlrZSB0bw0KPiBwcm9tb3RlDQo+ID4gbWFqb3IgYW5kIG1pbm9yIHRvIHNlcGFy
YXRlIGZpZWxkcyBpbiB0aGUgcGFja2V0IGZyb20gYmVpbmcgZW1iZWRkZWQgYXQNCj4gYW4NCj4g
PiBhcmJpdHJhcnkgcG9pbnRzIGluIHRoZSBKU09OIHN0cmluZy4NCj4gDQo+IEkgYWdyZWUgdGhh
dCdkIGJlIGEgc2Vuc2libGUgY2hhbmdlIChhbmQgdGhlbiBJIHdvbmRlciBpZiB0aGUgbGl0dGxl
IGJpdCBvZiBKU09ODQo+IGlzIGFjdHVhbGx5IHVzZWZ1bCBhbnkgbW9yZSkuDQoNClRoZSByZWFz
b24gd2h5IHRoZSBKU09OIHN0cmluZyBleGlzdHMgaXMgdGhhdCBpdCBzaW1wbGlmaWVzIGFkZGlu
ZyBpbmZvcm1hdGlvbiB0byB0aGUgdmVyc2lvbiwgc2hvdWxkIHdlIGV2ZXIgbmVlZCB0by4NCg0K
PiANCj4gPiA+PiBTbyBjYW4gd2Ugc3dpdGNoIGl0IG5vdyBzbyB0aGUgaW5pdGlhbCBzZXR1cCBp
cyBhIHNlbmQvcmVjdiB0b28/DQo+ID4gPg0KPiA+ID4gSSdtIGZpbmUgd2l0aCB0aGF0IGJ1dCB3
b3VsZCBmaXJzdCBsaWtlIHRvIGhlYXIgYmFjayBmcm9tIEpvaG4gaW4gY2FzZSBoZQ0KPiBvYmpl
Y3RzLg0KPiA+DQo+ID4NCj4gPiAJSSB0aGluayBJIHdyaXRlIHRoYXQgc2VjdGlvbiwgYW5kIGp1
c3Qgc3dpdGNoZWQgY2xpZW50IGFuZCBzZXJ2ZXIuICBUaGUNCj4gY29kZQ0KPiA+IGlzIHdyaXR0
ZW4gYXMgY2xpZW50IHByb3Bvc2VzLCBzZXJ2ZXIgcmVzcG9uZHM7IHRoaXMgaXMgdGhlIGJldHRl
ciBtb2RlbC4NCj4gDQo+IEhhaCwgZ3JlYXQsIHRoYW5rcy4NCj4gDQo+IHJlZ2FyZHMNCj4gam9o
bg0K


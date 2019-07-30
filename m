Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A247C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 14:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E81AB205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 14:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ceOB4IR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E81AB205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsT3K-0008ED-64
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 10:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60456)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hsT2i-0007kp-DK
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:23:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hsT2g-0005do-HN
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:23:56 -0400
Received: from mail-eopbgr130091.outbound.protection.outlook.com
 ([40.107.13.91]:45621 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hsT2g-0005cn-52
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:23:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuTW4uzsNNeLWeTWhioUyUZIe/Tdhvm2dtldgKOy7Nt0rMU0gyGJU03l2vUW4pCb+DNOHBUZFaZZMPQUoT9gUhXlQhFq225Gyn8B4DYK2ZUspiaLLUmV6XjMbmmSszRBrJqBw69dwNcO+wvQudYutOv7Rt+kehjQaYflym7tBkF3KhOaDch0l5SRozLcMQas476V7kViiE2+731g3JOGMHG6q7viY1IzpG+nPP1dAyXeQbu1be81wRZx6j7v9zzuZDI4l9AuEvwyNdbVOKb2u8A/RNk6BetfsSuya/Op4daR+Y7GR9U3YaUu+1mBNN20rT8RDIYd+uVnQ1sSLaJLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdOeDntyeGUai6pTGAPY4X4phd+XVDaqAUiKsfCY6FI=;
 b=hT6NbLkd0zcgiYt1mqf5iSoMLZdKuYhyEjS+ouwMZKzJdZG7uaDvL+VF0HcdVHFZxWIPjjRHie6lUEohOO7S7ZH/7UhXpgcEoKash9jtG8marHlwL/T6uUoz6BCLkl/gmToSQZexxLt8WtkM7PoAeCJ9eAG2vxA4MSfBTzXfDWLE9O4SQdo2ug+XYdsNvj8A71+lsn+rsfE/Q0Sb+tEhXfsg0pDUlgJ8CQI45wFWywhsVnFpUACL30nkILI05bkQw9meIq2vWoVaYucRZRZatZr4Ua+su5gJqetXgZ6y96NztA8JXZVaI6pH81tvSANhqeCxiVik5xJxMuYV2ec3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdOeDntyeGUai6pTGAPY4X4phd+XVDaqAUiKsfCY6FI=;
 b=ceOB4IR8CJqqJMZi1UJx839Uh01GqPkcZMv64+BUYdidWUw55Xmt5/lafoyVYucMcWbkej32N8PWMjHb357agnUUJC6OgmnVo9Un/6zk18UeYJYL61P4M6YpQY3OBTJi9TR6veBYyd4f7LfQ0jb+g1IVQ2pbfk3wncDHHB/MfqQ=
Received: from VI1PR08MB3760.eurprd08.prod.outlook.com (20.178.14.92) by
 VI1PR08MB2656.eurprd08.prod.outlook.com (10.175.245.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Tue, 30 Jul 2019 14:23:51 +0000
Received: from VI1PR08MB3760.eurprd08.prod.outlook.com
 ([fe80::39df:28b7:2704:36cc]) by VI1PR08MB3760.eurprd08.prod.outlook.com
 ([fe80::39df:28b7:2704:36cc%7]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 14:23:51 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com"
 <mreitz@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH v7] qemu-io: add pattern file for write
 command
Thread-Index: AQHVMxt0ixM9YPofcEO9utIE230YxqbjXo6A
Date: Tue, 30 Jul 2019 14:23:50 +0000
Message-ID: <C0CB8B14-BC4E-47F5-ADE6-9D21E73B0E2C@getmailspring.com>
References: <20190705102101.1114-1-dplotnikov@virtuozzo.com>
In-Reply-To: <20190705102101.1114-1-dplotnikov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::24) To VI1PR08MB3760.eurprd08.prod.outlook.com
 (2603:10a6:803:b9::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Mailspring
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea767da3-97cb-4e94-6f04-08d714f98b08
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB2656; 
x-ms-traffictypediagnostic: VI1PR08MB2656:
x-microsoft-antispam-prvs: <VI1PR08MB2656444068D1649F315C0D86CFDC0@VI1PR08MB2656.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(346002)(376002)(39850400004)(396003)(189003)(199004)(386003)(26005)(7736002)(107886003)(478600001)(18926415008)(733005)(2501003)(8676002)(6306002)(14454004)(54896002)(256004)(8936002)(305945005)(81166006)(81156014)(53936002)(110136005)(68736007)(4326008)(6436002)(66066001)(5660300002)(54906003)(9686003)(6512007)(6246003)(36756003)(186003)(66446008)(64756008)(71190400001)(66556008)(66476007)(446003)(316002)(6486002)(3846002)(76176011)(50226002)(66946007)(33656002)(71200400001)(2906002)(86362001)(3736002)(11346002)(102836004)(99286004)(476003)(6116002)(229853002)(52116002)(486006)(6506007)(25786009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB2656;
 H:VI1PR08MB3760.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fWl7kuamoimCLZn56RGZyzbCUlL0fcZZIT9Mq8i1txORSmzsbofda7yJQVOWvK8QqS2lgRHQ4qm2DYxIKRBPmFbu0ICK05Hhow/4ai8cpyw+v9WFvXqlb/2xs9YavHtDtTf9NHDAy/mD1gKwF8r6qDrkbZ/9HHjRqbNHT08bgRtHpSC1UKtGiWzk1QOnBNAY+0R5b0gFSozAp8o+sRDO9bLDMkUe1PTpNqdjn83AzJX/I2aVJe4latesp0Bh80Z/8E6yOntqpaCvzCVbhVEBqYI7fSs1Mm/v/dk0AgaOoikUChFEavinyNiR8wYE7ro7usrq+QxHKSrYLyBN5ccACHtBUpptAku03OMRwwl4IWfF8I0QJGU4RgdQC4XtNbbCcaHLtgRuPc4eujIG6HHB6sa/F0oIJPBnqBAVA1vN66U=
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea767da3-97cb-4e94-6f04-08d714f98b08
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 14:23:51.0061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dplotnikov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2656
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.91
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v7] qemu-io: add pattern file for write
 command
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGluZyENCg0KT24gSnVsIDUgMjAxOSwgYXQgMToyMSBwbSwgRGVuaXMgUGxvdG5pa292IDxkcGxv
dG5pa292QHZpcnR1b3p6by5jb20+IHdyb3RlOg0KVGhlIHBhdGNoIGFsbG93cyB0byBwcm92aWRl
IGEgcGF0dGVybiBmaWxlIGZvciB3cml0ZQ0KY29tbWFuZC4gVGhlcmUgd2FzIG5vIHNpbWlsYXIg
YWJpbGl0eSBiZWZvcmUuDQoNClNpZ25lZC1vZmYtYnk6IERlbmlzIFBsb3RuaWtvdiA8ZHBsb3Ru
aWtvdkB2aXJ0dW96em8uY29tPg0KLS0tDQp2NzoNCiogZml4IHZhcmlhYmxlIG5hbWluZw0KKiBt
YWtlIGNvZGUgbW9yZSByZWFkYWJsZQ0KKiBleHRlbmQgaGVscCBmb3Igd3JpdGUgY29tbWFuZA0K
DQp2NjoNCiogdGhlIHBhdHRlcm4gZmlsZSBpcyByZWFkIG9uY2UgdG8gcmVkdWNlIGlvDQoNCnY1
Og0KKiBmaWxlIG5hbWUgaW5pdGlhdGVkIHdpdGggbnVsbCB0byBtYWtlIGNvbXBpbGVycyBoYXBw
eQ0KDQp2NDoNCiogbWlzc2luZyBzaWduZWQtb2ZmIGNsYXVzZSBhZGRlZA0KDQp2MzoNCiogbWlz
c2luZyBmaWxlIGNsb3NpbmcgYWRkZWQNCiogZXhjbHVzaXZlIGZsYWdzIHByb2Nlc3NpbmcgY2hh
bmdlZA0KKiBidWZmZXIgdm9pZCogY29udmVydGVkIHRvIGNoYXIqIHRvIGZpeCBwb2ludGVyIGFy
aXRobWV0aWNzDQoqIGZpbGUgcmVhZGluZyBlcnJvciBwcm9jZXNzaW5nIGFkZGVkDQotLS0NCnFl
bXUtaW8tY21kcy5jIHwgODYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0NCjEgZmlsZSBjaGFuZ2VkLCA4MCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvcWVtdS1pby1jbWRzLmMgYi9xZW11LWlvLWNtZHMuYw0KaW5k
ZXggMDk3NTBhMjNjZS4uNDk1MTcwMzgwYSAxMDA2NDQNCi0tLSBhL3FlbXUtaW8tY21kcy5jDQor
KysgYi9xZW11LWlvLWNtZHMuYw0KQEAgLTM0Myw2ICszNDMsNjYgQEAgc3RhdGljIHZvaWQgKnFl
bXVfaW9fYWxsb2MoQmxvY2tCYWNrZW5kICpibGssIHNpemVfdCBsZW4sIGludCBwYXR0ZXJuKQ0K
cmV0dXJuIGJ1ZjsNCn0NCg0KK3N0YXRpYyB2b2lkICpxZW11X2lvX2FsbG9jX2Zyb21fZmlsZShC
bG9ja0JhY2tlbmQgKmJsaywgc2l6ZV90IGxlbiwNCisgY2hhciAqZmlsZV9uYW1lKQ0KK3sNCisg
Y2hhciAqYnVmLCAqYnVmX29yaWdpbjsNCisgRklMRSAqZiA9IGZvcGVuKGZpbGVfbmFtZSwgInIi
KTsNCisgaW50IHBhdHRlcm5fbGVuOw0KKw0KKyBpZiAoIWYpIHsNCisgcHJpbnRmKCInJXMnOiAl
c1xuIiwgZmlsZV9uYW1lLCBzdHJlcnJvcihlcnJubykpOw0KKyByZXR1cm4gTlVMTDsNCisgfQ0K
Kw0KKyBpZiAocWVtdWlvX21pc2FsaWduKSB7DQorIGxlbiArPSBNSVNBTElHTl9PRkZTRVQ7DQor
IH0NCisNCisgYnVmX29yaWdpbiA9IGJ1ZiA9IGJsa19ibG9ja2FsaWduKGJsaywgbGVuKTsNCisN
CisgcGF0dGVybl9sZW4gPSBmcmVhZChidWYsIHNpemVvZihjaGFyKSwgbGVuLCBmKTsNCisNCisg
aWYgKGZlcnJvcihmKSkgew0KKyBwcmludGYoIiclcyc6ICVzXG4iLCBmaWxlX25hbWUsIHN0cmVy
cm9yKGVycm5vKSk7DQorIGdvdG8gZXJyb3I7DQorIH0NCisNCisgaWYgKHBhdHRlcm5fbGVuID09
IDApIHsNCisgcHJpbnRmKCInJXMnIGlzIGVtcHR5XG4iLCBmaWxlX25hbWUpOw0KKyBnb3RvIGVy
cm9yOw0KKyB9DQorDQorIGZjbG9zZShmKTsNCisNCisgaWYgKGxlbiA+IHBhdHRlcm5fbGVuKSB7
DQorIGNoYXIgKmZpbGVfYnVmID0gZ19tYWxsb2Moc2l6ZW9mKGNoYXIpICogcGF0dGVybl9sZW4p
Ow0KKyBtZW1jcHkoZmlsZV9idWYsIGJ1ZiwgcGF0dGVybl9sZW4pOw0KKyBsZW4gLT0gcGF0dGVy
bl9sZW47DQorIGJ1ZiArPSBwYXR0ZXJuX2xlbjsNCisNCisgd2hpbGUgKGxlbiA+IDApIHsNCisg
c2l6ZV90IGxlbl90b19jb3B5ID0gTUlOKHBhdHRlcm5fbGVuLCBsZW4pOw0KKw0KKyBtZW1jcHko
YnVmLCBmaWxlX2J1ZiwgbGVuX3RvX2NvcHkpOw0KKw0KKyBsZW4gLT0gbGVuX3RvX2NvcHk7DQor
IGJ1ZiArPSBsZW5fdG9fY29weTsNCisgfQ0KKyBxZW11X3ZmcmVlKGZpbGVfYnVmKTsNCisgfQ0K
Kw0KKyBpZiAocWVtdWlvX21pc2FsaWduKSB7DQorIGJ1Zl9vcmlnaW4gKz0gTUlTQUxJR05fT0ZG
U0VUOw0KKyB9DQorDQorIHJldHVybiBidWZfb3JpZ2luOw0KKw0KK2Vycm9yOg0KKyBxZW11X3Zm
cmVlKGJ1Zl9vcmlnaW4pOw0KKyByZXR1cm4gTlVMTDsNCit9DQorDQpzdGF0aWMgdm9pZCBxZW11
X2lvX2ZyZWUodm9pZCAqcCkNCnsNCmlmIChxZW11aW9fbWlzYWxpZ24pIHsNCkBAIC05NDksNiAr
MTAwOSw3IEBAIHN0YXRpYyB2b2lkIHdyaXRlX2hlbHAodm9pZCkNCiIgLW4sIC0tIHdpdGggLXos
IGRvbid0IGFsbG93IHNsb3cgZmFsbGJhY2tcbiINCiIgLXAsIC0tIGlnbm9yZWQgZm9yIGJhY2t3
YXJkcyBjb21wYXRpYmlsaXR5XG4iDQoiIC1QLCAtLSB1c2UgZGlmZmVyZW50IHBhdHRlcm4gdG8g
ZmlsbCBmaWxlXG4iDQorIiAtcywgLS0gdXNlIGEgcGF0dGVybiBmaWxlIHRvIGZpbGwgdGhlIHdy
aXRlIGJ1ZmZlclxuIg0KIiAtQywgLS0gcmVwb3J0IHN0YXRpc3RpY3MgaW4gYSBtYWNoaW5lIHBh
cnNhYmxlIGZvcm1hdFxuIg0KIiAtcSwgLS0gcXVpZXQgbW9kZSwgZG8gbm90IHNob3cgSS9PIHN0
YXRpc3RpY3NcbiINCiIgLXUsIC0tIHdpdGggLXosIGFsbG93IHVubWFwcGluZ1xuIg0KQEAgLTk2
NSw3ICsxMDI2LDcgQEAgc3RhdGljIGNvbnN0IGNtZGluZm9fdCB3cml0ZV9jbWQgPSB7DQoucGVy
bSA9IEJMS19QRVJNX1dSSVRFLA0KLmFyZ21pbiA9IDIsDQouYXJnbWF4ID0gLTEsDQotIC5hcmdz
ID0gIlstYmNDZm5xdXpdIFstUCBwYXR0ZXJuXSBvZmYgbGVuIiwNCisgLmFyZ3MgPSAiWy1iY0Nm
bnF1el0gWy1QIHBhdHRlcm4gfCAtcyBzb3VyY2VfZmlsZV0gb2ZmIGxlbiIsDQoub25lbGluZSA9
ICJ3cml0ZXMgYSBudW1iZXIgb2YgYnl0ZXMgYXQgYSBzcGVjaWZpZWQgb2Zmc2V0IiwNCi5oZWxw
ID0gd3JpdGVfaGVscCwNCn07DQpAQCAtOTc0LDcgKzEwMzUsNyBAQCBzdGF0aWMgaW50IHdyaXRl
X2YoQmxvY2tCYWNrZW5kICpibGssIGludCBhcmdjLCBjaGFyICoqYXJndikNCnsNCnN0cnVjdCB0
aW1ldmFsIHQxLCB0MjsNCmJvb2wgQ2ZsYWcgPSBmYWxzZSwgcWZsYWcgPSBmYWxzZSwgYmZsYWcg
PSBmYWxzZTsNCi0gYm9vbCBQZmxhZyA9IGZhbHNlLCB6ZmxhZyA9IGZhbHNlLCBjZmxhZyA9IGZh
bHNlOw0KKyBib29sIFBmbGFnID0gZmFsc2UsIHpmbGFnID0gZmFsc2UsIGNmbGFnID0gZmFsc2Us
IHNmbGFnID0gZmFsc2U7DQppbnQgZmxhZ3MgPSAwOw0KaW50IGMsIGNudCwgcmV0Ow0KY2hhciAq
YnVmID0gTlVMTDsNCkBAIC05ODMsOCArMTA0NCw5IEBAIHN0YXRpYyBpbnQgd3JpdGVfZihCbG9j
a0JhY2tlbmQgKmJsaywgaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KLyogU29tZSBjb21waWxlcnMg
Z2V0IGNvbmZ1c2VkIGFuZCB3YXJuIGlmIHRoaXMgaXMgbm90IGluaXRpYWxpemVkLiAqLw0KaW50
NjRfdCB0b3RhbCA9IDA7DQppbnQgcGF0dGVybiA9IDB4Y2Q7DQorIGNoYXIgKmZpbGVfbmFtZSA9
IE5VTEw7DQoNCi0gd2hpbGUgKChjID0gZ2V0b3B0KGFyZ2MsIGFyZ3YsICJiY0NmbnBQOnF1eiIp
KSAhPSAtMSkgew0KKyB3aGlsZSAoKGMgPSBnZXRvcHQoYXJnYywgYXJndiwgImJjQ2ZucFA6cXV6
czoiKSkgIT0gLTEpIHsNCnN3aXRjaCAoYykgew0KY2FzZSAnYic6DQpiZmxhZyA9IHRydWU7DQpA
QCAtMTAyMCw2ICsxMDgyLDEwIEBAIHN0YXRpYyBpbnQgd3JpdGVfZihCbG9ja0JhY2tlbmQgKmJs
aywgaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KY2FzZSAneic6DQp6ZmxhZyA9IHRydWU7DQpicmVh
azsNCisgY2FzZSAncyc6DQorIHNmbGFnID0gdHJ1ZTsNCisgZmlsZV9uYW1lID0gZ19zdHJkdXAo
b3B0YXJnKTsNCisgYnJlYWs7DQpkZWZhdWx0Og0KcWVtdWlvX2NvbW1hbmRfdXNhZ2UoJndyaXRl
X2NtZCk7DQpyZXR1cm4gLUVJTlZBTDsNCkBAIC0xMDUxLDggKzExMTcsOSBAQCBzdGF0aWMgaW50
IHdyaXRlX2YoQmxvY2tCYWNrZW5kICpibGssIGludCBhcmdjLCBjaGFyICoqYXJndikNCnJldHVy
biAtRUlOVkFMOw0KfQ0KDQotIGlmICh6ZmxhZyAmJiBQZmxhZykgew0KLSBwcmludGYoIi16IGFu
ZCAtUCBjYW5ub3QgYmUgc3BlY2lmaWVkIGF0IHRoZSBzYW1lIHRpbWVcbiIpOw0KKyBpZiAoKGlu
dCl6ZmxhZyArIChpbnQpUGZsYWcgKyAoaW50KXNmbGFnID4gMSkgew0KKyBwcmludGYoIk9ubHkg
b25lIG9mIC16LCAtUCwgYW5kIC1zIg0KKyAiY2FuIGJlIHNwZWNpZmllZCBhdCB0aGUgc2FtZSB0
aW1lXG4iKTsNCnJldHVybiAtRUlOVkFMOw0KfQ0KDQpAQCAtMTA4OCw3ICsxMTU1LDE0IEBAIHN0
YXRpYyBpbnQgd3JpdGVfZihCbG9ja0JhY2tlbmQgKmJsaywgaW50IGFyZ2MsIGNoYXIgKiphcmd2
KQ0KfQ0KDQppZiAoIXpmbGFnKSB7DQotIGJ1ZiA9IHFlbXVfaW9fYWxsb2MoYmxrLCBjb3VudCwg
cGF0dGVybik7DQorIGlmIChzZmxhZykgew0KKyBidWYgPSBxZW11X2lvX2FsbG9jX2Zyb21fZmls
ZShibGssIGNvdW50LCBmaWxlX25hbWUpOw0KKyBpZiAoIWJ1Zikgew0KKyByZXR1cm4gLUVJTlZB
TDsNCisgfQ0KKyB9IGVsc2Ugew0KKyBidWYgPSBxZW11X2lvX2FsbG9jKGJsaywgY291bnQsIHBh
dHRlcm4pOw0KKyB9DQp9DQoNCmdldHRpbWVvZmRheSgmdDEsIE5VTEwpOw0KLS0NCjIuMTcuMA0K
DQo=

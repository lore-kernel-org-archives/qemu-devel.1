Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5CCC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:16:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49DBE20733
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NnUdwwdX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="HAfZ8tPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49DBE20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVcOo-0005gf-KJ
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 09:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1iVcMs-0004HR-2w
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:14:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1iVcMp-0001e2-TN
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:14:33 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:49335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1iVcMp-0001bl-4V
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1573827271; x=1605363271;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zVWhTazM3qIQKELLl9ubxYDznK2hDZtiSpK6j0xsjhg=;
 b=NnUdwwdXCNJOXNsEY2AXuOGmj99crS8Rf+PL6hTAkuDNMcXNNQ1Ze1Wu
 XrwC7KZeNcs9gUJoqcSQZxhm0acC6rFtfasKHYERFa9gVdvF6Zok8w5aU
 UUl1x3APYbRCh/Cg4so24hQEH4DETV1gW8UFUtlvngBeiwMu5eVyeH1xI c=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Nov 2019 06:14:25 -0800
IronPort-SDR: 9NBSdw9pEEg0AV4RIlrHRmZw/0Nf4dC2ZjoMeobGW812h72ZLqaxIecmKYkXHLw7C/tTCn4ZWI
 HxaRTXaNKjj+BRmUvY/v9dU9kt/ZMTJfPO0+zLEx1LN0yQd2cDNSL12TylOmYHny7jZQ4k53Z8
 fW/CjgUnPCiXQ84pFgbOlLJDpilaBll1AflKAyGSkQgfSrQnrNfi6lbizStn2IS3K7K0DUCFYd
 QEG8RrNOQ5ubPeEWrOx/DZqaOjkJ+XIeDjqSPhdYqjSE2BU1D0jKuZF67bSFIXQgKpQmV/e5/u
 iS9V0OYZmsDrlVN05/mIO3nd
Received: from nasanexm01d.na.qualcomm.com ([10.85.0.84])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 15 Nov 2019 06:14:25 -0800
Received: from nasanexm03f.na.qualcomm.com (10.85.0.47) by
 NASANEXM01D.na.qualcomm.com (10.85.0.84) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Fri, 15 Nov 2019 06:14:24 -0800
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03f.na.qualcomm.com (10.85.0.47) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Fri, 15 Nov 2019 06:14:24 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB5238.namprd02.prod.outlook.com (20.176.253.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Fri, 15 Nov 2019 14:14:22 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::b0e0:a44a:3fc6:e2b9]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::b0e0:a44a:3fc6:e2b9%3]) with mapi id 15.20.2451.029; Fri, 15 Nov 2019
 14:14:22 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Subject: RE: [PATCH] Modify tests to work with clang
Thread-Topic: [PATCH] Modify tests to work with clang
Thread-Index: AQHVm26ABd+ecCCwZE+8rNo2HsqYWqeMJmqAgAAf/MA=
Date: Fri, 15 Nov 2019 14:14:21 +0000
Message-ID: <BYAPR02MB4886BE1C92ACC1DA5CBC10FDDE700@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1573792691-398-1-git-send-email-tsimpson@quicinc.com>
 <8736ep72qy.fsf@linaro.org>
In-Reply-To: <8736ep72qy.fsf@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [12.228.221.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16b0c41c-0a60-4efc-0a46-08d769d61cb6
x-ms-traffictypediagnostic: BYAPR02MB5238:
x-microsoft-antispam-prvs: <BYAPR02MB523894A426479A1ED94B2AD5DE700@BYAPR02MB5238.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39860400002)(376002)(136003)(346002)(13464003)(199004)(189003)(66556008)(66476007)(7696005)(52536014)(476003)(6916009)(446003)(11346002)(66446008)(64756008)(26005)(6246003)(6506007)(53546011)(102836004)(76176011)(256004)(14444005)(5660300002)(6306002)(186003)(9686003)(55016002)(3846002)(6116002)(71200400001)(4326008)(66574012)(71190400001)(74316002)(2906002)(486006)(7736002)(86362001)(305945005)(6436002)(229853002)(66066001)(316002)(66946007)(76116006)(99286004)(478600001)(8936002)(14454004)(966005)(8676002)(33656002)(81166006)(25786009)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB5238;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9S6gZGSKF/pHYGCo2P81Vy8RnECEThJ3pQ/yjWdjjt67lMBCtaiInzX4qtW775VYhdujGLhwU7JhgrWXM9ZorRFjcklUdG1P6QRkLDcAMbLAmwPimkvojjnljkWQO93H3jdZFpAkFJSEwTRIP+2J0WemWWWLkxV4cjBN/Gl8yOcZ5P18JVtfv7llja9A5Jun166yQHOOQtH7hjBxfLUUhAPBw8B3jJKWjpM4bj6SGAyIZn0bDcAXbjX5KHMrEBNq8+GulZ9Nvko8Ob6sEPOvzvC3ZxcIk4i8HiOk75SQH3bftZOlrz/bp/8fI1dBBu3P6IJRSkiaYgg8i4sJe/GqWfw25ZWvq+lIJS9tHOl9CJFshQwpzuMawQD2Jp8olyPJF81WlvD4ownKreAkS48lPfovk8xYX/wygBzr5zT6srvcoiBF9Eocu8cp+RwU/ZAu
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRRMLMWfol91k8iP0KOeDE7jatZzfZTDpQVmp4Z+coxUQbYJMiQMdcwYxKHZWc4tHkGAV6AeKDCuCJIvzYJ8Pjlefv1k4Nt0M6v64XDT3A+orj6YkVIYal/qneeqU95AEd5Ke9U1bV0NA9yC/j340gFUzRbO/0LGoBIkOUWdAw6Wemo2xUyBlLJlFeGhmKwX4rZGXE0LviltiLDdx4pmLu+QjOCMpLn6aIRRyFtOSMRPjJrWo8OzC7LbP10PjN8+oowM3DhfHvzkslP57YLDpJ6YNuJiyJzJL6MKNUoIoNcfHbTVSxeCehq2CPSyLe4MNC90849D0pWiGTFm/Zg9bQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJTbt/qVym22bXQp9GaBMq2i2DCtEMkQZy8xNnHOpVg=;
 b=ij67QkyI4uvAH4LzOy9FrDt6Y1s7Mfhcu5pK2MGrNCeyrOEy8By8At1i4ncAQSnv0W+Do/n8Tv6bQGIksiU4Byuf2ktEVrooCcS8KlhaNiGn6Ik0ZKotxVsenqtyNtAfmH/Hl3rUX2RZcSibJOFO9J2fnuqj7iTD47YCrpV1rsmyIkbCsNgBvJqK28aZ7pHxWGqY6nuOGpTPRxAHMajPPx5joRd4qrJMP4+4dZlyA0TNFW6PcIGoeCF1H1wkIpdA5ObrH9BpOOuZg5fC2BBRDVMTdzr+hYWH+dAOfqXx63XCfeGM4POnEaQ5LtA+qA2pfZtBn9ZpA/1V3faV6B75Qw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJTbt/qVym22bXQp9GaBMq2i2DCtEMkQZy8xNnHOpVg=;
 b=HAfZ8tPfhs9wOBZNLHAEPNLK7bJC9nU2llVzQty+0VzKM3rZ70XU3hrZXRsyW9PogyXlNxWw5xIXSFkANs5tmbDFKuwAcPrvbeXdOt0ekXizq9Y5LBDz1DFv7cBLgPJqouZ2khS3pUgX2pgEbWYEFASlLczUWS8D54TNtRPo908=
x-ms-exchange-crosstenant-network-message-id: 16b0c41c-0a60-4efc-0a46-08d769d61cb6
x-ms-exchange-crosstenant-originalarrivaltime: 15 Nov 2019 14:14:22.0445 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: Jqo2lBwCvGVTAJUC1pcAQDCrAdT1OHbR1Y1EEQ9b5jJGK8947iyPxiH+wuPfHKycrU4yekqmVvajtsk5EFj1uQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5238
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.39
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

V2l0aG91dCB2b2xhdGlsZSwgY2xhbmcgdHVybnMgdGhhdCBzdGF0ZW1lbnQgaW50byBhIGNhbGwg
dG8gYWJvcnQuDQoNCkl0IGlzIGRpc2N1c3NlZCBoZXJlIChDaHJpcyBMYXR0bmVyJ3MgYmxvZyBm
cm9tIDIwMTEpDQpodHRwOi8vYmxvZy5sbHZtLm9yZy8yMDExLzA1L3doYXQtZXZlcnktYy1wcm9n
cmFtbWVyLXNob3VsZC1rbm93Lmh0bWwNCg0KSGVyZSBpcyB0aGUgcmVsZXZhbnQgcGFyYWdyYXBo
DQpJZiB5b3UncmUgdXNpbmcgYW4gTExWTS1iYXNlZCBjb21waWxlciwgeW91IGNhbiBkZXJlZmVy
ZW5jZSBhICJ2b2xhdGlsZSIgbnVsbCBwb2ludGVyIHRvIGdldCBhIGNyYXNoIGlmIHRoYXQncyB3
aGF0IHlvdSdyZSBsb29raW5nIGZvciwgc2luY2Ugdm9sYXRpbGUgbG9hZHMgYW5kIHN0b3JlcyBh
cmUgZ2VuZXJhbGx5IG5vdCB0b3VjaGVkIGJ5IHRoZSBvcHRpbWl6ZXIuIFRoZXJlIGlzIGN1cnJl
bnRseSBubyBmbGFnIHRoYXQgZW5hYmxlcyByYW5kb20gTlVMTCBwb2ludGVyIGxvYWRzIHRvIGJl
IHRyZWF0ZWQgYXMgdmFsaWQgYWNjZXNzZXMgb3IgdG8gbWFrZSByYW5kb20gbG9hZHMga25vdyB0
aGF0IHRoZWlyIHBvaW50ZXIgaXMgImFsbG93ZWQgdG8gYmUgbnVsbCIuDQoNClRheWxvcg0KDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbGV4IEJlbm7DqWUgPGFsZXguYmVu
bmVlQGxpbmFyby5vcmc+DQpTZW50OiBGcmlkYXksIE5vdmVtYmVyIDE1LCAyMDE5IDY6MTcgQU0N
ClRvOiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+DQpDYzogcWVtdS1kZXZl
bEBub25nbnUub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBNb2RpZnkgdGVzdHMgdG8gd29yayB3
aXRoIGNsYW5nDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkNBVVRJT046IFRoaXMgZW1haWwgb3JpZ2lu
YXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4NCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cg0KVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPiB3cml0ZXM6DQoNCj4gU2ln
bmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPg0KPiAtLS0N
Cj4gIHRlc3RzL3RjZy9tdWx0aWFyY2gvZmxvYXRfaGVscGVycy5jIHwgMTMgKysrKysrKysrKysr
LQ0KPiAgdGVzdHMvdGNnL211bHRpYXJjaC9saW51eC10ZXN0LmMgICAgfCAgMiArLQ0KPiAgMiBm
aWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvdGVzdHMvdGNnL211bHRpYXJjaC9mbG9hdF9oZWxwZXJzLmMNCj4gYi90ZXN0cy90
Y2cvbXVsdGlhcmNoL2Zsb2F0X2hlbHBlcnMuYw0KPiBpbmRleCA4ZWU3OTAzLi40MzcyNDdjIDEw
MDY0NA0KPiAtLS0gYS90ZXN0cy90Y2cvbXVsdGlhcmNoL2Zsb2F0X2hlbHBlcnMuYw0KPiArKysg
Yi90ZXN0cy90Y2cvbXVsdGlhcmNoL2Zsb2F0X2hlbHBlcnMuYw0KPHNuaXA+DQo+IGRpZmYgLS1n
aXQgYS90ZXN0cy90Y2cvbXVsdGlhcmNoL2xpbnV4LXRlc3QuYw0KPiBiL3Rlc3RzL3RjZy9tdWx0
aWFyY2gvbGludXgtdGVzdC5jDQo+IGluZGV4IDY3M2Q3YzguLmVkZmMwMmMgMTAwNjQ0DQo+IC0t
LSBhL3Rlc3RzL3RjZy9tdWx0aWFyY2gvbGludXgtdGVzdC5jDQo+ICsrKyBiL3Rlc3RzL3RjZy9t
dWx0aWFyY2gvbGludXgtdGVzdC5jDQo+IEBAIC00ODUsNyArNDg1LDcgQEAgc3RhdGljIHZvaWQg
dGVzdF9zaWduYWwodm9pZCkNCj4gICAgICBhY3Quc2FfZmxhZ3MgPSBTQV9TSUdJTkZPOw0KPiAg
ICAgIGNoa19lcnJvcihzaWdhY3Rpb24oU0lHU0VHViwgJmFjdCwgTlVMTCkpOw0KPiAgICAgIGlm
IChzZXRqbXAoam1wX2VudikgPT0gMCkgew0KPiAtICAgICAgICAqKHVpbnQ4X3QgKikwID0gMDsN
Cj4gKyAgICAgICAgKih2b2xhdGlsZSB1aW50OF90ICopMCA9IDA7DQoNClRoaXMgbG9va3Mgc3Vz
cGljaW91cyAtIHZvbGF0aWxlIGlzIGFsbW9zdCBuZXZlciB0aGUgYW5zd2VyIHRvIGEgcXVlc3Rp
b24uIFdoYXQgYXJlIHdlIHRyeWluZyB0byBhY2hpZXZlIGhlcmU/DQoNCj4gICAgICB9DQo+DQo+
ICAgICAgYWN0LnNhX2hhbmRsZXIgPSBTSUdfREZMOw0KDQoNCi0tDQpBbGV4IEJlbm7DqWUNCg==


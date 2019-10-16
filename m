Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09133FA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:36:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F18205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="n8EsLcAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F18205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKiXk-0001gj-LS
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 08:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1iKh7S-0006v4-GD
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ani.sinha@nutanix.com>) id 1iKh7P-0006YK-81
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:05:29 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:31734)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ani.sinha@nutanix.com>)
 id 1iKh7L-0006We-Tu
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:05:25 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x9GB5Iqm023636
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 04:05:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : subject
 : date : message-id : content-type : mime-version; s=proofpoint20171006;
 bh=CrRqoVffDtpgLQ1yuBbLw5BD3CUw8SYHirfzH3lw6Oc=;
 b=n8EsLcAtBzOfBGAUmyutLnk7mSMghdUZBWYVqrHX0PESzW+bI0p+YVgNNTpcKYxIYAiS
 ygAjVXv4wmbWVwOPBcVj/rGZrJbp6gkIzqe6d1OcUbHh9PRFJnFwnTGI1NMsFQ5b7c/t
 hS475ZVjAfBE3yx9RyopcMLHbjhEaA71MQop3iY7Lp9AHfsD9KydYVSlk4yKBzBRlO2A
 sWSwKZdNzcnl+R7IjLqjPHUSxj9yBVdcu3LNcr61lnc6+W7Y8BjiIVDTmQkZJEmAhPs0
 pGteawHwuej1Vb3GDHB6HfgAI/aMfMbrNaEsTuIiTWtIkVVcLMHFbZKikp8f7ny6cmB7 hQ== 
Received: from nam01-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam01lp2053.outbound.protection.outlook.com [104.47.32.53])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2vke5eg5cy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 04:05:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWtDBSBBy0MiwgNbWZXtnFctXvXgP7sQuWTrE/vgvagg2j73ewELLKTdy4suaKIZKUJNt2qE5JiFuCmknBeAb7OMUEOxe8SwbE0UFX8D+yHW/M5GRT5ysdlxGMSzVBaeqfLkOdCWrkKwfClJUH8ul18wcnsvfnuq6EA4KGgRBiEKwEZ7HBGhKTfldZjJq1KZCXP582Nb+81J10DDwVu500D57+mvk+Tk6PPUDxJvsBlnj8mwK2fvlpcGfEIgfnIle4NbDnW56dcqtstFU5W8ikvPKJEy2UUzakXrC4Hnk6dHsVsDbNwqmpcdcf8ycwcQ8eJFGzHN/EN6+AUE7HeRwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrRqoVffDtpgLQ1yuBbLw5BD3CUw8SYHirfzH3lw6Oc=;
 b=CRgdesVxMQSBC0JhskEp1U3sbM9VwbzfI2C0KUzPhaTWyOnTPwOgfME7YFawEqzCOEualCrXoZDt1VgASFqnRSb+LL3keBVrTlUH4+sfo+aQHTgS4zpzVYzouVBYP/dq9bFI9rnOQSIQ/+zxiC05KEOyNzmygZ0GqQzdfCqRSGlhhXhxsGJ2wxqP2Bc/hlr5AimFhvlhMjKqfQvcoPsoTmZ0Bfks6BuLCIYAkx5ae0GwpX03seszJGm94RjyceI0tAJTJGs/CSnBuPCMeoiJwj2pbHC/MFBqz7qJ9Wy7CP+aJQ9xceFBhrrup/Hv65USwmuVGNELe74PDk9DhZlxIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from SN6PR02MB5135.namprd02.prod.outlook.com (52.135.99.152) by
 SN6PR02MB4653.namprd02.prod.outlook.com (52.135.122.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 16 Oct 2019 11:05:15 +0000
Received: from SN6PR02MB5135.namprd02.prod.outlook.com
 ([fe80::3522:65f0:16b:52ba]) by SN6PR02MB5135.namprd02.prod.outlook.com
 ([fe80::3522:65f0:16b:52ba%2]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 11:05:15 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: TOPOEXT and CentOs 7 guests
Thread-Topic: TOPOEXT and CentOs 7 guests
Thread-Index: AQHVhBGWzkhyOmMAJU+Uhq0XCiSIWw==
Date: Wed, 16 Oct 2019 11:05:15 +0000
Message-ID: <deeecbae-c872-4534-be7d-f1428ad25ad2@Spark>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [103.68.105.248]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84bb5c6b-8368-452d-fc6e-08d75228b901
x-ms-traffictypediagnostic: SN6PR02MB4653:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR02MB465305E7AA04F3B89C5D4B29F1920@SN6PR02MB4653.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(7916004)(376002)(366004)(39860400002)(396003)(136003)(346002)(189003)(199004)(7736002)(606006)(2501003)(478600001)(316002)(966005)(14454004)(2351001)(81166006)(66066001)(25786009)(71190400001)(71200400001)(8936002)(81156014)(8676002)(31686004)(99286004)(256004)(21615005)(5660300002)(6916009)(6506007)(102836004)(5640700003)(6436002)(66946007)(3846002)(64756008)(6116002)(31696002)(26005)(44832011)(2906002)(86362001)(476003)(486006)(186003)(66476007)(66556008)(76116006)(91956017)(236005)(6512007)(33716001)(6306002)(66446008)(9686003)(54896002)(6486002)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR02MB4653;
 H:SN6PR02MB5135.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HpeMjKYknhpRCSTozb9ACTemxB3RV1tTyVFVNjIBy9CZ54grypNFom93e13+lkQjeBYVm7j3NPA1ATk5zSEr5qc+1oDTaBWgCjZUthbsr7xwWxGChB69dum9RRAOrTYVWUHGwO2ZvgYFBoQTF8YFE5GeKEdH1eXDVJyHHCFPFPyQLsLWNcZu7jrsPvA6OpA4cFIYpUcOFkn98zQE+BUe22wkcYHbrejyTrFDyeKufagD+orogkylS1lYm6A7DhGpDSn4ImkoqJ/Xvw0mQbPqhSObNnbu7tNFg5acbOgNY+SjDC/T6Q1MHcG+wVbSpAn7YNqJXP4dheOk1uuD2zAS49zaEQHtuNsxGNTWNhUNteks1uoav8sGjjudyV8CuGkYZHw1R221gKj/kO/0v8svXqGJDo/KTkqqyDDM/hVZHDYAb6cy3DjJmi3O8qGVt6ltoRUSOvfBpe70NIYP6+5LgA==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_deeecbaec8724534be7df1428ad25ad2Spark_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bb5c6b-8368-452d-fc6e-08d75228b901
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 11:05:15.1560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wGdyXw+TVXbL/oIQ21VJkj4hCUKGCwWPCLFlxx2zIJOwNMPbIQGTTQq9m2iXGT98nmoAeP9LedPshzLgz3nRBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4653
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_04:2019-10-16,2019-10-16 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.155.12
X-Mailman-Approved-At: Wed, 16 Oct 2019 08:35:10 -0400
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

--_000_deeecbaec8724534be7df1428ad25ad2Spark_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgOg0KDQpJIGFtIGxvb2tpbmcgYXQgYSBwYXRjaCB3aGVyZSB3ZSBkaXNhYmxlIFRPUE9FWFQg
d2hlbiAtY3B1IGhvc3Qgb3IgLWNwdSBtYXggaXMgcGFzc2VkIHRvIHFlbXUgOg0KDQppZiAoY3B1
LT5tYXhfZmVhdHVyZXMpIHsNCiAgIGZvciAodyA9IDA7IHcgPCBGRUFUVVJFX1dPUkRTOyB3Kysp
IHsNCiAgICAgLyogT3ZlcnJpZGUgb25seSBmZWF0dXJlcyB0aGF0IHdlcmVuJ3Qgc2V0IGV4cGxp
Y2l0bHkNCiAgICAgICogYnkgdGhlIHVzZXIuDQogICAgICAqLw0KICAgICAgZW52LT5mZWF0dXJl
c1t3XSB8PQ0KICAgICAgeDg2X2NwdV9nZXRfc3VwcG9ydGVkX2ZlYXR1cmVfd29yZCh3LCBjcHUt
Pm1pZ3JhdGFibGUpICYNCiAgICAgICAgIH5lbnYtPnVzZXJfZmVhdHVyZXNbd10gJiBcDQogICAg
ICAgICB+ZmVhdHVyZV93b3JkX2luZm9bd10ubm9fYXV0b2VuYWJsZV9mbGFnczsNCiAgICB9DQp9
DQoNCmh0dHBzOi8vbGlzdHMubm9uZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE4
LTA4L21zZzAxNjQxLmh0bWwNCg0KDQpXZSBhcmUgdXNpbmcgYSBzZXR1cCB3aGVyZSB3ZSBwYXNz
IOKAnGt2bTY04oCdIGFzIHRoZSBjcHUgbW9kZWwgYWxvbmcgd2l0aCBvdGhlciBoeXBlcnZpc29y
IENQSVVEIGNhcGFiaWxpdGllcyBhcyBkZXRlY3RlZCBieSBsaWJ2aXJ0IHRvIGEgY2VudE9TIDcu
NyBndWVzdCBhbmQgdGhlIGd1ZXN0IGlzIHVuYWJsZSB0byBib290LiBXZSBhcmUgdXNpbmcgYSBB
TUQgRVBZQyBwbGF0Zm9ybSBhbmQgd2UgaGF2ZSB0cmFjZWQgaXQgZG93biB0byBUT1BPRVhUIGZs
YWcgYmVpbmcgdGhlIG9mZmVuZGluZyBDUFVJRCBmcm9tIHRoZSBob3N0IENQVSB3aGljaCBpcyBj
YXVzaW5nIHRoZSBpc3N1ZS4gRG9lcyBpdCBtYWtlcyBzZW5zZSB0byBub3QgZW5hYmxlIHRoaXMg
ZmxhZyBieSBkZWZhdWx0IG9uIGFsbCBvdGhlciBndWVzdCBDUFUgbW9kZWxzIGFzIHdlbGwgZXhj
ZXB0IGZvciBFUFlDIGFuZCBFUFRDLUlCUEI/DQoNCkp1c3QgbG9va2luZyBhdCB0aGUgY29kZSB2
ZXJ5IHJlY2VudGx5IGFuZCB0aG91Z2h0IEnigJlkIGdldCBhbiBvcGluaW9uIGZyb20gdGhlIHdp
c2VyIHFlbXUgY29tbXVuaXR5Lg0KDQpUaGFua3MNCkFuaQ0KDQo=

--_000_deeecbaec8724534be7df1428ad25ad2Spark_
Content-Type: text/html; charset="utf-8"
Content-ID: <32122ABA8DE0C14CA3470F7DEBA72F40@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiPg0KPGhlYWQ+DQo8bWV0
YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9InRleHQvaHRtbDsgY2hhcnNldD11
dGYtOCI+DQo8dGl0bGU+PC90aXRsZT4NCjwvaGVhZD4NCjxib2R5Pg0KPGRpdiBuYW1lPSJtZXNz
YWdlQm9keVNlY3Rpb24iIHN0eWxlPSJmb250LXNpemU6IDE0cHg7IGZvbnQtZmFtaWx5OiAtYXBw
bGUtc3lzdGVtLCBCbGlua01hY1N5c3RlbUZvbnQsIHNhbnMtc2VyaWY7Ij4NCkhpIDoNCjxkaXY+
PGJyPg0KPC9kaXY+DQo8ZGl2PkkgYW0gbG9va2luZyBhdCBhIHBhdGNoIHdoZXJlIHdlIGRpc2Fi
bGUgVE9QT0VYVCB3aGVuIC1jcHUgaG9zdCBvciAtY3B1IG1heCBpcyBwYXNzZWQgdG8gcWVtdSA6
PC9kaXY+DQo8ZGl2Pjxicj4NCjwvZGl2Pg0KPGRpdj5pZiAoY3B1LSZndDttYXhfZmVhdHVyZXMp
IHs8YnI+DQombmJzcDsgJm5ic3A7Zm9yICh3ID0gMDsgdyAmbHQ7IEZFQVRVUkVfV09SRFM7IHcm
IzQzOyYjNDM7KSB7PGJyPg0KJm5ic3A7ICZuYnNwOyAmbmJzcDsvKiBPdmVycmlkZSBvbmx5IGZl
YXR1cmVzIHRoYXQgd2VyZW4ndCBzZXQgZXhwbGljaXRseTxicj4NCiZuYnNwOyAmbmJzcDsgJm5i
c3A7ICogYnkgdGhlIHVzZXIuPGJyPg0KJm5ic3A7ICZuYnNwOyAmbmJzcDsgKi88YnI+DQombmJz
cDsgJm5ic3A7ICZuYnNwOyBlbnYtJmd0O2ZlYXR1cmVzW3ddIHw9PGJyPg0KJm5ic3A7ICZuYnNw
OyAmbmJzcDsgeDg2X2NwdV9nZXRfc3VwcG9ydGVkX2ZlYXR1cmVfd29yZCh3LCBjcHUtJmd0O21p
Z3JhdGFibGUpICZhbXA7PGJyPg0KJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwO35l
bnYtJmd0O3VzZXJfZmVhdHVyZXNbd10gJmFtcDsgXCZuYnNwOzxicj4NCiZuYnNwOyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOyAmbmJzcDt+ZmVhdHVyZV93b3JkX2luZm9bd10ubm9fYXV0b2VuYWJsZV9m
bGFnczs8YnI+DQombmJzcDsgJm5ic3A7IH08YnI+DQp9PGZvbnQgY29sb3I9IiNGNEY0RjQiPjxi
cj4NCjwvZm9udD48L2Rpdj4NCjxkaXY+PGJyPg0KPC9kaXY+DQo8ZGl2PjxhIGhyZWY9Imh0dHBz
Oi8vbGlzdHMubm9uZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE4LTA4L21zZzAx
NjQxLmh0bWwiPmh0dHBzOi8vbGlzdHMubm9uZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZl
bC8yMDE4LTA4L21zZzAxNjQxLmh0bWw8L2E+PGJyPg0KPC9kaXY+DQo8ZGl2Pjxicj4NCjwvZGl2
Pg0KPGRpdj48YnI+DQo8L2Rpdj4NCjxkaXY+V2UgYXJlIHVzaW5nIGEgc2V0dXAgd2hlcmUgd2Ug
cGFzcyDigJxrdm02NOKAnSBhcyB0aGUgY3B1IG1vZGVsIGFsb25nIHdpdGggb3RoZXIgaHlwZXJ2
aXNvciBDUElVRCBjYXBhYmlsaXRpZXMgYXMgZGV0ZWN0ZWQgYnkgbGlidmlydCB0byBhIGNlbnRP
UyA3LjcgZ3Vlc3QgYW5kIHRoZSBndWVzdCBpcyB1bmFibGUgdG8gYm9vdC4gV2UgYXJlIHVzaW5n
IGEgQU1EIEVQWUMgcGxhdGZvcm0gYW5kIHdlIGhhdmUgdHJhY2VkIGl0IGRvd24gdG8gVE9QT0VY
VA0KIGZsYWcgYmVpbmcgdGhlIG9mZmVuZGluZyBDUFVJRCBmcm9tIHRoZSBob3N0IENQVSB3aGlj
aCBpcyBjYXVzaW5nIHRoZSBpc3N1ZS4gRG9lcyBpdCBtYWtlcyBzZW5zZSB0byBub3QgZW5hYmxl
IHRoaXMgZmxhZyBieSBkZWZhdWx0IG9uIGFsbCBvdGhlciBndWVzdCBDUFUgbW9kZWxzIGFzIHdl
bGwgZXhjZXB0IGZvciBFUFlDIGFuZCBFUFRDLUlCUEI/PC9kaXY+DQo8ZGl2Pjxicj4NCjwvZGl2
Pg0KPGRpdj5KdXN0IGxvb2tpbmcgYXQgdGhlIGNvZGUgdmVyeSByZWNlbnRseSBhbmQgdGhvdWdo
dCBJ4oCZZCBnZXQgYW4gb3BpbmlvbiBmcm9tIHRoZSB3aXNlciBxZW11IGNvbW11bml0eS48L2Rp
dj4NCjxkaXY+PGJyPg0KPC9kaXY+DQo8ZGl2PlRoYW5rczwvZGl2Pg0KPGRpdj5Bbmk8L2Rpdj4N
CjxkaXY+Jm5ic3A7Jm5ic3A7PC9kaXY+DQo8L2Rpdj4NCjxkaXYgbmFtZT0ibWVzc2FnZVJlcGx5
U2VjdGlvbiIgc3R5bGU9ImZvbnQtc2l6ZTogMTRweDsgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0
ZW0sIEJsaW5rTWFjU3lzdGVtRm9udCwgc2Fucy1zZXJpZjsiPg0KPGRpdj48L2Rpdj4NCjwvZGl2
Pg0KPC9ib2R5Pg0KPC9odG1sPg0K

--_000_deeecbaec8724534be7df1428ad25ad2Spark_--


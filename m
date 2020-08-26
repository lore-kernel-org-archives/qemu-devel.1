Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02EDC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 23:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B436320679
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 23:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X0HRc/bM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="BMdlQeYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B436320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB5EZ-0005ip-Ui
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 19:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kB5DX-0004NM-88
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 19:52:35 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:40476)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kB5DV-0003Mb-FA
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 19:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598485953; x=1630021953;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=76hFWoCtiyPw5LV7APGbdSXKiUaHHdEuu4suiD8sHME=;
 b=X0HRc/bMbIrF9qtDctghe7zwTUxyhAKkraal5w/A+I8Nxttg7p9yBuT1
 v5mdlEjdVBHYIQYShfWQMcjt5kLR93ei14JH/dUxsi61sCYEo63L+U+nr
 ww+H5Fuc020ptm5TRXgRPfjxG38tZBd8I0h8xRb0Motni3DCXVqjlHtRl E=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Aug 2020 16:52:30 -0700
Received: from nasanexm03g.na.qualcomm.com ([10.85.0.49])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 26 Aug 2020 16:52:29 -0700
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 16:52:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 26 Aug 2020 16:52:29 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4952.namprd02.prod.outlook.com (2603:10b6:a03:45::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 26 Aug
 2020 23:52:21 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e%3]) with mapi id 15.20.3305.031; Wed, 26 Aug 2020
 23:52:21 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 13/34] Hexagon (target/hexagon) register map
Thread-Topic: [RFC PATCH v3 13/34] Hexagon (target/hexagon) register map
Thread-Index: AQHWdXdiYR9i7kRNSk2HIGicB2V546lKgZSAgACPgdA=
Date: Wed, 26 Aug 2020 23:52:21 +0000
Message-ID: <BYAPR02MB4886FAAE6E51F8E7F1ABD541DE540@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-14-git-send-email-tsimpson@quicinc.com>
 <a890bdc1-97ae-c9b4-8886-e51c3af138a9@linaro.org>
In-Reply-To: <a890bdc1-97ae-c9b4-8886-e51c3af138a9@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ec23997-da10-41d8-c401-08d84a1b12c0
x-ms-traffictypediagnostic: BYAPR02MB4952:
x-microsoft-antispam-prvs: <BYAPR02MB495291BE6DF9DBFC2E943991DE540@BYAPR02MB4952.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bMJkpqRhwRUh0ABXquEHA93X25ooN/SNE5fjwnKTojEfSvBFjxT9DVZNJ/oFRghj5W3yCpvztzvRAdS6cuzcvpBcyT84SnenS1W9kmycFNyqdRH4mqRaNLW+xfX+DwiQYh1gljBjGLE/3VlNPTDgPrXsnfYffoddeTqjfKYqh0M/t5L12FzvzIuGXVC1iNMkYJ30QYPbQO+YVvsCQmVqG89xH7V1igXp2FMuidtDlP5s5wwCiASzRSl8a8x3H6rfeAhQVD87qGqes06k/3HEl8Y5F5Qz6rZKrKHrUlj8I8F5T7EvLAt5Hj2qayWjdjKC/U913crXLS6qATzG2vHIow==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(39860400002)(396003)(346002)(376002)(136003)(478600001)(6506007)(26005)(52536014)(71200400001)(5660300002)(4744005)(83380400001)(186003)(86362001)(8936002)(53546011)(55016002)(54906003)(316002)(33656002)(9686003)(110136005)(7696005)(8676002)(64756008)(66946007)(2906002)(4326008)(66446008)(66476007)(66556008)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: uvhLVNr9pr6+/wJc/lrrlQSG+S7jzLedTtCM2VxFvEieMEVkVk21EGMHAlSjeXDg4FAHCVgYBzyGTdAxZko401UkGkb1r0XYAVFVqXbaJ+5re0Hj0FBvHVNsO+yDb3V/kOOw4KdZiW5EHK/B/LI19seQcYlTR0CmqWDm95y2yrz5AtCTylGy3QQwLW3s9p8YjcmX5gOen3+A6+r7mKE/fZd02BTGH2eQ0EHICUaEEa5r0iSZmAzOcwMeDUa6tDamBI/KR8qF2oJJhAwJ9oZq31IGINvzojbNv66YNkvPkVvamGgJzEIIE9rC/11a1wTfWPlUKMroLOsnuDsHgkpQ5cqpyNpA/mhN4+R+cPhAlW42DyqPdI1gi2h5MVMbnUQurg5WBhtrWcUECRl1Z87si2ts2nIJxi53LTQGKlcJPvZKuZmjRPj+26glo5h04+EXeZYf4Aa1mZoDaV5X7OSf4I2SReJB29l/aTBUYB06EWs0rDYdxoDSZ258LijHxeXddjClKgibY6eViESjvvkyRO/TanQ2A95v890vAjWgy4HZO5OOhRU4wgbFxHZL07CEdu/ewk6jTGMP03XM+oj6LMaXRZC9V7taMIIVpSvSHhBu0RQG6mBykGWEyDFm3pbVhRXDRRCA6CC9CcUi3c6kQA==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ge8+StE9a5m/LxM+pL57iwFEIPvMnRQRUCDxTqXB7/kfAnELr3/dIjyuRp0n9OsgwVEkM21X354NPsTG5P8iL0B1RSGsgJSA0ts76l6jzb3qdjWQ5+ReqpKwJ7fjwI79pi+gcYW9JzdIelzZswGCBbGboAZxgpkh4W7906mDWd7HFB0QF74PCLz9otsRKp/g2wPPLEcrNimf7afng+y6XLrZE+O9mRtFx+qZJYtkkyPi2KEMJu8aO17RBgKWXYFJcFSl85tYI4jwCAKGibWyDEijOPTIG/B4c8TBza4nnmnkCwmEvn1tJHYSVip6b8mqjsTxvE3vq1gzVF9dPeAWtQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXq92pGUgJHpxX3pc4LWxCJqD/EGkp/WegwaipnrbcI=;
 b=X/FDb1sQCyzSdE/EiCuLD2cAJ1LCo9IeLUmp97Y6EtsaHp7O6dfovLJPS9radW9Mmi7yw8gtiDaXr4lP0j78d/QHjygfe8CaVG+O6Y6dgeCEePU0cbp2J9OxDPgOJW0DE4mFML+ycOAzevfg9qX7J5Ujh9pHdDjOky7roZa3nfMjM1gdfbXE21wQ2JOsqBClEyZPU496eX0PvtACDDPE+WugFgjyIkIn/v4WFnBos6jSV+j3uyfVhALygA/q1VMXfleVeBbGElHFUVa90G1JMDsCzTTEg5kTdd8ZT7TxDGyZ7zehywHbf9isFuAMn14GMQcs/vDHWo4N4ybhLSRLTQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXq92pGUgJHpxX3pc4LWxCJqD/EGkp/WegwaipnrbcI=;
 b=BMdlQeYOjVkw2S+9o1yHoAQWfrPvaQGnBH1M+fEaQX3iTFhHraGufkjoYvYMjatv8AHYHSefkB1smY0u8VGeViOKJA1vLvsTfVK19PTheLMMyRLMMi27XbrGDl/jpl0Bk002yrYDhl2ONO/TQpXA+7v75rHFW/6K5CAwo3JL+nU=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 8ec23997-da10-41d8-c401-08d84a1b12c0
x-ms-exchange-crosstenant-originalarrivaltime: 26 Aug 2020 23:52:21.0241 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: Hw58ocP5iNUgDzYKtTll5MqVMmsU7GrlAff8xDhZGPc/jrw2wilYsXHIqlziknE3Hut+0eNm6CXFE9nCgce24Q==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4952
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.39; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 19:52:04
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "ale@rev.ng" <ale@rev.ng>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmljaGFyZCBIZW5kZXJz
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVn
dXN0IDI2LCAyMDIwIDg6MzYgQU0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWlj
aW5jLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGhpbG1kQHJlZGhhdC5jb207
IGxhdXJlbnRAdml2aWVyLmV1OyByaWt1LnZvaXBpb0Bpa2kuZmk7DQo+IGFsZWtzYW5kYXIubS5t
YWlsQGdtYWlsLmNvbTsgYWxlQHJldi5uZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAx
My8zNF0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIHJlZ2lzdGVyIG1hcA0KPg0KPiA+ICtERUZf
UkVHTUFQKFZfXzE2LCAxNiwgMCwgMiwgNCwgNiwgOCwgMTAsIDEyLCAxNCwgMTYsIDE4LCAyMCwg
MjIsIDI0LCAyNiwgMjgsDQo+IDMwKQ0KPg0KPiBHaXZlbiB0aGF0IERFRl9SRUdNQVAgaXRzZWxm
IGlzIGRlZmluZWQgaW4gZGVjb2RlLmMsIGFuZCBub3QgZXZlbiBpbg0KPiBhbm90aGVyDQo+IGhl
YWRlciBmaWxlLCB3aHkgZG8gdGhlc2Ugbm90IGxpdmUgaW4gZGVjb2RlLmMgYXMgd2VsbD8NCg0K
SSdsbCBtb3ZlIHRoZW0gdG8gZGVjb2RlLmMuDQo=


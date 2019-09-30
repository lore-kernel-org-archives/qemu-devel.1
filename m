Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC69C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 10:32:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C64216F4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 10:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="QlVXbBQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C64216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEsyh-0002Hc-Lw
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 06:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iEsww-0001Qj-4V
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iEswr-00060j-Pj
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:30:37 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:11930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iEswr-0005x4-Gm
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:30:33 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x8UAK3fD024396
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 03:30:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=xp99YT53PO5HNG4pgZZ5P+icjq9Ve4lhfSTXpajyjy4=;
 b=QlVXbBQbkA5pxH33sBu3DTxJ81k9zX2L+dsSP/Cx/zg4sF6BFsJuVfN1xgvJ4HfHIBv3
 vCmvXR/6bE6csnuxzXy3Zm3rCS95S7BHHXYsjoy3+3bVss3PrLIeWLZrZo16GJI1taLI
 gUot/67iUGF0herVUj6GfdXKTYE4Ue3K0P8F5yFJeCqH4rg1iAI5VXsM415vFy6RP88m
 ewnQSEnzs0MAr9elRg8x/RvuiGLWC6RG7Awo2qUgnAsR06DCCGYnYG7XXwz3PtKH7lZE
 HONUZKCjngtWBdu8tHhAK69xp37hUEw7UJbU3OMBCMOkaS9BXYuYYkVXGEErSY2mfzyb Kg== 
Received: from nam03-by2-obe.outbound.protection.outlook.com
 (mail-by2nam03lp2053.outbound.protection.outlook.com [104.47.42.53])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2va6khb6f9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 03:30:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWrs2iiPlVwp3D7Gd+yt0FooZb/1HtwcYnA3XsyLJdYqoDTkiaVZI+deY0uhM3J/7FAZvMpBNTVWdxKwQjIhb3Xtf/3mIHlzB3TeF4J4NqcqFqAEzeUMVCNo2uuYvvaXE62STpZYpQn5t016hYARojp5mi/sazl8hYMga2FLVJOHO00mgCf3WgBna8TxadiyQ+gjYVMNHGGQovM6O+WcDXhZYpW6QQ23ayYun7GVP/9W/RHmE1Q6xMsL13caclI5qTnm6YKk5mFrpACl1XeYMaQTtKkrAUMRjOJpZXWp3ZjffjlxduElHZ2uxBKl8UJQrLVPqcfklN61G4UEM8UsPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xp99YT53PO5HNG4pgZZ5P+icjq9Ve4lhfSTXpajyjy4=;
 b=FMCRhtlltPjSXrqxHsGotIxnpBCLxtfamtiFpUjOhwHOG8ygIyRoMxQx6itsfxrCo1nf8ffspzE+eYuqfIGKwfhFdIaOtxQgnaSAi+iLX8QxkPBiszFyY2MkGKCGMij5G/0ALK3BTAU3+NEw/JYg03Hgzr9W0wX6BirDaTM2vOO1GygnA4tisbZ9KDAk/32CzKYCEZ5QcNZJym/LuT+pdPsabRgkw98G6ay2UZxJp0IMj2E+cIxL4cNJIZwlCF6qiCJtROgpVA4KnRBxlovd2zL/ODutCwOhGGiIdoIqi3RoQVfRuLTfQYi0EY13s68Up5qlehIRd+cgfokAFKo+Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2608.namprd02.prod.outlook.com (10.168.205.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Mon, 30 Sep 2019 10:30:28 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::2867:91aa:a3e:e278]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::2867:91aa:a3e:e278%2]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 10:30:28 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: Thoughts on VM fence infrastructure
Thread-Topic: Thoughts on VM fence infrastructure
Thread-Index: AQHVd3oUjPlnPo4D5E2mRytId27baA==
Date: Mon, 30 Sep 2019 10:30:28 +0000
Message-ID: <42837590-2563-412B-ADED-57B8A10A8E68@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1a87617-106b-4456-e029-08d7459136a8
x-ms-traffictypediagnostic: MWHPR02MB2608:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB26086F89B3292106E7CA38DCD7820@MWHPR02MB2608.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(346002)(366004)(136003)(376002)(396003)(43544003)(199004)(189003)(4326008)(6436002)(91956017)(33656002)(4744005)(81166006)(8676002)(36756003)(66556008)(71190400001)(6486002)(99286004)(66946007)(6512007)(64756008)(486006)(71200400001)(5660300002)(66476007)(305945005)(76116006)(2906002)(14454004)(7736002)(81156014)(107886003)(102836004)(2616005)(186003)(6916009)(66066001)(26005)(256004)(316002)(66446008)(476003)(478600001)(8936002)(86362001)(25786009)(6116002)(3846002)(6506007)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2608;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rkaVRMvSCe7+kUHJLtOPsYevzArEcHExmqYmzSKu0Ly+Z4miz0VWS1nQhqkOwhnkS3gDiDW1NfbAhMs8WXWgGY8YdOGmouAm/mWcUStOxeSkTVVy/chNPjXfXC9r0PGRIgDzKoskZeIkTTL3L0U998Gv77hhmKTbHusiSK4jZTUFZ8om4lwtr8a1dvYdjr6IzHjYn/KpDKpX7Nb0d1wMW94gPBu1QnUB4Yh+OqFIGcKs5oLy+b+7noqef2fDwxfbvZ3lT+EeMJOKH29gS7w0B/zQNo8VBB77n6dU4B4Iub0RCHM48LhNgnvQzgxjHpxFvU1coGbuWCrjxEqilHlpDCieSpEsGjhIFA61GmuY/mP/c5ugE4HM+3S5ejpt+H4nAEPxjSvkkFbpJea5GmrKhIxevvGwfCwRXgVgbCMrfv8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EB7AE99AF211994AA820499A186FE20E@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a87617-106b-4456-e029-08d7459136a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 10:30:28.3956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksLUfOBgqbwCKHhllQEEgjS9faGEjP3dwnY0lnfYhPKDMX4HHYQeDKQ26jSrrW6QoS+CxwR+UiUBW5k3P9YWJfWi0C3+zOx+10y4VU7/+/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2608
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-30_06:2019-09-25,2019-09-30 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.151.68
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
Cc: Aditya Ramesh <aramesh@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Heyall,

We have a use case where a host should self-fence (and all VMs should
die) if it doesn't hear back from a heartbeat within a certain time
period. Lots of ideas were floated around where libvirt could take
care of killing VMs or a separate service could do it. The concern
with those is that various failures could lead to _those_ services
being unavailable and the fencing wouldn't be enforced as it should.

Ultimately, it feels like Qemu should be responsible for this
heartbeat and exit (or execute a custom callback) on timeout.

Does something already exist for this purpose which could be used?
Would a generic Qemu-fencing infrastructure be something of interest?

Cheers,
F.


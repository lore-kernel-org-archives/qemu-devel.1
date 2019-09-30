Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4703C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD3A5215EA
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Bi4rRPz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3A5215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEy1u-0000ml-OE
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 11:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iExsM-0001Zc-8F
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iExsJ-00058s-8O
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:46:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:26396)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iExsF-00057W-M0
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:46:09 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x8UFVGxY018180; Mon, 30 Sep 2019 08:46:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=mhTMrsAc3mdWmIqqo5XFlQVwh7Ie9s3iUqlvJWK9Hg0=;
 b=Bi4rRPz2P7YPYU7iYe0vBEOavrqLle0TkVwa2S5tAOf3BGayVKzWR9r8tVAnxB0zTzYp
 V2lXITp44pLIF+ldD21s1B2PzzzUYVva+e3U/Ooin15VaVJrStO3BPN9OD3M9pPflIie
 EnrmvCLxvu1gGV0eX/ARs3Oq1ubQ0/aLqtzj56RwpHH4wX3+HwE/DdCkrkaLef7r2BcT
 fa0I5jHawvLzgh1zmLFjFZuEG6hfjWSRtZnIc1UtNj5/WfzogwIF8T3LCGfSfPkPtzru
 NCbxkQVw4sirhbuOLFVKgEZrXYtxl9uS84QX4QFcleKqkHbtMV8OtQpJzdPcaexYdDgd 5w== 
Received: from nam04-co1-obe.outbound.protection.outlook.com
 (mail-co1nam04lp2055.outbound.protection.outlook.com [104.47.45.55])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2va528buyy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2019 08:46:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OW0F2xqriToru7R+5yg/WSiCHFoAOYmhGLG5Y+sTD//YOF7yJMATYaGiqYVTIREihfIEyOO3gUd9pFgN0TIL2wPfDN+uQ5qxw0IPsbov6A40twFyxdM6DVLvfTuJjYh1ZsFNx5h5kVdw7F8Pl/EBUmY2x+O6TwuSmiHXP7v85S+JPzSp3Bj+AerfMAMDDXzYpSQmPY4YJG0eb+wmwK2ua6j0sFzPkbKmsi6A+GkezBVFj5l3qaPQFS5GobqnHSuKOqBcddatbKKClK/x/lF1KAPpJBEoG0LXq/PXB4/KTh581jiM5vzkR3vaOaCCfl3fx/2sUAMZGL1BFIOOgL5QOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhTMrsAc3mdWmIqqo5XFlQVwh7Ie9s3iUqlvJWK9Hg0=;
 b=TsAWhH0DH5X6rSCxov7tcGGnKInUYNHRXaaLmQIHHOYiITVttJwc84ewLAHlHIFfPXvI4wlinjsP+SaW9YLncjblgJ3/olLjMpCytii6Q6DsC+XOiDEL4mCbZcyG89AflXkYE2IZH9qldzaD7RB/aUwEYglJKbxiwW6CChenoTkafgk4mAw9ZMJCGkQ/TVkOT/EmEkR43ajFXxFfsAI+0Q8XNT4qoTX7rEkhw52uhbCNj7r8wS4n3Odu4Ja1EO1erJj1A0bh7kNMXoriC4z+FMMhf1elum983qgLUwmd3KzEpnv8sjaChCfRCy8pc7x4fLfdACh1btxHAioLIya/Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB3215.namprd02.prod.outlook.com (10.164.133.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 15:46:00 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::2867:91aa:a3e:e278]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::2867:91aa:a3e:e278%2]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 15:46:00 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: Thoughts on VM fence infrastructure
Thread-Topic: Thoughts on VM fence infrastructure
Thread-Index: AQHVd3oUrA00x04Zc0W5TGhiZaAe96dESBkAgAAVQwA=
Date: Mon, 30 Sep 2019 15:46:00 +0000
Message-ID: <C5374DA3-A1FC-4F1A-AA36-DC02D350F5A1@nutanix.com>
References: <42837590-2563-412B-ADED-57B8A10A8E68@nutanix.com>
 <20190930142954.GA2801@work-vm>
In-Reply-To: <20190930142954.GA2801@work-vm>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbdfe8f4-8c86-434a-fb20-08d745bd4b33
x-ms-traffictypediagnostic: MWHPR02MB3215:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB3215EC0FAAA61E1F2A1E6825D7820@MWHPR02MB3215.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(376002)(366004)(39850400004)(136003)(199004)(189003)(71190400001)(486006)(66066001)(107886003)(71200400001)(81166006)(76176011)(102836004)(6246003)(229853002)(6486002)(8676002)(2906002)(446003)(11346002)(81156014)(2616005)(305945005)(476003)(7736002)(186003)(99286004)(8936002)(6916009)(86362001)(4326008)(91956017)(54906003)(5660300002)(66946007)(76116006)(25786009)(66476007)(66556008)(316002)(33656002)(6116002)(64756008)(3846002)(66446008)(36756003)(14454004)(6512007)(6506007)(53546011)(26005)(256004)(6436002)(478600001)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB3215;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: En29mzgrCiNzmCpMXmMK0OMAAtNr6E/KmWM64Mn0dZJZqJvpnGoj0K8k25kKoq3/6CgSLRPl6Qk8jdQc3HmSL94Pd5wbe7yNKuoJ0YqQu9bCesm3OADb9EWXdoRAuGOKYMxSJ5AqfTRzMmr83inU1leKp/bawQWdjtmihpylPGPSu7uPoOB8qFAe/RmMi7FWKs2+RxbdjNc+Dn9WIj6i+YdAy53NtVJpU3lCFjw7Z5HE1YepnIVb/xrPR0i4tbSsoEuMkSHR55zkgYVWry+B44KLfY31g5fcBy6YEKyJngTOsXFbXaU4alBW+btc7G5IuBPETxLJrcGub7aujU8r3v4whukWc5G7W8eN7mDCiNfVVzJDdwNvYX/3BStXmrNlYd773l7sfxJfWQp1ioXk8VNAW1Zn5sg2kCRCfwFUfCk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27780C1E46BD704BAC2BEE858936EEC0@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbdfe8f4-8c86-434a-fb20-08d745bd4b33
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 15:46:00.8168 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ExNpKXdU9/XQYrDtgRUiT27GxFbHKFUMTcCZYjOOuntBSBqWHe8zLKZRvObjSErAG4HfiK3F55YdunuX8q4z5guCgkGobpd8Gu6PZXU/8Vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3215
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-30_09:2019-09-30,2019-09-30 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.155.12
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
Cc: Aditya Ramesh <aramesh@nutanix.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi David,

> On Sep 30, 2019, at 3:29 PM, Dr. David Alan Gilbert <dgilbert@redhat.com>=
 wrote:
>=20
> * Felipe Franciosi (felipe@nutanix.com) wrote:
>> Heyall,
>>=20
>> We have a use case where a host should self-fence (and all VMs should
>> die) if it doesn't hear back from a heartbeat within a certain time
>> period. Lots of ideas were floated around where libvirt could take
>> care of killing VMs or a separate service could do it. The concern
>> with those is that various failures could lead to _those_ services
>> being unavailable and the fencing wouldn't be enforced as it should.
>>=20
>> Ultimately, it feels like Qemu should be responsible for this
>> heartbeat and exit (or execute a custom callback) on timeout.
>=20
> It doesn't feel doing it inside qemu would be any safer;  something
> outside QEMU can forcibly emit a kill -9 and qemu *will* stop.

The argument above is that we would have to rely on this external
service being functional. Consider the case where the host is
dysfunctional, with this service perhaps crashed and a corrupt
filesystem preventing it from restarting. The VMs would never die.

It feels like a Qemu timer-driven heartbeat check and calls abort() /
exit() would be more reliable. Thoughts?

Felipe

>=20
>> Does something already exist for this purpose which could be used?
>> Would a generic Qemu-fencing infrastructure be something of interest?
> Dave
>=20
>=20
>> Cheers,
>> F.
>>=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



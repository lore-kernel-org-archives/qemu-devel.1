Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA03C43457
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75AAB2225D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="oxiv9HoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75AAB2225D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3U7-000561-G8
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <felipe@nutanix.com>)
 id 1kT3Qx-0002BB-3c
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:36:43 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:15554)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <felipe@nutanix.com>)
 id 1kT3Qu-00005o-4z
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:36:42 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 09FDXJjM030174; Thu, 15 Oct 2020 06:36:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=zB/i9h6ppzoFDUmmF6H8erYY+XUMBW7TW7m/F+o1s9M=;
 b=oxiv9HoZ7//7sHF5EpWfQrC06kaF5DzSlZtFdEbFZTYNRbB8hWqhvVqeVr9090W0BAK4
 np0rX+GPECa1wgGBA9D++RB324C2J4Fj0H93SfV2mBb+A2ndEmp40uJ4D0AuSNmm6EoV
 8Di2qAd82MZb0EplHtzCpsdJhBmpSnuxMbqFWuSSoClAakEwDZd91/6kaU1LzE9Ii21Q
 3MJQwt4wVr7B8wwbss/CirPU/nTmpotOBa/7Xv3TZu/YndRuMzUFxYjnCPMt7q6GS7Pa
 LIqOKK0iIwjNOOXjsoPrwt9H7dxIpQUpX/Z6EIEKYrloGMbDEKfhHFzU4YTL+pt3siHh oA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
 by mx0b-002c1b01.pphosted.com with ESMTP id 343b2j3kcr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Oct 2020 06:36:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jemB6mtC8EocqOcszAupd/Ac2gY1UN1EZO+dAKuhW0QVV/5xiq455KEvJsP/2SFyHXZYq85dluPFZIEVjDtCNJWFoqhqyo09OEgx+LD4XNkMiynqKpmPjLz83nEiQoehTPmPwF3VwaY3wRZUwsSmYYvo+Py/hAibT6h+qN0yXNF82ilhCq5kg5faovpCIy4qOi8LhwX9z2iRBOO5Pw5T+0uxlfcVE3dOt7ovVfHN4h1fcDnmAek3jbQ2cbd0CY1OtylF+F79DsLeptl1fS45ni3L89NeRc/h1aQhip8YucIR7QZkv/BQndtmMgk0NUxlBLSYpbLDiDMwHWPsxDU9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zB/i9h6ppzoFDUmmF6H8erYY+XUMBW7TW7m/F+o1s9M=;
 b=jpN/b2/lJ3PGVOzdbGNk9/UbMtfiZzXvvhxMN39k2G869PAJStykDw+r4UhMbhhRiJnzoES9w1CxfzOK1VOiXjNM0t2mJ9rKQ0eS0kGb27A3Rsk6Br2amTfclvcAuO0strVFUpKjQtHo01JmgAc4dPC6oDwd4YWjbWchCa4RbwqT16+sjj2xtw2rduBt2ASjDjsZ3YDJ1K2rHAekbp30Wv8qHP1xix85j2aP30j42kJluUpG+nWau+5/yj8KHx4hOfJYxaMrEEmZABiksRCAqRMPMLjTJA5uGYaDdWax24cTapmJbeiP2QjT3Xh9tNl/3ucSWwvM7zC6c+IWzTaHTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BYAPR02MB4358.namprd02.prod.outlook.com (2603:10b6:a03:11::17)
 by BY5PR02MB6884.namprd02.prod.outlook.com (2603:10b6:a03:21c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Thu, 15 Oct
 2020 13:36:31 +0000
Received: from BYAPR02MB4358.namprd02.prod.outlook.com
 ([fe80::a1a4:c04e:4405:dadb]) by BYAPR02MB4358.namprd02.prod.outlook.com
 ([fe80::a1a4:c04e:4405:dadb%6]) with mapi id 15.20.3477.020; Thu, 15 Oct 2020
 13:36:31 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4] introduce vfio-user protocol specification
Thread-Topic: [PATCH v4] introduce vfio-user protocol specification
Thread-Index: AQHWi2yod8zgm1HwkEWWpH+OZU5qy6l3gJEAgAZkdICAAZ1BgIAAYCoAgAFxbQCAAt7hAIARPYMAgANpRYA=
Date: Thu, 15 Oct 2020 13:36:31 +0000
Message-ID: <A375B06C-FA78-4392-A569-AE494EEF9870@nutanix.com>
References: <1594984851-59327-1-git-send-email-thanos.makatos@nutanix.com>
 <1600180157-74760-1-git-send-email-thanos.makatos@nutanix.com>
 <20200924082132.GJ62770@stefanha-x1.localdomain>
 <MW2PR02MB37232E78343B164C2405AC248B350@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200929103743.GB181609@stefanha-x1.localdomain>
 <2E6DF2C2-A3C3-404D-BB2E-B53B3555EB66@oracle.com>
 <20200930142408.GA320669@stefanha-x1.localdomain>
 <E0C4979F-157D-4ADC-9FCF-23A70FB6C931@nutanix.com>
 <20201013093056.GA164611@stefanha-x1.localdomain>
In-Reply-To: <20201013093056.GA164611@stefanha-x1.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.1)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [82.9.225.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ccd36f0-ff73-427c-1f68-08d8710f53c3
x-ms-traffictypediagnostic: BY5PR02MB6884:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB6884B42E954924BD69850798D7020@BY5PR02MB6884.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UkOy+4elhRdSH9fnRu5l24jcTkrW0CluhD437/Pk51l9q1zBDIJPNtyBMzx3PGgekfJykr/ZGQNJNb0VGXqelrLZAd17pu+ELmD3qcI/xdU0Ym3WPbFLYsGytJ3gxcGZnd3CkiOLQ0eOutdhqBnRpWTiclZ72QCT6Gb8fLchJZjWL6iehAdEO1VjjdDNEwSk5ZEoOnhbI78C5ZvO9mJsfxfCPkGKhDgMRceOLlYFBUp1JWdHxCwQ8MBIQF1/S+xIVdbD5yu/Y5BPq+LR+QuuX7pVVDMNH07aq+51W1Bi+wUAEM5b8B9O8Es/mBCjdyolqOmj78Z5hjz6anIpyCelVhPvN43vDKyTi10wv0cWIBV9iBfOSY/DVI/bD84sE59mISBbQupKGCGv6MiKEl/pGQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4358.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(39860400002)(136003)(346002)(376002)(396003)(54906003)(186003)(6506007)(36756003)(478600001)(53546011)(966005)(83080400001)(4326008)(316002)(8936002)(26005)(8676002)(2906002)(71200400001)(5660300002)(66446008)(76116006)(66946007)(64756008)(66556008)(66476007)(33656002)(7416002)(86362001)(83380400001)(6512007)(6486002)(6916009)(2616005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 0lEhhQkow25tPaSKfZqRvr5b/oQSku+/4XXcIUQlKkmWS5em41chqjGUnBJmepeAeB+xwkFXGmpUW2y8oV9Fg+ErRMgnOjJbh+vy6WOe0qLf2QwZRz9tP3bLcwVHaSZg7m2eLJVGbdwBUKAZzKvOBu9+8wDYT2PsQIk3KhgzGrZukauoOq966W4qkOOHZeGAcL6ShBIXQ2YPFNRxRzxPs9ThMXkpwWeXRpJodVY5eMGAOb4kzGS30rdtSgXJQuanVZ5596sxO/4PEnO/L1wCDCXFSjUicn9WZ4L+qkz4EBw20lt/bgADiFPpl6tHuf8+KYwAT0rhUD1g0LEXEkgRGNI/vM1GPvDL2Budg4egZTCeBijzzhbZO3+VGv5PDwdPIAkM6JPpfcXuyk8JU0qzuokMbKVg/NfHm80j6IuwLp+ls/inELNc57nkAjaOT2e5fbQGBCEBmVsXczPHrRqqnxVGF47qjs5PCSplLgcqNpEf2nHoMI+DtgUdytIOsh7HtK/1yR28itXbMakcuWtTT3VHEq5Qq3IyglGkREeFZFVTvk6gz1mbjnwwCU/XI2NHp9i29RGPqDw8/tCSzUR+43TeRiuRUGeW2iVCjPWJJ7MN1Zu27aU78gkcpTquA8MhHm9/hys7+8NIAXTWBu/zuQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E789D50F9322FF4D90C3F5E4A5FAE736@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4358.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccd36f0-ff73-427c-1f68-08d8710f53c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 13:36:31.4730 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9l4gC6Waq0qO/jKdLKe7JIa+hQ0WSVqGnBOsPTuayObctUd78mfxa1/G5rInX4+p8kzYTLtu/b2bVga7FhO2mk+GzQJSbXyB58lytoBDoGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6884
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-15_08:2020-10-14,
 2020-10-15 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=felipe@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 09:36:37
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 John G Johnson <john.g.johnson@oracle.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "james.r.harris@intel.com" <james.r.harris@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "yuvalkashtan@gmail.com" <yuvalkashtan@gmail.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "elena.ufimtseva@oracle.com" <elena.ufimtseva@oracle.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "ismael@linux.com" <ismael@linux.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "xiuchun.lu@intel.com" <xiuchun.lu@intel.com>,
 "tomassetti.andrea@gmail.com" <tomassetti.andrea@gmail.com>,
 "changpeng.liu@intel.com" <changpeng.liu@intel.com>,
 "tina.zhang@intel.com" <tina.zhang@intel.com>,
 "Kanth.Ghatraju@oracle.com" <Kanth.Ghatraju@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

> On Oct 13, 2020, at 10:30 AM, Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
>=20
> On Fri, Oct 02, 2020 at 10:14:23AM +0000, Felipe Franciosi wrote:
>>=20
>>=20
>>> On Sep 30, 2020, at 3:24 PM, Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
>>>=20
>>> On Tue, Sep 29, 2020 at 09:21:54AM -0700, John G Johnson wrote:
>>>>> On Sep 29, 2020, at 3:37 AM, Stefan Hajnoczi <stefanha@redhat.com> wr=
ote:
>>>>>=20
>>>>> On Mon, Sep 28, 2020 at 09:58:37AM +0000, Thanos Makatos wrote:
>>>>>>> It should be accompanied by a test in tests/. PCI-level testing API=
S for
>>>>>>> BARs, configuration space, interrupts, etc are available in
>>>>>>> tests/qtest/libqos/pci.h. The test case needs to include a vfio-use=
r
>>>>>>> device backend interact with QEMU's vfio-user-pci implementation.
>>>>>>=20
>>>>>> We plan to use a libmuser-based backend for testing. This, I suppose=
, will
>>>>>> make libmuser a dependency of QEMU (either as a submodule or as a li=
brary),
>>>>>> which for now can be disabled in the default configuration. Is this =
acceptable?
>>>>>=20
>>>>> If there are no other dependencies and libmuser supports all host
>>>>> operating systems that QEMU's -device vfio-user supports, then I thin=
k
>>>>> it's a good idea to use libmuser for at least one in-tree test in QEM=
U.
>>>>>=20
>>>>>>> Also please let us know who is working on what so additional people=
 can
>>>>>>> get involved in areas that need work!
>>>>>>=20
>>>>>> Swapnil and I will be working on libmuser and the test in QEMU, John=
 and
>>>>>> the mp-qemu folks will be working on the patches for implementing
>>>>>> --device vfio-user-pci.
>>>>>=20
>>>>> Great!
>>>>>=20
>>>>> John: Will mpqemu use libmuser to implement the remote PCI host
>>>>> controller?
>>>>>=20
>>>>=20
>>>>=20
>>>> 	The vfio-user-pci plan is to use libmuser on the server side.
>>>=20
>>> Okay. Using libmuser in tests seems like a good choice in that case.
>>>=20
>>> We'll need to figure out the details of how to do it because the
>>> traditional shared library dependency approach is not well-suited to
>>> in-development code. It would involve shipping libmuser distro packages
>>> so QEMU's build system can declare a library dependency (with details
>>> provided in a pkg-config file).
>>>=20
>>> Here are approaches that are better for in-development libraries:
>>> 1. Keep the libmuser code in qemu.git.
>>> 2. A copy of libmuser in qemu.git with changes being sent upstream
>>>  (allows more flexibility in case QEMU-specific issues require
>>>  experimentation).
>>> 3. Git submodules.
>>>=20
>>> #1 if you're happy to use the QEMU development process for merging
>>> libmuser code then it's easiest to officially host the code in qemu.git=
.
>>> libmuser gets a subdirectory in the qemu.git tree and you (the
>>> maintainers) send pull requests. A libmuser library build target
>>> provides installable static and shared libraries so external
>>> applications can link against libmuser too. The big advantage here is
>>> that QEMU can instantly use the latest libmuser code changes.
>>=20
>> I think there's a couple of limitations here which we should keep in min=
d.
>>=20
>> 1. Does putting it in qemu.git precludes it being BSD-3?
>> There's been evidence of people using (or at least trying out) muser
>> from where it currently lives. That doesn't mean we can't move it, but
>> I'm wondering if it means we have to make it GPL.
>=20
> The 3-clause BSD license is compatible with the GPL according to
> Wikipedia:
> https://en.wikipedia.org/wiki/BSD_licenses

Ah, ok. That's not an issue then.

>=20
>> 2. What about other projects that need libmuser code?
>> What worries me more is projects like SPDK/DPDK wanting to link
>> against the library and having to clone the entire QEMU repo as a
>> submodule. That sounds a lot more expensive than option 3 and probably
>> have further complications if they aren't GPL.
>=20
> In the early stages where the vfio-user protocol and library interfaces
> might need changes it will be hard to use it from multiple applications
> without compatibility issues. If SPDK/DPDK are communicating with QEMU
> using a cutting-edge library then they probably need to build QEMU from
> source anyway. ISTR they also maintain a QEMU fork? So maybe it's not a
> big issue for them.

A few things on this:

Per Daniel's response on the other fork of the thread, I think we can
develop faster if we're not depending on qemu-devel. With the right
set of maintainers on the project, there's arguably more flexibility
in working at a restricted set of code. QEMU can then update the
submodule when a "checkpoint" is ready.

Also, I don't see why SPDK/DPDK would need to build QEMU from source
for their implementations. That is, they will need an up-to-date QEMU
for enabling their development, but they don't provide a QEMU to their
users; they just have to wait for a release.  I talked to Ben Walker
(SPDK), and he confirmed SPDK doesn't really maintain a fork of QEMU.
Apparently there was one when they were doing vhost-user-nvme, but
that's now abandoned.

If they had to add the entire QEMU as a submodule, it could
potentially be an issue, right? That's a lot of code just to get some
headers.

>=20
>>>=20
>>> #2 works best if the library is a small (just a few source files) with
>>> no fancy build system requirements.
>>=20
>> The risk here is that they go out of sync. There's the same (or even
>> more) maintenance burden as point 3 below, with the added risk that
>> someone could patch the files and make cherry-picks non-trivial.
>>=20
>>>=20
>>> #3 is used in QEMU for several other components. Submodules are a pain
>>> to sync (requires sending a qemu.git patch to move to a new commit ID),
>>> so this isn't good for a dependency that moves quickly.
>>=20
>> I argue this is no worse than option 2. It's what I think aligns best,
>> but let's keep weighing pros/cons and come to a conclusion together.
>> The list of maintainers for muser.git should be extended to include
>> more QEMU stakeholders and probably other projects that will use it
>> (as) heavily. The topic has been raised in SPDK's Slack team on
>> whether the client library should live in a repo of its own (eg.
>> libvfio-user.git). Given the reference implementation is in libmuser,
>> I still think muser.git is accurate (but can easily be persuaded
>> otherwise).
>=20
> Me too, no solution is perfect. My thoughts about developing it within
> qemu.git for now is that this will make protocol and library interface
> changes easy. It will also encourage applications (DPDK/SPDK) to build
> against a matching QEMU so that there are no compatibility problems at
> the protocol or library level while the code is still heavily under
> development.

I suppose that challenge is up to the vfio-user/libmuser maintainers
to resolve by tagging rc versions or something along those lines.
Those would be the ones we can add to QEMU master as the work
progresses.

Thoughts?
F.

>=20
> Stefan



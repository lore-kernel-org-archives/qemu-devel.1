Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CACEC74A4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 10:16:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18ACD208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 10:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18ACD208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlW8A-0002D2-1t
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 06:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59488)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <LMa@suse.com>) id 1hlW7f-0001la-2q
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:16:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <LMa@suse.com>) id 1hlW7d-0003mk-RO
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:16:19 -0400
Received: from m4a0041g.houston.softwaregrp.com ([15.124.2.87]:48720)
 by eggs.gnu.org with esmtp (Exim 4.71) (envelope-from <LMa@suse.com>)
 id 1hlW7d-0003Ue-KH
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:16:17 -0400
Received: FROM m4a0041g.houston.softwaregrp.com (15.120.17.146) BY
 m4a0041g.houston.softwaregrp.com WITH ESMTP; 
 Thu, 11 Jul 2019 10:16:05 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 11 Jul 2019 09:44:35 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 11 Jul 2019 09:44:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHve2ho0KHLgbYfN1S4lSwaUTnIa9NZnR+x8SSexwFV0XrCE6BObictM3SXBOQiy1qEaIvNeQcJJbdsuDThVWHd4VoHwT1k8T2j54SRyTIC5v49Xu0JgFjDGiMf3ikgbGhk3lc5zIUjHBwuWgN/B2VyhCQOBdkd7mulLUCsg1bNC6PiSzoovv4Clx1+grbXTtGELuRli091KihWJeHo3khqBkDkkjJfDeYs77wPM3ASPBl3aq+6SSIMSVARxQ687JxI/lB6xvOIuj53Jx/hRJ9s5h4YQoPIw1DBzIAwvfKa6yjB9FVaJWpVzRo05EjcLkt9nZbvfD0gFNPWlNjKHyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HQ5Go9EyZaTPFQdN1usVDbOqjK733QH7UaaLr+5mzU=;
 b=awA3wxJFvGDQuDMMQqG+EIUN5Nmy6QM/rT0+5ouiXWfGSqDovKETosVBCGpBsl+cKH51eitmp5UP2dTVpRNpxRa2cyfb/4gEURCPvrQFQhmupePl5Id+VkrVhHUuWb+VrQy3LBLU5kkbsp9vBr/yJk26Wv8G/8CWVrdX9qtOdYccRIsoQTSemLcYT3kCVB3s+UTVxqwoUk1+qgVgGk9WNuCXoolW/i0FjXCM4M129avdbImyyYCKvcebbIaWkdR6h5OMdUbWLbRfiYt+Y0IHLhElDLUHF76tpu8jtlnJ0JOajrsk4fI3hRR2RclN2PMvy/ZLVTa756/r29MdXAeS4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=suse.com;dmarc=pass action=none header.from=suse.com;dkim=pass
 header.d=suse.com;arc=none
Received: from BY5PR18MB3313.namprd18.prod.outlook.com (10.255.137.156) by
 BY5PR18MB3396.namprd18.prod.outlook.com (10.255.139.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Thu, 11 Jul 2019 09:44:32 +0000
Received: from BY5PR18MB3313.namprd18.prod.outlook.com
 ([fe80::b588:8e99:5614:73ad]) by BY5PR18MB3313.namprd18.prod.outlook.com
 ([fe80::b588:8e99:5614:73ad%4]) with mapi id 15.20.2052.020; Thu, 11 Jul 2019
 09:44:32 +0000
From: Lin Ma <LMa@suse.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dgilbert@redhat.com"
 <dgilbert@redhat.com>
Thread-Topic: [Qemu-devel] migrate_set_speed has no effect if the guest is
 using hugepages.
Thread-Index: AdU3zTKKe7aEJr5KQ9WS3a20E1+sgg==
Date: Thu, 11 Jul 2019 09:44:32 +0000
Message-ID: <BY5PR18MB3313E1E22A22D236D4C2680DC5F30@BY5PR18MB3313.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=LMa@suse.com; 
x-originating-ip: [45.122.156.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a57aea17-e6d3-4192-a858-08d705e460a5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BY5PR18MB3396; 
x-ms-traffictypediagnostic: BY5PR18MB3396:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BY5PR18MB339602F5C149D6CF0491B170C5F30@BY5PR18MB3396.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:663;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(199004)(53754006)(189003)(2906002)(81156014)(8676002)(74316002)(33656002)(8936002)(478600001)(81166006)(3846002)(256004)(186003)(316002)(6116002)(99286004)(7736002)(486006)(790700001)(476003)(26005)(110136005)(53936002)(76116006)(14454004)(66066001)(2501003)(66946007)(71200400001)(7696005)(66556008)(66476007)(64756008)(66446008)(71190400001)(68736007)(102836004)(80792005)(25786009)(9686003)(55016002)(86362001)(6306002)(6506007)(54896002)(6436002)(52536014)(5660300002)(558084003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BY5PR18MB3396;
 H:BY5PR18MB3313.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wlO8YpkKXVVmjuqAgDZ71nrAiRAwWUHPh20Lnr5mrMOzsAMrQppgaGH78fpTEMr42EPR0XeKhlMjKN+5iiFtYZNqJg/5zR3SUc0R1oII3DVtT4zeWtg7GPwBe3Ke0kmY1S6uK8AH4QCWbdJAATmwvtfQoO//ADWSA8poimQhkNYN/41hSXcDys+/dykO3S0qIxXCuICuVjwwCMCIVDZ9VhrZSI3g3FvcOzeuBOhNWqRKH8sXpauG11vlSFoSQ6sHiJlEVCtlldRf7VIWWECUB+a3qGdLtxk93j/BnaSdk+93lja8T2e2V/nXVryAOhSIKJH6pehy0SGPzWExxTyC0sJmgKjJ7qocKE8YH7hVgXHuG2HGg4+8IR0ezM0OP0nrNSZLPCMpJa81ssBFe9x5FDPuE38bJIPoP8P4OQ9mG4E=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a57aea17-e6d3-4192-a858-08d705e460a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 09:44:32.7046 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LMa@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3396
X-OriginatorOrg: suse.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 15.124.2.87
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] migrate_set_speed has no effect if the guest is using
 hugepages.
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

Hi all,

When I live migrate a qemu/kvm guest, If the guest is using huge pages, I f=
ound that
the migrate_set_speed command had no effect during stage 2.
It was caused by commit 4c011c3 postcopy: Send whole huge pages

I'm wondering that is it by design or is it a bug waiting for fix?


Thanks,
Lin

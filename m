Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA4BC3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 22:46:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2AF20716
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 22:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dkwsoofO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2AF20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9cmQ-0006x5-TN
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 17:46:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sunilmut@microsoft.com>) id 1j9clE-0005ll-41
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:45:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sunilmut@microsoft.com>) id 1j9clB-0004ED-Nr
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:45:03 -0500
Received: from mail-bn7nam10on2115.outbound.protection.outlook.com
 ([40.107.92.115]:56032 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sunilmut@microsoft.com>)
 id 1j9clB-0004E3-DP
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:45:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFoTWMLy3DLNfJOI7+nyM6T3G4ySyRKeeSFLTDrvGtw6qHyF8drzcKVT3opmtCdY3trcT4NmWBue/3+AHm9bWUboWd3NDRBX7cfb/+MEhQMQGJxtc9eziRgksY1WIklJBW80Gt3Vk1EWVa1UC2WQEkxXpM/iUbP8vSetNuKYf+qIblFBIvKgclWc+F0Hqdr8HGBSzYiy/DA/XbYQnRAWQSsLezJpDL9XlLHJ1l0KEKRxG4RKMSZN31DnIrLjBLLwpH5oZpwql3WNwDCUfW7uh7PZ32HTtV8dZQDjOCXu9LK01TY4bKF4kk5rw1jp22+G5bUKwqn3bWSoF7Bpf4uFrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pie/7fYCLsYnjCzeZv+toYqAMuviQezCWGYuNtd+KlU=;
 b=Jo/ZvoYYVJioyFFKNJru/wfcKyvZkf4N1pmMLzCAsIxc7Caaho6aCOglXKCBE97yOE6TamUm4shYiEDhOfbQATbqiaFOEQ5KARH99Ihf8XT/7V+HRYQOcj8z6PvOVBVARGbiB3QRVuU5A4TLVuuzdSsA8zIir1tyv10V7txJjwtWKp7FETCYjCeX0gyIGRyXewcLNkfkD1YxrIq+vosAe+VmSnLNLPOzurDvofInqK+95uRSCBNcxX2Qq081dL7CIXphLgd1kqGMTR6nsj4PmCybqSpvKbI+rxoE38/QC03g6eh+ycfhSfFHZOhrD/uHWtnyZwKKTyBOvLZ0/vXjGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pie/7fYCLsYnjCzeZv+toYqAMuviQezCWGYuNtd+KlU=;
 b=dkwsoofOC7j057mlvmRgKnT7Ebly5jbEmtPeRQKLhK3qkYlFV8jQm/S6diO77yNCVY63dJzEBz7vx0AhTTlWSUgYcEgRFEvNcuOoX8coZ2i8BVmzs8gG5RWO2Y5ncTD8g+HNLgwYoDIFc7cCw9D2EyFmePquF0YMkxYW8SGNzyQ=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN4PR2101MB0877.namprd21.prod.outlook.com
 (2603:10b6:803:46::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.4; Wed, 4 Mar
 2020 22:44:59 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::b1fc:af97:6a7b:4fe]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::b1fc:af97:6a7b:4fe%5]) with mapi id 15.20.2814.005; Wed, 4 Mar 2020
 22:44:59 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Paolo Bonzini <bonzini@gnu.org>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Weil
 <sw@weilnetz.de>
Subject: RE: [EXTERNAL] Re: PATCH] WHPX: TSC get and set should be dependent
 on VM state
Thread-Topic: [EXTERNAL] Re: PATCH] WHPX: TSC get and set should be dependent
 on VM state
Thread-Index: AdXs5oCBJsjFayPuQg++a0KvVJgCQQBPaQ8AABVvfKAAGpE0AAB6DlkQAC4MW4AAPGwU8A==
Date: Wed, 4 Mar 2020 22:44:59 +0000
Message-ID: <SN4PR2101MB088076531563C720C56B11CBC0E50@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <SN4PR2101MB08804D23439166E81FF151F7C0EA0@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <37e639a1-eb9f-b769-d61c-112d148bcff3@redhat.com>
 <SN4PR2101MB0880FE16EE36BF356552A9DDC0E80@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <4277f568-2b20-f7c4-5764-f516c8e281a9@redhat.com>
 <SN4PR2101MB088094833D95758F871BE401C0E70@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <225d909b-fea7-a655-4271-ceccb7701993@gnu.org>
In-Reply-To: <225d909b-fea7-a655-4271-ceccb7701993@gnu.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sunilmut@microsoft.com; 
x-originating-ip: [2001:4898:80e8:f:4a4:6c8d:d67b:c8c7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c96bc499-a652-46f1-ef31-08d7c08dab98
x-ms-traffictypediagnostic: SN4PR2101MB0877:
x-microsoft-antispam-prvs: <SN4PR2101MB0877FC75B8257F651DCDDB0DC0E50@SN4PR2101MB0877.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(189003)(199004)(8990500004)(10290500003)(71200400001)(9686003)(55016002)(7696005)(478600001)(316002)(6506007)(76116006)(53546011)(33656002)(8936002)(52536014)(54906003)(966005)(2906002)(110136005)(66446008)(64756008)(66476007)(86362001)(8676002)(66946007)(66556008)(4326008)(5660300002)(81156014)(81166006)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN4PR2101MB0877;
 H:SN4PR2101MB0880.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xKdRnp52BdqoQWOcWosAMolLA/vyrysDPJoYe8qUHKDzA8ZFsAqB83cNvD8gY03ekOG8WQanmn50yq7Mkl89unQjfuPtSyVm8r5QMdagBhUuGtSDm8p6rEBgwlSKYRMzAV6PAdsM7nL+/QN+XtWWejjAYgUZ2VIZ8qXH0iL65l5ukQ5gg5h/3ohb8jMIBa4YsWdQbHr9h+EibwG3cQkjfE7nhHx8gvau4QHKid7zo+bOdpGbpgsfwUPBQ7vua2XvUIX2qVInQvwAarbwugoN6OWJs3gQoYMQax0XJlU2omOlJjaNLTOh67hvQX7Xp1Ev0p8pVSd3PO+J3qv8JhdIFlOJGv2qBhTL/arxTWr1xvKb8fDCL9il94Iiz6g341YIKXEUamtZ1JhJPBDfSgcj1NwMDY6NAzXu61/cYzrchhbKGfz1IlVxH9f0+5+oNk+biReEtJSlhB8wy1zv5xrYC6fWrW2rBkKGmOc/NO/D9joVwUemnOeEODT8HJCrBbFt0rTbs7uesLogMMS21kBIBQ==
x-ms-exchange-antispam-messagedata: OgDkNM+mSI3x+qqqt8drl1DJOijrw2F2aYIhDjrwN552G1wIJUL9Cwx3jyKmRtUHzm73nWs+s5KY/kbVnDm+QX3try7uQVnOxNkCAqh7fPCJCdt+kbjEjYv8K4vrSuL/UiRWmLFUXPVfbgY+otE2Dkq/JJH1jJi8p959Y7mBL14fzN6mABE5dMX7Ht3YXGl6n/I1E6jmavseS4hByUyOWQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96bc499-a652-46f1-ef31-08d7c08dab98
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 22:44:59.6244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lfIGuZR3g01fbXH7fcL+n9LEgijQL+XI/Qtvcx9jbmYScw6ZxF9UDX4EJ5dYX3myNtqcJLFtOjPlnhOe5TYc6dXQArSbWp1Q+Z+1kSd7B44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0877
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.115
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


> -----Original Message-----
> From: Paolo Bonzini <paolo.bonzini@gmail.com> On Behalf Of Paolo Bonzini
> Sent: Tuesday, March 3, 2020 9:53 AM
> To: Sunil Muthuswamy <sunilmut@microsoft.com>; Richard Henderson <rth@twi=
ddle.net>; Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org; Stefan Weil <sw@weilnetz.de>
> Subject: Re: [EXTERNAL] Re: PATCH] WHPX: TSC get and set should be depend=
ent on VM state
>=20
> On 02/03/20 20:59, Sunil Muthuswamy wrote:
> >> You'd be using it to include a signed tags in a pull requests; that is=
,
> >> the git tag that you ask to pull has a cryptographic signature attache=
d
> >> to it.
> > Great. Is there a link that I can use to read up on how to get the GPG =
key
> > and how to include the signature or what process should I be following?
>=20
> This guide seems good, though I haven't tried:
>=20
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fmediu=
m.com%2F%40ryanmillerc%2Fuse-gpg-signing-keys-with-git-
> on-windows-10-github-
> 4acbced49f68&amp;data=3D02%7C01%7Csunilmut%40microsoft.com%7C826eb46e9f9f=
44281bd008d7bf9bb70d%7C72f988bf86f141af91ab2
> d7cd011db47%7C1%7C0%7C637188548242292250&amp;sdata=3DE%2BQ0ar57y65EI6%2FD=
XXOnEqHM682SOhu1WyzrXrILWGs%3D&amp;res
> erved=3D0
>=20
> You don't need the "git config --local commit.gpgsign true" command, but
> you will then create a signed tag with
>=20
> 	git tag -s -f qemu-for-upstream
> 	# let's say "mirror" is your github repo
> 	git push mirror +tags/for-upstream
>=20
> and send it to Peter.  I really think we should document this final step
> ("send it to Peter") better in the wiki, because the git tools for
> sending pull requests leave a lot to be desired.
>=20
> Paolo

Thanks. Ok, I am setup with GPG. Where should I be sending the pull request=
s to? Who is "Peter"? Do I have to send it to you?


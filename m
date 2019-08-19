Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A829EC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:57:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D782064A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="cnMueNBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D782064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hziAX-0000Rv-KS
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 09:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amarkovic@wavecomp.com>) id 1hzi9n-0008FG-Ah
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 09:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1hzi9l-0007O1-2q
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 09:57:11 -0400
Received: from mail-eopbgr780103.outbound.protection.outlook.com
 ([40.107.78.103]:45665 helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1hzi9h-0007MG-2o
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 09:57:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPmZsbeBDDc4f8nWDEnNp/BZzmTKBrSv1ESMqc/p1U6djU09NfIvhZ/r25d88+EJjqQaTHVkEQnU5WrbsSPemHevKt+8+jWuG8WNh92N+QKzqU+AvOM7mHcA0QmfaPajCB6ZubZBLXKfj8hR5PpwXvhPcgFRAf+Wxpw0IuKh17+mCYXigEwNqAqb7CrDdOqZM63PQ7GIktOn+yeSNeXLdQff0fG3WpKj3s9FyT0f992Y/Vbm41xiOpMR4dLxNE6cQfdtN/mgh1Q+4jmxqvk3h0LEJime1HZYajagLs/LI9yC0rfgzXbg8qB4bUKqGF9s2RiaDjCrnPrD39m4/g4k3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRAd9rCnHHfHHyvdVQSOqe2vslRtHTIB9JDKmQsHCjM=;
 b=Sc2+5Wo0HtxgQE/x9QofJzxBm7SW7uLtYhyMvHl4YYkRSLF88fAwXVtCakd59arOJH8I1XgoUycr4aCEt/aDZWo6zO+QltQDiojrHq9os//sKIDEXEHUkdjMWT06UU88HNkaQUaC6TdZoUKPCES2GD5CYMRtrWjMnJZs18JC+dtTdxSG3dcYq48RYZqe0IiHMKnZoUQBduq0VjV1AcB0sIE4Nx5Od0Qy1T7d/5ocBlCWFKxygk0K2pJ/BAv2Q46oa5o+5zMYr3O+kkfRBTYRy7EaUkgwk9tYh0EJ9zQqiDy9UMnsWzXuA7L/mck6gprtm9emdSaTsbIXGlHoB/+nZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRAd9rCnHHfHHyvdVQSOqe2vslRtHTIB9JDKmQsHCjM=;
 b=cnMueNBHwRqL4m+PIXXrbTbhYpg/vZ7hb6QuCA5z5yA2tl7qpp27sGvgchvq1CNpgeX+xsBnMVKDA9Ko8rIx4nNBIXA5ec8z90KbqQ0nhjFL1fAV88s/O3KNG6lVsWjrqdrXEQQ6leLyJi3UAJ+EssMb2RZM7jq2V9gqNVTlo0Q=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1412.namprd22.prod.outlook.com (10.174.80.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 13:56:59 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::709c:ea73:df85:b135]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::709c:ea73:df85:b135%12]) with mapi id 15.20.2178.018; Mon, 19 Aug
 2019 13:56:59 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Thomas Huth <thuth@redhat.com>, Aleksandar Markovic
 <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [EXTERNAL]Re: [Qemu-devel] [PATCH v8 10/37] target/mips: Style
 improvements in helper.c
Thread-Index: AQHVVpKsVgX2Hs9AHUOyK+FASaGCTqcCfcG4
Date: Mon, 19 Aug 2019 13:56:59 +0000
Message-ID: <BN6PR2201MB125153B574716BB28BBBDBBCC6A80@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1566216496-17375-11-git-send-email-aleksandar.markovic@rt-rk.com>,
 <7b8e46e1-ac78-9a32-24c0-305ac4db540f@redhat.com>
In-Reply-To: <7b8e46e1-ac78-9a32-24c0-305ac4db540f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2c9b47a-a600-4787-1200-08d724ad1af0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1412; 
x-ms-traffictypediagnostic: BN6PR2201MB1412:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR2201MB1412FD6C2F7C1F487535DBABC6A80@BN6PR2201MB1412.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39840400004)(396003)(136003)(366004)(346002)(189003)(199004)(5660300002)(2906002)(26005)(6436002)(3846002)(6116002)(71200400001)(71190400001)(486006)(76116006)(91956017)(66946007)(476003)(7696005)(76176011)(14454004)(316002)(99286004)(52536014)(66556008)(66476007)(66446008)(64756008)(2501003)(54906003)(110136005)(446003)(11346002)(81166006)(8676002)(8936002)(81156014)(7736002)(9686003)(74316002)(305945005)(186003)(55016002)(14444005)(256004)(6506007)(53546011)(33656002)(53936002)(86362001)(4326008)(6246003)(478600001)(66066001)(229853002)(102836004)(55236004)(25786009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1412;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tWleiX9QcmP+fa2HHeXS7cRYFSRffRsnsDpdTGGXvLCK5lf+/9BWOvbm8520zr/x0iiLFYZkV6BKPskqIPRv6bMEC5DG1uNl4oWSUuSk/01gkAb17ixOC+XHxfyvg3mjMCFSp0IjASsv9wjTdL/wSdgLxKEsI8968xsEn9n6GRl6XAxgbcmRDr+0Dos6rkKne/z3JB5upbPiPuGvNmOsw5nXkQXcsNNOzAsG4rmiBsjcL5Zh5vbpbMQXwGnSF9M22mPquOi/G/6Nb+IJN+Ql19QpaMLKblqNJQGMbnExYC5rbee/qR7vY/4l+uU7KC5V36mAiE2Jq8Ced2esOff6uOQZtaUVECyrqA9BbQns6FNTAGilj7gBeJAEHdEYxymUuxlYHfRkuF8dXyE4WHNRi9p35LsP02SEDAhplg9o1qY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c9b47a-a600-4787-1200-08d724ad1af0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 13:56:59.4148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: baAoUnaeuG0Zx+dVdQMggbHIJG8x483v0z6QZzqdJd2gJa70KCLmKA11vyEW8r89ST5LDmA7684sUUQAaUg46g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1412
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.103
Subject: Re: [Qemu-devel] [EXTERNAL]Re: [PATCH v8 10/37] target/mips: Style
 improvements in helper.c
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Thomas Huth <thuth@redhat.com>
>=20
> On 8/19/19 2:07 PM, Aleksandar Markovic wrote:
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> > ...
>=20
> > @@ -48,26 +48,28 @@ int no_mmu_map_address (CPUMIPSState *env, hwaddr *=
physical, int *prot,
> >  }
> >=20
> >  /* fixed mapping MMU emulation */
> > -int fixed_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *p=
rot,
> > -                           target_ulong address, int rw, int access_ty=
pe)
> > +int fixed_mmu_map_address(CPUMIPSState *env, hwaddr *physical, int *pr=
ot,
> > +                          target_ulong address, int rw, int access_typ=
e)
> >  {
> >      if (address <=3D (int32_t)0x7FFFFFFFUL) {
> > -        if (!(env->CP0_Status & (1 << CP0St_ERL)))
> > +        if (!(env->CP0_Status & (1 << CP0St_ERL))) {
> >              *physical =3D address + 0x40000000UL;
> > -        else
> > +        } else {
> >              *physical =3D address;
> > -    } else if (address <=3D (int32_t)0xBFFFFFFFUL)
> > +        }
> > +    } else if (address <=3D (int32_t)0xBFFFFFFFUL) {
>=20
> While you're at it: That line looks weird. Why is this first marked as
> "unsigned long" with the UL prefix and then casted through a signed
> int32_t ? I think you should either drop the prefix or the cast here
> (but probably rather in a separate patch).

Agreed, Thomas, this looks totally weird. Thanks for spotting it. I'll thin=
k a little
more about the best way of fixing it.

Aleksandar

>=20
>  Thomas


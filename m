Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8644DC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 13:50:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FDFC22DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 13:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="ohXLtxDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FDFC22DA9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i04X8-0007ib-EE
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 09:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amarkovic@wavecomp.com>) id 1i04Vz-0007IZ-ED
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 09:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1i04Vx-0006S8-Tn
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 09:49:35 -0400
Received: from mail-eopbgr780128.outbound.protection.outlook.com
 ([40.107.78.128]:46842 helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1i04Vx-0006R6-Hs
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 09:49:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3tYWA+5tsIyCWc07pOxuzmt4WPod0/kVqH86lCZ2lr2clCgPasd4rzeKQHQ3ZE5GNDz98nxxv6AbuU/GnE1+Xc+tTcj4KQAJlItFKrtIuQqJgNe2qY7yBNj+Ftq+RbG3BuPKmi0rE8kyNozGrDr307kUZLWdfGjGlVaSRmRMmkM0U111uvFyl6byrKqM5e9HKYjcuf3ut2wgsBWcwBeFIQMrlt6eO00HJrbnhsiVrjgxh1KD97HpaapsKAZ0oTVv8ZQAmEMA32Wqw/zQVHGUCTuXmN4ll23ivAoEOWBPSRbZx6v1gE5HbLtsT2KJUa3+Ql+rtNOLy+P6ENiCuPMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Jsyz/EvMD0p3JjHboi5K9NhxspVN2zFU6YLB1eIFxE=;
 b=aKaTETctNh8scHidwdcIGZ6yyGPEjOh4QbT8leOEO8lS/+epZuEYI6tzTa1MmWz8Rb2WP8hQM4a+70tKlfi87IvurDmZnlfP6Vi8IRcyEVSLfmG4EYsH62D99kdYw/kcb5EBX77ghzGbFvg0zb1WVgXrMUh/dVYmQ+/T884hMiUNGWCQWToRHAhCLairNskcMY7iigAmoFbZoRfNPFvU9XsNQw39bTlbbtxMBbSfJ3sHFBTxiod5FMtfyvE+E/ahA0N5nK2L+yPGC/L5dU8618Qh1EIKI9Qk9KV+lm8wBpp3f35LtuIcfw42ydObCnnIYrT4fPFwKHSvc5Y2N9wl9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Jsyz/EvMD0p3JjHboi5K9NhxspVN2zFU6YLB1eIFxE=;
 b=ohXLtxDju7sxjh0v0uJ7nPeDw0/5XM85b2z0aISv1Lmg8bUbLX5wASLhXEDUBMLkM0mVooBq7GKT7yXnlYYa7jf6DGjseqZwvVItu8FGGnclrai1KA4HtFt8mujvrhpcLFHrKKJjYNICtMEvZxmZXPKVZ8I9BrQGQh21L+7nvtw=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1732.namprd22.prod.outlook.com (10.161.155.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.23; Tue, 20 Aug 2019 13:49:27 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::709c:ea73:df85:b135]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::709c:ea73:df85:b135%12]) with mapi id 15.20.2178.018; Tue, 20 Aug
 2019 13:49:27 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Peter Maydell <peter.maydell@linaro.org>
Thread-Topic: [EXTERNAL]Re: Proposal for amending TCG interface naming scheme
Thread-Index: AQHVV1XFWW/0Wa1HQESTSd2lS0WjRqcEBcwAgAAGa4k=
Date: Tue, 20 Aug 2019 13:49:27 +0000
Message-ID: <BN6PR2201MB1251C78A16D557867586FFD4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <BN6PR2201MB1251511E7694854909AFEEB4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>,
 <CAFEAcA9UJGXOdNUD49bxmrdoZ5FEv4VLqAvyzDw66MOGsGB=wg@mail.gmail.com>
In-Reply-To: <CAFEAcA9UJGXOdNUD49bxmrdoZ5FEv4VLqAvyzDw66MOGsGB=wg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17387080-e628-4c88-7f0d-08d725753820
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1732; 
x-ms-traffictypediagnostic: BN6PR2201MB1732:
x-microsoft-antispam-prvs: <BN6PR2201MB17327F204D087827E5DD5BE0C6AB0@BN6PR2201MB1732.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(39850400004)(346002)(376002)(136003)(189003)(199004)(6916009)(6436002)(33656002)(26005)(66066001)(229853002)(102836004)(55236004)(9686003)(6506007)(186003)(446003)(86362001)(81166006)(81156014)(71200400001)(256004)(11346002)(305945005)(71190400001)(7416002)(5660300002)(8936002)(7736002)(52536014)(55016002)(74316002)(8676002)(64756008)(66446008)(66556008)(53936002)(66476007)(91956017)(76116006)(66946007)(6246003)(99286004)(476003)(486006)(7696005)(4326008)(14454004)(316002)(54906003)(2906002)(76176011)(25786009)(6116002)(3846002)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1732;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OS7kBCaWJT1qzbB9tREhYAgUzyHl/5XDCbPhqKfk1ktodkPQ76yKFj9soBGRuXfoJ9ba7Jv3NO/zeHdB2UdWBglCzHG7TIqB7MIeZxCH91e2dum0fCZ/jEWnzsw2z6JKHLT0M7aeuYze+thKLBd7/xTLbRl9epJOwAPLuTJGSKeGBu+D+c4+AKTZ5DHwEWvmmE8HTO6hwwDFHPlmNewJm+6E/ZXketmPtJ4pEYqovKA0749GOvYCb+q6XFuwuC8Eu5s3FbGZNTTAcpq2SLPjN0/2cuXcByDsfNE9ispZimH1zZqnTNYyABDt+Xvc3+v4Sw1aFccE9LcNiBSlONhkvX2uCBTp9z6KYVSm/WOqGMRK3OyZUPZeXLSvEXUzMmjm01vfC0Hveqa7biNVogUedtsMKNULs3vWZexkIJuExn4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17387080-e628-4c88-7f0d-08d725753820
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 13:49:27.5741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Mb7ymoyb5rnKciNuHos0EjW9fSuIQwZ5Lfl97x0QqiWVZgydzXgNYwWBTEijkpOE5Wk318AscuwEPHLiqFe1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1732
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.128
Subject: Re: [Qemu-devel] [EXTERNAL]Re: Proposal for amending TCG interface
 naming scheme
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
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Peter Maydell <peter.maydell@linaro.org>
> On Tue, 20 Aug 2019 at 13:50, Aleksandar Markovic
> <amarkovic@wavecomp.com> wrote:
> >
> > Hello, all.
> >
> > I noticed certain barrier and difficulties wrt learning TCG interface b=
y
> > newcomers and to some extent oldcomers too. At least some of them can b=
e
> > attributed to not best choice of names for functions TCG exposes, espec=
ially
> > in the area of extract and sextract. I have a quick idea on how to impr=
ove it
> > using the following renaming scheme:
> >
> > tcg_gen_extract_i32
> > tcg_gen_extract_i64
> > tcg_gen_extract_tl
> > tcg_gen_sextract_i32
> > tcg_gen_sextract_i64
> > tcg_gen_sextract_tl
> > tcg_gen_extract2_i32
> > tcg_gen_extract2_i64
> > tcg_gen_extract2_tl
> > tcg_gen_extrl_i64_i32
> > tcg_gen_extrh_i64_i32
> > tcg_gen_ext_i32_i64
> > tcg_gen_extu_i32_i64
> >
> > could become:
> >
> > tcg_gen_select_i32
> > tcg_gen_select_i64
> > tcg_gen_select_tl
> > tcg_gen_select_s_i32
> > tcg_gen_select_s_i64
> > tcg_gen_select_s_tl
> > tcg_gen_gather_i32
> > tcg_gen_gather_i64
> > tcg_gen_gather_tl
> > tcg_gen_extract_l_i64_i32
> > tcg_gen_extract_h_i64_i32
> > tcg_gen_extend_s_i32_i64
> > tcg_gen_extend_0_i32_i64
> >
> > The idea is to provide significant "lexicographic" distance between tho=
se > groups of functions, rather than having the similar name (wiht common =
root > "ext) for all of them.
>=20
> The current naming of the extract/sextract TCG ops is intended to keep
> them in line with the extract32/sextract32/extract64/sextract64 utility
> functions in bitops.h. I think those ones are reasonably named. The
> other ops are a bit more ad-hoc in naming, admittedly...
>=20

How about

tcg_gen_extract2_i32
tcg_gen_extract2_i64
tcg_gen_extract2_tl
tcg_gen_extrl_i64_i32
tcg_gen_extrh_i64_i32
tcg_gen_ext_i32_i64
tcg_gen_extu_i32_i64

to

tcg_gen_gather_i32
tcg_gen_gather_i64
tcg_gen_gather_tl
tcg_gen_pick_l_i64_i32
tcg_gen_pick_h_i64_i32
tcg_gen_extend_s_i32_i64
tcg_gen_extend_0_i32_i64

?

Any idea, please come up...?

Yours,
Aleksandar


> thanks
> -- PMM


Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B0BC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:33:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B91920828
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="JltHfI1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B91920828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i31op-0001EL-Cs
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 13:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amarkovic@wavecomp.com>) id 1i31nU-0000is-MZ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 13:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1i31nS-0008L6-BP
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 13:31:52 -0400
Received: from mail-eopbgr780121.outbound.protection.outlook.com
 ([40.107.78.121]:22752 helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1i31nR-0008KU-W8; Wed, 28 Aug 2019 13:31:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHUijO/H3Gqt2PNp4h4YE9HR07XJvabvu4m2JigY+GJokYgp8nrydnd8gjp/TvedrtlJtAyBjWp/KFJ//pTbBkXsGYG3mDjZJxEnhWo7SJ2ybippXRCO1xBzPV7yEl0M/1aF4kMHHrpK/e6IaC2mmcCgxMZaGOUWC05ogjWT9CnVtR/c7Fct8CvxFXHQnG9DhFPcEVvvrf4BVp0rcyrwDgnBN87MlNpbGgBCqQQT4/GskIHfCLc+fiTVGiFzXOUgd93gdX/bA+pM/uYigsGwQLDrU/SYMUxsEqWf22dLNQrnQmDLVjNXMjPYs0SSdsdxALFqjUTy3lW2rW1qY/B6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGe5bY26h2xMdkAjNkuCOBptT59g48yHS0UFQK3o464=;
 b=FNr/o99CjoXnJkOPF9O7bKnhhY1FnlCLwCNKs7nN9omRfIe3SC/AWKEtXM+HJeotnANEMAFOgTehIoSheOsuak/0f+SxZbsz5Ng2VTHn0tPE2kpPBj+6b/tQiNrZBqE955pciPWDHfij+RQahI91BQadBNNfh7cWCzvJ6hur0IU2HFtu6LPfWAh8gV7QXgfUv72ZxjPx75uYiPH9XdH+VA/HqGLI6WAr1ChaePatKA2Sbde32K5DoawvrGrZOmjjcjwfXKE4F8oSm3tSjq+1HGnqDCOCAG3wEkR+wiMkgkT4tzOPmVCobNXvS2m/iGqJkBUd8YgapTt0OjA7gqXOig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGe5bY26h2xMdkAjNkuCOBptT59g48yHS0UFQK3o464=;
 b=JltHfI1ThXfz2fMH1Fx9orckps3jLkTuQYxVgHF3PiSRZRB930qvty0tfYRsfapBpjo38tSnp7//GaNrWvGzqfW5vYDbB+ET9ziSt0EhO0koOCw94sI+E/yep9oM8xUuQ1mPT4+maZSGGJR+cLSvXg/HEe672zGJ9B5b+5YheFg=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1746.namprd22.prod.outlook.com (10.161.152.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 17:31:46 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::709c:ea73:df85:b135]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::709c:ea73:df85:b135%12]) with mapi id 15.20.2199.021; Wed, 28 Aug
 2019 17:31:45 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Laurent Vivier <laurent@vivier.eu>, Josh Kunz <jkz@google.com>, Aleksandar
 Markovic <aleksandar.markovic@rt-rk.com>, "milos.stojanovic@rt-rk.com"
 <milos.stojanovic@rt-rk.com>, Petar Jovanovic <pjovanovic@wavecomp.com>
Thread-Topic: [EXTERNAL]Re: [Qemu-devel] patch to swap SIGRTMIN + 1 and
 SIGRTMAX - 1
Thread-Index: AQHVWALJmqy0WHd9B0ClDA0tDggZvacN9W8AgAJWNwCAAJA7XA==
Date: Wed, 28 Aug 2019 17:31:45 +0000
Message-ID: <BN6PR2201MB125123754144B7214725BF05C6A30@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <CADgy-2vznasvwaUwNSi96Sy=ucPC=-3e=O9irqc5DSpV_uhWUg@mail.gmail.com>
 <abf5f3b6-7c05-a85b-051f-9905b8f50041@vivier.eu>
 <CADgy-2va2xVmO_a1gDwg+zkpNcLJTW5D1j=2kk1TnRMxyPaLMg@mail.gmail.com>,
 <6542ac57-6b06-1337-825b-dd1187accd15@vivier.eu>
In-Reply-To: <6542ac57-6b06-1337-825b-dd1187accd15@vivier.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92cb7ad9-89b4-4315-a244-08d72bdd9989
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1746; 
x-ms-traffictypediagnostic: BN6PR2201MB1746:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR2201MB1746C1FA117BDE3D3D5AAE29C6A30@BN6PR2201MB1746.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(136003)(346002)(366004)(376002)(396003)(53754006)(199004)(189003)(305945005)(6246003)(25786009)(53546011)(55236004)(102836004)(6506007)(186003)(26005)(6436002)(229853002)(6306002)(4326008)(55016002)(476003)(446003)(486006)(53936002)(9686003)(66946007)(66476007)(91956017)(76116006)(66556008)(66446008)(64756008)(2501003)(11346002)(2906002)(33656002)(256004)(14444005)(5660300002)(76176011)(7696005)(71190400001)(99286004)(3846002)(6116002)(71200400001)(6636002)(52536014)(7736002)(8676002)(81156014)(81166006)(966005)(316002)(66574012)(8936002)(86362001)(478600001)(110136005)(7416002)(66066001)(74316002)(14454004)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1746;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M1wxF7ErtCDgpdzAHCuedk92uQ8kPqtreBu0rR5W/4QwvnToKsP7OpiP46EMH0y2Plf13U5RoLP6UR++Sjz3Oeps9DeEXt9hNdL+vJo9dxtxAHGjIucJy5ESDt983ZwqfOMdVjdghCHq9DNylzHSsZPg2/s68TRWNQugAQrYBfEjLVQkrSXQFfpUffNGUnYJ7XSVc1kUyBCesFB1iDHwGeQgLNR8U0ce4DMlf15RpXgXP74FyTpUEU2CzgN67X/KPD7Zr28uQ+5TLiuaEhJ+1g6KJNIdrPxgx140b4vFZO20qrWGKqYEeMLWQRx65zLHmHUYCIZTiSsTyPLeXZkFnVuLqacEaIkIpTBnscQPsGQAYHt2lncmiXZAYKH+kvj1v5XqNYJ+74h71wZf+MskU9gOj9xZfZ48dJH4jbI6A/s=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cb7ad9-89b4-4315-a244-08d72bdd9989
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 17:31:45.8106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /OjRKvk5rVTNJN5MujNu43N19ASZeagY4h2DRbgnaxWT445vEDFMQPf5ReTfOItWA5JY4TPYtlH7I4B+3F3QXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1746
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.121
Subject: Re: [Qemu-devel] [EXTERNAL]Re: patch to swap SIGRTMIN + 1 and
 SIGRTMAX - 1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "marlies.ruck@gmail.com" <marlies.ruck@gmail.com>,
 Shu-Chun Weng <scw@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Laurent Vivier <laurent@vivier.eu>=0A=
> Sent: Wednesday, August 28, 2019 10:51 AM=0A=
> To: Josh Kunz; Aleksandar Markovic; milos.stojanovic@rt-rk.com=0A=
> Cc: marlies.ruck@gmail.com; qemu-devel@nongnu.org; riku.voipio@iki.fi; > =
qemu-trivial@nongnu.org; Peter Maydell; Shu-Chun Weng; Aleksandar Markovic=
=0A=
> Subject: [EXTERNAL]Re: [Qemu-devel] patch to swap SIGRTMIN + 1 and SIGRTM=
AX - 1=0A=
> =0A=
> Le 26/08/2019 =E0 23:10, Josh Kunz a =E9crit :=0A=
> > On Wed, Aug 21, 2019 at 2:28 AM Laurent Vivier <laurent@vivier.eu=0A=
> > <mailto:laurent@vivier.eu>> wrote:=0A=
> >=0A=
> >     Le 19/08/2019 =E0 23:46, Josh Kunz via Qemu-devel a =E9crit :=0A=
> >     > Hi all,=0A=
> >     >=0A=
> >     > I have also experienced issues with SIGRTMIN + 1, and am interest=
ed in=0A=
> >     > moving this patch forwards. Anything I can do here to help? Would=
 the=0A=
> >     > maintainers prefer myself or Marli re-submit the patch?=0A=
> >     >=0A=
> >     > The Go issue here seems particularly sticky. Even if we update th=
e Go=0A=
> >     > runtime, users may try and run older binaries built with older=0A=
> >     versions of=0A=
> >     > Go for quite some time (months? years?). Would it be better to=0A=
> >     hide this=0A=
> >     > behind some kind of build-time flag=0A=
> >     (`--enable-sigrtmin-plus-one-proxy` or=0A=
> >     > something), so that some users can opt-in, but older binaries=0A=
> >     still work as=0A=
> >     > expected?=0A=
> >     >=0A=
> >     > Also, here is a link to the original thread this message is in=0A=
> >     reply to=0A=
> >     > in-case my mail-client doesn't set up the reply properly:=0A=
> >     > https://lists.nongnu.org/archive/html/qemu-devel/2019-07/msg01303=
.html=0A=
> >=0A=
> >     The problem here is we break something to fix something else.=0A=
> >=0A=
> >     I'm wondering if the series from Aleksandar Markovic, "linux-user:=
=0A=
> >     Support signal passing for targets having more signals than host" [=
1]=0A=
> >     can fix the problem in a better way?=0A=
> >=0A=
> >=0A=
> > That patch[1] (which I'll refer to as the MUX patch to avoid confusion)=
=0A=
> > does not directly fix the issue addressed by this patch (re-wiring=0A=
> > SIGRTMIN+1), but since it basically implements generic signal=0A=
> > multiplexing, it could be re-worked to address this case as well. The=
=0A=
> > way it handles `si_code` spooks me a little bit. It could easily be=0A=
> > broken by a kernel version change, and such a breakage could be hard to=
=0A=
> > detect or lead to surprising results. Other than that, it looks like a=
=0A=
> > reasonable implementation.=0A=
> >=0A=
> > That said, overall, fixing the SIGRTMIN+1 issue using a more-generic=0A=
> > signal-multiplexing mechanism doesn't seem *that* much better to me. It=
=0A=
> > adds a lot of complexity, and only saves a single signal (assuming glib=
c=0A=
> > doesn't add more reserved signals). The "big win" is additional=0A=
> > emulation features, like those introduced in MUX patch (being able to=
=0A=
> > utilize signals outside of the host range). If having those features in=
=0A=
> > QEMU warrants the additional complexity, then re-working this patch=0A=
> > on-top of that infrastructure seems like a good idea.=0A=
> >=0A=
> > If the maintainers want to go down that route, then I would be happy to=
=0A=
> > re-work this patch utilizing the infrastructure from the MUX patch.=0A=
> > Unfortunately it will require non-trivial changes, so it may be best to=
=0A=
> > wait until that patch is merged. I could also provide a patch "on top=
=0A=
> > of" the MUX patch, if that's desired/more convenient.=0A=
> >=0A=
> > Just one last note, if you do decide to merge the MUX patch, then it=0A=
> > would be best to use SIGRTMAX (instead of SIGRTMAX-1) as the=0A=
> > multiplexing signal if possible, to avoid breaking go binaries.=0A=
> >=0A=
> =0A=
> Personally, I prefer a solution that breaks nothing.=0A=
> =0A=
> Aleksandar, Milos,=0A=
> =0A=
> do you have an updated version of you series "Support signal passing for=
=0A=
> targets having more signals than host"?=0A=
> =0A=
=0A=
Milos is unfortunetely working on an entirely different project now, and ca=
n't spare enough time to finish the series. I am also busy with other issue=
s, even though I would like very much this or equivalent solution to be int=
egrated. Alternatively, someone in the team may have time later this year, =
but I do not know that yet  - perhaps somebody else (Josh) can take over th=
e series?=0A=
=0A=
Sincerely,=0A=
Aleksandar=0A=
=0A=
=0A=
> Thanks,=0A=
> Laurent=0A=
> =


Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06B3C43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:16:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB5320708
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="QDej03Uw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB5320708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQSxw-0007jD-I2
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 06:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1kQSwc-00079Y-L3
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:14:42 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65]:23571)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1kQSwX-0002xx-DV
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:14:41 -0400
IronPort-SDR: UcxClQAgNzW4DaJ9jrBXTnkPgpHShUL1XHl1WUsmzWaMrkF/n9f+pdPGQvX+htZ1Np/qFFtEFp
 ArIBdmqh5RogTHdTBxJCYo/1lHEl/IPMbM3cD9MmIplfvOjdH0a8/YAWUq4f7LiBjRUhLC1/bu
 MSMWPfBfhlvM2D+Cq8u3d1jFBlW4Wg1d+RY2BNberSUTpSslXippJLOXMzZmvJGEjMHAPZDeUv
 vr/ah3iqmL7mnAWPsNn2bhSt0ee45U48LTIUZ2BGgc1zi3Z/vQ+9dw2M7T51Shaa9D23lKpiv8
 kJQ=
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="19273707"
X-IronPort-AV: E=Sophos;i="5.77,350,1596466800"; d="scan'208";a="19273707"
Received: from mail-ty1jpn01lp2056.outbound.protection.outlook.com (HELO
 JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.56])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2020 19:14:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtKA8BfCPfhldO41yn5jdeKSLEnc6otrvqlSg/tj2YrREXJGl6WkuSDeudGFRbjg0VaZOW1e+ywYSKVH3/oNTs8L9NmpIK+zZI6F44Ltt+LCS6uy/kPrHkrbArNrBYeyWZf3ZG9ecGOBDzY++6rQ6YKgbrlKRd3hbPcopIk4EWUIOylWdnfxyNK7QZYvqqs7TKZgXV8uXNJE0+YUBKPdeY1pUBBQt0BTVeu4o9UQIxDat89WixoEuSCxbQQwcx7jUNat8tOd2qAkvlMkZGISsbvh7FLd1qDBQ8Kl4KPY2MIzO/E9rGvKGyEd8RmPm7KOto7cEJakAvGxiu6z0qRJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVltWtvuo6RKlT48rul8AcVCzWmO7VnbCvTuRpipyyM=;
 b=Og7UhmnXtSqt6ckoCz7rpSVKgHyJPvDZWVsB6H4VCTlJo+2ZMbZ5Y17ugVtusAHvNAwg9F/MebIUVmo4FpiE3Phb8QrrM/amRS8LBiI3ilqHrWQXI67SXxm8JR0jRe+RYboDA71XGdLlKFYA95L21Rb1gly4FhOspFkZTmj6W/JlfitU41rQ1DDmenjATaV4GCT4ozvllKVUJ6Hzt3XywMyC8HUL5HY4+WFcUeABqM5n8jE9gBGLTsZbGD19JhM1OGZ4ORSip5VAQ6+hW5qKAGCQVE78tIsCif/wGwYsvgW/IbdppkHVNx9dqbmm0z+wW0a7bdU/Ivzw1+68UVg5gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVltWtvuo6RKlT48rul8AcVCzWmO7VnbCvTuRpipyyM=;
 b=QDej03UwDeEBOeg9gCu2HZOlbu3pf9nRFPgDKhvOTzIVmqKy5/oHjtmCx6i8xhX60qej+cQhgTFT9VLvu6aCvCSCmlvtb40K7LeF/MTyuoYYH2s4QY2ogdTTp8uwkSwb8y2I/SCVp6wyoHf18PgEXdr8bd+QN3pCC9UlJ6Q5FVc=
Received: from OSBPR01MB4582.jpnprd01.prod.outlook.com (2603:1096:604:74::21)
 by OSAPR01MB3412.jpnprd01.prod.outlook.com (2603:1096:604:5a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Thu, 8 Oct
 2020 10:14:23 +0000
Received: from OSBPR01MB4582.jpnprd01.prod.outlook.com
 ([fe80::922:4117:105f:bce]) by OSBPR01MB4582.jpnprd01.prod.outlook.com
 ([fe80::922:4117:105f:bce%4]) with mapi id 15.20.3455.024; Thu, 8 Oct 2020
 10:14:23 +0000
From: "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
To: "'Dr. David Alan Gilbert'" <dgilbert@redhat.com>
Subject: RE: [Virtio-fs] [PATCH] configure: add option for virtiofsd
Thread-Topic: [Virtio-fs] [PATCH] configure: add option for virtiofsd
Thread-Index: AQHWnIrb+Kne8hlQY0en7yQgBnyE6amMRIUAgADTW3CAAGE8gIAAA8KQ
Date: Thu, 8 Oct 2020 10:13:17 +0000
Deferred-Delivery: Thu, 8 Oct 2020 10:14:17 +0000
Message-ID: <OSBPR01MB458244F79B20419ABCB1758DE50B0@OSBPR01MB4582.jpnprd01.prod.outlook.com>
References: <20201007092913.1524199-1-misono.tomohiro@jp.fujitsu.com>
 <15796673-2daf-70a8-4b20-b861d4c22e62@redhat.com>
 <OSBPR01MB45820C38F613E3D38A565CCEE50B0@OSBPR01MB4582.jpnprd01.prod.outlook.com>
 <20201008095505.GA2962@work-vm>
In-Reply-To: <20201008095505.GA2962@work-vm>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckermailid: 1bc2969fc0d241859c6cd89aa4cf7806
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc73998d-28c0-489f-a9b0-08d86b72ee1d
x-ms-traffictypediagnostic: OSAPR01MB3412:
x-microsoft-antispam-prvs: <OSAPR01MB3412D49B0D8562C1F6E7251BE50B0@OSAPR01MB3412.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P/9Q4e4hwT+cmkTlgjTB7jMr+hjBGgeJm3LenfdpRI7x/Y1waJDl3UQ/MhbJQn448iaV3XxZ3McDfdDeAghKkNHm753EDeLVpX0NihsCGbsAd7zAOrZAMxPUVlaAQaH9DAF6xVO/+lX7yRFlFRVhPSKeLlRXpRThO2don5HBnTONT+vTPcg+B+0NFZ7l587Q3DNAOlyeqxzSvhrUffH+X5Y2sUp8hvjNDqH8BNlLl6xdhTMOAZdNdVOPB/j3BYtFHnnXJN2XEEttc+b2M5+tKXcG/RqMomVuVdGLKT2e0k04fmAE/IcimT+vTHQ2/3Al8h5BkzAqBuzFzm4ipIH8FZOixVFhwxz8vaEr6vqM8/VHJXJ8CUYxiA8u+B89175biAJbeO/Q0z4o2XmD/pD/HTp6ctwz/vOv/cCvPXXWrq4G7dxJiFk9iuFKQ4dVTr0G+KdTRu/W2jMfOJDW9VRUeA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSBPR01MB4582.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(8676002)(83080400001)(26005)(6916009)(478600001)(966005)(7696005)(5660300002)(52536014)(4326008)(55016002)(6506007)(9686003)(2906002)(64756008)(54906003)(66446008)(66476007)(66556008)(186003)(316002)(33656002)(66946007)(85182001)(8936002)(86362001)(76116006)(83380400001)(6666004)(71200400001)(777600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Z52GbQ7wO01KaUoAf5hNr6dIEaGkMeSUE6Dyj107PwzXZeydAik+bA2rPUHv3pKj3oIntAJkgBkbU1AsMrm1mhIK+G5RoD16rnJtRu7XiN1w/+3BZ/hE+7dQweDpY2Q0X3J+RcxN0JM2P0yrRg1TR6pOkqLnXq0FeMGJXz2v2RGzHPPw/ZSXMPIYvKXwqYR10oQiXFed9LIBn2JlEbww4FiCw6KTpI5p78qv7xAdL/+ggz67ytc+skDwrS1OWwiU5OVFgcw8UyaIGgs+B+ftdrQK3utSm+pYeVMvfkJOS33Oisw3W2qs0N3E1gofEL6GPFUGoaic00KXvyRyGEWPypNe7lTL/ue7cFHJKuvDaZtPoXBjP+LO8x0mCLhPeNgh3QcF0Aaw5HM6Cn4me92PN50NoGZM0CfI6uq1q+i7wTCPkmuMqwI7qysgjvcUda/CUwWBEa06vnbv1NzET7NeF3uK9mH/wEtXosMvmUngW5i9yRyIfVC+CdcXrmNjApFEoWFc6vARRJKCPHUY8FWA0S5tHz4g/HNfATvzeP6tSDaQY4aow7SD8z9SsPErqkmnoBzoBu5Qgx3MwfOV0t//V+0FWQ5wp76oDTe/0Jvw8q5YaoxQODPgo0ONj021SUBvSETtV5o92AyVUOmIDdx6Jw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4582.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc73998d-28c0-489f-a9b0-08d86b72ee1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2020 10:14:23.7260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dzy89lChTd9z4vQrrlt9t8NpOl4hQSQXvt5KQJXtPoFkkHdAM4+ZuQ+LKueIVjUAEoI9/QW/E3ygFXhhuSlPYhd6UeLsf06ABAErdqdykQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3412
Received-SPF: pass client-ip=216.71.158.65;
 envelope-from=misono.tomohiro@fujitsu.com; helo=esa20.fujitsucc.c3s2.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 05:18:27
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Cc: "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
 'Paolo Bonzini' <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

...
> > BTW, while testing the updated patch, I noticed current master branch (=
as of 10/08) fails to execute virtiofsd.
> > backtrace from coredump shows:
> > #0  get_relocated_path (dir=3D0x560f4d2f2ef0
> > "/usr/local/var/run/virtiofsd") at ../util/cutils.c:924
> > #1  0x0000560f4baab6da in qemu_get_local_state_pathname
> (relative_pathname=3Drelative_pathname@entry=3D0x560f4bac6cf1 "run/virtio=
fsd")
> >     at ../util/oslib-posix.c:345
> > #2  0x0000560f4baa1b09 in fv_socket_lock (se=3D0x560f4d2f2f20) at
> > ../tools/virtiofsd/fuse_virtio.c:865
> > #3  fv_create_listen_socket (se=3D0x560f4d2f2f20) at
> > ../tools/virtiofsd/fuse_virtio.c:906
> > #4  virtio_session_mount (se=3D0x560f4d2f2f20) at
> > ../tools/virtiofsd/fuse_virtio.c:968
> > #5  0x0000560f4ba99725 in main (argc=3D<optimized out>, argv=3D<optimiz=
ed
> > out>) at ../tools/virtiofsd/passthrough_ll.c:2947
> >
> > So, this is related to:
> > https://github.com/qemu/qemu/commit/f4f5ed2cbde65acaa1bd88d00cc23fa8bf
> > 6b5ed9#diff-ae9b732998587b609c0854bae40b2fe6R924
> >
> > Adding  "qemu_init_exec_dir(argv[0]);" in virtiofs's main() seems
> > solve the problem, but is it correct fix?
>=20
> Yes, I've already posted the fix for that,
>    https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg01852.html
>=20

Thanks, then test is ok and I will send v2.

Regards,
Misono

> Dave
>=20
> > Regards,
> > Misono
> >
> > >
> > > Thanks,
> > >
> > > Paolo
> > >
> > > > -have_virtiofsd =3D (have_system and
> > > > -    have_tools and
> > > > -    'CONFIG_LINUX' in config_host and
> > > > -    'CONFIG_SECCOMP' in config_host and
> > > > -    'CONFIG_LIBCAP_NG' in config_host and
> > > > -    'CONFIG_VHOST_USER' in config_host)
> > > > -
> > > > -if have_virtiofsd
> > > > +if 'CONFIG_VIRTIOFSD' in config_host
> > > >    subdir('virtiofsd')
> > > >  endif
> > > >
> >
> >
> > _______________________________________________
> > Virtio-fs mailing list
> > Virtio-fs@redhat.com
> > https://www.redhat.com/mailman/listinfo/virtio-fs
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3412AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C8FE2067C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="IjeH+3oq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8FE2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3Ms-00017h-Ar
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:21:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1kc3LW-0000S8-L0
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:20:20 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:47898)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1kc3LS-0002OP-E4
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:20:18 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0A99DFg2008646; Mon, 9 Nov 2020 01:20:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=ZwA53aWYw3s5M+BnuUl/bOXAWAdiZhZRSjeqaAX50PE=;
 b=IjeH+3oqnhPH5s3Gzcd5/Ph1xzxD3TeVh2vZ78pJSsxc8UKv91JkwmEJXHNslhHTOsOQ
 Zz1O73DuAjP6orsu14wEkxVSQyaWFCistYh8X/9baA10VxbKxM5Dk/bSDXwuDBxCVhAm
 rnB+rDNxVhZHmRd9c14FCfMacjaRN/Yuw6SMRDWaHeQ746zzwTCCwPtEfj5wmv6vpbS1
 Xhc6c/UIayA99+dKHtUKKHw/iHrQr3HYf7WKYWT5LeqVX/GY3z7M98FUXQxkGsNbGy7F
 Ex+i+2w/QEDyUOdLEforuSuK3MQV3If8xGvqxBbDpoXSowckoZz8NuVop2nFbxgI1E35 mg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by mx0a-002c1b01.pphosted.com with ESMTP id 34nuhkax57-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2020 01:20:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+94PeDjmiMqbQn7Kez9dtRX1p45E101xGo0bq0dBEogtr+34+ntMo+LfFNEexpLmulL+Oo+5zNjTSvXECSsNkivBE/atOs8ODnsJl13UhXtr1BwEXgNI9EDDe4pBoowRQzDB4Cz+7elzJBSXiYjg2C872scK6uPZUP1coXU8/PgcImhO+hSfzzMMFjvZlRdBD/ptAQyMhoLRr5VE7IZhK/0yxeWna4duvJVhrUtm7buZS2d5zaLdu8gxll+aUj2wFLrsUAHL+orJXFfx3M1oYXgKjVRQfuWB8gSEgQGzcokSMdf+fQpWGeVAJIps1smh4A2KIy28y2ErnkZWzJV3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwA53aWYw3s5M+BnuUl/bOXAWAdiZhZRSjeqaAX50PE=;
 b=BfJC5D1RN72YNMusNaz2MP8qRq8UEAISfhri/cSuZMoZDd22vU/BXVKDdjX/f5BjraN3u9uY+jL672xG43i8LO1yvZP2h/kQ19qqCOWXeTEbMBhVbI12vRcd8uqB3Gm1t9wRQg+DrrT2vY80I1NQtdgwxkydp3NHf4lLm8f65t9UOL4qeffSh3g5ENmljytRotj93zSVxSC/ouYMAJXf87cvlQ1rWiOvE4jsHPlDZJtcvQxZrRTiI00f/uSivcLX/GgMkWTerwof+JOON6Y+Vz7eDQYmIWMHRe8ssIh5TnUClEiCIEhHBwl8BdQKIOLuYO4bauHdpKKYO+ppnIfMGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from SN1PR02MB3725.namprd02.prod.outlook.com (2603:10b6:802:32::10)
 by SA0PR02MB7178.namprd02.prod.outlook.com (2603:10b6:806:ed::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 09:20:02 +0000
Received: from SN1PR02MB3725.namprd02.prod.outlook.com
 ([fe80::2849:50fb:b1b2:cc24]) by SN1PR02MB3725.namprd02.prod.outlook.com
 ([fe80::2849:50fb:b1b2:cc24%3]) with mapi id 15.20.3541.024; Mon, 9 Nov 2020
 09:20:02 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>, John Levon
 <levon@movementarian.org>
Subject: RE: [PATCH v5] introduce vfio-user protocol specification
Thread-Topic: [PATCH v5] introduce vfio-user protocol specification
Thread-Index: AQHWrUTVjUvP5pU8VEG/kGG39PR4hqmtNlfQgAMsMQCABFmqAIAK26cA
Date: Mon, 9 Nov 2020 09:20:01 +0000
Message-ID: <SN1PR02MB3725ACC5BF3C3FA339C22C3A8BEA0@SN1PR02MB3725.namprd02.prod.outlook.com>
References: <1594984851-59327-1-git-send-email-thanos.makatos@nutanix.com>
 <20201028161005.115810-1-thanos.makatos@nutanix.com>
 <SN1PR02MB3725C85DCD4BF652FF6FBB8D8B170@SN1PR02MB3725.namprd02.prod.outlook.com>
 <20201030170306.GA2544852@li1368-133.members.linode.com>
 <MW2PR02MB3723D387485067C65D31D2328B100@MW2PR02MB3723.namprd02.prod.outlook.com>
In-Reply-To: <MW2PR02MB3723D387485067C65D31D2328B100@MW2PR02MB3723.namprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nutanix.com; dkim=none (message not signed)
 header.d=none;nutanix.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [78.149.9.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04442f64-6ba8-416e-4c2b-08d88490a33a
x-ms-traffictypediagnostic: SA0PR02MB7178:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR02MB7178F6A3C8D501B26CB3B2978BEA0@SA0PR02MB7178.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7gvdeqkfc5Fhm5IURQkbF3u018lvJRMQAezO4YUhIwb8BZsGm58CY3fYNzHAHU1bAWe4LkJ2ttCdBBROmr24jkyzDGobKZ/v37aqxlyCn+S0qjk99UcWrnBbzzyy8CaX8UWvxM9Ndy0cWgDjZFgHPN42FCipPbwGg+Rk4+hq6lNSx0Xae8/E2jvftbc6Pf3ZeQPee4Zd9SmtFi81peggofEq9BPQXYKZodVFCMrvlK59/Hxz9WmbLtdUM7azVga4w3Jn3o4UluLu8Jfv9hJ8bqMqb3QHe7/fa0xQqmbnOaUd9tD920T/DFO1pPpgSwiQigP5FOJH8kDrbpAPV0gw0A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR02MB3725.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(346002)(366004)(39860400002)(376002)(396003)(33656002)(71200400001)(83380400001)(44832011)(6506007)(26005)(186003)(55236004)(7696005)(8676002)(8936002)(4326008)(478600001)(66946007)(64756008)(2906002)(66476007)(86362001)(5660300002)(55016002)(9686003)(316002)(66556008)(110136005)(4744005)(76116006)(66446008)(52536014)(54906003)(7416002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 32DNeWyIAL5kc53JS0bURfiwnYIfiieXkzxIVHEOU68VcVDdOwQ1gdQiPVmcXw3T9Sx5XsS82bag85NtCevD4yoEzUZAlYdfB+Gty5YPXaXtKPT7KC1T7KyioJ5Uf4MNcdNBkaBY0pj8PBG4wDlvsN22E9pE/raUrjqaE2EaAPoZnANV+CY+pIOyag55lyZMnwBLpc+Nmc7vifLcfQMo3vIqtHym4WeokJdlOk7WbqOOTh28H543YA2TPiq5X3wcpQRReJa68v7FRgt3fNWBC0klQzGSH4V3a1u6aUSqt4LX/SZrOEIHOj3R5cXXDsG0Awvirlp3P/agYtgcDaHbuZJdwJWBHIgSvHkBUDdqvn2WbYE1b/vLwx1PPfVz5w8n5TvTJVnh0N/d9Zvc8Jaa/Iuax+uykjVDjzoTSpyEET+5K2YvckgdxFShSBgV2+SyNIfHAPiigNIwYI2/Ims1N7zoBuPPBhXWPvNuxpic6QC3LD4BqBVsAn7HNT6Cawu7s28h/v4MhXex72vDEwnJTaUswZ+wkYB2r3PMrbdDzd94+sk18MZeysDDKvrsYk24DWCTS82zQeakiswUYxK+u3jrPEM1REHim7nP9d9ChzK9jRFS5jR9a/WDUmSeZUOZAEgsFb10kiJ9fKJCs70auw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR02MB3725.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04442f64-6ba8-416e-4c2b-08d88490a33a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 09:20:01.9420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xcnuvFW6XltjvqnTFXy38ZEHOTrdUH4hM2UZWe1Kr+oVB1GPSiKEinKKSk8Yy9DsvT1V5jz4iVKCZMOhqz9A8Q94DfV6IkboNI6StsLUGE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7178
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-09_02:2020-11-05,
 2020-11-09 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 04:20:10
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "tomassetti.andrea@gmail.com" <tomassetti.andrea@gmail.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "james.r.harris@intel.com" <james.r.harris@intel.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 "yuvalkashtan@gmail.com" <yuvalkashtan@gmail.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "Kanth.Ghatraju@oracle.com" <Kanth.Ghatraju@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "tina.zhang@intel.com" <tina.zhang@intel.com>,
 "ismael@linux.com" <ismael@linux.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 "xiuchun.lu@intel.com" <xiuchun.lu@intel.com>,
 =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "changpeng.liu@intel.com" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > >   * *Error* in a reply message indicates the command being
> acknowledged
> > had
> > >     an error. In this case, the *Error* field will be valid.
> > >
> > > * *Error* in a reply message is a UNIX errno value. It is reserved in=
 a
> > command message.
> >
> > I'm not quite following why we need a bit flag and an error field. Do y=
ou
> > anticipate a failure, but with errno=3D=3D0?
>=20
> Indeed, the Error bit seems redundant. John, is there a reason why we nee=
d
> the
> error bit?

I haven't heard back from John yet; however I think it makes sense to maint=
ain
an error bit and not necessarily require errno to be set, since there can b=
e
errors that no errno value makes sense. I'll update the spec.


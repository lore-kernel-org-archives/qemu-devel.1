Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F8FC2D0C1
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:31:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E422464E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TQBy79Mn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E422464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idEdp-0000ld-HZ
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:31:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1idEMm-0007n7-GW
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:14:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1idEMk-0007Me-Da
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:13:56 -0500
Received: from mail-eopbgr150125.outbound.protection.outlook.com
 ([40.107.15.125]:33713 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1idEMW-0007BY-G9; Fri, 06 Dec 2019 09:13:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l46v3tFl2ZGiaVouhSawdBpXhYcROWo020wu4lt52dMOR22LQceAZ0e51BjZyTteHRzEsGFUPeoogH9ns/0IkEGhNW+Tz2ojDLKkLMe6ImlMGWTmFmeq6NBTsLbowh4XQbvO+E6W6+xQpE/ZPlLb4din9+dKG4/eeI8XvBbYBzhck886ugmZOBZFsvxMQELsw2XtIfe5MXIej/hQ7njjFw3JjwCfydXUEu0a/UPFb5Qu6slEDo/UJMEaQJbSd1o5AUdHsxq6sGxCsHQmYtLHXg3qgt0jL0Fy8awsNEClsSR/r92AJG7BoeFXhk8idF4VsgHmu3pzcTGmOV+5KTYFTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwHUEOv00eZJO4PrzLPVTQb9UFzLk75qo5T/wMk2rCo=;
 b=Nts6CVrNVs+sou5Uzm1UVOLpD/qMD0u6Cob5tcYaZAoXXM8f/s/Yjw0VtQNZ4KEd2jRQvdIOQlKhwNbP9cknv8SjVqpPobDTB08CYttSFGofoBfgObo2OdkGB/7CLLFfY/cMmOi1mHY6OulFAb6FEtEmFMhoO7VIJMxHo8HWQeDdAswXQ7ZHPW8zYOqV0OmaZURD/mljS54zgSGoSl6WK7MsmWngYTEQwTN++4s487iv+2Wjc+JPS48DXCnsPSyHS8RBlaXZ7asr35djnZ1IT5XBBr/2Pz/ISYDH/E+G1M3MeDjb1u2Pxnzxjqwwv3GQx02ey3WjTZsDvB/1g0x8Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwHUEOv00eZJO4PrzLPVTQb9UFzLk75qo5T/wMk2rCo=;
 b=TQBy79MnNl4JX0dd0yQ4UINxJD41BQaX14+bN2J0f8qiYTvdV+vmKRNbEFhD5rC9ITfqa0OskE3u0d0G716oP34O2d3hQFyEhSbPzFocQEzkRqduu/s6risYsVPnuAwKmUPuhdgEJu1qbZCrIoDxWhjhPutGl88lYH3J+2JitKo=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3480.eurprd08.prod.outlook.com (20.177.113.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Fri, 6 Dec 2019 10:28:09 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 10:28:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v7 07/21] ppc: well form kvmppc_hint_smt_possible error
 hint helper
Thread-Topic: [PATCH v7 07/21] ppc: well form kvmppc_hint_smt_possible error
 hint helper
Thread-Index: AQHVq3+O4eI1HXM8UUe94Hg8jUSVr6esOdiAgACu24A=
Date: Fri, 6 Dec 2019 10:28:09 +0000
Message-ID: <e8dd7486-6cae-c48e-3212-58cf8669da37@virtuozzo.com>
References: <20191205152019.8454-1-vsementsov@virtuozzo.com>
 <20191205152019.8454-8-vsementsov@virtuozzo.com>
 <20191206000217.GG5031@umbus.fritz.box>
In-Reply-To: <20191206000217.GG5031@umbus.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0005.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::15) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191206132807054
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec645d09-4cc4-4266-4995-08d77a36fd34
x-ms-traffictypediagnostic: AM6PR08MB3480:
x-microsoft-antispam-prvs: <AM6PR08MB3480AAF32AFCED7112848741C15F0@AM6PR08MB3480.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39850400004)(54534003)(199004)(189003)(54906003)(6486002)(14454004)(25786009)(478600001)(2616005)(71190400001)(11346002)(316002)(186003)(102836004)(6512007)(5660300002)(99286004)(26005)(52116002)(6506007)(31686004)(2906002)(81156014)(305945005)(81166006)(14444005)(229853002)(76176011)(6916009)(4326008)(66556008)(71200400001)(66946007)(8676002)(86362001)(8936002)(66446008)(64756008)(31696002)(66476007)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3480;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7+taDsy62W03E6kh9X+nL4gnqd8WVCfrBZGlFdnaxILUBzngbHQ+NqzNNe7UKwmHsOYpyTCFSeIFscMlWzPHU8Jx6Q2Ngq2OO6vnj9a7VBS7BZDFIXqUKR18vUKHghYh1ih4QJivDPw5Pe9QcCKLo7YmFof2om6nzo+zjQQ7BabRuBqJnH+7jh11R+1Oo+Tr13CsKnvP6Nxv7jcj0mCDA2lYWXWb1K9CGji1uOgPAx38Nc3+4+dwMDOWQiF+UxNoAujI6UKZZEThkWBHUy7VaNOHJqeYagICpw7jzsgGkE6BjilFboeLxJs/TZwiSnhJKWKwMiVxqqdk54pBPnax41h61TfdnJ6NPcm3W7RcXjpZ4Zgk5HvhkFaAtuGBlWFv21QTdbgRGacCd1W2Dn5WGpUwJBDRo4nY08eI6hj4Rv2Ut5TIN3P2qvIaRRMUXeGUZ8Mg6zwpDVDLSKXdI0BjyT0/IMXD4XmmRJSrmdCbd/Ted6NtSckiur2eBuNIPseY
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <414FFEC67E276A4DB3B2B624101771DF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec645d09-4cc4-4266-4995-08d77a36fd34
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 10:28:09.2428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ylfzIsH7b3aSJVJfod3nU8EKCWDQ7hrbwhCTV4CqMm07LuNMNp5wjly7DhXlBrOn0gOFQIoDlTYFFDXaJbHl3XgVjz9Iz8IEgvcObDTbECs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3480
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.125
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
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

06.12.2019 3:02, David Gibson wrote:
> On Thu, Dec 05, 2019 at 06:20:05PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
>> Make kvmppc_hint_smt_possible hint append helper well formed:
>> rename errp to errp_in, as it is IN-parameter here (which is unusual
>> for errp), rename function to be kvmppc_error_append_*_hint.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy
>> <vsementsov@virtuozzo.com>
>=20
> Apart from Greg's point about the changelog,
>=20
> Acked-by: David Gibson <david@gibson.dropbear.id.au>

Thanks! actually, v8 is out with fixed commit message

>=20
>> ---
>>   target/ppc/kvm_ppc.h | 4 ++--
>>   hw/ppc/spapr.c       | 2 +-
>>   target/ppc/kvm.c     | 2 +-
>>   3 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
>> index 98bd7d5da6..f22daabf51 100644
>> --- a/target/ppc/kvm_ppc.h
>> +++ b/target/ppc/kvm_ppc.h
>> @@ -28,7 +28,7 @@ void kvmppc_set_papr(PowerPCCPU *cpu);
>>   int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
>>   void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
>>   int kvmppc_smt_threads(void);
>> -void kvmppc_hint_smt_possible(Error **errp);
>> +void kvmppc_error_append_smt_possible_hint(Error *const *errp);
>>   int kvmppc_set_smt_threads(int smt);
>>   int kvmppc_clear_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
>>   int kvmppc_or_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
>> @@ -164,7 +164,7 @@ static inline int kvmppc_smt_threads(void)
>>       return 1;
>>   }
>>  =20
>> -static inline void kvmppc_hint_smt_possible(Error **errp)
>> +static inline void kvmppc_error_append_smt_possible_hint(Error *const *=
errp)
>>   {
>>       return;
>>   }
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index e076f6023c..1b87eb0ffd 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -2564,7 +2564,7 @@ static void spapr_set_vsmt_mode(SpaprMachineState =
*spapr, Error **errp)
>>                                         " requires the use of VSMT mode =
%d.\n",
>>                                         smp_threads, kvm_smt, spapr->vsm=
t);
>>                   }
>> -                kvmppc_hint_smt_possible(&local_err);
>> +                kvmppc_error_append_smt_possible_hint(&local_err);
>>                   goto out;
>>               }
>>           }
>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>> index c77f9848ec..27ea3ce535 100644
>> --- a/target/ppc/kvm.c
>> +++ b/target/ppc/kvm.c
>> @@ -2076,7 +2076,7 @@ int kvmppc_set_smt_threads(int smt)
>>       return ret;
>>   }
>>  =20
>> -void kvmppc_hint_smt_possible(Error **errp)
>> +void kvmppc_error_append_smt_possible_hint(Error *const *errp)
>>   {
>>       int i;
>>       GString *g;
>=20


--=20
Best regards,
Vladimir


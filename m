Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D335C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 09:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1D12070B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 09:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Qd2AP/rT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1D12070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibi5t-0003I9-4Q
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 04:34:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ibi4J-00025w-C8
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:32:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ibi4H-0006Ir-UL
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:32:35 -0500
Received: from mail-eopbgr130111.outbound.protection.outlook.com
 ([40.107.13.111]:43687 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ibi4D-0006Gd-4A; Mon, 02 Dec 2019 04:32:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYmaFx49rISWUPmaWa9GYs784CayQStmOKHZ96MPCDtxytXxMAqwMeXQeDWZSnz50o9GPHMJf2LZTD13cTUaZbrLbwNR85JHQwa01Vn4W6F0k6ezob7smEDri755MpTAS/xM0crWEizTvfTz8SrBUqRneUddt8seJOD2Rd60wsDionteAyOcA1uDkBFSx31KfI+QHWj/xb8qQjMBkn6jsq/hXl3bIm2g9i0dUEwnVa6lsm8kGpxD8xJuSLR2y14MSfcdnuZqM3cKOK/CDkRLuFosLmumFvHnfToMoAnh9lMythRTrJuMPeerLPSp9rhFBWR74RPbfY1TpQddVhj3bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtvqszLAvyC3JK6h+AThjE8qJhi1nyi/m9h2g7At70c=;
 b=Cj/kjXr5YEGEIP4Jh40PbN8rQZe+qMVYoVM0lORhjG6JSh+xL59PVUdprfVqL97+E4fA+0RFCKkRWLYkSkBjun7Om8YpK6bUBLYNdPawVy8X4tYlx5Ydwwp6yTjf+mw64ZvNUh1he4ngpebaBGuDiLH/ZsuuQh5ol7tCT1dXkYVD9U5PY723GU3BLwFaD688EsPB3TC3pp+oLaKacuk7RK+ZiYJEHyAh+bcSydHMFnArQLsBwfjfGN74ooBAikGi/6eY6raUmyoX/ha64+RNxjMfqv8N48WfLemm3weBKX0yYLiJqpkJDi4gVcS9Ua7nSNKfaxvF27RumEtowGh6ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtvqszLAvyC3JK6h+AThjE8qJhi1nyi/m9h2g7At70c=;
 b=Qd2AP/rTHpskVo6fufqQ7A1bI1Ezx7E1EI7TIR27ZV+nmJ36baoFuJezwsWBtShYdqgd8qGkxXJqqPndyx46hZxq8EoPLWFwXeKY+vgzhu3ABUYG2zZLnVT7pKElCcc335ctpqLP4lDhYxpeRv0prZ47wg5284ZZ1gIYqbdifJk=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4771.eurprd08.prod.outlook.com (10.255.97.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Mon, 2 Dec 2019 09:32:24 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 09:32:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v6] ppc: well form kvmppc_hint_smt_possible error hint
 helper
Thread-Topic: [PATCH v6] ppc: well form kvmppc_hint_smt_possible error hint
 helper
Thread-Index: AQHVpVbzYaXD3zDfU0OJp/JZN5cGD6emKNeAgABzRwA=
Date: Mon, 2 Dec 2019 09:32:24 +0000
Message-ID: <ac1a560b-5132-86e0-ac34-04c375724d32@virtuozzo.com>
References: <20191127191434.20945-1-vsementsov@virtuozzo.com>
 <20191202023947.GA37909@umbus.fritz.box>
In-Reply-To: <20191202023947.GA37909@umbus.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0079.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::23) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191202123222255
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d08248c-4e56-45b0-7c5c-08d7770a89b6
x-ms-traffictypediagnostic: AM6PR08MB4771:
x-microsoft-antispam-prvs: <AM6PR08MB47717757C176DBDAFCB68D2CC1430@AM6PR08MB4771.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(136003)(39840400004)(396003)(366004)(189003)(199004)(2906002)(66066001)(54906003)(2616005)(305945005)(7736002)(99286004)(14444005)(256004)(52116002)(14454004)(76176011)(386003)(6506007)(4326008)(8936002)(446003)(11346002)(71200400001)(71190400001)(36756003)(31696002)(86362001)(31686004)(25786009)(6306002)(6116002)(3846002)(6436002)(186003)(102836004)(26005)(6512007)(229853002)(316002)(6486002)(66556008)(64756008)(66946007)(66446008)(66476007)(5660300002)(478600001)(966005)(6916009)(81156014)(81166006)(6246003)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4771;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UBH+cWwit24EKGEF5JzqBoy5x1kxcCyS8XNVv59qZnaMgNLiQWbLJ5ghLhIGaANtHM/EzalGUh2UAF11cgQtuhjGNTN4pEsXx+tDOyP8fZJxMxU+wqw385q2pvAdnBUC8A5N6Yx8F/pZzbGhHrE+WhG6n8diDEbniOf7Wg/T/LX7LfaQNQnNKxltj9vaQbZ0lvbiHxFbFftCFh3i7VE6lU+K1ZGE93ooQeQacpyLnfK7J9tPzX9NNMlT03KnwG91AJQxf++bV5Vf9w09LNNBXz8Yn8b0t3tSmnrpgz9GhokhoupJl8SKOncbsCAcfe54SH03oFNOIUezSOdOH5Vr8LDcKlz8usts1OcMjdYnVHSXjQbn23mQu8wuodLVKaY13q7gQjlDmeZ/qIZEevfWMR8DtTSqZ1M2sK1LCPi6xIhNkfTrT2j17pA9zYQ2ilANuDjWti2BPoYNqHBN1cH58K88XknSvBvyWio8OvQssMY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <4C0609BAAE70DA43B8C7A1E66F5D34E6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d08248c-4e56-45b0-7c5c-08d7770a89b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 09:32:24.1320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oDWz+qWYXhx6acrxc3/+cowNPxMGefF04i0rp8YxGI6k66dCp2SfubuUOPYaUwfTWN8v9jFyvmEdp+n7ATvCiaSg4c+0VVPYz9HfoZH/F5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4771
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.111
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
Cc: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.12.2019 5:39, David Gibson wrote:
> On Wed, Nov 27, 2019 at 10:14:34PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
>> Make kvmppc_hint_smt_possible hint append helper well formed:
>> rename errp to errp_in, as it is IN-parameter here (which is unusual
>> for errp), rename function to be kvmppc_error_append_*_hint.
>=20
> I'm not entirely convinced by the errp_in name, since it's actually
> both an in and out parameter.  Nonetheless, I've applied this to
> ppc-for-5.0.

Markus doesn't like it too.

So, seems there would be v7, the current version is here:
git://repo.or.cz/qemu/armbru.git branch error-prep

Discussion is here:
https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg04633.html
and here:
https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg04636.html

Sorry, for sent v6 in separate :\


>=20
>=20
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>
>> v6: keep kvmppc_ function prefix
>>      add r-b by Marc-Andr=E9
>>
>>   target/ppc/kvm_ppc.h | 4 ++--
>>   hw/ppc/spapr.c       | 2 +-
>>   target/ppc/kvm.c     | 6 +++---
>>   3 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
>> index 98bd7d5da6..47b08a4030 100644
>> --- a/target/ppc/kvm_ppc.h
>> +++ b/target/ppc/kvm_ppc.h
>> @@ -28,7 +28,7 @@ void kvmppc_set_papr(PowerPCCPU *cpu);
>>   int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
>>   void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
>>   int kvmppc_smt_threads(void);
>> -void kvmppc_hint_smt_possible(Error **errp);
>> +void kvmppc_error_append_smt_possible_hint(Error **errp_in);
>>   int kvmppc_set_smt_threads(int smt);
>>   int kvmppc_clear_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
>>   int kvmppc_or_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
>> @@ -164,7 +164,7 @@ static inline int kvmppc_smt_threads(void)
>>       return 1;
>>   }
>>  =20
>> -static inline void kvmppc_hint_smt_possible(Error **errp)
>> +static inline void kvmppc_error_append_smt_possible_hint(Error **errp_i=
n)
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
>> index c77f9848ec..7406d18945 100644
>> --- a/target/ppc/kvm.c
>> +++ b/target/ppc/kvm.c
>> @@ -2076,7 +2076,7 @@ int kvmppc_set_smt_threads(int smt)
>>       return ret;
>>   }
>>  =20
>> -void kvmppc_hint_smt_possible(Error **errp)
>> +void kvmppc_error_append_smt_possible_hint(Error **errp_in)
>>   {
>>       int i;
>>       GString *g;
>> @@ -2091,10 +2091,10 @@ void kvmppc_hint_smt_possible(Error **errp)
>>               }
>>           }
>>           s =3D g_string_free(g, false);
>> -        error_append_hint(errp, "%s.\n", s);
>> +        error_append_hint(errp_in, "%s.\n", s);
>>           g_free(s);
>>       } else {
>> -        error_append_hint(errp,
>> +        error_append_hint(errp_in,
>>                             "This KVM seems to be too old to support VSM=
T.\n");
>>       }
>>   }
>=20


--=20
Best regards,
Vladimir


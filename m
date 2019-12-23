Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B83C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 12:02:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF2F420709
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 12:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="imXMhsyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2F420709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijMPf-0000Ra-Uq
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 07:02:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ijMNk-0008HI-Lp
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 07:00:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ijMNe-0006P0-5P
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 07:00:15 -0500
Received: from mail-eopbgr150134.outbound.protection.outlook.com
 ([40.107.15.134]:55877 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ijMNd-0006NF-Gm; Mon, 23 Dec 2019 07:00:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajlA5bQNB1+1L+vUlBmPsM+sAIPkccb7SsHJY8E+S0mn4uVyPO7l0vwoT1cSaFI1/fmR4OrkhXmCalfi5cgjRhYVh3c+8p85Ozt38HldwbwB9Q5J0JUMEajcAdT0mhshfVUPEfhc+yioKuuW6WK3fHut3Uao19HLjnbwCVwQwftGvUR86+leCD0qYkpLslXfJ/StSYonkL7CSva6ROEbAegLM2nM7+p+paK99PGrQLUvB8IFeTc4+dL7fD1bw/crnA4ygrSW4nrirzW+t1ToLpP+nX16axZxNWmklYmZ1NhliZj7f330pwkq2z7RZ3fSXXzRmSsgoTos2WeB+yIaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ll3cEC6nLRlI2RjQLBQPjyrwKdlGYvNoFG0NHUwPwIo=;
 b=nDGJGvYIYU5UwKb4aCefGNUoYSVz42YLoSj5ArRv4h7/H2TzmZmNfeTm2fOQTPqXp3U8QhmtDIuX6Dxvr4OiNhAcySqWzq7znYrMx6GTZGUrqZYtanfTAeYkAt7zJ7KvQiZgxcBzbkOr+aw8QWbCcZ+x5K9RL1FSf/gvmj/T3HKHny+fq4GY1zap2KcdPu3s3Xq20CXtLeV+tOEJh+eXdoY8GRPxrrxCyeCpVFzOVi5nv06B3NMhp4x/pwH9m+BcTSHdldUuZPRhoVFDy+SC0s7KspVFuBrWRJCDckzOS7G/QmIKRKwnd0vl6tYZohMbk/LomBMPd67xUdIz+0jhvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ll3cEC6nLRlI2RjQLBQPjyrwKdlGYvNoFG0NHUwPwIo=;
 b=imXMhsyvXAqqTQeuSAv/HRduHl4HFTcQbmlufXzMj6ngyhZI36GR20lAQQqbZmCpqqddAgXPj/rF1sncm47pyNFfxpqR+0eLsjypunqEyhLMZhjrVWGuyltA0VeuFbnPjZCQVIDvARIHw/ISXTCoMkYohz/BNFJzqzeIzllZ0T0=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3224.eurprd08.prod.outlook.com (52.135.164.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Mon, 23 Dec 2019 12:00:06 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 12:00:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH] iotests: fix usage -machine accel= together with -accel
 option
Thread-Topic: [PATCH] iotests: fix usage -machine accel= together with -accel
 option
Thread-Index: AQHVuWSx7SraNxXYAEmfR4xRvIHJ0afHZj4AgAA3/YA=
Date: Mon, 23 Dec 2019 12:00:05 +0000
Message-ID: <c0d54ec5-a535-c455-769c-0132e14f63bf@virtuozzo.com>
References: <20191223074329.21262-1-vsementsov@virtuozzo.com>
 <8900f0c8-19ce-2475-01c6-150394d516f0@redhat.com>
In-Reply-To: <8900f0c8-19ce-2475-01c6-150394d516f0@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::30) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191223150003357
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a70cb7b-2913-4d89-5d2c-08d7879fa661
x-ms-traffictypediagnostic: AM6PR08MB3224:
x-microsoft-antispam-prvs: <AM6PR08MB3224311F7BA203BD3F994DC9C12E0@AM6PR08MB3224.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0260457E99
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(366004)(136003)(346002)(376002)(396003)(189003)(199004)(186003)(4326008)(54906003)(110136005)(316002)(71200400001)(8676002)(81166006)(81156014)(478600001)(8936002)(6486002)(31686004)(6512007)(36756003)(53546011)(66556008)(64756008)(66446008)(2906002)(31696002)(6506007)(66476007)(66946007)(5660300002)(86362001)(26005)(52116002)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3224;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rPYKwGNx5iqGRWJJ5DeK4j9qEhT9nZq3JRPjbzI+V0qoXElnIJZfbehMFiyqi8w1hL/VqjYZDuL2rmQix7Hf6E9uuXmedmNWzUACDfeH1e7XS27rzRTAletwUhkaz7/nUhQ3dzf9htQpmKF/KCS+gsd0oeHg7d2kV80xLJXnuQgj2f8Pbr3Eauy7coEWflxBTF8VtphSjYlNDuaLWzrQBZxhk9wh61uUPTB6Y2iWKTbNa6Fr0hKjZCaqXqF/ToPoCva/JFGo0OD2GJwT/w53a4ZWSyHaihklPqhLJxsuMsdV7GpUj58/61rRiDFVBMfQndazmGZnH43l2C8vzHKkyliq0s9oHHufDHywkWyHQPVzjTcT95XuSiRiCjInuM8Qy7lc2j219lR1ytNP05roEk8UPW2SGHA/rXxPY1GZonnsbKVVGN6af9U/2rJxovGx
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <75D49E7FBD90084E98F48C690B9CABDD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a70cb7b-2913-4d89-5d2c-08d7879fa661
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2019 12:00:06.0241 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZSF/S56k2fMC4hKbRst/arxC5N+JOqK0e/0mEm9V3EPZ01SpAOPtedRfzf2oS9NpQ0sSr9q37OM5Ut/L7sKNwWFWThBgwNoC459aECfTafo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3224
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.134
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.12.2019 11:39, Paolo Bonzini wrote:
> On 23/12/19 08:43, Vladimir Sementsov-Ogievskiy wrote:
>> diff --git a/vl.c b/vl.c
>> index 86474a55c9..9fb859969c 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -2779,7 +2779,7 @@ static void configure_accelerators(const char *pro=
gname)
>>           for (tmp =3D accel_list; !accel_initialised && tmp && *tmp; tm=
p++) {
>>               /*
>>                * Filter invalid accelerators here, to prevent obscenitie=
s
>> -             * such as "-machine accel=3Dtcg,,thread=3Dsingle".
>> +             * such as "-machine accel=3Dtcg,thread=3Dsingle".
>=20
> The double comma is intentional.  Without the "if" below, the comma
> would be escaped and parsed as "-accel tcg,thread=3Dsingle".

Ah, OK, than drop this chunk.

>=20
>>                */
>>               if (accel_find(*tmp)) {
>>                   qemu_opts_parse_noisily(qemu_find_opts("accel"), *tmp,=
 true);
>> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
>> index 90970b0549..2890785a10 100755
>> --- a/tests/qemu-iotests/check
>> +++ b/tests/qemu-iotests/check
>> @@ -587,13 +587,13 @@ export QEMU_PROG=3D"$(type -p "$QEMU_PROG")"
>>  =20
>>   case "$QEMU_PROG" in
>>       *qemu-system-arm|*qemu-system-aarch64)
>> -        export QEMU_OPTIONS=3D"-nodefaults -display none -machine virt,=
accel=3Dqtest"
>> +        export QEMU_OPTIONS=3D"-nodefaults -display none -machine virt =
-accel qtest"
>>           ;;
>>       *qemu-system-tricore)
>> -        export QEMU_OPTIONS=3D"-nodefaults -display none -machine trico=
re_testboard,accel=3Dqtest"
>> +        export QEMU_OPTIONS=3D"-nodefaults -display none -machine trico=
re_testboard -accel qtest"
>>           ;;
>>       *)
>> -        export QEMU_OPTIONS=3D"-nodefaults -display none -machine accel=
=3Dqtest"
>> +        export QEMU_OPTIONS=3D"-nodefaults -display none -accel qtest"
>>           ;;
>>   esac
>>  =20
>>
>=20
> This part is good, but what is the reproducer?
>=20


For example, 30 iotest fails for me with a lot of
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ERROR: test_stream (__main__.TestSmallerBackingFile)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "030", line 592, in setUp
+    self.vm.launch()
+  File "/work/src/qemu/master/tests/qemu-iotests/../../python/qemu/machine=
.py", line 302, in launch
+    self._launch()
+  File "/work/src/qemu/master/tests/qemu-iotests/../../python/qemu/machine=
.py", line 329, in _launch
+    self._post_launch()
+  File "/work/src/qemu/master/tests/qemu-iotests/../../python/qemu/qtest.p=
y", line 110, in _post_launch
+    super(QEMUQtestMachine, self)._post_launch()
+  File "/work/src/qemu/master/tests/qemu-iotests/../../python/qemu/machine=
.py", line 274, in _post_launch
+    self._qmp.accept()
+  File "/work/src/qemu/master/tests/qemu-iotests/../../python/qemu/qmp.py"=
, line 157, in accept
+    return self.__negotiate_capabilities()
+  File "/work/src/qemu/master/tests/qemu-iotests/../../python/qemu/qmp.py"=
, line 73, in __negotiate_capabilities
+    raise QMPConnectError
+qemu.qmp.QMPConnectError


and if I add -d, I see

+DEBUG:qemu.machine:Error launching VM
+DEBUG:qemu.machine:Command: '/work/src/qemu/master/tests/qemu-iotests/../.=
./x86_64-softmmu/qemu-system-x86_64 -display none -vga none -chardev socket=
,id=3Dmon,path=3D/tmp/tmp.ANcscZnFct/qemu-23220-monitor.sock -mon chardev=
=3Dmon,mode=3Dcontrol -qtest unix:path=3D/tmp/tmp.ANcscZnFct/qemu-23220-qte=
st.sock -accel qtest -nodefaults -display none -machine accel=3Dqtest -driv=
e if=3Dvirtio,id=3Ddrive0,file=3Dblkdebug::/ramdisk/x3/test.img,format=3Dqc=
ow2,cache=3Dwriteback,backing.node-name=3Dmid,backing.backing.node-name=3Db=
ase'
+DEBUG:qemu.machine:Output: 'qemu-system-x86_64: The -accel and "-machine a=
ccel=3D" options are incompatible\n'


Try just random three python tests: 132 202 203: all fails with same sympto=
ms. (interesting that -d doesn't help for 202 and 203, but still they are f=
ixed after this patch).

I expect that all python tests are broken.. Still I'm lazy to check all, le=
t's just fix.


--=20
Best regards,
Vladimir


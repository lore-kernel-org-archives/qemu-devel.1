Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE42C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:51:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 062132070D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="raXBUJcN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062132070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzizu-000894-Br
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 10:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arikalo@wavecomp.com>) id 1hzivk-0003ZH-QB
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1hzivj-0000Qy-Iw
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:46:44 -0400
Received: from mail-eopbgr710114.outbound.protection.outlook.com
 ([40.107.71.114]:39428 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1hzivj-0000Qe-Bi
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:46:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuT+ocrnjl4QLVCwS99s014XXM7VlUgIr+/OvsSxGnB5/pU/a+blRBt8s3jqrkjQKrBV+YQOPYDO4YM4DzQ0sA+CiQq6kHkWMIcHvGCxaz+wAPHHDxyFHu1WUMNDYk/zcMUcoBjqz2LXI35WK7E/CXH36n0nmvZmkFiNYR7tmKqBqxxQdvDCfGNrhlnvg53vI9vKVn99NTEOB78zc0A5gl1IBrvTGm5RNmvx43jgVc4NOiJV04ntgaevF/aqrOA/llBHLN5LcggBYy2fztBjV3Z2yCLsrYQigX0iOMyp4j/DjeD973LSIhGkX9Z4XpJe4cTJTnC7eLUz/alqbnnFTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5oaZn/RZAa2BF3UoCzs+Eo2bj0o5eg8gBVPeyp+ABo=;
 b=cz9jlTnfTEUxdE/J0Cocc02HuFXdqbGWAHQ5k38esWSQnEQMf3wjs2FkhTymgBplbjA2pD2wC/el9R4xnRzIsz7wgOsYJatjrgZkdDmGqgk1fhHcMk3DX1dwnFqbwjvDuBcDaIbS0l2ihLnc/+fGojKv1BPweiAzA1S4J4kOQbwUD4cSN+mtSrmTWAZERlpGBpaMKhBIZdDlnEYKZIMqVTfCNv0OdMKdqFB2naXzbG00mP2ltibNcGo92Cm9oOBd/v2Iij2+sp9SkNC9BoB/6WhW7oMRekKPHWe6HN27Ka5aop5BlniOHRsr3TKISJsSZwEH8DBsraMHjcXr+U/87A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5oaZn/RZAa2BF3UoCzs+Eo2bj0o5eg8gBVPeyp+ABo=;
 b=raXBUJcN2vvf0MlyBqst4vmpg6oIBfuCN5LXNKXPVwJltxqtTeV3fzqHAFSoelmPaZBJpcL2c7fFj2/V1CyCi6uUd+DvF08dvzPPDE8UGv1FZRScDMw05Fa1/+txj4BgbLpFWfC1fLQfGHpt8wqIRHdjw6ZS44/IOkFyyvfX/KA=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
 DM5PR22MB0684.namprd22.prod.outlook.com (10.172.191.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 19 Aug 2019 14:46:41 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::ed69:1c9f:bdff:2197]) by DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::ed69:1c9f:bdff:2197%5]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 14:46:41 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [EXTERNAL][PATCH v8 14/37] target/mips: Style improvements in
 mips_int.c
Thread-Index: AQHVVobVr2dQLJEYSEeya2ssmW29G6cCjKRF
Date: Mon, 19 Aug 2019 14:46:41 +0000
Message-ID: <DM5PR22MB1658FA857725FD2A0E1AAF35D2A80@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>,
 <1566216496-17375-15-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1566216496-17375-15-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bdef606-8a84-4057-68f1-08d724b40c75
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM5PR22MB0684; 
x-ms-traffictypediagnostic: DM5PR22MB0684:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR22MB068443F8449FB4CB8E240ABED2A80@DM5PR22MB0684.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(346002)(136003)(366004)(39840400004)(189003)(199004)(76176011)(7696005)(76116006)(110136005)(316002)(6606003)(2501003)(74316002)(446003)(229853002)(91956017)(55016002)(54896002)(66476007)(64756008)(52536014)(66556008)(99286004)(66946007)(66066001)(86362001)(6436002)(54906003)(66446008)(9686003)(53546011)(256004)(107886003)(6246003)(3846002)(6116002)(19627405001)(102836004)(33656002)(14444005)(8676002)(6506007)(55236004)(186003)(53936002)(5660300002)(81156014)(81166006)(14454004)(26005)(4326008)(71200400001)(8936002)(478600001)(71190400001)(7736002)(11346002)(25786009)(476003)(2906002)(486006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0684;
 H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RIrby3wkxXm9FhYlKkUQdbzVbPMvVJv5dZT1/02ToNc4q/jJsXjr3e36BQEEM7hEKx8PREsjGuhfeQxlm+welM2DQPBcASvTG1T6YNGzfuqreUFcWoAaYgh6dqH4XI42ax5v3mcWDT19b/7iS0Q/8GxmXhCbAidB8egspJPKX8xyXlT4+pvDdaOVrlssUJ7U1a1ZPixlwRnOtdn6eCcnfedbiGwr4Og0XfpKjsxzpFYPXi8xeVlbWhoA7fhEvih27sqpCT8S4FcY/VIuTCuXA2Ly7MKVFLFetX8UwI/CYbB0HKpDRStIP5CKVGc4PoQoteIeLyJtc8suEYhzY8eABtDy0CpVCJuva8DRypyTlZL/UtZUjLd1Lrdiug0BYYQTy50I1JNDFnwW/7WWggqNHoMkBC9GQSAxBCUH9CqfUdA=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bdef606-8a84-4057-68f1-08d724b40c75
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 14:46:41.7379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y6bNbzZm6b4+zQpgJknPBQLQVgxaImqZ6YwUSalMaIZ2Y/JcLUS4GyHwuj6yAmoIy/+x5MQjtVWRKRBYOy7y+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0684
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.114
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [EXTERNAL][PATCH v8 14/37] target/mips: Style
 improvements in mips_int.c
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
Cc: "philmd@redhat.com" <philmd@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Monday, August 19, 2019 2:07 PM
> To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
> Cc: philmd@redhat.com <philmd@redhat.com>; Aleksandar Markovic <amarkovic=
@wavecomp.com>; Aleksandar Rikalo <arikalo@wavecomp.com>
> Subject: [EXTERNAL][PATCH v8 14/37] target/mips: Style improvements in mi=
ps_int.c
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Fixes mostly errors and warnings reported by 'checkpatch.pl -f'.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  hw/mips/mips_int.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
> index f899f6c..4c731ab 100644
> --- a/hw/mips/mips_int.c
> +++ b/hw/mips/mips_int.c
> @@ -35,8 +35,9 @@ static void cpu_mips_irq_request(void *opaque, int irq,=
 int level)
>      CPUState *cs =3D CPU(cpu);
>      bool locked =3D false;
>
> -    if (irq < 0 || irq > 7)
> +    if (irq < 0 || irq > 7) {
>          return;
> +    }
>
>      /* Make sure locking works even if BQL is already held by the caller=
 */
>      if (!qemu_mutex_iothread_locked()) {
> --
> 2.7.4
>

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>


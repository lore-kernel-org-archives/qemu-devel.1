Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54E2C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF4F22070D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="Mxc5glrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4F22070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzj0T-0000rf-G6
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 10:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arikalo@wavecomp.com>) id 1hziy8-00067K-W4
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1hziy7-0001Q1-J4
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:49:12 -0400
Received: from mail-eopbgr720096.outbound.protection.outlook.com
 ([40.107.72.96]:22016 helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1hziy6-0001PK-Vv
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:49:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nI3k6aqpPaJ5fqLyUNd2wwAgUl7nLcPwVX8tpLqQE3vO8kfD6w+Ck6w2CVaqib+UyhV73OjzXky0Vt99gU4c4M+9CuEKV6mCQ3aBnJ5jFgTY8KshF7FjT9FheQv+UojIEKX76/6b4ixGNCwQ8pJMCK5sdn6L+A0pNb8xIPknvGlpcRInsNbuKO8HP3qsbmTjkuDv27t5jYFkC9uFVrfc+0EmO9mR2nDOjaeWxCto1TDqxE/bKoFdpTqSokWStmPjHHsrk18eRBv1Y/0SWu7xg0hEXmDHMHBme1jvPGXNJWLb+P1PS+9lM1hhxM2BScdIFTH6vQbKB7v81oLJKg0K1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0AS2O+xs6nZh/h75VRWXC9zRWT9GKszbF8+F0gqW4E=;
 b=fmCxS27GKeTvuibprcWlB+OAKZVMCJskOcS5uzetAIy411kBKzw6Mp8n8JMWW8YTIMG+UypGYFMzPPhV4xEOCbpSUR30p7/fPiwvNSbp6lU0EiZBZ/8vTKPMFavtnUHiByX3CAgKyQi/mvb7BGlWrC+psCYpNNUDnhwllTY9MGnVIunEccuN0OftdG3NDnlFgigrCmAK6A/6tmJqMoG/3fBlX8u5Rh53Q/XZrD9hJ88kMOhpUeGV3rQbUO/g1wgsLYP6eTzP6NoLc5M1bCbJeIsUqT0lBqGZM0wIdvfkKjYP9OSpUotOYBbtvdFURivRjjkJjWz0bqlIgzXnzmfNRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0AS2O+xs6nZh/h75VRWXC9zRWT9GKszbF8+F0gqW4E=;
 b=Mxc5glrERt/ujkgLFyk65C79h9xFNIp9lnAcIvMhA+E/YgFLL2Z5E/hQv8+o6tiPA/+jh5ryjN8ns0izoJm+ol6z0yHpScWaZylGFAKaUSCmrDDtH4nldZy6P2jWcRf9DUVfQKdEq2gEQf0Rv2uLGp3oFJbaJ+QUieJ2az8w+IM=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
 DM5PR22MB0683.namprd22.prod.outlook.com (10.172.190.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 19 Aug 2019 14:49:09 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::ed69:1c9f:bdff:2197]) by DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::ed69:1c9f:bdff:2197%5]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 14:49:09 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [EXTERNAL][PATCH v8 36/37] target/mips: tests/tcg: Add optional
 printing of more detailed failure info
Thread-Index: AQHVVobVFkuqG8u43Ue30JVR1gbssacCjVTI
Date: Mon, 19 Aug 2019 14:49:09 +0000
Message-ID: <DM5PR22MB1658A66A26A98AC8EDA83E45D2A80@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>,
 <1566216496-17375-37-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1566216496-17375-37-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 510f2be0-433d-49d9-9af2-08d724b4646c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DM5PR22MB0683; 
x-ms-traffictypediagnostic: DM5PR22MB0683:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR22MB068361427DCBE22EC17C4015D2A80@DM5PR22MB0683.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(346002)(396003)(39840400004)(366004)(199004)(189003)(186003)(66066001)(9686003)(81166006)(102836004)(4326008)(81156014)(107886003)(5660300002)(54906003)(6436002)(54896002)(19627405001)(110136005)(26005)(6116002)(86362001)(3846002)(2501003)(55016002)(486006)(52536014)(476003)(8676002)(316002)(256004)(6606003)(6506007)(53546011)(11346002)(53936002)(55236004)(14454004)(66446008)(64756008)(71200400001)(7736002)(6246003)(33656002)(99286004)(71190400001)(91956017)(76116006)(66556008)(66946007)(229853002)(74316002)(66476007)(446003)(2906002)(25786009)(76176011)(7696005)(14444005)(478600001)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0683;
 H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OrHczmviFKhtHKRopkn8TWu4K9VD7dnw8leNiM7BzGI/eIgjerMuniDNkB1nm+QFcYpuwTXFmylCJBGz/lDm17DCBTQXn+RO6rsG4oVaFVYpVTDmLxNWVSq3Ti1QwRQ9BZCwW9X2Gx7UF9y3wQvPVxUuhjv1/fIj6nwCSSzlnKo4j2B0w0ytdrhBrtYi5rC+WUl2JojULNanY23wEmlQbqmtyTLGZ1YhJYNs+R4jQLVmYuhVt8e/b7DLtv1jSingyOZa80xjxqIswLgtmHgA98QpvSJYQAZTFTkM9clZBYzRXNV2EhvWC3b6JX/16lSlLUw01OhS+WK7CtYjBlC75LCkVlD/4Dk1dTpGf9XflNuwK0p+0d8iNtIaPw6m/4ALSbxQ/k9oF4iI91CNbnlOt4QT1boTMTW8f4knaPbM41w=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510f2be0-433d-49d9-9af2-08d724b4646c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 14:49:09.2947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/jmhJEht3hlpJIkhBrtq4TZxJrIg7nuUZvuyitpNHIObhLNL3kz31J3iwr1vN88EJDTc5OL/qy6KDygf4BiVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0683
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.72.96
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [EXTERNAL][PATCH v8 36/37] target/mips: tests/tcg:
 Add optional printing of more detailed failure info
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

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Monday, August 19, 2019 2:08 PM
> To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
> Cc: philmd@redhat.com <philmd@redhat.com>; Aleksandar Markovic <amarkovic=
@wavecomp.com>; Aleksandar Rikalo <arikalo@wavecomp.com>
> Subject: [EXTERNAL][PATCH v8 36/37] target/mips: tests/tcg: Add optional =
printing of more detailed failure info
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> There is a need for printing input and output data for failure cases,
> for debugging purpose. This is achieved by this patch, and only if a
> preprocessor constant is manually set to 1. (Assumption is that the
> need for such printout is relatively rare.)
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  tests/tcg/mips/include/test_utils_128.h | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/tests/tcg/mips/include/test_utils_128.h b/tests/tcg/mips/inc=
lude/test_utils_128.h
> index 2fea610..0dd3868 100644
> --- a/tests/tcg/mips/include/test_utils_128.h
> +++ b/tests/tcg/mips/include/test_utils_128.h
> @@ -27,7 +27,8 @@
>  #include <inttypes.h>
>  #include <string.h>
>
> -#define PRINT_RESULTS 0
> +#define PRINT_RESULTS    0
> +#define PRINT_FAILURES   0
>
>
>  static inline int32_t check_results_128(const char *isa_ase_name,
> @@ -65,6 +66,26 @@ static inline int32_t check_results_128(const char *is=
a_ase_name,
>              (b128_result[2 * i + 1] =3D=3D b128_expect[2 * i + 1])) {
>              pass_count++;
>          } else {
> +#if PRINT_FAILURES
> +            uint32_t ii;
> +            uint64_t a, b;
> +
> +            printf("\n");
> +
> +            printf("FAILURE for test case %d!\n", i);
> +
> +            memcpy(&a, (b128_expect + 2 * i), 8);
> +            memcpy(&b, (b128_expect + 2 * i + 1), 8);
> +            printf("Expected result : { 0x%016llxULL, 0x%016llxULL, },\n=
",
> +                   a, b);
> +
> +            memcpy(&a, (b128_result + 2 * i), 8);
> +            memcpy(&b, (b128_result + 2 * i + 1), 8);
> +            printf("Actual result   : { 0x%016llxULL, 0x%016llxULL, },\n=
",
> +                   a, b);
> +
> +            printf("\n");
> +#endif
>              fail_count++;
>          }
>      }
> --
> 2.7.4

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>


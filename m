Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAE0C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9627C2070B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="N+RRnnSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9627C2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i31Sf-0000Gl-KO
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 13:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arikalo@wavecomp.com>) id 1i3175-0001dB-Ja
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1i3172-0004lQ-Rn
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:48:02 -0400
Received: from mail-eopbgr710113.outbound.protection.outlook.com
 ([40.107.71.113]:59136 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1i3171-0004jD-PX
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:48:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiF9jPOdGnWzI/+yD11nPzrIXyteg6TcLPYUzZ0oxO1wITylfLm5fFBAKi05VwgoQB8TJXzuOSfIETnRELOj5wJjFvVsLoKisRt+cVqi0V46UpF0R1g1K9+9hmXhx/WPwp9JiIk6qT4MD3aBiyKSdge5JY4nNYKUvQcbF4Lc1wlH2/k0QHD24+DhTCRRvOdBbtOzBgbBHYjM6vqU4/mSwopZn4tmLDIyjUxD+ILh8Og0UWy1VD7faD8Yq42VqBhmQKsE0Ss2wPNJSY3iQV0b1LHChHEtnMn1Z/4PXSpmwQrb29eEbdHYTtHo4XgaYlkV7d1/8E8vGemKC1N9PhDgjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/PmR0oD0JyH3Y4qi8Kev5QGjF/6O9dudzOVftZ1xdI=;
 b=Mgv01bwPJcKQ7ag8j+7jm0xOzQCwXbNzhC+b823lb2DwiSLb4XdvRmW3BouA8Kb2G6x28IMnzgA0bm5AFQGiE6lJDzslwNrH+s40cprKqTlmYEhkJAF08xEpQHjVjorfxaOTrbVktCbWIyT1wb9wXWBYGXHBpsS630OUo1ICg6teG55nvPs9x5U++pvvZCFqPocKXSY5SDzv57y7W1+tWCiF0HjEP9WFbpt/EVMqXk+IwIs2BLbX2vG7qx8kUFKKnT7lRIPb4XaQhJ+rItRcMcikhjkSamsQ3NiMYS8W1lu2Y/NWKUynRpYPLOSdbQy5S/27xdN8Gj2uAlrLRSSUDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/PmR0oD0JyH3Y4qi8Kev5QGjF/6O9dudzOVftZ1xdI=;
 b=N+RRnnSgNSd5AC4k/V6i71KOkArPxPz6V86eEk8R43HUpxsQXFnj+aVKpMYFIFXvJoNe+wgZsEt05McJOqRru8HiXOn5/khDSvsY29X/gNzBnzm2Wi5HzFpQHdxMMoraj8retXoBnwYiDEzwQiji3W6oDQHDLhJLeTBwlxN4cOA=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
 DM5PR22MB0684.namprd22.prod.outlook.com (10.172.191.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 16:47:55 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::ed69:1c9f:bdff:2197]) by DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::ed69:1c9f:bdff:2197%5]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 16:47:55 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [EXTERNAL][PATCH] target/mips: Fix emulation of ST.W in system
 mode
Thread-Index: AQHVXbyQFGXGZCmyrE2VDR0S8kVvzacQxOgg
Date: Wed, 28 Aug 2019 16:47:55 +0000
Message-ID: <DM5PR22MB1658692F65BBADA4CF5735E4D2A30@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1567009239-11273-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1567009239-11273-1-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7023c9d3-d5c6-4cc8-a917-08d72bd779e1
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM5PR22MB0684; 
x-ms-traffictypediagnostic: DM5PR22MB0684:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR22MB06843FF81212F590F002C710D2A30@DM5PR22MB0684.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(366004)(346002)(136003)(376002)(396003)(189003)(199004)(478600001)(476003)(3846002)(486006)(66066001)(25786009)(74316002)(7736002)(2501003)(81156014)(81166006)(66476007)(66446008)(66946007)(91956017)(76116006)(64756008)(14454004)(19627405001)(316002)(110136005)(66556008)(2906002)(99286004)(107886003)(9686003)(53936002)(54896002)(55016002)(6506007)(8676002)(71190400001)(76176011)(5660300002)(71200400001)(6436002)(33656002)(55236004)(186003)(446003)(102836004)(26005)(8936002)(6606003)(6116002)(6246003)(14444005)(86362001)(229853002)(52536014)(256004)(7696005)(11346002)(53546011)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0684;
 H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: T0q773k8ip7ijar0D0kPztDa8QbYdgLjXPSmySkHYOu6SCjujPBnyIWhOL7JL7zPfSXtPqeKrjQJfSuAVZxBo/Q0nkYssDDNrikAjJcxBs0Rtcwccj340ZdayI9O+1LvWr5mDjEz3naHYW+EEderxywm5lqPXlRYiFErDHGxZROziu+I/mIcFWHgGH8oBndYpVGzOwbEpmTPI/Vd6VHrFmyHY8kcz3vR5uTRPHyC1RlW5KBidWJ3MRmQhAIHELOKUSthyUHewrXM4iZcglBzgsAaJXD23iygs2+8G6CXuixuNCzw0+yMKAllaH2SQSIGZCtDFVPOOO8UgrhvPobj/uCsCulWvC9Ec6HI9Om7WdZWpGrlj7Qukllg5uNrrT42x3EiYi3qUmpQceIYDoeQ4PVnSLaYZMuU4hcokQHwKh8=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7023c9d3-d5c6-4cc8-a917-08d72bd779e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 16:47:55.8120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Djqke8PPzferVTtlQXXoMbxgfTJ3wwPbqgZCwkVt1HOrgDnZLtnjDq/2mMGWGYMgcoDNgT/f3g+2v8m4ueWELg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0684
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.113
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [EXTERNAL][PATCH] target/mips: Fix emulation of
 ST.W in system mode
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Wednesday, August 28, 2019 6:20 PM
> To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
> Cc: Aleksandar Markovic <amarkovic@wavecomp.com>; Aleksandar Rikalo <arik=
alo@wavecomp.com>
> Subject: [EXTERNAL][PATCH] target/mips: Fix emulation of ST.W in system m=
ode
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Order of arguments in helper_ret_stl_mmu() invocations was wrong,
> apparently caused by misplaced multiline copy-and-paste.
>
> Fixes: 6decc57 "target/mips: Fix MSA instructions ST.<B|H|W|D> on
> big endian host"
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/op_helper.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 5874029..e55e300 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -4842,15 +4842,15 @@ void helper_msa_st_w(CPUMIPSState *env, uint32_t =
wd,
>      ensure_writable_pages(env, addr, mmu_idx, GETPC());
>  #if !defined(CONFIG_USER_ONLY)
>  #if !defined(HOST_WORDS_BIGENDIAN)
> -    helper_ret_stl_mmu(env, addr + (0 << DF_WORD), oi, GETPC(), pwd->w[0=
]);
> -    helper_ret_stl_mmu(env, addr + (1 << DF_WORD), oi, GETPC(), pwd->w[1=
]);
> -    helper_ret_stl_mmu(env, addr + (2 << DF_WORD), oi, GETPC(), pwd->w[2=
]);
> -    helper_ret_stl_mmu(env, addr + (3 << DF_WORD), oi, GETPC(), pwd->w[3=
]);
> +    helper_ret_stl_mmu(env, addr + (0 << DF_WORD), pwd->w[0], oi, GETPC(=
));
> +    helper_ret_stl_mmu(env, addr + (1 << DF_WORD), pwd->w[1], oi, GETPC(=
));
> +    helper_ret_stl_mmu(env, addr + (2 << DF_WORD), pwd->w[2], oi, GETPC(=
));
> +    helper_ret_stl_mmu(env, addr + (3 << DF_WORD), pwd->w[3], oi, GETPC(=
));
>  #else
> -    helper_ret_stl_mmu(env, addr + (1 << DF_WORD), oi, GETPC(), pwd->w[0=
]);
> -    helper_ret_stl_mmu(env, addr + (0 << DF_WORD), oi, GETPC(), pwd->w[1=
]);
> -    helper_ret_stl_mmu(env, addr + (3 << DF_WORD), oi, GETPC(), pwd->w[2=
]);
> -    helper_ret_stl_mmu(env, addr + (2 << DF_WORD), oi, GETPC(), pwd->w[3=
]);
> +    helper_ret_stl_mmu(env, addr + (1 << DF_WORD), pwd->w[0], oi, GETPC(=
));
> +    helper_ret_stl_mmu(env, addr + (0 << DF_WORD), pwd->w[1], oi, GETPC(=
));
> +    helper_ret_stl_mmu(env, addr + (3 << DF_WORD), pwd->w[2], oi, GETPC(=
));
> +    helper_ret_stl_mmu(env, addr + (2 << DF_WORD), pwd->w[3], oi, GETPC(=
));
>  #endif
>  #else
>  #if !defined(HOST_WORDS_BIGENDIAN)
> --
> 2.7.4

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>



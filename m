Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A85FC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:10:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD18C21D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="eH4DYd4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD18C21D7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD80J-0004m5-Vv
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 10:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arikalo@wavecomp.com>) id 1iD7zM-0004C2-OJ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1iD7zK-0003ou-Rc
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:09:52 -0400
Received: from mail-eopbgr730106.outbound.protection.outlook.com
 ([40.107.73.106]:12652 helo=NAM05-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1iD7zK-0003nG-GZ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:09:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkClUlMQLhmq9Am/mQzFEFTA7HphwAs7zBWd5P5MX/BvjWMWPcqPrDKWSLT6XPez5e7y3ONcMr2YhxR+FiOprXkr6s0Rn2Zf2VAqYlV5IwgvyKFi1ipIruiInxTXQP2P5k4f9kS4AFTXxWyuBkUHFs8QHFlSixGXtujrMbNBLu3datv9J9u8Qc9RsWRwNmEzL+Y3kLdd7PIGeE4A7aZU0bOcrGt+uctiDTanmkE58RgSf3HO/ZPVBNjJ4wlMciqjxrfkcrSa4oBpA0sN+mtbX1wWQybYxli5PBz5vUaA4mVXcli9GBp4iuL3VJZnnB+cbZkgbF49lO3P1lDNNaZodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChcZMZpmH+UZiSbBjzgYRJ+HvLZ3w4+emycKdVUEYC4=;
 b=bNAosAZf+afAsHA4yKCCPFrP8EtZyMQxw9nVhVNggOu6DUSV1onfM/YUj3BbdgrX4xPaUrvHbO/ZfFF7sK80n96oKV2oxdgqhgSr1RNQkkD6Dipm8hlzFc3E7bv1ADiXrJ8+008zCtWYOZp2fCVPnUoXgP8KPNavuK0a/6rS0gwLjF9buoM4n622cTskEVlAiV3S4RthHd8vFu0OShcUG57+RfR1BPEscqlLUPXUHiYZ+DZ5PFlSnH+zgW9uLY18iSUxh/2me8zyBCoQ1ysGHbx/TKq7Gu57Xr1M0VCtK8u7//TIWNOezSEzZmd3O/IVMlYZRWgjAwmvjHqKDZiCig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChcZMZpmH+UZiSbBjzgYRJ+HvLZ3w4+emycKdVUEYC4=;
 b=eH4DYd4tt8mIGqbad6LfLlLtfi4JE2acisDilcshX3Mu5nhjhFW0kU7mOWNOjl6nVL0CkQYPxf3cENBP1r9bUOIJMXHRbEcvUCTLAU3RB3Kc5V5Fi0DBqqL4kIB7sbhfOLMi1SMl87rH6VKAiANVU3VfCl97x/H+e/YEq4Ycxpc=
Received: from MWHPR22MB1664.namprd22.prod.outlook.com (10.164.206.142) by
 MWHPR22MB0126.namprd22.prod.outlook.com (10.168.249.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.21; Wed, 25 Sep 2019 14:09:46 +0000
Received: from MWHPR22MB1664.namprd22.prod.outlook.com
 ([fe80::715e:bc1f:6393:9b00]) by MWHPR22MB1664.namprd22.prod.outlook.com
 ([fe80::715e:bc1f:6393:9b00%3]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 14:09:46 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [EXTERNAL][PATCH v2 00/20] target/mips: Misc cleanups for
 September/October 2019
Thread-Topic: [EXTERNAL][PATCH v2 00/20] target/mips: Misc cleanups for
 September/October 2019
Thread-Index: AQHVc58+lebhCXHmDUiXkZWwejizLqc8bVEZ
Date: Wed, 25 Sep 2019 14:09:46 +0000
Message-ID: <MWHPR22MB16644605D91274DCB0F306B5D2870@MWHPR22MB1664.namprd22.prod.outlook.com>
References: <1569415572-19635-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1569415572-19635-1-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce4f7e77-159c-4bc2-6c57-08d741c20586
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:MWHPR22MB0126; 
x-ms-traffictypediagnostic: MWHPR22MB0126:
x-microsoft-antispam-prvs: <MWHPR22MB012643857AAF1EF3A37DADBDD2870@MWHPR22MB0126.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:139;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(136003)(396003)(39840400004)(376002)(189003)(199004)(478600001)(66946007)(14454004)(91956017)(55236004)(316002)(5660300002)(66066001)(25786009)(66446008)(66476007)(66556008)(64756008)(53546011)(7696005)(2501003)(6506007)(99286004)(8936002)(8676002)(76116006)(81166006)(81156014)(76176011)(19627405001)(2906002)(86362001)(55016002)(71190400001)(71200400001)(6436002)(105004)(9686003)(6246003)(54896002)(229853002)(26005)(186003)(102836004)(110136005)(256004)(52536014)(446003)(11346002)(486006)(6116002)(476003)(74316002)(7736002)(3846002)(33656002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR22MB0126;
 H:MWHPR22MB1664.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DXW77b5bTov0IkW7mfIbRij7FetdFGIC7Yr3x069Q9jcTGh9b/ciMPxS7TIqQ0ATIXhFwhtb8nx9dZkAP/OM77J8AUpLbc5ikIwyvd5MNNEcE1YK+6MWrcpnPuqc+IFrPDd4Kpgj+kQ1QaINKXWnWo3Cd1SpUq95ORhPBhIau4EYBwsGUByviSDUMkCBaVq1THB8mAq5lVu8gx5LCLhN/yojcVheV6v0hK7QSaRf/MdBobwcQxB0LjfRaeulTRe+GD2pIiU0KZRqtkBpytnv4ZzU9y5ujRCND+9uqQFrHo6rF2MPlCqkf2TIwk3Ms0m3C5SI932bc6Kovk3rLHfyoOy0RZNQcA6DkYX8B34fA5lUz3ZNaJphq7RtXg4+n4X0CgYJsoiI0Dn8kpOTmeGarEVYY8C80WavVgftEVPPOZc=
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_MWHPR22MB16644605D91274DCB0F306B5D2870MWHPR22MB1664namp_"
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4f7e77-159c-4bc2-6c57-08d741c20586
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 14:09:46.7141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YrK6mywt4lIRUEguTrpLV6kUtKfuZJ7jczp0gaLl+hWh53cpLdz0j3lIsYK0j+m2WeRYXhesO2czgemtaUNfEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR22MB0126
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.73.106
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_MWHPR22MB16644605D91274DCB0F306B5D2870MWHPR22MB1664namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Wednesday, September 25, 2019 2:45 PM
> To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
> Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
> Subject: [EXTERNAL][PATCH v2 00/20] target/mips: Misc cleanups for Septem=
ber/October 2019
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Mostly cosmetic changes.
>
> Aleksandar Markovic (20):
>   target/mips: Clean up helper.c
>   target/mips: Clean up internal.h
>   target/mips: Clean up kvm_mips.h
>   target/mips: Clean up mips-defs.h
>   target/mips: Clean up op_helper.c
>   target/mips: Clean up translate.c
>   target/mips: msa: Split helpers for <NLOC|NLZC>.<B|H|W|D>
>   target/mips: msa: Split helpers for PCNT.<B|H|W|D>
>   target/mips: msa: Split helpers for BINS<L|R>.<B|H|W|D>
>   target/mips: msa: Unroll loops and demacro <BMNZ|BMZ|BSEL>.V
>   target/mips: msa: Split helpers for B<CLR|NEG|SEL>.<B|H|W|D>
>   target/mips: msa: Split helpers for AVE_<S|U>.<B|H|W|D>
>   target/mips: msa: Split helpers for AVER_<S|U>.<B|H|W|D>
>   target/mips: msa: Split helpers for CEQ.<B|H|W|D>
>   target/mips: msa: Split helpers for CLE_<S|U>.<B|H|W|D>
>   target/mips: msa: Split helpers for CLT_<S|U>.<B|H|W|D>
>   target/mips: msa: Split helpers for DIV_<S|U>.<B|H|W|D>
>   target/mips: msa: Split helpers for MOD_<S|U>.<B|H|W|D>
>   target/mips: msa: Simplify and move helper for MOVE.V
>   target/mips: msa: Move helpers for <AND|NOR|OR|XOR>.V
>
>  target/mips/helper.c     |  132 +--
>  target/mips/helper.h     |  144 +++-
>  target/mips/internal.h   |   60 +-
>  target/mips/kvm_mips.h   |    2 +-
>  target/mips/mips-defs.h  |   53 +-
>  target/mips/msa_helper.c | 2115 ++++++++++++++++++++++++++++++++++++----=
------
>  target/mips/op_helper.c  |  913 +++++++++++++-------
>  target/mips/translate.c  |  421 +++++++--
>  8 files changed, 2888 insertions(+), 952 deletions(-)
>
> --
> 2.7.4

Make sure you run all our MSA regression unit tests before applying.
Also, there are more than 80 characters lines in patches 12, 13, 15, 16, 17=
 and 18.

Otherwise:
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>


--_000_MWHPR22MB16644605D91274DCB0F306B5D2870MWHPR22MB1664namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<span>&gt; From: Aleksandar Markovic &lt;aleksandar.markovic@rt-rk.com&gt;<=
br>
</span>
<div>&gt; Sent: Wednesday, September 25, 2019 2:45 PM<br>
</div>
<div>&gt; To: qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
</div>
<div>&gt; Cc: Aleksandar Rikalo &lt;arikalo@wavecomp.com&gt;<br>
</div>
<div>&gt; Subject: [EXTERNAL][PATCH v2 00/20] target/mips: Misc cleanups fo=
r September/October 2019<br>
</div>
<div>&gt; &nbsp;<br>
</div>
<div>&gt; From: Aleksandar Markovic &lt;amarkovic@wavecomp.com&gt;<br>
</div>
<div>&gt; <br>
</div>
<div>&gt; Mostly cosmetic changes.<br>
</div>
<div>&gt; <br>
</div>
<div>&gt; Aleksandar Markovic (20):<br>
</div>
<div>&gt; &nbsp; target/mips: Clean up helper.c<br>
</div>
<div>&gt; &nbsp; target/mips: Clean up internal.h<br>
</div>
<div>&gt; &nbsp; target/mips: Clean up kvm_mips.h<br>
</div>
<div>&gt; &nbsp; target/mips: Clean up mips-defs.h<br>
</div>
<div>&gt; &nbsp; target/mips: Clean up op_helper.c<br>
</div>
<div>&gt; &nbsp; target/mips: Clean up translate.c<br>
</div>
<div>&gt; &nbsp; target/mips: msa: Split helpers for &lt;NLOC|NLZC&gt;.&lt;=
B|H|W|D&gt;<br>
</div>
<div>&gt; &nbsp; target/mips: msa: Split helpers for PCNT.&lt;B|H|W|D&gt;<b=
r>
</div>
<div>&gt; &nbsp; target/mips: msa: Split helpers for BINS&lt;L|R&gt;.&lt;B|=
H|W|D&gt;<br>
</div>
<div>&gt; &nbsp; target/mips: msa: Unroll loops and demacro &lt;BMNZ|BMZ|BS=
EL&gt;.V<br>
</div>
<div>&gt; &nbsp; target/mips: msa: Split helpers for B&lt;CLR|NEG|SEL&gt;.&=
lt;B|H|W|D&gt;<br>
</div>
<div>&gt; &nbsp; target/mips: msa: Split helpers for AVE_&lt;S|U&gt;.&lt;B|=
H|W|D&gt;<br>
</div>
<div>&gt; &nbsp; target/mips: msa: Split helpers for AVER_&lt;S|U&gt;.&lt;B=
|H|W|D&gt;<br>
</div>
<div>&gt; &nbsp; target/mips: msa: Split helpers for CEQ.&lt;B|H|W|D&gt;<br=
>
</div>
<div>&gt; &nbsp; target/mips: msa: Split helpers for CLE_&lt;S|U&gt;.&lt;B|=
H|W|D&gt;<br>
</div>
<div>&gt; &nbsp; target/mips: msa: Split helpers for CLT_&lt;S|U&gt;.&lt;B|=
H|W|D&gt;<br>
</div>
<div>&gt; &nbsp; target/mips: msa: Split helpers for DIV_&lt;S|U&gt;.&lt;B|=
H|W|D&gt;<br>
</div>
<div>&gt; &nbsp; target/mips: msa: Split helpers for MOD_&lt;S|U&gt;.&lt;B|=
H|W|D&gt;<br>
</div>
<div>&gt; &nbsp; target/mips: msa: Simplify and move helper for MOVE.V<br>
</div>
<div>&gt; &nbsp; target/mips: msa: Move helpers for &lt;AND|NOR|OR|XOR&gt;.=
V<br>
</div>
<div>&gt; <br>
</div>
<div>&gt; &nbsp;target/mips/helper.c &nbsp; &nbsp; | &nbsp;132 &#43;--<br>
</div>
<div>&gt; &nbsp;target/mips/helper.h &nbsp; &nbsp; | &nbsp;144 &#43;&#43;&#=
43;-<br>
</div>
<div>&gt; &nbsp;target/mips/internal.h &nbsp; | &nbsp; 60 &#43;-<br>
</div>
<div>&gt; &nbsp;target/mips/kvm_mips.h &nbsp; | &nbsp; &nbsp;2 &#43;-<br>
</div>
<div>&gt; &nbsp;target/mips/mips-defs.h &nbsp;| &nbsp; 53 &#43;-<br>
</div>
<div>&gt; &nbsp;target/mips/msa_helper.c | 2115 &#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;----------<br>
</div>
<div>&gt; &nbsp;target/mips/op_helper.c &nbsp;| &nbsp;913 &#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<br>
</div>
<div>&gt; &nbsp;target/mips/translate.c &nbsp;| &nbsp;421 &#43;&#43;&#43;&#=
43;&#43;&#43;&#43;--<br>
</div>
<div>&gt; &nbsp;8 files changed, 2888 insertions(&#43;), 952 deletions(-)<b=
r>
</div>
<div>&gt; <br>
</div>
<div>&gt; -- <br>
</div>
<div>&gt; 2.7.4<br>
</div>
<div><br>
</div>
<div>Make sure you run all our MSA regression unit tests before applying.<b=
r>
</div>
<div>Also, there are more than 80 characters lines in patches 12, 13, 15, 1=
6, 17 and 18.<br>
</div>
<div><br>
</div>
<div>Otherwise: <br>
</div>
<div>Reviewed-by: Aleksandar Rikalo &lt;arikalo@wavecomp.com&gt;<br>
</div>
<span></span><br>
</body>
</html>

--_000_MWHPR22MB16644605D91274DCB0F306B5D2870MWHPR22MB1664namp_--


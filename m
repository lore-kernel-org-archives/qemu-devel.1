Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EF8C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D4022303
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="xyLSeM1U";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="d7GuQEbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D4022303
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX7E7-00066S-2B
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 12:23:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1iX7D4-0005Aa-HB
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:22:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1iX7D3-00043G-3M
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:22:38 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:23038)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1iX7D2-00041J-JR
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1574184156; x=1605720156;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=AcjaQXr/4HihfiYJ9HG0PziRqUZBnZmWMqUbNygjOc8=;
 b=xyLSeM1UJ6T7TrA3ZK2T4n4LUnX+2sERpSRt+b/TPtDnDH8zUvYi5fXy
 cKV8cpkLzWpSqfAMUyXABzQa7ZjF3aweWvf3wlyDUMlCnevbddA352Jgi
 aH6Ar1ZyaXBPT1I4sM9Zxhu/4LT7EhuLKfT1FYIDZtDx0gvtd6pUKmN8B A=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Nov 2019 09:22:33 -0800
IronPort-SDR: vdivo4LN7Wi4ovvth2NGAHd+y8V1nAdUuUoNZkPFugcnu+Or4goeRNteZcxj8QP/zveh8Qb8YF
 oqRvvWL0Y5Q2TfOEyYpgYH6a/Lqkg4p5JpWs2Axi7ymgmLGI9coR3Pg5PyzScc3kQ7cFbVzgej
 hHTAo7mMpgqjFwSbuw+Pl6RV+PogfwwDYwIFHUdD0nRavXRxzlXDXvESLv+pLeiMTLQ8z03Tsq
 g/dm9AFPegTRb0t9ZFoT62F5vAAtxvVxg40H/xVuwnV4Q92Zm7eRkug4Na7njqw08XDeRMG0eb
 xAThab13t/vX0+m4sT8xuUNx
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 19 Nov 2019 09:22:30 -0800
Received: from nasanexm01a.na.qualcomm.com (10.85.0.81) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Tue, 19 Nov 2019 09:22:29 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm01a.na.qualcomm.com (10.85.0.81) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Tue, 19 Nov 2019 09:22:28 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB4150.namprd02.prod.outlook.com (20.176.248.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Tue, 19 Nov 2019 17:22:28 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::b0e0:a44a:3fc6:e2b9]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::b0e0:a44a:3fc6:e2b9%3]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 17:22:27 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi"
 <riku.voipio@iki.fi>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] Add minimal Hexagon target - First in a series of patches
 - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon -
 Files in target/hexagon/imported are from another project and therefore do
 not conform to qemu coding standards
Thread-Topic: [PATCH] Add minimal Hexagon target - First in a series of
 patches - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon - Files in target/hexagon/imported are from another project
 and therefore do not conform to qemu coding standards
Thread-Index: AQHVnmwob37h/DrHSkKsyb+krTkIzKeSnIAAgAAaZ7A=
Date: Tue, 19 Nov 2019 17:22:27 +0000
Message-ID: <BYAPR02MB488666AA94EBB57C2A318004DE4C0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
 <a77ce406-5307-cee8-8e0b-7c08056fb0df@redhat.com>
In-Reply-To: <a77ce406-5307-cee8-8e0b-7c08056fb0df@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [199.106.103.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3747e57a-2a54-4376-7e42-08d76d150d33
x-ms-traffictypediagnostic: BYAPR02MB4150:
x-microsoft-antispam-prvs: <BYAPR02MB4150FA553D27C37AEE2461AADE4C0@BYAPR02MB4150.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(346002)(376002)(366004)(39860400002)(13464003)(189003)(199004)(7696005)(6246003)(8676002)(81156014)(229853002)(316002)(2201001)(81166006)(9686003)(76176011)(71190400001)(25786009)(186003)(76116006)(5660300002)(8936002)(55016002)(33656002)(2501003)(486006)(66066001)(476003)(99286004)(53546011)(6506007)(6436002)(86362001)(66946007)(110136005)(11346002)(446003)(478600001)(14454004)(74316002)(6116002)(26005)(256004)(52536014)(2906002)(71200400001)(7736002)(3846002)(305945005)(64756008)(66556008)(66446008)(66476007)(102836004)(219693003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4150;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3EwoyWE/ZJ03LptE8WYj1ZSBlE0x3x4vXB1v0acV5+Y+nTjlrNeOQ3Pt3NCvQ16P3pfnSlLkEnAeWeewwwIHsO59XBiTi/pxe+2Y14ObT9O5KBvgxxI5coaMa18q/M3BRn//OajPP2CHzapEoYdk05EjlHX60bb8ZEe9gliLFWX7oCyfDQWZuTwGl0LYVK8eG+1Jiyesa8RklotF8GFAvvbO10K2gO3fYmlPpPQ3aBBlGb+c2OmMXfoMeI2jZAEaKbKwanzGnZGqbQ1elIL7ylQknIqeSjljNR2o1kV9f8cVuANphVvBJA5JbUld2JOzbc6rG599LbXwkHJ5WdBtsN5PxIrhGljEp1cQ+n3Up+9Px+sMBu7Oq9wGPbQioZbMSPIwOO6N6aTS5ev/C2eqM3i/5yqV0rWVB4qwb7ainaX8+g+aetV3Pn7NcGUA67I1
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sxc7IIHCfY/RRXcAS5B1D8rwe4DqkvZaWNMJeI5/11e3KapTwm9jvnhju3rtv0VDNDfpshDSSsJqZKUa0eQ8OrCw3Fs1tFKxbC0r2GAAsg4q5Djsm3NripOKywzU87Z0K4QkJiR4b9v4iqJeBWJgnp503MsItkCkHSSoMDbZVAw/xggP4V3vLzUP4vH1I60up1qMt3dhTxzNfOII7cSTunzcooL7BUsi187WoSg97672gNsJw2Xi7Xt+Svj0TfqePDuXppqyuG0GzAMvMmaVNS03elXkJzUt2476J2y/n1h1URhx7arYuSpmIeBlu+GZXDzTwMVttur+0crNotGUlw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8rjb13eHhBXc6caKalpAjoK5jTuBOvmG75U8uY3TEE=;
 b=iqRmzcDF+TGuVn5lZ/st/St8WIdhQxNSpLnvJgdsP4HRYGvMp81ulImUkQBBMkuxoxI32Ey6yzUnwBJDgjaKwyVvnGA1Z5zn3Jrat5d+5cSjJjB1GjyluxGRgsyyfzAcQLEFE/UZCVNpsS1TzL292tNO5B6s9EzwWEv/6mDjJJAXwG/+3Oe3r3xXk4KPZivfJRBBoyFCpgkEJbuWYMD92aRKnAtpeLGQcqrliXW9rWze83uCU2+rA8s20ex3toOKZ7wP1xI37xuKkjTHbKSbEeWKJVxxprnW2QBbRY6zkjbuoLqUvvKC5sCbVq4y5z1gg7nrorfwlaurLNoxuHQ5Vg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8rjb13eHhBXc6caKalpAjoK5jTuBOvmG75U8uY3TEE=;
 b=d7GuQEbbKc30r4SXSen9xe9vrr0THUHDyWRerZnp894C9g6cAfuLLVy25HfMkwP+s5ciusX3bOc/7HoBDfkLmz9ASGp9ZtVOD50sFF7/lRIwKQdUPErtN21Ybt12z3xUSNosTrnZcfYld15wWkt+ooLOUsHS+/0jDmKMo3EhtWQ=
x-ms-exchange-crosstenant-network-message-id: 3747e57a-2a54-4376-7e42-08d76d150d33
x-ms-exchange-crosstenant-originalarrivaltime: 19 Nov 2019 17:22:27.7015 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 3urwGiWYQsjdSj0Dj7TfMSB9JA+k4L3ZA8SX/kuG2L0WASmO+Pboa3XOndL4Nz9tETY63Lcy9uJzzvLUPzYSsw==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4150
x-originatororg: quicinc.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.39
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

Thanks for all the feedback on the patch.  I'll summarize my TODO list here=
.  Please let me know if there's anything I missed.
- Add a README file in the imported directory to make it clear that the cod=
e comes from another project.  Personally, I prefer keeping the name as "im=
ported".  It was suggested by Richard at the meeting.  Also as a heads-up, =
that is a small subset of the files that will be in that directory eventual=
ly.  Right now, it is the minimum needed to build the skeleton target.
- Work on the .checkpatchignore as Philippe suggested.
- Split out the "[__SIGRTMAX - 1] =3D __SIGRTMIN + 1" into a separate patch=
.
- Clean up the long subject line.
- Add license text to the new files.
- Remove the DEBUG_HEX blocks.  In general the DEBUG_HEX macro controls a b=
unch of debugging output as you'll see in later patches.  In the long run, =
I think it should be replaces with a macro that is defined when configured =
with --enable-debug and then an additional command-line argument.  I haven'=
t looked into this, so any pointers would be appreciated.
- Laurent suggested I split the patch into two parts: linux-user and target=
/hexagon.  If I do that, which one should contain the changes to common fil=
es (e.g., configure)?  Also, note that we won't be able to build until both=
 patches are merged.  Is that OK?

Thanks,
Taylor


-----Original Message-----
From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
Sent: Tuesday, November 19, 2019 9:19 AM
To: Taylor Simpson <tsimpson@quicinc.com>; laurent@vivier.eu; riku.voipio@i=
ki.fi; qemu-devel@nongnu.org
Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of patc=
hes - linux-user changes + linux-user/hexagon + skeleton of target/hexagon =
- Files in target/hexagon/imported are from another project and therefore d=
o not conform to qemu coding standards

-------------------------------------------------------------------------
CAUTION: This email originated from outside of the organization.
-------------------------------------------------------------------------

On 11/19/19 12:58 AM, Taylor Simpson wrote:
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
[...]
>   target/hexagon/imported/global_types.h      |  25 +++
>   target/hexagon/imported/iss_ver_registers.h | 183 +++++++++++++++
>   target/hexagon/imported/max.h               |  78 +++++++
>   target/hexagon/imported/regs.h              |  19 ++

Maybe you can rename this directory as:

target/hexagon/dsp-sdk/

and add a README "Files under this directory are imported from the SDK avai=
lable once registered on developer.qualcomm.com ..."




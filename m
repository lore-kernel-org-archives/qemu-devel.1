Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF10C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 15:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42D812072A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 15:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Upwl17Um";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="WABAA8mW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D812072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAFL0-0002Hp-BZ
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 10:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1jAFKI-0001qa-Cv
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 10:55:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1jAFKE-0006bQ-56
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 10:55:50 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:12645)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1jAFKD-0006XI-KZ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 10:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1583510145; x=1615046145;
 h=from:to:subject:date:message-id:mime-version;
 bh=hwUCzpKJR5GXyK3CtsNjwAzxnh03JDm6dRdSNkmuJ+M=;
 b=Upwl17UmTERQvVGgapLzsiuPy2huIIuCjeHjvYhNsRWbaGRQmY+ZYaP6
 6zoh9/w/GoeCmK9TSplfsmrlB+FoxVz4efq5LaK/ruZLDEnJr8filwwoR
 gyZ/a7faxjqa9V8yXuZ6PqL6GoLexpWq3z/H6h6JdmD5ROqNSTOY4gxH1 Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Mar 2020 07:55:44 -0800
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 06 Mar 2020 07:55:44 -0800
Received: from apsanexr02f.ap.qualcomm.com (10.85.0.29) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 Mar 2020 07:55:43 -0800
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 apsanexr02f.ap.qualcomm.com (10.85.0.29) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 Mar 2020 07:55:41 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Fri, 6 Mar 2020 07:55:41 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB5448.namprd02.prod.outlook.com (2603:10b6:a03:9b::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Fri, 6 Mar
 2020 15:55:40 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62%6]) with mapi id 15.20.2772.019; Fri, 6 Mar 2020
 15:55:40 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: TCG global variable aliasing/optimization question
Thread-Topic: TCG global variable aliasing/optimization question
Thread-Index: AdXyYohg9CPIWUd0STSU4I62bJqiMg==
Date: Fri, 6 Mar 2020 15:55:40 +0000
Message-ID: <BYAPR02MB4886920CEE376F484A49BAEFDEE30@BYAPR02MB4886.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [216.30.21.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0b2dd18-157a-4559-03b6-08d7c1e6d1d3
x-ms-traffictypediagnostic: BYAPR02MB5448:
x-microsoft-antispam-prvs: <BYAPR02MB5448F6B528F9272FD77602FCDEE30@BYAPR02MB5448.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0334223192
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(39860400002)(366004)(136003)(396003)(189003)(199004)(6506007)(81156014)(8936002)(81166006)(7696005)(8676002)(316002)(26005)(186003)(6916009)(86362001)(2906002)(66446008)(66476007)(5660300002)(64756008)(66556008)(66946007)(52536014)(9686003)(55016002)(33656002)(76116006)(478600001)(71200400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB5448;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fv9NKRhPTGcMWa1fb7LoUDBctfAgj8mgzRVPFDfp+owmuV9tloCX0ryCkr17EJ3TPz1Ymj86rJNe8E029hgf1XGheeqe5uq3RtC8uWG0tndRaOC9Cnj6yMECbL7/3oNA84XJnwsKl419oAckkl+SpWYRAO/JwbDalz5bN/I4w2XcwySzoqvgvGgZGyLNBnLq8Hx80/kl9o2f2o5XxsdT3oqhuCy5bODp/e/q6Te7+gZwNJg2ePlPyIuOkZJw2jPQJUoKzwHooFMKrq7QJOYRqDAshvoRbhx5+SQ1UKD6GC+l1IF6I0pUBaBQWNEvu9JlYnzVIvXrr7lxEXZcohRpcoW+7Uh5IGF0yxIN1Bt3EjIdPyAjC0q+szjyZcE2M6YA6029V/spj6QhflFTY/yu5xScvl4GBPDQAWF/Io00DxmwLQYTklqsRaeEsEACOM83
x-ms-exchange-antispam-messagedata: Ye6faxtLFeEy+7VurmnhKKEim0cu32eR4EZNqJ5U+O+bxZN4PTN642uQwLwgY59avllJeN7rJza2sdWuAzOnwBr+obDtKYATW8ClJ97rm4HoPJBnvrUBFfcQKcbD5qpNO6kV1TI4CTUwwAwuyDXe+g==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCJA/8GIVwJgArT9NIP+xQd84sLg6nlTL+pq4TRknId4hazSj4xqx64wvaLMZDpvKELqBX/SZbMrx8aH+IXPNwRAC3zn/lvdZ8RZ9HK9AVehQzgW9R3kt919JAatQexkXEUfhDM2jtE5NHnia8ZWdty/Ql5B6T2/86O8URG8eAIKfNAeKTqBPhTa47kactDDpvFtc3eS9+4LJLMTpAY3q7viaElz434v5wzMyR3ZwFprHEWHdslfKPIJMjwy/9zX+YTWeEaQTKz6MXDaFIRsR7K4/L9stQAIcy7NPzAe0T5TcfQNnyfSXSsUOujlR9wt+KMNitHRn9Kqc8IAWf2dZw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6OzGek46Lc3CTJGiEtnRKSiz67QxIYecQbKRijXFrc=;
 b=KcIuuRiszZR3fb4B57KXaA7xZUxmQZtoOiGbHkJbZR0egw+9zxoEer4OVh4+Z3eBHwbPPSws0vH/xECVz7LnYaoBRdLcAGYRdY4vAkmyLOh7Tkh++K/S8b2C2CWCitu4akLwbx8EwgBoP8rxP+g2TYhYDVawOoxrontKG8QU/VxSiBf9D8+QC45y6xWOqIwBUJUZ0JXefg+8FR7NnenRhfKkUnfx6SpWoj7744ktZAuCJRcfMqKo3MlwuBSihav7uGm65Jg8tzPV4s7q+8tWfSnv28s28dqb4hS6K1c6RUsH/jKSLlSOr2czHglps+JRFcR38L0f+fe4DpOZOq4dbg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6OzGek46Lc3CTJGiEtnRKSiz67QxIYecQbKRijXFrc=;
 b=WABAA8mWT5Wj0phfGvv9TjS38UjiMgyOLiGDOv+S9fEX577/lowHAzxMDBX5QSnqd3It/nPgQtVuxdk/qJ4kAGbjiT0kOj21oKkf17hjCS2dUswuFzv/gN5cP2V5YB4pBTlTwZ6j6KYeKgJ1oqT9eH2sZ/XboWp33tI1/mKT/Vw=
x-ms-exchange-crosstenant-network-message-id: f0b2dd18-157a-4559-03b6-08d7c1e6d1d3
x-ms-exchange-crosstenant-originalarrivaltime: 06 Mar 2020 15:55:40.2141 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: +0AtGfPSHv0Y2JAlDs8BYe8vk8vqDnuBhK1ZhbmjZbNKcKaA0Ydwvpvf5CcmOE2v3OJInkDhuW8vIHxnTF2Y7w==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5448
Content-Type: multipart/alternative;
 boundary="_000_BYAPR02MB4886920CEE376F484A49BAEFDEE30BYAPR02MB4886namp_"
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
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

--_000_BYAPR02MB4886920CEE376F484A49BAEFDEE30BYAPR02MB4886namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Does the TCG optimizer assume all global variables are unique?  If so, is t=
here a method to indicate that two global variables alias?

Background:
I am improving the way we handle register pairs for Hexagon.  The original =
implementation would read from the individual 32-bit registers and concat t=
o form the 64-bit value
tcg_gen_concat_i32_i64(val64, hex_gpr[NUM], hex_gpr[(NUM) + 1]);
Similarly, a write would break apart the 64-bit value into two parts and st=
ore them individually
/* Low word */
tcg_gen_extrl_i64_i32(val32, val64);
tcg_gen_mov_tl(hex_gpr[rnum], val32);
/* High word */
tcg_gen_extrh_i64_i32(val32, val64);
tcg_gen_mov_tl(hex_grp[rnum + 1], val32);

I'm hoping to get more efficient code by creating an array of global i64 va=
riables that overlap the i32 single registers.
for (i =3D 0; i < TOTAL_PER_THREAD_REGS; i++) {
    hex_gpr[i] =3D tcg_global_mem_new(cpu_env,
        offsetof(CPUHexagonState, gpr[i]), hexagon_regnames[i]);
}
for (i =3D 0; i < TOTAL_PER_THREAD_REGS/2; i++) {
    hex_gpr_pairs[i] =3D tcg_global_mem_new_i64(cpu_env,
       offsetof(CPUHexagonState, gpr[2 * i]), hexagon_pairnames[i]);
}
So, a read would be
                tcg_gen_mov_i64(val64, hex_gpr_pairs[NUM/2]);
and a write would be
                tcg_gen_mov_i64(hex_gpr_pairs[NUM/2], val64);

Unfortunately, it seems TCG is optimizing with the assumption that globals =
don't overlap.  Here's an example
                {
                    r4 =3D ##0x11111111
                    r5 =3D ##0x22222222
                }
                {
                    p1 =3D cmp.eq(r3:2,r5:4)
                    r4 =3D r17
                    jump 1f
                }
Here is the TCG
---- 00400094
movi_i32 pc,$0x400094
movi_i32 slot_cancelled,$0x0
movi_i32 pred_written,$0x0
movi_i32 loc2,$0x11111111
mov_i32 new_r4,loc2
movi_i32 loc2,$0x22222222
mov_i32 new_r5,loc2
mov_i32 r4,new_r4                                                        /*=
 Assignment to r4 value is 0x11111111 */
mov_i32 r5,new_r5                                                        /*=
 Assignment to r5 value is 0x22222222 */
movi_i32 tmp0,$0x1
add_i32 pkt_cnt,pkt_cnt,tmp0
movi_i32 tmp0,$0x2
add_i32 insn_cnt,insn_cnt,tmp0
---- 004000a4
movi_i32 pc,$0x4000a4
movi_i32 slot_cancelled,$0x0
movi_i32 branch_taken,$0x0
movi_i32 next_PC,$0x4000ac
movi_i32 pred_written,$0x0
mov_i64 loc3,r3:2
mov_i64 loc4,r5:4                                                          =
  /* Read from register pair r5:4 */
movi_i64 tmp5,$0xff
movi_i64 tmp6,$0x0
movcond_i64 tmp7,loc3,loc4,tmp5,tmp6,eq
extrl_i64_i32 loc2,tmp7
ext8u_i32 loc2,loc2
movi_i32 tmp0,$0x0
ext8u_i32 tmp1,loc2
and_i32 tmp8,tmp1,new_pred_p1
movi_i32 tmp10,$0x2
and_i32 tmp9,pred_written,tmp10
movcond_i32 new_pred_p1,tmp9,tmp0,tmp8,tmp1,ne
movi_i32 tmp10,$0x2
or_i32 pred_written,pred_written,tmp10
mov_i32 loc2,r17
movi_i32 tmp1,$0x8
add_i32 tmp0,pc,tmp1
movi_i32 tmp1,$0x0
movcond_i32 next_PC,branch_taken,tmp1,next_PC,tmp0,ne
movi_i32 branch_taken,$0x1
mov_i32 new_r4,loc2
mov_i32 r4,new_r4                                                        /*=
 Assignment to r4 from r17 */
movi_i32 tmp0,$0x0
mov_i32 p1,new_pred_p1
mov_i32 pc,next_PC
movi_i32 tmp0,$0x1
add_i32 pkt_cnt,pkt_cnt,tmp0
movi_i32 tmp0,$0x2
add_i32 insn_cnt,insn_cnt,tmp0
exit_tb $0x0
set_label $L0
exit_tb $0x55bb47db6043

Here is the generated x86 code.
OUT: [size=3D186]
0x55bb47db6100:  mov    -0x8(%rbp),%ebx
0x55bb47db6103:  test   %ebx,%ebx
0x55bb47db6105:  jl     0x55bb47db61ae
0x55bb47db610b:  mov    $0x22222222,%ebx
0x55bb47db6110:  mov    %ebx,0x138(%rbp)
0x55bb47db6116:  mov    %ebx,0x14(%rbp)
0x55bb47db6119:  mov    0xd0(%rbp),%ebx
0x55bb47db611f:  inc    %ebx
0x55bb47db6121:  mov    0xd4(%rbp),%r12d
0x55bb47db6128:  add    $0x2,%r12d
0x55bb47db612c:  movl   $0x0,0x120(%rbp)
0x55bb47db6136:  mov    0x8(%rbp),%r13
0x55bb47db613a:  mov    0x10(%rbp),%r14
0x55bb47db613e:  mov    $0xff,%r15d
0x55bb47db6144:  xor    %r10d,%r10d
0x55bb47db6147:  cmp    %r14,%r13
0x55bb47db614a:  cmove  %r15,%r10
0x55bb47db614e:  mov    %r10d,%r13d
0x55bb47db6151:  mov    %r13d,0x32c(%rbp)
0x55bb47db6158:  movl   $0x2,0x338(%rbp)
0x55bb47db6162:  mov    $0x4000ac,%r14d
0x55bb47db6168:  mov    %r14d,0x114(%rbp)
0x55bb47db616f:  movl   $0x1,0x110(%rbp)
0x55bb47db6179:  mov    0x44(%rbp),%r15d
0x55bb47db617d:  mov    %r15d,0x134(%rbp)
0x55bb47db6184:  mov    %r15d,0x10(%rbp)
0x55bb47db6188:  mov    %r13d,0x104(%rbp)
0x55bb47db618f:  mov    %r14d,0xa4(%rbp)
0x55bb47db6196:  inc    %ebx
0x55bb47db6198:  mov    %ebx,0xd0(%rbp)
0x55bb47db619e:  lea    0x2(%r12),%ebx
0x55bb47db61a3:  mov    %ebx,0xd4(%rbp)
0x55bb47db61a9:  jmpq   0x55bb47db6016
0x55bb47db61ae:  lea    -0x172(%rip),%rax        # 0x55bb47db6043
0x55bb47db61b5:  jmpq   0x55bb47db6018
The first assignment to r4 with 0x11111111 has been removed.  I guess this =
is because the second assignment makes it look dead, but it is NOT dead bec=
ause the read from r5:4 accesses the value.

Thanks,
Taylor


--_000_BYAPR02MB4886920CEE376F484A49BAEFDEE30BYAPR02MB4886namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Does the TCG optimizer assume all global variables a=
re unique?&nbsp; If so, is there a method to indicate that two global varia=
bles alias?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Background:<o:p></o:p></p>
<p class=3D"MsoNormal">I am improving the way we handle register pairs for =
Hexagon.&nbsp; The original implementation would read from the individual 3=
2-bit registers and concat to form the 64-bit value<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">tcg_gen_concat_i32_i64(va=
l64, hex_gpr[NUM], hex_gpr[(NUM) &#43; 1]);<o:p></o:p></p>
<p class=3D"MsoNormal">Similarly, a write would break apart the 64-bit valu=
e into two parts and store them individually<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">/* Low word */<o:p></o:p>=
</p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">tcg_gen_extrl_i64_i32(val=
32, val64);<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">tcg_gen_mov_tl(hex_gpr[rn=
um], val32);<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">/* High word */<o:p></o:p=
></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">tcg_gen_extrh_i64_i32(val=
32, val64);<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">tcg_gen_mov_tl(hex_grp[rn=
um &#43; 1], val32);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;m hoping to get more efficient code by creat=
ing an array of global i64 variables that overlap the i32 single registers.=
<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">for (i =3D 0; i &lt; TOTA=
L_PER_THREAD_REGS; i&#43;&#43;) {<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">&nbsp;&nbsp;&nbsp; hex_gp=
r[i] =3D tcg_global_mem_new(cpu_env,<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; offsetof(CPUHexagonState, gpr[i]), hexagon_regnames[i]);<=
o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">}<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">for (i =3D 0; i &lt; TOTA=
L_PER_THREAD_REGS/2; i&#43;&#43;) {<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">&nbsp;&nbsp;&nbsp; hex_gp=
r_pairs[i] =3D tcg_global_mem_new_i64(cpu_env,<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;offsetof(CPUHexagonState, gpr[2 * i]), hexagon_pairnames[i=
]);<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">}<o:p></o:p></p>
<p class=3D"MsoNormal">So, a read would be<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tcg_gen_mov_i64(val64, hex_gpr_pairs=
[NUM/2]);<o:p></o:p></p>
<p class=3D"MsoNormal">and a write would be<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tcg_gen_mov_i64(hex_gpr_pairs[NUM/2]=
, val64);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Unfortunately, it seems TCG is optimizing with the a=
ssumption that globals don&#8217;t overlap.&nbsp; Here&#8217;s an example<o=
:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; r4 =3D ##0x111111=
11<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; r5 =3D ##0x222222=
22<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; p1 =3D cmp.eq(r3:=
2,r5:4)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; r4 =3D r17<o:p></=
o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; jump 1f<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <o:p></o:p></p>
<p class=3D"MsoNormal">Here is the TCG<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">---- 00400094<o:p></o:p><=
/p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movi_i32 pc,$0x400094<o:p=
></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movi_i32 slot_cancelled,$=
0x0<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movi_i32 pred_written,$0x=
0<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movi_i32 loc2,$0x11111111=
<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">mov_i32 new_r4,loc2<o:p><=
/o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movi_i32 loc2,$0x22222222=
<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">mov_i32 new_r5,loc2<o:p><=
/o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">mov_i32 r4,new_r4&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /* Assignment to r4 value is 0x11111111 */<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">mov_i32 r5,new_r5&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; /* Assignment to r5 value is 0x22222222 */<o:p></o:p=
></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movi_i32 tmp0,$0x1<o:p></=
o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">add_i32 pkt_cnt,pkt_cnt,t=
mp0<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movi_i32 tmp0,$0x2<o:p></=
o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">add_i32 insn_cnt,insn_cnt=
,tmp0<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">---- 004000a4<o:p></o:p><=
/p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movi_i32 pc,$0x4000a4<o:p=
></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movi_i32 slot_cancelled,$=
0x0<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movi_i32 branch_taken,$0x=
0<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movi_i32 next_PC,$0x4000a=
c<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movi_i32 pred_written,$0x=
0<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">mov_i64 loc3,r3:2<o:p></o=
:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">mov_i64 loc4,r5:4&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Read from register pair r=
5:4 */<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movi_i64 tmp5,$0xff<o:p><=
/o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movi_i64 tmp6,$0x0<o:p></=
o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movcond_i64 tmp7,loc3,loc=
4,tmp5,tmp6,eq<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">extrl_i64_i32 loc2,tmp7<o=
:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">ext8u_i32 loc2,loc2<o:p><=
/o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movi_i32 tmp0,$0x0<o:p></=
o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">ext8u_i32 tmp1,loc2<o:p><=
/o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">and_i32 tmp8,tmp1,new_pre=
d_p1<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movi_i32 tmp10,$0x2<o:p><=
/o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">and_i32 tmp9,pred_written=
,tmp10<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movcond_i32 new_pred_p1,t=
mp9,tmp0,tmp8,tmp1,ne<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movi_i32 tmp10,$0x2<o:p><=
/o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">or_i32 pred_written,pred_=
written,tmp10<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">mov_i32 loc2,r17<o:p></o:=
p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movi_i32 tmp1,$0x8<o:p></=
o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">add_i32 tmp0,pc,tmp1<o:p>=
</o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movi_i32 tmp1,$0x0<o:p></=
o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movcond_i32 next_PC,branc=
h_taken,tmp1,next_PC,tmp0,ne<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movi_i32 branch_taken,$0x=
1<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">mov_i32 new_r4,loc2<o:p><=
/o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">mov_i32 r4,new_r4&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; /* Assignment to r4 from r17 */<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movi_i32 tmp0,$0x0<o:p></=
o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">mov_i32 p1,new_pred_p1<o:=
p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">mov_i32 pc,next_PC<o:p></=
o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movi_i32 tmp0,$0x1<o:p></=
o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">add_i32 pkt_cnt,pkt_cnt,t=
mp0<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">movi_i32 tmp0,$0x2<o:p></=
o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">add_i32 insn_cnt,insn_cnt=
,tmp0<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">exit_tb $0x0<o:p></o:p></=
p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">set_label $L0<o:p></o:p><=
/p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">exit_tb $0x55bb47db6043<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Here is the generated x86 code.<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">OUT: [size=3D186]<o:p></o=
:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db6100:&nbsp; mov=
&nbsp;&nbsp;&nbsp; -0x8(%rbp),%ebx<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db6103:&nbsp; tes=
t&nbsp;&nbsp; %ebx,%ebx<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db6105:&nbsp; jl&=
nbsp;&nbsp;&nbsp;&nbsp; 0x55bb47db61ae<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db610b:&nbsp; mov=
&nbsp;&nbsp;&nbsp; $0x22222222,%ebx<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db6110:&nbsp; mov=
&nbsp;&nbsp;&nbsp; %ebx,0x138(%rbp)<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db6116:&nbsp; mov=
&nbsp;&nbsp;&nbsp; %ebx,0x14(%rbp)<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db6119:&nbsp; mov=
&nbsp; &nbsp;&nbsp;0xd0(%rbp),%ebx<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db611f:&nbsp; inc=
&nbsp;&nbsp;&nbsp; %ebx<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db6121:&nbsp; mov=
&nbsp;&nbsp;&nbsp; 0xd4(%rbp),%r12d<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db6128:&nbsp; add=
&nbsp;&nbsp;&nbsp; $0x2,%r12d<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db612c:&nbsp; mov=
l&nbsp;&nbsp; $0x0,0x120(%rbp)<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db6136:&nbsp; mov=
&nbsp;&nbsp;&nbsp; 0x8(%rbp),%r13<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db613a:&nbsp; mov=
&nbsp;&nbsp;&nbsp; 0x10(%rbp),%r14<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db613e:&nbsp; mov=
&nbsp;&nbsp;&nbsp; $0xff,%r15d<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db6144:&nbsp; xor=
&nbsp;&nbsp;&nbsp; %r10d,%r10d<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db6147:&nbsp; cmp=
&nbsp;&nbsp;&nbsp; %r14,%r13<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db614a:&nbsp; cmo=
ve&nbsp; %r15,%r10<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db614e:&nbsp; mov=
&nbsp;&nbsp;&nbsp; %r10d,%r13d<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db6151:&nbsp; mov=
&nbsp;&nbsp;&nbsp; %r13d,0x32c(%rbp)<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db6158:&nbsp; mov=
l&nbsp;&nbsp; $0x2,0x338(%rbp)<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db6162:&nbsp; mov=
&nbsp;&nbsp;&nbsp; $0x4000ac,%r14d<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db6168:&nbsp; mov=
&nbsp;&nbsp;&nbsp; %r14d,0x114(%rbp)<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db616f:&nbsp; mov=
l&nbsp;&nbsp; $0x1,0x110(%rbp)<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db6179:&nbsp; mov=
&nbsp;&nbsp;&nbsp; 0x44(%rbp),%r15d<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db617d:&nbsp; mov=
&nbsp;&nbsp;&nbsp; %r15d,0x134(%rbp)<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db6184:&nbsp; mov=
&nbsp;&nbsp;&nbsp; %r15d,0x10(%rbp)<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db6188:&nbsp; mov=
&nbsp;&nbsp;&nbsp; %r13d,0x104(%rbp)<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db618f:&nbsp; mov=
&nbsp;&nbsp;&nbsp; %r14d,0xa4(%rbp)<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db6196:&nbsp; inc=
&nbsp;&nbsp;&nbsp; %ebx<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db6198:&nbsp; mov=
&nbsp;&nbsp;&nbsp; %ebx,0xd0(%rbp)<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db619e:&nbsp; lea=
&nbsp;&nbsp;&nbsp; 0x2(%r12),%ebx<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db61a3:&nbsp; mov=
&nbsp;&nbsp;&nbsp; %ebx,0xd4(%rbp)<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db61a9:&nbsp; jmp=
q&nbsp;&nbsp; 0x55bb47db6016<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db61ae:&nbsp; lea=
&nbsp;&nbsp;&nbsp; -0x172(%rip),%rax&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; # 0x55bb47db6043<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">0x55bb47db61b5:&nbsp; jmp=
q&nbsp;&nbsp; 0x55bb47db6018<o:p></o:p></p>
<p class=3D"MsoNormal">The first assignment to r4 with 0x11111111 has been =
removed.&nbsp; I guess this is because the second assignment makes it look =
dead, but it is NOT dead because the read from r5:4 accesses the value.<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Taylor<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BYAPR02MB4886920CEE376F484A49BAEFDEE30BYAPR02MB4886namp_--


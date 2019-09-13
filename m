Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B11AC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7320C20693
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7320C20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8mvX-000384-EF
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 10:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pc@us.ibm.com>) id 1i8muT-00027f-0e
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pc@us.ibm.com>) id 1i8muP-0000lk-Qp
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:50:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pc@us.ibm.com>) id 1i8muP-0000lF-Jg
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:50:49 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8DEl3Ud042014; Fri, 13 Sep 2019 10:50:44 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v0c3mb248-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2019 10:50:43 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8DEmB1e001870;
 Fri, 13 Sep 2019 14:50:42 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma03wdc.us.ibm.com with ESMTP id 2uytdx7kba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2019 14:50:42 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8DEoes255181808
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2019 14:50:40 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2DEA6E05B;
 Fri, 13 Sep 2019 14:50:39 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 389196E052;
 Fri, 13 Sep 2019 14:50:39 +0000 (GMT)
Received: from oc3272150783.ibm.com (unknown [9.160.39.69])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Fri, 13 Sep 2019 14:50:38 +0000 (GMT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190913134935.29696-1-alex.bennee@linaro.org>
From: Paul Clarke <pc@us.ibm.com>
Message-ID: <70173025-eef0-ff89-3c8f-517397ca42f3@us.ibm.com>
Date: Fri, 13 Sep 2019 09:50:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913134935.29696-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-13_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=898 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909130148
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x8DEl3Ud042014
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH] tests/tcg: add float_madds test to
 multiarch
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
Cc: 1841592@bugs.launchpad.net, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/13/19 8:49 AM, Alex Benn=C3=A9e wrote:
> +static float f32_numbers[] =3D {
> +    -SNANF,
> +    -NAN,
> +    -INFINITY,
> +    -FLT_MAX,
> +    -1.111E+31,
> +    -1.111E+30,
> +    -1.08700982e-12,
> +    -1.78051176e-20,
> +    -FLT_MIN,
> +    0.0,
> +    FLT_MIN,
> +    2.98023224e-08,
> +    5.96046E-8, /* min positive FP16 subnormal */
> +    6.09756E-5, /* max subnormal FP16 */
> +    6.10352E-5, /* min positive normal FP16 */
> +    1.0,
> +    1.0009765625, /* smallest float after 1.0 FP16 */
> +    2.0,
> +    M_E, M_PI,
> +    65503.0,
> +    65504.0, /* max FP16 */
> +    65505.0,
> +    131007.0,
> +    131008.0, /* max AFP */
> +    131009.0,
> +    1.111E+30,
> +    FLT_MAX,
> +    INFINITY,
> +    NAN,
> +    SNANF
> +};

I've noticed that Glibc prefers to use hex representation for float value=
s, to ensure an accurate representation.  If you care to do so, here they=
 are:
static float f32_numbers[] =3D {
    -SNANF,=20
    -NAN,  =20
    -INFINITY,
    -FLT_MAX,
    -0x1.1874b2p+103,
    -0x1.c0bab6p+99,
    -0x1.31f75p-40,
    -0x1.505444p-66,
    -FLT_MIN,
    0.0,   =20
    FLT_MIN,
    0x1p-25,
    0x1.ffffe6p-25, /* min positive FP16 subnormal */
    0x1.ff801ap-15, /* max subnormal FP16 */
    0x1.00000cp-14, /* min positive normal FP16 */
    1.0,   =20
    0x1.004p+0, /* smallest float after 1.0 FP16 */
    2.0,   =20
    M_E, M_PI,
    0x1.ffbep+15,
    0x1.ffcp+15, /* max FP16 */
    0x1.ffc2p+15,
    0x1.ffbfp+16,
    0x1.ffcp+16, /* max AFP */
    0x1.ffc1p+16,
    0x1.c0bab6p+99,
    FLT_MAX,
    INFINITY,
    NAN,   =20
    SNANF  =20
};

PC


Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3ABC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 23:17:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7BFD218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 23:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="cuR7lAA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7BFD218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=me.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSq1t-00087t-NQ
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 19:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thorpej@me.com>) id 1kSq12-0007hc-7o
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 19:17:04 -0400
Received: from pv34p98im-ztdg02172101.me.com ([17.143.234.142]:55224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thorpej@me.com>) id 1kSq10-0007Ja-OT
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 19:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1602717419; bh=/s+Xs4wfbiKORcvLon3aTWCq5ErwPkxM/3g0OGU58iU=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 b=cuR7lAA2ujwDaCJILo8NVl4eqavkib1MEy7SSlrzSzhrRiBWlXR2ApfEdWHfteJS7
 +4Jo/Mt/dtXk0VZOTZcbc5nLM5c1Sp5451GPGPIpA0UtU5fY/wVuEiIbho6MtexA57
 +GxmgcxTXYXVvIS3g7AqJdvLDnLQdagTfVCeMwfyf6x51cL0r9l1Lk505UVn30hCeN
 e6XqC1wsfAkKI9umSrQqKVdD4UDnb8s22mDmxLOZn0khFiGaZItI9nGAXtYExgQA/3
 OJsrHZQwelvjKyb4zK8RC1dMMl863ZANm7J/0rGy7ipuB4lskcXwpLP8Ey3lVCeCvq
 ZxQTSCAMcR7wg==
Received: from [17.232.161.240] (unknown [17.232.161.240])
 by pv34p98im-ztdg02172101.me.com (Postfix) with ESMTPSA id 1EAA554022C;
 Wed, 14 Oct 2020 23:16:59 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] qemu-palcode: Changes to support booting NetBSD/alpha
From: Jason Thorpe <thorpej@me.com>
In-Reply-To: <c35e151d-7b9c-849f-e4a0-a9c62d9a31a1@linaro.org>
Date: Wed, 14 Oct 2020 16:16:48 -0700
Cc: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6896C79F-8A9B-4EFC-BC68-EE8856EFD2B6@me.com>
References: <20201007025229.7487-1-thorpej@me.com>
 <c35e151d-7b9c-849f-e4a0-a9c62d9a31a1@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-14_12:2020-10-14,
 2020-10-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2010140161
Received-SPF: pass client-ip=17.143.234.142; envelope-from=thorpej@me.com;
 helo=pv34p98im-ztdg02172101.me.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 19:16:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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


> On Oct 14, 2020, at 2:52 PM, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> I'm certainly open to these changes.  But it'll need to be split up -- =
one
> patch per bullet, basically.

That's fine.  What's the convention for patches that stack on top of one =
another?

-- thorpej



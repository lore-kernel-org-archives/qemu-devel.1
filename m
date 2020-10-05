Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A179FC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07FED20774
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FED20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPQhD-0004KM-3t
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 09:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1kPQgC-0002w7-AN
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:37:29 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:31587)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1kPQg3-0006QP-PE
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:37:27 -0400
IronPort-SDR: 1HEXG3P0HF7XVUM+s2rDq4cAHsXk2asTeuHsTQHai2Fx/joGzNsEXwTTIOEtyfEKS/NFd7na2P
 ARG6/NUpOQwok88VJ9rD97eVPv09Kij2jZidweMvKcsQoJ/N/KsiCRtMIdUIU1fLv9CerSWyG3
 REvqgDjQgUJ/Zb+cG2W90mJO4feBoh4bGisThgm3xaqRUk/dBl0zbCChd8W2XftwuXvSm/ieJk
 ST+e7M73U5lqneGgj3njuUqIGuEwiZN9wscu0ReKZQE+kc6GQYLfDnBPjSMU0hxsfqwfZiSy40
 Buk=
X-IronPort-AV: E=Sophos;i="5.77,338,1596528000"; d="scan'208";a="53560603"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa3.mentor.iphmx.com with ESMTP; 05 Oct 2020 05:37:13 -0800
IronPort-SDR: 8TURLqozpKq5NH2mMdn38NIDMqd6UxRZvvjEuXqJtm1Me18SQ28ajZLy9rMM7y/95Zu8ETw/Xa
 NAOUnolUherBt7tguFzyuAs/F75v46ZslvxDwZVTNvsZIJ30mMWm/bjR1CmG2yiDgxtRNw3aCN
 CGhJ6CidcXCnHfM2mBAhkWUivbr1ow3ojqTLjg/Le7gfd32rjdVVtrUdnWM3RZMtqJOfGRROit
 DbPJ5aWtW/dQvnIubakpo6Q+fkKUYqCbGpsiQW9qtwuUEHoXKJ6QC24CnzkOZXamF4+RatYveG
 KOo=
Date: Mon, 5 Oct 2020 13:37:07 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH 08/21] contrib/gitdm: Add Mentor Graphics to the
 domain map
In-Reply-To: <20201004180443.2035359-9-f4bug@amsat.org>
Message-ID: <alpine.DEB.2.21.2010051327090.312@digraph.polyomino.org.uk>
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-9-f4bug@amsat.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="-1152306461-1982663207-1601905027=:312"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-08.mgc.mentorg.com (139.181.222.8) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.137.180;
 envelope-from=joseph_myers@mentor.com; helo=esa3.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 09:37:13
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kwok Cheung Yeung <kcy@codesourcery.com>,
 Andrew Jenner <andrew@codesourcery.com>, qemu-devel@nongnu.org,
 Julian Brown <julian@codesourcery.com>,
 Sandra Loosemore <sandra@codesourcery.com>,
 Taimoor Mirza <tmirza@codesourcery.com>,
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 Thomas Schwinge <thomas@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

---1152306461-1982663207-1601905027=:312
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT

On Sun, 4 Oct 2020, Philippe Mathieu-Daudé wrote:

> There is a number of contributors from this domain,
> add its own entry to the gitdm domain map.

At some point the main branding will be Siemens; not sure how you want to 
handle that.

-- 
Joseph S. Myers
joseph@codesourcery.com
---1152306461-1982663207-1601905027=:312--


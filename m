Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B8EC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D42AF2078E
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42AF2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPXVF-0003Xw-Qi
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 16:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1kPXTo-0001l6-Pq
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 16:53:08 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:33808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1kPXTl-0005qr-3P
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 16:53:07 -0400
IronPort-SDR: Fu/t0yPZ3xJ3WQ/IPbc3/PDf0X/D2RDbI098g0+T7EJsSJBRvoKeC8IX+MIFoyuyae8G7fLj6v
 cPQX1TmpVFUw32eIY9JyuO1p1+MuXahIE//xc1SubbkturkDbd8+c1N8VALEft4Jjuj89Cm1U5
 0/4XxG7iz/1dvsqcaBNOyekQdemCo9P6JrW97LEyM6P8KmXsVEE4Ud5gzSyO6YSeqfJ0wPuDKh
 YgX9dVlXWY4XLRwE1s93AJXQdGNFKQIBY23neU6zVi+j3LaBKphbse4InHi2GYIN1Hc8pDS8L+
 4oA=
X-IronPort-AV: E=Sophos;i="5.77,340,1596528000"; d="scan'208";a="55847254"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa1.mentor.iphmx.com with ESMTP; 05 Oct 2020 12:53:01 -0800
IronPort-SDR: N45VDAZv4rkLXzOKL0ENJdhjMU4Ef0lxLOSVMIxO9JvfpNIychGdBIMAuEz/VYMMbZ4GBv4+b4
 0VsMy7z28xML1psivTIdoBWz1yB64tV8a5Tqy/SiJXwOeFuQF8JSd8S0RIeDaoDDkPO8OeZXBO
 RTW7qcTPFLjGo7tZ18+U3vlb4lqyzD8VBR/9XG2WryOYS2se5czzBd9jR5/1/1lX7wBxHm4Qix
 QhWzIHI5/XjvEEuFLM+DeksFNoZLVzo/IBeSt5ZuzUZxEx6d38muQuNMkuh06EjfdDKuxuVnGN
 laY=
Date: Mon, 5 Oct 2020 20:52:56 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH 08/21] contrib/gitdm: Add Mentor Graphics to the
 domain map
In-Reply-To: <87eemc3b1q.fsf@linaro.org>
Message-ID: <alpine.DEB.2.21.2010052047250.11145@digraph.polyomino.org.uk>
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-9-f4bug@amsat.org>
 <alpine.DEB.2.21.2010051327090.312@digraph.polyomino.org.uk>
 <87eemc3b1q.fsf@linaro.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="-1152306461-1321629755-1601931176=:11145"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.129.153;
 envelope-from=joseph_myers@mentor.com; helo=esa1.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 16:53:02
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
 Andrew Jenner <andrew@codesourcery.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Julian Brown <julian@codesourcery.com>,
 Sandra Loosemore <sandra@codesourcery.com>,
 Taimoor Mirza <tmirza@codesourcery.com>,
 Thomas Schwinge <thomas@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

---1152306461-1321629755-1601931176=:11145
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT

On Mon, 5 Oct 2020, Alex Bennée wrote:

> Joseph Myers <joseph@codesourcery.com> writes:
> 
> > On Sun, 4 Oct 2020, Philippe Mathieu-Daudé wrote:
> >
> >> There is a number of contributors from this domain,
> >> add its own entry to the gitdm domain map.
> >
> > At some point the main branding will be Siemens; not sure how you want to 
> > handle that.
> 
> We've already done something similar with WaveComp who have rolled up
> the various mips and imgtec contributions into
> contrib/gitdm/group-map-wavecomp.
> 
> It's really up to you and which corporate entity would like internet
> bragging points. The only Siemens contributor I could find is Jan Kiszka
> but he has contributed a fair amount ;-)

Given that the Mentor branding is going away (and the "Mentor Graphics" 
version largely has gone away, "Mentor, a Siemens Business" is what's 
currently used as a Mentor brand), probably it makes sense to use Siemens 
for both codesourcery.com and mentor.com addresses.

-- 
Joseph S. Myers
joseph@codesourcery.com
---1152306461-1321629755-1601931176=:11145--


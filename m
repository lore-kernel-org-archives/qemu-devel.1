Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876F1C4BA18
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E8E206E6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="cQv6tdLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E8E206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j70Jy-0004uy-F8
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 12:18:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1j70GJ-0003aR-7p
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:14:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1j70GI-0006E6-AP
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:14:19 -0500
Received: from mout.web.de ([212.227.15.4]:37721)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1j70GH-00068o-To
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1582737255;
 bh=S4eKO3IabwH0N2dgkztplZg0cCGDL97f41otnfAXuQo=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=cQv6tdLlV9Mk5ZTdXYifOZgFxrjhIJ3eDGzRGQTETdnX3PoPJtfShk/OB1yUMVfSO
 yoM4f5jL3mk0bmF2oXhFPWnJujO20tb588KYJaPR8c9b+9FNSihBSnF3PgpfkEHttV
 Azr6vDrbAEcG74AQLZujrj+6Nd1jwFET5SFkA5ko=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.40]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LwZA7-1jTk4X3FaZ-018MF3; Wed, 26
 Feb 2020 18:14:14 +0100
Date: Wed, 26 Feb 2020 18:14:14 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Jing-Wei Su <jwsu1986@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] Update Documentation
Message-ID: <20200226181414.792a224f@luklap>
In-Reply-To: <CAFKS8hWLhXNnVgRsADhrG+N0grgS_-C9bAfC8-oU0spbyy=vVQ@mail.gmail.com>
References: <CAFKS8hWLhXNnVgRsADhrG+N0grgS_-C9bAfC8-oU0spbyy=vVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pHKPVL5PhRb1DDfLYEeSEH1U4A0eE9hyoaVZaMJlB3M5LRVv293
 L48dhWOYsMrRHmGsf7sr83fBf/yBRK4X1q22xn8xoRX/qH38tnp6iVwnni531v3W5VFiLP8
 inlbrh9xUojNFyVE5ow70M/7fYxlxzr7U+JPSMFo4auyMCvj7kn2+W0N6T7iZeDCgmVEF4/
 UB0E1wUaxcAMVvJhOYigA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FTuWQPG4PaA=:OHXv4LKYgVpA7M9UUR5Qoj
 V6qp1BfIuzSIS8+O3AazHndfuzKsxJij3t9J555sZdCRJz+T1krjd8wfscVQuD8ZOsvQoOfib
 bra5f7P3gs+hrUZX58k0msQ2uSRarUWD5lGncs+Xta/ANE3sdkXjlYxyftf4qVAdm32WNHpq7
 h3F7b8ZI4VQjyGcEemws2DKjT5aE9l+74V0D1bFkl8poNBbyEAsJhUKpbuHh0J7BsPWxVMVfy
 915KySvM5P+LcKkuK2iolDSDvj6JSRV2A1d7Zgl80SMKC/x8fVIf/j08xhhFe7yUCkrIQ5e3w
 TxzBirD8Xgc5K9Wqknyys52ol0ue1Xh1M4+siDZIafB5pyUGu8U5AxUqPNs9nfmZCriZuqUN3
 DlarKeNtuq4kMu+lYZfixrqSMSQkorywo0BPUUPh2MDMOSaqp40JZOSVCFjnAY7jaUbRjC+pt
 cKy/LipdstjaU3Sa6Aq2SbnZ8Opld81uVaoK7ZX+Rj4Q/J0q43Edtxi4lPNCNl4lHsVG9gDRm
 tWqGGMHwiEy4ZTuDCc/QXo9QZK2rrxXLcFMJo5zQ1CCS1JUDz2SI3zsX3Y9WBcnFOZt1tvn0Q
 HTdz33DDM0PZ6YCqCxpnXFXhIzbO4dviwbt4oLoVsgwzXaCFGU7XI3XJ4GbU/7VGKSUK+8Hfc
 jax1Tv/pkyn8UHaiA8f5jj1RqbGCLd6QXENJuUajpiKhwTbbrfZ4mCv9hOkNqn+TnHmHaSttX
 jygFwFZiRY8uvLqrad+YQW2A0aIEGMu/gIosOURAJ+sc5AHdlhMP4J+Ki9RKfJMtiQjilw+wJ
 h9FEUgUDCoOuvNy5+tx6+7BmwC7lLMKyc6fQvyJVCBHZfmFTsczK8Qo4noRbW0wTZcFXxwndA
 L2zMRuVC4DSem8p8LU91X9VNXE4gsv/9UNwUDD8pZqdUeYP0jQ119oB6j+QDtKOWfuXP834jO
 H7fCkLE508bRLnOfrGikuxwAHySsSXs5BbRRFag9mLPOZ0qRQZlhSry1ce2ntxXstqXBDNNk5
 2EWg/IUupHuST7v0Y4roApnrgeJDoTTRZSaOFdwlQRWHHo7tD59A97P64PkdQ3vEHxpZkiYxG
 +gJBooNBMlLjmTx+B4mbo57GDwDdTufLda0sbt45I4FtG1yTNa9d4zsSwJGMyHAg1eAX8Upbd
 YlTv8Lbwsm/ubh3OWQpJm+y9DgZk0WUqTdSckZcV4PrHzCK1Np0R7XHpYK3PSJyh45cANDwOC
 P+n8tsNoy58MgTDpX
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.4
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 23:59:22 +0800
Jing-Wei Su <jwsu1986@gmail.com> wrote:

> Hi, Lukas
>
> If  PVM died, to let old  SVM be the new PVM, the old SVM's
> filter-redirectors(f1 and f2) are removed in your document.
> Why don't you remove the filter-rewriter from the old SVM?
> The filter-rewrite is kept in the new PVM. What is its role in the new P=
VM?
>
> Thanks!
>
> Sincerely,
> Jing-Wei

Hi,
The filter-rewriter rewrites the TCP-Packets to increase similarity of PVM=
 and SVM, after the SVM takes over it needs to continue the rewriting, oth=
erwise it would break the TCP connections.

Regards,
Lukas Straub


Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83ADC4CECD
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 02:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7268C2189D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 02:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="SaLLf0iJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7268C2189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAPsb-0007Ez-Jy
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 22:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fam@euphon.net>) id 1iAPrq-0006nt-0t
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 22:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fam@euphon.net>) id 1iAPrn-0004X5-Ra
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 22:38:52 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17807)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fam@euphon.net>) id 1iAPrm-0004St-Cw
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 22:38:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568774310; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=g1WTDuxJr3GPmnvbe0qo+SMbkdq/KqoVEMAg8+8swerEiSo3EYdS9FawuOS9XC4DYm8AnQ6mZ0lIH2WkVzc3bOmPbCFhuNSFQvOjtfpCRFb8mhdk+excPBoEPdY5O4RNhsaYY6fzZdIajNDbQrp2aH9W+OavruHSKhGh1JdjQ80=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1568774310;
 h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results;
 bh=8DiG6a8Xd6gRVOV3MBYVEjvkWs6LbpJD8/sLf5bGR5w=; 
 b=C+wElI05P7P45kT+7FVwZu9CbMXjJ5SAcgq2GtX8x9w95DVsGKv1fPf7FEEKdjr8NT/eqtBpyAysO0aU+PveW9WM21TyQ9fyvOOsfRdzeuUIOM4/oc5e7+LIxJrJezbkYKpy4z+jVlAc9HS/9M04eYUpJstOOk39it5Y7SdJgOU=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=euphon.net;
 spf=pass  smtp.mailfrom=fam@euphon.net;
 dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1568774310; 
 s=zoho; d=euphon.net; i=fam@euphon.net;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
 l=1647; bh=8DiG6a8Xd6gRVOV3MBYVEjvkWs6LbpJD8/sLf5bGR5w=;
 b=SaLLf0iJrmbRP3X4JEFQp4NqWuKGI8Zc3FXpfYpJxePox30NdaToh3XarcuErmOQ
 9XKypSou9km/K2++Dl9GLZa4xrocJPxqQue2qCEMoigwiA3kf+of8198NiWTS41j4/i
 aJ7xz+/PPPrESfMyCDZS0xSpH+me6BlYgkdZrDao=
Received: from localhost (120.52.147.46 [120.52.147.46]) by mx.zoho.com.cn
 with SMTPS id 1568774308339255.02150867556645;
 Wed, 18 Sep 2019 10:38:28 +0800 (CST)
Date: Wed, 18 Sep 2019 10:38:26 +0800
From: Fam Zheng <fam@euphon.net>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190918023826.GA28483@magic>
References: <156825315333.21839.4459418365355602992@5dec9699b7de>
 <06e01dd7-d464-729d-3cc6-b9440dd5e18e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06e01dd7-d464-729d-3cc6-b9440dd5e18e@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ZohoCNMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 124.251.121.243
Subject: Re: [Qemu-devel] [PATCH] docker: add sanitizers back to clang build
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 09/12 19:07, John Snow wrote:
> 
> 
> On 9/11/19 9:52 PM, no-reply@patchew.org wrote:
> > Patchew URL: https://patchew.org/QEMU/20190912014442.5757-1-jsnow@redhat.com/
> > 
> > 
> > 
> > Hi,
> > 
> > This series seems to have some coding style problems. See output below for
> > more information:
> > 
> > Subject: [Qemu-devel] [PATCH] docker: add sanitizers back to clang build
> > Message-id: 20190912014442.5757-1-jsnow@redhat.com
> > Type: series
> > 
> > === TEST SCRIPT BEGIN ===
> > #!/bin/bash
> > git rev-parse base > /dev/null || exit 0
> > git config --local diff.renamelimit 0
> > git config --local diff.renames True
> > git config --local diff.algorithm histogram
> > ./scripts/checkpatch.pl --mailback base..
> > === TEST SCRIPT END ===
> > 
> > From https://github.com/patchew-project/qemu
> >  * [new tag]         patchew/20190912014442.5757-1-jsnow@redhat.com -> patchew/20190912014442.5757-1-jsnow@redhat.com
> > Switched to a new branch 'test'
> > 96d44b9 docker: add sanitizers back to clang build
> > 
> > === OUTPUT BEGIN ===
> > ERROR: Missing Signed-off-by: line(s)
> 
> GDI.
> 
> I keep adding this to my configuration files, but it keeps "falling
> off", somehow.
> 
> I have some patches in the works for stgit where I'm going to work
> through some test cases for setting profile variables and try to fix this.
> 
> In the meantime:
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Isn't this because you inserted a '---' line in the middle of the commit
message so the part after it is ditched by 'git am'?

This feels a bit hard to catch, wondering what is in the works. :)

Fam



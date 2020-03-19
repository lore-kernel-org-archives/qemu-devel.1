Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361F5C4332E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0340B20739
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="feQaYFYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0340B20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEtko-0000qm-55
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 07:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jEtk1-0000Lc-Fy
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jEtjy-0001Cs-Vx
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:53:37 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:46279)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jEtjy-0000RS-Ec; Thu, 19 Mar 2020 07:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=OA9xsgai7U8iMJBQ/a7K1j5wWzd06GTsD4Mi+xk7JrE=; 
 b=feQaYFYDLWQa96T7/lTUOQ1iP9yzxKtUjKJ4DLBWeEGnDD3MC+Kxp9otFcTG4j1lk0+08U3SWePUgyfBxFuwXGhkhZoK7NtEZuMyjKk1TfvTz7+F0uTtd7eoVKpkh5zBwVqBmbb8V8VAmpdANhzlEz43SThKe3Dg9lxgWUnyDLvBi6LnWt2aGo7os0HvUeyNI01x2L5fG1rissMiPxUdGNkBFBc/mU+eowA9T77VVJOpSNHmlYq/O9wvI2h08yZLeCvS4bvQhZ36bZeQl4qYuEqC+cxAq7BbCDhe6OwC+ULSJssoOIEC43gYm2MEgG44jASRK70Xg//UimmnHIDfEQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jEtje-00056x-Sb; Thu, 19 Mar 2020 12:53:14 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1jEtje-0002GP-Ir; Thu, 19 Mar 2020 12:53:14 +0100
From: Alberto Garcia <berto@igalia.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH-for-5.0] block: Assert BlockDriver::format_name is not NULL
In-Reply-To: <20200318222235.23856-1-philmd@redhat.com>
References: <20200318222235.23856-1-philmd@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 19 Mar 2020 12:53:14 +0100
Message-ID: <w51o8sspnmd.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Mansour Ahmadi <ManSoSec@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 18 Mar 2020 11:22:35 PM CET, Philippe Mathieu-Daud=C3=A9 wrote:
> bdrv_do_find_format() calls strcmp() using BlockDriver::format_name
> as argument, which must not be NULL. Assert this field is not null
> when we register a block driver in bdrv_register().
>
> Reported-by: Mansour Ahmadi <ManSoSec@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto


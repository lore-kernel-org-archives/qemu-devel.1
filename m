Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F74C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 22:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A613F22CED
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 22:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A613F22CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5HNg-0004rt-7p
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 18:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1i5HMo-0004Oa-Bj
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 18:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1i5HMm-0007YZ-6u
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 18:33:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55506)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1i5HMm-0007Y5-0o
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 18:33:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 96BC5190C01B;
 Tue,  3 Sep 2019 22:33:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-245.rdu2.redhat.com
 [10.10.123.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BFE1B100195C;
 Tue,  3 Sep 2019 22:33:30 +0000 (UTC)
Date: Tue, 3 Sep 2019 18:33:28 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190903223328.GA448@localhost.localdomain>
References: <20190829013125.GG16342@umbus.fritz.box>
 <20190829015117.GH16342@umbus.fritz.box>
 <20190829032746.GA488@localhost.localdomain>
 <24d0d5be-d206-33a0-cd8c-29825e2f8516@redhat.com>
 <ecfc63f3-d208-4a79-c26c-3d8fa031b3d3@redhat.com>
 <20190903150824.GA14836@localhost.localdomain>
 <20190903172758.GR3694@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903172758.GR3694@habkost.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Tue, 03 Sep 2019 22:33:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Cryptic errors from PIP install if missing
 openssl-devel
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
Cc: ldoktor@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 03, 2019 at 02:27:58PM -0300, Eduardo Habkost wrote:
> This would stop working as soon as a file named 'p@ssw0rD' gets
> created.  Can the API be more explicit somehow?
> 
> Is there anything that prevents us from using keyword arguments?
> e.g.:
> 
>   Session(..., username='root', password='p@ssw0rD')
>

OK, we have enough fair criticism of the approach that would keep the
API compatible, so let's implement a better, not non-backwards
compatible version, like suggested here.

Thanks for the feedback!
- Cleber.


Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81721CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:16:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E3220659
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:16:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E3220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMu14-00081U-H3
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <samuel.thibault@gnu.org>) id 1iMtpC-0002sA-HJ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <samuel.thibault@gnu.org>) id 1iMtpB-0008QE-ET
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:03:46 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:48762)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <samuel.thibault@gnu.org>)
 id 1iMtpB-0008Os-7r
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:03:45 -0400
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 654EE1FDA;
 Tue, 22 Oct 2019 15:03:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fc1g4LzXio5l; Tue, 22 Oct 2019 15:03:42 +0200 (CEST)
Received: from function (unknown [62.102.229.57])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id 5BBBD1E7D;
 Tue, 22 Oct 2019 15:03:42 +0200 (CEST)
Received: from samy by function with local (Exim 4.92.2)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1iMu1J-0003jP-3g; Tue, 22 Oct 2019 15:16:17 +0200
Date: Tue, 22 Oct 2019 15:16:15 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: Python 2 and test/vm/netbsd
Message-ID: <20191022131615.ivlfwpct22zcjzde@function>
References: <20191016030021.GD4084@habkost.net>
 <a83d518a-6e39-0017-203d-2ee3d61935ca@redhat.com>
 <20191016224124.GF4084@habkost.net>
 <20191017220541.GJ4084@habkost.net>
 <20191017225548.GL4084@habkost.net>
 <20191018104439.c2tojlvi2c5zzesi@sirius.home.kraxel.org>
 <20191018142940.GN4084@habkost.net>
 <a0c2df74-360b-79de-132e-f4d5be5bfc12@redhat.com>
 <20191018160019.he52tpvjqolzgswg@function>
 <20191018164143.GP4084@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018164143.GP4084@habkost.net>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 185.233.100.1
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost, le ven. 18 oct. 2019 13:41:43 -0300, a ecrit:
> On Fri, Oct 18, 2019 at 06:00:19PM +0200, Samuel Thibault wrote:
> > It was implemented at the time of introduction of IPv6 in SLIRP. Perhaps
> > NetBSD has a slightly different behavior which makes the implementation
> > fail to notice the error.
> 
> If anybody is interested in investigating it, a network traffic
> dump generated by `-object filter-dump` is attached.

The dump does show the Destination Unreachable icmp message, so it seems
it's the guest which does not notice it for some reason.

Samuel


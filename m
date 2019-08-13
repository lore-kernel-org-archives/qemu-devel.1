Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54826C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 09:11:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A43920663
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 09:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A43920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxSpm-0007kC-GV
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 05:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50116)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hxSpN-0007FV-52
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 05:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hxSpL-0000tf-SD
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 05:10:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59928)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hxSpJ-0000sP-8V; Tue, 13 Aug 2019 05:10:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8F33080F7C;
 Tue, 13 Aug 2019 09:10:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-18.ams2.redhat.com
 [10.36.117.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 230A653E09;
 Tue, 13 Aug 2019 09:10:42 +0000 (UTC)
Date: Tue, 13 Aug 2019 11:10:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190813091041.GA4663@localhost.localdomain>
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <20190812181146.26121-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812181146.26121-3-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 13 Aug 2019 09:10:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: test mirroring qcow2 under
 raw format
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
Cc: den@openvz.org, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 12.08.2019 um 20:11 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Check that it is fixed by previous commit
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/263     | 46 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/263.out | 12 ++++++++++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 59 insertions(+)
>  create mode 100755 tests/qemu-iotests/263
>  create mode 100644 tests/qemu-iotests/263.out
> 
> diff --git a/tests/qemu-iotests/263 b/tests/qemu-iotests/263
> new file mode 100755
> index 0000000000..dbe38e6c6c
> --- /dev/null
> +++ b/tests/qemu-iotests/263
> @@ -0,0 +1,46 @@
> +#!/usr/bin/env python
> +#
> +# Test mirroring qcow2 under raw-format
> +#
> +# Copyright (c) 2019 Virtuozzo International GmbH.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +import iotests
> +from iotests import qemu_img_create, qemu_io, filter_qemu_io, file_path, log
> +
> +iotests.verify_image_format(supported_fmts=['qcow2'])
> +
> +base, top, target = file_path('base', 'top', 'target')
> +size = 1024 * 1024
> +
> +qemu_img_create('-f', iotests.imgfmt, base, str(size))
> +log(filter_qemu_io(qemu_io('-f', iotests.imgfmt,
> +                           '-c', 'write -P 1 0 1M', base)))
> +qemu_img_create('-f', iotests.imgfmt, '-b', base, top, str(size))

Who deletes these files at the end of the test? (There's a reason why
all the other test cases uses 'with FilePath(...)'.)

Kevin


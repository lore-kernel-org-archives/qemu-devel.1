Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCE0CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:12:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1888D2054F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="YZGVTMnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1888D2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO38F-0002UT-Er
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 13:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iO31n-0005Uy-QK
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 13:05:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iO31m-0002j5-Kq
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 13:05:31 -0400
Received: from mout.web.de ([212.227.15.14]:56735)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>)
 id 1iO31j-0002QO-Jp; Fri, 25 Oct 2019 13:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1572023097;
 bh=swJni6b4V8pRAk84eLDd3KajcXs6Pvhgess3/vHrBUY=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=YZGVTMnNGV4TSI59w9vQ7LTjpInfNIoC/lsCbQzGGxCdHj+xvh66Vf5pVRGLgYD3s
 HKRsofFs8Wy4zVwxTvXvcDYqSJLZLLdIsBeeu43iVBIx9tc19CCoqO6bOnnSASYPnC
 SMKDyPs4aDvOcnB7QgfYPIS3Sdmx/zBiXzG0QfEs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.116]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MYZ8c-1iRwlv0uIs-00VPqI; Fri, 25
 Oct 2019 19:04:57 +0200
Date: Fri, 25 Oct 2019 19:04:54 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v7 0/4] colo: Add support for continuous replication
Message-ID: <20191025190454.5176685f@luklap>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cPuoh/0JSG4Q0hkOUQbxmGAvWhPcLCntUaL3EEmrde2RyUAVZ8Q
 +cFD6DHAlNMSCJmhWO9Cqqa3BgNCllp4oObA2sWJD4MFqNjCKmSkzhljc+w/9jbOSlJOnNH
 5EohT7/sr7oadg/is7KqAXf4KpTxYqaTuuWmF5E1dRs2noC61pphPKExmGwUfKJiHKdNfZd
 oiR9FnrOGYAZsRH8lKR6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uVBllg0GIig=:b0BBTmCm7+w/R+dBGgXV9J
 7Mm8IZcyR0T1OmStuIbmEz8tya7zpmvl3AgPgOPYcZIIKBu2RQ31WlOqwYX9NX1fK3UEga5/A
 mpXyISA2YTWqbq9YizILhEUeAFFfSkkRmPiYfFB+irdGW1nSuP3iaufvxP5qtnlFvEbc4H6Bz
 YMCIp8iX+KlA/RcQ6CcBF+xFzFcP2yfwtMzi8Cn7F5VRU95T8+r3ElSU5byexc61mnmKGR7kX
 YwbILjNfK4P0bvzhCmwW68xnrKTjINoR0naegPpr9l7vpYquAxm0Cmcmv/TQLqgLAsphyVGyu
 ydU3enZejg52jh14ZZVjNDtJCJJmX9QnePIU2xJlTKAbiegDMyOQ2fs1yvQIFmrS20UVeKHSl
 D+BGTCBT4BUgKiORMdBQQcskVnn0kVuhkZI7nFyf+cAS3ZZGQ3tBmk96kzn6ak73XYXGBih8l
 bjLvxIM8ZmPBK0Oko7TF8A3ZRnzPulSz0ihvt2aRqRbWP7iwJZUHu8cmsbEsLNgoa/dTS5NRY
 o00bXrlDID7bL42Rj+kII52La1ETpYTSypFZbtgX5pyD04hF+OSSP2cNN60/aJdDZ93zlF+AI
 naAnqQ/zqzVcmIWDCjmuexyRhGqjuR0Aw9/t2+MXGBEZ7BQclCzhDcdbqyZ0WxtZlpXRMb50+
 pYFbbc79NZoiugGTfb5+imEHSIQ3rLAuOEFWSIcRATGaTh2qiU5wQA7sRdiw8euripTIwnLXw
 hSYcEtqrYTa5oo8xJeRQSPhtqTA539QJ1lyINenqVubM9YTuz/DR+41Ap6RoU0ShWIJNrJZe5
 6qTZhSYpyLMP/5q5EzW6nN3Bn+H6RTl5JekENjS+z0YrbqchVfkcqBtiRx/7k0PyaiGtdcqV1
 MAmRC9VfiiusRjeNlgF8euwsr1ck0L5YCwdCDpUt4bdLrFZakRYK+X9YqEA2czQWR+fk4ikU/
 8f1IN2Dm+lnCHECBB6/kX3cW1SuDVnGORgOlbyL0I6knAd7hA6bOuPZvK0xsYXozDI0fWsVpe
 OBuYWewuHCjEiliMX2Tk7UujFYkbt4vh/FSJU3T+O4nSRh9e9eFm+dN8e5khqYXOwdZ0Yw10p
 jk45ePrkurEFS9XpXKS/z2EWfEtrUJEOO3ZNFlOlGh8oI2VlJJAJy1OzK9i8ioT74Umc/oQxB
 vNGLe00W+X7WEuUvYPkLhWliIGTwe23/xYRlmWnL+vbht0xSmo1BcLj5SkJydyei45UbDGSRi
 /h0hYFF7BL4rRR8YByjkP/wnUxWyU/oiCn6WBo5SN6bm4Dtm0wupCGI2QxXs=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.14
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Wen Congyang <wencongyang2@huawei.com>, Jason Wang <jasowang@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Xie Changlong <xiechanglong.d@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Everyone,
These Patches add support for continuous replication to colo. This means
that after the Primary fails and the Secondary did a failover, the Seconda=
ry
can then become Primary and resume replication to a new Secondary.

Regards,
Lukas Straub

v7:
 - clarify meaning of ip's in documentation and note that active and hidde=
n
   images just need to be created once
 - reverted removal of bdrv_is_root_node(top_bs) in replication and adjust=
ed
   the top-id=3D parameter in documentation acordingly

v6:
 - documented the position=3D and insert=3D options
 - renamed replication test
 - clarified documentation by using different ip's for primary and seconda=
ry
 - added Reviewed-by tags

v5:
 - change syntax for the position=3D parameter
 - fix spelling mistake

v4:
 - fix checkpatch.pl warnings

v3:
 - add test for replication changes
 - check if the filter to be inserted before/behind belongs to the same in=
terface
 - fix the error message for the position=3D parameter
 - rename term "after" -> "behind" and variable "insert_before" -> "insert=
_before_flag"
 - document the quorum node on the secondary side
 - simplify quorum parameters in documentation
 - remove trailing spaces in documentation
 - clarify the testing procedure in documentation

v2:
 - fix email formating
 - fix checkpatch.pl warnings
 - fix patchew error
 - clearer commit messages


Lukas Straub (4):
  block/replication.c: Ignore requests after failover
  tests/test-replication.c: Add test for for secondary node continuing
    replication
  net/filter.c: Add Options to insert filters anywhere in the filter
    list
  colo: Update Documentation for continuous replication

 block/replication.c        |  35 +++++-
 docs/COLO-FT.txt           | 224 +++++++++++++++++++++++++++----------
 docs/block-replication.txt |  28 +++--
 include/net/filter.h       |   2 +
 net/filter.c               |  92 ++++++++++++++-
 qemu-options.hx            |  31 ++++-
 tests/test-replication.c   |  52 +++++++++
 7 files changed, 389 insertions(+), 75 deletions(-)

=2D-
2.20.1


Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4DFC43215
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BA7206D3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="IJO7Ce7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BA7206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUviP-0008KM-P3
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 11:41:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iUvdE-0002z3-7S
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:36:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iUvdD-0004Mo-3H
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:36:36 -0500
Received: from mout.web.de ([212.227.15.3]:51047)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>)
 id 1iUvdA-0004Lf-7R; Wed, 13 Nov 2019 11:36:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1573662965;
 bh=EBgpQzQ6k/7S9mrSMyrm9gx2RGexNh0KiOQHDh8YCbE=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=IJO7Ce7DG3rI3Xo7Y5oAXRxFx1L4KcTaR/QGJoEL+y0m9nQ+4pDQCm8OMEsaZgkWW
 /EviO93lOYmRvGivi2WxNFycGr+dL59ryO1J2AWXHGoSJEjcLkPCdsXKHb5fvCjfO5
 buVzlaR40viQ9EAYADDWH/4SwguaLjpV1bKAKoQE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.246]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LpQjF-1hzQki0lBl-00fE8Z; Wed, 13
 Nov 2019 17:36:05 +0100
Date: Wed, 13 Nov 2019 17:35:59 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 0/4] colo: Add support for continuous replication
Message-ID: <20191113173559.0713c27d@luklap>
In-Reply-To: <cover.1571925699.git.lukasstraub2@web.de>
References: <cover.1571925699.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y3h3pjukhRtHWwr5vlytXIvJfiqTcZB0SBFXX/TxIZFmhhHmvDF
 FkFTjY0DkNJbsOpvq+WN43IVVJ+gfj4zQqecMR9sDLk46AepxJQ6uugy4CdmsXT4L5kAW1r
 WnNwJIoHJ3B9NQF8j2HUOJO7rzDzzBAalA+aGdX+5N75os2IAmLsUW3b3PKp5bq0UIHdLGh
 qbMSgDdr9OthG1DHP0RgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DeFpq/sNSfw=:wN3lNCCvlfA+FMHIK86BEx
 uumRBWu3uatXj1pJYvPt+baJg/X4E7SU3ICALGPQIZ9yo+uZvtuVoWr1XlZFxcKMqpdeC307U
 2umPqBqngmEbev3r/eEH1cs3ccXWoCOSiQfrR1DEMFWheFiqWEfE39xY2odbmi717znVfTOwg
 XQeils8+oN3wtK05Zeu+63sK+C6f1ieMK6YP+KeLRVUcp7PV9UoWweeyXnilfcl19MT4g5cmo
 COJdH1NsJKJ5D0vzz7fFkq5H9j2ueCxhnP+jw2HkDdJaVaAjBZskHrxT85qttW2GXLo9WcMnH
 fGTk97zmmBCVM5D6/foP1GX9LOL6om2Ddi5etsQ+Jajas+a/3uNwD2MFB6Neij9kfnE/OM72Q
 qkRbW/Sa0dqt7D7Szom+91y/0fqnIJdF+gy3jEXEEM4jXkZ/e/y1NHoukVU2VX76C8VhnwHRe
 GXAxafP8QeCtkI0ihSAy5WYl4huVCeg27dkNHY7nmhbgSmX4CKq7+mkOuR+Pm5GuNcSObqNEL
 knyatxX+T9ui1sNsGzg7lb3IoMQZciSJECmYp7e34ce0AlMI1nw2lY4PT+9AnP0EaUgh2okOl
 /VBZm/zzGwNCu6yvoLtk/xv/p48W0ak3m/gi7ighkw9Hg1Cg+LkwjQR/Sv7FYp83c57/YZXRS
 ila/kloUsy5QD9yuPuJ1/cCEN989CTE4/ykZ2zzvpCjTZ/refUl/YZqiAGnPA2wFK549KvKzi
 UCH9a6m+Qor+nrwhqeZDnzLEwgc11x+8RL/R0PZQfYOLeDTbE3E3mWK2g9QdSQwlndUECbQX/
 Du0I0OqJpyJk4DMTXog6n8FV68nn/fFQp1HET8iU4+ARmy0QEv4UY92v4RrlPyD9bcXGSBmn8
 vd6JWzjJUR9f2+RowXMaDvxgHcfBTrTk28eBKzuadL8Y5zXPPG1ozqatpcb/o4lm1aV9iagSW
 usN1pKRQTHzE4vPKojCxpKhegaun7oqmBbpSjsidOFPLRLvibzPQQBs4l3Zg3OmBhHPFXLhtu
 JUJYsrrNTP558AHmnp62mb2HqnVTPGMGj4J1a5meJT69t75w+NBIHmpS2ZNdaMoRUWMFeX0g/
 OLwWFsUAiwNsT5+XnGo4oZCo+LW8DmkSw8axLT3DiIq4Z1UU6TwvGNO8n7Ja0lmA4H9QMk+lR
 bh24Sd/QmjZk/OBz9dSxlpx1SsPydH5ShqM4xwOx8RYRmqEKEELwBVeeYGFxOSgsAGCAeKoQg
 8OGxDM8IjkQufz1N0ZFyqLdNLiyqFtcs4SsiP3ZSw2vQ5SQCp7NgVY3vabxY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.3
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

On Fri, 25 Oct 2019 19:06:31 +0200
Lukas Straub <lukasstraub2@web.de> wrote:

> Hello Everyone,
> These Patches add support for continuous replication to colo. This means
> that after the Primary fails and the Secondary did a failover, the Secon=
dary
> can then become Primary and resume replication to a new Secondary.
>
> Regards,
> Lukas Straub
>
> v7:
>  - clarify meaning of ip's in documentation and note that active and hid=
den
>    images just need to be created once
>  - reverted removal of bdrv_is_root_node(top_bs) in replication and adju=
sted
>    the top-id=3D parameter in documentation acordingly
>
> v6:
>  - documented the position=3D and insert=3D options
>  - renamed replication test
>  - clarified documentation by using different ip's for primary and secon=
dary
>  - added Reviewed-by tags
>
> v5:
>  - change syntax for the position=3D parameter
>  - fix spelling mistake
>
> v4:
>  - fix checkpatch.pl warnings
>
> v3:
>  - add test for replication changes
>  - check if the filter to be inserted before/behind belongs to the same =
interface
>  - fix the error message for the position=3D parameter
>  - rename term "after" -> "behind" and variable "insert_before" -> "inse=
rt_before_flag"
>  - document the quorum node on the secondary side
>  - simplify quorum parameters in documentation
>  - remove trailing spaces in documentation
>  - clarify the testing procedure in documentation
>
> v2:
>  - fix email formating
>  - fix checkpatch.pl warnings
>  - fix patchew error
>  - clearer commit messages
>
>
> Lukas Straub (4):
>   block/replication.c: Ignore requests after failover
>   tests/test-replication.c: Add test for for secondary node continuing
>     replication
>   net/filter.c: Add Options to insert filters anywhere in the filter
>     list
>   colo: Update Documentation for continuous replication
>
>  block/replication.c        |  35 +++++-
>  docs/COLO-FT.txt           | 224 +++++++++++++++++++++++++++----------
>  docs/block-replication.txt |  28 +++--
>  include/net/filter.h       |   2 +
>  net/filter.c               |  92 ++++++++++++++-
>  qemu-options.hx            |  31 ++++-
>  tests/test-replication.c   |  52 +++++++++
>  7 files changed, 389 insertions(+), 75 deletions(-)
>

Hello Everyone,
So I guess this is ready for merging or will that have to wait until the 4=
.2 release is done?

Regards,
Lukas Straub


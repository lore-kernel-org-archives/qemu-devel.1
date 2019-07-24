Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98018C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 17:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F55121873
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 17:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F55121873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqKk1-0000Dj-Ml
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 13:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47406)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crobinso@redhat.com>) id 1hqKjr-0008Go-6V
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 13:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crobinso@redhat.com>) id 1hqKjp-0005b7-VP
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 13:07:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51940)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crobinso@redhat.com>)
 id 1hqKjp-0005SF-N4; Wed, 24 Jul 2019 13:07:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C436F7FDCC;
 Wed, 24 Jul 2019 17:07:34 +0000 (UTC)
Received: from [10.10.124.106] (ovpn-124-106.rdu2.redhat.com [10.10.124.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45B2860497;
 Wed, 24 Jul 2019 17:07:34 +0000 (UTC)
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
From: Cole Robinson <crobinso@redhat.com>
Message-ID: <1ca31fa3-2557-a836-cd7b-4dd244befcd6@redhat.com>
Date: Wed, 24 Jul 2019 13:07:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 24 Jul 2019 17:07:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH 00/36] Patch Round-up for
 stable 3.1.1, freeze on 2019-07-29
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/19 1:00 PM, Michael Roth wrote:
> Hi everyone,                                                           =
                                  =20
>=20
> The following new patches are queued for QEMU stable v3.1.1:
>=20
>   https://github.com/mdroth/qemu/commits/stable-3.1-staging
>=20
> The release is planned for 2019-08-01:
>=20
>   https://wiki.qemu.org/Planning/3.1
>=20
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.
>=20
> Note that this update falls outside the normal stable release support
> window (~1 development cycle), but is being released now since it was
> delayed from its intended release date.
>=20

Here's some extra patches we are carrying in Fedora 30

Thanks,
Cole

commit e014dbe74e0484188164c61ff6843f8a04a8cb9d
Author: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
Date:   Tue Mar 5 16:46:33 2019 +0100

    gluster: Handle changed glfs_ftruncate signature

commit 0e3b891fefacc0e49f3c8ffa3a753b69eb7214d2
Author: Niels de Vos <ndevos@redhat.com>
Date:   Tue Mar 5 16:46:34 2019 +0100

    gluster: the glfs_io_cbk callback function pointer adds pre/post
stat args

commit cce648613bc802be1b894227f7fd94d88476ea07
Author: Prasad J Pandit <pjp@fedoraproject.org>
Date:   Wed Dec 12 23:28:17 2018 +0530

    pvrdma: release device resources in case of an error

commit 2aa86456fb938a11f2b7bd57c8643c213218681c
Author: Prasad J Pandit <pjp@fedoraproject.org>
Date:   Thu Dec 13 01:00:35 2018 +0530

    pvrdma: add uar_read routine

commit e909ff93698851777faac3c45d03c1b73f311ea6
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri Jan 11 17:27:31 2019 +0100

    scsi-generic: avoid possible out-of-bounds access to r->buf

commit a7104eda7dab99d0cdbd3595c211864cba415905
Author: Prasad J Pandit <pjp@fedoraproject.org>
Date:   Sun Jan 13 23:29:48 2019 +0530

    slirp: check data length while emulating ident function

commit b05b267840515730dbf6753495d5b7bd8b04ad1c
Author: Gerd Hoffmann <kraxel@redhat.com>
Date:   Tue Jan 8 11:23:01 2019 +0100

    i2c-ddc: fix oob read

commit 9a1565a03b79d80b236bc7cc2dbce52a2ef3a1b8
Author: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Date:   Wed Mar 13 09:49:03 2019 +0000

    seccomp: don't kill process for resource control syscalls

commit d52680fc932efb8a2f334cc6993e705ed1e31e99
Author: Prasad J Pandit <pjp@fedoraproject.org>
Date:   Thu Apr 25 12:05:34 2019 +0530

    qxl: check release info object

commit ad280559c68360c9f1cd7be063857853759e6a73
Author: Prasad J Pandit <pjp@fedoraproject.org>
Date:   Fri Jan 4 15:19:10 2019 +0530

    sun4u: add power_mem_read routine

commit da885fe1ee8b4589047484bd7fa05a4905b52b17
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Fri Dec 14 13:30:52 2018 +0000

    device_tree.c: Don't use load_image()

commit 065e6298a75164b4347682b63381dbe752c2b156
Author: Markus Armbruster <armbru@redhat.com>
Date:   Tue Apr 9 19:40:18 2019 +0200

    device_tree: Fix integer overflowing in load_device_tree()


Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA043C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4CDB21783
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VofH+42l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CDB21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUAKL-0007VC-RY
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 09:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crobinso@redhat.com>) id 1iUAIW-0005dQ-Nf
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:04:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crobinso@redhat.com>) id 1iUAIU-0001QX-KH
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:04:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57296)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1iUAIU-0001Q7-01
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:04:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573481041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VseiF+EjlezxmYC8XRFOqoffcnGZqJ4Pg5u5ePvpM90=;
 b=VofH+42lCa1LNduhKdfN+3ulWfa91W/oxFinQ+mUCRKphbndDO94BgWYE7RQW766c1Fz8F
 9kL7VoG+z4CDWNNZdPU0ysxtiT7TwFN30k3upzIxynXXm8Q8DlkeOVwRYPB/o/092YjGKI
 4O2XVgtmC4zdQR7kOB65C/RMkeIcZD0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-g2ZhlaRJPg2RFFgpO2QNbA-1; Mon, 11 Nov 2019 09:02:51 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90FC9107ACC5;
 Mon, 11 Nov 2019 14:02:50 +0000 (UTC)
Received: from [10.10.121.92] (ovpn-121-92.rdu2.redhat.com [10.10.121.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A1E962965;
 Mon, 11 Nov 2019 14:02:50 +0000 (UTC)
Subject: Re: [PATCH 00/55] Patch Round-up for stable 4.1.1, freeze on
 2019-11-12
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
From: Cole Robinson <crobinso@redhat.com>
Message-ID: <fa7c8160-ac0e-ed54-ba77-2a516f08b003@redhat.com>
Date: Mon, 11 Nov 2019 09:03:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: g2ZhlaRJPg2RFFgpO2QNbA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

On 11/5/19 3:51 PM, Michael Roth wrote:
> Hi everyone,
>=20
> The following new patches are queued for QEMU stable v4.1.1:
>=20
>   https://github.com/mdroth/qemu/commits/stable-4.1-staging
>=20
> The release is tentatively planned for 2019-11-14:
>=20
>   https://wiki.qemu.org/Planning/4.1
>=20
> Please note that the original release date was planned for 2019-11-21,
> but was moved up to address a number of qcow2 corruption issues:
>=20
>   https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg07144.html
>=20
> Fixes for the XFS issues noted in the thread are still pending, but will
> hopefully be qemu.git master in time for 4.1.1 freeze and the
> currently-scheduled release date for 4.2.0-rc1.
>=20
> The list of still-pending patchsets being tracked for inclusion are:
>=20
>   qcow2: Fix data corruption on XFS
>     https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg00073.html
>     (PULL pending)
>   qcow2: Fix QCOW2_COMPRESSED_SECTOR_MASK
>     https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg07718.html
>   qcow2-bitmap: Fix uint64_t left-shift overflow
>     https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg07989.html
>=20
> Please respond here or CC qemu-stable@nongnu.org on any additional patche=
s
> you think should be included in the release.
>=20
> Thanks!
>=20

Extra patches we are carrying in Fedora 31. First 2 were requested as
fixes for gluster 4k issues. Last one fixes tests on newer kernels

commit a6b257a08e3d72219f03e461a52152672fec0612
Author: Nir Soffer <nirsof@gmail.com>
Date:   Tue Aug 13 21:21:03 2019 +0300

    file-posix: Handle undetectable alignment

commit 1fa6975773bb7dcb27dd5a248c0ccfe839b83178
Author: Nir Soffer <nirsof@gmail.com>
Date:   Tue Aug 27 04:05:27 2019 +0300

    block: posix: Always allocate the first block

commit d4f42d8c648d7e94b408e8056483189c27cf53bf
Author: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Date:   Wed Aug 21 16:14:27 2019 +0100

    tests: make filemonitor test more robust to event ordering


Thanks,
Cole



Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3003C5DF64
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C164C2178F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJzqxVRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C164C2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSNqg-0003e8-Aw
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 11:07:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iSNcH-0005mm-M1
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iSNcG-0006xQ-Bb
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:53:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59654
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iSNcF-0006w1-NW
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573055582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5rQzrnK48RUhOxfRkhJa3UVUNO+Rh2kD/SliXmztdUw=;
 b=BJzqxVRcrDcr9KopASwslP0hfY17awS7RwpyRaEieKyeqGnMI21R/Yl6FzlKjdP1H5t8T7
 LDUQloWg4gCYN/Ml35yUy7MSoChxY4ku3poNuPHnwBAr8NWsQvpmeljnMBaL31Si91/cZD
 x0WP4tCZ0cANBd8PzBZisCPWunN523w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-U2nBE5vDOO6lC0nN3dPgjQ-1; Wed, 06 Nov 2019 10:53:01 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65CEA8017DD;
 Wed,  6 Nov 2019 15:53:00 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 069121001DE1;
 Wed,  6 Nov 2019 15:52:53 +0000 (UTC)
Message-ID: <55b7664c4766ec05423d76dba0712b438f4b5e6c.camel@redhat.com>
Subject: Re: [PATCH v2 00/21] iotests: Allow ./check -o data_file
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Wed, 06 Nov 2019 17:52:52 +0200
In-Reply-To: <20191015142729.18123-1-mreitz@redhat.com>
References: <20191015142729.18123-1-mreitz@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: U2nBE5vDOO6lC0nN3dPgjQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-10-15 at 16:27 +0200, Max Reitz wrote:
> Hi,
>=20
> The cover letter from v1 (explaining the motivation behind this series
> and the general structure) is here:
>=20
> https://lists.nongnu.org/archive/html/qemu-block/2019-09/msg01323.html
>=20
>=20
> For v2, I=E2=80=99ve tried to address Maxim=E2=80=99s comments:
> - Patch 1 through 3: New
> - Patch 4: Only print feature bits instead of blacklisting stuff that we
>            don=E2=80=99t need
> - Patch 5:
>   - Fix typo
>   - Add comment why 098 needs compat=3D1.1
> - Patch 16: Use _check_test_img
> - Patch 17: Use the new _filter_json_filename
> - Patch 18: Rethink the incompatible feature filter approach: Instead of
>             filtering out the data_file bit, just check whether the
>             dirty bit is present (because that is all we want to know)
> - Patch 19: Use the new _filter_json_filename
> - Patch 20: Rebase conflicts due to the changes to patch 5
> - Patch 21:
>   - Add and use _get_data_file
>   - Add a comment how the data_file_filter in _filter_qemu_img_map works
>=20

Thank you! I reviewed the series, and it looks fine now.
Best regards,
=09Maxim Levitsky



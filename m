Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1950C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD52217BA
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUxziGK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD52217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iafvM-00039l-M2
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 08:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iaf6t-00023t-DS
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iaf6o-0001eq-4m
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:10:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55756
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iaf6n-0001bG-9H
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575029446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63Mys5DYcd0iWt7LK6yyU7KHaPaTcEHF9sWykfM7648=;
 b=dUxziGK9vmywyukfq1fmbYKG6tmrMVSm9jXT9TLGYAzWV7A3FRrkSCv+tvW/hnU/LDmtxT
 +8Ib2VifN04zQ3xLfVQE2GXYxdctLjCO9G8Tpwf7vty9Yq1L3PruppptOfjqZvScNwrMGc
 2p1wxk83GshPG4QjtrDn9CLtGTdZKwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-Z0dWOdmrNAWt4TzMX2vfdQ-1; Fri, 29 Nov 2019 07:10:44 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC4DB80183C;
 Fri, 29 Nov 2019 12:10:43 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.36.118.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B14E600C8;
 Fri, 29 Nov 2019 12:10:39 +0000 (UTC)
Subject: Re: [PATCH-for-4.2? 0/1] roms/edk2: update submodule to
 edk2-stable201911, fixing low severity CVEs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191129104457.1991-1-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9e052d2b-50c9-9370-a279-002987375f89@redhat.com>
Date: Fri, 29 Nov 2019 13:10:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191129104457.1991-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Z0dWOdmrNAWt4TzMX2vfdQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Cole Robinson <crobinso@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Prasad J Pandit <pjp@fedoraproject.org>, Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Phil,

On 11/29/19 11:44, Philippe Mathieu-Daud=C3=A9 wrote:
> I had this commit ready for when the next EDK2 release were go out,
> which just happened: https://edk2.groups.io/g/devel/message/51502
>=20
> Laszlo doesn't think it's worth the churn to rush to get this update
> into into 4.2-rc4: https://bugs.launchpad.net/qemu/+bug/1852196/comments/=
2
>=20
> I agree with Laszlo, users shouldn't use the EDK2 bundled within QEMU
> in production, and should rather build it from source. However some
> distributions seem to rely on this convenience way to package EDK2,
> and few CVEs are fixed in this new release. So it might be worthwhile
> to get this into 4.2-rc4. Anyhow distributions don't use QEMU stable
> tag directly and backport patches, so if there is no other rc4 patch,
> we could skip this for after 4.2, as Laszlo originally planned.
>=20
> Philippe Mathieu-Daud=C3=A9 (1):
>   roms/edk2: update submodule from edk2-stable201905 to
>     edk2-stable201911
>=20
>  roms/edk2 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

if we want to do this, then the above diffstat is not enough.

- please evaluate whether we should do something like 9153b9d7401f
("roms/Makefile.edk2: update input file list for
"pc-bios/edk2-licenses.txt"", 2019-06-14)

- we need to rebuild the binaries: 3583cb29f28f ("pc-bios: refresh edk2
build artifacts for edk2-stable201905", 2019-06-14)

- we should update the README file: 541617cad344 ("pc-bios: update the
README file with edk2-stable201905 information", 2019-06-14)

Thanks
Laszlo



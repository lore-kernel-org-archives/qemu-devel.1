Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA2DC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:48:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D91215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yx1L0sOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D91215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT6VL-0004as-8L
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iT6QY-0000TW-Bx
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:43:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iT6QW-0001Yw-Lq
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:43:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25902
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iT6QW-0001Yk-GV
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573227836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uDx5th0g9HpIcu0JF2xvZ+ctTQBM9PLpFhboxKhHl5k=;
 b=Yx1L0sOY3SOc0ssh+4Fw4LMxOUqmodLfuUArC+C61DwnNL3iL78j84J07vNiODj0MG/5sR
 tz3RXUdYbgEZ6iDVgRTvHghbuRfD0B3qmtWJ7K2p6FaunMCkZbU+MgHZb2ZjL6qJAEdAWk
 Sefdqy7HWkEhrNPVghn2oGWhgpsoQ3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-j-ew9pROMzSJakllX3EOkQ-1; Fri, 08 Nov 2019 10:43:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 921B2800C72;
 Fri,  8 Nov 2019 15:43:52 +0000 (UTC)
Received: from [10.3.117.38] (ovpn-117-38.phx2.redhat.com [10.3.117.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED7AC600C9;
 Fri,  8 Nov 2019 15:43:42 +0000 (UTC)
Subject: Re: [PATCH] configure: Check bzip2 is available
To: Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191108102805.8258-1-philmd@redhat.com>
 <862eb773-609d-4250-b46b-d922fc5a86a7@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <00cca0a5-7a51-f2d1-5120-821c335954b8@redhat.com>
Date: Fri, 8 Nov 2019 09:43:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <862eb773-609d-4250-b46b-d922fc5a86a7@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: j-ew9pROMzSJakllX3EOkQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/8/19 5:01 AM, Laszlo Ersek wrote:

>>
>> Add a check in ./configure to warn the user if bzip2 is missing.
>=20
> We've come full circle. Let me explain:
>=20
>>
>> Fixes: 536d2173b2b
>=20
> So this makes me kinda grumpy. If you look at the v3 posting of the patch=
 that would later become commit 536d2173b2b:
>=20
>    http://mid.mail-archive.com/20190321113408.19929-8-lersek@redhat.com
>=20
> you see the following note in the changelog:
>=20
>      - compress FD files with bzip2 rather than xz, so that decompression=
 at
>        "make install" time succeed on older build OSes too [Peter]
>=20
> So I couldn't use xz because that was "too new" for some build OSes, but =
now we also can't take bzip2 for granted because that's "too old" for some =
other build OSes? This is ridiculous.
>=20
> To be clear, my disagreement is only with the "Fixes" tag. For me, "Fixes=
" stands for something that, in retrospect, can be proven to have been a bu=
g at the time the code was *originally* committed. But, at the time, taking=
 "bzip2" for granted was *not* a bug. The conditions / circumstances have c=
hanged more recently, and the assumption about bzip2 has been invalidated *=
after* adding a dependency on bzip2.
>=20
> Nonetheless, thank you for adapting the code to the potential absence of =
bzip2. Can you perhaps go in some details in the commit message, near "not =
included in default installations" and "freshly installed systems"? If we c=
an, we should identify the exact distro release where this problem has been=
 encountered (and I wouldn't mind a link to the BZ or ticket under which pe=
ople agreed to remove bzip2 from the default package set).

bzip2 is no longer a favored compression.  If we are trying to pick a=20
compression that is most likely to be present on any system, go with=20
gzip.  If we are trying to pick a compression that packs tighter and=20
uncompresses faster, pick xz or zstd.  But bzip2 does neither: it packs=20
slightly tighter than gzip but has slower performance in doing so, and=20
thus is no longer used as a default compression.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org



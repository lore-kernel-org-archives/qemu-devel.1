Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3EBC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ABE620679
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YeBrV0VB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ABE620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXn3D-0006Qm-IB
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 09:03:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iXmzi-0003Qn-Lv
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:59:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iXmzh-0002mQ-Cf
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:59:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39081
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iXmzh-0002kr-9F
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:59:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574344776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dr1FDpYQYUF+dPHZ5bGQnuXa8fRdZCJH1X6JVtujSDo=;
 b=YeBrV0VBOoiVjMU4yvpzyWwLV7DIDM+pl6FNimiwjg1nKwcaJK9LkrYI2kV5pbmS5/Q1Bm
 lcVxlc+nWit1nAZqXMIB8/GGX/vRvUDIw3AHQjYaHRXlJqfr2aLAEYqhInExjyYdC8si1D
 REcfd65ecHoa2TzQw1y75u1PP+f7884=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-ATnh_TUsNPGzESq553NB9g-1; Thu, 21 Nov 2019 08:59:35 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E5938018A3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 13:59:34 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B26955F92F;
 Thu, 21 Nov 2019 13:59:33 +0000 (UTC)
Subject: Re: [qemu-web PATCH] Add a blog post about the QEMU-related
 presentation of KVM Forum 2019
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20191121115207.5832-1-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d25b1eb9-343d-f8bf-f090-4e8d77ad8383@redhat.com>
Date: Thu, 21 Nov 2019 07:59:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191121115207.5832-1-thuth@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: ATnh_TUsNPGzESq553NB9g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/21/19 5:52 AM, Thomas Huth wrote:
> There have been quite a lot of QEMU-related talks at KVM Forum this
> year - let's provide a summary for the people who could not attend.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   Note: For some talks it's hard to decide whether they really fit the
>   QEMU blog or not. I've assembled the list below by quickly skimming
>   through the schedule and the videos, and that's what I came up with ...
>   If you think any of the other talks should be mentioned here, too,
>   please let me know.

Perhaps:

[Making the Most of NBD](https://www.youtube.com/watch?v=3DPMa6KFX9AxM) by=
=20
Eric Blake and Richard Jones

which mentions optimizations to 'qemu-img convert' made possible through=20
NBD protocol extensions

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org



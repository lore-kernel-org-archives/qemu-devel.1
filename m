Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310A3C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 14:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F15E820782
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 14:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrRsR32k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15E820782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEwSL-0005GM-5Q
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 10:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jEwRR-0004cK-47
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jEwRP-00087v-8w
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:46:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:52811)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jEwRP-000879-4K
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584629194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ub5mJmKhtdifdLFS3fZG0R8UeiaHw1WcicVCpjUz/20=;
 b=RrRsR32ksLwoCzCwrTU6R0TywcI1UayBlHN0iuWyAxVZpkqPs4IlExEcAbvbs/JT4llmxp
 GIlc8GQRiGw0BW8bP6DP0csTAq5MWlPBrHdDTeWrgs6ae5Wv1rr2F347ASkb2PQBrvFhT0
 3qnZUyET2ysJKe6ijZYGphG7DVxelvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-6hqhZbvRMBOTFojUwLxcxg-1; Thu, 19 Mar 2020 10:46:33 -0400
X-MC-Unique: 6hqhZbvRMBOTFojUwLxcxg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B76899786F;
 Thu, 19 Mar 2020 14:46:31 +0000 (UTC)
Received: from localhost (unknown [10.40.208.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B80B4BBBEE;
 Thu, 19 Mar 2020 14:46:28 +0000 (UTC)
Date: Thu, 19 Mar 2020 15:46:26 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Heyi Guo <guoheyi@huawei.com>
Subject: Re: [PATCH v4 0/2] add new options to set smbios type 4 fields
Message-ID: <20200319154626.551a7852@redhat.com>
In-Reply-To: <20200318064820.19363-1-guoheyi@huawei.com>
References: <20200318064820.19363-1-guoheyi@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 wanghaibin.wang@huawei.com, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 14:48:18 +0800
Heyi Guo <guoheyi@huawei.com> wrote:

> Common VM users sometimes care about CPU speed, so we add two new
> options to allow VM vendors to present CPU speed to their users.
> Normally these information can be fetched from host smbios.

it's probably too late for this series due to soft-freeze,
pls repost once 5.0 is released

>=20
> v3 -> v4:
> - Fix the default value when not specifying "-smbios type=3D4" option;
>   it would be 0 instead of 2000 in previous versions
> - Use uint64_t type to check value overflow
> - Add test case to check smbios type 4 CPU speed
>=20
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
>=20
> Heyi Guo (2):
>   hw/smbios: add options for type 4 max-speed and current-speed
>   tests/bios-tables-test: add smbios cpu speed test
>=20
>  hw/smbios/smbios.c             | 36 +++++++++++++++++++++++++----
>  qemu-options.hx                |  3 ++-
>  tests/qtest/bios-tables-test.c | 42 ++++++++++++++++++++++++++++++++++
>  3 files changed, 76 insertions(+), 5 deletions(-)
>=20



Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66657C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:09:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A302087E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JuaGI/Wb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A302087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iue71-0003Td-1m
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:09:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iubw5-0006M7-4n
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:50:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iubw3-0000PQ-Tt
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:50:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22262
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iubw3-0000Mb-Ob
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579783811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8uwTBTYdE94Cmo1wsjToF423Flsydw/GLIHlPO32hQU=;
 b=JuaGI/WbpQ6bT3YxU7sbNuNH9dr6uNWSFnTc+7G4BDMnazCMLkTk/ekLQTYeSollFYOe66
 OQvh4tcxmOX+BymMojN/zjhjua37K/JlJ4jhm8SOsisgkg7UdTQJeiE+abm2AdS/8BYIH5
 8TzNcS7DfUI7tB7JclmPTN2/OWQvi1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-mioDkcWYNQW6q4IgZR-o8Q-1; Thu, 23 Jan 2020 07:50:07 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 517B318FE861;
 Thu, 23 Jan 2020 12:50:06 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FBDE2898F;
 Thu, 23 Jan 2020 12:50:05 +0000 (UTC)
Date: Thu, 23 Jan 2020 13:50:02 +0100
From: Andrew Jones <drjones@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH REPOST v3 18/80] arm/mcimx6ul-evk: use memdev for RAM
Message-ID: <20200123125002.bcdbwbfankqsn6bz@kamzik.brq.redhat.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-19-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1579779525-20065-19-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: mioDkcWYNQW6q4IgZR-o8Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 jcd@tribudubois.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 23, 2020 at 12:37:43PM +0100, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> PS:
>   remove no longer needed MCIMX6ULEVK
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: drjones@redhat.com
> CC: jcd@tribudubois.net
> CC: peter.maydell@linaro.org
> CC: qemu-arm@nongnu.org
> ---
>  hw/arm/mcimx6ul-evk.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
>

I don't know anything about mcimx6ul-evk, but I promised Igor to put
another pair of eyes on his changes. Looks fine to me.

Reviewed-by: Andrew Jones <drjones@redhat.com>



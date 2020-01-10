Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F31C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 13:55:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D104F2072E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 13:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YACHpBGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D104F2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipukx-0007kt-SR
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 08:55:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ipukD-0007Bz-TM
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 08:54:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ipukC-0004xv-VD
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 08:54:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27788
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ipukC-0004t7-QW
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 08:54:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578664471;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMc8I8r5BwW1B2K1nT58Yep2cvdobamuQW2KAMUTiLc=;
 b=YACHpBGiX34YvVUnhq+ks61r57WDHcCnmtfu0xaexOckJvLZy+az2lXKkCBWXcfZq+aJjE
 +Pv6zlhDimYYCc7sNQqQbBVPTmDvfvKI/kMFBm7jrd/Ax22b8FZ3pRrkoW8gVjDHscO1x1
 7KQnvECbkDIjS1Az0Ax/M2OrDo/Xw1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-nWkFgTKGN4KWlgtUwOlHJw-1; Fri, 10 Jan 2020 08:54:30 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E3C5801F91;
 Fri, 10 Jan 2020 13:54:29 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A00B5C1D4;
 Fri, 10 Jan 2020 13:54:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: - - <nevilad@yahoo.com>
Subject: Re: [PATCH] Bug #1829242 correction
In-Reply-To: <694638341.1321046.1573223493407@mail.yahoo.com>
 (nevilad@yahoo.com's message of "Fri, 8 Nov 2019 14:31:33 +0000
 (UTC)")
References: <694638341.1321046.1573223493407.ref@mail.yahoo.com>
 <694638341.1321046.1573223493407@mail.yahoo.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 10 Jan 2020 14:54:27 +0100
Message-ID: <87sgknxvqk.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: nWkFgTKGN4KWlgtUwOlHJw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
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
Reply-To: quintela@redhat.com
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

- - <nevilad@yahoo.com> wrote:
> Bug #1829242 correction. Added type conversions to ram_addr_t
> before all left shifts of page indexes to TARGET_PAGE_BITS, to correct
> overflows when the page address was 4Gb and more.
>
> Signed-off-by: Alexey Romko <nevilad@yahoo.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

I have to "redo" the patch, as it is very mangled.  I think I put the
author/text/changes correctly O:-)

Queued.

Thanks, Juan.



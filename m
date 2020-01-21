Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD8CC33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A75AE24653
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkXs1rQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75AE24653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itwg7-0006eo-9b
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 11:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1itwdx-0004fA-AL
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:44:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1itwdu-00057C-M0
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:44:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49386
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1itwdu-00056m-Iz
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579625082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OGA6nY8faJLhtYBzCSYOEhl28mtllZ72bndy45JENKU=;
 b=SkXs1rQQ0uHze/XAyxdmBQWjSCF1to9II8p77r0i/sMMDpgkSysVVRAJGBX4DzsKSxeqwA
 EGZCUiHIFqIipxUS65+hKMQeis5jvWAWo9NKR5Ucs7++80HrohKIcpEwhQ2ts77ao2oNGj
 ngAjOvXkrL85MGQ7LsOo821/mmss6Z8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-7Vpd2-W7NZOwx3-OPFbdHg-1; Tue, 21 Jan 2020 11:44:25 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38A761007C1D;
 Tue, 21 Jan 2020 16:44:23 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B6698573F;
 Tue, 21 Jan 2020 16:44:03 +0000 (UTC)
Date: Tue, 21 Jan 2020 17:44:01 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 00/10] Cleanups around the 'current_machine' global
 variable
Message-ID: <20200121174401.269a4fff.cohuck@redhat.com>
In-Reply-To: <11145254-2dfe-a699-2f92-b11b287d7ab8@redhat.com>
References: <20200121110349.25842-1-philmd@redhat.com>
 <11145254-2dfe-a699-2f92-b11b287d7ab8@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 7Vpd2-W7NZOwx3-OPFbdHg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Richard Henderson <rth@twiddle.net>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jan 2020 17:27:09 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 21/01/20 12:03, Philippe Mathieu-Daud=C3=A9 wrote:
> > v1 was "Replace current_machine by qdev_get_machine()":
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg669611.html
> >=20
> > But Markus objected, see:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg670122.html
> > and older discussion:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg611338.html
> >=20
> > This series salvage patches from v1, and add other trivial cleanups.
> >=20
> > Can the ARM/PPC/S390 patches could go via their own tree, and the
> > rest via Paolo's 'misc' tree? =20
>=20
> I think they're trivial enough so (with the exception of patch 7) I have
> queued them.

I had already queued the s390 patch; let's just see who gets their pull
req out first, I can also unqueue it again.



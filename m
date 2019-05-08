Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA82C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5342121019
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5342121019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35160 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOKiC-0004wZ-Je
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 07:26:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOKc5-0008GU-K0
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOKc4-0005cK-Q1
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:19:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hOKc4-0005bn-KD
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:19:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA0DA3019882;
	Wed,  8 May 2019 11:19:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F3E260C67;
	Wed,  8 May 2019 11:19:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id D3FBE1132B35; Wed,  8 May 2019 13:19:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: mst@redhat.com
References: <20190402161900.7374-1-armbru@redhat.com>
Date: Wed, 08 May 2019 13:19:47 +0200
In-Reply-To: <20190402161900.7374-1-armbru@redhat.com> (Markus Armbruster's
	message of "Tue, 2 Apr 2019 18:18:57 +0200")
Message-ID: <87h8a55h2k.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Wed, 08 May 2019 11:19:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/3] acpi: More trace points
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: imammedo@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping?

Markus Armbruster <armbru@redhat.com> writes:

> I wrote these patches to help me debug an unplug failure.  I expect
> them to be helpful for others, too.
>
> Markus Armbruster (3):
>   acpi/piix4: Convert debug printf()s to trace events
>   acpi/pcihp: Convert debug printf()s to trace events
>   acpi/pcihp: Add a few more trace points related to unplug
>
>  hw/acpi/pcihp.c      | 32 +++++++++++++++-----------------
>  hw/acpi/piix4.c      | 14 +++-----------
>  hw/acpi/trace-events | 16 ++++++++++++++++
>  3 files changed, 34 insertions(+), 28 deletions(-)


Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D957EC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:34:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE07D2166E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE07D2166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyuar-0005tr-T5
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 04:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msuchanek@suse.de>) id 1iyua8-0004yB-RD
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:33:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msuchanek@suse.de>) id 1iyua7-0005A6-Oq
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:33:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:49414)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <msuchanek@suse.de>)
 id 1iyua7-00056H-Io; Tue, 04 Feb 2020 04:33:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9C279AC65;
 Tue,  4 Feb 2020 09:33:17 +0000 (UTC)
Date: Tue, 4 Feb 2020 10:33:15 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: Restrictions of libnet (was: Re: VW ELF loader)
Message-ID: <20200204093314.GU4113@kitsune.suse.cz>
References: <ec81cca1-d5fb-3f1e-b433-3328d81a117e@redhat.com>
 <de7e4d34-eb63-904c-3475-7feee154c72c@ozlabs.ru>
 <8420784f-b4c7-9864-8534-b94dbc5f74ff@redhat.com>
 <d63ba962-ffbb-9f27-34fb-657188e90194@ozlabs.ru>
 <CABgObfYwtrh_uy8zFmg2qDjK6iynniN6=jJ9_MKfNxXUaOkPKw@mail.gmail.com>
 <71d1cc16-f07d-481d-096b-17ee326157bb@ozlabs.ru>
 <CABgObfa4tUVBbpBtoY3JFSF8-0mRVxgGbzQokc+JrJGPagwPaQ@mail.gmail.com>
 <d13eea1d-7942-47e0-6189-a66ce9639db4@redhat.com>
 <20200204095403.04d9dd29.conny@cornelia-huck.de>
 <4794cf7a-7b53-5fea-c89d-baa01d3ed0ce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4794cf7a-7b53-5fea-c89d-baa01d3ed0ce@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic]
X-Received-From: 195.135.220.15
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Cornelia Huck <conny@cornelia-huck.de>, qemu-devel <qemu-devel@nongnu.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On Tue, Feb 04, 2020 at 10:20:14AM +0100, Thomas Huth wrote:

> 
> So IMHO the s390x world should move towards grub2, too. We could e.g.
> link it initially into the s390-ccw bios bios ... and if that works out
> well, later also use it as normal bootloader instead of zipl (not sure
> if that works in all cases, though, IIRC there were some size
> constraints and stuff like that).

AFAIK the main reason why it does not work is that grub does not have
ccw drivers.

That aside it would be welcome to get it working.

Thanks

Michal


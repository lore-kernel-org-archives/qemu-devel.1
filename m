Return-Path: <SRS0=Pmsr=VD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9309FC5B578
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 04:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F7821670
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 04:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F7821670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjcQv-0007Wm-NQ
	for qemu-devel@archiver.kernel.org; Sat, 06 Jul 2019 00:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56443)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hjcQ3-00072Y-2W
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 00:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hjcQ0-00079Y-PK
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 00:35:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47604)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hjcPr-000719-Ot
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 00:35:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8A1CA368E3;
 Sat,  6 Jul 2019 04:35:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5843151409;
 Sat,  6 Jul 2019 04:35:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BBDC31132ABF; Sat,  6 Jul 2019 06:35:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
References: <1562356239-19391-1-git-send-email-pbonzini@redhat.com>
 <1562356239-19391-12-git-send-email-pbonzini@redhat.com>
 <87r273g571.fsf@dusky.pond.sub.org>
Date: Sat, 06 Jul 2019 06:35:11 +0200
In-Reply-To: <87r273g571.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Sat, 06 Jul 2019 06:25:22 +0200")
Message-ID: <87ef33g4qo.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Sat, 06 Jul 2019 04:35:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 11/12] hw/i386: Fix linker error when ISAPC
 is disabled
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
Cc: Julio Montes <julio.montes@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
>> From: Julio Montes <julio.montes@intel.com>
>>
>> v2: include config-devices.h to use CONFIG_IDE_ISA
>>
>> Message-Id: <20190705143554.10295-2-julio.montes@intel.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> You lost Julio's S-o-B due to his ill-advised '---' line.  Also the part
> of his commit message that should be committed.  Same for PULL 10/12.

Ah, you fixed the S-o-B in v2.  You decide whether restoring the lost
parts of the commit message is worth a respin.


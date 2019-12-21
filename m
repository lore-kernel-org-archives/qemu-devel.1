Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67E2C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 08:00:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB2521927
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 08:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/aY2eiw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB2521927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiZgA-0006V4-OJ
	for qemu-devel@archiver.kernel.org; Sat, 21 Dec 2019 03:00:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iiZfQ-00066J-GW
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 02:59:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iiZfP-0007ab-60
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 02:59:16 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32818
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iiZfO-0007WJ-SD
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 02:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576915154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rhhBsuSfyKZCSUJ18AIFRMM0qBWCpL6p/RsrJP44J3U=;
 b=M/aY2eiwbHduxAxN4MfTYFfFDTjG29vZA0iAqRYwPouynPmRr36gYQY3GDfOlCGyQDLAdQ
 0WiQIsr1+s2vRCXD9MDaleqwNZ4rLO1AMa0EwxIAQRLSTH8SFL70ktudTfAi0YRtzdrtUb
 DsIPc012ffSt4omIUQwtoOr3frrSZRc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-ZjQaxvi7PDubvowrCrdV1A-1; Sat, 21 Dec 2019 02:59:12 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A460800D41
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2019 07:59:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C4C11001902;
 Sat, 21 Dec 2019 07:59:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D36C011385C9; Sat, 21 Dec 2019 08:59:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: Can we retire Python 2 now?
References: <8736dfdkph.fsf@dusky.pond.sub.org>
 <20191220165627.GV498046@habkost.net>
Date: Sat, 21 Dec 2019 08:59:09 +0100
In-Reply-To: <20191220165627.GV498046@habkost.net> (Eduardo Habkost's message
 of "Fri, 20 Dec 2019 13:56:27 -0300")
Message-ID: <87tv5up0s2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ZjQaxvi7PDubvowrCrdV1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Fri, Dec 20, 2019 at 05:29:30PM +0100, Markus Armbruster wrote:
>> Python 2 EOL is only a few days away[*].  We made configure bitch about
>> it in commit e5abf59eae "Deprecate Python 2 support", 2019-07-01.  Any
>> objections to retiring it now, i.e. in 5.0?
>
> Thanks for the reminder!
>
> I'll be honest: even if somebody in this list objects to dropping
> Python 2 support, I'm not willing to be maintainer of a Python 2
> codebase in 2020.  The only reason for not doing it in 4.1 was
> the tests/vm/netbsd breakage we took very long to debug and fix.

I wasn't exactly "willing" in 2019...

> I have just submitted this pull request:
>
>   Subject: [PULL 0/2] Require Python >=3D 3.5 to build QEMU
>   https://lore.kernel.org/qemu-devel/20191220165141.2207058-1-ehabkost@re=
dhat.com/

Awesome, thanks!



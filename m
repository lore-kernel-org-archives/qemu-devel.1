Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099C6C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 11:09:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6892089F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 11:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6892089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49818 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfMqP-00040L-VL
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 07:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52869)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hfMoe-00025o-N5
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hfMod-0004pp-MV
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:07:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53508)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hfMod-0004nu-DK
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:07:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 59C1BA70E;
 Mon, 24 Jun 2019 11:07:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-169.ams2.redhat.com
 [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2368619C69;
 Mon, 24 Jun 2019 11:07:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 97DAC11386A0; Mon, 24 Jun 2019 13:07:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>
References: <20190619201050.19040-1-armbru@redhat.com>
 <20190619201050.19040-2-armbru@redhat.com>
 <e0595422-c115-ca7f-9e3c-cfb69602d5e2@suse.de>
Date: Mon, 24 Jun 2019 13:07:12 +0200
In-Reply-To: <e0595422-c115-ca7f-9e3c-cfb69602d5e2@suse.de> ("Andreas
 =?utf-8?Q?F=C3=A4rber=22's?= message of "Wed, 19 Jun 2019 22:31:23 +0200")
Message-ID: <87o92ns0m7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 24 Jun 2019 11:07:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 01/17] MAINTAINERS: new maintainers for QOM
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
Cc: kwolf@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Andreas F=C3=A4rber <afaerber@suse.de> writes:

> Am 19.06.19 um 22:10 schrieb Markus Armbruster:
>> From: Paolo Bonzini <pbonzini@redhat.com>
>>=20
>> QOM is not a particularly active subsystem now: 51 commits in two years.
>> But, we need active maintainers to review and merge patches, and Git
>> shows the following top committers taking on QOM:
>>=20
>>     Markus Armbruster <armbru@redhat.com>
>>     Eduardo Habkost <ehabkost@redhat.com>
>>     Paolo Bonzini <pbonzini@redhat.com>
>>     Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>     Eric Blake <eblake@redhat.com>
>>=20
>> I volunteer myself, and also volunteer Eduardo and Daniel as reviewers
>> since they understand the code well.
>>=20
>> Cc: Andreas F=C3=A4rber <afaerber@suse.de>
>> Cc: Daniel P. Berrange <berrange@redhat.com>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> Message-Id: <20190607113737.13473-1-pbonzini@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> I'm pretty sure I gave an Acked-by that's missing above?

My fault.  I'll make sure it's in v2 or else the pull request.


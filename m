Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC22CC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:35:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95DC220B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DC220B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51172 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZF1M-0001NL-LL
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37842)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hZExD-0007Eq-If
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hZExB-00089e-Cy
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:30:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48338)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hZExB-00083h-4b
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:30:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 27D56776F0;
 Fri,  7 Jun 2019 13:30:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E76C0614C3;
 Fri,  7 Jun 2019 13:30:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7305C11386A0; Fri,  7 Jun 2019 15:30:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>
References: <20190607113737.13473-1-pbonzini@redhat.com>
 <f18cb164-d742-04c3-37b6-ba10f72bcd0c@suse.de>
Date: Fri, 07 Jun 2019 15:30:26 +0200
In-Reply-To: <f18cb164-d742-04c3-37b6-ba10f72bcd0c@suse.de> ("Andreas
 =?utf-8?Q?F=C3=A4rber=22's?= message of "Fri, 7 Jun 2019 14:29:46 +0200")
Message-ID: <87h891bk0d.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 07 Jun 2019 13:30:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: new maintainers for QOM
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Andreas F=C3=A4rber <afaerber@suse.de> writes:

> Am 07.06.19 um 13:37 schrieb Paolo Bonzini:
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
>> ---
>>  MAINTAINERS | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a96829ea83..c5862db154 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2031,9 +2031,10 @@ F: docs/interop/qemu-ga-ref.texi
>>  T: git https://github.com/mdroth/qemu.git qga
>>=20=20
>>  QOM
>> -M: Andreas F=C3=A4rber <afaerber@suse.de>
>> +M: Paolo Bonzini <pbonzini@redhat.com>
>> +R: Daniel P. Berrange <berrange@redhat.com>
>> +R: Eduardo Habkost <ehabkost@redhat.com>
>
> Thanks for volunteering,
>
> Acked-by: Andreas F=C3=A4rber <afaerber@suse.de>

Andreas, I'd like to use this opportunity to thank you for your
distinguished service.


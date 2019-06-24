Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC73C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 11:24:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5684D20674
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 11:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5684D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49988 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfN5T-0005C6-Fj
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 07:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59242)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hfN37-0003iL-Ad
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hfN35-000143-Ml
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:22:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60752)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hfN35-00010p-7v
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:22:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E27C43082231
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 11:22:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-169.ams2.redhat.com
 [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB168600CD;
 Mon, 24 Jun 2019 11:22:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C88111386A0; Mon, 24 Jun 2019 13:22:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
References: <20190619201050.19040-1-armbru@redhat.com>
 <20190619201050.19040-8-armbru@redhat.com>
 <20190620084158.GI25448@redhat.com>
Date: Mon, 24 Jun 2019 13:22:07 +0200
In-Reply-To: <20190620084158.GI25448@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
 =?utf-8?Q?rang=C3=A9=22's?=
 message of "Thu, 20 Jun 2019 09:41:58 +0100")
Message-ID: <87ef3jrzxc.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 24 Jun 2019 11:22:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 07/17] MAINTAINERS: Merge sections CPU,
 NUMA into Machine core
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
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Jun 19, 2019 at 10:10:40PM +0200, Markus Armbruster wrote:
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  MAINTAINERS | 16 ++++------------
>>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1aef0afaf7..f18fddbbbb 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1268,8 +1268,12 @@ S: Supported
>>  F: hw/core/machine.c
>>  F: hw/core/null-machine.c
>>  F: hw/cpu/cluster.c
>> +F: numa.c
>> +F: qom/cpu.c
>
> Not a blocker for this patch, but as a later patch, I'd encourage you to
> move qom/cpu.c somewhere else. Pretty much anywhere else would be better
> than under qom/ IMHO :-)

Eduardo, any ideas?

>>  F: include/hw/boards.h
>>  F: include/hw/cpu/cluster.h
>> +F: include/qom/cpu.h
>
> Likewise
>
>> +F: include/sysemu/numa.h
>>  T: git https://github.com/ehabkost/qemu.git machine-next
>>=20=20
>>  Xtensa Machines
[...]


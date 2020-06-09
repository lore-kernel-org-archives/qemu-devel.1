Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378F3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003B92078D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSZks3yU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003B92078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiZqq-0005vX-8e
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 04:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jiZpY-00055a-NB
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:42:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51387
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jiZpW-0002R9-DX
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591692117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sgk0RnSjsl5gYIfNLKz93g33rVvrsEliE96cWKZ2dcg=;
 b=gSZks3yUDMJW7myxcuKjWQvIsmtqt1mE0Ncz9vs/aAa+mHNNy7RiClmPLVU3mGKCJP0whz
 pEHakrJBx6iZxRw+pXOJIEbjim69zH+B6iVRE4QbtwlXVeyDup6QJspKLnKI/PQDBwwbtl
 9kRHExyfoojTJ68EiQtWE7RfJ6sxo9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-gvy1-JhXOFyhlmV1fhhHYA-1; Tue, 09 Jun 2020 04:41:53 -0400
X-MC-Unique: gvy1-JhXOFyhlmV1fhhHYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EE651009441;
 Tue,  9 Jun 2020 08:41:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E98460CD0;
 Tue,  9 Jun 2020 08:41:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1EE9411386A6; Tue,  9 Jun 2020 10:41:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 2/8] MAINTAINERS: Mark SH4 based R2D & Shix machines
 orphan
References: <20200608090142.6793-1-f4bug@amsat.org>
 <20200608090142.6793-3-f4bug@amsat.org>
 <8f97580c-bf25-dd83-e23e-dcea1e6ce6b7@redhat.com>
Date: Tue, 09 Jun 2020 10:41:48 +0200
In-Reply-To: <8f97580c-bf25-dd83-e23e-dcea1e6ce6b7@redhat.com> (Thomas Huth's
 message of "Mon, 8 Jun 2020 11:48:12 +0200")
Message-ID: <875zc0skab.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thomas Huth <thuth@redhat.com> writes:

> On 08/06/2020 11.01, Philippe Mathieu-Daud=C3=A9 wrote:
>> Last commit from Magnus Damm is fc8e320ef583, which date is
>> Fri Nov 13 2009.  As nobody else seems to care about the patches
>> posted [*] related to the R2D and Shix machines, mark them orphan.
>>=20
>> Many thanks to Magnus for his substantial contributions to QEMU,
>> and for introducing these SH4 based machine!

s/machine/machines/

>>=20
>> [*] https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08519.html
>>=20
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  MAINTAINERS | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 49d90c70de..a012d9b74e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1250,14 +1250,15 @@ SH4 Machines
>>  ------------
>>  R2D
>>  M: Magnus Damm <magnus.damm@gmail.com>
>> -S: Maintained
>> +S: Orphan
>>  F: hw/sh4/r2d.c
>>  F: hw/intc/sh_intc.c
>>  F: hw/timer/sh_timer.c
>> +F: include/hw/sh4/sh_intc.h
>> =20
>>  Shix
>>  M: Magnus Damm <magnus.damm@gmail.com>
>> -S: Odd Fixes
>> +S: Orphan
>>  F: hw/sh4/shix.c
>
> Having both, an "M:" entry and "S: Orphan" in a section sounds weird.
> Magnus, are you still interested in these sections? If not, I think the
> "M:" line should be removed...?

Concur.  Of course, let's give Magnus a chance to chime in.



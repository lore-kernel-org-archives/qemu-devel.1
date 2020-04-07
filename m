Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5943EC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34CB2063A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FoXXZmjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34CB2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLmdG-0002NP-0R
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 07:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jLmcO-0001YP-VO
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jLmcN-000681-US
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:42:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20009
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jLmcN-00067a-RF
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586259731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YIyINTCo+c85ZDVFjJw6uH02aif6k+XK2F8JEPWlizw=;
 b=FoXXZmjKRVo98n+f5QUy8/cF2kgngcYCit0eJRW72Bbnv0VUjNII9n0Qu1uq8FdjuP/Ato
 RIqArF3NizPJE8372xGGRDa/7knyDF/oXCPfiMTcM42EU1UxG91FCElViVH6cw7oedVGEe
 Z6/I95Xt3Vrfyd3gJl1ukAZqg3LI5VY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-5ntJEqunNyekV1fD5QsQrg-1; Tue, 07 Apr 2020 07:42:08 -0400
X-MC-Unique: 5ntJEqunNyekV1fD5QsQrg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF7661005514;
 Tue,  7 Apr 2020 11:42:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 683B05E000;
 Tue,  7 Apr 2020 11:42:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D994811385C8; Tue,  7 Apr 2020 13:42:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Simran Singhal <singhalsimran0@gmail.com>
Subject: Re: [PATCH v3] qobject: json-streamer: Change bracket_count to
 brace_count
References: <20200402182848.GA3023@simran-Inspiron-5558>
 <87eet5t67y.fsf@dusky.pond.sub.org>
Date: Tue, 07 Apr 2020 13:42:05 +0200
In-Reply-To: <87eet5t67y.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Fri, 03 Apr 2020 08:48:33 +0200")
Message-ID: <87y2r7v7xu.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Julia Suvorova <jusual@mail.ru>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Simran Singhal <singhalsimran0@gmail.com> writes:
>
>> Change the "parser->bracket_count >=3D 0" to "parser->brace_count >=3D 0=
"
>> to fix the typo.
>>
>> Fixes: 8d3265b3
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
>
> First, thank you so much for spotting and fixing my typo!
>
> The commit message neglects to explain what is broken.  I'd like to use
> this one:
>
>   json: Fix check for unbalanced right curly brace
>
>   We immediately diagnose unbalanced right curly brace:
>
>       $ qemu-kvm --nodefaults --nographic --qmp stdio
>       {"QMP": {"version": {"qemu": {"micro": 91, "minor": 2, "major": 4},
>       "package": "v5.0.0-rc1-1-gf6ce4a439a08"}, "capabilities": ["oob"]}}
>       }
>       {"error": {"class": "GenericError", "desc": "JSON parse error,
>       expecting value"}}
>
>   except within square bracket:
>
>       [}
>
>   The check for unbalanced braces has a typo.  Fix it.
>
>   Fixes: 8d3265b3d00db1071d1d3bf8433b4818088fdeb5
>   Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
>   Reviewed-by: Eric Blake <eblake@redhat.com>
>
> Objections?

Apparently none.  Queued, thanks!

[...]



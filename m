Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58381C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 11:56:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A2DC20673
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 11:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2DC20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCMx1-0002fY-9k
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 07:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCMw3-00029J-3z
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCMw1-0003r9-Rv
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:55:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48802)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCMw1-0003ps-M6
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:55:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9E55A190C006;
 Mon, 23 Sep 2019 11:55:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D1775D717;
 Mon, 23 Sep 2019 11:55:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8D9C5113864E; Mon, 23 Sep 2019 13:55:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/19] tests/qapi-schema: Demonstrate
 insufficient 'if' checking
References: <20190914153506.2151-1-armbru@redhat.com>
 <20190914153506.2151-6-armbru@redhat.com>
 <ca7e3eba-98ba-56cb-574f-d9974f39122b@redhat.com>
Date: Mon, 23 Sep 2019 13:55:11 +0200
In-Reply-To: <ca7e3eba-98ba-56cb-574f-d9974f39122b@redhat.com> (Eric Blake's
 message of "Tue, 17 Sep 2019 12:47:50 -0500")
Message-ID: <87r247ns68.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Mon, 23 Sep 2019 11:55:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 9/14/19 10:34 AM, Markus Armbruster wrote:
>> Cover invalid 'if' in struct members, features, union and alternate
>> branches.  Four out of four are broken.  Mark FIXME.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
> Embarrassing. But the fact that you're pointing them out presumably
> means that you fix it later in the series ;)

Yes:
[PATCH 09/19] qapi: Remove null from schema language
[PATCH 12/19] qapi: Fix missing 'if' checks in struct, union, alternate 'data'

>> +++ b/tests/qapi-schema/features-if-invalid.json
>> @@ -0,0 +1,5 @@
>> +# Cover feature with invalid 'if'
>> +# FIXME not rejected, misinterpreded as unconditional
>
> misinterpreted
>
> With the typo fix,
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

>> +++ b/tests/qapi-schema/struct-member-if-invalid.json
>> @@ -0,0 +1,4 @@
>> +# Cover member with invalid 'if'
>> +# FIXME not rejected, would generate '#if True\n'
>
> Which might actually compile, depending on what else is present in
> various headers!  But certainly not what was intended.
>
>> +++ b/tests/qapi-schema/union-branch-if-invalid.json
>> @@ -0,0 +1,7 @@
>> +# Cover branch with invalid 'if'
>> +# FIXME not rejected, would generate '#if \n'
>> +{ 'enum': 'Branches', 'data': ['branch1'] }
>> +{ 'struct': 'Stru', 'data': { 'member': 'str' } }
>> +{ 'union': 'Uni',
>> +  'base': { 'tag': 'Branches' }, 'discriminator': 'tag',
>> +  'data': { 'branch1': { 'type': 'Stru', 'if': [''] } } }
>
> So you're pointing out a difference between an empty string and a string
> not containing a C macro name (possibly because later patches will give
> them different error messages).

Not sure I got this comment.


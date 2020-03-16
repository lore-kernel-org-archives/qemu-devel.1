Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F832C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:02:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4741820663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZheKvw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4741820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDv0B-0003l2-FB
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jDuZZ-0004B6-Sk
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jDuZX-00062E-Ti
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:34:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46340)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jDuZX-0005rG-P7
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584383682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HEcY6cL30ap/GlNtA0PLagV8dLpDs0nxmXzFdVBA4OM=;
 b=JZheKvw60bboBwlwOn+5f+vk5v189Edz/C4j7GIng9MTAcM7fTj8zdA/iAMk6bfFDk42EP
 +PcGYZCEeWGlL2TScodZn/TAjhUQ2jVp1aR2dAPVzXQZSQWMjPfMPNK1fLyuNCMatV3UIY
 8qeSX6g665S759cxwZ0L/ZGDHENqkoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-B0-X1-wPP8a17_TbYF3Zew-1; Mon, 16 Mar 2020 14:34:40 -0400
X-MC-Unique: B0-X1-wPP8a17_TbYF3Zew-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6962C8E91A3;
 Mon, 16 Mar 2020 18:34:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-49.ams2.redhat.com
 [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BC328AC30;
 Mon, 16 Mar 2020 18:34:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BF5071138404; Mon, 16 Mar 2020 19:34:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 01/34] qemu-doc: Belatedly document QMP command arg &
 result deprecation
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-2-armbru@redhat.com>
 <25da4d26-094d-e74c-d0d6-8e159c96191f@redhat.com>
Date: Mon, 16 Mar 2020 19:34:37 +0100
In-Reply-To: <25da4d26-094d-e74c-d0d6-8e159c96191f@redhat.com> (Eric Blake's
 message of "Mon, 16 Mar 2020 10:10:09 -0500")
Message-ID: <87v9n4w3lu.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 3/15/20 9:46 AM, Markus Armbruster wrote:
>> A number of deprecated QMP arguments and results were missed in commit
>> eb22aeca65 "docs: document deprecation policy & deprecated features in
>> appendix" (v2.10.0):
>>
>
>>
>> Since then, we missed a few more:
>>
>> * Commit 3c605f4074 "commit: Add top-node/base-node options" (v3.1.0)
>>    deprecated block-commit arguments @base and @top.
>>
>> * Commit 4db6ceb0b5 "block/dirty-bitmap: add recording and busy
>>    properties" (v4.0.0) deprecated query-named-block-nodes result
>>    @dirty-bitmaps member @status, not just query-block.
>>
>> Make up for all that.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   docs/system/deprecated.rst | 48 ++++++++++++++++++++++++++++++++++----
>>   1 file changed, 44 insertions(+), 4 deletions(-)
>
> Should we remove any of these features that have been deprecated long
> enough?  But that can be separate, having this patch just add mention
> that was previously forgotten is fine.

Up to the subsystem maintainers, I'd say.

I think we should sweep deprecated.rst on every release.  Early in the
development cycle seems best.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!



Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5BCC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 11:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C412120674
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 11:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C412120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50064 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfNHE-0004s3-TK
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 07:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34533)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hfNEM-0001cu-Cj
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hfNEL-0001HT-D9
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:33:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44678)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hfNEL-00016N-6W
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:33:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CD28981F1B
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 11:33:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-169.ams2.redhat.com
 [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BBF15C1B5;
 Mon, 24 Jun 2019 11:33:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 21EA811386A0; Mon, 24 Jun 2019 13:33:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
References: <20190619201050.19040-1-armbru@redhat.com>
 <20190619201050.19040-13-armbru@redhat.com>
 <6b9e65f7-8525-6725-4387-f770e275df03@redhat.com>
Date: Mon, 24 Jun 2019 13:33:39 +0200
In-Reply-To: <6b9e65f7-8525-6725-4387-f770e275df03@redhat.com> (Eric Blake's
 message of "Wed, 19 Jun 2019 15:18:13 -0500")
Message-ID: <875zovrze4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 24 Jun 2019 11:33:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 12/17] qapi: Split machine-target.json off
 target.json and misc.json
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 6/19/19 3:10 PM, Markus Armbruster wrote:
>> Move commands query-cpu-definitions, query-cpu-model-baseline,
>> query-cpu-model-comparison, and query-cpu-model-expansion with their
>> types from target.json to machine-target.json.  Also move typee
>
> s/typee/types/

Will fix.  Thanks!

>> CpuModelInfo, CpuModelExpansionType, and CpuModelCompareResult from
>> misc.json there.  Add machine-target.json to MAINTAINERS section
>> "Machine core".
>> 
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---


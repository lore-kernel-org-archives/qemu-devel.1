Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E297BC04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 11:50:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3014207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 11:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3014207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCMri-00072J-Ji
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 07:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCMq2-0005xR-At
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:49:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCMq1-0006ls-79
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:49:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58352)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCMq1-0006lH-1g
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:49:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 495D61DDA;
 Mon, 23 Sep 2019 11:49:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F6C4196AE;
 Mon, 23 Sep 2019 11:49:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0B22A113864E; Mon, 23 Sep 2019 13:49:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/16] qapi: Schema language cleanups &
 doc improvements
References: <20190913201349.24332-1-armbru@redhat.com>
 <32fcbd17-4500-0984-dec6-01598a02c541@redhat.com>
Date: Mon, 23 Sep 2019 13:49:00 +0200
In-Reply-To: <32fcbd17-4500-0984-dec6-01598a02c541@redhat.com> (Eric Blake's
 message of "Tue, 17 Sep 2019 11:31:08 -0500")
Message-ID: <87wodznsgj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Mon, 23 Sep 2019 11:49:04 +0000 (UTC)
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
Cc: marcandre.lureau@redhat.com, Peter Krempa <pkrempa@redhat.com>,
 qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 9/13/19 3:13 PM, Markus Armbruster wrote:
>> v3:
>> * PATCH 05
>>   - Typo fixed [Eric]
>> * PATCH 06+07
>>   - Additional comments [Eric]
>> * PATCH 11
>>   - Replace one more QAPISchemaMember by QAPISchemaEnumMember
>> * PATCH 13+15
>>   - Doc phrasing tweaks [Eric]
>> * PATCH 14+15
>>   - Belatedly update for v2's restriction to printable ASCII [Eric]
>>   - Correct claim "order of top-level expression doesn't matter" [Eric]
>> * PATCH 15
>>   - Fix EBNF for PRAGMA [Eric]
>
> Peter Krempa's proposal to add features to commands (for introspecting
> Kevin's recent savevm fix) slightly conflicts with this.
>
> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03586.html

I'm pretty sure it'll conflict plenty more with the
not-yet-posted-to-avoid-scaring-off-reviewers part of my work.  We'll
work it out :)


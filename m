Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6A0C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B7CA21906
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7CA21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFPgD-0005VR-AQ
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 17:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iFOMn-0001eP-Vw
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 16:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iFOMm-00070n-Sm
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 16:03:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56734)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iFOMm-00070V-NC
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 16:03:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D689FC04AC69;
 Tue,  1 Oct 2019 20:03:23 +0000 (UTC)
Received: from [10.3.116.201] (ovpn-116-201.phx2.redhat.com [10.3.116.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82A2A5C1D4;
 Tue,  1 Oct 2019 20:03:21 +0000 (UTC)
Subject: Re: [PATCH 3/7] qapi: Eliminate accidental global frontend state
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20191001191514.11208-1-armbru@redhat.com>
 <20191001191514.11208-4-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f3ed3848-8606-0179-6a17-7c1d8631b63e@redhat.com>
Date: Tue, 1 Oct 2019 15:03:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191001191514.11208-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 01 Oct 2019 20:03:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 2:15 PM, Markus Armbruster wrote:
> The frontend can't be run more than once due to its global state.
> A future commit will want to do that.
> 
> The only global frontend state remaining is accidental:
> QAPISchemaParser.__init__()'s parameter previously_included=[].
> Python evaluates the default once, at definition time.  Any
> modifications to it are visible in subsequent calls.  Well-known
> Python trap.  Change the default to None and replace it by the real
> default in the function body.  Use the opportunity to convert
> previously_included to a set.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   scripts/qapi/common.py | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


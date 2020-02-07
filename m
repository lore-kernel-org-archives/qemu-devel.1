Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC694C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:34:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A681920838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYiDC2ck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A681920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04i4-00008f-Ql
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:34:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j04gQ-0006KX-Ip
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:32:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j04gP-0000rD-3l
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:32:38 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30038
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j04gO-0000r7-Vl
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581085956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zRbVTfMrigsE3BG5cRVCsqLG+3illxPMVgVY2kn9Ooo=;
 b=QYiDC2ckHfcDgnyWVFbMzVdwxNezKkYGkvKETi5CVR1L3dzFO4ybdLv/RGte9SOKP+Ic2c
 EZFnjxxyLLBOrqCjSBpQehTnSHX78MfJmuFrNAsvL1LYWe0/opA0g+Z6Hr8+PsiC0CbfCt
 xOn/pgGOmkaEjGCxAVhgxoalXrhEuvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-ajK82DigO9O7VkD2WNufxg-1; Fri, 07 Feb 2020 09:32:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B647F8010D6;
 Fri,  7 Feb 2020 14:32:28 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B48F7FB60;
 Fri,  7 Feb 2020 14:32:25 +0000 (UTC)
Subject: Re: should we have a new 'tools' manual?
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA--P9FLM4qBxf23sLuv5Tz4HRgj7ONC7ODxnfZiLph9TA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <2e70328b-5b7b-9e9d-8dfa-2af5c8e2fb28@redhat.com>
Date: Fri, 7 Feb 2020 08:32:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA--P9FLM4qBxf23sLuv5Tz4HRgj7ONC7ODxnfZiLph9TA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ajK82DigO9O7VkD2WNufxg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 5:50 AM, Peter Maydell wrote:
> So far we've been converting docs to Sphinx and assigning them
> to manuals according to the division originally set out by
> Paolo on the wiki: https://wiki.qemu.org/Features/Documentation
> 
>   * QEMU User-mode Emulation User's Guide (docs/user)
>   * QEMU System Emulation User's Guide (docs/system)
>   * QEMU System Emulation Management and Interoperability Guide (docs/interop)
>   * QEMU System Emulation Guest Hardware Specifications (docs/specs)
>   * QEMU Developer's Guide (docs/devel, not shipped to end-users)
> 
> but some of our documentation has always been a bit of an awkward
> fit into this classification:
>   * qemu-img
>   * qemu-nbd
>   * virtfs-proxy-helper
> etc. I've tended to put these things into interop/.
> 
> The proposal from Dan and David was that we should add a sixth
> top-level manual
>   * QEMU Tools Guide (docs/tools)
> 
> which would be a more coherent place for these to live.
> 
> This seems like a good idea to me -- do people agree? What's
> our definition of a "tool", or do we just know one when we see it?
> What in particular should go in tools/ ?

Moving the documentation for both qemu-img and qemu-nbd to tools/ 
instead of interop/ makes sense to me.  I don't know if qemu-io is 
documented well (it's more of an internal tool than a user-visible 
tool), but it could also live in tools/.

As it is, I would love to move toplevel/qemu-nbd.c into a 
tools/qemu-nbd.c directory.  But when I spent a mere 30 minutes seeing 
what it would take, I quickly learned that there is enough arcane 
Makefile magic going on in building from subdirectories that it wasn't 
worth my time to figure out how, especially if all that magic gets 
rewritten anyway during Paolo's conversion to meson.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org



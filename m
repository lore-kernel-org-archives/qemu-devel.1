Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C177C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 21:46:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 159D32075E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 21:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NEem45Zb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159D32075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWRsF-0000sI-7Q
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 17:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWRrP-0000Lp-NB
 for qemu-devel@nongnu.org; Wed, 06 May 2020 17:45:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54335
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWRrO-000683-6E
 for qemu-devel@nongnu.org; Wed, 06 May 2020 17:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588801545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aoMAwRgC6EZsM7ufdlzoxVbOwHn04mmU9bS20iBi01w=;
 b=NEem45Zbwih06Nh1kEXbrRsrTCac8qmChQZD1Bs5tsVeO78wiJX9nwN89DhN/QYzwgT8go
 cYc9czO3hdMw8EIcYeYpwMHjF/TpxzY0/0dRDdEZB4CpFUq2xXN1TZMW4HhQw8UfSzZs6S
 WLf9ciFVgmsOEI4e/AxFhm4I69McY+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-kKSWLaYGOyuinpn_1sIQCA-1; Wed, 06 May 2020 17:45:41 -0400
X-MC-Unique: kKSWLaYGOyuinpn_1sIQCA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FB80107ACCA;
 Wed,  6 May 2020 21:45:40 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8289A5EE13;
 Wed,  6 May 2020 21:45:39 +0000 (UTC)
Subject: Re: [PATCH v2 0/5] Additional parameters for qemu_img map
To: Eyal Moscovici <eyal.moscovici@oracle.com>
References: <59b0896d-85ad-08b5-fcc1-36adad7501a4@redhat.com>
 <20200506213459.44743-1-eyal.moscovici@oracle.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8befa613-1558-b975-2123-d98eb42ebc0e@redhat.com>
Date: Wed, 6 May 2020 16:45:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506213459.44743-1-eyal.moscovici@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 16:22:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, liran.alon@oracle.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/6/20 4:34 PM, Eyal Moscovici wrote:
> Hi,
> 
> The following series adds two parameters to qemu-img map:
> 1. start-offset: mapping starting offset.
> 2. max-length: the length of the mapping.
> 
> These parameters proved useful when mapping large disk spread across
> long store file chains. It allows us to bound the execution time of each
> qemu-img map execution as well as recover from failed mapping
> operations. In addition the map operation can divided to
> multiple independent tasks.
> 
> V2 changes:
> 1. add error reporting to cvtnum.
> 2. add image length validation in img_map.
> 3. rebase over QEMU 5.0.

It's better to post a v2 as a new top-level thread rather than buried 
in-reply-to the v1 thread; among other things, burying a reply can cause 
automated patch tooling to miss the updated series.

But since I see it, I'll review.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org



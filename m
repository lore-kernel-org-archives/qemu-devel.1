Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8121AC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:07:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A6520872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A6520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDtiR-0004yO-V7
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 13:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iDtFu-0004Vt-1O
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 12:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iDtFs-0002FH-0i
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 12:38:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55060)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iDtFk-0001ac-K8; Fri, 27 Sep 2019 12:37:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4F8A28A1CA4;
 Fri, 27 Sep 2019 16:37:53 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AAD355D9C3;
 Fri, 27 Sep 2019 16:37:52 +0000 (UTC)
Subject: Re: [PATCH 1/4] qemu-iotests: remove bash shebang from library files
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20190927141728.7137-1-crosa@redhat.com>
 <20190927141728.7137-2-crosa@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7ce7f9b7-a79e-21c5-18e2-f7f2ec85e575@redhat.com>
Date: Fri, 27 Sep 2019 11:37:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190927141728.7137-2-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Fri, 27 Sep 2019 16:37:53 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/27/19 9:17 AM, Cleber Rosa wrote:
> Due to not being able to find a reason to have shebangs on files that
> are not executable.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/qemu-iotests/common.config  | 2 --
>   tests/qemu-iotests/common.filter  | 2 --
>   tests/qemu-iotests/common.nbd     | 1 -
>   tests/qemu-iotests/common.pattern | 2 --
>   tests/qemu-iotests/common.qemu    | 2 --
>   tests/qemu-iotests/common.rc      | 2 --
>   tests/qemu-iotests/common.tls     | 2 --
>   7 files changed, 13 deletions(-)
> 

Loss of the shebang changes the mode in which emacs opens the files 
(from Shell-script[bash] to Conf[space] in my case).  I agree that a #! 
comment is not appropriate for a file that is not executable as a 
standalone file, but it becomes harder to edit the file correctly unless 
we replace it with some other way of letting editors realize that the 
contents of each file is still meant to be consumed by bash.

Something like this would work:

# hey emacs, this file will be sourced by bash: -*- sh -*-

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


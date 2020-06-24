Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842E4C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 21:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50197207E8
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 21:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EroAeR6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50197207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joDHO-0002Fu-8W
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 17:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1joDGU-0001oK-56
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 17:49:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52237
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1joDGR-0007jN-IC
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 17:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593035342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SAjrh/coeCdJV0shoOnVKt/t3wk7Nl7EN8JqiAyonaw=;
 b=EroAeR6poITyUJBTARnHGWhyItemWPNpQRHDZA5DCI9Wt6NrQ28J8c2Wog+Hgfv+KhXZj5
 DKw1ARqaGkAp5HFmvxfiigvG/R12CGJlyeA01hdkJMfbFiZlhcru3kOuUsE2QpV7fc6QBm
 LsqVD8pOk26tKs/34ERrzMt4GVBG0K8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-H7GUwjcOMLOfqiUqdGCHCw-1; Wed, 24 Jun 2020 17:48:53 -0400
X-MC-Unique: H7GUwjcOMLOfqiUqdGCHCw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90FF418585A1;
 Wed, 24 Jun 2020 21:48:52 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 55D1E60F8A;
 Wed, 24 Jun 2020 21:48:52 +0000 (UTC)
Subject: Re: Building in Solaris 11.4
To: Michele Denber <mdenber@gmx.com>, qemu-devel@nongnu.org
References: <5EF3C648.4060506@gmx.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ae7652b5-86f7-fc52-af01-69096dd3b163@redhat.com>
Date: Wed, 24 Jun 2020 16:48:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <5EF3C648.4060506@gmx.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/24/20 4:31 PM, Michele Denber wrote:
> While trying to run configure in Solaris 11.4, I quickly run into:
> 
> root@hemlock:~/qemu-5.0.0# ./configure
> ./configure[62]: local: not found [No such file or directory]

> grep: illegal option -- e
> Usage: grep [-c|-l|-q] -bhinsvw pattern file . . .
> ./configure[62]: local: not found [No such file or directory]

You've uncovered multiple portability issues, where even though 
configure expects to run with #!/bin/sh, it uses some non-POSIX-isms.


> Line 62 is
> 
>      local compiler="$1"
> 
> I'm not familiar with this construct.  What does "local" do?  It wasn't
> in the configure file for QEMU 2.12.  (And I already said "cc=gcc")

local is a bash-ism (ksh has it to) that changes how variables are 
scoped within shell functions.  The options to fix it are to either: 
avoid local and use global variables everywhere (and worrying about 
naming collisions when one function calls another), or to tweak 
configure so that it re-exec's itself under bash if it detects that 
/bin/sh is not up to our usage expectations.  (configure scripts 
generated by Autoconf do the latter, but qemu doesn't use autoconf).

grep -e is also a non-portable construct; it might be possible to change 
that line to call egrep instead, or to rewrite the regex to not need 
extended regex.

As a short-term workaround, you can always do:

/path/to/bash ./configure

to run it under a shell that won't choke on our use of non-posix constructs.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org



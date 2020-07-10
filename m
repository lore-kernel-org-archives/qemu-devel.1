Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5727C433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:34:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD86820657
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1+h8aPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD86820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvyw-0007EW-Py
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jtvfn-0004Cx-1T
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:14:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28061
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jtvfk-00054q-BT
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594397687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L4eDTZUrU/O2vyccldumbsXYy4BLRFffHWhihk6q0G8=;
 b=G1+h8aPUjxoYCsLcFzWKdHZi5A6Ki+AWW9R+9/BrQFiqIusWQnVg6I6DP5bZtB8VVOubWg
 pBUxniD1oUJYpTsz3H346v8YtlGVZbqMG7Yy2hSJBxmvqj0hw3B79yhgfqxLLsSl0ovzPS
 wkJ5a92qQTS8d0pvr31uMjDVgQzw2Mg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-MUF49OdIPB2Jm8QqeRrd5A-1; Fri, 10 Jul 2020 12:14:46 -0400
X-MC-Unique: MUF49OdIPB2Jm8QqeRrd5A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED2BF193F561;
 Fri, 10 Jul 2020 16:14:44 +0000 (UTC)
Received: from [10.3.112.178] (ovpn-112-178.phx2.redhat.com [10.3.112.178])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A9681002382;
 Fri, 10 Jul 2020 16:14:44 +0000 (UTC)
Subject: Re: [PULL v2] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200709121713.283092-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f5761840-ae62-a784-6c2c-d95838bc874f@redhat.com>
Date: Fri, 10 Jul 2020 11:14:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709121713.283092-1-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:36:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 7:17 AM, Kevin Wolf wrote:
> The following changes since commit 8796c64ecdfd34be394ea277aaaaa53df0c76996:
> 
>    Merge remote-tracking branch 'remotes/kraxel/tags/audio-20200706-pull-request' into staging (2020-07-08 16:33:59 +0100)
> 
> are available in the Git repository at:
> 
>    git://repo.or.cz/qemu/kevin.git tags/for-upstream
> 
> for you to fetch changes up to d1c824e681e423a6224c6831a493e9175fa02dc1:
> 
>    qemu-img: Deprecate use of -b without -F (2020-07-09 14:14:55 +0200)
> 
> ----------------------------------------------------------------
> Block layer patches:
> 
> - file-posix: Mitigate file fragmentation with extent size hints
> - Tighten qemu-img rules on missing backing format
> - qemu-img map: Don't limit block status request size
> 
> ----------------------------------------------------------------
> Eric Blake (10):
>        qemu-img: Flush stdout before before potential stderr messages
>        block: Finish deprecation of 'qemu-img convert -n -o'
>        sheepdog: Add trivial backing_fmt support
>        vmdk: Add trivial backing_fmt support
>        qcow: Tolerate backing_fmt=

I see you renumbered my test 293 to 301 for conflict resolution, but did 
not update the commit message to call out the updated number ;)

Since we may have to do a v3 because of the 'truncate -s' issue in 114, 
you could touch that up too.


>   tests/qemu-iotests/301           | 88 ++++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/301.out       | 59 +++++++++++++++++++++++++++
>   tests/qemu-iotests/common.filter | 62 ++++++++++++----------------
>   tests/qemu-iotests/group         |  1 +
>   146 files changed, 906 insertions(+), 472 deletions(-)
>   create mode 100755 tests/qemu-iotests/301
>   create mode 100644 tests/qemu-iotests/301.out
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org



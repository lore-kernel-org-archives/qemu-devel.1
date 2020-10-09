Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4222BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:54:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C22332076E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbpU44V6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22332076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQwaw-0002vt-PP
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 13:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQwZe-0001FQ-0k
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:52:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQwZc-0007NF-BO
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602265975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qum4skhSNnMOUYsKviRzDwtyp5ToL3hy4RQFfond46E=;
 b=IbpU44V6lOU4d+488dKo2Nh7M5YkNbrmPy0N3KGM3mOeucNO6zJBPHN5/0RjEdeFb4La6e
 ChPpWlqAn0SZVRvhmnq+zXzuV9TzrpiIv0WYl8Bvimtkbhb6U0aWs5fPkFfxzxQGFYuQ9Y
 Dwg7wjEGbCu2Cv8/x5Tr6vVUf9UCLnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-tGPjWtOoMWy7HPOcxvaIUQ-1; Fri, 09 Oct 2020 13:52:53 -0400
X-MC-Unique: tGPjWtOoMWy7HPOcxvaIUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0904280B71D
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 17:52:52 +0000 (UTC)
Received: from [10.10.112.203] (ovpn-112-203.rdu2.redhat.com [10.10.112.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A38D5C1C7;
 Fri,  9 Oct 2020 17:52:48 +0000 (UTC)
Subject: Re: [PATCH 0/3] python/qemu: strictly typed mypy conversion, pt3
To: qemu-devel@nongnu.org
References: <20201009175123.249009-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <cbab18b3-be20-ad05-232b-2ed7f7a8198c@redhat.com>
Date: Fri, 9 Oct 2020 13:52:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201009175123.249009-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.208, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 1:51 PM, John Snow wrote:
> This is actually quite short; it's already fully typed. Attached are two
> fixes for settimeout and error handling. There are actually more fixes
> that need to be made here, because use of readline() in non-blocking
> mode is actually undefined behavior, so a more thorough re-work of the
> error classes used by this library must be put on hold pending a more
> aggressive re-write.
> 
> That's a problem for later, so for now, call the initial conversion to
> the statically typed subset of python done so we can move on to adding
> the regression tests that will maintain this baseline for us.
> 
> John Snow (3):
>    python: add mypy config
>    python/qemu/qmp.py: re-raise OSError when encountered
>    python/qemu/qmp.py: Fix settimeout operation
> 
>   python/mypy.ini    |  4 ++++
>   python/qemu/qmp.py | 30 +++++++++++++++++++++---------
>   2 files changed, 25 insertions(+), 9 deletions(-)
>   create mode 100644 python/mypy.ini
> 

Based on: https://gitlab.com/jsnow/qemu/-/tree/python



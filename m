Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220ABC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0CD3252C4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pp4y94Oo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0CD3252C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpvqL-00079w-3g
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 11:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jpvpB-0006DZ-Pc
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:36:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jpvp7-0003vP-OV
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593444956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lUr/Hi3rT4JfCNcFHmm1LOGXNOB27Ym657MaLLThJcI=;
 b=Pp4y94OoKwQXTZlzGxENOcj92JNl2yQXW7m23nsLB5o2x8QANOooqECEmTw+WX1f3MTYT1
 IYIQvdFIiR9YoIlkr1y+ZIXMx4KTvOcPPCADXdljbAZhSS8sgSdBH3XeNIFgKg6FjdUtW3
 Kq8kefYdmdwx2JG8Je/dewU6chqaCEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-LSAQPQpIP6C38hhvXb3liQ-1; Mon, 29 Jun 2020 11:35:39 -0400
X-MC-Unique: LSAQPQpIP6C38hhvXb3liQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D84A81902EA0;
 Mon, 29 Jun 2020 15:35:38 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82D0419C71;
 Mon, 29 Jun 2020 15:35:38 +0000 (UTC)
Subject: Re: [PATCH] coverity: provide Coverity-friendly MIN_CONST and
 MAX_CONST
To: qemu-devel@nongnu.org, no-reply@patchew.org, pbonzini@redhat.com
References: <159344410468.15477.8209266914104937697@d1fd068a5071>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ee3aeb03-b36d-e3d1-a9c4-22c4c87ae9c2@redhat.com>
Date: Mon, 29 Jun 2020 10:35:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <159344410468.15477.8209266914104937697@d1fd068a5071>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:06:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 10:21 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200629151642.11974-1-pbonzini@redhat.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Subject: [PATCH] coverity: provide Coverity-friendly MIN_CONST and MAX_CONST
> Type: series
> Message-id: 20200629151642.11974-1-pbonzini@redhat.com
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
>  From https://github.com/patchew-project/qemu
>   * [new tag]         patchew/20200629151642.11974-1-pbonzini@redhat.com -> patchew/20200629151642.11974-1-pbonzini@redhat.com
> Switched to a new branch 'test'
> 3aee0de coverity: provide Coverity-friendly MIN_CONST and MAX_CONST
> 
> === OUTPUT BEGIN ===
> WARNING: architecture specific defines should be avoided
> #38: FILE: include/qemu/osdep.h:269:
> +#ifdef __COVERITY__
> 
> ERROR: Macros with complex values should be enclosed in parenthesis

Obvious false positive.

> #39: FILE: include/qemu/osdep.h:270:
> +#define MIN_CONST(a, b) (a) < (b) ? (a) : (b)
> 
> ERROR: Macros with complex values should be enclosed in parenthesis

But this one is a real complaint.  We really do want:

#define MIN_CONST(a, b) ((a) < (b) ? (a) : (b))

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org



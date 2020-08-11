Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2442C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:12:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6B882076B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwHerjy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B882076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Xom-00086w-04
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 13:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k5Xo2-0007IO-Tm
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 13:11:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55140
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k5Xo0-0005y9-Rd
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 13:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597165878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qeuKwY9qW6mjuHxiXBbMPuu+i3MZBbMKHP7UsmwHvfg=;
 b=gwHerjy35HlAlXS/P7w8ZtsnRu5SwoqSd50CJW/2GsY6jkSxkYJpfDHNZaBGAo/+Nyjrev
 Neo7z2g4W4BVBxCcKuJA+3nbIMpYoT6pxuutlpKWOcfcrauGhxIIZvChZFQglZZ5IeNMcx
 u5xICBztZluVXJ7U/5o1hEdzjGDEOsY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-QjPWuKncP2ag4JjXhoPxcg-1; Tue, 11 Aug 2020 13:11:14 -0400
X-MC-Unique: QjPWuKncP2ag4JjXhoPxcg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EFD6100CCC0;
 Tue, 11 Aug 2020 17:11:13 +0000 (UTC)
Received: from [10.3.112.157] (ovpn-112-157.phx2.redhat.com [10.3.112.157])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E196887D63;
 Tue, 11 Aug 2020 17:11:12 +0000 (UTC)
Subject: Re: [PATCH] iotests/259: Fix reference output
To: Nir Soffer <nsoffer@redhat.com>, Max Reitz <mreitz@redhat.com>
References: <20200811080830.289136-1-mreitz@redhat.com>
 <CAMRbyytS0HZLjHVmr4aKC3of4_EDxZXOqOzAornC1WbnYoxN-Q@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5259c386-9b5b-1ab6-cab1-60da07388653@redhat.com>
Date: Tue, 11 Aug 2020 12:11:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMRbyytS0HZLjHVmr4aKC3of4_EDxZXOqOzAornC1WbnYoxN-Q@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 06:40:20
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/11/20 10:54 AM, Nir Soffer wrote:
> On Tue, Aug 11, 2020 at 11:08 AM Max Reitz <mreitz@redhat.com> wrote:
> 
>> The error message has changed recently, breaking the test.  Fix it.
>>
>> Fixes: a2b333c01880f56056d50c238834d62e32001e54
>>         ("block: nbd: Fix convert qcow2 compressed to nbd")
>>
> 
> Thanks for fixing this. I thought that I ran all the tests when I submitted
> the change.
> 
> Is this new test that was not available in master when I submitted this, or
> maybe I
> missed something when running the tests?

More likely the latter.  'make check' runs a subset of iotests under a 
subset of options, so this must not have been one of those options (or 
CI would have caught it sooner).  Running it manually with './check -nbd 
256' sees it, though.

> 
> I think I ran the tests using:
> 
>      SPEED=thorough check-block.sh
> 

My fault as well, since it was a rather late patch and I was trying to 
get it in -rc3, so I didn't complete as many tests on it as I would have 
liked before submitting the pull request.  Ah well, it won't be the 
first release with a broken iotest.  (Or if we really _do_ need -rc4, I 
can add this to the queue of nice-to-have)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org



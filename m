Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7AEC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 00:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94FC3212CC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 00:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HM9Ff6Kq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FC3212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLEyp-0005zf-K9
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 20:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLEyG-0005VC-88
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 20:18:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35947)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLEyD-0007D9-Pp
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 20:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600906724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oHwkREj6vyij/xJNq1/P7nB+UaI0HOAl8+44vnYClY4=;
 b=HM9Ff6KqGtwwvr6YTILHQsnb9+lv7M8a9IOaXf6xdeX4+GvR+RYCrzg45bwkaAXREVqbXV
 j9ANikBW3FTCMlZbrUxKHim6YLHmS/cFVPGLCvP49fhnS/r7gDjaR133yUklxkjF7z1kng
 nuDwBECg8gT0AuisxjorFaVyGOHkuuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-ukgaUiz-Om-4SM8dHaDJlw-1; Wed, 23 Sep 2020 20:18:42 -0400
X-MC-Unique: ukgaUiz-Om-4SM8dHaDJlw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F13681074652;
 Thu, 24 Sep 2020 00:18:40 +0000 (UTC)
Received: from [10.3.114.2] (ovpn-114-2.phx2.redhat.com [10.3.114.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 91FDE19D7C;
 Thu, 24 Sep 2020 00:18:36 +0000 (UTC)
Subject: Re: [PATCH v8 4/7] scripts: add block-coroutine-wrapper.py
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200915164411.20590-1-vsementsov@virtuozzo.com>
 <20200915164411.20590-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7a3ff4f8-3aa8-90c9-b68a-d1676a7b9960@redhat.com>
Date: Wed, 23 Sep 2020 19:18:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915164411.20590-5-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/20 11:44 AM, Vladimir Sementsov-Ogievskiy wrote:
> We have a very frequent pattern of creating coroutine from function
> with several arguments:
> 

> +++ b/scripts/block-coroutine-wrapper.py
> @@ -0,0 +1,187 @@
> +#!/usr/bin/env python3
> +"""Generate coroutine wrappers for block subsystem.

Looking at the generated file after patch 5 is applied,...


> +
> +def gen_header():
> +    copyright = re.sub('^.*Copyright', 'Copyright', __doc__, flags=re.DOTALL)
> +    copyright = re.sub('^(?=.)', ' * ', copyright.strip(), flags=re.MULTILINE)
> +    copyright = re.sub('^$', ' *', copyright, flags=re.MULTILINE)
> +    return f"""\

This generated comment...


> +
> +
> +def gen_wrappers_file(input_code: str) -> str:
> +    res = gen_header()

...is getting inserted into the generated file...

> +    for func in func_decl_iter(input_code):
> +        res += '\n\n\n'
> +        res += gen_wrapper(func)
> +
> +    return prettify(res)  # prettify to wrap long lines
> +
> +
> +if __name__ == '__main__':
> +    if len(sys.argv) < 3:
> +        exit(f'Usage: {sys.argv[0]} OUT_FILE.c IN_FILE.[ch]...')
> +
> +    with open(sys.argv[1], 'w') as f_out:
> +        for fname in sys.argv[2:]:
> +            with open(fname) as f_in:
> +                f_out.write(gen_wrappers_file(f_in.read()))

multiple times.  You'll want to hoist the call to gen_header outside the 
loop over fname in sys.argv[2:].

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org



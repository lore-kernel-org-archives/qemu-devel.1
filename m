Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1FAC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB3A206F5
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LW2bwkwv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB3A206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMbKU-0005IZ-Mx
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 13:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jMbJj-0004hr-Q7
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:50:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jMbJi-0003dd-Mv
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:50:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37866
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jMbJi-0003d8-Jr
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586454618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gZshyhJn2hUH7ZP7Ta7bW9aT+T3Nk3yW1I+c7xzg3H8=;
 b=LW2bwkwvTQXBYRn2YX5+dEV75rJIYC2kVu6LuViVIgS639lxWZwkZosvQtTUShXXPH1cjs
 ZAxvxQr2GpWbYPXu3VAjjGD20cd2uSEjDHjvLL7Ia2wRl9XQJGJbZ0jFAqVdCho7IWEe+G
 i94ZF1GRRmCDsx4nMYtkGkam/wGu4ek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-RqPv1UO2MiWkA-34RLgi4Q-1; Thu, 09 Apr 2020 13:50:15 -0400
X-MC-Unique: RqPv1UO2MiWkA-34RLgi4Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0987800D5B;
 Thu,  9 Apr 2020 17:50:14 +0000 (UTC)
Received: from [10.3.114.49] (ovpn-114-49.phx2.redhat.com [10.3.114.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 345F5272AA;
 Thu,  9 Apr 2020 17:50:14 +0000 (UTC)
Subject: Re: [PATCH for-5.1 1/8] tests-qemu-opts: Cover has_help_option(),
 qemu_opt_has_help_opt()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200409153041.17576-1-armbru@redhat.com>
 <20200409153041.17576-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8ea167d6-2784-1ab9-cf55-52eb7553cb4d@redhat.com>
Date: Thu, 9 Apr 2020 12:50:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200409153041.17576-2-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/9/20 10:30 AM, Markus Armbruster wrote:
> The two turn out to be inconsistent for "a,b,,help".  Test case
> marked /* BUG */.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/test-qemu-opts.c | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 

> +static void test_has_help_option(void)
> +{
> +    static const struct {
> +        const char *params;
> +        /* expected value of has_help_option() */
> +        bool expect_has_help_option;
> +        /* expected value of qemu_opt_has_help_opt() with implied=false */
> +        bool expect_opt_has_help_opt;
> +        /* expected value of qemu_opt_has_help_opt() with implied=true */
> +        bool expect_opt_has_help_opt_implied;
> +    } test[] = {
> +        { "help", true, true, false },
> +        { "helpme", false, false, false },
> +        { "a,help", true, true, true },
> +        { "a=0,help,b", true, true, true },
> +        { "help,b=1", true, true, false },
> +        { "a,b,,help", false /* BUG */, true, true },

So which way are you calling the bug?  Without looking at the code but 
going off my intuition, I parse this as option 'a' and option 'b,help'. 
The latter is not a normal option name because it contains a ',', but is 
a valid option value.

I agree that we have a bug, but I'm not yet sure in which direction the 
bug lies (should has_help_option be fixed to report true, in which case 
the substring ",help" has precedence over ',,' escaping; or should 
qemu_opt_has_help_opt be fixed to report false, due to treating 'b,help' 
after ',,' escape removal as an invalid option name).  So the placement 
of the /* BUG */ comment matters - where you placed it, I'm presuming 
that later in the series you change has_help_option to return true, even 
though that goes against my intuitive parse.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org



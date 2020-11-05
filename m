Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5384C4742C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:54:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1715420715
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3xcKgjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1715420715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kafiI-0003AY-WB
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 08:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kafYJ-0007CW-J1
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:43:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kafYH-0004tL-EM
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604583824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t7ARopnZSdNKPKp8LaxJXu/YtRILB4fMn6SslUhDm3o=;
 b=Z3xcKgjQBGQtlo7wP3LZ1m+K9jOSYwThpq8TXGda9VJRbUKIeoJDaqZDuTdXe3lWpkABRh
 IW7lHzHFYO4Vk8r6gbsV/Hxllz3FA/hd5tv3igs/2C/h46cy2aDAQ7jkKcYKY9m4GqkZFy
 tqxcu6qt8XuzU9mDOxg2RYulEUpS8y0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-R36SiiMYPeaVAFfscOsWKw-1; Thu, 05 Nov 2020 08:43:39 -0500
X-MC-Unique: R36SiiMYPeaVAFfscOsWKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAEFE1009E26;
 Thu,  5 Nov 2020 13:43:38 +0000 (UTC)
Received: from [10.3.114.103] (ovpn-114-103.phx2.redhat.com [10.3.114.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 848287366D;
 Thu,  5 Nov 2020 13:43:31 +0000 (UTC)
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20201105122808.1182973-1-marcandre.lureau@redhat.com>
 <20201105122808.1182973-10-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Subject: Re: [PATCH v2 9/9] docs: update the documentation about schema
 configuration
Message-ID: <28f4b64e-346d-b987-a43d-04a895c5da90@redhat.com>
Date: Thu, 5 Nov 2020 07:43:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201105122808.1182973-10-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, jsnow@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 6:28 AM, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  docs/devel/qapi-code-gen.txt | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index 3d22a7ae21..c499352a74 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -772,26 +772,30 @@ downstream command __com.redhat_drive-mirror.
>  === Configuring the schema ===
>  
>  Syntax:
> -    COND = STRING
> -         | [ STRING, ... ]
> +    COND = CFG-ID
> +         | [ COND, ... ]

As written, you allow recursion of [] such as:

[ [ ] ]

I think you meant: [ CFG-ID, ...]


> +         | { 'all: [ COND, ... ] }
> +         | { 'any: [ COND, ... ] }
> +         | { 'not': COND }

Here, the recursion makes sense: it looks like you want to permit all of
these:

'if': { 'not': { 'any': [ 'COND1', 'COND2' ] } }
'if': { 'not': [ 'COND3' ] }
'if': { 'not': 'COND4' }

>  
> -All definitions take an optional 'if' member.  Its value must be a
> -string or a list of strings.  A string is shorthand for a list
> -containing just that string.  The code generated for the definition
> -will then be guarded by #if STRING for each STRING in the COND list.
> +    CFG-ID = STRING

Does CFG-ID need its own rule?  Should this rule be listed before COND?

> +
> +All definitions take an optional 'if' member. Its value must be a string, a list
> +of strings or an object with a single member 'all', 'any' or 'not'. A string is
> +shorthand for a list containing just that string. A list is a shorthand for a
> +'all'-member object. The C code generated for the definition will then be guarded
> +by an #if precessor expression.
>  
>  Example: a conditional struct
>  
>   { 'struct': 'IfStruct', 'data': { 'foo': 'int' },
> -   'if': ['CONFIG_FOO', 'HAVE_BAR'] }
> +   'if': { 'all': [ 'CONFIG_FOO', 'HAVE_BAR' ] } }
>  
>  gets its generated code guarded like this:
>  
> - #if defined(CONFIG_FOO)
> - #if defined(HAVE_BAR)
> + #if defined(CONFIG_FOO) && defined(HAVE_BAR)
>   ... generated code ...
> - #endif /* defined(HAVE_BAR) */
> - #endif /* defined(CONFIG_FOO) */
> + #endif /* defined(HAVE_BAR) && defined(CONFIG_FOO) */
>  
>  Individual members of complex types, commands arguments, and
>  event-specific data can also be made conditional.  This requires the
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org



Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD092C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A344D206E9
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTPiQV+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A344D206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJzer-0007Hm-Qq
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 09:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jJze9-0006Va-Sl
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:12:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jJze8-0008Rx-HM
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:12:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55349
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jJze8-0008RT-CY
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585833154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/rojNdLXHpQ7PZHkfNC+zZFkHLKk4I5sUST8uhdZ+I=;
 b=UTPiQV+GqcYusBuO1IEObVrLi0Wj+tUHkqjGCT+Mo/8KwQmgN/rIDyZ1UxiHS9RDu/RTsW
 0HTRjiZQRQfiJN8bbwHYfA3FRqg+jU5cuQI/q+FGUUWAID4a5wjQEO+g8xjWAE9Mmx7Y7H
 x7l57JWCj15cPzwPb544KyQ7Trgnk+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-aAlU1i1LPhGwQBfHQxP5mg-1; Thu, 02 Apr 2020 09:12:30 -0400
X-MC-Unique: aAlU1i1LPhGwQBfHQxP5mg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEDA8800D5C;
 Thu,  2 Apr 2020 13:12:29 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44C7C60BF4;
 Thu,  2 Apr 2020 13:12:29 +0000 (UTC)
Subject: Re: [PATCH] qobject: json-streamer: Remove double test
To: Simran Singhal <singhalsimran0@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200402121313.GA5563@simran-Inspiron-5558>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c955d844-9d39-930a-fb92-75fd97bb0330@redhat.com>
Date: Thu, 2 Apr 2020 08:12:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402121313.GA5563@simran-Inspiron-5558>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/2/20 7:13 AM, Simran Singhal wrote:
> Remove the duplicate test "parser->bracket_count >= 0".
> 
> Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
> ---
>   qobject/json-streamer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
> index 47dd7ea576..ef48185283 100644
> --- a/qobject/json-streamer.c
> +++ b/qobject/json-streamer.c
> @@ -85,7 +85,7 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
>       g_queue_push_tail(&parser->tokens, token);
>   

Adding some context:

>       if ((parser->brace_count > 0 || parser->bracket_count > 0)
> -        && parser->bracket_count >= 0 && parser->bracket_count >= 0) {
> +        && parser->bracket_count >= 0) {
>           return;
>       }
>   
>     json = json_parser_parse(parser->tokens, parser->ap, &err);
>     parser->tokens = NULL;
> 
> out_emit:

This code was rewritten in commit 8d3265b3.  Prior to that, it read:


     if (parser->brace_count < 0 ||
         parser->bracket_count < 0 ||
         (parser->brace_count == 0 &&
          parser->bracket_count == 0)) {
         json = json_parser_parse(parser->tokens, parser->ap, &err);
         parser->tokens = NULL;
         goto out_emit;
     }

     return;

out_emit:

Obviously, the goal of the rewrite was to convert:

if (cond) {
   do stuff
} else {
   return
}
more stuff

into the more legible

if (!cond) {
   return
}
do stuff
more stuff

Let's re-read my original review:

https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg03017.html

> Applying deMorgan's rules:
> 
> !(brace < 0 || bracket < 0 || (brace == 0 && bracket == 0))
> !(brace < 0) && !(bracket < 0) && !(brace == 0 && bracket == 0)
> brace >= 0 && bracket >= 0 && (!(brace == 0) || !(bracket == 0))
> brace >= 0 && bracket >= 0 && (brace != 0 || bracket != 0)
> 
> But based on what we learned in the first two conjunctions, we can rewrite the third:
> 
> 
> brace >= 0 && bracket >= 0 && (brace > 0 || bracket > 0)
> 
> and then commute the logic:
> 
> (brace > 0 || bracket > 0) && brace >= 0 && bracket >= 0
> 

What I missed was the typo: we checked bracket >= 0 twice, instead of 
the intended brace >= 0 && bracket >= 0.  This needs a v2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org



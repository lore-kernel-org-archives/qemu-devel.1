Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F28C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:47:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA24D20708
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nw+mqNq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA24D20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsscu-0007o1-5j
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jssc5-0006dq-VV
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:46:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39147
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jssc4-0007QX-AX
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594147599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QwMJFZ2WOW0WrqA0Cu0I4c4uL0mnSfnqiJyaxPX4AEI=;
 b=Nw+mqNq2EMynVY+zo7utfd+d8QofjGLx2k2/mPJgfDYuOdJ465Eoq+XEdr77IqCrkvdTN4
 uLEOHXDc47cm+vU/RBUhAIx1VZDu/fbZOBiNOBT1JTM+P8Kw/cHu15JsOflWrYE0Z9+fs9
 fjzXn/R0KETiQurgKkGloSTWiMuZ0DE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-HkfduuMeN6WPK45o0NnRUQ-1; Tue, 07 Jul 2020 14:46:35 -0400
X-MC-Unique: HkfduuMeN6WPK45o0NnRUQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 396471B18BC1;
 Tue,  7 Jul 2020 18:46:30 +0000 (UTC)
Received: from [10.3.115.46] (ovpn-115-46.phx2.redhat.com [10.3.115.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9719A797E0;
 Tue,  7 Jul 2020 18:46:28 +0000 (UTC)
Subject: Re: [PATCH v4 03/45] error: Document Error API usage rules
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200707160613.848843-1-armbru@redhat.com>
 <20200707160613.848843-4-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a2fdc2c4-62af-ff06-26d3-e9d6c5a449e2@redhat.com>
Date: Tue, 7 Jul 2020 13:46:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707160613.848843-4-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:04:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, groug@kaod.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 11:05 AM, Markus Armbruster wrote:
> This merely codifies existing practice, with one exception: the rule
> advising against returning void, where existing practice is mixed.
> 
> When the Error API was created, we adopted the (unwritten) rule to
> return void when the function returns no useful value on success,
> unlike GError, which recommends to return true on success and false on
> error then.
> 

> Make the rule advising against returning void official by putting it
> in writing.  This will hopefully reduce confusion.
> 
> Update the examples accordingly.
> 
> The remainder of this series will update a substantial amount of code
> to honor the rule.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---

> @@ -95,14 +122,12 @@
>    * Create a new error and pass it to the caller:
>    *     error_setg(errp, "situation normal, all fouled up");
>    *
> - * Call a function and receive an error from it:
> - *     Error *err = NULL;
> - *     foo(arg, &err);
> - *     if (err) {
> + * Call a function, receive an error from it, and pass it to caller

maybe s/to caller/to the caller/

> + * when the function returns a value that indicates failure, say false:
> + *     if (!foo(arg, errp)) {
>    *         handle the error...
>    *     }
> - *
> - * Receive an error and pass it on to the caller:
> + * when it doesn't, say a void function:

Hmm. It looks like you have a single sentence "Call a function... when 
the function returns", but this line now makes it obvious that you have 
a single prefix: "Call a function, ...and pass it to the caller:"
with two choices "when the function returns" and "when it doesn't".  I'm 
not sure if there is a nicer way to typeset it, adding yet another ":" 
at the end of the line looks odd.  The idea behind the text is fine, I'm 
just trying to paint the bikeshed to see if there is a better presentation.

>    *     Error *err = NULL;
>    *     foo(arg, &err);
>    *     if (err) {
> @@ -120,6 +145,19 @@
>    *     foo(arg, errp);
>    * for readability.
>    *
> + * Receive an error, and handle it locally
> + * when the function returns a value that indicates failure, say false:
> + *     Error *err = NULL;
> + *     if (!foo(arg, &err)) {
> + *         handle the error...
> + *     }
> + * when it doesn't, say a void function:

It helps that you have repeated the same pattern as above.  But that 
means if you change the layout, both groupings should have the same 
layout.  Maybe:

Intro for a task:
- when the function returns...
- when it doesn't

Also, are there functions that have a return type other than void, but 
where the return value is not an indication of error?  If there are, 
then the "say a void function" clause makes sense (but we should 
probably recommend against such functions); if there are not, then "say 
a void function" reads awkwardly.  Maybe:

- when it does not, because it is a void function:

> + *     Error *err = NULL;
> + *     foo(arg, &err);
> + *     if (err) {
> + *         handle the error...
> + *     }
> + *
>    * Receive and accumulate multiple errors (first one wins):
>    *     Error *err = NULL, *local_err = NULL;
>    *     foo(arg, &err);
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org



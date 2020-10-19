Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8410C43467
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E3F22200
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJIKEG+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E3F22200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUR6A-0007sW-SW
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 05:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kUR4l-0007Ij-EC
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:03:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55117)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kUR4j-0005SQ-U4
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603098209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X5+ajz7xznAu78Xx6xem72j1nX4DRfbGEz5dzBVWHnI=;
 b=BJIKEG+e/6KAVX8PwKdnct9HRW/loMNkunsvNcV/RAe4BhoUMXmkONd0s4vrPopdo8A1ST
 FT0JYzDkgnHf0Ut5PQTi/k09bdaxWXdKFEqrfIDd5gex+NWT1w8xJfrVVrvfzAAR07zN62
 iypCK9Ci7meOFVJa4MCRgsM7h1/xc4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-x1hb6llFNzeu6LBM5sQ4aw-1; Mon, 19 Oct 2020 05:03:24 -0400
X-MC-Unique: x1hb6llFNzeu6LBM5sQ4aw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 867E09CC32;
 Mon, 19 Oct 2020 09:03:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5388B6EF41;
 Mon, 19 Oct 2020 09:03:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C66061132A08; Mon, 19 Oct 2020 11:03:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 1/7] keyval: Fix and clarify grammar
References: <20201011073505.1185335-1-armbru@redhat.com>
 <20201011073505.1185335-2-armbru@redhat.com>
 <f0f23fd5-dae9-9692-135a-f22c04520d64@redhat.com>
Date: Mon, 19 Oct 2020 11:03:03 +0200
In-Reply-To: <f0f23fd5-dae9-9692-135a-f22c04520d64@redhat.com> (Eric Blake's
 message of "Mon, 12 Oct 2020 06:43:39 -0500")
Message-ID: <875z761tbs.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 10/11/20 2:34 AM, Markus Armbruster wrote:
>> The grammar has a few issues:
>> * key-fragment = / [^=,.]* /
>>    Prose restricts key fragments: they "must be valid QAPI names or
>>    consist only of decimal digits".  Technically, '' consists only of
>>    decimal digits.  The code rejects that.  Fix the grammar.
>> * val          = { / [^,]* / | ',,' }
>>    Use + instead of *.  Accepts the same language.
>> * val-no-key   = / [^=,]* /
>>    The code rejects an empty value.  Fix the grammar.
>> * Section "Additional syntax for use with an implied key" is
>>    confusing.  Rewrite it.
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   util/keyval.c | 16 ++++++++++------
>>   1 file changed, 10 insertions(+), 6 deletions(-)
>> diff --git a/util/keyval.c b/util/keyval.c
>> index 13def4af54..82d8497c71 100644
>> --- a/util/keyval.c
>> +++ b/util/keyval.c
>> @@ -16,8 +16,8 @@
>>    *   key-vals     = [ key-val { ',' key-val } [ ',' ] ]
>>    *   key-val      = key '=' val
>>    *   key          = key-fragment { '.' key-fragment }
>> - *   key-fragment = / [^=,.]* /
>> - *   val          = { / [^,]* / | ',,' }
>> + *   key-fragment = / [^=,.]+ /
>
> This requires a non-empty string.  Good (we don't allow an empty key).
>
>> + *   val          = { / [^,]+ / | ',,' }
>
> I agree that this has no real change.  Previously, you allowed zero or
> more repetitions of a regex that could produce zero characters; now, 
> each outer repetition must make progress.
>
>>    *
>>    * Semantics defined by reduction to JSON:
>>    *
>> @@ -71,12 +71,16 @@
>>    * Awkward.  Note that we carefully restrict alternate types to avoid
>>    * similar ambiguity.
>>    *
>> - * Additional syntax for use with an implied key:
>> + * Alternative syntax for use with an implied key:
>>    *
>> - *   key-vals-ik  = val-no-key [ ',' key-vals ]
>> - *   val-no-key   = / [^=,]* /
>> + *   key-vals     = [ key-val-1st { ',' key-val } [ ',' ] ]
>> + *   key-val-1st  = val-no-key | key-val
>> + *   val-no-key   = / [^=,]+ /
>>    *
>> - * where no-key is syntactic sugar for implied-key=val-no-key.
>> + * where val-no-key is syntactic sugar for implied-key=val-no-key.
>> + *
>> + * Note that you can't use the sugared form when the value contains
>> + * '=' or ','.
>
> Nor can you use the sugared form when the value is intended to be
> empty

True.  Spelling it out wouldn't hurt.  Takes a follow-up patch; this one
is already in master.

>       (although this may be academic, as your other patches enumerate
> the list of clients, and none of them seem to allow an empty value
> even when desugared).
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!



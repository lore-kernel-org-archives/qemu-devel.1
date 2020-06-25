Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297BDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E652A20775
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKFTDV0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E652A20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUAn-0006rr-1m
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joTnd-00044v-AC
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:28:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43792
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joTnZ-0007Ds-TN
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0NJdPxpW2f+Ko8kRsxEnTVAj7SKVEYRdbw+1TWTfJww=;
 b=YKFTDV0M8afeInxQgsCvoUwVv1i5H+usLKXRRwAHRv6J5s1apowoI7nRZL1n8bZyPKYvHt
 f+D0o/o6WnYrJTqNHbhjidX6cwQy72/yLDA91KKdQ8cPd/EzM86wZakzJ8iQtlh6Q+Vy0E
 MTD1yBdrnTofVTz3S7vtQIvg79rVFAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-v1FWzhAYM16QegKSlhNjVQ-1; Thu, 25 Jun 2020 11:28:18 -0400
X-MC-Unique: v1FWzhAYM16QegKSlhNjVQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89A8980401F;
 Thu, 25 Jun 2020 15:28:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56AAE78120;
 Thu, 25 Jun 2020 15:28:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BD09D11384D4; Thu, 25 Jun 2020 17:28:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 01/46] error: Improve examples in error.h's big comment
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-2-armbru@redhat.com>
 <20200625164400.5f63e74d@bahia.lan>
Date: Thu, 25 Jun 2020 17:28:15 +0200
In-Reply-To: <20200625164400.5f63e74d@bahia.lan> (Greg Kurz's message of "Thu, 
 25 Jun 2020 16:44:00 +0200")
Message-ID: <87o8p7upv4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greg Kurz <groug@kaod.org> writes:

> On Wed, 24 Jun 2020 18:42:59 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Show errp instead of &err where &err is actually unusual.  Add a
>> missing declaration.  Add a second error pileup example.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  include/qapi/error.h | 19 +++++++++++++++----
>>  1 file changed, 15 insertions(+), 4 deletions(-)
>> 
>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>> index ad5b6e896d..1a5ea25e12 100644
>> --- a/include/qapi/error.h
>> +++ b/include/qapi/error.h
>> @@ -16,15 +16,15 @@
>>   * Error reporting system loosely patterned after Glib's GError.
>>   *
>>   * Create an error:
>> - *     error_setg(&err, "situation normal, all fouled up");
>> + *     error_setg(errp, "situation normal, all fouled up");
>>   *
>>   * Create an error and add additional explanation:
>> - *     error_setg(&err, "invalid quark");
>> - *     error_append_hint(&err, "Valid quarks are up, down, strange, "
>> + *     error_setg(errp, "invalid quark");
>> + *     error_append_hint(errp, "Valid quarks are up, down, strange, "
>>   *                       "charm, top, bottom.\n");
>>   *
>>   * Do *not* contract this to
>> - *     error_setg(&err, "invalid quark\n"
>> + *     error_setg(errp, "invalid quark\n" // WRONG!
>>   *                "Valid quarks are up, down, strange, charm, top, bottom.");
>>   *
>>   * Report an error to the current monitor if we have one, else stderr:
>> @@ -108,12 +108,23 @@
>>   *     }
>>   *
>>   * Do *not* "optimize" this to
>> + *     Error *err = NULL;
>>   *     foo(arg, &err);
>>   *     bar(arg, &err); // WRONG!
>>   *     if (err) {
>>   *         handle the error...
>>   *     }
>>   * because this may pass a non-null err to bar().
>> + *
>> + * Likewise, do *not*
>> + *     Error *err = NULL;
>> + *     if (cond1) {
>> + *         error_setg(err, ...);
>
> s/err/&err
>
>> + *     }
>> + *     if (cond2) {
>> + *         error_setg(err, ...); // WRONG!
>
> ditto

Good catch!

> With that fixed:
>
> Reviewed-by: Greg Kurz <groug@kaod.org>

Thanks!

>
>> + *     }
>> + * because this may pass a non-null err to error_setg().
>>   */
>>  
>>  #ifndef ERROR_H



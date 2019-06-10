Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDC3C282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C072082E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C072082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43078 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haH2m-0005Er-13
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 05:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50471)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1haH17-0003nh-4A
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1haH15-0003bP-1x
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:55:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39992)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1haH14-0003aV-TU
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:55:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 68D8CC050003
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 09:54:53 +0000 (UTC)
Received: from redhat.com (ovpn-116-138.ams2.redhat.com [10.36.116.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BDE4F196E6;
 Mon, 10 Jun 2019 09:54:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
In-Reply-To: <20190529163447.GK2882@work-vm> (David Alan Gilbert's message of
 "Wed, 29 May 2019 17:34:48 +0100")
References: <20190515121544.4597-1-quintela@redhat.com>
 <20190515121544.4597-7-quintela@redhat.com>
 <20190529163447.GK2882@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Mon, 10 Jun 2019 11:54:50 +0200
Message-ID: <875zpdvk7p.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 10 Jun 2019 09:54:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 6/8] migration: Make none operations
 into its own structure
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> It will be used later.
>
> 'none' is confusing - I think this is no-compression specifically -
> right?
> I'd be happy with something abbreviated like 'nocomp'

Got into nocomp.
>> @@ -1093,6 +1129,8 @@ static void *multifd_send_thread(void *opaque)
>>      /* initial packet */
>>      p->num_packets = 1;
>>  
>> +    multifd_send_state->ops = &multifd_none_ops;
>> +
>
> I agree with Wei Yang that is a bad idea; that should be done once
> before the first thread is started.

Also fixed.

Thanks, Juan.


Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FCCC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 07:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E00F2190F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 07:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E00F2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iISbl-00042r-9S
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 03:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iISSf-0004Iv-9i
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 03:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iISSd-0000ft-Ll
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 03:02:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42512)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1iISSd-0000eq-DV; Thu, 10 Oct 2019 03:02:07 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6529D99D2E;
 Thu, 10 Oct 2019 07:02:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A23651001DE0;
 Thu, 10 Oct 2019 07:02:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1FEDD1138619; Thu, 10 Oct 2019 09:02:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCHv2 1/2] util/qemu-error: add guest name helper with -msg
 options
References: <20191009164459.8209-1-msmarduch@digitalocean.com>
 <20191009164459.8209-2-msmarduch@digitalocean.com>
 <3f24a34d-de91-c996-ffd8-306d0e0ce6a0@redhat.com>
Date: Thu, 10 Oct 2019 09:02:01 +0200
In-Reply-To: <3f24a34d-de91-c996-ffd8-306d0e0ce6a0@redhat.com> (Paolo
 Bonzini's message of "Wed, 9 Oct 2019 23:16:50 +0200")
Message-ID: <874l0hulqu.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 10 Oct 2019 07:02:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, qemu-trivial@nongnu.org, mtosatti@redhat.com,
 qemu-devel@nongnu.org, Mario Smarduch <msmarduch@digitalocean.com>,
 philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 09/10/19 18:44, Mario Smarduch wrote:
>>  };
>> @@ -1263,6 +1267,7 @@ static void realtime_init(void)
>>  static void configure_msg(QemuOpts *opts)
>>  {
>>      enable_timestamp_msg = qemu_opt_get_bool(opts, "timestamp", true);
>> +    enable_guestname_msg = qemu_opt_get_bool(opts, "name", false);
>>  }
>
> Before, the msg option certainly had a timestamp suboption, but this
> might not be the case now.  So that "true" needs to become "false".
> I'll fix it up when applying.

Hold your horses.

Before this patch, -msg "" enables timestamps.  If you apply it with
your fixup, it doesn't anymore.  I don't disagree with that change, but
it needs to be its own commit, with a proper explanation.

I have more comments on this patch.


Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0DBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 988C120748
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3FRebMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988C120748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jysnG-0001F7-Qj
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jysmg-0000ju-Oh
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 04:10:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26173
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jysmf-0003mk-3G
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 04:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595578224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=JYNTOwg2Z0GGZGZmxkrIOdP/OMiKmy88mKcGVk80uMY=;
 b=Y3FRebMgnIU0TVz7TzBNiFuAJsdPR83DGmjFqvfr+tfEGTbsuu7p1Ikud/x7weVzkcfCb/
 nikjrNdNnM5hFKlIfDNJzEGItZ8gGULTHxNyohsf+NP28vYsglVF4shwHsIpfS4UQ4dG99
 FRC3F2AUV4rEipZSX2lFNW5UQNwGO3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-UvzBSvy3O2u1Zk6dJ3Eq3A-1; Fri, 24 Jul 2020 04:10:20 -0400
X-MC-Unique: UvzBSvy3O2u1Zk6dJ3Eq3A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79953800597;
 Fri, 24 Jul 2020 08:10:19 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-77.ams2.redhat.com [10.36.112.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6986F10013C0;
 Fri, 24 Jul 2020 08:10:18 +0000 (UTC)
Subject: Re: Status of scripts/qmp/ (was: [PATCH 0/3] scripts/qmp/qom-fuse:
 Scrape off the bitrot)
To: Markus Armbruster <armbru@redhat.com>
References: <20200723142738.1868568-1-armbru@redhat.com>
 <36a450fb-8072-1223-9253-0446ed23dcd1@redhat.com>
 <874kpxe5an.fsf_-_@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5de3e0d5-73e6-800e-de91-83bd5aa47cb9@redhat.com>
Date: Fri, 24 Jul 2020 10:10:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <874kpxe5an.fsf_-_@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 01:23:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/07/2020 09.33, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 23/07/2020 16.27, Markus Armbruster wrote:
>>> Markus Armbruster (3):
>>>   scripts/qmp/qom-fuse: Unbreak import of QEMUMonitorProtocol
>>>   scripts/qmp/qom-fuse: Port to current Python module fuse
>>>   scripts/qmp/qom-fuse: Fix getattr(), read() for files in /
>>
>> Could it be added to a CI pipeline, so that it does not bitrot again?
> 
> Should it be?
> 
> Thread hijack!
> 
> What's the status of scripts/qmp/?
> 
> The directory is covered by MAINTAINERS section QMP, with status
> "Supported".  Status is a *lie* for these scripts.  I inherited them
> with the rest of QMP.  I have no use for them, except I occasionally use
> qom-fuse for QOM spelunking, mostly because our monitor commands are so
> unwieldy compared to a filesystem.  I barely looked at them in the 5+
> years of my service as QMP maintainer.  Actual status is "Odd fixes".
> 
> Does this stuff have any business in /scripts/?
> 
> Nothing in scripts/qmp/ should be shipped.
> 
> scripts/qmp/qemu-ga-client doesn't even belong there.  Michael, is it of
> any use today?
> 
> I know scripts/qmp/qmp-shell has a few friends among developers.  I
> regard it as a failed attempt at making QMP easier for humans, and have
> zero interest in it.
> 
> scripts/qmp/qmp looks like an attempt at making QMP easier for shell
> scripts.  I'm not aware of actual use, and have zero interest in it.
> 
> scripts/qmp/qom-{get,list,set} look like an attempt at making QOM easier
> for shell scripts.  I'm not aware of actual use, and have zero interest
> in it.  Heck, I can't even figure out how to use qom-get (I just spend
> at least 30s trying).

According to the original commit (235fe3bfd46b1104575b540d0bc), it seems
like these were using for manual testing. If in all those years nobody
ever tried to integrate them into our "make check" test suite, I guess
they are just dead code.

> scripts/qmp/qom-tree feels redundant with scripts/qmp/qom-fuse.  I just
> ran it for the first time just to come to this judgement.
> 
> I believe contrib/ would be a better home for all of them.
> 
> I feel like moving the directory there and leaving it *uncovered* in
> MAINTAINERS.  If a volunteer steps forward, we can add a suitable
> section.
> 
> Opinions?

I'd suggest to remove the "test tools" from commit 235fe3bfd46b1104575b5
since apparently nobody ever cared to integrate them into the test suite.

For the other scripts that are still used occasionally, I'd leave them
in their current location. If you don't want to maintain them, remove
them from your section in MAINTAINERS and add a new "QMP scripts"
section where you can mark the scripts/qmp folder as orphan.

 Thomas



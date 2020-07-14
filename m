Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4BDC433ED
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A04B22512
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsaKeFL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A04B22512
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLQv-0003RY-TJ
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 09:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jvLQJ-0002uv-DG
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:56:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35037
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jvLQH-0003K0-Ke
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594735000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=3nHtuO2bbYEZTcslqUGZn/6F5fgsCwXOE1iTzgqaUZI=;
 b=QsaKeFL9thXnvNze3kctqdLLUk1JQMMQ07UaJ1K3CUZddn8mRrAbYuvQsJRg6d3EzGRC4J
 2SVnh9tmUg74Ukg/xWi+WY3mQgjEBlu9Ov9h9ViHUPZOv+cEbLytEiNFeK74jPjAM+EBb/
 7QJaO/MtJYflzHj+mQd/Kj7+MYcccRs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-bmvmNPD0PYKgV7Wezag5QA-1; Tue, 14 Jul 2020 09:56:36 -0400
X-MC-Unique: bmvmNPD0PYKgV7Wezag5QA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4E11800400;
 Tue, 14 Jul 2020 13:56:34 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-11.ams2.redhat.com [10.36.112.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 00FF210013C3;
 Tue, 14 Jul 2020 13:56:25 +0000 (UTC)
Subject: Re: [PATCH 1/1] MAINTAINERS: introduce cve or security quotient field
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20200714083631.888605-1-ppandit@redhat.com>
 <20200714083631.888605-2-ppandit@redhat.com>
 <CAFEAcA9QWLmi1fGuPW93GXFKV2KCwNs6Xp3U9MU2r4wtendzhg@mail.gmail.com>
 <20200714095233.GC25187@redhat.com>
 <20200714060916-mutt-send-email-mst@kernel.org>
 <CAFEAcA_ca4JN655GW=eGyjrjDmiv0EktaZZ7RMghO5rBwm9tGQ@mail.gmail.com>
 <20200714064921-mutt-send-email-mst@kernel.org>
 <20200714133021.GF25187@redhat.com> <20200714134856.GC5120@linux.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <dbb871bf-6772-1105-5bcd-7bbc3ba0f14b@redhat.com>
Date: Tue, 14 Jul 2020 15:56:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200714134856.GC5120@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/07/2020 15.48, Kevin Wolf wrote:
> Am 14.07.2020 um 15:30 hat Daniel P. BerrangÃƒÂ© geschrieben:
>> On Tue, Jul 14, 2020 at 07:02:59AM -0400, Michael S. Tsirkin wrote:
>>> On Tue, Jul 14, 2020 at 11:22:28AM +0100, Peter Maydell wrote:
>>>> On Tue, 14 Jul 2020 at 11:12, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>> And for people who want to build QEMU with lots of functionality (like
>>>>> Fedora does), I think a -security flag would be a useful addition.
>>>>> We can then tell security researchers "only a high security issue
>>>>> if it reproduces with -security=high, only a security issue
>>>>> if it reproduces with -security=low".
>>>>
>>>> I think a -security option would also be useful to users -- it
>>>> makes it easier for them to check "is this configuration using
>>>> something that I didn't realize was not intended to be secure".
>>>> For me, something useful for our users is much more compelling
>>>> than "this might make security researchers' lives a bit easier".
>>>>
>>>> thanks
>>>> -- PMM
>>>
>>> True. And I guess downstreams can also force the option to high or set the
>>> default to high rather easily if they want to.
>>>
>>> So the option would be:
>>>
>>> -security level
>>> 	Set minimal required security level of QEMU.
>>>
>>> 	high: block use of QEMU functionality which is intended to be secure against
>>> 		malicious guests.
>>> 	low: allow use of all QEMU functionality, best effort security
>>> 		against malicious guests.
>>>
>>> Default would be -security low.
>>>
>>> Does this look reasonable?
>>
>> The challenge I see is that wiring up a runtime flag into every relevant
>> part of the QEMU codebase is an pretty large amount of work. Every device,
>> every machine type, every backend type, every generic subsystem will all
>> need checks for this flag. It is possible, but it isn't going to be quick
>> or easy, especially with poor error reporting support in many areas.
> 
> Would it make more sense as a configure flag that decides whether or not
> to compile in potentially problematic devices/backends?

I guess there are users for both. Some people prefer to compile their
reduced QEMU binary (remember Nemu?), while the users from the normal
Linux distros might benefit more from a runtime switch, I guess.

I wonder whether it's somehow possible to unify both approaches, so that
we could mark the secure/insecure objects in the Makefiles already and
then either don't link them for the Nema-style users, or mark the
objects via some linker magic (?) as insecure, so we could flag them
during runtime if a certain parameter has been used...? No clue whether
that's possible at all, I'm just brainstorming...

 Thomas



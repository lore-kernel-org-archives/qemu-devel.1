Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436D5C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBB62054F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvxdxcYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBB62054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBJFP-0007fP-6j
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 10:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBJEX-0006cy-KX
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:50:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23367
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBJEW-0007jf-08
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598539831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aa0DuYW96C4Yznx/17T28IzholbBAYYlg8AdNuIp95k=;
 b=VvxdxcYYazFTwTj5BwdXqMIkkEhVYNGOPL2naJRPJ5ac6uS4Mxb5PNxcwu/4PCscQcLOex
 sZI9PQQ96P+d3vPwM84XE8lLIs5jQlK9wiEjfjveJXluATVBul2PGyXBz9VvmEJdKHISOl
 q45mDHw5VEKiwahKQaz3kdVR2kAzZ1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-yi4HKxXoMGyPogj2DekEyg-1; Thu, 27 Aug 2020 10:50:28 -0400
X-MC-Unique: yi4HKxXoMGyPogj2DekEyg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9BBD10ABDA1;
 Thu, 27 Aug 2020 14:50:27 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C98FE7D64E;
 Thu, 27 Aug 2020 14:50:26 +0000 (UTC)
Subject: Re: [PATCH] Deprecate lm32 port
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200827113259.25064-1-peter.maydell@linaro.org>
 <8385e0cf-b955-e62d-dfdc-51380b7c5433@redhat.com>
 <CAFEAcA_3fiQ86aby8PALZNUukPE1RhgV+1+hjoEF+aCfCp3mbw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0fd6bf04-f021-6716-c010-93def04c6f5d@redhat.com>
Date: Thu, 27 Aug 2020 16:50:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_3fiQ86aby8PALZNUukPE1RhgV+1+hjoEF+aCfCp3mbw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.782, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Michael Walle <michael@walle.cc>, "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/08/2020 16.19, Peter Maydell wrote:
> On Thu, 27 Aug 2020 at 14:52, Thomas Huth <thuth@redhat.com> wrote:
>> What's next? moxie? ... apart from the tree-wide clean-ups and trivial
>> fixes, moxie did not have any major updates since 2013 when it has been
>> added, as far as I can see ... is anybody still using it?
> 
> I was never very clear on how much use moxie had to start with...
> 
> An extremely rough-and-ready guide to how well-loved a target
> is might be "did it get converted to TranslatorOps?". Unconverted:
>  * avr
>  * cris
>  * lm32 (deprecation in progress)
>  * microblaze (rth just posted patches for this)
>  * moxie
>  * nios2
>  * tilegx (deprecation in progress)
>  * unicore32 (deprecation in progress)

Another criteria might be: Do we have a tcg, qtest or acceptance test to
check that the target is still working?

- avr has an acceptance test

- cris has tcg tests

- lm32 has tcg tests

- microblaze has acceptance tests (and one trivial qtest)

- moxie ... has only one very trivial qtest (boot-serial-test)

- nios2 has an acceptance test

- tilegx does not have any tests at all

- unicore32 does not have any tests at all
  (not counting the trivial machine-none-test)

So from that point of view, unicore32, tilegx and moxie are the
candidates for deprecation.

> I think dropping the moxie maintainer an email to ask about
> the architecture's status wouldn't be a bad idea if you
> wanted to start that ball rolling.

Ok, good idea, I'll try to write a mail later today.

 Thomas



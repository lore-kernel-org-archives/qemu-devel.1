Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0896C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:47:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 738562072D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yl2jh1os"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738562072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juvzN-0002Sv-OS
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 06:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1juvyV-0001kW-JS
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:46:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39006
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1juvyS-0002Ke-WC
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594637174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1jxpVee2D2CXrF+i6ydsiXVPDag0mghqFYfQw0e8lrs=;
 b=Yl2jh1osFZlFBSNvVDsmV0Z41Gh3krxpMEYmD27maVz0mB31VJRX3v8z6afsBj+/QcmhCy
 bbT8G5WsG4sSAvsCfeVPhYWp7jcU1SLLSEU/nCAcNwNyVzVAwnCN3eKzv0GHNlq/4U3FEi
 bhYYn/QhjkumRZa4M6tRxBfsHPICGAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-8rhfVA_xM5aSQWNEUqK6Tw-1; Mon, 13 Jul 2020 06:46:13 -0400
X-MC-Unique: 8rhfVA_xM5aSQWNEUqK6Tw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B69228014D4;
 Mon, 13 Jul 2020 10:46:10 +0000 (UTC)
Received: from gondolin (ovpn-113-13.ams2.redhat.com [10.36.113.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2AB4D7846C;
 Mon, 13 Jul 2020 10:46:07 +0000 (UTC)
Date: Mon, 13 Jul 2020 12:46:04 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH 3/3] cpu-timers, icount: new modules
Message-ID: <20200713124604.5fcc8282.cohuck@redhat.com>
In-Reply-To: <eb8e29c7-4cb5-8273-1c94-e62ea9e06485@suse.de>
References: <20200629093504.3228-1-cfontana@suse.de>
 <20200629093504.3228-4-cfontana@suse.de>
 <aa45a793-35b1-d3bd-18a8-4c52ad888029@redhat.com>
 <f89f249d-dbc4-779b-5b53-fc408461f072@suse.de>
 <ecf5f26b-ce86-3e13-5c5c-567919433acb@redhat.com>
 <e9dca3d1-f52d-13ce-2d7d-66958bc15765@suse.de>
 <d0bc3f23-98c0-eadb-55ed-3377f43c494a@suse.de>
 <20200710083356.4c6e9f78.cohuck@redhat.com>
 <eb8e29c7-4cb5-8273-1c94-e62ea9e06485@suse.de>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Jason J. Herne" <jjherne@linux.ibm.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?= =?UTF-8?B?w6k=?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Roman Bolshakov <r.bolshakov@yadro.com>,
 Wenchao Wang <wenchao.wang@intel.com>, haxm-team@intel.com,
 Colin Xu <colin.xu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jul 2020 21:20:08 +0200
Claudio Fontana <cfontana@suse.de> wrote:

> >>> In short this goes away if I again set icount to enabled for qtest,
> >>> basically ensuring that --enable-tcg is there and then reenabling icount.
> >>>
> >>> qtest was forcing icount and shift=0 by creating qemu options, in order to misuse its counter feature,
> >>> instead of using a separate counter.
> >>>
> >>> Removing that ugliness we end up with different behavior of save/load, because vmstate will now suddenly not contain icount-related values anymore.
> >>> What I do not understand is why this causes a problem because save should just not store the icount state and load should just not load the icount state,
> >>> and why we die on the load of s390 keys state (it works just fine for other architectures).  
> > 
> > Yes, I don't really see why skeys is so special. No endianness stuff, I
> > assume?  
> 
> 
> No, does not seem to be the issue.

Hm, had been worth a thought.

> 
> I discovered a way simpler way to "fix" it: 
> 
> static bool icount_state_needed(void *opaque)
> {
>     return 1;
> }
> 
> Ie, making sure that the state is always saved/restored, even when unused.
> 
> Really weird.
> 
> I logged/debugged the vmstate code, and I can see that things seem symmetric between save and load when it comes to timers.
> 
> something puts 0s into the key somehow...

Maybe writing one 0 to many?



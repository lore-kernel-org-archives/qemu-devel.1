Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D2EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A4C72065F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1RBkwVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4C72065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZGDn-00030d-PT
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 11:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jZGDC-0002a8-8e
 for qemu-devel@nongnu.org; Thu, 14 May 2020 11:55:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35612
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jZGD9-0000I4-Pp
 for qemu-devel@nongnu.org; Thu, 14 May 2020 11:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589471751;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1siLPmWwfKUEq+iYqOYLoN5vYwQcF7AQVrZy7ZHQAU=;
 b=a1RBkwVMWopG2nR8i2lpSjFb//l0BAvrcBF8iNfYi2LOOhOo4ZVl3E5teS8J9BLGZ4igq1
 p+qKy8jwC6OEV7PhcyWRBt5FmvVyCNKhR4HURoR4kN2jNPw3Uinhxrev565kpG/nKzwJ8A
 7iDwIaTjs5qUu098bXS6z5wQDVM4VGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-jzk67n9-Oma0pGG8dvK4nQ-1; Thu, 14 May 2020 11:55:46 -0400
X-MC-Unique: jzk67n9-Oma0pGG8dvK4nQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAA09107ACF4;
 Thu, 14 May 2020 15:55:45 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B541851322;
 Thu, 14 May 2020 15:55:43 +0000 (UTC)
Date: Thu, 14 May 2020 16:55:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: proposal: deprecate -readconfig/-writeconfig
Message-ID: <20200514155540.GN1280939@redhat.com>
References: <7599153e-89a2-9a86-16ad-4a3c6a107b18@redhat.com>
 <20200514085622.GB1280939@redhat.com>
 <56379563-c1f3-3270-f9ac-5bdd49b324aa@redhat.com>
 <20200514153456.GL1280939@redhat.com>
 <93bda646-6f5f-69b6-57ec-36ec9485e84c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <93bda646-6f5f-69b6-57ec-36ec9485e84c@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 11:31:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 14, 2020 at 05:51:02PM +0200, Paolo Bonzini wrote:
> On 14/05/20 17:34, Daniel P. Berrangé wrote:
> > Yeah, the key thing is that you really want to be able to provide the
> > whole initial config in one go as an atomic action. I don't want to
> > issue 100 individual QMP commands to load each initial device.
> 
> Why?  I think if we do something like the qemu-vm-$TARGET that you
> propose below, there's absolutely no difference between the two.

Ok, I should clarify. I don't want to do 100 individual serialized
round-trip request+reply, as that'd create latency on startup.
100 pipelined/parallelized request+reply would be ok, as you'll
not have the synchronization delay for each command.

Today the biggest cause of slow startup in libvirt, is issuing
something like 100+ serialized QMP calls to check status of
individual CPUID features. Possibly this is already just a libvirt
bug we can could just stuff all 100 qom-get queries down the pipe
in one go and have 1 wait for replies to arrive.

> Then you'd have a
> 
> qemu-run /some/file.yaml
> 
> (notice the lack of $TARGET) that takes care of starting the VM.
> 
> > I tend to think we'd be better served by focusing on introducing a new set
> > of binaries,  qemu-vm-$TARGET, which exclusively use a new config syntax,
> > free of any legacy baggage present in qemu-system-$TARGET.
> > 
> > Work on qemu-vm-$TARGET will involve refactoring, and that will certainly
> > risk causing bugs in qemu-system-$TARGET. The premise though is that this
> > risk is lower, than if we tried to retrofit a new config syuntax directly
> > into qemu-system-$TARGET.
> > 
> > In particular I think it is basically impossible to do any meaningful
> > changes in the main() method of softmmu/vl.c, due to the fragile ordering
> > for creation of various different devices/backends, and its interaction
> > with the argv parsing. By using a new qemu-vm-$TARGET we can have a new
> > softmmu/vm.c, instead of vl.c. We'll still likely need to modify parts of
> > vl.c to use new/changed API calls, but that's less distruptive, as we
> > can leave the crazy logic for ordering of device creation untouched.
> 
> Agreed.
> 
> Paolo
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



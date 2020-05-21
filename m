Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCE0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 09:46:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A34E20721
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 09:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UC1sOMhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A34E20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbhmO-0000nl-QV
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 05:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jbhlG-0007Tz-BJ
 for qemu-devel@nongnu.org; Thu, 21 May 2020 05:45:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48125
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jbhlE-0003H7-M7
 for qemu-devel@nongnu.org; Thu, 21 May 2020 05:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590054306;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hNzTiv0oKZQS6AlnQUHoaMOspKjbIvhv1u+9dEMYpe8=;
 b=UC1sOMhXuGFH9BMr9vQpo/V2inURaa9tzQ2EvNsS429W+cMaLu91IEGXfxMJnYyfRy6ycF
 s0G1CMat4hzVP6fQsUI7B/yBy3KBBXPjM7FjgcO43eB7C01xkUAaAgfzDtiNxcrs5KdoyJ
 0z2aSiKS2ctvOAXs7oDSYyXT34F5G2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-QUYnSaRJO0q6FLLE5seZlw-1; Thu, 21 May 2020 05:44:55 -0400
X-MC-Unique: QUYnSaRJO0q6FLLE5seZlw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07DCCEC1A2;
 Thu, 21 May 2020 09:44:54 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C01F079584;
 Thu, 21 May 2020 09:44:51 +0000 (UTC)
Date: Thu, 21 May 2020 10:44:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Robert Hoo <robert.hu@linux.intel.com>
Subject: Re: [PATCH v4 5/5] target/i386: remove Icelake-Client CPU model
Message-ID: <20200521094448.GA2211791@redhat.com>
References: <20200520021007.30649-1-chenyi.qiang@intel.com>
 <20200520021007.30649-6-chenyi.qiang@intel.com>
 <20200520091734.GD2194189@redhat.com>
 <40954b28075efac72948a9fd43b59ff4e2e9f42a.camel@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <40954b28075efac72948a9fd43b59ff4e2e9f42a.camel@linux.intel.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 qemu-devel@nongnu.org, Chenyi Qiang <chenyi.qiang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 21, 2020 at 09:40:55AM +0800, Robert Hoo wrote:
> On Wed, 2020-05-20 at 10:17 +0100, Daniel P. Berrangé wrote:
> > On Wed, May 20, 2020 at 10:10:07AM +0800, Chenyi Qiang wrote:
> > > There are no Icelake Desktop products in the market. Remove the
> > > Icelake-Client CPU model.
> > 
> > QEMU has been shipping this CPU model for 2 years now. Regardless
> > of what CPUs Intel are selling, it is possible for users to be
> > running VMs with Icelake-Client CPU if their host satisfies the
> > listed features. So I don't think it is valid to remove this.
> > 
> This 'Icelake-Client' actually doesn't exist. How do we define its
> feature list? and who will be using it? If any special feature tailor
> requirement, it can be simply achieved by '-cpu Icelake,+/-' features,
> this is the correct way.

Well its feature list is defined by what exists in QEMU code right
now. Presumably was based off some silicon that did exist in Intel
at some point, or it would not have been added to QEMU in the first
place ?

Changing guests to use "-cpu Icelake-Server,+/-" would be a guest
ABI change because of the different model number IIUC

> I think we should remove it. When we realize something's not correct,
> we should fix it ASAP. Leaving it there will only cause more serious
> issue in the future.

We have versioned CPU models so that we can fix mistakes in previously
defined CPU model features, without causing breakage for anything that
is using the previous incorrectly defined model.  We can't version the
deletion of a CPU model though. I'm not seeing the serious harm that's
caused by the Icelake-Client CPU model existing though, and deleting
it will definitely cause harm to the config of anything that currently
happens to use it.

Maybe Icelake-Client could be turned into a deprecated alias for a
version of Icelake-Server that has  the cutdown feature list ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



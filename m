Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECCCC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8263C20674
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+W/zDK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8263C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPjeE-0001Kr-If
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 05:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kPjch-0000DZ-12
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:51:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31624)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kPjce-0003Sc-Vr
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601977864;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=SUpnVaD7SmO95eLIoH3qd4WUJOAmWA3+3LIZ7KDhj5s=;
 b=g+W/zDK+Qzw/yi0L1WJF/LBm1hkPjPgCZzrvmBnybYWCSxmmR6CyZggkNR4fgs87wfZ9kl
 GP4XTHea6TN8Mw80oJzEB9Afl+s2irciabqUqzW3OuaD/6DEa4MkCme+0kgbpo8BtxVQFM
 uwLYpODW64Y3k1iaN/I0L+rQO0Fd6Gs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-bA80crYqNKSuXRReLNj4_A-1; Tue, 06 Oct 2020 05:51:02 -0400
X-MC-Unique: bA80crYqNKSuXRReLNj4_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACBAE8D9842;
 Tue,  6 Oct 2020 09:51:01 +0000 (UTC)
Received: from redhat.com (ovpn-114-125.ams2.redhat.com [10.36.114.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D4A610013BD;
 Tue,  6 Oct 2020 09:50:50 +0000 (UTC)
Date: Tue, 6 Oct 2020 10:50:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: QEMU API cleanup initiative - Let's chat during the KVM call
Message-ID: <20201006095047.GG2482221@redhat.com>
References: <1f0b0576-eb07-bf5a-a4d8-c6a2d18d1a94@redhat.com>
 <20201005134552.GC5029@stefanha-x1.localdomain>
 <8e8a7b4d-e3a8-efe0-47b0-d20186970cee@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8e8a7b4d-e3a8-efe0-47b0-d20186970cee@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Andrea Bolognani <abologna@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 05, 2020 at 10:52:41AM -0400, John Snow wrote:
> - Markus considers the platonic ideal of a CLI one in which each flag is a
> configuration directive, and each directive that references another
> directive must appear after the directive in which it references.

In this view you would be creating resources in the order in which they
appear in the understanding that the mgmt app knows what dependancies
it placed between cli options. ie it knows that it wants "-object secret"
created before "-chardev foo", because the chardev depends on the secret
to exist.

Despite the fact that QEMU does not correctly honour the CLI arg order
today, libvirt will place arguments in the order in which they must be
created already. IOW, we know the order they appear in the CLI or
configuration will always work correctly, as long as QEMU honours it.

QEMU has had todo various hacks to deal with the fact that it doesn't
honour ordering, such as creating different -object types at different
stages in startup. This is a really horrible part of QEMU that constantly
causes us pain.

> - I tend to consider the ideal configuration to be a static object that has
> no inherent order from one key to the next, e.g. a JSON object or static
> flat file that can be used to configure the sysemu.

If you treat the configuration as un-ordered, then QEMU needs to be
intelligent enough to figure out the correct order to create all the
resources in. This requires some pieces of code to have a complete
view of all configuration, and know which attrs express dependencies.
It then has to be able to traverse the configuration in the correct
topological sorted order to create things.

Anything is possible, but from where QEMU is starting right now this
feels like a massive task to put in front of ourselves. We basically
have to solve the entire global configuration problem in order to get
this working as you can only do the topological sorting if you can see
the full picture.

The concern I have is that it also injects an element of non-determinism
into the startup procedure that can make things painful to debug. eg there
are theoretically many possible sort orders that are correct for creation,
but if things have unexpected side-effects during creation, these different
orders will not be strictly equivalent in reality.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



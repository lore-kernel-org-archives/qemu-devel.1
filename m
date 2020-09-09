Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA48C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:45:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F7E21532
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WivjGFAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F7E21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG0PH-0000AX-6n
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 09:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kG0OZ-0007eR-Te
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kG0OX-0007D1-R7
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599659056;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Gvsb75gwQcwPDntob8eq/D2/Dwj0VIdBByQgLDVtP4w=;
 b=WivjGFApF7Bm2eE6E0hWjEvDKT+VOW/SiU9UTva3KINctTKU4ZT+8eC2wjRH8vnR4jurSq
 ucDT/SEc7ZzB7jPJoHor1a6HebqiDkOZTgZsx6ue4somX8c2v8eViakDfZzGnrU5yldXQn
 l8c7dLoB+0bWc8xNz8aJoik8iCaIUgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-kQCSDRdgP9-tURAUaPSpfQ-1; Wed, 09 Sep 2020 09:44:13 -0400
X-MC-Unique: kQCSDRdgP9-tURAUaPSpfQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EC2E18BA280;
 Wed,  9 Sep 2020 13:44:11 +0000 (UTC)
Received: from redhat.com (ovpn-113-81.ams2.redhat.com [10.36.113.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D7EC27BCF;
 Wed,  9 Sep 2020 13:44:06 +0000 (UTC)
Date: Wed, 9 Sep 2020 14:44:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC] QEMU as Xcode project on macOS
Message-ID: <20200909134403.GP1011023@redhat.com>
References: <2764135.D4k31Gy3CM@silver>
 <3afbbc20-410a-4466-f3c8-07b718ca8d3f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3afbbc20-410a-4466-f3c8-07b718ca8d3f@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 07:20:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 programmingkidx@gmail.com, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 09, 2020 at 03:41:02PM +0200, Thomas Huth wrote:
> On 09/09/2020 14.56, Christian Schoenebeck wrote:
> > I've recently been thinking about how feasible a stripped down Xcode project 
> > for QEMU would be, i.e. you just get the QEMU sources, click on 
> > qemu.xcodeproj, Cmd + B, done. No extra installation, no configure, nothing.
> 
> Meson seems to have some exporter for Xcode according to
> https://mesonbuild.com/IDE-integration.html ... maybe you can harness
> that feature somehow?

I feel like using the Meson XCode generator still ends up giving us
1 + 1/2 distinct build systems, as I very much doubt that there is
a guarantee of behavioural parity between its XCode output and Ninja
output.

> 
> > The question is, and I don't have the big picture of QEMU yet to judge that, 
> > how much is auto generated for QEMU i.e. with custom scripts that would 
> > probably destroy this plan? There are these trace calls that are auto 
> > generated, is there more like the TCG part for instance?
> 
> Yes, I think we generate code in a couple of places, e.g. the code in
> target/s390x/ uses a "gen-features" helper to generate some code. So
> implementing a separate Xcode project that does not use the main build
> files does not sound very appealing.
> 
>  Thomas
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



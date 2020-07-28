Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8371EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EBA420792
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0D8cf2W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EBA420792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0MSR-0007dO-KI
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 06:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k0MRU-0006Z2-0V
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:02:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28906
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k0MRS-0005ui-57
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595930557;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OydSGjpnOFTQylSU0E3ii0E3lapJHbxVkDV/Jg0X1ow=;
 b=a0D8cf2WnpWyjjs2mJ3wJZXWU2xOsYflXkTddk4rsH8BJgiDAvLw7LVM60tegu+Vgfcvj7
 tMcjFGDRb9xVPq2jUiE89Fukz9hQR7c0I1fXDkMPmoOIqkwBql7GY59IQLJ+KqnRez7H94
 qctwSmud+nT4K813NnCgL/Iqq8MuwFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-A-OvvyCyNNmhUq-L2ZUj5A-1; Tue, 28 Jul 2020 06:02:21 -0400
X-MC-Unique: A-OvvyCyNNmhUq-L2ZUj5A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BBA819253C0;
 Tue, 28 Jul 2020 10:02:20 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC5AE90E7E;
 Tue, 28 Jul 2020 10:02:16 +0000 (UTC)
Date: Tue, 28 Jul 2020 11:02:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 2/3] cirrus.yml: Compile macOS and FreeBSD with -Werror
Message-ID: <20200728100213.GD3430616@redhat.com>
References: <20200724143220.32751-1-thuth@redhat.com>
 <20200724143220.32751-3-thuth@redhat.com>
 <20200724144651.GG3146350@redhat.com>
 <506e2579-410e-8553-6cbf-508793bb35a0@redhat.com>
 <CAFEAcA9C9V_sJT15jkny+zDzZgGDpuQSkuU6XjEDp1i7J0r8CA@mail.gmail.com>
 <20200727105721.GG3400429@redhat.com>
 <3cef33b4-2e7f-92c3-19c3-ca48309f49f0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3cef33b4-2e7f-92c3-19c3-ca48309f49f0@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 00:06:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 28, 2020 at 08:43:29AM +0200, Thomas Huth wrote:
> On 27/07/2020 12.57, Daniel P. Berrangé wrote:
> > On Fri, Jul 24, 2020 at 05:50:47PM +0100, Peter Maydell wrote:
> >> On Fri, 24 Jul 2020 at 17:46, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> >>> I guess we were expecting the distrib to update the pkg.
> >>
> >> Apple's view is that you shouldn't be using the sasl header
> >> at all but instead their proprietary crypto library APIs, so
> >> I wouldn't expect them to ever ship something without the
> >> deprecation warnings.
> > 
> > So from pov of our CI, it seems the right answer is to modify the
> > cirrus.yml to install libsasl2 from homebrew:
> > 
> >   https://formulae.brew.sh/formula-linux/libsasl2
> 
> Ok, that one confused me for quite a while, since brew refused to find
> it in the macOS jobs on Cirrus-CI. The solution: This is not a macOS
> package, but a Linux package! Homebrew is apparently also available for
> Linux. There is no libsasl package in homebrew for macOS.

Hah, I totally missed that too.

> So what to do now? I think introducing a libsasl submodule to QEMU just
> for compiling this code on macOS without warnings is also overkill. And
> if I got the answers here right, --disable-sasl is also disliked (since
> this code likely should still be (compile-)tested on macOS).
> So I think I'll go for the same trick as Peter is using for his tests
> and use --extra-cflags='-Werror -Wno-error=deprecated-declarations'.

Seems like despite the deprecation, people just continue to use the
system sasl. I guess the extra-cflags  is reasonable for CI, and it
gives end users a warning that they're relyin on a feature of macOS
that's not considered stable....even if it doesn't appear to have
had any actual changes for 10 years.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



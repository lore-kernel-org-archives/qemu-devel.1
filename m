Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECABC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:49:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC6FD20674
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEqfn0sa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC6FD20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz0tJ-0005CD-SV
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 12:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jz0sm-0004n0-AL
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:49:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37026
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jz0sj-0003Sh-Of
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595609350;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pNpPDDlhpQEzOp1bv70q2/ziDD8U+HgswXgyEtjTWFE=;
 b=UEqfn0saTNFgKBFWLpNynN2LIi86+LKOORWykSWl3wM3EOUnpjkmzPWC7ZB+ktyhEfDauP
 HMC5FPP0yMgOFe4jDt0pzew/QqE0Ii0/FqTnzwbzEYON4J+SGX8fPLLAmvRcQvd36egqvM
 apaRM7gfh5FfwhLRGaWOG7pfwPX728U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-D2p_PkcrPpWnTZpu4_xvAw-1; Fri, 24 Jul 2020 12:49:08 -0400
X-MC-Unique: D2p_PkcrPpWnTZpu4_xvAw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74E71800460;
 Fri, 24 Jul 2020 16:49:07 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 926AF5C1BB;
 Fri, 24 Jul 2020 16:49:04 +0000 (UTC)
Date: Fri, 24 Jul 2020 17:49:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 2/3] cirrus.yml: Compile macOS and FreeBSD with -Werror
Message-ID: <20200724164901.GO3146350@redhat.com>
References: <20200724143220.32751-1-thuth@redhat.com>
 <20200724143220.32751-3-thuth@redhat.com>
 <20200724144651.GG3146350@redhat.com>
 <506e2579-410e-8553-6cbf-508793bb35a0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <506e2579-410e-8553-6cbf-508793bb35a0@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 06:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 24, 2020 at 06:46:23PM +0200, Philippe Mathieu-Daudé wrote:
> On 7/24/20 4:46 PM, Daniel P. Berrangé wrote:
> > On Fri, Jul 24, 2020 at 04:32:19PM +0200, Thomas Huth wrote:
> >> Compiler warnings currently go unnoticed in our FreeBSD and macOS builds,
> >> since -Werror is only enabled for Linux and MinGW builds by default. So
> >> let's enable them here now, too.
> >> For macOS, that unfortunately means that we have to disable the vnc-sasl
> >> feature, since this is marked as deprecated in the macOS headers and thus
> >> generates a lot of deprecation warnings.
> > 
> > I wonder if its possible to add
> > 
> > #pragma GCC diagnostic push
> > #pragma GCC diagnostic ignored "-Wdeprecated"
> > 
> > ...
> > 
> > #pragma GCC diagnostic pop
> > 
> > to silence just one source file ?
> 
> 3 years ago Peter said:
> 
> "The awkward part is
>  that it has to  be in force at the point where the deprecated
>  function is used, not where it's declared. So you can't just wrap
>  the #include of the ssl header in pragmas, you'd have to either
>  do it at every callsite or else over the whole .c file."

Nearly all our sasl code is isolated in ui/vnc-auth-sasl.c, so we
can just do pragma push/pop around that entire file.

There's then just two remaining cases in ui/vnc.c which are
easy enough to deal with, or we can move the calls out of vnc.c
into vnc-auth-sasl.c to fully isolate the code

> 
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg459264.html
> 
> I guess we were expecting the distrib to update the pkg.
> 
> > 
> > 
> > Regards,
> > Daniel
> > 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



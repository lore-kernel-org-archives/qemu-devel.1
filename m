Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CA5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7F722074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCaEwbi8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F722074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kATzY-0004C6-5G
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kATz1-0003ji-3I
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:07:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60061
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kATyy-00069S-OH
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598342823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XLoUtTRJkT7sm8yOeII3rGZpMmMnkgTVF4Hkh6SZAh8=;
 b=JCaEwbi8Qu9EkkGhSco6hHLUZo5GP4BUfv4ZzoqZoc5YYeJ2NW6GeqS5n5a+dM/87M2q7d
 C1mqToFL8a5admCXqDzhHVR6WNfNVGt2+JHD+REUUMjK0RoN22+dwt0FGObLVYCYwjdFEi
 87SmAd8LAFW+7czuxMoLFKb6F1eirAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-2eDA2hNQNCKuzC744isTag-1; Tue, 25 Aug 2020 04:06:59 -0400
X-MC-Unique: 2eDA2hNQNCKuzC744isTag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98C9C80EF9F;
 Tue, 25 Aug 2020 08:06:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B78560FC2;
 Tue, 25 Aug 2020 08:06:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 55A9016E18; Tue, 25 Aug 2020 10:06:57 +0200 (CEST)
Date: Tue, 25 Aug 2020 10:06:57 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH] meson: set colorout to auto
Message-ID: <20200825080657.saqysz6rugvhomrl@sirius.home.kraxel.org>
References: <20200825064342.2037-1-kraxel@redhat.com>
 <CAJ+F1CJ0J5E2sJ=jvG7m=5pttOYohGvwqUjMFM1Vz5qBmhnk5Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJ0J5E2sJ=jvG7m=5pttOYohGvwqUjMFM1Vz5qBmhnk5Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:05:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 10:59:42AM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Aug 25, 2020 at 10:44 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> 
> > Dunno why the default is set to "always".  IMHO it should be "auto",
> > i.e. only colorize in case stdout goes to a terminal.  Cluttering
> > logfiles and confusing compiler message parsers with terminal control
> > sequences is not nice ...
> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >
> 
> "Enable colored output with GCC. Ninja redirects stdout/stderr so by
> default GCC thinks it is not talking to a terminal"
> 
> https://github.com/mesonbuild/meson/commit/4f63fe498314c385de2d3b6a3a953d15985914d2

Hmm, maybe ninja handles this then, by stripping the terminal sequences
in case stdout isn't a terminal.

With ninja being the default backend the default kind-of makes sense
(for meson upstream) ...

> Since we use make, I don't know if it's any better.

... but given qemu uses make not ninja we might prefer something else ;)

As far I know make doesn't redirect output.  Or maybe it redirects using
a pty (instead of a pipe) in case stdout is a terminal.  At least auto
mode for colored gcc warnings works fine with make.  It is colored when
started in a terminal, it isn't when started in emacs (and piped through
the emacs message parser).

> Perhaps meson should set compiler/tools colors = always/never based on what
> it is connected to at configure time instead?

Why?  Even when running configure in a terminal I might use emacs for
builds later on.

take care,
  Gerd



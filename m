Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DCAC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 09:02:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52D6021479
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 09:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D6021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49661 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT0fQ-0000KI-Mm
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 05:02:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hT0XK-0002My-4T
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:54:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hT0XI-0001b4-PO
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:54:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hT0XI-0001aT-GC
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:54:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ABFB98830E;
	Tue, 21 May 2019 08:54:07 +0000 (UTC)
Received: from redhat.com (ovpn-112-26.ams2.redhat.com [10.36.112.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E59A160FBE;
	Tue, 21 May 2019 08:53:53 +0000 (UTC)
Date: Tue, 21 May 2019 09:53:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190521085350.GF25835@redhat.com>
References: <20190520184108.GA10764@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190520184108.GA10764@habkost.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Tue, 21 May 2019 08:54:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Introducing GSoC project: API Documentation
 Generation
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Gabriel Barreto <sbarreto.gabriel@gmail.com>,
	qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>,
	Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 20, 2019 at 03:41:08PM -0300, Eduardo Habkost wrote:
> Please welcome GSoC student Gabriel Barreto.  Gabriel is going to
> work on QEMU API Documentation Generation[1].
> 
> Gabriel's first task is to evaluate our options for extract doc
> comments from C source code and integrate them into Sphinx
> documentation.  I saw that Peter has experimented with kernel-doc
> in the past[2][3].  Has anybody evaluated other alternatives?
> (e.g. Hawkmoth[4])

In the past I tested both GTK-DOC and Doxygen.

GTK-DOC has assumptions that you're following "normal" GTK/GLib style and
can't cope with many C type decls if you diverge, which rules it out on
practical grounds.

Doxygen can parse more or less anything which I really dislike the output
structure it generates for docs as it is not at all friendly to browser and
find the info you actually want compared to other docs tools

Hawkmoth seems pretty attractive in its output format, but doesn't appear
to be part of either Debian or Fedora distros, so we would have to bundle
it in QEMU I expect.  My big concern there is that there have only been
2 contributors to Hawkmoth in its entire 3 year existance, which makes
me fear for its long term viability if the main author gives up.

QEMU should pick a tool which is well established / widely used & thus
stands a good chance of being maintained for the long term, as we don't
want to end up relying on abandonware in 5 years time.  The kernel-doc
project is not widely used, but its main user is significant enough that
it isn't likely to die through lack of maintainers.

If we're using sphinx for the rest of our docs, then I think it is pretty
compelling to have a docs tool that integrates well with sphinx.

I personally don't care much about the source comment annotation syntax.
It is mostly just a matter of bikeshed colour picking, and no matter
which tool we pick will require updates to the source. The style /
layout / readability of the output is more important to me.

> [1] https://wiki.qemu.org/Google_Summer_of_Code_2019#API_documentation_generation
> [2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg411643.html
> [3] https://www.mail-archive.com/qemu-devel@nongnu.org/msg411841.html
> [4] https://readthedocs.org/projects/hawkmoth/

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AB0C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:13:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A5320EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekk1oEQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A5320EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHkYP-0001ww-3w
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 05:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kHkXk-0001El-RU
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:13:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31520
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kHkXi-0008HD-G4
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600074777;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=nN5r5rV5o7uf2HwOh5Z1rX7MrM9DelDhDi6fXi9fewQ=;
 b=ekk1oEQhRmM+rm8l90ZU5UX9vIxsJK89LRWVllMHrzZugRUDCRq9KrWMOsv44l4rQbsCxk
 iD9Yz9lUQGA13vyJW9jFfc9MTxzFCOqfknjtGvgLjlQsz1fDP/9+E0E0q/Bs/4P9L8bMra
 tAwGXxHJCcDEHOWXcxSjsSUHAzmcltU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-BNbx1EI1Mr6Ur7619RJzwg-1; Mon, 14 Sep 2020 05:12:53 -0400
X-MC-Unique: BNbx1EI1Mr6Ur7619RJzwg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 125D51005E63;
 Mon, 14 Sep 2020 09:12:52 +0000 (UTC)
Received: from redhat.com (ovpn-114-99.ams2.redhat.com [10.36.114.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A158E5DA60;
 Mon, 14 Sep 2020 09:12:47 +0000 (UTC)
Date: Mon, 14 Sep 2020 10:12:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 0/3] Automatically convert configure options to meson
 build options
Message-ID: <20200914091244.GE1252186@redhat.com>
References: <20200913100534.22084-1-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200913100534.22084-1-pbonzini@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 00:11:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Sep 13, 2020 at 12:05:31PM +0200, Paolo Bonzini wrote:
> Right now meson_options.txt lists less than a dozen options, but about
> 40 more could come as configure tests are converted and moved to
> meson.build.  Each option needs code in configure to parse it and pass
> the option down to Meson as a -D command-line argument; in addition the
> default must be duplicated between configure and meson_options.txt.
> 
> This series tries to remove the code duplication by passing unknown
> --enable and --disable options to a Python program, and using
> Meson's introspection support to match those to meson_options.txt
> 
> The disadvantages are:
> 
> - because we parse command-line options before meson is available,
> the introspection output is stored in the source tree.  The output
> is slightly modified using the "jq" tool in order to ensure that it's
> stable and that modifications to meson_buildoptions.txt do not cause
> horrible conflicts.  This is the main reason for the unattractive
> diffstat (the number of JSON lines added is higher than the number
> of configure lines removed, though of course the latter are code
> that must be maintained manually and the former is not).
> 
> - we now need Python to generate the full help, so if Python is
> missing we can only print a partial message and direct the user
> to specify the interpreter with --python.  It would be possible to fix
> this by rewriting the script in Perl (at least on Fedora, JSON::PP is
> always installed if Perl is, because it's a dependency for CPAN; I'd
> have to check Ubuntu and the BSDs), or if we want to write it as a
> Bourne shell script, to further massage the introspection output into
> for example TAB-separated values.

IMHO we should stay as far away from Perl as possible, and I say this as
someone who enjoys writing Perl scripts !  Perl is a significant barrier
to entry for potential contributors, because it just doesn't have the
wide knowledge base that it did in the past. You can expect most people
to have some familiarity with Python, or be able to pick it up fairly
easily in a way that just isn't possible in Perl.

As for shell, we have a never ending stream of bugs due to the wide
range of different shell impls which make portable coding very hard.

In general I think our overall goal should be to focus on getting down to
use of a single scripting language in QEMU, and that language clearly has
to be python3. We shouldn't introduce any new usage of Perl or Shell
in QEMU IMHO. Even if we think the usage will only be short term temporary
workaround, short term hacks in QEMU have a habit of living for years longer
than we expect.

> Opinions are welcome on whether this is worthwhile and how to solve
> the above doubts.

IIUC, the motivation of this series is just to remove some duplication
of defaults / args, nothing more than that ?

If correct, then I'd say it probably isn't worth the hassle. I'd say we
should focus effort on just converting more of configure to meson, as
quickly as practical, and not try to add much more magic that's only
relevant for the transition time.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



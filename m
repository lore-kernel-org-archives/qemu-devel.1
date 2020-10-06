Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833CCC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0183206B5
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iY1dIV73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0183206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPjTP-0006u9-Im
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 05:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kPjSo-0006Pb-Rg
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:40:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kPjSm-00022K-Th
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601977251;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=OFV8TnhdqroiWL8YIZL5W4hL51Qr8ixqyz5z9kLoT30=;
 b=iY1dIV73TMKZNR0RF0qOnBCBxr1GNQasHoPcwMJw4VF67uii3/A3tzjlMHdqdOz8uJv1uK
 5+1qe3tGitqgZCtkfgTNHEQuXZR6cNJEoWKlk4590uFYkXZAohLxGEOvulJwa9z3JkLUGp
 57NgxdWFyHnL4jtpOH4MgRcnGHLtsFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-t7evruisPmOdBADcpbAJHw-1; Tue, 06 Oct 2020 05:40:47 -0400
X-MC-Unique: t7evruisPmOdBADcpbAJHw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B5C08D984C;
 Tue,  6 Oct 2020 09:40:46 +0000 (UTC)
Received: from redhat.com (ovpn-114-125.ams2.redhat.com [10.36.114.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD68C7366A;
 Tue,  6 Oct 2020 09:40:34 +0000 (UTC)
Date: Tue, 6 Oct 2020 10:40:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: QEMU API cleanup initiative - Let's chat during the KVM call
Message-ID: <20201006094032.GF2482221@redhat.com>
References: <1f0b0576-eb07-bf5a-a4d8-c6a2d18d1a94@redhat.com>
 <20201005134552.GC5029@stefanha-x1.localdomain>
 <8e8a7b4d-e3a8-efe0-47b0-d20186970cee@redhat.com>
 <9b6c8327-7e53-ef1d-e576-1e091ca1e04f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9b6c8327-7e53-ef1d-e576-1e091ca1e04f@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Andrea Bolognani <abologna@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 06, 2020 at 11:30:20AM +0200, Paolo Bonzini wrote:
> On 05/10/20 16:52, John Snow wrote:
> > - Markus considers the platonic ideal of a CLI one in which each flag is
> > a configuration directive, and each directive that references another
> > directive must appear after the directive in which it references.
> > 
> > - I tend to consider the ideal configuration to be a static object that
> > has no inherent order from one key to the next, e.g. a JSON object or
> > static flat file that can be used to configure the sysemu.
> > 
> > They're not compatible visions; and they have implications for error
> > ordering and messages and so on.
> 
> I think they aren't incompatible.  Even your idea would probably forbid
> cycles, so it only takes a topological sort to go from an unordered
> configuration to an ordered one.  The only difference is whether it's
> the user or the program that does it.
> 
> > For the meantime, Markus's vision is closer to what QEMU already does,
> > so it's likely the winning answer for now and if a conversion to the
> > other idea is required at a time later, we'll have to tackle it then. (I
> > think.)
> > 
> > It's a good subject of discussion. (Also relevant: if parsing is to
> > occur in more than the CLI context, the existing contextual CLI parser
> > error system needs to be reworked to avoid monitor-unsafe error calls.
> > It's not trivial, I think.)
> 
> I think parsing should occur in CLI context only, but errors can occur
> elsewhere too.
> 
> I think the idea for this kind of refactoring is always to first make
> the code behave the way you want, and only then change the
> implementation to look the way you want.
> 
> Currently we have:
> 
>     switch (...) {
>         case QEMU_OPT_...:
>             /* something has side effects, something is just parsing */
>     }
> 
>     init1();
>     qemu_opts_foreach(something_opts, configure_something);
>     init2();
>     qemu_opts_foreach(some_more_opts, configure_some_more);
>     init3();
> 
>     enter_preconfig();
> 
> We should first of all change it to
> 
>     parse_command_line() {
>         apply_simple_options()l
>         qemu_opts_foreach(something_opts, configure_something);
>         qemu_opts_foreach(some_more_opts, configure_some_more);
>     }
> 
>     switch (...) {
>         case QEMU_OPT_...:
>         /* no side effects on the initN() calls below */
>     }
> 
>     init1();
>     init2();
>     init3();
> 
>     parse_command_line()
> 
>     enter_preconfig();
> 
>     more_init_that_needs_side_effects();
> 
> This way, the parse_command_line() and its qemu_opts_foreach callbacks
> can become changed into a series of qmp_*() commands.  The commands can
> be called within the appropriate loc_push() though.
> 
> Problem is, it's 1000 lines of initialization interspersed with
> qemu_opts_foreach calls.  But it's doable.

I feel that both of these approaches are equally broken, as they don't
honour the order in which arguments are passed by the caller when
creating resources.

This leads to the crazy hacks we have with -object where we have to
create certain objects at certain stages.

To make QEMU CLI parsing sane we need to be able to create objects as
we parse them.

   while (n++ < argc) {
        switch (argv[n]) {
           case QEMU_OPT_foo:
             ...parse argv[n]...
             ...create argv[n]...
        }
   }

IOW, all usage of 'qemu_opts_foreach' should be targetted for complete
elimination.

I'm not convinced that your proposed change takes us in direction, if
anything it is encoding the current split of parsing vs creation even
more strongly.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



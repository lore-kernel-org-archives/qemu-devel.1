Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E30C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F2C32177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iV70Z6q2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2C32177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBIuI-0001Rj-Pn
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 10:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBItS-0000sU-N6
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBItP-0004C5-TW
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598538522;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hIcVXgTMCdAnGJb5mNud9JQ+Nw6+rL459JQvWtuUo7Q=;
 b=iV70Z6q2nUz+BRLzjZdhvcDUskkIO9ycx3Tk7+L7sslcwHn7r8dw0wbhoSMhoWNbDS473u
 QJKyVUL1d1mboF8Xj1iImzN7cb70hiFEBisA84adA5d1pzfadPEMYmlVtvje1iA/ShTisI
 mCLolteT30mYUChqUD5PTOHdDXv50+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-b_aCEx2PM06tNzsezVdrng-1; Thu, 27 Aug 2020 10:28:31 -0400
X-MC-Unique: b_aCEx2PM06tNzsezVdrng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBE781074FB2;
 Thu, 27 Aug 2020 14:28:30 +0000 (UTC)
Received: from redhat.com (ovpn-114-113.ams2.redhat.com [10.36.114.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14A755B6B7;
 Thu, 27 Aug 2020 14:28:24 +0000 (UTC)
Date: Thu, 27 Aug 2020 15:28:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v7 1/8] Introduce yank feature
Message-ID: <20200827142822.GV192458@redhat.com>
References: <cover.1596528468.git.lukasstraub2@web.de>
 <0092d4fe5f64078a18db3790c46c508416dbdb6b.1596528468.git.lukasstraub2@web.de>
 <871rjs9ser.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <871rjs9ser.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:54:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 27, 2020 at 02:37:00PM +0200, Markus Armbruster wrote:
> I apologize for not reviewing this much earlier.
> 
> Lukas Straub <lukasstraub2@web.de> writes:
> 
> > The yank feature allows to recover from hanging qemu by "yanking"
> > at various parts. Other qemu systems can register themselves and
> > multiple yank functions. Then all yank functions for selected
> > instances can be called by the 'yank' out-of-band qmp command.
> > Available instances can be queried by a 'query-yank' oob command.
> >
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  include/qemu/yank.h |  80 +++++++++++++++++++
> >  qapi/misc.json      |  45 +++++++++++
> >  util/Makefile.objs  |   1 +
> >  util/yank.c         | 184 ++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 310 insertions(+)
> >  create mode 100644 include/qemu/yank.h
> >  create mode 100644 util/yank.c


> > + *
> > + * This function is thread-safe.
> > + *
> > + * @instance_name: The name of the instance
> > + * @func: The yank function
> > + * @opaque: Will be passed to the yank function
> > + */
> > +void yank_register_function(const char *instance_name,
> > +                            YankFn *func,
> > +                            void *opaque);
> 
> Pardon my ignorance... can you explain to me why a yank instance may
> have multiple functions?

multifd migration - there's a single migration "instance", which
has multiple FDs open, each of which has a func registered.


> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index 9d32820dc1..0d6a8f20b7 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -1615,3 +1615,48 @@
> >  ##
> >  { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
> >
> > +##
> > +# @YankInstances:
> > +#
> > +# @instances: List of yank instances.
> > +#
> > +# Yank instances are named after the following schema:
> > +# "blockdev:<node-name>", "chardev:<chardev-name>" and "migration"
> > +#
> > +# Since: 5.1
> > +##
> > +{ 'struct': 'YankInstances', 'data': {'instances': ['str'] } }
> 
> I'm afraid this is a problematic QMP interface.
> 
> By making YankInstances a struct, you keep the door open to adding more
> members, which is good.
> 
> But by making its 'instances' member a ['str'], you close the door to
> using anything but a single string for the individual instances.  Not so
> good.
> 
> The single string encodes information which QMP client will need to
> parse from the string.  We frown on that in QMP.  Use QAPI complex types
> capabilities for structured data.
> 
> Could you use something like this instead?
> 
> { 'enum': 'YankInstanceType',
>   'data': { 'block-node', 'chardev', 'migration' } }
> 
> { 'struct': 'YankInstanceBlockNode',
>   'data': { 'node-name': 'str' } }
> 
> { 'struct': 'YankInstanceChardev',
>   'data' { 'label': 'str' } }
> 
> { 'union': 'YankInstance',
>   'base': { 'type': 'YankInstanceType' },
>   'discriminator': 'type',
>   'data': {
>       'block-node': 'YankInstanceBlockNode',
>       'chardev': 'YankInstanceChardev' } }
> 
> { 'command': 'yank',
>   'data': { 'instances': ['YankInstance'] },
>   'allow-oob': true }
> 
> If you're confident nothing will ever be added to YankInstanceBlockNode
> and YankInstanceChardev, you could use str instead.

I raised this idea back in the v1 posting. There's a thread starting
at this:

  https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg02881.html

which eventually concluded that plain string is best.

I think that's right because the yank feature is providing generic
infrastructure with zero knowledge of backends that are using it.
The only interaction between the yank functionality and its callers
is via an opaque function callback. So there's no conceptual place
at which the yank infra would want to know about the backends nor
pass any backend specific config params to it.

> > +##
> > +# @yank:
> > +#
> > +# Recover from hanging qemu by yanking the specified instances.
> 
> What's an "instance", and what does it mean to "yank" it?
> 
> The documentation of YankInstances above gives a clue on what an
> "instance" is: presumably a block node, a character device or the
> migration job.
> 
> I guess a YankInstance is whatever the code chooses to make one, and the
> current code makes these three kinds.
> 
> Does it make every block node a YankInstance?  If not, which ones?
> 
> Does it make every character device a YankInstance?  If not, which ones?
> 
> Does it make migration always a YankInstance?  If not, when?

From the POV of the yank code, the "instance" is intentionally opaque.
Whatever the instance wants todo with its callback is acceptable, as
long as it isn't violating the rules for the callback by doing stuff
which can block. In practice right now, an instance is anything which
has a network connection associated with it, but it doesn't have to be
restricted to just networking. Anything which is talking to a service
which can get "stuck" is in scope for supporting yanking.

eg I could imagine an instance having some external helper process and
the yank callback would kill the process 



> > +static void __attribute__((__constructor__)) yank_init(void)
> > +{
> > +    qemu_mutex_init(&lock);
> > +}
> > --
> > 2.20.1
> 
> The two QMP commands permit out-of-band execution ('allow-oob': true).
> OOB is easy to get wrong, but I figure you have a legitimate use case.
> Let's review the restrictions documented in
> docs/devel/qapi-code-gen.txt:
> 
>     An OOB-capable command handler must satisfy the following conditions:
> 
>     - It terminates quickly.
>     - It does not invoke system calls that may block.
>     - It does not access guest RAM that may block when userfaultfd is
>       enabled for postcopy live migration.
>     - It takes only "fast" locks, i.e. all critical sections protected by
>       any lock it takes also satisfy the conditions for OOB command
>       handler code.
> 
> Since the command handlers take &lock, the restrictions apply to the
> other critical sections protected by &lock as well.  I believe these are
> all okay: they do nothing but allocate, initialize and free memory.
> 
> The restrictions also apply to the YankFn callbacks, but you documented
> that.  Okay.
> 
> The one such callback included in this patch is
> yank_generic_iochannel(), which is a thin wrapper around
> qio_channel_shutdown(), which in turn runs the io_shutdown method.
> Thus, the restructions also apply to all the io_shutdown methods.
> That's not documented.
> 
> Daniel, should it be documented?

Patch 6 documents that the qio_channel_shutdown method must be
thread safe but perhaps the doc could be more explicit

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



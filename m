Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD78BC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 07:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A26B2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 07:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hL73cFhO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A26B2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCeY8-0001e9-L8
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 03:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kCeXX-0001Aj-D0
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 03:47:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59506
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kCeXV-00012P-Lq
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 03:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598860060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jesAh/upVKcx7IWTjN+g4wWmcm2yJtbjQP8iQM7Dbws=;
 b=hL73cFhOc0+v2NbGyXKNAu3rlrS7+YDh84/qlqupiLxoifzxzyLTbsJYqcZ3+ltpXV7xp5
 if8mRRVc2VblCKQzWE4M0E58v5ae13ZIa4TGdZQFxXfUCHYbP3DL0FYTz1VWHpsR6huJFa
 Qk1eKyWAhopilbZVVSEx0Unc9/aevjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-0Wk2hMoLN7OiYR-FXM775Q-1; Mon, 31 Aug 2020 03:47:39 -0400
X-MC-Unique: 0Wk2hMoLN7OiYR-FXM775Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C59DC1006700;
 Mon, 31 Aug 2020 07:47:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EED387B2D;
 Mon, 31 Aug 2020 07:47:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 24495113864A; Mon, 31 Aug 2020 09:47:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v7 1/8] Introduce yank feature
References: <cover.1596528468.git.lukasstraub2@web.de>
 <0092d4fe5f64078a18db3790c46c508416dbdb6b.1596528468.git.lukasstraub2@web.de>
 <871rjs9ser.fsf@dusky.pond.sub.org> <20200828162145.21d082af@luklap>
Date: Mon, 31 Aug 2020 09:47:33 +0200
In-Reply-To: <20200828162145.21d082af@luklap> (Lukas Straub's message of "Fri, 
 28 Aug 2020 16:21:45 +0200")
Message-ID: <878sdvdzoq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 02:54:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Lukas Straub <lukasstraub2@web.de> writes:

> On Thu, 27 Aug 2020 14:37:00 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> I apologize for not reviewing this much earlier.
>> 
>> Lukas Straub <lukasstraub2@web.de> writes:
>> 
>> > The yank feature allows to recover from hanging qemu by "yanking"
>> > at various parts. Other qemu systems can register themselves and
>> > multiple yank functions. Then all yank functions for selected
>> > instances can be called by the 'yank' out-of-band qmp command.
>> > Available instances can be queried by a 'query-yank' oob command.
>> >
>> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
>> > Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
[...]
>> > diff --git a/qapi/misc.json b/qapi/misc.json
>> > index 9d32820dc1..0d6a8f20b7 100644
>> > --- a/qapi/misc.json
>> > +++ b/qapi/misc.json
>> > @@ -1615,3 +1615,48 @@
>> >  ##
>> >  { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
>> >
>> > +##
>> > +# @YankInstances:
>> > +#
>> > +# @instances: List of yank instances.
>> > +#
>> > +# Yank instances are named after the following schema:
>> > +# "blockdev:<node-name>", "chardev:<chardev-name>" and "migration"
>> > +#
>> > +# Since: 5.1
>> > +##
>> > +{ 'struct': 'YankInstances', 'data': {'instances': ['str'] } }  
>> 
>> I'm afraid this is a problematic QMP interface.
>> 
>> By making YankInstances a struct, you keep the door open to adding more
>> members, which is good.
>> 
>> But by making its 'instances' member a ['str'], you close the door to
>> using anything but a single string for the individual instances.  Not so
>> good.
>> 
>> The single string encodes information which QMP client will need to
>> parse from the string.  We frown on that in QMP.  Use QAPI complex types
>> capabilities for structured data.
>> 
>> Could you use something like this instead?
>> 
>> { 'enum': 'YankInstanceType',
>>   'data': { 'block-node', 'chardev', 'migration' } }
>> 
>> { 'struct': 'YankInstanceBlockNode',
>>   'data': { 'node-name': 'str' } }
>> 
>> { 'struct': 'YankInstanceChardev',
>>   'data' { 'label': 'str' } }
>> 
>> { 'union': 'YankInstance',
>>   'base': { 'type': 'YankInstanceType' },
>>   'discriminator': 'type',
>>   'data': {
>>       'block-node': 'YankInstanceBlockNode',
>>       'chardev': 'YankInstanceChardev' } }
>> 
>> { 'command': 'yank',
>>   'data': { 'instances': ['YankInstance'] },
>>   'allow-oob': true }
>> 
>> If you're confident nothing will ever be added to YankInstanceBlockNode
>> and YankInstanceChardev, you could use str instead.
>
> As Daniel said, this has already been discussed.

I'll look up that discussion.

[...]
>> The two QMP commands permit out-of-band execution ('allow-oob': true).
>> OOB is easy to get wrong, but I figure you have a legitimate use case.
>> Let's review the restrictions documented in
>> docs/devel/qapi-code-gen.txt:
>> 
>>     An OOB-capable command handler must satisfy the following conditions:
>> 
>>     - It terminates quickly.
>>     - It does not invoke system calls that may block.
>>     - It does not access guest RAM that may block when userfaultfd is
>>       enabled for postcopy live migration.
>>     - It takes only "fast" locks, i.e. all critical sections protected by
>>       any lock it takes also satisfy the conditions for OOB command
>>       handler code.
>> 
>> Since the command handlers take &lock, the restrictions apply to the
>> other critical sections protected by &lock as well.  I believe these are
>> all okay: they do nothing but allocate, initialize and free memory.
>> 
>> The restrictions also apply to the YankFn callbacks, but you documented
>> that.  Okay.
>> 
>> The one such callback included in this patch is
>> yank_generic_iochannel(), which is a thin wrapper around
>> qio_channel_shutdown(), which in turn runs the io_shutdown method.
>> Thus, the restructions also apply to all the io_shutdown methods.
>> That's not documented.
>> 
>> Daniel, should it be documented?
>> 
> This is already done in patch 6.

Patch 6 adds "This function is thread-safe" to its contract.  The
restrictions on OOB-capable handler code are much more severe than
ordinary thread safety.  For instance, blocking system calls outside
critical sections are thread safe, but not permitted in OOB-capable
handler code.  The contract needs to be more specific.

> Thank you for you review.

Better late than never...  you're welcome!



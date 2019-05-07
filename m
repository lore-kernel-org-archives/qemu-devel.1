Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4BDC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 16:20:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243692054F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 16:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243692054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49597 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO2p2-0004r0-7F
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 12:20:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hO2nq-0004Fu-8r
	for qemu-devel@nongnu.org; Tue, 07 May 2019 12:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hO2np-0002rC-6f
	for qemu-devel@nongnu.org; Tue, 07 May 2019 12:18:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hO2no-0002qf-RU
	for qemu-devel@nongnu.org; Tue, 07 May 2019 12:18:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0624D3E2B0
	for <qemu-devel@nongnu.org>; Tue,  7 May 2019 16:18:48 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8D8AB61085;
	Tue,  7 May 2019 16:18:47 +0000 (UTC)
Date: Tue, 7 May 2019 13:18:45 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190507161845.GL28722@habkost.net>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<87imumj1jb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imumj1jb.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Tue, 07 May 2019 16:18:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/3] Export machine type deprecation info
 through QMP
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
Cc: mprivozn@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 07, 2019 at 07:07:04AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > This series adds machine type deprecation information to the
> > output of the `query-machines` QMP command.  With this, libvirt
> > and management software will be able to show this information to
> > users and/or suggest changes to VM configuration to avoid
> > deprecated machine types.
> 
> This overlaps with something I want to try, namely using Kevin's
> proposed QAPI feature flags for deprecation markings.  Let's compare the
> two.
> 
> To mark something as deprecated with your patches, you add a
> @support-status member somewhere, where "somewhere" is related to
> "something" by "provides information on".
> 
> Example: MachineInfo (returned by query-machines) provides information
> on possible values of -machine parameter type.  If -machine was
> QAPIfied, it would provide information on possible values of a QAPI
> object type's member.  The type might be anonymous.  The member should
> be an enum (we currently use 'str' in MachineInfo).

QAPIfying -machine, -cpu, and -device would be wonderful.

> 
> Example: say we want to deprecate block driver "vfat",
> i.e. BlockdevDriver member @vfat.  Type BlockdevDriver is used in
> multiple places; let's ignore all but BlockdevOptions.  We need to add
> @support-status to something that provides information on
> BlockdevDriver, or maybe on BlockdevOptions.  There is no ad hoc query
> providing information on either of the two, because QAPI/QMP
> introspection has been sufficient.  What now?
> 
> Can we add deprecation information to (general) QAPI/QMP introspection

Yes, we can.  I think it's a good idea.  But:

> instead of ad hoc queries?

I'm not sure about the "instead of" part.  I don't want perfect
to be the enemy of done, and I don't want QAPIfication of
-machine to be a requirement to start reporting machine type
deprecation information.

> 
> Kevin's proposed QAPI feature flags[*] extend the QAPI language so that
> struct types can optionally have a list of feature flags, which are
> strings.  Struct types suffice for his immediate needs.  I'd like to use
> feature flags to mark deprecation by tacking a "deprecated" feature onto
> whatever is deprecated.  This obviously needs feature support for
> everything we want to be able to deprecate: commands, and events, as
> well as members of enum and object types.
> 
> Example: to deprecate block driver "vfat", add feature "deprecated" to
> BlockdevDriver member @vfat.
> 
> Unlike your patches, this does not require finding a "somewhere" that
> provides information on "something".  You simply tack "deprecated" right
> onto "something".
> 
> Your patches provide more information, however: human-readable messages.

It also includes a machine-friendly suggested alternative (which
I think is even more important that the human-readable message).

We could extend QAPI introspection to return that if necessary,
right?


> 
> Food for thought :)
> 
> 
> [*] Hiding in
> Subject: [PATCH 0/4] file-posix: Add dynamic-auto-read-only QAPI feature
> Date: Mon,  8 Apr 2019 16:35:39 +0200
> Message-Id: <20190408143543.3982-1-kwolf@redhat.com>

-- 
Eduardo


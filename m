Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CD1C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 09:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F14E520656
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 09:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14E520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33735 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOIhs-0005Ld-7b
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 05:17:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOIh5-00054n-UG
	for qemu-devel@nongnu.org; Wed, 08 May 2019 05:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOIh4-0007OT-KG
	for qemu-devel@nongnu.org; Wed, 08 May 2019 05:16:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hOIh4-0007Kq-D9
	for qemu-devel@nongnu.org; Wed, 08 May 2019 05:16:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE5F6307D971
	for <qemu-devel@nongnu.org>; Wed,  8 May 2019 09:16:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D8C7600D4;
	Wed,  8 May 2019 09:16:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id E55331132B35; Wed,  8 May 2019 11:16:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<87imumj1jb.fsf@dusky.pond.sub.org>
	<20190507161845.GL28722@habkost.net>
Date: Wed, 08 May 2019 11:16:50 +0200
In-Reply-To: <20190507161845.GL28722@habkost.net> (Eduardo Habkost's message
	of "Tue, 7 May 2019 13:18:45 -0300")
Message-ID: <87lfzh5mrh.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Wed, 08 May 2019 09:16:52 +0000 (UTC)
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

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Tue, May 07, 2019 at 07:07:04AM +0200, Markus Armbruster wrote:
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>> 
>> > This series adds machine type deprecation information to the
>> > output of the `query-machines` QMP command.  With this, libvirt
>> > and management software will be able to show this information to
>> > users and/or suggest changes to VM configuration to avoid
>> > deprecated machine types.
>> 
>> This overlaps with something I want to try, namely using Kevin's
>> proposed QAPI feature flags for deprecation markings.  Let's compare the
>> two.
>> 
>> To mark something as deprecated with your patches, you add a
>> @support-status member somewhere, where "somewhere" is related to
>> "something" by "provides information on".
>> 
>> Example: MachineInfo (returned by query-machines) provides information
>> on possible values of -machine parameter type.  If -machine was
>> QAPIfied, it would provide information on possible values of a QAPI
>> object type's member.  The type might be anonymous.  The member should
>> be an enum (we currently use 'str' in MachineInfo).
>
> QAPIfying -machine, -cpu, and -device would be wonderful.
>
>> 
>> Example: say we want to deprecate block driver "vfat",
>> i.e. BlockdevDriver member @vfat.  Type BlockdevDriver is used in
>> multiple places; let's ignore all but BlockdevOptions.  We need to add
>> @support-status to something that provides information on
>> BlockdevDriver, or maybe on BlockdevOptions.  There is no ad hoc query
>> providing information on either of the two, because QAPI/QMP
>> introspection has been sufficient.  What now?
>> 
>> Can we add deprecation information to (general) QAPI/QMP introspection
>
> Yes, we can.  I think it's a good idea.  But:
>
>> instead of ad hoc queries?
>
> I'm not sure about the "instead of" part.  I don't want perfect
> to be the enemy of done, and I don't want QAPIfication of
> -machine to be a requirement to start reporting machine type
> deprecation information.

Valid point.  Still, I believe we should at least try to predict how the
pieces we create now would fit with the pieces we plan to create later
on.

Note that full QAPIfication of -machine isn't necessary to make QAPI
feature "deprecated" work for machine types.  Turning MachineInfo member
@name into an enum, so we can tack "deprecated" onto its values, would
suffice.

Such a QAPIfication of machine types is still hard: QOM types are
defined at compile time just like the QAPI schema, but their definition
is distributed, and collected into one place only at run time.  I
discussed this on slide 39 of my "QEMU interface introspection: From
hacks to solutions" talk (KVM Form 2015).  Just for device_add, but it's
just a special case of QOM.  Choices listed there:

* Collect drivers at compile time? Hard...
* Make QAPI schema dynamic? Hard...
* Forgo driver-specific arguments in schema?
  Defeats introspection...

I'd like to add to the last item:

  Provide QOM introspection on par with QAPI schema introspection

The QOM introspection we have (qom-list-types etc. is not on par.

Back to exposing machine type deprecation.

I'm doubtful your proposed solution can be applied widely.  It relies on
adding @support-status to something that provides information on
whatever is deprecated.  The initial use is with a something that is an
ad hoc query, namely query-machines.  To use it, the management
application needs to understand what query-machines' @support-status
applies to.  Certainly feasible.  But I fear every use will be a special
case.  Furthermore, a suitable ad hoc query need not exist.  What then?
Create suitable ad hoc queries just for communicating deprecation?

Instead, I'd like us to think about a more genral solution.  Or perhaps
two: one for properly QAPIfied stuff, and one for QOM.

>> Kevin's proposed QAPI feature flags[*] extend the QAPI language so that
>> struct types can optionally have a list of feature flags, which are
>> strings.  Struct types suffice for his immediate needs.  I'd like to use
>> feature flags to mark deprecation by tacking a "deprecated" feature onto
>> whatever is deprecated.  This obviously needs feature support for
>> everything we want to be able to deprecate: commands, and events, as
>> well as members of enum and object types.
>> 
>> Example: to deprecate block driver "vfat", add feature "deprecated" to
>> BlockdevDriver member @vfat.
>> 
>> Unlike your patches, this does not require finding a "somewhere" that
>> provides information on "something".  You simply tack "deprecated" right
>> onto "something".
>> 
>> Your patches provide more information, however: human-readable messages.
>
> It also includes a machine-friendly suggested alternative (which
> I think is even more important that the human-readable message).

I agree we should point to a preferred replacement whenever we deprecate
something.

We have to do it in documentation.  And we generally do, in
qemu-deprecated.texi.

How useful would doing it in QMP as well be?  Depends on what management
applications can do with the additional information.

> We could extend QAPI introspection to return that if necessary,
> right?

I'm confident we can come up with *something*.  It might kill the neat
and simple "use QAPI features to communicate deprecation" idea, though.

>> Food for thought :)
>> 
>> 
>> [*] Hiding in
>> Subject: [PATCH 0/4] file-posix: Add dynamic-auto-read-only QAPI feature
>> Date: Mon,  8 Apr 2019 16:35:39 +0200
>> Message-Id: <20190408143543.3982-1-kwolf@redhat.com>


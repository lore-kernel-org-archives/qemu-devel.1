Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B98C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 05:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2A372087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 05:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A372087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39999 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNsKg-0005Zf-3f
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 01:08:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hNsJq-0005Gz-AS
	for qemu-devel@nongnu.org; Tue, 07 May 2019 01:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hNsJo-0006AY-IT
	for qemu-devel@nongnu.org; Tue, 07 May 2019 01:07:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hNsJo-0006A2-Cz
	for qemu-devel@nongnu.org; Tue, 07 May 2019 01:07:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9FDF1C05243E
	for <qemu-devel@nongnu.org>; Tue,  7 May 2019 05:07:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6292F61496;
	Tue,  7 May 2019 05:07:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id D74331132B35; Tue,  7 May 2019 07:07:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190423212246.3542-1-ehabkost@redhat.com>
Date: Tue, 07 May 2019 07:07:04 +0200
In-Reply-To: <20190423212246.3542-1-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Tue, 23 Apr 2019 18:22:43 -0300")
Message-ID: <87imumj1jb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Tue, 07 May 2019 05:07:06 +0000 (UTC)
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

> This series adds machine type deprecation information to the
> output of the `query-machines` QMP command.  With this, libvirt
> and management software will be able to show this information to
> users and/or suggest changes to VM configuration to avoid
> deprecated machine types.

This overlaps with something I want to try, namely using Kevin's
proposed QAPI feature flags for deprecation markings.  Let's compare the
two.

To mark something as deprecated with your patches, you add a
@support-status member somewhere, where "somewhere" is related to
"something" by "provides information on".

Example: MachineInfo (returned by query-machines) provides information
on possible values of -machine parameter type.  If -machine was
QAPIfied, it would provide information on possible values of a QAPI
object type's member.  The type might be anonymous.  The member should
be an enum (we currently use 'str' in MachineInfo).

Example: say we want to deprecate block driver "vfat",
i.e. BlockdevDriver member @vfat.  Type BlockdevDriver is used in
multiple places; let's ignore all but BlockdevOptions.  We need to add
@support-status to something that provides information on
BlockdevDriver, or maybe on BlockdevOptions.  There is no ad hoc query
providing information on either of the two, because QAPI/QMP
introspection has been sufficient.  What now?

Can we add deprecation information to (general) QAPI/QMP introspection
instead of ad hoc queries?

Kevin's proposed QAPI feature flags[*] extend the QAPI language so that
struct types can optionally have a list of feature flags, which are
strings.  Struct types suffice for his immediate needs.  I'd like to use
feature flags to mark deprecation by tacking a "deprecated" feature onto
whatever is deprecated.  This obviously needs feature support for
everything we want to be able to deprecate: commands, and events, as
well as members of enum and object types.

Example: to deprecate block driver "vfat", add feature "deprecated" to
BlockdevDriver member @vfat.

Unlike your patches, this does not require finding a "somewhere" that
provides information on "something".  You simply tack "deprecated" right
onto "something".

Your patches provide more information, however: human-readable messages.

Food for thought :)


[*] Hiding in
Subject: [PATCH 0/4] file-posix: Add dynamic-auto-read-only QAPI feature
Date: Mon,  8 Apr 2019 16:35:39 +0200
Message-Id: <20190408143543.3982-1-kwolf@redhat.com>


Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61F9C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 08:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BE7C20862
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 08:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE7C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33250 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQp5P-0002tE-Jw
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 04:16:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQp4R-0002Ic-80
	for qemu-devel@nongnu.org; Wed, 15 May 2019 04:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQp4Q-0004Yt-4W
	for qemu-devel@nongnu.org; Wed, 15 May 2019 04:15:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1hQp4P-0004Ve-TK
	for qemu-devel@nongnu.org; Wed, 15 May 2019 04:15:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B50E5AFF8;
	Wed, 15 May 2019 08:15:24 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BF8EE608A6;
	Wed, 15 May 2019 08:15:22 +0000 (UTC)
Date: Wed, 15 May 2019 10:15:20 +0200
From: Andrew Jones <drjones@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190515081520.nazchdnludojzfqe@kamzik.brq.redhat.com>
References: <20190418092841.fzrcegkbal7dpfcy@kamzik.brq.redhat.com>
	<20190418112610.GO13773@redhat.com>
	<877ebrmch2.fsf@dusky.pond.sub.org>
	<20190513184237.i2ha3ixvhjqzkn5q@kamzik.brq.redhat.com>
	<87bm05ab6c.fsf@dusky.pond.sub.org>
	<20190514090225.vel4xm4x743o4rge@kamzik.brq.redhat.com>
	<87woit40wy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87woit40wy.fsf@dusky.pond.sub.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Wed, 15 May 2019 08:15:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] How do we do user input bitmap properties?
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
Cc: peter.maydell@linaro.org,
	Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
	dgilbert@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com,
	Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 14, 2019 at 03:32:13PM +0200, Markus Armbruster wrote:
> Syntax that can support such growth would be nice.
> 
> To grow a single unsigned number, we can make it wider (but we don't
> have infrastructure for numbers wider than 64 bits), or we can add more
> numbers (but under what name?).
> 
> Dotted keys syntax could grow more easily, but it's rather awkward.
> 
> Looking more closely at your "[PATCH 11/13] target/arm/cpu64: max cpu:
> Introduce sve-vls-map"... your syntax reflects your data structure:
> property "sve-vls-map" is of type uint64_t, and interpreted as bit set.
> This data type would have to grow, too.
> 
> We could make widen the integer property (but we don't have
> infrastructure for integer properties wider than 64 bits), or we can
> turn it into an array of integers (compatibility?), or we can add more
> properties to hold the additional integers (yet another silly way to
> represent a list/array of integers).
> 
> I'm not asking you to complicate things just to future-proof this.  Just
> pause and think whether you can pick a data type that's similarly
> convenient now, and easier to grow.
> 
> Then pick an external syntax for this data type.  You may have to pick a
> reasonable compromise between ease of implementation and ease of use.

Widening the integer property sounds good to me. I just hadn't thought of
it (implementation tunnel vision affecting my user interface design).
Andrea also mentioned that as a possibility in a reply to the series. I
think we can leave the property as a uint64_t right now and then, when/if
it needs to expand past 64 bits we can change the property to a string
and start parsing arbitrarily large integers from it. The internal state,
'uint64_t sve_vls_map' can easily be changed to a 'uint64_t sve_vls_map[]'
at that point too. How's that sound?

> Primarily machines means we can accept more verbosity.
> 
> If I understand the cover letter of your "[PATCH 00/13] target/arm/kvm:
> enable SVE in guests" correctly, then sve-max-vq and sve-vls-map are
> alternative interfaces for the same thing.  The latter is more general,
> but awkward on the command line and verbose everywhere.  The former
> isn't usable with -cpu host.  Correct?
> 
> If there wasn't "not usable with -cpu host", I'd ask whether we really
> need the generality.
>

The 'not usable with -cpu host' was a choice, not a limitation to deal
with. The problem with sve-max-vq is that it doesn't provide enough
information by itself. Multiple vector sets with the same max-vq can be
valid. For migration of KVM guests the exact set needs to be explicitly
requested to ensure the host supports it. For TCG it may be nice to
model sets besides the everything up to max-vq set that sve-max-vq would
choose. sve-max-vq could be used with -cpu host the same way I've
implemented it for -cpu max, which is to take the fully supported vector
set from the KVM query and use that one, but I didn't want to encourage
its use with AArch64's primary KVM cpu type (even if it's -cpu host and
thus not a great choice for migration anyway).

Thanks,
drew


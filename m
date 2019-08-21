Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CCCC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B876B2339E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B876B2339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Qcb-0006xs-Kr
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 09:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i0QZV-00020M-7n
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i0QZU-0000Bs-1X
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:22:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43086)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i0QYz-0008L9-PE; Wed, 21 Aug 2019 09:22:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5EE08470C;
 Wed, 21 Aug 2019 13:22:08 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 928945D6B0;
 Wed, 21 Aug 2019 13:22:03 +0000 (UTC)
Message-ID: <5f42137c5b25a493f4614a89a13b33cab5e9309f.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Date: Wed, 21 Aug 2019 16:22:02 +0300
In-Reply-To: <871rxelppv.fsf@dusky.pond.sub.org>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <d0635a23-7f99-9cf7-500c-af668e8ca370@redhat.com>
 <20190815091039.GA7415@linux.fritz.box> <87y2zuy0k7.fsf@dusky.pond.sub.org>
 <2561ace5297c93cee597c776230dcb8f457a8561.camel@redhat.com>
 <414e8dab-b19b-fd47-52eb-db43ae75ec07@redhat.com>
 <ba8e9afd066d65099a897b5c515a73ab2c64625d.camel@redhat.com>
 <871rxelppv.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 21 Aug 2019 13:22:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 00/13] RFC: luks/encrypted qcow2 key
 management
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Daniel =?ISO-8859-1?Q?P=2EBerrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-08-21 at 13:31 +0200, Markus Armbruster wrote:
> Maxim Levitsky <mlevitsk@redhat.com> writes:
> 
> > On Thu, 2019-08-15 at 10:00 -0500, Eric Blake wrote:
> > > On 8/15/19 9:44 AM, Maxim Levitsky wrote:
> > > 
> > > > > > > Does the idea of a union type with a default value for the discriminator
> > > > > > > help?  Maybe we have a discriminator which defaults to 'auto', and add a
> > > > > > > union branch 'auto':'any'.  During creation, if the "driver":"auto"
> > > > > > > branch is selected (usually implicitly by omitting "driver", but also
> > > > > > > possible explicitly), the creation attempt is rejected as invalid
> > > > > > > regardless of the contents of the remaining 'any'.  But during amend
> > > > > > > usage, if the 'auto' branch is selected, we then add in the proper
> > > > > > > "driver":"xyz" and reparse the QAPI object to determine if the remaining
> > > > > > > fields in 'any' still meet the specification for the required driver branch.
> > > > > > > 
> > > > > > > This idea may still require some tweaks to the QAPI generator, but it's
> > > > > > > the best I can come up with for a way to parse an arbitrary JSON object
> > > > > > > with unknown validation, then reparse it again after adding more
> > > > > > > information that would constrain the parse differently.
> > > > > > 
> > > > > > Feels like this would be a lot of code just to allow the client to omit
> > > > > > passing a value that it knows anyway. If this were a human interface, I
> > > > > > could understand the desire to make commands less verbose, but for QMP I
> > > > > > honestly don't see the point when it's not trivial.
> > > > > 
> > > > > Seconded.
> > > > 
> > > > 
> > > > But what about my suggestion of adding something like:
> > > > 
> > > > { 'union': 'BlockdevAmendOptions',
> > > > 
> > > >   'base': {
> > > >       'node-name':         'str' },
> > > > 
> > > >   'discriminator': { 'get_block_driver(node-name)' } ,
> > > 
> > > Not worth it. It makes the QAPI generator more complex (to invoke
> > > arbitrary code instead of a fixed name) just to avoid a little bit of
> > > complexity in the caller (which is assumed to be a computer, and thus
> > > shouldn't have a hard time providing a sane 'driver' unconditionally).
> > > An HMP wrapper around the QMP command can do whatever magic it needs to
> > > omit driver, but making driver mandatory for QMP is just fine.
> > 
> > All right! I kind of not agree with that, since I think even though QMP is a machine language,
> > it still should be consistent since humans still use it, even if this is humans that code some
> > tool that use it.
> > 
> > I won't argue with you though, let it be like that.
> 
> Software's fundamental limit is complexity.  We need to pick what we use
> it for.  Sometimes, that means saying no to things that would be nice to
> have.

I fully agree with that and that is usually the exact reason I argue about such things:
Sometimes avoiding complexity in one place, and/or breaking consistency can introduce complexity in other place (like libvirt).

In this particular case, I won't argue about this, but still it kind of feels like
it is a precedent of requiring the user to supply redundant data.

Of all issues all of you pointed out (thanks!!) this is probably the least important one that I should be arguing about, 
so let it be like you say.

Best regards,
	Maxim Levitsky






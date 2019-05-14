Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAE3C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 09:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DB2D2084A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 09:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB2D2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44036 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQTjR-00086f-Fq
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 05:28:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hQThw-00076j-2y
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hQThu-0000XD-NZ
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:26:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hQThu-0000KC-EZ
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:26:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 79534C1306E4
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 09:26:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.248])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 10627600C6;
	Tue, 14 May 2019 09:26:40 +0000 (UTC)
Date: Tue, 14 May 2019 10:26:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190514092638.GE25916@redhat.com>
References: <20190430131919.GN6818@redhat.com> <20190430144546.GA3065@work-vm>
	<20190430150556.GA2423@redhat.com>
	<87sgtqejn9.fsf@dusky.pond.sub.org>
	<20190507093954.GG27205@redhat.com>
	<875zql3ylk.fsf@dusky.pond.sub.org>
	<20190513120856.GH15029@redhat.com>
	<87ef525uls.fsf@dusky.pond.sub.org>
	<a3378e24-f13f-b51f-7180-8e0bf4661e10@redhat.com>
	<87tvdx8tfa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tvdx8tfa.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Tue, 14 May 2019 09:26:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [libvirt]  QMP; unsigned 64-bit ints;
 JSON standards compliance
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
Cc: libvir-list@redhat.com, =?utf-8?Q?J=C3=A1n?= Tomko <jtomko@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 14, 2019 at 08:02:49AM +0200, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
> > On 5/13/19 8:53 AM, Markus Armbruster wrote:
> >
> >>> We have a few options
> >>>
> >>>  1. Use string format for values > 2^53-1, int format below that
> >>>  2. Use string format for all fields which are 64-bit ints whether
> >>>     signed or unsigned
> >>>  3. Use string format for all fields which are integers, even 32-bit
> >>>     ones
> >>>
> >>> I would probably suggest option 2. It would make the QEMU impl quite
> >>> easy IIUC, we we'd just change the QAPI visitor's impl for the int64
> >>> and uint64 fields to use string format (when the right capability is
> >>> negotiated by QMP).
> >>>
> >>> I include 3 only for completeness - I don't think there's a hugely
> >>> compelling reason to mess with 32-bit ints.
> >> 
> >> Agree.
> >
> > Other than if we ever change the type of a QMP integer. Right now, if we
> > widen from 'int32' to 'int' (aka 'int64'), it is invisible to clients;
> > but once we start stringizing 64-bit numbers (at client request) but NOT
> > 32-bit numbers, then changing a type from 32 to 64 bits (or the
> > converse) becomes an API change to clients. Introspection will at least
> > let a client know which form to expect, but it does mean we have to be
> > more aware of typing issues going forward.
> 
> Thank you so much for helping my old synapses finally fire!  Option 2 is
> not what we thought it is.  Let me explain.
> 
> Introspection reports *all* QAPI integer types as "int".  This is
> deliberate.
> 
> So, when the client that negotiated the interoperability capability sees
> "int", it has to accept *both* integer encodings: JSON number and JSON
> string.
> 
> The difference between option 1 and option 2 for the client is that
> option 2 will use only one encoding.  But the client must not rely on
> that!  Another QEMU version may well use the other encoding (because we
> narrowed or widened the QAPI integer type in the QAPI schema).
> 
> Elsewhere in this thread, David pointed out that option 1 complicates
> testing QEMU: full coverage requires passing both a small number (to
> cover JSON number encoding) and a large number (to cover JSON string
> encoding), to which I replied that there are very few places to test.
> 
> Option 2 complicates testing clients: full coverage requires testing
> with both a version of QEMU (or a mock-up) that uses wide integers
> (encoded as JSON string) and narrow integers (encoded as JSON number).
> Impractical.
> 
> >>> Option 1 is the bare minimum needed to ensure precision, but to me
> >>> it feels a bit dirty to say a given field will have different encoding
> >>> depending on the value. If apps need to deal with string encoding, they
> >>> might as well just use it for all values in a given field.
> >> 
> >> I guess that depends on what this interoperability capability does for
> >> QMP *input*.
> >
> > "Be liberal in what you accept, strict in what you produce" - that
> > argues we should accept both forms on input (it's easy enough to ALWAYS
> > permit a string in place of an integer, and to take an in-range integer
> > even when we would in turn output it as a string).
> 
> With option 2, QEMU *has* to be liberal in what it accepts, because the
> client cannot deduce from introspection whether the integer is wide or
> narrow.
> 
> [...]
> 
> Daniel, you wrote you'd probably suggest option 2.  Would you like to
> reconsider?

Based on the above, let me try & summarize what we need behaviour to be:

  - Integer mode (current default):

       - QEMU & clients MUST format integer fields as numbers
         regardless of size

       - QEMU & clients MUST parse number format for any integer
         fields

  - String mode:

       - QEMU & clients MUST format integer fields as strings
         if their value can not fit in a 32-bit integer.

       - QEMU & clients MAY format integer fields as strings
         even if their value can fit in 32-bit integer

       - QEMU & client MUST parse both string and number format
         for any integer fields.

Unless I'm missing something, this should ensure we don't loose precision,
can always parse large numbers, and can internally change QEMU precision
from int8/16/32 upto full int64 without breaking clients.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


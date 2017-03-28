Received: from eggs.gnu.org ([2001:4830:134:3::10]:50928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cstYm-0002h8-O1
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cstYh-0003wU-AM
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:01:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cstYh-0003uu-5m
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:01:23 -0400
Date: Tue, 28 Mar 2017 13:01:19 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170328160119.GA7295@thinpad.lan.raisama.net>
References: <1490653177-131484-1-git-send-email-agraf@suse.de>
	<20170328004108.GP28530@thinpad.lan.raisama.net>
	<9d85e056-3331-9815-404b-9557ca5028cc@suse.de>
	<39d88a40-727b-81e9-0577-27198457304e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39d88a40-727b-81e9-0577-27198457304e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] i386: Allow cpuid bit override
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Tue, Mar 28, 2017 at 02:41:55PM +0200, Paolo Bonzini wrote:
> 
> 
> On 28/03/2017 13:26, Alexander Graf wrote:
> >> You can define an enum type in qapi-schema.json, and use
> >> visit_type_<YourEnumType>(). You can grep for
> >> visit_type_OnOffAuto to find examples.
> >>
> >> (But I suggest naming the enum something like
> >> "X86CPUFeatureSetting" instead of "OnOffForce", because we will
> >> probably add other enum values in the future).
> >>
> >> However: we need to find a way to do this and not break
> >> compatibility with "feat=yes|true|no|false", that's supported by
> >> StringInputVisitor (which is used by object_property_parse()).
> >> Maybe fallback to visit_type_bool() in case
> >> visit_type_<YourEnumType>() fails?
> > 
> > Putting it into a special enum sounds much more fragile than the current
> > solution to me. We need to bool fallback either way, so I fail to see
> > any benefit from having the enum.
> 
> Using an on/off/force enum sounds like the right thing to do.
> 
> However, I would open code the getters and setters completely (using
> visit_type_str) instead of using visit_type_FooEnum+visit_type_bool.
> Then you can easily map yes/true to on and no/false to off.

I am wondering if it isn't simpler to define the enum to be
(on, off, force, yes, true, no, false), and document
(yes, true, no, false) as deprecated.

-- 
Eduardo

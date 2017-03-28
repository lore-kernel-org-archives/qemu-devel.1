Received: from eggs.gnu.org ([2001:4830:134:3::10]:58634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csu5U-0006Qa-E2
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csu5R-0001Fa-CT
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:35:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1csu5R-0001FG-7O
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:35:13 -0400
References: <1490653177-131484-1-git-send-email-agraf@suse.de>
	<20170328004108.GP28530@thinpad.lan.raisama.net>
	<9d85e056-3331-9815-404b-9557ca5028cc@suse.de>
	<39d88a40-727b-81e9-0577-27198457304e@redhat.com>
	<20170328160119.GA7295@thinpad.lan.raisama.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <25c017ff-8d42-b3a3-309b-abdde25ece10@redhat.com>
Date: Tue, 28 Mar 2017 18:35:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170328160119.GA7295@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386: Allow cpuid bit override
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>



On 28/03/2017 18:01, Eduardo Habkost wrote:
>> Using an on/off/force enum sounds like the right thing to do.
>>
>> However, I would open code the getters and setters completely (using
>> visit_type_str) instead of using visit_type_FooEnum+visit_type_bool.
>> Then you can easily map yes/true to on and no/false to off.
> I am wondering if it isn't simpler to define the enum to be
> (on, off, force, yes, true, no, false), and document
> (yes, true, no, false) as deprecated.

This would require checks everywhere (plus I doubt that the deprecation
would actually lead to anything).  Doing the conversion in the getters
and setters provides the right level of abstraction; the question is
only whether to open code it or to use multiple calls to visit_type_*.

Paolo

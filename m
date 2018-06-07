Received: from eggs.gnu.org ([2001:4830:134:3::10]:49959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQsou-0006Y9-Kc
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQsoq-0000KC-Ev
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:11:08 -0400
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
	<20180426161958.2872-4-rkagan@virtuozzo.com>
	<87tvqjf28u.fsf@dusky.pond.sub.org>
	<3f5aaa32-5e43-542b-c657-3f1eec553e70@redhat.com>
	<df356e6b-8559-1a79-17cf-47bdfeb8612d@redhat.com>
	<b088605a-477f-4c80-34d8-c6677cfdb37e@redhat.com>
	<87d0x33wyr.fsf@dusky.pond.sub.org>
	<19326638-6980-5473-dea9-79c7aabdf710@redhat.com>
	<bcf8d1bf-54b0-c2cd-431c-3db8e14d7676@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b010eb74-9ac5-014c-723d-82ba462f99b8@redhat.com>
Date: Thu, 7 Jun 2018 13:10:43 +0200
MIME-Version: 1.0
In-Reply-To: <bcf8d1bf-54b0-c2cd-431c-3db8e14d7676@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/17] iotests: ask qemu for supported
 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

On 07.06.2018 13:07, Paolo Bonzini wrote:
> On 07/06/2018 09:50, Thomas Huth wrote:
>>
>>> There's no real need to kill off '?', unless it gets in the way of
>>> steering people towards 'help'.  We should steer them toward 'help',
>>> because '?' is a trap for insufficiently sophisticated users of
>>> shell[*].
>> ... and I agree with your points here.
>>
>> => I think we need a second list of deprecated feature (maybe we should
>> call them "legacy features" instead of "deprecated"?), i.e. a list of
>> features which we don't recommend for new code / scripts anymore, but
>> which we do not intend to remove via our official deprecation policy any
>> time soon. Things like "--enable-kvm" / "-no-kvm" or maybe even "-net"
>> go into the same category.
> 
> Yes, "-net" definitely goes there.
> 
>> If you agree, I can try to come up with a patch (should the list go into
>> qemu-doc.texi or a separate document in the the documentation folder?).
> 
> I think it should go in docs/devel.

I currently rather tend to put it into a new appendix in qemu-doc.texi,
since this is useful information for the normal users, too. Or how shall
we communicate this to the users that the old options that they are used
to are still there, but should not be used for new scripts anymore?

 Thomas

Received: from eggs.gnu.org ([2001:4830:134:3::10]:34543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQtSS-0000DV-KX
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQtSR-0002Ry-HS
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:52:00 -0400
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
	<20180426161958.2872-4-rkagan@virtuozzo.com>
	<87tvqjf28u.fsf@dusky.pond.sub.org>
	<3f5aaa32-5e43-542b-c657-3f1eec553e70@redhat.com>
	<df356e6b-8559-1a79-17cf-47bdfeb8612d@redhat.com>
	<b088605a-477f-4c80-34d8-c6677cfdb37e@redhat.com>
	<87d0x33wyr.fsf@dusky.pond.sub.org>
	<19326638-6980-5473-dea9-79c7aabdf710@redhat.com>
	<bcf8d1bf-54b0-c2cd-431c-3db8e14d7676@redhat.com>
	<b010eb74-9ac5-014c-723d-82ba462f99b8@redhat.com>
	<a9e7a3d9-4453-f9e1-9a00-fc9df42a0d47@redhat.com>
	<828d2f50-fd57-d103-1d94-98ddd0c23d6d@redhat.com>
	<48d98c53-5ff4-6391-87ec-334be1b5712e@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <172bd92d-507f-ba91-37eb-5f34114dd797@redhat.com>
Date: Thu, 7 Jun 2018 13:51:50 +0200
MIME-Version: 1.0
In-Reply-To: <48d98c53-5ff4-6391-87ec-334be1b5712e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] -enable-kvm and friens
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

On 07.06.2018 13:42, Paolo Bonzini wrote:
> On 07/06/2018 13:27, Thomas Huth wrote:
>>> As to "-enable-kvm", I don't see anything wrong with users using it, or
>>> even with occasionally adding more options like it.  However, we should
>>> warn developers that such simple options should be syntactic sugar for a
>>> structured (i.e. QemuOpts-based) option like "-accel", and that it
>>> should only be done for similarity with existing options.
>> Honestly, in this case I think it's just confusing for the normal users,
>> and not sugar (anymore). If I'm an unexperienced user who wants to
>> enable KVM, and I see multiple options that seem to be related, I wonder
>> whether they do the same or whether there's a difference, and which one
>> is preferred. And "-accel kvm" is even less to type than "-enable-kvm",
>> so there is really no advantage for "-enable-kvm" anymore. I think we
>> should remove "-enable-kvm" and "-enable-hax" from qemu-doc.texi and
>> only list it in the new legacy chapter / document.
> 
> Well, there's also the issue of distros shipping qemu-kvm binaries.  I
> think those should be provided by upstream.  If we do that, then we're
> perhaps in a better position to place --enable-kvm under the rug.

You don't need -enable-kvm for those qemu-kvm binaries, only -no-kvm.
And -no-kvm has never been documented in our qemu-doc user documentation
anyway (apart from the fact that it is now mentioned in the deprecation
chapter). So if we'd now mentioned -no-kvm in a "legacy feature" chapter
instead of the deprecation chapter, that would even improve the
situation for downstream qemu-kvms :-)

 Thomas

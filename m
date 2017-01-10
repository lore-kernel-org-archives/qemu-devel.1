Received: from eggs.gnu.org ([2001:4830:134:3::10]:49937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cQz8k-0002Ik-It
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cQz8i-0000WB-1z
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:19:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cQz8h-0000Vl-T7
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:19:11 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1479108340-3453-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170109234446-mutt-send-email-mst@kernel.org>
	<87bmvftejz.fsf@dusky.pond.sub.org>
	<20170110162151-mutt-send-email-mst@kernel.org>
Date: Tue, 10 Jan 2017 17:19:07 +0100
In-Reply-To: <20170110162151-mutt-send-email-mst@kernel.org> (Michael
	S. Tsirkin's message of "Tue, 10 Jan 2017 16:38:00 +0200")
Message-ID: <87pojuc2h0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 00/10] Convert msix_init() to error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>, Cao jin <caoj.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org, Dmitry Fleytman <dmitry@daynix.com>, Alex Williamson <alex.williamson@redhat.com>, Hannes Reinecke <hare@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Tue, Jan 10, 2017 at 11:06:08AM +0100, Markus Armbruster wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>> > On Mon, Nov 14, 2016 at 03:25:30PM +0800, Cao jin wrote:
>> >> v7 changelog:
>> >> 1. fix the segfaut bug in patch 2. So drop the all the R-b of it,
>> >>    please take a look, there is detailed description in the patch.
>> >> 2. add the R-b from Hannes Reinecke
>> >> 
>> >> Test:
>> >> 1. make check: pass
>> >> 2. After applied all the patch, command line test for all the
>> >>    affected devices, just make sure device realize process is ok,
>> >>    no crash, but no further use of device.
>> >
>> > Consider the megasas device for example, don't you
>> > need to test that the change actually does what
>> > it's intended to do?
>> 
>> For better or worse, that's a higher bar than we commonly require for
>> refactorings.
>> 
>> [...]
>
> Well the patch says that it's addressing a TODO. If no one can
> be bothered to test the functionality, maybe we shouldn't bother
> with the change.
>
> Generally this patchset is at v7.  It brings a very limited benefit to
> the project.  It better be perfect otherwise I don't see why bother.

We obviously disagree on the benefit.  Before this series, error
reporting is *broken* for QMP.  Fixing that is definitely not "why
bother" material.

I certainly don't object to tightening our testing habits.  I was merely
pointing out that you're doing that.

Testing patches that modernize interfaces often isn't easy for the
person doing the work.  Fortunately, megasas has a maintainer: Hannes.
Who gave his R-by.  For me, that would suffice, but you may see things
differently.  Would a Tested-by from him satisfy you?  If not, what
would satisfy you?

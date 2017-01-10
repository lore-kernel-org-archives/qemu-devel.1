Received: from eggs.gnu.org ([2001:4830:134:3::10]:42161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cQyV2-0000KW-CB
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 10:38:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cQyUx-0006fg-OF
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 10:38:12 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cQyUx-0006fV-IV
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 10:38:07 -0500
Received: by mail-wm0-x242.google.com with SMTP id l2so30676695wml.2
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 07:38:07 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1479108340-3453-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170109234446-mutt-send-email-mst@kernel.org>
	<87bmvftejz.fsf@dusky.pond.sub.org>
	<20170110162151-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <117edb31-5328-18fb-00d8-604e0e9f2757@redhat.com>
Date: Tue, 10 Jan 2017 16:38:05 +0100
MIME-Version: 1.0
In-Reply-To: <20170110162151-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 00/10] Convert msix_init() to error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>, Cao jin <caoj.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org, Dmitry Fleytman <dmitry@daynix.com>, Alex Williamson <alex.williamson@redhat.com>, Hannes Reinecke <hare@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>



On 10/01/2017 15:38, Michael S. Tsirkin wrote:
> On Tue, Jan 10, 2017 at 11:06:08AM +0100, Markus Armbruster wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>>
>>> On Mon, Nov 14, 2016 at 03:25:30PM +0800, Cao jin wrote:
>>>> v7 changelog:
>>>> 1. fix the segfaut bug in patch 2. So drop the all the R-b of it,
>>>>    please take a look, there is detailed description in the patch.
>>>> 2. add the R-b from Hannes Reinecke
>>>>
>>>> Test:
>>>> 1. make check: pass
>>>> 2. After applied all the patch, command line test for all the
>>>>    affected devices, just make sure device realize process is ok,
>>>>    no crash, but no further use of device.
>>>
>>> Consider the megasas device for example, don't you
>>> need to test that the change actually does what
>>> it's intended to do?
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

I agree.  The changes to the device model are non-trivial and you should
make a decent effort at coverage of non-trivial changes.

Paolo

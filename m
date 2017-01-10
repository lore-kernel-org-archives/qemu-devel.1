Received: from eggs.gnu.org ([2001:4830:134:3::10]:47963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cQtJu-0003S7-1U
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 05:06:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cQtJp-0007pv-3M
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 05:06:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cQtJo-0007pB-TS
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 05:06:17 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1479108340-3453-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170109234446-mutt-send-email-mst@kernel.org>
Date: Tue, 10 Jan 2017 11:06:08 +0100
In-Reply-To: <20170109234446-mutt-send-email-mst@kernel.org> (Michael
	S. Tsirkin's message of "Mon, 9 Jan 2017 23:45:27 +0200")
Message-ID: <87bmvftejz.fsf@dusky.pond.sub.org>
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
Cc: Cao jin <caoj.fnst@cn.fujitsu.com>, Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Hannes Reinecke <hare@suse.de>, Dmitry Fleytman <dmitry@daynix.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Mon, Nov 14, 2016 at 03:25:30PM +0800, Cao jin wrote:
>> v7 changelog:
>> 1. fix the segfaut bug in patch 2. So drop the all the R-b of it,
>>    please take a look, there is detailed description in the patch.
>> 2. add the R-b from Hannes Reinecke
>> 
>> Test:
>> 1. make check: pass
>> 2. After applied all the patch, command line test for all the
>>    affected devices, just make sure device realize process is ok,
>>    no crash, but no further use of device.
>
> Consider the megasas device for example, don't you
> need to test that the change actually does what
> it's intended to do?

For better or worse, that's a higher bar than we commonly require for
refactorings.

[...]

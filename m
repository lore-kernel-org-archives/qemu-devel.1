Received: from eggs.gnu.org ([2001:4830:134:3::10]:38606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cHbmt-0007TH-NS
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 14:33:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cHbmp-0002zC-NQ
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 14:33:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cHbmp-0002ym-Hp
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 14:33:51 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B106264DA1
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 19:33:50 +0000 (UTC)
Date: Thu, 15 Dec 2016 17:33:48 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161215193348.GT3808@thinpad.lan.raisama.net>
References: <20161208200737.GA29563@thinpad.lan.raisama.net>
	<87a8c0qedq.fsf@dusky.pond.sub.org>
	<20161213124239.GO3808@thinpad.lan.raisama.net>
	<56cc6442-ba4f-6c5e-9c57-8787acccb6f9@redhat.com>
	<20161213160038.GV3808@thinpad.lan.raisama.net>
	<cae49570-bde2-4075-78bb-bb348e7d634e@redhat.com>
	<cc92018a-e9c7-e3ab-7c17-556798f62920@redhat.com>
	<26fdcd4a-0389-2be6-b55b-e7f237db07a7@redhat.com>
	<f5266981-3b3c-d129-cc21-89c23cbcb8da@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5266981-3b3c-d129-cc21-89c23cbcb8da@redhat.com>
Subject: Re: [Qemu-devel] [RFC] qmp: query-device-slots command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laine Stump <laine@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, Igor Mammedov <imammedo@redhat.com>

On Thu, Dec 15, 2016 at 02:15:51PM -0500, Laine Stump wrote:
> On 12/15/2016 05:12 AM, Marcel Apfelbaum wrote:
> > On 12/14/2016 10:10 PM, Laine Stump wrote:
> > > On 12/14/2016 12:17 PM, Marcel Apfelbaum wrote:
> > > > Be aware that 1 slot doesn't necessarily refer to only one device,
> > > > we can have a multi-function device.
> > > 
> > > Is that a fixed thing? I mean, is it always possible to use all 8
> > > functions of a slot (assuming no hotplug of course)?
> > > 
> > 
> > Yes, you simply add to the function 0 on command line:  with -device
> > ...,multifunction=on.
> 
> Yes, I know how the commandline works. my question is whether *all* PCI
> controllers in existence have 8 usable functions per slot, or if that might
> be another thing that is different from one controller to the next (and thus
> would have to be reported in these query responses).

That's a good question. From looking at the code, I was assuming
the 8 functions were always available. But if they might be not,
that's another reason to explicitly report PCI functions in the
new queries.

-- 
Eduardo

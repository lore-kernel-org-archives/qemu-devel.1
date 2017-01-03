Received: from eggs.gnu.org ([2001:4830:134:3::10]:42488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cORfJ-0004vR-SJ
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cORfG-0001Nf-Mm
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:10:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cORfG-0001NR-GZ
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:10:18 -0500
References: <20161229223815.13705-1-ehabkost@redhat.com>
	<20161230152834.6d1fa963@Igors-MacBook-Pro.local>
	<20161230182308.GK3441@thinpad.lan.raisama.net>
	<20170103140252.1a2df147@nial.brq.redhat.com>
	<20170103142223.GB3315@thinpad.lan.raisama.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e27ac12b-9e41-f145-ca05-385d4edd2738@redhat.com>
Date: Tue, 3 Jan 2017 17:10:15 +0100
MIME-Version: 1.0
In-Reply-To: <20170103142223.GB3315@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qdev: Make "hotplugged" property read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>



On 03/01/2017 15:22, Eduardo Habkost wrote:
>> I didn't know that. Is this documented somewhere?
>> Is it actually used by any existing software?
> not that I know of. But users should be fixed if they are not using it.
> 
> I see. The problem is that the mechanism is undocumented,
> untested, and seems very likely to trigger bugs in device code.

I agree.  Why can't hotplugged be migrated?

Paolo

Received: from eggs.gnu.org ([209.51.188.92]:35377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3OTc-0003tO-GO
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3OQE-0004jv-Id
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:09:11 -0400
References: <20190308131445.17502-1-armbru@redhat.com>
	<20190308131445.17502-12-armbru@redhat.com>
	<fde51cea-909c-6c63-7553-2b48d7d4ac45@redhat.com>
	<87mum1l8o9.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7cdf93fd-504d-9371-a927-096a43394ecf@redhat.com>
Date: Mon, 11 Mar 2019 18:08:41 +0100
MIME-Version: 1.0
In-Reply-To: <87mum1l8o9.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 11/12] pc: Support firmware
 configuration with -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org, mst@redhat.com, philmd@redhat.com, mreitz@redhat.com, marcandre.lureau@redhat.com, lersek@redhat.com

On 11/03/19 16:42, Markus Armbruster wrote:
>> Does it work if you add the device yourself as a child of /machine,
>> instead of relying on /machine/unattached?
> 
> I figure you're suggesting something like this incremental patch:

Yes.

> Passes "make check" and "info qtree" looks good both with and without
> -machine pflash0,...
> 
> I'm not exactly happy with "pfl0" and "pfl1".  Got a favorite color for
> my bikeshed?

"pflash[0]" and "pflash[1]"?

Paolo

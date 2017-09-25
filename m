Received: from eggs.gnu.org ([2001:4830:134:3::10]:58863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dwRWa-0006Ri-GV
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 07:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dwRWX-0008WB-D6
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 07:26:08 -0400
References: <20170915090643.6043-1-otubo@redhat.com>
	<fbe31cc8-c628-32e6-90b0-0341ef1972d3@msgid.tls.msk.ru>
	<0e84971b-592e-22f7-8815-2b3e193f6c1d@redhat.com>
	<20170925092641.GD12137@vader>
	<52fe072e-8e53-0610-2195-3ef8e120b553@msgid.tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cd87c7b5-76e3-c5f1-3c2a-59c163f4bc35@redhat.com>
Date: Mon, 25 Sep 2017 13:25:58 +0200
MIME-Version: 1.0
In-Reply-To: <52fe072e-8e53-0610-2195-3ef8e120b553@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] dma/i82374: avoid double creation of
 i82374 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, Eduardo Otubo <otubo@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, qemu-trivial@nongnu.org, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>

On 25/09/2017 12:54, Michael Tokarev wrote:
>> Yes, that's correct. I can revert this patch with the error
>> propagation patch as well, if you guys don't mind.
> Hmm. After reading the original discussion I concluded this patch
> is okay.  I can remove it right now before the series has been
> applied, together with another tiny change.

No problem, it's okay for now as a trivial change.

Paolo

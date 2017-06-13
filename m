Received: from eggs.gnu.org ([2001:4830:134:3::10]:59971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dKicP-0000U8-RJ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:00:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dKicK-00067I-FA
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:00:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dKicK-00066U-9a
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:00:08 -0400
References: <CAGKXQyf2xdubP9EV4AK2AuxYmzrm4rjYpEPckDb5aiNDTW5YUQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <40ef6b8f-3391-a116-faa0-c43dadea6712@redhat.com>
Date: Tue, 13 Jun 2017 12:00:04 +0200
MIME-Version: 1.0
In-Reply-To: <CAGKXQyf2xdubP9EV4AK2AuxYmzrm4rjYpEPckDb5aiNDTW5YUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] global bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ali saeedi <ali.saeedi56@gmail.com>, qemu-devel@nongnu.org

On 13/06/2017 11:15, ali saeedi wrote:
> Hello
> can i have a bitmap of all pages in the ram? in qemu code, it seems that we
> only can have bitmap of pages in a block and we have no global bitmap of
> pages.

If you mean dirty pages, the "global bitmap of pages" would simply be
the union of all per-block pages.

Paolo

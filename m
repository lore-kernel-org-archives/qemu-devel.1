Received: from eggs.gnu.org ([2001:4830:134:3::10]:37199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dNgtX-0005Zj-UO
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:46:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dNgtT-0004LT-1w
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:46:11 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:36105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dNgtS-0004L4-Re
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:46:06 -0400
Received: by mail-wr0-f177.google.com with SMTP id c11so82625482wrc.3
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 07:46:06 -0700 (PDT)
References: <33C62801-DFAA-49FA-BBDE-D9622810C8EB@icloud.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0203f432-ccc4-ddca-418c-05a7df844284@redhat.com>
Date: Wed, 21 Jun 2017 16:46:03 +0200
MIME-Version: 1.0
In-Reply-To: <33C62801-DFAA-49FA-BBDE-D9622810C8EB@icloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] TLB addend field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Theodore Dubois <tblodt@icloud.com>, qemu-devel@nongnu.org

On 21/06/2017 16:15, Theodore Dubois wrote:
> Hi, I’ve got a question about the addend field in the TLB. Why use
> this instead of a pointer to the host page? I would think the speed
> difference would be unmeasurable.

After the TLB check you have computed "x & ~(PAGE_SIZE - 1)", but not "x
& (PAGE_SIZE - 1)".  Without the addend field you would need an extra
instruction for the latter and you would have more complicated register
allocations.  It would probably be small but measurable.  If you think
it simplifies the code and it is not measurable, do it and send a patch! :)

Paolo

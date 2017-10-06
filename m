Received: from eggs.gnu.org ([2001:4830:134:3::10]:54483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e0SDB-0002BA-A4
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e0SD8-0000Q8-7v
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:58:41 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:54951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e0SD8-0000ON-0T
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:58:38 -0400
Received: by mail-wm0-f46.google.com with SMTP id i124so7759900wmf.3
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 05:58:37 -0700 (PDT)
References: <20170922151208.24590-1-aik@ozlabs.ru>
	<df2f7ce1-a868-4a99-52ec-d4f934e1b7b7@redhat.com>
	<f0f20f2a-6946-1b44-768f-3ec8035d5e74@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ba3606b7-1f69-9498-b480-8e24521718da@redhat.com>
Date: Fri, 6 Oct 2017 14:58:27 +0200
MIME-Version: 1.0
In-Reply-To: <f0f20f2a-6946-1b44-768f-3ec8035d5e74@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu] virtio-pci: Replace modern_as
 with direct access to modern_bar
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

On 03/10/2017 04:11, Alexey Kardashevskiy wrote:
>>> What is best to do if MR is not found (and is it possible in practice)?
>>> assert or redirect to unassigned memory?
>> Do nothing at all, I think.
> Repost without asserts?

Yes, I guess so.

>> I haven't thought much about the endian switches, but it looks good
>> apart from that.
> What is next? Michael?

Yes, I was going to ping him about this patch too.

Paolo

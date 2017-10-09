Received: from eggs.gnu.org ([2001:4830:134:3::10]:45256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e1Oc9-0000lB-Oi
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 23:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e1Oc5-0003Zn-Mh
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 23:20:21 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:37513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1e1Oc5-0003Zc-DT
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 23:20:17 -0400
Received: by mail-pf0-x241.google.com with SMTP id z80so5784163pff.4
	for <qemu-devel@nongnu.org>; Sun, 08 Oct 2017 20:20:17 -0700 (PDT)
References: <20170922151208.24590-1-aik@ozlabs.ru>
	<df2f7ce1-a868-4a99-52ec-d4f934e1b7b7@redhat.com>
	<f0f20f2a-6946-1b44-768f-3ec8035d5e74@ozlabs.ru>
	<ba3606b7-1f69-9498-b480-8e24521718da@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <3da73e23-7c1b-aecc-a908-4774b0807b83@ozlabs.ru>
Date: Mon, 9 Oct 2017 14:20:12 +1100
MIME-Version: 1.0
In-Reply-To: <ba3606b7-1f69-9498-b480-8e24521718da@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

On 06/10/17 23:58, Paolo Bonzini wrote:
> On 03/10/2017 04:11, Alexey Kardashevskiy wrote:
>>>> What is best to do if MR is not found (and is it possible in practice)?
>>>> assert or redirect to unassigned memory?
>>> Do nothing at all, I think.
>> Repost without asserts?
> 
> Yes, I guess so.

easy, done :)

> 
>>> I haven't thought much about the endian switches, but it looks good
>>> apart from that.
>> What is next? Michael?
> 
> Yes, I was going to ping him about this patch too.
> 
> Paolo


-- 
Alexey

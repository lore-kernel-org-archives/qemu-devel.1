Received: from eggs.gnu.org ([2001:4830:134:3::10]:34993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gV92M-0008Dz-Ci
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 00:50:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gV92I-0001ga-PH
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 00:50:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gV92I-0001eG-FD
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 00:50:50 -0500
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
	<1543851204-41186-10-git-send-email-pbonzini@redhat.com>
	<765f17e9-ce4d-1015-f76d-5aa168e567b2@redhat.com>
	<b21c1434-c4e6-6690-5c51-1194c75a5ed0@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3c48ec30-49e6-2205-a9c5-c1101ce0a496@redhat.com>
Date: Fri, 7 Dec 2018 06:50:43 +0100
MIME-Version: 1.0
In-Reply-To: <b21c1434-c4e6-6690-5c51-1194c75a5ed0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/71] vhost-user-test: support
 VHOST_USER_PROTOCOL_F_CROSS_ENDIAN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>

On 2018-12-06 21:06, Paolo Bonzini wrote:
> On 06/12/18 17:15, Thomas Huth wrote:
>>>  
>>> -        for (j = 0; j < 256; j++) {
>>> -            uint32_t a = readl(s->memory.regions[i].guest_phys_addr + j*4);
>>> +        for (j = 0; j < 1024; j++) {
>>> +            uint32_t a = readb(s->memory.regions[i].guest_phys_addr + j);
>> Can't you simply use memread() intead?
> 
> Yes, I guess I could do memread + memcmp, but I wanted to change the
> code as little as possible here.

OK, fair.

Reviewed-by: Thomas Huth <thuth@redhat.com>

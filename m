Received: from eggs.gnu.org ([2001:4830:134:3::10]:35467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gUzvO-0005BU-Pb
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:07:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gUzvJ-0003oP-NI
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:07:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gUzvJ-0003kN-9r
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:07:01 -0500
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
	<1543851204-41186-10-git-send-email-pbonzini@redhat.com>
	<765f17e9-ce4d-1015-f76d-5aa168e567b2@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b21c1434-c4e6-6690-5c51-1194c75a5ed0@redhat.com>
Date: Thu, 6 Dec 2018 21:06:54 +0100
MIME-Version: 1.0
In-Reply-To: <765f17e9-ce4d-1015-f76d-5aa168e567b2@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>

On 06/12/18 17:15, Thomas Huth wrote:
>>  
>> -        for (j = 0; j < 256; j++) {
>> -            uint32_t a = readl(s->memory.regions[i].guest_phys_addr + j*4);
>> +        for (j = 0; j < 1024; j++) {
>> +            uint32_t a = readb(s->memory.regions[i].guest_phys_addr + j);
> Can't you simply use memread() intead?

Yes, I guess I could do memread + memcmp, but I wanted to change the
code as little as possible here.

Paolo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:35872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gJQkn-0007qL-To
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:20:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gJQdW-0002QH-NC
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:12:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gJQdW-0002N1-Dn
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:12:50 -0500
References: <CALMp9eQ5zWxb2N9fyYz=WcQshwk0L6qQ4D6L6+p_dzMo4H=txA@mail.gmail.com>
	<20181102034649.43559-1-liran.alon@oracle.com>
	<12c26c34-8dd1-a442-7826-86b93ff978f8@redhat.com>
	<20181102123504.GA2387@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8f689c05-350b-b9b3-2c62-e7a54c85af7d@redhat.com>
Date: Sun, 4 Nov 2018 23:12:43 +0100
MIME-Version: 1.0
In-Reply-To: <20181102123504.GA2387@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [QEMU PATCH v2 0/2]: KVM: i386: Add support for
 save and restore nested state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Liran Alon <liran.alon@oracle.com>, jmattson@google.com, ehabkost@redhat.com, kvm@vger.kernel.org, mtosatti@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org

On 02/11/2018 13:35, Dr. David Alan Gilbert wrote:
>>
>> Personally, I would like to say that, starting from QEMU 3.2, enabling
>> nested VMX requires a 4.20 kernel.  It's a bit bold, but I think it's a
>> good way to keep some sanity.  Any opinions on that?
> That seems a bit mean; there's a lot of people already using nested.

True.  However, a more complete version of the "plan" is that they could
continue using it, but only with a pre-3.2 machine type.

Paolo

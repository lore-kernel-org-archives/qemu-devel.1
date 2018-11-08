Received: from eggs.gnu.org ([2001:4830:134:3::10]:59759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gKgxw-0007vn-T4
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gKgxs-0001rn-Dr
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:51:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gKgxr-0001eo-TF
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:51:04 -0500
References: <CALMp9eQ5zWxb2N9fyYz=WcQshwk0L6qQ4D6L6+p_dzMo4H=txA@mail.gmail.com>
	<20181102034649.43559-1-liran.alon@oracle.com>
	<CALMp9eRk=a1FEyr78NRGBBZ2iFCo5s2n5N=bM4zR=YF56oob3A@mail.gmail.com>
	<1C803EF0-9E1B-4E1B-A4DD-4BE788A7A1FF@oracle.com>
	<DF5EC0F1-BA8D-4B85-BB1A-B22234235FBA@oracle.com>
	<CALMp9eQSptO+S1NZjQQUa=HQCXFOevHwTDS9i0KXHCGSfKzEkA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a567de11-a106-fd6d-7998-1a18ba17eaaa@redhat.com>
Date: Thu, 8 Nov 2018 10:50:46 +0100
MIME-Version: 1.0
In-Reply-To: <CALMp9eQSptO+S1NZjQQUa=HQCXFOevHwTDS9i0KXHCGSfKzEkA@mail.gmail.com>
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
To: Jim Mattson <jmattson@google.com>, Liran Alon <liran.alon@oracle.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm list <kvm@vger.kernel.org>, mtosatti@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org

On 08/11/2018 01:45, Jim Mattson wrote:
> I have no attachments to the current design. I had used a data[] blob,
> because I didn't think userspace would have any need to know what was
> in there. However, I am now seeing the error of my ways. For example,
> the userspace instruction emulator needs to know the contents of the
> vmcs12 to emulate instructions when in guest mode.

Yeah, we're probably going to have to document the KVM vmcs12 structure,
possibly moving it to uapi.  But that's a different thing from
save/restore state, which can use the 4K or 8K data[] blob.

Paolo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gP4vM-0000yZ-6Q
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:14:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gP4vJ-0004MX-47
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:14:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gP4vI-0004MJ-T7
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:14:33 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29B5A308A941
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 12:14:32 +0000 (UTC)
References: <20181119182330.17147-1-pbonzini@redhat.com>
	<20181120114422.GA5072@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20c9d320-f189-f65a-8a29-ddead8949d45@redhat.com>
Date: Tue, 20 Nov 2018 13:14:29 +0100
MIME-Version: 1.0
In-Reply-To: <20181120114422.GA5072@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target/i386: kvm: add VMX migration
 blocker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

On 20/11/18 12:44, Dr. David Alan Gilbert wrote:
> * Paolo Bonzini (pbonzini@redhat.com) wrote:
>> Nested VMX does not support live migration yet.  Add a blocker
>> until that is worked out.
>>
>> Nested SVM only does not support it, but unfortunately it is
>> enabled by default for -cpu host so we cannot really disable it.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> So I'm OK with this, but it does need a release note warning whenever it
> goes in, because it'll surprise those who've already enabled nesting
> but don't use it on all their VMs.

Yes, of course.

Paolo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDTCr-0002sB-SG
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDTCm-0008Qv-Um
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:44:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gDTCl-0008N3-En
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:44:36 -0400
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
	<1539894735-14232-7-git-send-email-pbonzini@redhat.com>
	<CAFEAcA9HgX84HT68PxCc3b_HhrqiEowe2zh8NOHYW-M1g-dq8Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <171fc99b-92a4-1b2f-dc64-0e8c5d92a5c4@redhat.com>
Date: Fri, 19 Oct 2018 13:44:29 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9HgX84HT68PxCc3b_HhrqiEowe2zh8NOHYW-M1g-dq8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 06/48] target-i386: kvm: do not initialize
 padding fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19/10/2018 11:03, Peter Maydell wrote:
> On 18 October 2018 at 21:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> The exception.pad field is going to be renamed to pending in an upcoming
>> header file update.  Remove the unnecessary initialization; it was
>> introduced to please valgrind (commit 7e680753cfa2) but they were later
>> rendered unnecessary by commit 076796f8fd27f4d, which added the "= {}"
>> initializer to the declaration of "events".  Therefore the patch does
>> not change behavior in any way.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM
> 

I'll include your R-b in v3.

Paolo

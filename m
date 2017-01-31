Received: from eggs.gnu.org ([2001:4830:134:3::10]:60476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cYhpU-00048n-As
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:27:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cYhpT-0001eP-Iw
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:27:16 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
References: <1485879287-12548-1-git-send-email-peter.maydell@linaro.org>
	<87wpdbw2ki.fsf@dusky.pond.sub.org>
Message-ID: <157b55c5-2927-5f4e-0c43-820abd75a6d2@redhat.com>
Date: Tue, 31 Jan 2017 18:27:10 -0500
MIME-Version: 1.0
In-Reply-To: <87wpdbw2ki.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Drop QEMU_GNUC_PREREQ() checks for gcc
 older than 4.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, patches@linaro.org



On 31/01/2017 12:40, Markus Armbruster wrote:
>>  
>>  #define QEMU_NORETURN __attribute__ ((__noreturn__))
>>  
>> -#if QEMU_GNUC_PREREQ(3, 4)
>>  #define QEMU_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
>> -#else
>> -#define QEMU_WARN_UNUSED_RESULT
>> -#endif
> Should we inline this macro?
> 
>>  
>> -#if QEMU_GNUC_PREREQ(4, 0)
>>  #define QEMU_SENTINEL __attribute__((sentinel))
>> -#else
>> -#define QEMU_SENTINEL
>> -#endif
> Likewise.

Why, since we don't do that for QEMU_NORETURN, QEMU_PACKED, etc.?

Paolo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:49647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZjRH-0002UD-Bg
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 16:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZjRE-0004og-5D
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 16:31:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZjRD-0004oG-QJ
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 16:31:32 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20181207131732.21073-1-lvivier@redhat.com>
	<f4c7787a-c0c5-b239-9d61-e5ae0fcfa6b9@redhat.com>
	<5206f22c-a472-2f17-e9e9-adf7960fb6cb@redhat.com>
	<90581a67-61d5-46e8-1a6c-5e0e342c6546@redhat.com>
Message-ID: <2e164218-63ea-4e83-3ca0-9592e68a53fa@redhat.com>
Date: Wed, 19 Dec 2018 22:31:24 +0100
MIME-Version: 1.0
In-Reply-To: <90581a67-61d5-46e8-1a6c-5e0e342c6546@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] scsi-disk: Convert from DPRINTF()
 macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 19/12/18 22:30, Paolo Bonzini wrote:
> On 07/12/18 17:37, Laurent Vivier wrote:
>>> TIL about trace_event_get_state_backends(), I'll use it to clean other
>>> hexdump traces, thanks :)
>> I've copied that from gdbstub.c where there is an hexdump() function
>> using it.
>>
>> I'm going to send a v2 of this patch, because I think it is not needed
>> in this case to pass the function in the parameters.
> 
> I think it's better like this, you'd have to free the buffer in the
> caller and that's also ugly.

Nevermind, I diffed v1 and v2 and I see what I mean.  I queued v2.

Paolo

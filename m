Received: from eggs.gnu.org ([2001:4830:134:3::10]:39364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBebf-0005PD-V2
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:26:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBebd-00073M-BQ
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:26:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eBebd-00072r-4g
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:26:13 -0500
References: <CANRm+CxGAiDBDYrtvxXwsPwt2WjiY_biMCVkvQOyAaQtv5v-UQ@mail.gmail.com>
	<80415da5-4eef-bf85-b617-fadc3dae4475@redhat.com>
	<CANRm+CwexgKHUVK3b3QYw8ksyaSgZRDiWztOsOvPpMugTQj16w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e23177c9-36cb-2ad7-18c0-ebf3caaebb52@redhat.com>
Date: Mon, 6 Nov 2017 11:26:04 +0100
MIME-Version: 1.0
In-Reply-To: <CANRm+CwexgKHUVK3b3QYw8ksyaSgZRDiWztOsOvPpMugTQj16w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu core file size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 06/11/2017 11:01, Wanpeng Li wrote:
> 2017-11-06 17:41 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
>> On 06/11/2017 10:11, Wanpeng Li wrote:
>>> Hi all,
>>>
>>> qemu core dump, max_core="unlimited", dump_guest_core=0, kill -11 pid
>>> to generate a qemu core file, the Rss of qemu itself is ~40MB, the
>>> core file is almost ~40MB in centos 6.x, but ~400MB in cents 7.x, any
>>> idea?
>>
>> My suspicion is the memory API, which isn't used in CentOS 6.x.  QEMU
>> 2.11 should fix that.
> 
> Could you point out the patchset for the fix?

Between 447b0d0b9ee8a0ac216c3186e0f3c427a1001f0c and
092aa2fc65b7a35121616aad8f39d47b8f921618.

Thanks,

Paolo

> 
> Regards,
> Wanpeng Li
> 

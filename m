Received: from eggs.gnu.org ([2001:4830:134:3::10]:44285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBg7P-0000kg-Am
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:03:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBg7J-0005aB-JW
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:03:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eBg7J-0005Zt-DS
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:03:01 -0500
References: <CANRm+CxGAiDBDYrtvxXwsPwt2WjiY_biMCVkvQOyAaQtv5v-UQ@mail.gmail.com>
	<80415da5-4eef-bf85-b617-fadc3dae4475@redhat.com>
	<CANRm+CwexgKHUVK3b3QYw8ksyaSgZRDiWztOsOvPpMugTQj16w@mail.gmail.com>
	<e23177c9-36cb-2ad7-18c0-ebf3caaebb52@redhat.com>
	<20171106115931.GB3898@lemon>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fb7c5778-238d-ac99-26d6-8a6d9c80a0f4@redhat.com>
Date: Mon, 6 Nov 2017 13:02:50 +0100
MIME-Version: 1.0
In-Reply-To: <20171106115931.GB3898@lemon>
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
To: Fam Zheng <famz@redhat.com>
Cc: Wanpeng Li <kernellwp@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 06/11/2017 12:59, Fam Zheng wrote:
>>> Could you point out the patchset for the fix?
>> Between 447b0d0b9ee8a0ac216c3186e0f3c427a1001f0c and
>> 092aa2fc65b7a35121616aad8f39d47b8f921618.
> Not sure how these relate to the core size, but I've tested upstream
> (ec7a8bf0b8f7dc7288fe8745464ee8217528cc6c) and with dump-guest-core=off the core
> file is 363M, still significantly larger than rss (~73M).
> 
> What is bloating the core file?

My guess would have been fragmented heap.  The core file, unlike the
RSS, includes all the mmaped memory (e.g. from shared libraries) that
has never been used.

For example, all the Ceph/Gluster/PulseAudio/SPICE/whatever libraries
are included in the core file but likely are not in the RSS.

Paolo

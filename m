Received: from eggs.gnu.org ([2001:4830:134:3::10]:49038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1eBgMw-00068r-BK
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:19:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1eBgMn-0004uw-2g
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:19:10 -0500
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:48823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1eBgMm-0004un-Ub
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:19:01 -0500
Received: by mail-oi0-x22a.google.com with SMTP id m198so6895876oig.5
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 04:19:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <fb7c5778-238d-ac99-26d6-8a6d9c80a0f4@redhat.com>
References: <CANRm+CxGAiDBDYrtvxXwsPwt2WjiY_biMCVkvQOyAaQtv5v-UQ@mail.gmail.com>
	<80415da5-4eef-bf85-b617-fadc3dae4475@redhat.com>
	<CANRm+CwexgKHUVK3b3QYw8ksyaSgZRDiWztOsOvPpMugTQj16w@mail.gmail.com>
	<e23177c9-36cb-2ad7-18c0-ebf3caaebb52@redhat.com>
	<20171106115931.GB3898@lemon>
	<fb7c5778-238d-ac99-26d6-8a6d9c80a0f4@redhat.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Mon, 6 Nov 2017 20:18:59 +0800
Message-ID: <CANRm+Cw=F244w=6YMutjcvWin9_xiRt0Z1MvT=oi+7CXjU+DXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] qemu core file size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

2017-11-06 20:02 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
> On 06/11/2017 12:59, Fam Zheng wrote:
>>>> Could you point out the patchset for the fix?
>>> Between 447b0d0b9ee8a0ac216c3186e0f3c427a1001f0c and
>>> 092aa2fc65b7a35121616aad8f39d47b8f921618.
>> Not sure how these relate to the core size, but I've tested upstream
>> (ec7a8bf0b8f7dc7288fe8745464ee8217528cc6c) and with dump-guest-core=off the core
>> file is 363M, still significantly larger than rss (~73M).
>>
>> What is bloating the core file?
>
> My guess would have been fragmented heap.  The core file, unlike the
> RSS, includes all the mmaped memory (e.g. from shared libraries) that
> has never been used.
>
> For example, all the Ceph/Gluster/PulseAudio/SPICE/whatever libraries
> are included in the core file but likely are not in the RSS.

Do you mean not use Memory API will avoid the fragmented heap?

Regards,
Wanpeng Li

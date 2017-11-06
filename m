Received: from eggs.gnu.org ([2001:4830:134:3::10]:55079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1eBeDl-0007qY-IT
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:01:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1eBeDf-000211-Pf
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:01:33 -0500
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:57182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1eBeDf-00020q-LK
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:01:27 -0500
Received: by mail-oi0-x22f.google.com with SMTP id v9so6618326oif.13
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 02:01:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <80415da5-4eef-bf85-b617-fadc3dae4475@redhat.com>
References: <CANRm+CxGAiDBDYrtvxXwsPwt2WjiY_biMCVkvQOyAaQtv5v-UQ@mail.gmail.com>
	<80415da5-4eef-bf85-b617-fadc3dae4475@redhat.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Mon, 6 Nov 2017 18:01:26 +0800
Message-ID: <CANRm+CwexgKHUVK3b3QYw8ksyaSgZRDiWztOsOvPpMugTQj16w@mail.gmail.com>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

2017-11-06 17:41 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
> On 06/11/2017 10:11, Wanpeng Li wrote:
>> Hi all,
>>
>> qemu core dump, max_core="unlimited", dump_guest_core=0, kill -11 pid
>> to generate a qemu core file, the Rss of qemu itself is ~40MB, the
>> core file is almost ~40MB in centos 6.x, but ~400MB in cents 7.x, any
>> idea?
>
> My suspicion is the memory API, which isn't used in CentOS 6.x.  QEMU
> 2.11 should fix that.

Could you point out the patchset for the fix?

Regards,
Wanpeng Li

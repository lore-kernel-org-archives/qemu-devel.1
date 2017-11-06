Received: from eggs.gnu.org ([2001:4830:134:3::10]:45368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBduu-0002ET-B8
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:42:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBdup-0001Gz-AU
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:42:04 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:54861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eBdup-0001Gh-3y
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:41:59 -0500
Received: by mail-wm0-f51.google.com with SMTP id r68so12775814wmr.3
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 01:41:58 -0800 (PST)
References: <CANRm+CxGAiDBDYrtvxXwsPwt2WjiY_biMCVkvQOyAaQtv5v-UQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <80415da5-4eef-bf85-b617-fadc3dae4475@redhat.com>
Date: Mon, 6 Nov 2017 10:41:56 +0100
MIME-Version: 1.0
In-Reply-To: <CANRm+CxGAiDBDYrtvxXwsPwt2WjiY_biMCVkvQOyAaQtv5v-UQ@mail.gmail.com>
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
To: Wanpeng Li <kernellwp@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Fam Zheng <famz@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 06/11/2017 10:11, Wanpeng Li wrote:
> Hi all,
> 
> qemu core dump, max_core="unlimited", dump_guest_core=0, kill -11 pid
> to generate a qemu core file, the Rss of qemu itself is ~40MB, the
> core file is almost ~40MB in centos 6.x, but ~400MB in cents 7.x, any
> idea?

My suspicion is the memory API, which isn't used in CentOS 6.x.  QEMU
2.11 should fix that.

Paolo

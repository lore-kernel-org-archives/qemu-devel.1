Received: from eggs.gnu.org ([2001:4830:134:3::10]:47706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elH1m-00008Z-Mm
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:32:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elH1j-0003WC-Ra
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:32:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52200 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elH1j-0003Vt-O0
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:32:23 -0500
References: <20180205181846.29996-1-dgilbert@redhat.com>
	<20180212133227.4lmmxomnddrb2vmt@kamzik.brq.redhat.com>
	<20180212150703.GB2545@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cbbf1a55-33ec-2738-62f9-b7a7c531941f@redhat.com>
Date: Mon, 12 Feb 2018 10:32:07 -0600
MIME-Version: 1.0
In-Reply-To: <20180212150703.GB2545@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] tests/migration: Add source to PC boot
 block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Andrew Jones <drjones@redhat.com>
Cc: wei@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, peterx@redhat.com, quintela@redhat.com

On 02/12/2018 09:07 AM, Dr. David Alan Gilbert wrote:

>>
>> Is xxd now considered a common enough tool for portable scripts? I've
>> always liked xxd for manual use, but scripted with 'od'.
> 
> This script isn't part of a normal build or make check or anything, so
> jumping through hoops to make it portable for the mythical other person
> who might ever run it seems OTT, especially since xxd is very common,
> and I'm not sure how much I'd bet on the portability of od's output
> format either.

Relying on xxd is okay given your arguments, but od IS portable (it is 
required by POSIX, and if you stick to the basics that POSIX documents, 
things are pretty consistent between implementations).  I will grant, 
however, that a portable use of od has a much longer command line (with 
the options you need to turn on for saner output, because who reads 
octal these days) than xxd giving you hex by default.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

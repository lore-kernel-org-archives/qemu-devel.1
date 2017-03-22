Received: from eggs.gnu.org ([2001:4830:134:3::10]:34817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cqeQL-0007sg-6t
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cqeQI-0001sD-3m
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:27:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cqeQH-0001rm-UA
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:27:26 -0400
References: <CAJy91CY1SOwi7D-kyU0ooe5SyhM414WaBCedXuPfXXhJpbo1fg@mail.gmail.com>
	<CAFEAcA_etsFstPtUzs0AZjWD35MhMLhwru0ibJzS_upgE-nsng@mail.gmail.com>
	<CAJy91CZmqEUXLKjRJ0JdUEf83E3FwE_24qmej-4C8uAGQkTPWA@mail.gmail.com>
	<CAFEAcA-mzO7vniDEaZeueVFQ7+MVBB7pnzHhahv2Yk_f3q0mJw@mail.gmail.com>
	<CAJy91CZ4Ed-HGHLkzEc1dqQbo32d-eTE1S1ovO_ZwkDdTpkQXQ@mail.gmail.com>
	<CAJy91CaCV40FgSP55qWZeZgkQ=2+E8Cr7xdbu9pn5HLEo+6JJQ@mail.gmail.com>
	<CAJy91CYEwOVT7oEdYY=21__c2kcLTyxyjAaq7Zx4VnQdeLdQQQ@mail.gmail.com>
	<CAFEAcA_t9iLude4Vu3Zc=_wcXMTtFb4Q4oJ8O+zLAJ9isAPqHQ@mail.gmail.com>
	<1322109813.6444955.1490172025040.JavaMail.zimbra@redhat.com>
	<CAJy91CaUxFHJeGLLW4DqK6sBwx2qDnE9s20ZbdT86JDn8yQoHg@mail.gmail.com>
	<218df442-1a31-e969-32ef-01184fae84c0@redhat.com>
	<CAJy91CbBV97RRKr=Rze5-eYrYAvnwiDZQ0oQZi33aKR1v-UXKg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2d7a5a9a-8a7b-1bae-feb8-80fc4ee3048a@redhat.com>
Date: Wed, 22 Mar 2017 12:27:22 +0100
MIME-Version: 1.0
In-Reply-To: <CAJy91CbBV97RRKr=Rze5-eYrYAvnwiDZQ0oQZi33aKR1v-UXKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Guest application reading from pl011 without
 device driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>



On 22/03/2017 11:28, Jiahuan Zhang wrote:
> 
>     A function that lets a process sleep until data is available on the
>     socket.  The solution is to rewrite Windows chardev handling in QEMU to
>     use threads or overlapped I/O.
> 
> Yes, socket is working well. Will you add the "select" to pipe
> implementation?

It's Windows that doesn't support it (the Windows function name is
WaitForSingleObject).

Paolo

> Or shall I look into it and fix? Since in my case, I prefer windows pipe
> to socket.
> But if I do, definitly, I will spend much more effort than you, the experts.

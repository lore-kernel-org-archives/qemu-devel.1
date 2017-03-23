Received: from eggs.gnu.org ([2001:4830:134:3::10]:41616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr05e-0003W8-Kk
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 06:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr05b-0005vC-Ip
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 06:35:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17049)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cr05b-0005uX-Cr
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 06:35:31 -0400
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
	<2d7a5a9a-8a7b-1bae-feb8-80fc4ee3048a@redhat.com>
	<CAJy91CbcV3_jVg9PTD6unka6_M65rgkKDv0KsBK=YpVd=XKqvg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ed9e6d65-ba93-d572-861a-46926a37d42a@redhat.com>
Date: Thu, 23 Mar 2017 11:35:27 +0100
MIME-Version: 1.0
In-Reply-To: <CAJy91CbcV3_jVg9PTD6unka6_M65rgkKDv0KsBK=YpVd=XKqvg@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>



On 23/03/2017 11:12, Jiahuan Zhang wrote:
> 
>     It's Windows that doesn't support it (the Windows function name is
>     WaitForSingleObject).
> 
> 
> Hi, I have checked the Windows chardev implimentation in QEMU.
> I learned from char-win-stdio.c to using thread and WaitForSingleObject
> for interlocking.
> char-win-stdio.c uses qemu_add_wait_object().
> Char-pipe.c uses qemu_add_polling_cb().
> I found all over qemu, only char-pipe uses qemu_add_polling_cb().
> Does this mean that somebody has already looked into this issue,
> and failed in using qemu_add_wait_object(),
> and then he/she created qemu_add_polling_cb()?

I don't know, but using threads sounds like a way to solve the bug, indeed.

Thanks,

Paolo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1d5A66-00067U-Ul
	for qemu-devel@nongnu.org; Mon, 01 May 2017 08:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1d5A65-000813-Nt
	for qemu-devel@nongnu.org; Mon, 01 May 2017 08:06:34 -0400
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:35297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiahuanzhang90@gmail.com>)
	id 1d5A65-00080n-IM
	for qemu-devel@nongnu.org; Mon, 01 May 2017 08:06:33 -0400
Received: by mail-qt0-x230.google.com with SMTP id y33so88069052qta.2
	for <qemu-devel@nongnu.org>; Mon, 01 May 2017 05:06:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJy91Cbxh8kG=76EJFHXAd+qbCH-Gx+V8-C9O7b3ytm2XNzPEw@mail.gmail.com>
References: <CAJy91CY1SOwi7D-kyU0ooe5SyhM414WaBCedXuPfXXhJpbo1fg@mail.gmail.com>
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
	<ed9e6d65-ba93-d572-861a-46926a37d42a@redhat.com>
	<CAJy91CYfOUZ+_TrN6-tLtWuPX-3_gRc7bfNa4anW0iM42i1FTg@mail.gmail.com>
	<d355d12a-9f37-b7ca-aab0-1fcd0d481a8f@redhat.com>
	<CAJy91Ca+=vJtXn6dV-awqz8xKHNyAnAw0MY91Fbr9yOE2-NNPw@mail.gmail.com>
	<CAJy91Cbxh8kG=76EJFHXAd+qbCH-Gx+V8-C9O7b3ytm2XNzPEw@mail.gmail.com>
From: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Date: Mon, 1 May 2017 14:06:32 +0200
Message-ID: <CAJy91Cb2G7yTW1ALD2=bdh+2GbjDavg1ruDw0VfZG+wgxHvkyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

Hi, can somebody help to check this host (Windows 7) to guest (Linux
4.10) Windows named pipe data transfer?
The method I implemented has while loops that makes qemu consume 100% CPU
time.
I cannot find any optimization to eliminate the loops. So sad!

Anyone has time, please help.

On 24 March 2017 at 11:00, Jiahuan Zhang <jiahuanzhang90@gmail.com> wrote:

> Hi, now it is working with the following char-pipe_new.c.
>
> See the patch. Doing the "if fifo has space" polling only when there are
> data on the pipe, and next reading from pipe.
> The sub_thread does these three things, and the main thread only does
> writing to UART fifo when the subthread signalled its handler.
>
> It is working in my case to transfer large data. Rational? Please check.
>
> On 24 March 2017 at 08:24, Jiahuan Zhang <jiahuanzhang90@gmail.com> wrote:
>
>> Hi, here are the patch files for char-pipe.c, char-win.c, char-win.h
>>
>>
>> On 23 March 2017 at 18:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>>>
>>>
>>> On 23/03/2017 18:28, Jiahuan Zhang wrote:
>>> > Hi, the method doesn't work for pipe. It still causes the same issue.
>>> > The only difference is that the first byte in the UART fifo can be read
>>> > by the guest app.
>>> > So now my guest app can immediately read 17bytes when the host is
>>> > sending data continuously,
>>> > then guest app is unable to read.
>>> >
>>> > Now there is a solution-to-be. Set the qemu pipe chardev to wait for 1
>>> > millisecond before do a next ReadFile(),
>>> > then the pl011 can deliver the complete large data by the 16-byte fifo
>>> > continuously to the guest app.
>>> >
>>> > Is it rational? Or is this host -CPU-dependent?
>>>
>>> Post the patch, maybe you have a bug.
>>>
>>> Paolo
>>>
>>
>>
>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:52332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cJeiB-00021E-1c
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 06:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cJei9-000408-OR
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 06:05:31 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:33932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cJei9-000401-Ka
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 06:05:29 -0500
Received: by mail-io0-x244.google.com with SMTP id y124so25435959iof.1
	for <qemu-devel@nongnu.org>; Wed, 21 Dec 2016 03:05:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000301d25b4f$20018440$60048cc0$@ru>
References: <000301d259dc$f9d097c0$ed71c740$@ru>
	<000601d25a95$12b1b9f0$38152dd0$@ru>
	<20161220102126.GE5602@stefanha-x1.localdomain>
	<002501d25ab1$af024b00$0d06e100$@ru>
	<CAJSP0QXm9ssLC5C+gV_agkEW_fdUY=NWBMvHqMh55UhYTR276g@mail.gmail.com>
	<000301d25b4f$20018440$60048cc0$@ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 21 Dec 2016 11:05:28 +0000
Message-ID: <CAJSP0QW1pOcthcEt16Pp5xQu3miUh2Leq3kn3yvQqWqhi1P=QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] qemu-2.8-rc4 is broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Wed, Dec 21, 2016 at 5:57 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
>> -----Original Message-----
>> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
>> On Tue, Dec 20, 2016 at 11:10 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
>> >> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
>> >> On Tue, Dec 20, 2016 at 10:45:44AM +0300, Pavel Dovgalyuk wrote:
>> >> > It also fails much earlier when I enable logs with "-d int -D log".
>> >> >
>> >> Looks like a heap corruption bug since free() is failing.
>> >
>> > Seems to be a race condition.
>> > When I add logs into invalidate_page_bitmap, the bug disappears.
>> > It seems that someone tries to free the same page bitmap twice and simultaneously.
>>
>> Does the following workaround prevent the crashes?
>>
>> -global apic-common.vapic=off
>
> Yes, this option helps.
> Thank you.

Good news.  This can be fixed in 2.8.1 once someone finds a solution.

Stefan

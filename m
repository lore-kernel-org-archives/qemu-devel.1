Received: from eggs.gnu.org ([2001:4830:134:3::10]:39106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dorjn-0005cz-G6
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dorji-0008Nd-L9
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:48:27 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:35063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1dorji-0008Kp-Cc
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:48:22 -0400
Received: by mail-io0-x242.google.com with SMTP id n74so196458ioe.2
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 06:48:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKPgXcHH=H6OzbLKen3q21Rmx9iwdg7C_jzApmqin7NDR6XMxQ@mail.gmail.com>
References: <20170813155849.11368-1-sameeh@daynix.com>
	<CAKPgXcHH=H6OzbLKen3q21Rmx9iwdg7C_jzApmqin7NDR6XMxQ@mail.gmail.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Mon, 4 Sep 2017 16:48:19 +0300
Message-ID: <CAKPgXcFBJcVCuvk-Ao939qFZpLhVVKuvWHsefyej-S8w+4jSGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>

Ping.

On Tue, Aug 22, 2017 at 2:18 PM, Sameeh Jubran <sameeh@daynix.com> wrote:

> Ping.
>
> On Sun, Aug 13, 2017 at 6:58 PM, Sameeh Jubran <sameeh@daynix.com> wrote:
>
>> From: Sameeh Jubran <sjubran@redhat.com>
>>
>> This series fixes qemu-ga's behaviour upon facing a missing serial/serial
>> driver by listening to the serial device's events.
>>
>> For more info on why this series is needed checkout the commit message
>> of the third patch and the following bugzilla:
>> https://bugzilla.redhat.com/show_bug.cgi?id=990629.
>>
>> Sameeh Jubran (3):
>>   qga: Channel: Add functions for checking serial status
>>   qga: main: make qga config and socket activation global
>>   qga: Prevent qemu-ga exit if serial doesn't exist
>>
>>  Makefile            |   4 +
>>  qga/channel-posix.c |  54 ++++++++++
>>  qga/channel-win32.c |  60 +++++++++++
>>  qga/channel.h       |   9 ++
>>  qga/main.c          | 284 ++++++++++++++++++++++++++++++
>> ++++++++++++++++------
>>  qga/service-win32.h |   4 +
>>  6 files changed, 385 insertions(+), 30 deletions(-)
>>
>> --
>> 2.9.4
>>
>>
>
>
> --
> Respectfully,
> *Sameeh Jubran*
> *Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
> *Software Engineer @ Daynix <http://www.daynix.com>.*
>



-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*

Received: from eggs.gnu.org ([2001:4830:134:3::10]:35319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYXT6-0002Ai-Vo
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYXT3-0005qA-Ui
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:00:17 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:37024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYXT3-0005oW-Pw
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:00:13 -0400
Received: by mail-qt0-x243.google.com with SMTP id a18-v6so4775831qtj.4
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 07:00:13 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180625165749.3910-1-f4bug@amsat.org>
	<CAFEAcA-gdAOohovhu1iF1fXGjqU_KiuEs0Q6WYRE7=BOBwr+gw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0e438fe8-912e-0b14-7266-f4110bf04bac@amsat.org>
Date: Thu, 28 Jun 2018 11:00:01 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-gdAOohovhu1iF1fXGjqU_KiuEs0Q6WYRE7=BOBwr+gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 0/3] qapi/error: converts
 error_setg(&error_fatal) to error_report() + exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>

On 06/28/2018 10:51 AM, Peter Maydell wrote:
> On 25 June 2018 at 17:57, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Hi,
>>
>> This series converts error_setg(&error_fatal) to error_report() + exit() as
>> suggested by the "qapi/error.h" documentation.
>>
>> This reduce Coverity and Clang static analyzer positive falses.
>>
>> See http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg07585.html:
>>
>>     On 07/24/2017 04:52 PM, Eric Blake wrote:
>>     That's a shame.  Rather, we should patch this file (and others) to avoid
>>     all the inconsistent uses of error_setg(&error_*), to comply with the
>>     error.h documentation.
>>
> 
> Applied to target-arm.next, thanks. (Not all arm code, but mostly
> close enough that that seems the easiest way to deal with it.)

Thanks!

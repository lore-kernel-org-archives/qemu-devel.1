Received: from eggs.gnu.org ([2001:4830:134:3::10]:56933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dq0ub-0004em-TH
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dq0uW-0006GC-U9
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:48:21 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dq0uW-0006G7-QA
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:48:16 -0400
Received: by mail-qk0-x243.google.com with SMTP id d70so232089qkc.1
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 10:48:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170907082918.7299-1-famz@redhat.com>
	<1504776868.15653.6.camel@redhat.com>
	<20170907114329.GD25123@lemon.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ee9face3-fb38-5e29-04d8-9fa673eea1e9@amsat.org>
Date: Thu, 7 Sep 2017 14:48:13 -0300
MIME-Version: 1.0
In-Reply-To: <20170907114329.GD25123@lemon.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/9] buildsys: Move ui/usb library
 cflags/libs to per object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On 09/07/2017 08:43 AM, Fam Zheng wrote:
> On Thu, 09/07 11:34, Gerd Hoffmann wrote:
>> On Thu, 2017-09-07 at 16:29 +0800, Fam Zheng wrote:
>>> Hi Gerd,
>>>
>>> This is part two of the QEMU_CFLAGS and libs_softmmu cleanup series,
>>> including
>>> ui/, audio/ and hw/usb/. Please review.
>>
>> Looks good, survived a test build.
>>
>> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Thanks for the quick review! Do you want to queue this in your tree? If not I
> can include it in my next pull request for "build and test automation" patches.

+1 for "build and test automation"

this series:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Also Fam I recommend you to use scripts/git.orderfile it is easier to 
read the ./configure before the Makefiles.

Regards,

Phil.

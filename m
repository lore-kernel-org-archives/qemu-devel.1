Received: from eggs.gnu.org ([2001:4830:134:3::10]:43221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ezCRt-0008Oc-JH
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 22:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ezCRp-00015q-J5
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 22:28:57 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ezCRp-00015h-ED
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 22:28:53 -0400
Received: by mail-qk0-x242.google.com with SMTP id z184so11505986qkc.1
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 19:28:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180322180940.8253-1-jcmvbkbc@gmail.com>
	<20180322180940.8253-2-jcmvbkbc@gmail.com>
	<6de7c7f7-c2db-c575-53ef-18118c0f4df3@redhat.com>
	<CAMo8Bf+TL_LiYozskKc+EKtozA1yRnboDCUhZXoFA+Y4V+td5A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <63f8479d-1dc9-3c9a-6a23-568155b7295b@amsat.org>
Date: Thu, 22 Mar 2018 23:28:48 -0300
MIME-Version: 1.0
In-Reply-To: <CAMo8Bf+TL_LiYozskKc+EKtozA1yRnboDCUhZXoFA+Y4V+td5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] target/xtensa: add .inc. to non-top
 level source file names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, Eric Blake <eblake@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

On 03/22/2018 05:37 PM, Max Filippov wrote:
> On Thu, Mar 22, 2018 at 12:16 PM, Eric Blake <eblake@redhat.com> wrote:
>> On 03/22/2018 01:09 PM, Max Filippov wrote:
>>>
>>> Fix definitions of existing cores and core importing script.
>>
>> This mentions the script...
>> ...but only touches .c files.
> 
> Yeah, I initially did it in a single patch, but then split it into
> two. Will merge
> them back as suggested.
> 

squashed with #2 (import_core.sh):
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

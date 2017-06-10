Received: from eggs.gnu.org ([2001:4830:134:3::10]:38980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1dJfC2-0000lD-QA
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 08:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1dJfC2-0003Ct-12
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 08:08:38 -0400
Received: from mail-qt0-x236.google.com ([2607:f8b0:400d:c0d::236]:36550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ali.saeedi56@gmail.com>)
	id 1dJfC1-0003Cj-T8
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 08:08:37 -0400
Received: by mail-qt0-x236.google.com with SMTP id u19so96238762qta.3
	for <qemu-devel@nongnu.org>; Sat, 10 Jun 2017 05:08:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d65ddaed-14c0-98be-28e0-d61d0bf351b9@gmail.com>
References: <CAGKXQyd8y6xu77XpV-BS1ZGFKBi3Yh=AAnw98nOWFoPkrmNLrw@mail.gmail.com>
	<d65ddaed-14c0-98be-28e0-d61d0bf351b9@gmail.com>
From: ali saeedi <ali.saeedi56@gmail.com>
Date: Sat, 10 Jun 2017 16:38:35 +0430
Message-ID: <CAGKXQye=1p23gTMBbxRhLF_e-PvQbPcNeQdpxU9s=PTuOhhr4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Memory dirty event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello
thanks for your answer
Do i code in kernel space for writing this API?
Please give me more guide about what should i do to write this API.
thanks a lot

On Thu, May 25, 2017 at 5:50 PM, Xiao Guangrong <guangrong.xiao@gmail.com>
wrote:

>
> No API directly supports your case, but you can do it in KVM by using
> page-track mechanism.
>
>
>
> On 05/25/2017 08:26 PM, ali saeedi wrote:
>
>> Hello
>> How can i receive an event when a page or block is dirtied in qemu code?
>> thanks a lot
>>
>>

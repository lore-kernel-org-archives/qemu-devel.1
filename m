Received: from eggs.gnu.org ([2001:4830:134:3::10]:42518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ewXen-0008A2-LP
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 14:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ewXei-0004jR-SN
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 14:31:17 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:37076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ewXei-0004iX-Kc
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 14:31:12 -0400
Received: by mail-wr0-x230.google.com with SMTP id z12so9328338wrg.4
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 11:31:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180312223455.18124-1-ehabkost@redhat.com>
	<CAFEAcA9W=CLdogF+gHUfQOy7Gb=UHg0oTLYhYMRh7S363ss9wQ@mail.gmail.com>
	<20180313183704.GA3417@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d41924c6-a526-352a-c37a-5a4cf2786dcf@amsat.org>
Date: Thu, 15 Mar 2018 19:31:09 +0100
MIME-Version: 1.0
In-Reply-To: <20180313183704.GA3417@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/7] Machine queue, 2018-03-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

Hi Eduardo,

On 03/13/2018 07:37 PM, Eduardo Habkost wrote:
> On Tue, Mar 13, 2018 at 06:29:10PM +0000, Peter Maydell wrote:
>> On 12 March 2018 at 22:34, Eduardo Habkost <ehabkost@redhat.com> wrote:
>>> The following changes since commit 6ceb1b51f05f9e1892d082960ed602dca7b6696e:
>>>
>>>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20180312-pull-request' into staging (2018-03-12 16:14:37 +0000)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>>>
>>> for you to fetch changes up to a82664f2f8b1ce2db90e644df01d7ca7845881a6:
>>>
>>>   cpu: drop unnecessary NULL check and cpu_common_class_by_name() (2018-03-12 19:33:32 -0300)
>>>
>>> ----------------------------------------------------------------
>>> Machine queue, 2018-03-12
>>>
>>
>> Hi. It looks like this breaks bsd-user compilation:
>>
>> /root/qemu/bsd-user/main.c: In function 'main':
>> /root/qemu/bsd-user/main.c:905:5: warning: implicit declaration of
>> function 'create' [-Wimplicit-function-declaration]
>>      cpu = create(cpu_type);
>>      ^
>> /root/qemu/bsd-user/main.c:905:5: warning: nested extern declaration
>> of 'create' [-Wnested-externs]
>> /root/qemu/bsd-user/main.c:905:9: warning: assignment makes pointer
>> from integer without a cast [enabled by default]
>>      cpu = create(cpu_type);
>>          ^
>>
>> and then later it fails to link with
>> /root/qemu/bsd-user/main.c:905: undefined reference to `create'
> 
> Oops, sorry.  I don't have a BSD host handy right now, are you able to confirm
> if the new tag I pushed fixes it?

You might try:

$ make vm-test
vm-test: Test QEMU in preconfigured virtual machines

  vm-build-ubuntu.i386            - Build QEMU in ubuntu i386 VM
  vm-build-freebsd                - Build QEMU in FreeBSD VM
  vm-build-netbsd                 - Build QEMU in NetBSD VM
  vm-build-openbsd                - Build QEMU in OpenBSD VM

Regards,

Phil.

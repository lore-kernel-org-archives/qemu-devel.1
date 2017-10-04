Received: from eggs.gnu.org ([2001:4830:134:3::10]:32934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzg76-0005yf-P2
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:37:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzg73-0002mJ-Lx
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:37:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dzg73-0002m0-Fj
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:37:09 -0400
References: <20170929110052.6111-1-kraxel@redhat.com>
	<CAFEAcA-8gaOhkuNX9hBt0Ofg-CKkJ-v8puHJ4K3QOq0ZGMgB5w@mail.gmail.com>
	<1507106598.27227.2.camel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9d566b88-7991-b9f4-8b73-737a99d3ac6d@redhat.com>
Date: Wed, 4 Oct 2017 11:37:04 +0200
MIME-Version: 1.0
In-Reply-To: <1507106598.27227.2.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/3] Usb 20170929 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 04.10.2017 10:43, Gerd Hoffmann wrote:
>   Hi,
> 
>> This fails to build from clean (x86-64 Linux host):
>>
>> make[1]: *** No rule to make target '../hw/usb/host-stub.o', needed
>> by
>> 'qemu-system-microblaze'. Stop.
>>
>> (and similar for other targets).
> 
> /me looks puzzled.
> 
> There is a "hw/usb/host-stub.c" file in the repo, so I fail so see why
> make thinks it can't build the object file ...
> 
> Also it works fine in my testing, including a full build of all targets
> (some with and some without usb support).

Ah, deja vu. I think you've now run into the problem that I had with my
patch, too - see:

 https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01875.html
 https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02082.html

I think this is a race condition when building with "make -j" in
parallel. Just add a line like this and you should be fine:

common-obj-$(CONFIG_ALL) += host-stub.o

 Thomas

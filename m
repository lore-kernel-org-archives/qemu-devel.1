Received: from eggs.gnu.org ([209.51.188.92]:48034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1guXdl-00033b-7j
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 02:10:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1guXdk-0001jv-GJ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 02:10:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1guXdk-0001SC-7a
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 02:10:28 -0500
References: <87wom249zf.fsf@dusky.pond.sub.org>
	<CAFEAcA-9rhR3qiTZQx=oYtodfpo81wMWKFafboHR7uN0wRNccw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4374659d-dc3f-4fa4-9ee4-305ea702104a@redhat.com>
Date: Fri, 15 Feb 2019 08:03:40 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-9rhR3qiTZQx=oYtodfpo81wMWKFafboHR7uN0wRNccw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Object instantiation vs. device realization: what
 to do when?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 14/02/2019 17.33, Peter Maydell wrote:
> On Thu, 14 Feb 2019 at 16:21, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> One of qdev's perennial sources of confusion is what to do at object
>> instantiation time, i.e. in TypeInfo::instance_init(), and what to do at
>> device realization time, i.e. in DeviceClass::realize().
> 
> Thanks for opening this topic. It's been on my todo list for a
> long time to try to figure out what the answer is...

I also got no proper answers here, but FWIW, I wrote down some things I
noticed last year here:

 http://people.redhat.com/~thuth/blog/qemu/2018/09/10/instance-init-realize.html

  Thomas

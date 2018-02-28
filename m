Received: from eggs.gnu.org ([2001:4830:134:3::10]:54008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eqvzQ-00031R-7A
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 02:17:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eqvzM-0005YV-TN
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 02:17:24 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:39517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eqvzM-0005YL-Kq
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 02:17:20 -0500
Received: by mail-wm0-x22d.google.com with SMTP id i3so1628728wmi.4
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 23:17:20 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <CAFEAcA8Pu=SkYCPwCnRdKTEFPScsZhj4vJm0dTs+jV1jTWOAog@mail.gmail.com>
	<0304e590-ab51-649b-7cee-bb7c5be6f5e4@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8c93c12e-f794-d0ea-c393-55131ba4ad25@redhat.com>
Date: Wed, 28 Feb 2018 08:17:17 +0100
MIME-Version: 1.0
In-Reply-To: <0304e590-ab51-649b-7cee-bb7c5be6f5e4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Deprecate tilegx ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Chen Gang <chengang@emindsoft.com.cn>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Chen Gang <gang.chen.5i5j@gmail.com>, Chen Gang <xili_gchen_5257@hotmail.com>, Richard Henderson <rth@twiddle.net>, Anthony Green <green@moxielogic.com>

On 28/02/2018 07:11, Thomas Huth wrote:
> On 27.02.2018 12:51, Peter Maydell wrote:
>> I propose that we deprecate and plan to remove the unicore32 code:
> [...]
>> Essentially, it seems to be a largely-inactive university R&D project,
>> it's costing us in maintenance effort every time we have to touch it,
>> and I don't think it has any real users.
>>
>> Does anybody disagree?
>>
>> If we go ahead with deprecating then we should:
>>  * add a note to Changelog that we're deprecating the target
>>  * ditto qemu-doc.texi's deprecation section
>>  * patch hw/unicore32/puv3.c to warn on startup that it's deprecated
>>  * remove it entirely for the 2.14 release
>>
>> We could also remove linux-user/unicore32 immediately, since
>> the linux-user target has been disabled for some time.
> 
> Sounds reasonable to me, but let's wait a week or two for feedback from
> Guan Xuetao.

Sounds good---thought I would consider dropping unicore32 now with no
formal deprecation period...

>> Possibly there are other target architectures we could reasonably
>> deprecate-and-remove (though none of the other ones Linux is dropping
>> in this round are ones we support)...
> 
> I'd vote for marking tilegx as deprecated, too, since we even do not
> have an active maintainer for that CPU core (at least I did not spot one
> in our MAINTAINERS file). Opinions?

Tilegx has been last modified in 2015, so it's a little more alive than
unicore32.

Another one is moxie.  Anthony?

Thanks,

Paolo

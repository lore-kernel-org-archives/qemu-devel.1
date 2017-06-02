Received: from eggs.gnu.org ([2001:4830:134:3::10]:53203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGhb7-00077E-7O
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGhb6-000788-DR
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:06:17 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dGhb6-00076o-61
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:06:16 -0400
Received: by mail-wm0-x244.google.com with SMTP id d127so16966606wmf.1
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 01:06:16 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170601170733.13080-1-pbonzini@redhat.com>
	<CAFEAcA9Yteb5jsB2AJhuhx1Ejg+nwrF8PgetRWv+yFPduLHOgg@mail.gmail.com>
	<CAFEAcA9zPWDQ8Y6ugAut5WobLXzP3zrUeUUH7RcSUMqdLkkndA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2b22afa9-d3fa-99d3-c53d-696215041ffa@redhat.com>
Date: Fri, 2 Jun 2017 10:06:13 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9zPWDQ8Y6ugAut5WobLXzP3zrUeUUH7RcSUMqdLkkndA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 00/34] Misc patches for 2016-06-01
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 01/06/2017 19:56, Peter Maydell wrote:
> On 1 June 2017 at 18:53, Peter Maydell <peter.maydell@linaro.org> wrote:
>> Test failure on OSX:
>>
>> TEST: tests/device-introspect-test... (pid=66373)
>>   /aarch64/device/introspect/list:                                     OK
>>   /aarch64/device/introspect/none:                                     OK
>>   /aarch64/device/introspect/abstract:                                 OK
>>   /aarch64/device/introspect/concrete:                                 **
>> ERROR:/root/qemu/qom/object.c:364:object_initialize_with_type:
>> assertion failed: (type != NULL)
>> Broken pipe
> 
> Got those the wrong way round -- this is the FreeBSD failure
> and the other lot are OSX. Pretty sure it's the same error,
> though -- it's just that for some reason my OSX setup doesn't
> actually cause make to exit with an error when a test fails,
> so it goes on to hit what's probably the same bug in all the
> other check-qtest-$ARCH targets rather than bailing out.

Thanks, any chance you can bisect these?  I'll install a FreeBSD VM next
week.

Paolo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYUgE-0004Zc-2k
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYUgB-0001HW-0E
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:57:06 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:32997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYUgA-0001H0-Ps
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:57:02 -0400
Received: by mail-wm0-x230.google.com with SMTP id v139so2494565wmv.0
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 02:57:02 -0700 (PDT)
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-3-alex.bennee@linaro.org>
	<98e1b6a7-7af5-7b8b-23c8-159572c83eb4@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <98e1b6a7-7af5-7b8b-23c8-159572c83eb4@redhat.com>
Date: Fri, 21 Jul 2017 10:57:00 +0100
Message-ID: <87shhq6rkj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11 02/23] fpu: import SoftFloat3c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, rth@twiddle.net


Thomas Huth <thuth@redhat.com> writes:

> On 20.07.2017 17:04, Alex Bennée wrote:
>> SoftFloat3c is a re-write of the BSD softfloat library which includes
>> a number of new features. It has been written with libraries in mind
>> and has a new API so hopefully we can use both side-by-side as we
>> migrate.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>  fpu/softfloat3c/8086-SSE/extF80M_isSignalingNaN.c |   57 +
>
> I'd maybe rather name the folder "softfloat3" instead of "softfloat3c"
> ... otherwise it does not match anymore if we ever want to update to
> version 3d (which is likely just a minor release with some few bug
> fixes, so we likely don't want to maintain that in a separate folder)

Good point, will do.

--
Alex Bennée

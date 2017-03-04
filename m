Received: from eggs.gnu.org ([2001:4830:134:3::10]:41742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckAFd-00052o-L3
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 09:01:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckAFc-0003lh-QO
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 09:01:37 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:34934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ckAFc-0003l9-H3
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 09:01:36 -0500
Received: by mail-wm0-x22d.google.com with SMTP id v186so34026139wmd.0
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 06:01:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <aeecd6a5-2593-c3c4-25f0-ae0d6af53653@twiddle.net>
References: <1488558530-21016-1-git-send-email-pbonzini@redhat.com>
	<aeecd6a5-2593-c3c4-25f0-ae0d6af53653@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 4 Mar 2017 14:01:14 +0000
Message-ID: <CAFEAcA_2ymGX+9QV=n7Q3j1sMmGuGNJw6XypttJ5r_eQHOeFyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] hppa: avoid anonymous unions in designated
 initializers.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 3 March 2017 at 19:24, Richard Henderson <rth@twiddle.net> wrote:
> On 03/04/2017 03:28 AM, Paolo Bonzini wrote:
>>
>> These cause compilation failures on CentOS 6 or other operating
>> systems with older GCCs.
>>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>         Peter, please consider applying this as a build fix, because
>>         the centos6 docker target is broken.
>
>
> Reviewed-by: Richard Henderson <rth@twiddle.net>

Thanks; applied to master as a buildfix.

-- PMM

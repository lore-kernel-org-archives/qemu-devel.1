Received: from eggs.gnu.org ([2001:4830:134:3::10]:43229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eIFfV-00028K-1d
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:13:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eIFfU-0007xS-BI
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:13:29 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:43079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eIFfU-0007wT-6N
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:13:28 -0500
Received: by mail-oi0-x242.google.com with SMTP id z143so2810528oia.10
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 07:13:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bdbc6042-bbae-b057-c9ee-769c6d7e8345@redhat.com>
References: <1511452598-6077-1-git-send-email-peter.maydell@linaro.org>
	<bdbc6042-bbae-b057-c9ee-769c6d7e8345@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Nov 2017 15:13:07 +0000
Message-ID: <CAFEAcA9304UPDvL2MeQUUomFJFG9BB4SohxOgxJ7wsc2nk-sgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.11?] osdep.h: Make TIME_MAX handle
 different time_t types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Brad Smith <brad@comstyle.com>, Kamil Rytarowski <n54@gmx.com>

On 23 November 2017 at 16:00, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 23/11/2017 16:56, Peter Maydell wrote:
>> In our various supported host OSes, the time_t type may be either 32
>> or 64 bit, and could in theory also be either signed or unsigned.
>> Notably, in OpenBSD time_t is a 64 bit type even if 'long' is 32
>> bits, so using LONG_MAX for TIME_MAX is incorrect.
>>
>> Use an approach suggested by Paolo Bonzini which calculates
>> the maximum value of the type rather than hardcoding it;
>> to do this we use the TYPE_MAXIMUM macro from Gnulib.
>>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---

> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks; applied to master.

-- PMM

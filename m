Received: from eggs.gnu.org ([2001:4830:134:3::10]:45786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cow7Q-0004v7-4R
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 13:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cow7P-0005rD-Fe
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 13:56:52 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:35931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cow7P-0005qU-9e
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 13:56:51 -0400
Received: by mail-wr0-x22c.google.com with SMTP id u108so56776394wrb.3
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 10:56:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <86a22787-b3d0-dd32-9925-61f94de4ad33@weilnetz.de>
References: <20170317160811.28370-1-pbonzini@redhat.com>
	<86a22787-b3d0-dd32-9925-61f94de4ad33@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Mar 2017 17:56:29 +0000
Message-ID: <CAFEAcA_EzhCt1trWAiqof-wPLcp_exWB-V=KiCzzKKpeM8anzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for 2.9 v2] configure: remove Cygwin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>

On 17 March 2017 at 17:52, Stefan Weil <sw@weilnetz.de> wrote:
> Am 17.03.2017 um 17:08 schrieb Paolo Bonzini:
>>
>> The Cygwin target is really compiling for native Win32 with -mno-cygwin.
>> Except, GCC 4.7.0 has finally removed the long deprecated -mno-cygwin
>> option, and that happened about five years ago.
>>
>> Let it rest in peace.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>
>
> Reviewed-by: Stefan Weil <sw@weilnetz.de>
>
> CC'ing qemu-trivial for the pull request.
>
> I only wonder whether we should raise an error if people
> try building QEMU with native Cygwin (not Cygwin / Mingw-w64).

I think the "warn about deprecated hosts" patch that I posted
earlier today will effectively end up doing that, because it
changes the case $targetos from "default to assuming Linux" to
"explicitly check for Linux, and default to an error message".

thanks
-- PMM

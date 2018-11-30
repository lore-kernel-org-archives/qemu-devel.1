Received: from eggs.gnu.org ([2001:4830:134:3::10]:58111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSiFI-0008JY-0N
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:50:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSiBy-0006jQ-TK
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:46:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gSiBy-0006iJ-L7
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:46:46 -0500
References: <1543574620-17506-1-git-send-email-thuth@redhat.com>
	<20181130111555.GA9162@redhat.com>
	<2acf4de2-d826-c2a4-c826-8c966b5cce9e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eb933208-6ee6-7f2a-dc14-bffbfa76cfad@redhat.com>
Date: Fri, 30 Nov 2018 13:46:42 +0100
MIME-Version: 1.0
In-Reply-To: <2acf4de2-d826-c2a4-c826-8c966b5cce9e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0] compiler.h: Add an explicit check
 for the compiler version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, peter.maydell@linaro.org

On 30/11/18 13:30, Thomas Huth wrote:
> Do we really want to artificially limit our support here without any
> further reasons? If the users want to compile QEMU on an older system,
> and one of the libraries does not quite match anymore, it's often easy
> enough to recompile a newer version of the library to get things going
> again. Recompiling a whole compiler is way more cumbersome, though...
> 
> OTOH, we could get rid of some more #if QEMU_GNUC_PREREQ spots in the
> source code if we bump the minimum version to 4.8 ... so that might be a
> real reason to increase the minimum.

Of all of them, I think, if we bump to 4.7?

Older 4.6 and 4.7 version have the PR55489 bug that we're checking for
in configure, too ("we should be able to delete this at the end of 2013"
:)).  Bumping to 4.8 would let us remove TRANSLATE_OPT_CFLAGS for good.

Paolo

>> We would need an explicit check for clang, however, instead of
>> relying on it claiming gcc 4.2 support - that's a way inaccurate
>> claim anyway so detecting a specific clang version would be
>> better regardless IMHO
> 
> Fine for me if we bump the minimum Clang version to 3.4 ... then we
> could get rid of the the CONFIG_INT128 hacks that we have in various
> parts of the code.
> 
>  Thomas
> 

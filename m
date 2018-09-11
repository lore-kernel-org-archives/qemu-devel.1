Received: from eggs.gnu.org ([2001:4830:134:3::10]:58794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzgmB-0005Ke-ML
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzgm7-000741-1i
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:24:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41888 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fzgm6-00072D-Ms
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:24:06 -0400
References: <20180903171831.15446-1-cota@braap.org>
	<20180903171831.15446-6-cota@braap.org> <87d0tld83i.fsf@linaro.org>
	<20180910123020.GA19941@flamenco>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <606947f7-ee92-ec98-90f5-d41ebe6a64be@redhat.com>
Date: Tue, 11 Sep 2018 13:24:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180910123020.GA19941@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/6] target/i386/translate: use
 thread-local storage in !user-mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 10/09/2018 14:30, Emilio G. Cota wrote:
>> I'm confused - as we can have multi-threaded user space don't the same
>> requirements apply?
> In user-mode, code generation is serialized by mmap_lock.
> Making these per-thread would just waste TLS space.

It's stupid question time!  How can the TLS work?  tcg_x86_init is only
called once, the first time cpu_exec_realizefn is called.

Either they can be kept in non-TLS, or you should move them to DisasContext.

Paolo

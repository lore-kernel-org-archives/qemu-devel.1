Received: from eggs.gnu.org ([2001:4830:134:3::10]:56876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cja1P-0006Sc-3k
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 18:20:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cja1O-0004so-7y
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 18:20:31 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:38895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cja1O-0004sN-1Z
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 18:20:30 -0500
Received: by mail-wm0-x230.google.com with SMTP id t193so3381173wmt.1
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 15:20:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <442ad062-5b45-bea0-3276-0cef76234477@redhat.com>
References: <20170228161402.25122-1-pbonzini@redhat.com>
	<CAFEAcA-yYjQab=g2C8WbP=zAy5q8r6o=z-UHh0Q9NDO3um_OCA@mail.gmail.com>
	<442ad062-5b45-bea0-3276-0cef76234477@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 23:20:08 +0000
Message-ID: <CAFEAcA85Qs9OL=SQNYdNvP_UY2GycLf02EU65=a_25Wd+ZYohg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v4 00/19] KVM and cpu-exec patches for 2.9
 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 March 2017 at 18:01, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 01/03/2017 18:58, Peter Maydell wrote:
>> Fails to build, ppc64, aarch64 (and probably others):
>>
>> In file included from /home/pm215/qemu/include/qemu/osdep.h:36:0,
>>                  from /home/pm215/qemu/kvm-all.c:16:
>> /home/pm215/qemu/kvm-all.c: In function =E2=80=98kvm_cpu_exec=E2=80=99:
>> /home/pm215/qemu/kvm-all.c:1995:22: error: =E2=80=98have_sigbus_pending=
=E2=80=99
>> undeclared (first use in this function)
>>          if (unlikely(have_sigbus_pending)) {
>>                       ^
>> /home/pm215/qemu/include/qemu/compiler.h:66:43: note: in definition of
>> macro =E2=80=98unlikely=E2=80=99
>>  #define unlikely(x)   __builtin_expect(!!(x), 0)
>>                                            ^
>> /home/pm215/qemu/kvm-all.c:1995:22: note: each undeclared identifier
>> is reported only once for each function it appears in
>>          if (unlikely(have_sigbus_pending)) {
>>                       ^
>> /home/pm215/qemu/include/qemu/compiler.h:66:43: note: in definition of
>> macro =E2=80=98unlikely=E2=80=99
>>  #define unlikely(x)   __builtin_expect(!!(x), 0)
>
> Are you sure you updated the tag?

Your cover letter says "changes up to b9a93b6cfd"
but the tag is of commit 0819248. My script always does
a git fetch, so it looks to me like maybe you failed to
push the new tag?

thanks
-- PMM

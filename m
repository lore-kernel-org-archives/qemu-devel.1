Received: from eggs.gnu.org ([2001:4830:134:3::10]:40630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fLFRp-0005v7-Um
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fLFRm-0005ze-OP
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:08:01 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fLFRm-0005zK-IL
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:07:58 -0400
Received: by mail-pl0-f68.google.com with SMTP id m24-v6so328086pls.11
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 15:07:58 -0700 (PDT)
References: <20180522192034.13318-1-pbonzini@redhat.com>
	<CAFEAcA_mU6wvzGCvhv_OvX37QqyNkMdwfM8Kc6swNQK=tCZMYA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <91829340-f17a-1c24-715c-fe0fd6953ebc@redhat.com>
Date: Wed, 23 May 2018 00:07:56 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_mU6wvzGCvhv_OvX37QqyNkMdwfM8Kc6swNQK=tCZMYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg: remove softfloat from --disable-tcg
 builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>

On 22/05/2018 21:27, Peter Maydell wrote:
> On 22 May 2018 at 20:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> Even though the presence of softfloat does not cause --disable-tcg builds to fail,
>> it is the single largest .o file in them.  Remove it, since TCG is the only client.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  Makefile.target          |   2 +-
>>  hw/i386/x86-iommu-stub.c | 132 +++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 133 insertions(+), 1 deletion(-)
>>  create mode 100644 hw/i386/x86-iommu-stub.c
> 
> Is this new x86-iommu-stub.c file intended to be in this patch?

No, of course not.  I probably fat fingered a "r" into "f" in git rebase
-i...

Paolo

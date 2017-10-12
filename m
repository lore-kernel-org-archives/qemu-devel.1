Received: from eggs.gnu.org ([2001:4830:134:3::10]:57191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e2fB0-0007sS-Mc
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e2fAu-00062A-R8
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:13:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e2fAu-00061s-Ka
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:13:28 -0400
References: <1507655662-28101-1-git-send-email-peter.maydell@linaro.org>
	<d56cf809-5f37-2fff-bcb1-80296cf5f33a@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2d38fb05-c496-1cc3-9253-cc01b2ba8a1b@redhat.com>
Date: Thu, 12 Oct 2017 17:13:24 +0200
MIME-Version: 1.0
In-Reply-To: <d56cf809-5f37-2fff-bcb1-80296cf5f33a@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] docs/devel/loads-stores.rst: Document
 our various load and store APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, patches@linaro.org

On 12/10/2017 17:10, Richard Henderson wrote:
> On 10/10/2017 10:14 AM, Peter Maydell wrote:
>> QEMU has a wide selection of different functions for doing
>> loads and stores; provide some overview documentation of
>> what they do and how to pick which one to use.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> Changes v2->v3: fixed the typos noticed by Eric;
>> dropped the note about license in favour of using the
>> default gpl2+. I think this is ready to commit now.
>>
>> Changes v1->v2: filled in most of the gaps thanks to the
>> comments on v1.
>>
>> I have left some TODO markers in where they represent
>> fixes we should ideally make to the API. Since this
>> is for-developers internals documentation I think it's
>> OK to leave those in.
>>
>>  docs/devel/loads-stores.rst | 398 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 398 insertions(+)
>>  create mode 100644 docs/devel/loads-stores.rst
> 
> Modulo the 2 typos that Eric found,
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> What path should this patch take in?

I can take it.

Paolo

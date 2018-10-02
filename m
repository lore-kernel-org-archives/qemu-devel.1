Received: from eggs.gnu.org ([2001:4830:134:3::10]:56339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7KxF-0004VP-37
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7Kx7-0008GE-Ln
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:43:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44537)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7Kx6-0008Dj-Ss
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:43:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id 63-v6so2280012wra.11
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 06:43:02 -0700 (PDT)
References: <20180927211322.16118-1-richard.henderson@linaro.org>
	<CAFEAcA8zsd21+5va-ApormhvSrnZ18Ygs4w=eH9rkRr7nf5inQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5decf44a-2a6b-7ce3-278c-3a93f823721f@redhat.com>
Date: Tue, 2 Oct 2018 15:42:59 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8zsd21+5va-ApormhvSrnZ18Ygs4w=eH9rkRr7nf5inQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/9] target/arm: Rely on id regs instead
 of features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 02/10/2018 14:30, Peter Maydell wrote:
> On 27 September 2018 at 22:13, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> There are more feature bits that could be converted, but I thought
>> I should show the work to this point to get feedback.
>>
>> This is the "v2" as compared to
>> http://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg01849.html
> 
> So having written the code both ways round, which do you think
> works out nicer? (or at least least-worst :-))

Using the *FEATURE*() and FIELD_DP/EX() macros are a great improvement,
the code is more concise, easier to review.

I also appreciate the arm_features enum cleaned, using the previous
macros on ISAR.

I doubt this version works worst, but it definitively looks nicer, thus
less bug-prone.

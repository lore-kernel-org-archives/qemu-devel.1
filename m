Received: from eggs.gnu.org ([2001:4830:134:3::10]:48535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFjFS-0007xi-JF
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:39:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFjFR-0008Mu-Oz
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:39:54 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:36023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFjFR-0008Mj-J8
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:39:53 -0400
Received: by mail-wm0-x229.google.com with SMTP id 7so95278915wmo.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 08:39:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87bmqanz6i.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
References: <1495444679-7736-1-git-send-email-sandipandas1990@gmail.com>
	<87bmqanz6i.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 16:39:31 +0100
Message-ID: <CAFEAcA__bsp5_yJZJr3LBbB_5yuALZ4o5ELXhJo4OO5jjz4G3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH risu v2] ppc64: Fix patterns for rotate
 doubleword instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: Sandipan Das <sandipandas1990@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

On 30 May 2017 at 16:26, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:
> Sandipan Das <sandipandas1990@gmail.com> writes:
>
>> The patterns for the following instructions are fixed:
>>  * Rotate Left Doubleword then Clear Right (rldcr[.])
>>  * Rotate Left Doubleword Immediate then Clear Right (rldicr[.])
>>  * Rotate Left Doubleword Immediate then Mask Insert (rldimi[.])
>>
>> The first instruction has a typo. For the other two instructions,
>> the extended opcodes are incorrect and the shift field 'sha' is
>> absent. Also, the shift field 'sh' should be used in place of the
>> register field 'rb'.
>>
>> Signed-off-by: Sandipan Das <sandipandas1990@gmail.com>
>
> Reviewed-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Thanks; applied to risu master.

-- PMM

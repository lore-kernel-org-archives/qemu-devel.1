Received: from eggs.gnu.org ([2001:4830:134:3::10]:44440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dL0i3-0000by-Ad
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 01:19:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dL0i0-0006BP-5C
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 01:19:15 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1dL0hz-0006BE-VC
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 01:19:12 -0400
Received: by mail-wr0-f194.google.com with SMTP id v104so35938245wrb.0
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 22:19:11 -0700 (PDT)
References: <20170608184944.19406-1-mrolnik@gmail.com>
	<20170608184944.19406-2-mrolnik@gmail.com>
	<bcd25371-e16f-4fe5-6298-f273720cbaad@tuxfamily.org>
	<CAK4993gCQsJKy-nK4NNS=+v3-zLhM8S5iyHnLUmjqHvFMEmzoA@mail.gmail.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <dc686f64-edf2-43df-318d-47b0c839c0e6@tuxfamily.org>
Date: Wed, 14 Jun 2017 07:19:09 +0200
MIME-Version: 1.0
In-Reply-To: <CAK4993gCQsJKy-nK4NNS=+v3-zLhM8S5iyHnLUmjqHvFMEmzoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v19 01/13] target-avr: AVR cores
 support is added.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Rolnik <mrolnik@gmail.com>, Thomas Huth <huth@tuxfamily.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Anichang <anichang@protonmail.ch>

On 13.06.2017 22:32, Michael Rolnik wrote:
> the last version of my patches were done by Richard. Now I just
> reapplied them to the master. 
> Should I have to remove "signed-off-by Richard" ?

OK, if Richard did change to your patches, you should likely keep the
line. But I think you should remove the "Message-Id" line when sending
patches to the list, since that is normally only used by maintainers
when they finally pick up the patches. Otherwise this looks very
confusing (since the new v19 version has a different Message-Id in the
mail header).

 Thomas


> On Tue, Jun 13, 2017 at 11:09 PM, Thomas Huth <huth@tuxfamily.org
> <mailto:huth@tuxfamily.org>> wrote:
> 
>     On 08.06.2017 20:49, Michael Rolnik wrote:
>     >     1. basic CPU structure
>     >     2. registers
>     >     3. no instructions
>     >     4. saving sreg, rampD, rampX, rampY, rampD, eind in HW representation
>     >
>     > Signed-off-by: Michael Rolnik <mrolnik@gmail.com <mailto:mrolnik@gmail.com>>
>     > Message-Id: <1471522070-77598-2-git-send-email-mrolnik@gmail.com
>     <mailto:1471522070-77598-2-git-send-email-mrolnik@gmail.com>>
>     > Signed-off-by: Richard Henderson <rth@twiddle.net <mailto:rth@twiddle.net>>
> 
>     Why is the final "Signed-off-by" by Richard, if the patch has apparently
>     been sent by you, Michael? Something is wrong here with the order...
> 
>      Thomas

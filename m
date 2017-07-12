Received: from eggs.gnu.org ([2001:4830:134:3::10]:36172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVDj0-0000W8-Kw
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVDix-0007iS-HB
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:14:26 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVDix-0007iL-9z
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:14:23 -0400
Received: by mail-wr0-f180.google.com with SMTP id r103so24873736wrb.0
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 02:14:23 -0700 (PDT)
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
	<149942859571.8972.4761014660099212028.stgit@frigg.lan>
	<87h8yialdo.fsf@linaro.org> <87zicaf2t3.fsf@frigg.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87zicaf2t3.fsf@frigg.lan>
Date: Wed, 12 Jul 2017 10:13:20 +0100
Message-ID: <87a84a9fwv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v12 04/27] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>


Lluís Vilanova <vilanova@ac.upc.edu> writes:

> Alex Bennée writes:
>
>> Lluís Vilanova <vilanova@ac.upc.edu> writes:
>
>>> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
<snip>
>>> +
>>> +        translate_block_tcg_check(db);
>>> +    }
>
>> This may be a personal taste thing but having while(true) {} and breaks
>> is harder to follow than do { stuff } while (!done);
>
> I think it is. I prefer to see the loop condition up-front, unless a do-while
> makes the condition logic substantially simpler.

Yes but in this case the condition is "go forever" unless we break (or
goto) out. I'd be happy with the while at the top if it was an actual
condition.

--
Alex Bennée

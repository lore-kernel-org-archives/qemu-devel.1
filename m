Received: from eggs.gnu.org ([2001:4830:134:3::10]:41093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJ3s9-00052H-M6
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 16:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJ3s6-0008Dh-Hb
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 16:17:37 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dJ3s6-0008DX-Cu
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 16:17:34 -0400
Received: by mail-qt0-x241.google.com with SMTP id x58so10736545qtc.2
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 13:17:34 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170607155536.1193-1-rth@twiddle.net>
	<20170607233019.GA29137@flamenco>
	<d1c6bad4-12b4-b697-fca5-dae84864bba0@twiddle.net>
	<20170608174404.GA1767@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d210e5b7-98c9-090d-8766-acbb677942d8@twiddle.net>
Date: Thu, 8 Jun 2017 13:17:29 -0700
MIME-Version: 1.0
In-Reply-To: <20170608174404.GA1767@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/7] tcg: allocate TB structs preceding
 translate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 06/08/2017 10:44 AM, Emilio G. Cota wrote:
> On Thu, Jun 08, 2017 at 09:44:11 -0700, Richard Henderson wrote:
>> On 06/07/2017 04:30 PM, Emilio G. Cota wrote:
>>> On Wed, Jun 07, 2017 at 08:55:29 -0700, Richard Henderson wrote:
>>>> Then I've a few follow-up patches to take advantage of the new TB
>>>> placement for arm platforms.  I've had a look at the asm output for
>>>> ppc64 and s390x, and don't see anything obvious that can be improved.
>>>
>>> Nice! Just tested patches 3-7 with an arm guest image on
>>> x86 and aarch64 hosts:
>>>
>>>    Tested-by: Emilio G. Cota <cota@braap.org>
>>
>> So... you've tested patch 3 then?
>> Patches 4-7 are for an arm host.
> 
> Ha! Yes, sorry for the confusion -- I blindly went by the patch titles'
> "target/arm" prefix; shouldn't they be "tcg/arm"?

Oops, yes indeed.  I'll fix that too for v5.


r~

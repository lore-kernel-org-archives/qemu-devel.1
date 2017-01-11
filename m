Received: from eggs.gnu.org ([2001:4830:134:3::10]:57992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPbA-0004bh-Ob
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:34:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPb9-0006qS-NZ
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:34:20 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:33810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cRPb9-0006qB-Gz
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:34:19 -0500
Received: by mail-lf0-x241.google.com with SMTP id q89so12473150lfi.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 12:34:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5b41ce5e-6b22-bda8-ae46-9f99e78a6e3f@ilande.co.uk>
References: <cover.1478291230.git.atar4qemu@gmail.com>
	<CACXAS8Cz_NaOA9YgFAnKrYryWR=mEb2Ep6aUKP6j85PRJKiq0g@mail.gmail.com>
	<e2e9b38a-ad45-d205-f139-cdefd3212f2b@ilande.co.uk>
	<da86f614-5ba1-5cf9-3083-25dcc8c96956@twiddle.net>
	<5b41ce5e-6b22-bda8-ae46-9f99e78a6e3f@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 11 Jan 2017 21:33:57 +0100
Message-ID: <CACXAS8CNa9nv4iAQTmRAKa74iJfxZrBfOMr=9B2R1DZ654K4aA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v1 00/30] target-sparc: add niagara
 OpenSPARC T1 sun4v emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>

On Wed, Jan 11, 2017 at 6:13 PM, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> On 11/01/17 16:56, Richard Henderson wrote:
>
>> On 12/30/2016 09:35 AM, Mark Cave-Ayland wrote:
>>> On 15/12/16 17:04, Artyom Tarasenko wrote:
>>>
>>>> Ping?
>>>> Richard & Mark, can you please review the patches
>>>> 04, 05, 08, 10, 11,12, 14, 15, 16, 18-23 and 25-28?
>>>>
>>>> Hope I haven't missed anything from the v0 review.
>>>>
>>>> It would be nice to get it into the 2.9 release.
>>>
>>> No objections from me on the v1, although I would like to see the
>>> official documentation updated in qemu-doc.texi perhaps with an example
>>> command line as per the cover letter (maybe a link as to where to
>>> download the PROM?) and the corrected case for Niagara.
>>>
>>> I also suspect that as you've been digging in this area a lot more than
>>> me that you're definitely going to be more of the expert here.
>>>
>>> Can you rebase your branch onto master at github so I can give it a spin
>>> and make sure there aren't any regressions? Other than that I'd like to
>>> see this merged fairly quickly if Richard is happy since my connectivity
>>> will be fairly intermittent after the next couple of weeks.
>>
>> I am fairly happy with the patch set.  The addition of MMU_PHYS_IDX in
>> the meantime makes the rebase non-trivial.  Your assistance in getting
>> the patch set updated would be most appreciated.
>
> Thanks Richard. Artyom, are you able to proceed with the rebase?

Yes. Have just sent the v2, also available here:

https://github.com/artyom-tarasenko/qemu/tree/sun4v-v2

Artyom


-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu

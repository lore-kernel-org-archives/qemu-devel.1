Received: from eggs.gnu.org ([2001:4830:134:3::10]:55883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d31Hx-0002zx-2A
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d31Hs-0008AZ-8u
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:17:57 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:36451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1d31Hs-0008AO-3w
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:17:52 -0400
Received: by mail-io0-x242.google.com with SMTP id x86so53889824ioe.3
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 07:17:52 -0700 (PDT)
In-Reply-To: <CAFEAcA_PUdFS-gPncf9S6ZGyKGdotang=sM1EkE42M7OKTW16w@mail.gmail.com>
References: <BD9E8ECB-EB56-45A9-89A4-C1506319A7BD@gmail.com>
	<CAFEAcA_PUdFS-gPncf9S6ZGyKGdotang=sM1EkE42M7OKTW16w@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2B569456-B4A2-490A-A721-DE16E3B6A1C7@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Tue, 25 Apr 2017 10:17:49 -0400
Subject: Re: [Qemu-devel] [PATCH 3/9] Add risu_reginfo_ppc.c file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


On Apr 25, 2017, at 4:17 AM, Peter Maydell wrote:

> On 25 April 2017 at 04:19, G 3 <programmingkidx@gmail.com> wrote:
>> Add the risu_reginfo_ppc.c file. It handles operations involving  
>> the reginfo
>> structure.
>
>> +    /* check each floating point register */
>> +    for (i = 0; i < NUMBER_OF_FPR; i++) {
>> +        if (r1->fpr[i] != r2->fpr[i]) {
>> +            if (!(isnan(r1->fpr[i]) && isnan(r2->fpr[i]))) {
>> +                if ( fabs(r1->fpr[i] - r2->fpr[i]) < 0.000001) {
>> +                    debug_print("float point register %d mismatch
>> detected\n", i);
>> +                    return 0;
>> +                }
>
> This is definitely wrong. Risu is supposed to check for exact
> binary correctness, so you simply want to compare the binary
> values of the FP regs, not check whether they're vaguely
> close to the right answer.

Remove the isnan and fabs lines?


>> +/*
>> + * Shows the classification of a floating point value.
>> + * Input: floating point value
>> + * Output: string description
>> + */
>> +const char *show_classification(double x) {
>> +    switch(fpclassify(x)) {
>> +        case FP_INFINITE:  return "Inf";
>> +        case FP_NAN:       return "NaN";
>> +        case FP_NORMAL:    return "normal";
>> +        case FP_SUBNORMAL: return "subnormal";
>> +        case FP_ZERO:      return "zero";
>> +        default:           return "unknown";
>> +    }
>> +}
>
> None of the other backends do this. If we want to do it
> (and I'm not convinced it's worth the effort) we should
> do it consistently everywhere.

It does help with understanding what is different with two floating  
point values. But if you don't want it removing it is fine with me.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS5fP-0001YM-HO
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 14:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS5fM-000553-FX
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 14:01:47 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS5fM-00054r-Ax
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 14:01:44 -0400
Received: by mail-qk0-x242.google.com with SMTP id 16so24878385qkg.2
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 11:01:44 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAFEAcA_OcQY1V16Vi8Ld1iZprPUsq+OCML0udYzLhVToCUXt_g@mail.gmail.com>
	<24d9856c-dd4e-70d1-5eaf-3f36e70fad72@twiddle.net>
	<CAFEAcA_QfLHR1dFQphS5DzjnekUACq=DOGKaqaeQgM_XpouLjw@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0d564da7-7208-e975-d546-e5683e8914f5@twiddle.net>
Date: Mon, 3 Jul 2017 11:01:38 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_QfLHR1dFQphS5DzjnekUACq=DOGKaqaeQgM_XpouLjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] handling emulation fine-grained memory protection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 07/03/2017 09:40 AM, Peter Maydell wrote:
>> Since these are defined by system registers, I can imagine there can only be
>> a few pages for which this fine grained handling might apply any any one
>> time. This would certainly be preferable to reducing the effectiveness of
>> the entire TLB by a factor of 16.
> 
> Yes, that was somewhat my feeling too -- really tiny TLB pages
> are not very nice, and most pages probably won't be finegrained.

Coming back to this, might it make sense to choose a *larger* page size for M 
profile?  1K is awfully small.  Any idea how aligned the region start/end tends 
to be for real applications?

If we're only taking this extra trap for the first and last page of a region, 
when the application happens to use a size/alignment that conflicts with the 
page size that we choose, then a much larger page size choice might perform 
well overall.


r~

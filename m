Received: from eggs.gnu.org ([2001:4830:134:3::10]:34757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPBmK-00066a-5y
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:33:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPBjK-0005ym-TW
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:30:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPBjI-0005wI-Vb
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:30:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id u9-v6so3227963wrr.0
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 11:30:36 -0800 (PST)
References: <20181115192446.17187-1-minyard@acm.org>
	<20181115192446.17187-2-minyard@acm.org>
	<8add8514-f353-b914-78e8-e9f3e9be840d@redhat.com>
	<c0c4051d-fe57-7399-9904-65425c6efc26@acm.org>
	<CAFEAcA_Ubfuf-w66JJcPT+nWFFw-aa+Wfdm1ocGHf+VCSM_-qQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1f31e8e0-cde2-db7a-56ae-26eb70bb13d9@redhat.com>
Date: Tue, 20 Nov 2018 20:30:33 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Ubfuf-w66JJcPT+nWFFw-aa+Wfdm1ocGHf+VCSM_-qQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 01/12] i2c: Split smbus into parts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <minyard@acm.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Corey Minyard <cminyard@mvista.com>

On 20/11/18 16:47, Peter Maydell wrote:
> On 16 November 2018 at 13:20, Corey Minyard <minyard@acm.org> wrote:
>> On 11/15/18 4:22 PM, Philippe Mathieu-Daudé wrote:
>>>> --- /dev/null
>>>> +++ b/include/hw/i2c/smbus_eeprom.h
>>>> @@ -0,0 +1,11 @@
>>>
>>>
>>> You missed the copyright notice here.
>>
>>
>> Other files don't have copyright notices (i2c.h, for instance), and for
>> the smbus.[ch] case the copyrights are kind of mixed up, the include
>> files had the big header with a copyright by one company and the C
>> file had a different copyright notice by a different company.
>>
>> Not a huge deal, but I didn't include it in that file because I didn't
>> think it was necessary.  I'm wondering if it would be best to
>> establish a style like Linux has, with the // SPDX... thing on the
>> first line.
> 
> Yeah, we have some legacy files with no copyright notice, but we
> usually try to avoid that for new files. New files should have
> a copyright notice and a license statement. (If you copied from
> a file without a license statement, LICENSE says that means
> 2-or-later.)
> 
> We don't yet use SPDX headers. (They're just a different and
> shorter way to write the license statement.)

Does that mean we can use them, or you rather prefer we don't?

While they are machine parseable, I find them easier to understand than 
the big chunk of legal text that sometime are not correctly written.

Thanks,

Phil.

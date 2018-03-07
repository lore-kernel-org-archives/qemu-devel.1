Received: from eggs.gnu.org ([2001:4830:134:3::10]:48767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etfeW-0001hB-05
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 15:27:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etfeR-0005JI-2R
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 15:27:08 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:50514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etfeQ-0005IT-Qz
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 15:27:02 -0500
Received: by mail-wm0-x241.google.com with SMTP id w128so7289846wmw.0
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 12:27:02 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1517729303-32043-1-git-send-email-whois.zihan.yang@gmail.com>
	<CAKwiv-h4HJkt3QM-dakH54CY_1wgDkGtt5+wTQg396TdH_CUXw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <487a4895-e076-e7f5-0f05-fafbd1c435fe@amsat.org>
Date: Wed, 7 Mar 2018 17:27:01 -0300
MIME-Version: 1.0
In-Reply-To: <CAKwiv-h4HJkt3QM-dakH54CY_1wgDkGtt5+wTQg396TdH_CUXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] vmmouse: convert qdev pointer property
 to QOM link relationship
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org

Hi Zihan Yang,

On 03/07/2018 01:55 PM, Zihan Yang wrote:
>  Hi all, this is a bitesized patch from me a while ago, it seems a little
> old but I wonder if there is any opinion about it? Is it still valid?

For a single TYPE use, I'm not sure use a specific header is useful
(patch #1).
The 2nd patch looks valid to me but I'm not a QOM link expert.

> 
> Thanks.
> 
> 2018-02-04 15:28 GMT+08:00 Zihan Yang <whois.zihan.yang@gmail.com>:
> 
>> The ps2_mouse property of vmmouse is still pointer type which
>> is defined by DEFINE_PROP_PTR. But qdev pointer property should
>> be avoided according to qdev-properties.h. Convert it to
>> QOM link relationship.
>>
>> It involves two patches because it requires the TYPE_I8042
>> macro which is defined in another file. The first patch put
>> this macro into a single header file so that the macro can
>> be used elsewhere. The second patch does the actual work.
>>
>> Zihan Yang (2):
>>   hw/input/pckdb: put TYPE_I8042 into a single header file
>>   vmmouse: change qdev pointer property to qom link
>>
>>  hw/i386/pc.c      |  2 +-
>>  hw/i386/vmmouse.c | 19 ++++++++++++-------
>>  hw/input/pckbd.c  |  2 +-
>>  hw/input/pckbd.h  |  6 ++++++
>>  4 files changed, 20 insertions(+), 9 deletions(-)
>>  create mode 100644 hw/input/pckbd.h
>>
>> --
>> 2.7.4
>>
>>

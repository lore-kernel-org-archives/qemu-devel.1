Received: from eggs.gnu.org ([2001:4830:134:3::10]:38872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gF1bs-0000YL-Va
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 14:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gF1bp-00012U-R4
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 14:40:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gF1bn-00010Z-Vk
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 14:40:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id r10-v6so1923205wrv.6
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 11:40:51 -0700 (PDT)
References: <20181023120454.28553-1-richard.henderson@linaro.org>
	<20181023120454.28553-2-richard.henderson@linaro.org>
	<2eb3d12f-1a2b-8194-e1a4-cfd6396f3aa5@redhat.com>
	<fc2e13a8-ee93-9a73-1c19-d9ff6576f793@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c58275c6-93b0-e0dd-8a66-6b07f8f40f54@redhat.com>
Date: Tue, 23 Oct 2018 20:40:48 +0200
MIME-Version: 1.0
In-Reply-To: <fc2e13a8-ee93-9a73-1c19-d9ff6576f793@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/7] decodetree: Add !extern flag to
 argument sets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, palmer@sifive.com, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, mjc@sifive.com

On 23/10/18 15:54, Richard Henderson wrote:
> On 10/23/18 2:27 PM, Philippe Mathieu-Daudé wrote:
>>> +        if re_fullmatch('!extern', t):
>>> +            extern = True
>>
>> It looks odd to match a negative form then use a positive one.
>>
>> Why not simply use 'extern'?
> 
> "!" is an escape character here.
> Just "escape" would be a field named "escape".
> 
> It follows existing similar syntax for !function=foo

Oh OK!

Thanks,

Phil.

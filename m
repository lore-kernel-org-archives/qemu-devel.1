Received: from eggs.gnu.org ([2001:4830:134:3::10]:41423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTY3u-0002oV-4p
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTY2q-00017U-5M
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:37:38 -0400
Received: from mail-pl0-x22a.google.com ([2607:f8b0:400e:c01::22a]:36928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTY2p-00015p-Iz
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:36:31 -0400
Received: by mail-pl0-x22a.google.com with SMTP id 31-v6so4080667plc.4
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 12:36:31 -0700 (PDT)
References: <1526945967-9687-1-git-send-email-cota@braap.org>
	<ff49bf54-3d5c-c2a4-95cd-3cb8c2efab51@linaro.org>
	<ada5eac5-eceb-b330-6f12-ac6e9c58268d@linaro.org>
	<20180602002905.GA19122@flamenco> <87vab1zip9.fsf@linaro.org>
	<87r2l9z074.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bc39e100-30ae-ba09-f011-e30083c2c749@linaro.org>
Date: Thu, 14 Jun 2018 09:36:26 -1000
MIME-Version: 1.0
In-Reply-To: <87r2l9z074.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 00/17] tcg: tb_lock removal redux v3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 06/14/2018 08:34 AM, Alex Bennée wrote:
>>> You can fetch v4 from:
>>>   https://github.com/cota/qemu/tree/tb-lock-removal-redux-v4
>>
>> I've just spun up v4 and it still works on aarch64 and now also passes
>> the coldfire test rich passed me. So have a:
>>
>> Tested-by: Alex Bennée <alex.bennee@linaro.org>
>>
>> For those two.
> 
> Ping, Richard are you happy with the fix?

Yes; just sent a PR including v4.  It survived a couple of overnight
stress-tests.  I did miss your T-B from this thread though; whoops.


r~

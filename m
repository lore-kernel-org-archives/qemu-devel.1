Received: from eggs.gnu.org ([2001:4830:134:3::10]:40124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1co7Zn-0003J5-5l
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:58:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1co7Zm-0000j6-AX
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:58:47 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:34714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1co7Zm-0000io-4N
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:58:46 -0400
Received: by mail-wm0-x229.google.com with SMTP id 196so18539656wmm.1
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 04:58:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7d1e7414-1194-2d81-1058-62b6313b625e@redhat.com>
References: <20170315081641.20588-1-pbonzini@redhat.com>
	<7d1e7414-1194-2d81-1058-62b6313b625e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Mar 2017 11:58:24 +0000
Message-ID: <CAFEAcA8GCnA8ri1KEiCjmcjxPUTQtih9u0DT10NLjtZ9=Zx_vA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] coverity-model: model
 address_space_read/write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 15 March 2017 at 11:55, Eric Blake <eblake@redhat.com> wrote:
> On 03/15/2017 03:16 AM, Paolo Bonzini wrote:
>> -MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
>> -                             uint8_t *buf, int len, bool is_write)
>> +MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
>> +                               MemTxAttrs attrs,
>> +                               uint8_t *buf, int len)
>>  {
>>      MemTxResult result;
>> -
>>      // TODO: investigate impact of treating reads as producing
>>      // tainted data, with __coverity_tainted_data_argument__(buf).
>> -    if (is_write) __bufread(buf, len); else __bufwrite(buf, len);
>
> Old code did __bufread for reads,

Eh? for a read is_write is false, and we use the else clause,
which is __bufwrite...

thanks
-- PMM

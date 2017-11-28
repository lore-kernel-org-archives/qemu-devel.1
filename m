Received: from eggs.gnu.org ([2001:4830:134:3::10]:46892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJbls-0000ms-6r
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 04:01:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJblm-0008SB-Hd
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 04:01:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eJblm-0008Rj-C7
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 04:01:34 -0500
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
	<151127326409.6888.9209413226035587910.stgit@Misha-PC.lan02.inno>
	<CABdb7372q-LntFhkDuurfWi2JakzZCM9xVxkEA=cqYMbKv_jGw@mail.gmail.com>
	<CAFEAcA9Db5hB95KqZEjWgEhkX_gWZ+Za40B1hhbKQ5mop-WgbQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ba2ccf99-43f1-49ba-5fb8-3a3882477cea@redhat.com>
Date: Tue, 28 Nov 2017 10:01:26 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Db5hB95KqZEjWgEhkX_gWZ+Za40B1hhbKQ5mop-WgbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 05/45] windbg: added helper features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Ladi Prosek <lprosek@redhat.com>
Cc: Mihail Abakumov <mikhail.abakumov@ispras.ru>, Stefan Weil <sw@weilnetz.de>, qemu-devel <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Roman Kagan <rkagan@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>

On 28/11/2017 09:34, Peter Maydell wrote:
>>  #define FMT_ERR  "Error:%d"
>>
>>  #define UINT8_P(ptr) ((uint8_t *) (ptr))
>> -#define UINT32_P(ptr) ((uint32_t *) (ptr))
>> +#define UINT32_P(ptr) ((uint32_t *) (size_t) (ptr))
>>  #define PTR(var) UINT8_P(&var)
> Hiding casts behind macros like this doesn't seem worthwhile
> to me anyway -- all it's doing is obscuring what's going on.
> And casting an arbitrary pointer to a uint32_t* is somewhat
> alarming -- the alignment requirements may not be met.
> Chances are high that code using that macro is not correct.

And also, we already have ldb_p and ldl_*_p that do exactly what you
want (and give you an opportunity to specify the intended endianness,
probably little-endian).

Thanks,

Paolo

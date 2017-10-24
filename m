Received: from eggs.gnu.org ([2001:4830:134:3::10]:38762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6poa-0002Zm-LV
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 23:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6poX-0000db-Ib
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 23:23:40 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:47454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6poX-0000dL-De
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 23:23:37 -0400
Received: by mail-qt0-x22d.google.com with SMTP id z50so28780244qtj.4
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 20:23:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171020232023.15010-1-richard.henderson@linaro.org>
	<20171020232023.15010-22-richard.henderson@linaro.org>
	<20171023173709.GF6901@flamenco>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4af64099-78dd-f46e-cf95-50c851c2a564@amsat.org>
Date: Tue, 24 Oct 2017 00:23:34 -0300
MIME-Version: 1.0
In-Reply-To: <20171023173709.GF6901@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 21/52] tcg: Use offsets not indices for
 TCGv_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On 10/23/2017 02:37 PM, Emilio G. Cota wrote:
> On Fri, Oct 20, 2017 at 16:19:52 -0700, Richard Henderson wrote:
>> Using the offset of a temporary, relative to TCGContext, rather than
>> its index means that we don't use 0.  That leaves offset 0 free for
>> a NULL representation without having to leave index 0 unused.
[...]
>>  /* used to align parameters */
>> -#define TCG_CALL_DUMMY_ARG      ((TCGArg)(-1))
>> +#define TCG_CALL_DUMMY_ARG      ((TCGArg)0)
> 
> We're doing something clever here (on a first read I thought TCGContext
> was a typo), so I'd leave a comment somewhere. TCG_CALL_DUMMY_ARG might
> be a good place to do so; a copy of the commit's message should suffice.

agreed.

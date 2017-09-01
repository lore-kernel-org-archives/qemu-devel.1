Received: from eggs.gnu.org ([2001:4830:134:3::10]:36500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnoVO-0004XE-PL
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 12:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnoVK-0000bL-3l
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 12:09:14 -0400
Received: from mail-qk0-x236.google.com ([2607:f8b0:400d:c09::236]:33512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnoVJ-0000b6-VP
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 12:09:10 -0400
Received: by mail-qk0-x236.google.com with SMTP id l65so2952466qkc.0
	for <qemu-devel@nongnu.org>; Fri, 01 Sep 2017 09:09:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170830225225.27925-1-f4bug@amsat.org>
	<20170901151850.GD17184@localhost.localdomain>
	<e5407d61-b21c-8ff5-1051-f75a6221e222@amsat.org>
	<20170901154850.GP7570@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e8c0ae1e-e157-35a9-fe71-8eb5b44f8178@amsat.org>
Date: Fri, 1 Sep 2017 13:09:05 -0300
MIME-Version: 1.0
In-Reply-To: <20170901154850.GP7570@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/7] QOMify MIPS cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>

On 09/01/2017 12:48 PM, Eduardo Habkost wrote:
> On Fri, Sep 01, 2017 at 12:44:42PM -0300, Philippe Mathieu-Daudé wrote:
>> On 09/01/2017 12:18 PM, Eduardo Habkost wrote:
>>> On Wed, Aug 30, 2017 at 07:52:18PM -0300, Philippe Mathieu-Daudé wrote:
>>>> Hi,
>>>>
>>>> This series is based on Igor's "complete cpu QOMification" [1] but only modify
>>>> the MIPS part. Igor posted an updated series [2], both series should apply
>>>> separately.
>>>>
>>>> Igor suggested on IRC this series could enter via the Machine core tree, so
>>>> I added Eduardo and Marcel.
>>>
>>> I would do that only if the MIPS maintainers (CCed) aren't
>>> willing to merge the series themselves.
>>
>> Aurelien told me he looked at the series but isn't comfortable with
>> reviewing QOM code. Anyway since all patches are reviewed/tested and this is
>> MIPS only series it also makes sens to me this enters via their tree.
>>
>> Eduardo can you Ack this series from the QOM part to help Aurelien?
> 
> Absolutely:
> 
> Acked-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> I will try to review the QOM code more closely and send
> Reviewed-by lines too.

Thank you!

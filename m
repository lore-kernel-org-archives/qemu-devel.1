Received: from eggs.gnu.org ([2001:4830:134:3::10]:33061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dr6GZ-0002pJ-CP
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 13:43:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dr6GW-00030q-9i
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 13:43:31 -0400
Received: from mail-qt0-x229.google.com ([2607:f8b0:400d:c0d::229]:34401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dr6GW-00030j-52
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 13:43:28 -0400
Received: by mail-qt0-x229.google.com with SMTP id m35so15360605qte.1
	for <qemu-devel@nongnu.org>; Sun, 10 Sep 2017 10:43:28 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170830225225.27925-1-f4bug@amsat.org>
	<20170901151850.GD17184@localhost.localdomain>
	<e5407d61-b21c-8ff5-1051-f75a6221e222@amsat.org>
	<20170901154850.GP7570@localhost.localdomain>
	<e8c0ae1e-e157-35a9-fe71-8eb5b44f8178@amsat.org>
	<5d7f7453-1303-7879-5437-73a79f2f0033@imgtec.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e2422a4d-4c00-6498-d1c8-725a6bdf399b@amsat.org>
Date: Sun, 10 Sep 2017 14:43:22 -0300
MIME-Version: 1.0
In-Reply-To: <5d7f7453-1303-7879-5437-73a79f2f0033@imgtec.com>
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
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

Hi Eduardo,

>>>>> On Wed, Aug 30, 2017 at 07:52:18PM -0300, Philippe Mathieu-Daudé wrote:
>>>>>> Hi,
>>>>>>
>>>>>> This series is based on Igor's "complete cpu QOMification" [1] but
>>>>>> only modify
>>>>>> the MIPS part. Igor posted an updated series [2], both series should
>>>>>> apply
>>>>>> separately.
>>>>>>
>>>>>> Igor suggested on IRC this series could enter via the Machine core
>>>>>> tree, so
>>>>>> I added Eduardo and Marcel.
>>>>>
>>>>> I would do that only if the MIPS maintainers (CCed) aren't
>>>>> willing to merge the series themselves.
>>>>
>>>> Aurelien told me he looked at the series but isn't comfortable with
>>>> reviewing QOM code. Anyway since all patches are reviewed/tested and
>>>> this is
>>>> MIPS only series it also makes sens to me this enters via their tree.
>>>>
>>>> Eduardo can you Ack this series from the QOM part to help Aurelien?
>>>
>>> Absolutely:
>>>
>>> Acked-by: Eduardo Habkost <ehabkost@redhat.com>
>>>
>>> I will try to review the QOM code more closely and send
>>> Reviewed-by lines too.

This series with your Acked-by tag is available for you to review at:

   git://github.com/philmd/qemu.git tags/mips-qomify-20170910

Regards,

Phil.

>>
>> Thank you!
>>
> 
> I can take the series too. Please carry on reviewing.
> 
> Regards,
> Yongbok
> 

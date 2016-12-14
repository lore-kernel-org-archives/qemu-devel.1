Received: from eggs.gnu.org ([2001:4830:134:3::10]:47149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cHCFy-0003QW-22
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:18:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cHCFt-00067f-3f
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:18:14 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:54048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cHCFs-000678-PI
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:18:09 -0500
References: <20161214144713.11009-1-stefanha@redhat.com>
	<22da7375-6a66-0340-4208-b4d04b5ce49f@vivier.eu>
	<CAJSP0QW-zPDGrFoyE3XLd-SNKt261+AJPS5k1jxZyr8jNkvxXA@mail.gmail.com>
	<20161214160827.GA3872@noname.str.redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <3e1011ab-37bf-b244-11e5-9fd8df6678ce@vivier.eu>
Date: Wed, 14 Dec 2016 17:17:57 +0100
MIME-Version: 1.0
In-Reply-To: <20161214160827.GA3872@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.8] po: add missing translations in de, fr, it,
 zh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Pino Toscano <ptoscano@redhat.com>

Le 14/12/2016 à 17:08, Kevin Wolf a écrit :
> Am 14.12.2016 um 16:58 hat Stefan Hajnoczi geschrieben:
>> On Wed, Dec 14, 2016 at 3:41 PM, Laurent Vivier <laurent@vivier.eu> wrote:
>>> Le 14/12/2016 à 15:47, Stefan Hajnoczi a écrit :
>>>> There are missing translations for the new "Copy" menu item.
>>>>
>>>> The following people provided them to me on IRC just in time for the
>>>> QEMU 2.8 release:
>>>>
>>>>  * de_DE - Stefan Hajnoczi <stefanha@redhat.com>
>>>>  * fr_FR - Laurent Vivier <laurent@vivier.eu>
>>>>  * it    - Pino Toscano <ptoscano@redhat.com>
>>>>  * zh_CN - Fam Zheng <famz@redhat.com>
>>>>
>>>> Reported-by: Kevin Wolf <kwolf@redhat.com>
>>>> Cc: Fam Zheng <famz@redhat.com>
>>>> Cc: Pino Toscano <ptoscano@redhat.com>
>>>> Cc: Laurent Vivier <laurent@vivier.eu>
>>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>
>>> "Copier" is OK now, but it seems we have some problems with the accents.
>>> I don't know why.
>>
>> It could be an email encoding issue.  On disk I see the proper UTF-8 characters.
>>
>> You could try my git branch to avoid email issues:
>> https://github.com/stefanha/qemu/tree/missing-translations-2.8
> 
> IIRC, it's actually a known problem with not consistently using a UTF-8
> locale, and we avoid changing some locale categories because that would
> break things like floating point representation in JSON (because printf
> might end up using comma as the decimal separator).

So the translation like the Chinese one is totally unusable?

Laurent

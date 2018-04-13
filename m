Received: from eggs.gnu.org ([2001:4830:134:3::10]:59566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f6vZG-0007tG-Gw
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 06:04:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f6vZD-00029v-Da
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 06:04:30 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1f6vZD-00026Q-9F
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 06:04:27 -0400
Received: by mail-io0-f194.google.com with SMTP id 141so9588701iou.12
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 03:04:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87d0z37esf.fsf@dusky.pond.sub.org>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
	<1521515720-612046-22-git-send-email-mst@redhat.com>
	<87d0z37esf.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Apr 2018 12:04:20 +0200
Message-ID: <CAMxuvazEKdmo=AMw0cXGMqvjMsXMxG2121hyDytOZYZ13j1PcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 21/50] Makefile: add target to print
 generated files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

Hi

On Fri, Apr 13, 2018 at 9:21 AM, Markus Armbruster <armbru@redhat.com> wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
>
>> This is helpful for automatic code analysis.
>
> Out of curiosity: how?
>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>  Makefile | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Makefile b/Makefile
>> index 677a54b..f799390 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1045,6 +1045,9 @@ endif
>>  include $(SRC_PATH)/tests/docker/Makefile.include
>>  include $(SRC_PATH)/tests/vm/Makefile.include
>>
>> +printgen:
>> +     @echo $(GENERATED_FILES)
>> +
>>  .PHONY: help
>>  help:
>>       @echo  'Generic targets:'
>
> I tried to answer my question myself by looking up the thread where this
> patch was posted for review.  I can't find any.  Am I blind?

And you could also "make print-GENERATED_FILES" already

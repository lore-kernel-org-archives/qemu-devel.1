Received: from eggs.gnu.org ([209.51.188.92]:50269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDoAs-0005CK-Uq
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDoAo-000372-4G
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:40:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDoAl-00036n-MB
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:40:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so4611956wrn.11
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 03:40:11 -0700 (PDT)
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-4-armbru@redhat.com>
	<CAMxuvayc+RnpmFpUVFaLW2Uh8y6bZo2N4o6wu6YVyE1XRHtdWg@mail.gmail.com>
	<87bm1gr83k.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1f1ab942-49e9-0714-c6bc-65c7a0c4fa27@redhat.com>
Date: Tue, 9 Apr 2019 12:40:03 +0200
MIME-Version: 1.0
In-Reply-To: <87bm1gr83k.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/15] char-pty: Drop "char device
 redirected to" message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 4/8/19 2:31 PM, Markus Armbruster wrote:
> Marc-André Lureau <marcandre.lureau@redhat.com> writes:
> 
>> Hi
>>
>> On Mon, Apr 8, 2019 at 10:36 AM Markus Armbruster <armbru@redhat.com> wrote:
>>>
>>> char_pty_open() prints a "char device redirected to PTY_NAME (label
>>> LABEL)" message to the current monitor or else to stderr.  No other
>>> ChardevClass::open() prints anything on success.  Drop the message.
>>>
>>> Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  chardev/char-pty.c | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>
>> I guess that was printed for convenience.
>>
>> Allocated pty can be read from "info chardev", so I suppose we can
>> make qemu more silent. Fine with me:
>>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Thanks!
> 
> If we should decide the message is still useful enough to be worth
> keeping, I could direct it to stdout instead of dropping it.

I prefer this, if Marc-André is still OK.

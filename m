Received: from eggs.gnu.org ([2001:4830:134:3::10]:45244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fakla-0000uG-Tr
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 12:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faklX-0001ok-I3
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 12:36:30 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faklX-0001oT-Ck
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 12:36:27 -0400
Received: by mail-qk0-x242.google.com with SMTP id c131-v6so3129170qkb.0
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 09:36:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180704143014.8670-1-f4bug@amsat.org>
	<87va9v80ut.fsf@linaro.org> <20180704154831.GM32267@redhat.com>
	<87tvpf7yzm.fsf@linaro.org> <20180704162632.GQ32267@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f76292dc-8684-73f9-6295-42fa60a6dbe6@amsat.org>
Date: Wed, 4 Jul 2018 13:36:22 -0300
MIME-Version: 1.0
In-Reply-To: <20180704162632.GQ32267@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] configure: Do not display host compilers
 as cross-compilers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

On 07/04/2018 01:26 PM, Daniel P. Berrangé wrote:
> On Wed, Jul 04, 2018 at 05:21:49PM +0100, Alex Bennée wrote:
>>
>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>
>>> On Wed, Jul 04, 2018 at 04:41:30PM +0100, Alex Bennée wrote:
>>>>
>>>> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>>>>
>>>>> This silent (since d75402b5ee2):
>>>>>
>>>>>   ./configure
>>>>>   [...]
>>>>>   NOTE: cross-compilers enabled:  'cc'
>>>>>
>>>>> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>>> Reported-by: Daniel P. Berrangé <berrange@redhat.com>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>>> ---
>>>>>  configure | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/configure b/configure
>>>>> index b99ebdde24..fbb53ab6bb 100755
>>>>> --- a/configure
>>>>> +++ b/configure
>>>>> @@ -7328,7 +7328,7 @@ echo "QEMU_CFLAGS+=$cflags" >> $config_target_mak
>>>>>
>>>>>  done # for target in $targets
>>>>>
>>>>> -if test -n "$enabled_cross_compilers"; then
>>>>> +if test -n "$target_compiler" -a -n "$enabled_cross_compilers"; then
>>>>>      echo
>>>>>      echo "NOTE: cross-compilers enabled: $enabled_cross_compilers"
>>>>>  fi
>>>>
>>>> I had also added:
>>>>
>>>> -    echo "NOTE: cross-compilers enabled: $enabled_cross_compilers"
>>>> +    echo "NOTE: compilers enabled for TCG tests: $enabled_cross_compilers"[
>>>>
>>>> to make things clearer.
>>>
>>> I think we should also 's/NOTE: //', because everything printed by
>>> configure at the end is a note. Also get rid of the extra blank
>>> line before it.
>>
>> *shrugs* I made the original decision because:
>>
>> WARNING: Use of SDL 1.2 is deprecated and will be removed in
>> WARNING: future releases. Please switch to using SDL 2.0
>> compilers enabled for TCG tests:  'aarch64-linux-gnu-gcc' 'arm-linux-gnueabihf-gcc' 'cc' 'aarch64-linux-gnu-gcc' 'arm-linux-gnueabihf-gcc' 'cc'
>>
>> offended my eye, but I'm happy either way really.
> 
> Oh, I see - can we move the print out before the WARNING, as
> those warnings were intended to be the last thing that was
> printed. All the feature summaries were supposed to come first.

I think this is the cleaner thing to do (warnings last).

Lemme change that and respin.

> 
> IIRC, we'll be able to delete the SDL/GTK deprecation messages
> when 3.1 opens anyway, because they'll have been present for
> both 2.12 and 3.0 already.
> 
> Regards,
> Daniel
> 

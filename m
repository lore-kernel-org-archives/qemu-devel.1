Received: from eggs.gnu.org ([2001:4830:134:3::10]:53254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnohg-0000bg-OU
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnohf-0007rH-Sb
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:49:40 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnohf-0007r2-M0
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:49:39 -0400
Received: by mail-wm0-x231.google.com with SMTP id n11so67321307wma.1
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 08:49:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Y5k_GNFw+ZgaY09tLTc0V=9FZLRGY-uDZHVMY_SoPxQ@mail.gmail.com>
References: <0C9DA454-E3DC-4291-806E-9A96557DE833@gmail.com>
	<CAFEAcA8Y5k_GNFw+ZgaY09tLTc0V=9FZLRGY-uDZHVMY_SoPxQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Mar 2017 16:49:17 +0100
Message-ID: <CAFEAcA_K+FcLeA-aG64mUT7a5yk47TCtj9Db3m7W+q-7O87khQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa.m: add toast file support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

On 6 January 2017 at 14:45, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 30 December 2016 at 20:42, Programmingkid <programmingkidx@gmail.com> wrote:
>> Add the ability for the user to use .toast files with QEMU. This format works
>> just like ISO files.
>>
>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>> ---
>>  ui/cocoa.m | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/ui/cocoa.m b/ui/cocoa.m
>> index 26d4a1c..c81f7b6 100644
>> --- a/ui/cocoa.m
>> +++ b/ui/cocoa.m
>> @@ -879,7 +879,7 @@ QemuCocoaView *cocoaView;
>>          // set the supported image file types that can be opened
>>          supportedImageFileTypes = [NSArray arrayWithObjects: @"img", @"iso", @"dmg",
>>                                   @"qcow", @"qcow2", @"cloop", @"vmdk", @"cdr",
>> -                                  nil];
>> +                                  @"toast", nil];
>>          [self make_about_window];
>>      }
>>      return self;
>> --
>
> Applied to cocoa.next, thanks.

...and now applied to master; sorry, I forgot I had a patch
pending in my cocoa queue.

thanks
-- PMM

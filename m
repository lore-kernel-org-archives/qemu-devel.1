Received: from eggs.gnu.org ([2001:4830:134:3::10]:56808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIGYv-0006s3-Jk
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIGYu-0005O8-So
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:38:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dIGYu-0005Nb-MT
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:38:28 -0400
References: <20170606151919.772-1-pbonzini@redhat.com>
	<CAFEAcA-ZHmWeJ_a7seQ6OxcssVYZ1UEUe9Y6LtYu54PFGEEL7g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <893e46f6-b5b3-70fe-0e23-e46df350b361@redhat.com>
Date: Tue, 6 Jun 2017 17:38:24 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ZHmWeJ_a7seQ6OxcssVYZ1UEUe9Y6LtYu54PFGEEL7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: include version number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>



On 06/06/2017 17:25, Peter Maydell wrote:
> On 6 June 2017 at 16:19, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  qemu-doc.texi | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/qemu-doc.texi b/qemu-doc.texi
>> index 965ba5929e..8e5c4a951f 100644
>> --- a/qemu-doc.texi
>> +++ b/qemu-doc.texi
>> @@ -1,6 +1,7 @@
>>  \input texinfo @c -*- texinfo -*-
>>  @c %**start of header
>>  @setfilename qemu-doc.info
>> +@include version.texi
>>
>>  @documentlanguage en
>>  @documentencoding UTF-8
>> @@ -19,7 +20,7 @@
>>  @iftex
>>  @titlepage
>>  @sp 7
>> -@center @titlefont{QEMU Emulator}
>> +@center @titlefont{QEMU version @value{VERSION}}
>>  @sp 1
>>  @center @titlefont{User Documentation}
>>  @sp 3
>> --
>> 2.13.0
> 
> I think you also now need to make the qemu-doc.* files depend
> on version.texi (as we do already for qemu-ga-ref.* and qemu-qmp-ref.*)
> (If we plan to make the other docs also use version.texi, this
> might be best done by reverting some of commit bd7f97479687.)

Indeed, so I'll make a two-patch series with this and  "docs: create
interop/ subdirectory".

Paolo

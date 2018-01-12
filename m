Received: from eggs.gnu.org ([2001:4830:134:3::10]:42235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZxZT-00089v-R3
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZxZP-00067Z-Nf
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:27 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:34847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZxZP-00066Y-IU
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:23 -0500
Received: by mail-wr0-f173.google.com with SMTP id g38so1844127wrd.2
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:32:23 -0800 (PST)
References: <1515755504-21341-1-git-send-email-pbonzini@redhat.com>
	<9da34f89-3866-bbae-636e-bf26a74cc4ff@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ab39ffe-57a3-5b7e-39f8-d6e062f027bf@redhat.com>
Date: Fri, 12 Jan 2018 12:32:19 +0100
MIME-Version: 1.0
In-Reply-To: <9da34f89-3866-bbae-636e-bf26a74cc4ff@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] docker: change Fedora base image to
 fedora:27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Fam Zheng <famz@redhat.com>

On 12/01/2018 12:28, Philippe Mathieu-Daudé wrote:
> Hi Paolo,
> 
> On 01/12/2018 08:11 AM, Paolo Bonzini wrote:
>> Using "fedora:latest" makes behavior different depending on when you
>> actually pulled the image from the docker repository.  In my case,
>> the supposedly "latest" image was a Fedora 25 download from 8 months
>> ago, and the new "test-debug" test was failing.
>>
>> Use "27" to improve reproducibility and make it clear when the image
>> is obsolete.
>>
>> Cc: Fam Zheng <famz@redhat.com>
>> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> I wonder what script you are using, and if the R: tag in MAINTAINERS is
> that useful, since I saw few docker patches I'm interestd in but I was
> not CC'd:

No, it's my fault

> $ ./scripts/get_maintainer.pl -f tests/docker/dockerfiles/fedora.docker
> "Alex Bennée" <alex.bennee@linaro.org> (maintainer:Build and test au...)
> Fam Zheng <famz@redhat.com> (maintainer:Build and test au...)
> "Philippe Mathieu-Daudé" <f4bug@amsat.org> (reviewer:Build and test au...)
> 
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  tests/docker/dockerfiles/fedora.docker | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
>> index 32de731..714adad 100644
>> --- a/tests/docker/dockerfiles/fedora.docker
>> +++ b/tests/docker/dockerfiles/fedora.docker
>> @@ -1,4 +1,4 @@
>> -FROM fedora:latest
>> +FROM fedora:27
> 
> I'd rather use the deprecation approach like we use for Debian,
> see tests/docker/dockerfiles/debian.docker.
> 
> That said, you remind me of a series doing the same for Ubuntu I forgot
> to send, if you want I can add fedora25 and fedora27 before sending.

That's fine by me (but use "fedora" instead of fedora25).

Paolo

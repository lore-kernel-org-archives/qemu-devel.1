Received: from eggs.gnu.org ([2001:4830:134:3::10]:45682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fsQcV-0000ZJ-18
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fsQX3-0000v7-SA
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:38:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43928 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fsQX3-0000uO-MG
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:38:33 -0400
References: <20180821172324.29331-1-r.bolshakov@yadro.com>
	<CAFEAcA85U43m4HbXXy+B-fw+sLMU4gZYTDjHUpT87970MN91NQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <322ecf3c-2411-212f-3b84-63728b3b018e@redhat.com>
Date: Wed, 22 Aug 2018 12:38:26 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA85U43m4HbXXy+B-fw+sLMU4gZYTDjHUpT87970MN91NQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] char: Enable build of pty on macOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Roman Bolshakov <r.bolshakov@yadro.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 21/08/2018 20:29, Peter Maydell wrote:
>>
>>  #if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)      \
>>      || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFly__) \
>> -    || defined(__GLIBC__)
>> +    || defined(__GLIBC__) || defined(__APPLE__)
> We should fix this by figuring out what the code is actually looking
> for (ie what OS functions), having a configure test for those
> functions, and dropping the big long list of OS ifdefs. Otherwise
> we've just got exactly the same problem for the next unix-ish
> OS that comes along...

It's really looking only for qemu_openpty_raw, which in turn is compiled
for all CONFIG_POSIX systems.  Because the file is already compiled for
CONFIG_POSIX only, the #ifdef is a legacy of the time before
chardev/char-pty.c was split out of qemu-char.c.  It can be removed.

Paolo

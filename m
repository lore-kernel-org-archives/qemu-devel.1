Received: from eggs.gnu.org ([2001:4830:134:3::10]:33872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP5nH-0005fm-DG
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:10:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP5nG-0004s8-Jt
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:10:19 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP5nE-0004iH-SA
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:10:18 -0500
Received: by mail-oi1-x242.google.com with SMTP id t204so1416997oie.7
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 05:10:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D9A31B6-6136-4ABD-B88D-722BA2D99528@gmail.com>
References: <mailman.21030.1541972152.1282.qemu-devel@nongnu.org>
	<4D9A31B6-6136-4ABD-B88D-722BA2D99528@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 13:09:54 +0000
Message-ID: <CAFEAcA-pN5F7UaiWC8nmG00NC=PftG6Aw3QfmEu-Dj4b8H4fOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Fix for crashes and non-responsive UI on
 macOS Mojave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Berkus Decker <berkus@gmail.com>

On 13 November 2018 at 12:12, Programmingkid <programmingkidx@gmail.com> wrote:
>> On Nov 11, 2018, at 4:35 PM, Berkus Decker wrote:
>> These changes are ought to work on OSX 10.6, although I don?t have a machine handy to test it.
>
> I have Mac OS 10.6 available for testing.

This is perhaps a good point to ask the question: is retaining
support for 10.6 still worth the effort ? It was released 9
years ago and has been unsupported by Apple for nearly 5 years.

qemu-doc.texi's "Supported build platforms" section says:
# The project supports building with the two most recent versions
# of macOS, with the current homebrew package set available.

which would be High Sierra (10.13) and Mojave (10.14) only. If you
widened that to "all versions still supported by Apple" it would add
Sierra (10.13) to the list.

Given how few upstream developers we have who care about OSX,
I think it is not very useful to spend that effort on trying
to retain support for ancient versions of it.

thanks
-- PMM

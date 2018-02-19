Received: from eggs.gnu.org ([2001:4830:134:3::10]:59706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1enr6I-0005VZ-Kn
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:27:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1enr6D-0003Kb-PY
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:27:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58372 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1enr6D-0003Jp-Kt
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:27:41 -0500
References: <CAG9FBFpFBrUrG0bRwjAo6xHYG4rnc0BT_ufLSa-HsO2WWgvKJw@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <3de4128f-7749-fc52-d5ec-5744b4e74301@redhat.com>
Date: Mon, 19 Feb 2018 14:27:24 -0500
MIME-Version: 1.0
In-Reply-To: <CAG9FBFpFBrUrG0bRwjAo6xHYG4rnc0BT_ufLSa-HsO2WWgvKJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu warnings and errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Barrett <xucaen@gmail.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>



On 02/19/2018 10:24 AM, James Barrett wrote:
> I keep getting these warnings with a message to send email to
> qemu-devel@nongnu.org
> 
> here is the command I am using:
> 
> qemu-system-i386 -hda bbs.hd -fda bbs.fd -hdb fat:rw:dist
> 
> 
> Host OS is Ubunti 17.10, guest OS is MS-DOS 6.22
> 

What version of QEMU?

> 
> 
> WARNING: Image format was not specified for 'bbs.hd' and probing guessed
> raw.
>          Automatically detecting the format is dangerous for raw images,
> write operations on block 0 will be restricted.
>          Specify the 'raw' format explicitly to remove the restrictions.
> WARNING: Image format was not specified for 'bbs.fd' and probing guessed
> raw.
>          Automatically detecting the format is dangerous for raw images,
> write operations on block 0 will be restricted.
>          Specify the 'raw' format explicitly to remove the restrictions.
> vvfat dist chs 1024,16,63
> WARNING: Image format was not specified for 'json:{"fat-type": 0, "dir":
> "dist", "driver": "vvfat", "floppy": false, "rw": true}' and probing
> guessed raw.
>          Automatically detecting the format is dangerous for raw images,
> write operations on block 0 will be restricted.
>          Specify the 'raw' format explicitly to remove the restrictions.

All of the above is "fine," but occurs because you use the -hda and -fda
shorthands to load raw files.

The more explicit syntax looks like this:

-drive if=none,format=raw,file=bbs.hd,id=foo
-device ide-hd,drive=foo

with that "format=raw" parameter there you'll avoid all those warnings.

> unknown keycodes `(unnamed)', please report to qemu-devel@nongnu.org
> 

This part is the only part that urges you to report the error, but I
don't know much about what's going on here.

Maybe Gerd knows?

--js

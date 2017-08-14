Received: from eggs.gnu.org ([2001:4830:134:3::10]:34448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dhDvZ-00052p-9s
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dhDvW-0005gP-4b
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:53:01 -0400
References: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
	<a808c0865b720e22ca2929ec3d362d4610fbad51.1502708830.git.mjt@msgid.tls.msk.ru>
	<CAFEAcA-Jac8wFzQ9vRyKjcEwDKYBdXysNyDP7ERFfXFhVcF56w@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ff54b90d-9912-ce03-31cf-9fd08571eab2@redhat.com>
Date: Mon, 14 Aug 2017 13:52:53 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Jac8wFzQ9vRyKjcEwDKYBdXysNyDP7ERFfXFhVcF56w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 7/7] hw/misc/mmio_interface: Return after
 error_setg() to avoid crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, KONRAD Frederic <fred.konrad@greensocs.com>

On 14.08.2017 13:45, Peter Maydell wrote:
> On 14 August 2017 at 12:07, Michael Tokarev <mjt@tls.msk.ru> wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> QEMU currently abort()s if the user tries to specify the mmio_interface
>> device without parameters:
>>
>> x86_64-softmmu/qemu-system-x86_64 -nographic -device mmio_interface
>> qemu-system-x86_64: /home/thuth/devel/qemu/util/error.c:57: error_setv:
>>  Assertion `*errp == ((void *)0)' failed.
>> Aborted (core dumped)
>>
>> This happens because the realize function is trying to set the errp
>> twice in this case. After setting an error, the realize function
>> should immediately return instead.
> 
> It seems like it should be an error to permit this to be
> created from the command line at all
That's also what thought first ... but the commit message of commit
7cc2298c46a6afa4f4ff7e5cd262809c782d701b says that it "can be
hotplugged/hotunplugged" ? ... that's confusing ...

Frederic, I think some more comments in the header of the file would be
really useful here.

 Thomas

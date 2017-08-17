Received: from eggs.gnu.org ([2001:4830:134:3::10]:36223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1diK6e-00067K-Cr
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1diK6d-0008F8-HU
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:41:00 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:35188
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1diK6d-0008Ed-7G
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:40:59 -0400
References: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
	<a808c0865b720e22ca2929ec3d362d4610fbad51.1502708830.git.mjt@msgid.tls.msk.ru>
	<CAFEAcA-Jac8wFzQ9vRyKjcEwDKYBdXysNyDP7ERFfXFhVcF56w@mail.gmail.com>
	<ff54b90d-9912-ce03-31cf-9fd08571eab2@redhat.com>
	<CAFEAcA_Fr3U5n+pBqfDk1J9GeaLREU1ttgKvMmmawMF+W1Fi+A@mail.gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <d2f92c3e-34ee-9a38-96b8-623fbc316e61@adacore.com>
Date: Thu, 17 Aug 2017 14:40:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Fr3U5n+pBqfDk1J9GeaLREU1ttgKvMmmawMF+W1Fi+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>



On 08/14/2017 01:55 PM, Peter Maydell wrote:
> On 14 August 2017 at 12:52, Thomas Huth <thuth@redhat.com> wrote:
>> On 14.08.2017 13:45, Peter Maydell wrote:
>>> It seems like it should be an error to permit this to be
>>> created from the command line at all
> 
>> That's also what thought first ... but the commit message of commit
>> 7cc2298c46a6afa4f4ff7e5cd262809c782d701b says that it "can be
>> hotplugged/hotunplugged" ? ... that's confusing ...
> 
> It means that memory.c creates and deletes instances of the
> device on demand, not that it's hotplugged in the "controlled by
> the user simulating PCI or other hotplug" sense.
> 
> thanks
> -- PMM
> 

Sorry, missed that I changed my email address recently.
I'll add some docs and fix the things we mentioned for 2.11.

For the context:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg446748.html

Thanks,
Fred

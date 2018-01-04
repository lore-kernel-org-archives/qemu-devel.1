Received: from eggs.gnu.org ([2001:4830:134:3::10]:60685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eX4tF-0004kl-G4
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 07:44:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eX4tC-0005uM-St
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 07:44:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eX4tC-0005s9-N7
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 07:44:54 -0500
References: <1515068847-20311-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-7+woO3ByXgJntLzg+yJd6YDS-tZXqZFjiHEW3tbgMUw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2efc072a-a0d7-a3f3-a3a9-9ec6ad86e170@redhat.com>
Date: Thu, 4 Jan 2018 13:44:48 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-7+woO3ByXgJntLzg+yJd6YDS-tZXqZFjiHEW3tbgMUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] usb: Remove legacy -usbdevice option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Paolo Bonzini <pbonzini@redhat.com>

On 04.01.2018 13:33, Peter Maydell wrote:
> On 4 January 2018 at 12:27, Thomas Huth <thuth@redhat.com> wrote:
>> The option has been marked as deprecated since QEMU 2.10, and so far
>> nobody complained that it is urgently required anymore. So let's now
>> get rid of this legacy pile, to simplify the usb code quite a bit.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>=20
> The diffstat is nice, but can we retain the "please use
> $NEWOPTION instead of $OLDOPTION" message for a bit?
> I'm pretty sure there will be users out there who've
> been happily ignoring deprecation notices, and I think
> we'll reduce the amount of support traffic if they
> get a new QEMU with a specific error message telling them
> what they need to fix, rather than one which just prints
> a generic "unknown option" message.

Sounds like a good idea at the first glance ... but at a second thought:
Don't we confuse the management layers like libvirt this way, which
might probe for the availability of this option by executing QEMU with
this parameter?

 Thomas

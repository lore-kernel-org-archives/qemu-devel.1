Received: from eggs.gnu.org ([2001:4830:134:3::10]:42020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eX4zF-0000qF-G4
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 07:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eX4zA-0005cl-8v
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 07:51:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eX4z9-0005aa-Us
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 07:51:04 -0500
References: <1515068847-20311-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-7+woO3ByXgJntLzg+yJd6YDS-tZXqZFjiHEW3tbgMUw@mail.gmail.com>
	<2efc072a-a0d7-a3f3-a3a9-9ec6ad86e170@redhat.com>
	<CAFEAcA_YUDYVUGaa5-ZUCQB6ErGySFtg_wO6=Ah=vyK7hAASPA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <797565f6-894a-1663-7375-afbcb1d1a70b@redhat.com>
Date: Thu, 4 Jan 2018 13:50:57 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_YUDYVUGaa5-ZUCQB6ErGySFtg_wO6=Ah=vyK7hAASPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 04.01.2018 13:49, Peter Maydell wrote:
> On 4 January 2018 at 12:44, Thomas Huth <thuth@redhat.com> wrote:
>> On 04.01.2018 13:33, Peter Maydell wrote:
>>> The diffstat is nice, but can we retain the "please use
>>> $NEWOPTION instead of $OLDOPTION" message for a bit?
>>> I'm pretty sure there will be users out there who've
>>> been happily ignoring deprecation notices, and I think
>>> we'll reduce the amount of support traffic if they
>>> get a new QEMU with a specific error message telling them
>>> what they need to fix, rather than one which just prints
>>> a generic "unknown option" message.
>>
>> Sounds like a good idea at the first glance ... but at a second thought:
>> Don't we confuse the management layers like libvirt this way, which
>> might probe for the availability of this option by executing QEMU with
>> this parameter?
> 
> If they do (which I'd hope they don't) then QEMU will
> exit with a failure status code, which they ought to
> identify as "not supported".

OK, makes sense. I'll cook a v2 of the patch accordingly...

 Thomas

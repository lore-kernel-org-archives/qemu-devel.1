Received: from eggs.gnu.org ([2001:4830:134:3::10]:36510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etziD-0000UH-Iw
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etzi9-0006Ru-NV
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:52:17 -0500
References: <1520413694-1271-1-git-send-email-thuth@redhat.com>
	<3aaac650-2934-c4ab-3f58-c022b1510e81@reactos.org>
	<950d4782-e1ca-816a-f13c-3dade56a7e7f@redhat.com>
	<CAFEAcA-bXBfc44y5FV9BOB14KMsJGNj3YEYSDxyAfVGpQooWjg@mail.gmail.com>
	<48bc8ae3-97d9-3fba-5c58-a44c20a4a8d4@redhat.com>
	<CAFEAcA8mYKZ7F0YE8=x-4Y8Ca9dn3GEOTNg0iV6U53ZvH1fL5g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d9f23e85-4b88-f94a-987d-3214d37c7ff4@redhat.com>
Date: Thu, 8 Mar 2018 18:51:53 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8mYKZ7F0YE8=x-4Y8Ca9dn3GEOTNg0iV6U53ZvH1fL5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/prep: Fix implicit creation of
 "-drive if=scsi" devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 08/03/2018 11:45, Peter Maydell wrote:
> On 8 March 2018 at 10:26, Thomas Huth <thuth@redhat.com> wrote:
>> The problem is rather that we still need more automatic regression tests
>> for stuff like this. I already have got something in mind for a new
>> qtest: If "mkisofs" or "genisoimage" is available, we could create a
>> boot CD-ROM automatically using the boot code from tests/boot-sector.c.
>> Then the test could try to boot from that CD-ROM to check whether
>> "--cdrom" is still working as expected. What do you think, does that
>> sound reasonable?
> 
> That's probably a good plan, though it wouldn't be able to cover
> boards like versatile/realview that can't boot from a cdrom.

We don't need to boot, we "only" need to have a qtest that sends an
INQUIRY command.  The code to bring up the LSI HBA can be copied from
SeaBIOS, what's missing is libqos ports for the various PCI bridges...

Paolo

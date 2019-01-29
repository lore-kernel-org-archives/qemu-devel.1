Received: from eggs.gnu.org ([209.51.188.92]:54816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1goOeE-0004DI-Fh
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:21:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1goOeA-0001ye-W1
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:21:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1goOe9-0001xj-9N
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:21:30 -0500
References: <20190124011554.25418-1-philmd@redhat.com>
	<20190124011554.25418-5-philmd@redhat.com>
	<20190124114305.bdxz76bsxk5lvc3d@sirius.home.kraxel.org>
	<ad4d15ab-a625-2171-358a-95266ec53bf4@redhat.com>
	<CAFEAcA8-FiXLns3Aj42cFkpUE54gAU0SRAO=kmWojU4+QdVm1w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f5f2d687-11ba-52bd-159e-21a2d4cfa46e@redhat.com>
Date: Tue, 29 Jan 2019 09:21:22 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8-FiXLns3Aj42cFkpUE54gAU0SRAO=kmWojU4+QdVm1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/display/milkymist-tmu2: Move
 inlined code from header to source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Brad Smith <brad@comstyle.com>, Michael Walle <michael@walle.cc>, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>

On 28/01/19 19:02, Peter Maydell wrote:
> 
> I don't understand why the build/config-all-devices.mak versions of
> the defines of CONFIG_FOO variables are so weird:
> 
> CONFIG_ACPI:=$(findstring y,$(CONFIG_ACPI)y)
> 
> ...are they really intended to be self-referential like that?

Yes, config-all-devices.mak is basically on "OR" of all the
config-devices.mak files.

Are CONFIG_X11 and CONFIG_OPENGL defined at the time
config-all-devices.mak is included?

Paolo

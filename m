Received: from eggs.gnu.org ([209.51.188.92]:45595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1grRjV-0003FN-TA
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:15:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1grRjU-0000rI-ST
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:15:37 -0500
From: Brad Smith <brad@comstyle.com>
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-10-philmd@redhat.com>
	<CAFEAcA_ejg0yPkBZ_0-mgM5zgMHKqKe3SDGX0wMZ-neYC_Oy0A@mail.gmail.com>
	<e5dd8130-e041-7774-2141-cc506dee99f7@redhat.com>
	<94f74717-0bab-ea0a-e7cc-239a1b1136bf@comstyle.com>
Message-ID: <97d5ea1c-0621-8f9c-0ee6-6a64540b4ddd@comstyle.com>
Date: Wed, 6 Feb 2019 13:15:10 -0500
MIME-Version: 1.0
In-Reply-To: <94f74717-0bab-ea0a-e7cc-239a1b1136bf@comstyle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 09/18] tests/vm/openbsd: Install Bash
 from the ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

On 2/5/2019 8:57 AM, Brad Smith wrote:

> If someone could point me in the right direction as to how the image 
> is created
> I could look at coming up with something newer. I would prefer that 
> over some
> of the workarounds I've seen to date.

I started creating the image and then wondered what do I set the root 
password
to? The instructions also talk about an SSH key but I don't know how 
that would
work when this image is used for the VM test framework.

I updated the instructions on the Wiki to make use of VirtIO for both 
the NIC and
disk controller.

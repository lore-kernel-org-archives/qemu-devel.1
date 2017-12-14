Received: from eggs.gnu.org ([2001:4830:134:3::10]:58570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePZLX-0007KD-VP
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:39:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePZLX-00029q-7J
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:39:08 -0500
References: <20171213213557.26561-1-f4bug@amsat.org>
	<20171214093907.GA14433@stefanha-x1.localdomain>
	<d4d649fc-4bb2-9b61-7e48-46a6a51e7b01@redhat.com>
	<CAMr-obuvJ4z54e0evM+J98jsdRayL-UeA_WDQVp0rx=sRoTVgw@mail.gmail.com>
	<874lotwb0w.fsf@dusky.pond.sub.org>
	<cfaa75b2-0da8-847d-0328-ec291ae81001@redhat.com>
	<CAFEAcA-13FJr=pscaLCtOZ0joG2Hm9m5iOuuK0xmLjSwG95U3w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ab49c17a-355c-a435-bd7c-da402166eb95@redhat.com>
Date: Thu, 14 Dec 2017 20:38:34 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-13FJr=pscaLCtOZ0joG2Hm9m5iOuuK0xmLjSwG95U3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/6] QTests: use Python to run
 complex tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, Nir Soffer <nirsof@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Alistair Francis <alistair.francis@xilinx.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>

On 14/12/2017 20:08, Peter Maydell wrote:
> On 14 December 2017 at 17:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> And also in software collections.  For 2.12 (as part of the above "drop
>> Python 2.x support" plan)
> 
> I'm reluctant to require a non-system python on OSX to build.

Oh well.  I guess I can post the infrastructure to simplify using a
non-system Python, without actually requiring it.

Paolo

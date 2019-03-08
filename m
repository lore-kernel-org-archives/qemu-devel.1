Received: from eggs.gnu.org ([209.51.188.92]:37390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h29T1-0001dE-Mn
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 01:58:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h29T1-00072c-2u
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 01:58:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h29T0-000711-Ps
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 01:58:51 -0500
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
	<a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
	<CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
	<62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
	<20190308064743.xe4govhrfdsrzns3@sirius.home.kraxel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <eceec1cb-42f1-32e4-da07-6d57a533fbef@redhat.com>
Date: Fri, 8 Mar 2019 07:58:41 +0100
MIME-Version: 1.0
In-Reply-To: <20190308064743.xe4govhrfdsrzns3@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 08/03/2019 07.47, Gerd Hoffmann wrote:
>   Hi,
> 
>>> As an aside, it might be a nice idea to drop the in-srcdir
>>> build altogether for QEMU anyway -- it's not really a very
>>> good idea and it means our build system has to cope with two
>>> different ways of working to no particularly useful end.
>>
>> I was actually going to propose that, but I was afraid of throwing two
>> bombs in the same day. :)
> 
> I stopped using in-tree builds years ago.  When test-building different
> configurations using an build/$cfgname out-of-tree build directory is
> the only sane approach.  And IIRC I've managed to break in-tree builds
> because of that.

FWIW, I'm also only doing out-of-tree builds. Thus I'd support a patch,
too, which enforces out of tree builds.

 Thomas

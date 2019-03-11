Received: from eggs.gnu.org ([209.51.188.92]:39125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1h3IMc-00089d-Of
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1h3IMb-0000ja-Qx
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:40:58 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1h3IMb-0000ib-FR
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:40:57 -0400
Received: by mail-wr1-x442.google.com with SMTP id d17so4461724wre.10
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 03:40:56 -0700 (PDT)
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
	<CAFEAcA--XHtUhOzSdNBDOVXbEceHkWSFiBcgNMTr5B-zz2fajA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA--XHtUhOzSdNBDOVXbEceHkWSFiBcgNMTr5B-zz2fajA@mail.gmail.com>
Date: Mon, 11 Mar 2019 10:40:54 +0000
Message-ID: <87zhq1ofrd.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/60] ppc-for-4.0 queue 20190310
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, Greg Kurz <groug@kaod.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Sun, 10 Mar 2019 at 08:27, David Gibson <david@gibson.dropbear.id.au> =
wrote:
>>
>> The following changes since commit f5b4c31030f45293bb4517445722768434829=
d91:
>>
>>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request=
' into staging (2019-03-09 17:35:48 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20190310
>>
>> for you to fetch changes up to 08d020471fcd41cb020fc9987ed1945eefcc8805:
>>
>>   spapr: Use CamelCase properly (2019-03-10 14:35:44 +1100)
>>
>> ----------------------------------------------------------------
>> ppc patch queue for 2019-03-10
>>
>> Here's a final pull request before the 4.0 soft freeze.  Changes
>> include:
>>   * A Great Renaming to use camel case properly in spapr code
>>   * Optimization of some vector instructions
>>   * Support for POWER9 cpus in the powernv machine
>>   * Fixes a regression from the last pull request in handling VSX
>>     instructions with mixed operands from the FPR and VMX parts of the
>>     register array
>>   * Optimization hack to avoid scanning all the (empty) entries on a
>>     new IOMMU window
>>   * Add FSL I2C controller model for E500
>>   * Support for KVM acceleration of the H_PAGE_INIT hypercall on spapr
>>   * Update u-boot image for E500
>>   * Enable Specre/Meltdown mitigations by default on the new machine type
>>   * Enable large decrementer support for POWER9
>>
>> Plus a number of assorted bugfixes and cleanups.
>>
>
> Hi. This pullreq generates a pile of new 'warning' messages
> during 'make check':
>
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=3Dppc64-softmmu/qemu-system-ppc64
> QTEST_QEMU_IMG=3Dqemu-img tests/
> boot-serial-test -m=3Dquick -k --tap < /dev/null |
> ./scripts/tap-driver.pl --test-name=3D"boot-serial-test"
> PASS 1 boot-serial-test /ppc64/boot-serial/ppce500
> PASS 2 boot-serial-test /ppc64/boot-serial/40p
> PASS 3 boot-serial-test /ppc64/boot-serial/mac99
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-cfpc=3Dworkaround
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-sbbc=3Dworkaround
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-ibs=3Dworkaround
> PASS 4 boot-serial-test /ppc64/boot-serial/pseries
> PASS 5 boot-serial-test /ppc64/boot-serial/powernv
> PASS 6 boot-serial-test /ppc64/boot-serial/sam460ex
>
> and similarly during the boot-pxe-test.
>
> Could you silence these, please?

FWIW this PR contains fixes that will finally get the gitlab CI green so
I look forward to v2 getting merged ;-)

--
Alex Benn=C3=A9e

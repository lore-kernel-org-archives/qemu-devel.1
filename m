Received: from eggs.gnu.org ([2001:4830:134:3::10]:45605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fapZL-000288-Sx
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 17:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fapZI-0005g4-Ng
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 17:44:11 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:39055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fapZI-0005fc-Ho
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 17:44:08 -0400
Received: by mail-qt0-x241.google.com with SMTP id q12-v6so5585099qtp.6
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 14:44:08 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180622004435.10291-1-f4bug@amsat.org>
	<20180622004435.10291-5-f4bug@amsat.org> <87in62vq15.fsf@linaro.org>
	<543f19ab-385c-4e77-b243-d6740b456360@amsat.org>
	<87bmbuvjvl.fsf@linaro.org>
	<2a4024fa-dcc7-701d-dd9c-0777aa02869b@amsat.org>
	<643265a1-f613-e14f-ac25-900133e52528@amsat.org>
	<20180704204746.GF7451@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cc9a70d8-3516-d76b-f130-7b02de57716a@amsat.org>
Date: Wed, 4 Jul 2018 18:44:02 -0300
MIME-Version: 1.0
In-Reply-To: <20180704204746.GF7451@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/6] tests/acceptance: Add a
 BootLinuxConsoleMips test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>, John Snow <jsnow@redhat.com>

On 07/04/2018 05:47 PM, Eduardo Habkost wrote:
> On Wed, Jul 04, 2018 at 04:56:44PM -0300, Philippe Mathieu-Daudé wrote:
>> On 06/28/2018 07:45 PM, Philippe Mathieu-Daudé wrote:
>>> On 06/28/2018 03:36 PM, Alex Bennée wrote:
>>>> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>>>>> On 06/28/2018 01:23 PM, Alex Bennée wrote:
> [...]
>>>>>>> +    def test(self):
>>>>>>> +        kernel_url = ('http://people.debian.org/~aurel32/qemu/mips/'
>>>>>>> +                      'vmlinux-3.2.0-4-4kc-malta')
>>>>>>> +        kernel_hash = '592e384a4edc16dade52a6cd5c785c637bcbc9ad'
>>>>>>> +        kernel_path = self.fetch_asset(kernel_url,
>>>>>>> asset_hash=kernel_hash)
>>>>>>
>>>>>> I'm uncomfortable using "random" binaries of websites as the source of
>>>>>> our test kernels. I can see the justification for distro kernels as they
>>>>>> at least have the infrastructure to rebuild from source if you really
>>>>>> want to, but even then the distros don't cover a lot of the
>>>>>> architectures.
>>
>> Alex: I could find all the Linux kernel I'm interested to console-test
>> with Avocado on the http://snapshot.debian.org/ archive website.
>>
>> For example Aurelien's one (more up-to-date) is available here:
>> http://snapshot.debian.org/package/linux-2.6/2.6.32-48/#linux-image-2.6.32-5-4kc-malta_2.6.32-48
>>
>> I also added a SH-4 test for the SM501 series of Zoltan BALATON using
>> the kernel extracted from this distrib built kernel:
>> http://snapshot.debian.org/package/linux-2.6/2.6.32-30/#linux-image-2.6.32-5-sh7751r_2.6.32-30
>>
>> The Debian distribution also provide the source package and the kernels
>> can be simply rebuilt using make-kpkg or (make bindeb-pkg with more
>> recent kernels).
>>
>> Would it be enough to satisfy the GPL requirements to provided that info
>> in the header and use these handy pre-compiled kernels?
> 
> (IANAL, etc.)
> 
> Personally, I would try to avoid dealing with the "written offer"
> option of the GPL, and just publish the sources in the same
> medium (HTTP download repository, git repository, etc) as the
> binary.

About Debian packaged kernel: the sources are in the same directory:

http://snapshot.debian.org/package/linux-2.6/2.6.32-30/

linux-2.6_2.6.32.orig.tar.gz
linux-image-2.6.32-5-sh7751r_2.6.32-30_sh4.deb
linux-support-2.6.32-5_2.6.32-30_all.deb

The other way, trying to compile a 2013 kernel is painful because the
oldest GCC I succeed installing complain about many errors.

The next absurd option I have is install a 2013 userland distrib and use
qemu-user to cross^H^H^H^H(?? I dunno how to name it)-compile this
kernel.... "backward-compile"? This might make sens with the coming
quantum computers.

> There was a related discussion about distribution of firmware
> binaries at <https://www.mail-archive.com/qemu-devel@nongnu.org/msg475674.html>.
> It looks like we never applied the docs/firmware.txt patch,
> though.

This case is not about firmware we need to run QEMU, but Linux kernel to
run acceptance tests using QEMU. But same legal stuffs, you know...

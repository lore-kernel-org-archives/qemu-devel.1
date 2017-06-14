Received: from eggs.gnu.org ([2001:4830:134:3::10]:40175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLABF-0003lS-7H
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLABC-0001RW-0h
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:26:01 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLABB-0001RS-RU
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:25:57 -0400
Received: by mail-qt0-x244.google.com with SMTP id o21so520799qtb.1
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 08:25:57 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1497369290-20401-1-git-send-email-peter.maydell@linaro.org>
	<1497369290-20401-2-git-send-email-peter.maydell@linaro.org>
	<20170614151548.GM4370@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3b74d72b-9dbf-bdff-a581-175adf96fb47@amsat.org>
Date: Wed, 14 Jun 2017 12:25:53 -0300
MIME-Version: 1.0
In-Reply-To: <20170614151548.GM4370@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] travis: install more library
 dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, patches@linaro.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 06/14/2017 12:15 PM, Daniel P. Berrange wrote:
> On Tue, Jun 13, 2017 at 04:54:48PM +0100, Peter Maydell wrote:
>> Update the travis list of library packages to install so that
>> our build tests cover more of our code base.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> I'm seeing the OS-X and GProf/GCov enable build entries fail with
> timeouts a reasonable amount of time, so turning on more features
> will make timeouts hit even more frequently. This patch would at
> least impact the GProf/GCov matrix entry in this respect. Is there
> anything we can do to mitigate this problem ?

There are few things we can tune:
https://docs.travis-ci.com/user/common-build-problems#my-builds-are-timing-out

But it seems easier to split the matrix a bit more, i.e. using 
--disable-system and --disable-linux/bsd-user, having a job only 
building full documentation (not compiling) and all other jobs using 
--disable-docs and so.

>> ---
>>  .travis.yml | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 27a2d9c..26dabb6 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -11,28 +11,37 @@ addons:
>>        # Build dependencies
>>        - libaio-dev
>>        - libattr1-dev
>> +      - libbluetooth-dev
>>        - libbrlapi-dev
>> +      - libcap-dev
>>        - libcap-ng-dev
>>        - libgnutls-dev
>>        - libgtk-3-dev
>>        - libiscsi-dev
>>        - liblttng-ust-dev
>> +      - liblzo2-dev
>>        - libnfs-dev
>>        - libncurses5-dev
>>        - libnss3-dev
>>        - libpixman-1-dev
>>        - libpng12-dev
>>        - librados-dev
>> +      - librdmacm-dev
>>        - libsdl1.2-dev
>>        - libseccomp-dev
>> +      - libsnappy-dev
>>        - libspice-protocol-dev
>>        - libspice-server-dev
>>        - libssh2-1-dev
>>        - liburcu-dev
>>        - libusb-1.0-0-dev
>> +      - libvde-dev
>>        - libvte-2.90-dev
>> +      - libxen-dev
>> +      - nettle-dev
>>        - sparse
>>        - uuid-dev
>> +      - xfslibs-dev
>>
>>  # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
>>  # to prevent IRC notifications from forks. This was created using:
>> @@ -162,28 +171,37 @@ matrix:
>>              # Build dependencies
>>              - libaio-dev
>>              - libattr1-dev
>> +            - libbluetooth-dev
>>              - libbrlapi-dev
>> +            - libcap-dev
>>              - libcap-ng-dev
>>              - libgnutls-dev
>>              - libgtk-3-dev
>>              - libiscsi-dev
>>              - liblttng-ust-dev
>> +            - liblzo2-dev
>>              - libnfs-dev
>>              - libncurses5-dev
>>              - libnss3-dev
>>              - libpixman-1-dev
>>              - libpng12-dev
>>              - librados-dev
>> +            - librdmacm-dev
>>              - libsdl1.2-dev
>>              - libseccomp-dev
>> +            - libsnappy-dev
>>              - libspice-protocol-dev
>>              - libspice-server-dev
>>              - libssh2-1-dev
>>              - liburcu-dev
>>              - libusb-1.0-0-dev
>> +            - libvde-dev
>>              - libvte-2.90-dev
>> +            - libxen-dev
>> +            - nettle-dev
>>              - sparse
>>              - uuid-dev
>> +            - xfslibs-dev
>>        language: generic
>>        compiler: none
>>        env:
>> --
>> 2.7.4
>>
>>
>
> Regards,
> Daniel
>

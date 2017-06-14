Received: from eggs.gnu.org ([2001:4830:134:3::10]:60652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL9tE-0007vh-Ju
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL9tA-0000Tf-L1
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:07:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17143)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dL9tA-0000T2-Cs
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:07:20 -0400
References: <1497369290-20401-1-git-send-email-peter.maydell@linaro.org>
	<1497369290-20401-2-git-send-email-peter.maydell@linaro.org>
	<f279fd6d-d32f-79e8-66e3-62edc0e425a8@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <937b2871-7380-4bfc-9a3b-997e496633ff@redhat.com>
Date: Wed, 14 Jun 2017 17:07:15 +0200
MIME-Version: 1.0
In-Reply-To: <f279fd6d-d32f-79e8-66e3-62edc0e425a8@amsat.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, patches@linaro.org



On 14/06/2017 05:52, Philippe Mathieu-Daud=E9 wrote:
> As you said, due to Travis using Ubuntu still not all libs get detected
> but at least the following:
>=20
>  $ ./configure ${CONFIG}
> -VirtFS support    no
> +VirtFS support    yes
> -bluez  support    no
> +bluez  support    yes
> -xfsctl support    no
> +xfsctl support    yes
> -lzo support       no
> +lzo support       yes
> -snappy support    no
> +snappy support    yes
>=20
> Using debian based docker images on Shippable we also get:
>=20
> -nettle            no
> -nettle kdf        no
> +nettle            yes (3.3)
> +nettle kdf        yes
> -rbd support       no
> +rbd support       yes
> -vde support       no
> +vde support       yes
> -GlusterFS support no
> +GlusterFS support yes
> -libnfs support    no
> +libnfs support    yes

So this leaves out only rdma and iscsi?

I don't know travis vs. shippable very well, can you provide a similar
patch to shippable?

Paolo

> On 06/13/2017 12:54 PM, Peter Maydell wrote:
>> Update the travis list of library packages to install so that
>> our build tests cover more of our code base.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> Tested-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
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
>>

Received: from eggs.gnu.org ([209.51.188.92]:59099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMbXv-0005mO-Ge
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMbXu-0002CW-F5
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:00:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMbXu-00027t-80
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:00:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15so3024790wrb.2
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 10:00:23 -0700 (PDT)
References: <20190503070241.24786-1-kraxel@redhat.com>
	<87a7g34hhn.fsf@zen.linaroharston>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6f291a03-0ff4-1c61-1a29-bd334e502564@redhat.com>
Date: Fri, 3 May 2019 19:00:21 +0200
MIME-Version: 1.0
In-Reply-To: <87a7g34hhn.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tests/docker: add ubuntu 18.04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>

On 5/3/19 6:42 PM, Alex Bennée wrote:
> 
> Gerd Hoffmann <kraxel@redhat.com> writes:
> 
>> Based on the ubuntu.docker file.
>> Used to reproduce the build failure Peter was seeing.
>> Others might find this useful too ;)
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  tests/docker/dockerfiles/ubuntu1804.docker | 57 ++++++++++++++++++++++
>>  1 file changed, 57 insertions(+)
>>  create mode 100644 tests/docker/dockerfiles/ubuntu1804.docker
>>
>> diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dockerfiles/ubuntu1804.docker
>> new file mode 100644
>> index 000000000000..2e2900150b09
>> --- /dev/null
>> +++ b/tests/docker/dockerfiles/ubuntu1804.docker
>> @@ -0,0 +1,57 @@
>> +FROM ubuntu:18.04
>> +ENV PACKAGES flex bison \
>> +    ccache \
>> +    clang \
>> +    gcc \
>> +    gettext \
>> +    git \
>> +    glusterfs-common \
>> +    libaio-dev \
>> +    libattr1-dev \
>> +    libbluetooth-dev \
>> +    libbrlapi-dev \
>> +    libbz2-dev \
>> +    libcacard-dev \
>> +    libcap-dev \
>> +    libcap-ng-dev \
>> +    libcurl4-gnutls-dev \
>> +    libdrm-dev \
>> +    libepoxy-dev \
>> +    libfdt-dev \
>> +    libgbm-dev \
>> +    libgtk-3-dev \
>> +    libibverbs-dev \
>> +    libiscsi-dev \
>> +    libjemalloc-dev \
>> +    libjpeg-turbo8-dev \
>> +    liblzo2-dev \
>> +    libncurses5-dev \
>> +    libncursesw5-dev \
>> +    libnfs-dev \
>> +    libnss3-dev \
>> +    libnuma-dev \
>> +    libpixman-1-dev \
>> +    librados-dev \
>> +    librbd-dev \
>> +    librdmacm-dev \
>> +    libsasl2-dev \
>> +    libsdl2-dev \
>> +    libseccomp-dev \
>> +    libsnappy-dev \
>> +    libspice-protocol-dev \
>> +    libspice-server-dev \
>> +    libssh2-1-dev \
>> +    libusb-1.0-0-dev \
>> +    libusbredirhost-dev \
>> +    libvdeplug-dev \
>> +    libvte-2.91-dev \
>> +    libxen-dev \
>> +    make \
>> +    python-yaml \
>> +    sparse \
>> +    texinfo \
>> +    xfslibs-dev
>> +RUN apt-get update && \
>> +    apt-get -y install $PACKAGES
>> +RUN dpkg -l $PACKAGES | sort > /packages.txt
>> +ENV FEATURES clang pyyaml sdl2
> 
> Queued to testing/next, thanks.

Just finished builds, so if it's not too late:

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

I'm not sure whichever {ubuntu1804/ubuntu18.04}.docker is better,
anyway:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> --
> Alex Bennée
> 

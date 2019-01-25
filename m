Received: from eggs.gnu.org ([209.51.188.92]:40256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn3No-0006kN-96
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:27:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn3Nn-0006Ux-GS
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:27:04 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gn3Nm-0006RV-Kr
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:27:03 -0500
Received: by mail-wr1-x441.google.com with SMTP id f7so10773992wrp.1
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 07:27:01 -0800 (PST)
References: <20190125140017.6092-1-alex.bennee@linaro.org>
	<20190125140017.6092-6-alex.bennee@linaro.org>
	<6dca2f29-427b-82af-0750-f066f6da8be3@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <6dca2f29-427b-82af-0750-f066f6da8be3@redhat.com>
Date: Fri, 25 Jan 2019 15:26:59 +0000
Message-ID: <87k1iszrjw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 05/14] docker: disable Xen on CentOS 7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 25/01/19 15:00, Alex Benn=C3=A9e wrote:
>> From: Paolo Bonzini <pbonzini@redhat.com>
>>
>> The Xen repository is failing to install, disable it.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> A better version:
>
> --- a/tests/docker/dockerfiles/centos7.docker
> +++ b/tests/docker/dockerfiles/centos7.docker
> @@ -1,5 +1,6 @@
>  FROM centos:7
> -RUN yum install -y epel-release centos-release-xen
> +RUN yum install -y epel-release centos-release-xen-48
> +

What happens if the upstream project moves to a newer release? Will it
break again?

>  RUN yum -y update
>  ENV PACKAGES \
>      bison \
>
>
> I can include it in my pull request too.

Sure... I mainly pulled it in because it's used by the centos VM. I'm
unlikely to get a PR out today as there are some reviews needed.

>
> Paolo
>
>> ---
>>  tests/docker/dockerfiles/centos7.docker | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dock=
erfiles/centos7.docker
>> index e0f18f5a41..e6fcbf4bcd 100644
>> --- a/tests/docker/dockerfiles/centos7.docker
>> +++ b/tests/docker/dockerfiles/centos7.docker
>> @@ -1,5 +1,5 @@
>>  FROM centos:7
>> -RUN yum install -y epel-release centos-release-xen
>> +RUN yum install -y epel-release
>>  RUN yum -y update
>>  ENV PACKAGES \
>>      bison \
>> @@ -8,7 +8,7 @@ ENV PACKAGES \
>>      ccache \
>>      csnappy-devel \
>>      flex \
>> -    g++ \
>> +    gcc-c++ \
>>      gcc \
>>      gettext \
>>      git \
>> @@ -29,7 +29,6 @@ ENV PACKAGES \
>>      spice-server-devel \
>>      tar \
>>      vte-devel \
>> -    xen-devel \
>>      zlib-devel
>>  RUN yum install -y $PACKAGES
>>  RUN rpm -q $PACKAGES | sort > /packages.txt
>>


--
Alex Benn=C3=A9e

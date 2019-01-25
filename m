Received: from eggs.gnu.org ([209.51.188.92]:40463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gn3OV-000782-R5
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:27:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gn3OU-0007De-MH
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:27:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:6246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gn3OS-0007BS-2C
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:27:45 -0500
References: <20190125140017.6092-1-alex.bennee@linaro.org>
	<20190125140017.6092-6-alex.bennee@linaro.org>
	<6dca2f29-427b-82af-0750-f066f6da8be3@redhat.com>
	<87k1iszrjw.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c938d001-c6d1-e542-1650-7a247161778b@redhat.com>
Date: Fri, 25 Jan 2019 16:27:34 +0100
MIME-Version: 1.0
In-Reply-To: <87k1iszrjw.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

On 25/01/19 16:26, Alex Benn=C3=A9e wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> On 25/01/19 15:00, Alex Benn=C3=A9e wrote:
>>> From: Paolo Bonzini <pbonzini@redhat.com>
>>>
>>> The Xen repository is failing to install, disable it.
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> A better version:
>>
>> --- a/tests/docker/dockerfiles/centos7.docker
>> +++ b/tests/docker/dockerfiles/centos7.docker
>> @@ -1,5 +1,6 @@
>>  FROM centos:7
>> -RUN yum install -y epel-release centos-release-xen
>> +RUN yum install -y epel-release centos-release-xen-48
>> +
> What happens if the upstream project moves to a newer release? Will it
> break again?
>=20

I don't know. We'll see. :)

Paolo

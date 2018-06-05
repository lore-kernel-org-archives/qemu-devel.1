Received: from eggs.gnu.org ([2001:4830:134:3::10]:39242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fQDr5-0007DW-Tq
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fQDr0-0002KQ-V9
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:26:39 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:50406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fQDr0-0002Jg-NT
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:26:34 -0400
Received: by mail-wm0-x243.google.com with SMTP id e16-v6so5741590wmd.0
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 08:26:34 -0700 (PDT)
References: <20180604145109.30498-1-alex.bennee@linaro.org>
	<20180604145109.30498-6-alex.bennee@linaro.org>
	<20180605025549.GB8708@lemon.usersys.redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180605025549.GB8708@lemon.usersys.redhat.com>
Date: Tue, 05 Jun 2018 16:26:32 +0100
Message-ID: <87a7s9cl07.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 5/7] docker: Update fedora image to 28
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: cota@braap.org, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org


Fam Zheng <famz@redhat.com> writes:

> On Mon, 06/04 15:51, Alex Benn=C3=A9e wrote:
>> From: Fam Zheng <famz@redhat.com>
>>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/docker/dockerfiles/fedora.docker | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/docke=
rfiles/fedora.docker
>> index b706f42405..65d7761cf5 100644
>> --- a/tests/docker/dockerfiles/fedora.docker
>> +++ b/tests/docker/dockerfiles/fedora.docker
>> @@ -1,4 +1,4 @@
>> -FROM fedora:27
>> +FROM fedora:28
>>  ENV PACKAGES \
>>      ccache gettext git tar PyYAML sparse flex bison python3 bzip2 hostn=
ame \
>>      gcc gcc-c++ llvm clang make perl which bc findutils glib2-devel \
>> --
>> 2.17.0
>>
>
> This one is in master now.

Cool, rolling the pull-req for the rest now.

>
> Fam


--
Alex Benn=C3=A9e

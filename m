Received: from eggs.gnu.org ([2001:4830:134:3::10]:44232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVFW1-0005xl-5R
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVFW0-0006WV-7N
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:13:41 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:45382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVFVz-0006W8-VE
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:13:40 -0400
Received: by mail-oi0-x243.google.com with SMTP id 188-v6so17876294oid.12
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 05:13:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180619120554.GP7451@localhost.localdomain>
References: <CAFEAcA-ZEH+SxhPOoPj+FkgSykikQq0cGUZdXnhvN5C2PE=i6w@mail.gmail.com>
	<20180619120554.GP7451@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Jun 2018 13:13:17 +0100
Message-ID: <CAFEAcA8b-VnM7wj_gneMBLDvZp1LnKDZ5EwCeB3wp_Y+MkDaww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/13] Python queue, 2018-06-11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 19 June 2018 at 13:05, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Tue, Jun 19, 2018 at 12:13:41PM +0100, Peter Maydell wrote:
>> Hi; I noticed that running configure on my machine can now produce a
>> python traceback from docker.py:
>>
>> make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/al=
ldbg'
>> config-host.mak is out-of-date, running configure
>> Traceback (most recent call last):
>>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
>> line 29, in <module>
>>     from StringIO import StringIO
>> ImportError: No module named 'StringIO'
>> Install prefix    /usr/local
>> [etc]
>>
>> I don't know if this is because of this change, but this is the
>> most recent change involving python...
>
> This seems to be introduced by:
>
> commit 51a12b51fd3693a16eb73362713a98d467e15af7
> Author: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Date:   Wed Apr 4 14:24:39 2018 +0100
>
>     configure: add test for docker availability
>
>     This tests for a working docker installation without sudo and sets up
>     config-host.mak accordingly. This will be useful from cross compiling
>     things in the future.
>
>     Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>     Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> tests/docker/docker.py is still python2-only but ./configure is
> trying to run it using $python (which can be Python 3).

Aha, yes -- I'd forgotten, but this config in my buildtest setup
is indeed configuring with --python=3Dpython3.

thanks
-- PMM

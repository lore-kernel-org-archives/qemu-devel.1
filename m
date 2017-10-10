Received: from eggs.gnu.org ([2001:4830:134:3::10]:60639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1yjL-0008AC-5A
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:54:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1yjK-0001c0-3z
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:54:11 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:47644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1yjJ-0001bf-TL
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:54:10 -0400
Received: by mail-wm0-x232.google.com with SMTP id t69so7461328wmt.2
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 10:54:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8d+UkhOJKovyedTye=8mD0mcbEScHm58RKyCuzYezxqA@mail.gmail.com>
References: <20171010171122.9756-1-marcandre.lureau@redhat.com>
	<CAFEAcA8d+UkhOJKovyedTye=8mD0mcbEScHm58RKyCuzYezxqA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Oct 2017 18:53:48 +0100
Message-ID: <CAFEAcA-O8hz-oa4H=L51O9iHCikdijY_ZYzREiYsgPyHG91fgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/27] vhost-user patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, changpeng liu <changpeng.liu@intel.com>

On 10 October 2017 at 18:22, Peter Maydell <peter.maydell@linaro.org> wrote=
:
> On 10 October 2017 at 18:10, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
>> The following changes since commit 567d0a19c7998fa366598b83d5a6e5f0759d3=
ea9:
>>
>>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-machine-pu=
ll-request' into staging (2017-10-10 13:25:46 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/elmarco/qemu.git tags/vus-pull-request
>>
>> for you to fetch changes up to 25f1fe82c64c8c4922254d63195e1d9cffbb0507:
>>
>>   vhost-user-scsi: remove server_sock from VusDev (2017-10-10 19:06:06 +=
0200)
>>
>> ----------------------------------------------------------------
>>
>> ----------------------------------------------------------------
>
> Hi. I'm afraid this fails to build:

And windows build:


  CC      contrib/libvhost-user/libvhost-user.o
/home/petmay01/linaro/qemu-for-merges/contrib/libvhost-user/libvhost-user.c=
:26:24:
fatal error: sys/socket.h: No such file or directory
compilation terminated.

You don't need to include sys/socket.h directly if you include
qemu/osdep.h, because that header will pull it in.

That may just run you into something else that doesn't work on
Windows, of course.

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dq0xP-0005Op-MD
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:51:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dq0xL-00076O-2E
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:51:15 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:44990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dq0xK-000768-Qe
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:51:10 -0400
Received: by mail-wm0-x234.google.com with SMTP id 137so678684wmj.1
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 10:51:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8025c01d-fde7-0031-2360-503bdbe3a21a@amsat.org>
References: <20170907082918.7299-1-famz@redhat.com>
	<20170907082918.7299-2-famz@redhat.com>
	<8025c01d-fde7-0031-2360-503bdbe3a21a@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Sep 2017 18:50:48 +0100
Message-ID: <CAFEAcA9=axe_f4C6wLRxuJC_pvEe_Pt51AfHZEUEkOikB=S+9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/9] buildsys: Move gtk/vte cflags/libs to
 per object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 7 September 2017 at 18:45, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> On 09/07/2017 05:29 AM, Fam Zheng wrote:
>> diff --git a/ui/Makefile.objs b/ui/Makefile.objs
>> index 3369451285..146a8ce062 100644
>> --- a/ui/Makefile.objs
>> +++ b/ui/Makefile.objs
>> @@ -45,6 +45,10 @@ gtk.o-cflags :=3D $(GTK_CFLAGS) $(VTE_CFLAGS)
>>   gtk-egl.o-cflags :=3D $(GTK_CFLAGS) $(VTE_CFLAGS)
>>   gtk-gl-area.o-cflags :=3D $(GTK_CFLAGS) $(VTE_CFLAGS)
>>   +gtk.o-libs :=3D $(GTK_LIBS) $(VTE_LIBS)
>> +gtk-egl.o-libs :=3D $(GTK_LIBS) $(VTE_LIBS)
>> +gtk-gl-area.o-libs :=3D $(GTK_LIBS) $(VTE_LIBS)
>
>
> $(foreach x, gtk gtk-egl gtk-gl-area, \
>     $(eval $x.o-libs +=3D $(GTK_LIBS) $(VTE_LIBS)) \
>     $(eval $x.o-cflags +=3D $(GTK_CFLAGS) $(VTE_CFLAGS)) \
>
> )

I think that's worse, personally. Most developers don't
touch the makefiles very often and so doing the simple
straightforward thing is better. Then it's clearer to
people who come along later how they need to add a new
file to the makefiles (a surprisingly common question).

thanks
-- PMM

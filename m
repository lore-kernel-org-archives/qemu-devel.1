Received: from eggs.gnu.org ([2001:4830:134:3::10]:55400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e3l1L-0003Cr-Fn
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 11:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e3l1H-0002wi-69
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 11:40:06 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:45100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e3l1G-0002w8-Vy
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 11:40:03 -0400
Received: by mail-wm0-f45.google.com with SMTP id q124so29279439wmb.0
	for <qemu-devel@nongnu.org>; Sun, 15 Oct 2017 08:40:02 -0700 (PDT)
References: <CA+J4q6dO+V32yF11jFD2jAizigYoZS6eECyuDTgRVfe+a_JUJQ@mail.gmail.com>
	<1507878038.21465.3.camel@redhat.com>
	<CAFEAcA9Vmrz3NTfJcSteyxvRvtb3VuCXZd=aOTL-GrWL3cm8bg@mail.gmail.com>
	<20171015160141.75690306@naga>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b389eb6f-7a3a-6d63-95f2-f0b526de3afa@redhat.com>
Date: Sun, 15 Oct 2017 17:39:59 +0200
MIME-Version: 1.0
In-Reply-To: <20171015160141.75690306@naga>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] QEMU without X11 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>, Peter Maydell <peter.maydell@linaro.org>
Cc: hanji unit <hanjiunit@gmail.com>, qemu-discuss <qemu-discuss@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 15/10/2017 16:01, Michal Suchánek wrote:
>>> ./configure --disable-gtk --disable-sdl --disable-opengl  
>> You can also use the runtime -display options (assuming
>> your development environment has the libraries
>> and your runtime environment has them installed, there's
>> no harm in having a QEMU that was built with gtk support
>> and not using the gtk UI.)
>>
>> There are a couple of parts to this:
>>  (1) does your guest OS require a graphics device?
>> (eg typically Windows does, ARM Linux will happily use
>> a serial port)
>>  (2) if you do need a graphics device, where does the
>> output go?
>> (eg you can tell QEMU to just not show graphics at
>> all with -display none, use -display vnc to for a VNC
>> server, etc. Some of the -display options will use
>> X11, and some won't.)
> iirc you also need to specify -nographic so qemu does not try to use the
> X11 GUI to display your serial output.

Right.  -nographic's effects can be described in terms of other
command-line options, but it is pretty hairy.  The effects fall in two
categories:

1) -nographic is a shortcut for "-display none -machine graphics=off"

2) it changes the default character device backend from "vc:80Cx24C"
(80x24 graphical console) to either "mon:stdio" or "stdio", except for
the parallel port whose default becomes simply "null".

Paolo

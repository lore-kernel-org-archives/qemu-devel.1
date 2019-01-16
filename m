Received: from eggs.gnu.org ([209.51.188.92]:56227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjj6A-0006xp-Lb
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjj68-0001Uo-2r
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:11:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gjj64-0001I4-TV
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:11:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id f188so1522429wmf.5
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 03:10:52 -0800 (PST)
References: <20190115115047.39326-1-alex.kanavin@gmail.com>
	<bde5dc1a-2ec3-98fa-1b4c-9147ddbadd86@redhat.com>
	<CANNYZj8RLr0ZQJjgXD065WzuYUHbi-dCN1-j_gQNq+28U9h6Qw@mail.gmail.com>
	<20190116055311.go6kwaemxfvbgtbb@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <85a3b4c9-017a-edbd-d991-172dc1528a7c@redhat.com>
Date: Wed, 16 Jan 2019 12:10:49 +0100
MIME-Version: 1.0
In-Reply-To: <20190116055311.go6kwaemxfvbgtbb@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] egl-helpers.h: add a missing X11 include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Alexander Kanavin <alex.kanavin@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 1/16/19 6:53 AM, Gerd Hoffmann wrote:
> On Tue, Jan 15, 2019 at 09:47:08PM +0100, Alexander Kanavin wrote:
>> On Tue, 15 Jan 2019 at 20:58, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>> Cc'ing Gerd (the maintainer) and Marc-André.
>>>
>>>> |  EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, Window win);
>>>> |                                                        ^~~~~~
>>>> |                                                        minor
> 
>>> <epoxy/egl.h> includes <EGL/eglplatform.h> which contains:
>>>
>>>   #if defined(MESA_EGL_NO_X11_HEADERS)
>>>   typedef void            *EGLNativeDisplayType;
>>>   typedef khronos_uintptr_t EGLNativePixmapType;
>>>   typedef khronos_uintptr_t EGLNativeWindowType;
>>>   #else
>>>   /* X11 (tentative)  */
>>>   #include <X11/Xlib.h>
>>>
>>> So Window should already be declared.
>>
>> Hello Philippe,
>>
>> we build mesa explicitly using "--with-platforms='drm surfaceless'"
>> (x11 is not in the list), which means MESA_EGL_NO_X11_HEADERS is
>> indeed defined according to [1]. We also enable opengl and gtk in
>> qemu.
> 
> Hmm, should we use EGLNativeWindowType instead of Window then?

Yes, I prefer this too but was not sure you'd like that :)

Alexander do you want to write the patch or should I?

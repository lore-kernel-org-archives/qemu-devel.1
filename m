Received: from eggs.gnu.org ([209.51.188.92]:32852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gqbOS-00073T-EM
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:22:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gqbOR-0004Vr-CC
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:22:24 -0500
Date: Mon, 4 Feb 2019 10:22:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190204102213.GF1905@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1549268045-11861-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1549268045-11861-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ui/sdl_keysym: Remove obsolete SDL1.2
 related code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Mon, Feb 04, 2019 at 09:14:05AM +0100, Thomas Huth wrote:
> Support for SDL1.2 has been removed recently in commit:
> 
>   0015ca5cbabe0b31d31610ddfaafd90a9e5911a4
>   ("ui: remove support for SDL1.2 in favour of SDL2")
> 
> So we can drop the SDL1.2-specific code in sdl_keysym.h now, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  ui/sdl_keysym.h | 73 ---------------------------------------------------------
>  1 file changed, 73 deletions(-)
> 
> diff --git a/ui/sdl_keysym.h b/ui/sdl_keysym.h
> index 599d9fc..6994180 100644
> --- a/ui/sdl_keysym.h
> +++ b/ui/sdl_keysym.h
> @@ -200,79 +200,6 @@ static const name2keysym_t name2keysym[]={
>  { "yacute",               0x0fd},
>  { "thorn",                0x0fe},
>  { "ydiaeresis",           0x0ff},
> -#if SDL_MAJOR_VERSION == 1

Don't why this was ever here, because this file is never used by SDL2.
SDL1 passed window system native scan codes, while SDL2 always passes
USB HID scancodes.

IOW, you can delete this whole file.

> -{"EuroSign", SDLK_EURO},
>  
> -    /* modifiers */
> -{"Control_L", SDLK_LCTRL},
> -{"Control_R", SDLK_RCTRL},
> -{"Alt_L", SDLK_LALT},
> -{"Alt_R", SDLK_RALT},
> -{"Caps_Lock", SDLK_CAPSLOCK},
> -{"Meta_L", SDLK_LMETA},
> -{"Meta_R", SDLK_RMETA},
> -{"Shift_L", SDLK_LSHIFT},
> -{"Shift_R", SDLK_RSHIFT},
> -{"Super_L", SDLK_LSUPER},
> -{"Super_R", SDLK_RSUPER},
> -
> -    /* special keys */
> -{"BackSpace", SDLK_BACKSPACE},
> -{"Tab", SDLK_TAB},
> -{"Return", SDLK_RETURN},
> -{"Right", SDLK_RIGHT},
> -{"Left", SDLK_LEFT},
> -{"Up", SDLK_UP},
> -{"Down", SDLK_DOWN},
> -{"Page_Down", SDLK_PAGEDOWN},
> -{"Page_Up", SDLK_PAGEUP},
> -{"Insert", SDLK_INSERT},
> -{"Delete", SDLK_DELETE},
> -{"Home", SDLK_HOME},
> -{"End", SDLK_END},
> -{"Scroll_Lock", SDLK_SCROLLOCK},
> -{"F1", SDLK_F1},
> -{"F2", SDLK_F2},
> -{"F3", SDLK_F3},
> -{"F4", SDLK_F4},
> -{"F5", SDLK_F5},
> -{"F6", SDLK_F6},
> -{"F7", SDLK_F7},
> -{"F8", SDLK_F8},
> -{"F9", SDLK_F9},
> -{"F10", SDLK_F10},
> -{"F11", SDLK_F11},
> -{"F12", SDLK_F12},
> -{"F13", SDLK_F13},
> -{"F14", SDLK_F14},
> -{"F15", SDLK_F15},
> -{"Sys_Req", SDLK_SYSREQ},
> -{"KP_0", SDLK_KP0},
> -{"KP_1", SDLK_KP1},
> -{"KP_2", SDLK_KP2},
> -{"KP_3", SDLK_KP3},
> -{"KP_4", SDLK_KP4},
> -{"KP_5", SDLK_KP5},
> -{"KP_6", SDLK_KP6},
> -{"KP_7", SDLK_KP7},
> -{"KP_8", SDLK_KP8},
> -{"KP_9", SDLK_KP9},
> -{"KP_Add", SDLK_KP_PLUS},
> -{"KP_Decimal", SDLK_KP_PERIOD},
> -{"KP_Divide", SDLK_KP_DIVIDE},
> -{"KP_Enter", SDLK_KP_ENTER},
> -{"KP_Equal", SDLK_KP_EQUALS},
> -{"KP_Multiply", SDLK_KP_MULTIPLY},
> -{"KP_Subtract", SDLK_KP_MINUS},
> -{"help", SDLK_HELP},
> -{"Menu", SDLK_MENU},
> -{"Power", SDLK_POWER},
> -{"Print", SDLK_PRINT},
> -{"Mode_switch", SDLK_MODE},
> -{"Multi_Key", SDLK_COMPOSE},
> -{"Num_Lock", SDLK_NUMLOCK},
> -{"Pause", SDLK_PAUSE},
> -{"Escape", SDLK_ESCAPE},
> -#endif
>  {NULL, 0},
>  };
> -- 
> 1.8.3.1
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

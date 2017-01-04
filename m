Received: from eggs.gnu.org ([2001:4830:134:3::10]:57371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cOsLb-00030S-5q
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:39:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cOsLX-0001hR-Vo
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:39:47 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:35788)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cOsLX-0001cy-Lw
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:39:43 -0500
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <87bmw2vgvy.fsf@mail.parknet.co.jp>
	<1483519725.5670.44.camel@redhat.com>
Date: Thu, 05 Jan 2017 05:39:37 +0900
In-Reply-To: <1483519725.5670.44.camel@redhat.com> (Gerd Hoffmann's message of
	"Wed, 04 Jan 2017 09:48:45 +0100")
Message-ID: <87vatuk19y.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] ui/gtk: Fix mouse wheel on 3.4.0 or later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

Gerd Hoffmann <kraxel@redhat.com> writes:

>> +#if GTK_CHECK_VERSION(3, 4, 0)
>> +    } else if (scroll->direction == GDK_SCROLL_SMOOTH) {
>> +        gdouble delta_x, delta_y;
>> +        if (!gdk_event_get_scroll_deltas((GdkEvent*)scroll, &delta_x, &delta_y))
>> +            return TRUE;
>> +        if (delta_y > 0)
>> +            btn = INPUT_BUTTON_WHEEL_DOWN;
>> +        else
>> +            btn = INPUT_BUTTON_WHEEL_UP;
>> +#endif
>
> Patch looks good, except for some codestyle issues:

will fix

> === checkpatch complains ===
> ERROR: "(foo*)" should be "(foo *)"
> #13: FILE: ui/gtk.c:1024:
> +        if (!gdk_event_get_scroll_deltas((GdkEvent*)scroll, &delta_x,
> &delta_y))
>
> ERROR: braces {} are necessary for all arms of this statement
> #13: FILE: ui/gtk.c:1024:
> +        if (!gdk_event_get_scroll_deltas((GdkEvent*)scroll, &delta_x,
> &delta_y))
> [...]
>
> ERROR: braces {} are necessary for all arms of this statement
> #15: FILE: ui/gtk.c:1026:
> +        if (delta_y > 0)
> [...]
> +        else
> [...]
>
> total: 3 errors, 0 warnings, 16 lines checked
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

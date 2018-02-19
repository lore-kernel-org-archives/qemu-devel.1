Received: from eggs.gnu.org ([208.118.235.92]:40127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1enhDr-0005NP-V5
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 03:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1enhDo-0006xW-UL
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 03:54:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52326 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1enhDo-0006wt-P4
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 03:54:52 -0500
Date: Mon, 19 Feb 2018 09:54:44 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180219085444.ndyga5fgwkc6kfqm@sirius.home.kraxel.org>
References: <20180216203856.8645-1-programmingkidx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216203856.8645-1-programmingkidx@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v7] ui/cocoa.m: Add ability for user to
 specify mouse ungrab key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

  Hi,

> +/* Sends any keys that were delayed because they were part of the ungrab set */
> +static void send_key_if_delayed(Set *the_set, int keycode)
> +{
> +    if (contains_number(the_set, keycode)) {
> +        qemu_input_event_send_key_qcode(dcl->con, keycode, true);
> +        qemu_input_event_send_key_qcode(dcl->con, keycode, false);
> +    }
> +}

>          case NSEventTypeKeyUp:
>              keycode = cocoa_keycode_to_qemu([event keyCode]);
>  
> +            if (are_sets_equal(ungrab_set, key_set)) {
> +                [self ungrabMouse];
> +                clear_set(key_set);
> +                return;
> +            }
> +            send_key_if_delayed(key_set, keycode);
> +            remove_number(key_set, keycode);

This doesn't maintain the event ordering.

cheers,
  Gerd

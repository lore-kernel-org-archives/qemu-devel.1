Received: from eggs.gnu.org ([209.51.188.92]:54837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmC7O-00076E-Tk
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:34:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmBtt-0004zi-Di
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:20:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmBtr-0004xo-GH
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:20:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6CB6A80E7B
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 06:20:34 +0000 (UTC)
Date: Wed, 23 Jan 2019 07:20:33 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190123062033.mmte7z4friinj7yf@sirius.home.kraxel.org>
References: <20181219120904.17643-1-kraxel@redhat.com>
	<20181219120904.17643-2-kraxel@redhat.com>
	<c563bdda-601d-c362-049b-b8e3a933291b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c563bdda-601d-c362-049b-b8e3a933291b@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/7] kbd-state: add keyboard state
 tracker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

> > +         * the corresponding key-down event wasn't send to the guest,
> 
> s/send/sent/

Fixed.

> > +void kbd_state_lift_all_keys(KbdState *kbd)
> > +{
> > +    int qcode;
> > +
> > +    for (qcode = 0; qcode < Q_KEY_CODE__MAX; qcode++) {
> > +        if (test_bit(qcode, kbd->keys)) {
> > +            kbd_state_key_event(kbd, qcode, false);
> 
> Is there a more efficient iteration through the bitmap when looking for
> the next set bit, or is the map small enough that it doesn't matter?

It isn't that big (a bit over 100 I think), and the function isn't
called often, so performance really shouldn't be a problem here.

cheers,
  Gerd

Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B75CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:09:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5565B20640
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="p6wB/f5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5565B20640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNFSg-00067T-Gn
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 08:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>) id 1iNFRf-0005EX-0H
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:08:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <svens@stackframe.org>) id 1iNFRd-0006gR-SK
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:08:54 -0400
Received: from [2001:470:70c5:1111::170] (port=44125 helo=smtp.duncanthrax.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <svens@stackframe.org>)
 id 1iNFRc-0006av-87
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=C0dHHW8teXUT72ZxMlhpJju4R7xe7/z13dEinZjD/sQ=; b=p6wB/f5cvrHAFz+J5LdIzpSsZa
 82r2WP5DpiJqUOn8lJnVO0iaeuSSKzDf0mAILvc5xOuKpbRTNSOPdT0QzHBUWIw3FIicjtNKpbrL7
 /D728+X5k8loURoNhlC64YzHuBAvLQ+tMXy6qJuta3hO/cDdfFNkfRU8x1PWJeMgNzco=;
Received: from [2a01:4f8:121:41fa::170] (helo=stackframe.org)
 by smtp.eurescom.eu with esmtpa (Exim 4.86_2)
 (envelope-from <svens@stackframe.org>)
 id 1iNFRU-0004DT-8f; Wed, 23 Oct 2019 14:08:44 +0200
Date: Wed, 23 Oct 2019 14:08:44 +0200
From: Sven Schnelle <svens@stackframe.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 3/6] ps2: accept 'Set Key Make and Break' commands
Message-ID: <20191023120844.GA22554@stackframe.org>
References: <20191022205941.23152-1-svens@stackframe.org>
 <20191022205941.23152-4-svens@stackframe.org>
 <c0a0c73a-496f-e6bc-54ce-a6631ef3a81d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0a0c73a-496f-e6bc-54ce-a6631ef3a81d@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:470:70c5:1111::170
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Wed, Oct 23, 2019 at 01:08:35PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Sven,
> 
> (Please Cc reviewers who previously commented your patch)
>
> On 10/22/19 10:59 PM, Sven Schnelle wrote:
> > HP-UX sends both the 'Set key make and break (0xfc) and
> > 'Set all key typematic make and break' (0xfa). QEMU response
> > with 'Resend' as it doesn't handle these commands. HP-UX than
> > reports an PS/2 max retransmission exceeded error. Add these
> > commands and just reply with ACK.
> > 
> > Signed-off-by: Sven Schnelle <svens@stackframe.org>
> > ---
> >   hw/input/ps2.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> > 
> > diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> > index 67f92f6112..0b671b6339 100644
> > --- a/hw/input/ps2.c
> > +++ b/hw/input/ps2.c
> > @@ -49,6 +49,8 @@
> >   #define KBD_CMD_RESET_DISABLE	0xF5	/* reset and disable scanning */
> >   #define KBD_CMD_RESET_ENABLE   	0xF6    /* reset and enable scanning */
> >   #define KBD_CMD_RESET		0xFF	/* Reset */
> > +#define KBD_CMD_SET_MAKE_BREAK  0xFC    /* Set Make and Break mode */
> > +#define KBD_CMD_SET_TYPEMATIC   0xFA    /* Set Typematic Make and Break mode */
> >   /* Keyboard Replies */
> >   #define KBD_REPLY_POR		0xAA	/* Power on reset */
> > @@ -573,6 +575,7 @@ void ps2_write_keyboard(void *opaque, int val)
> >           case KBD_CMD_SCANCODE:
> >           case KBD_CMD_SET_LEDS:
> >           case KBD_CMD_SET_RATE:
> > +        case KBD_CMD_SET_MAKE_BREAK:
> 
> OK
> 
> >               s->common.write_cmd = val;
> >               ps2_queue(&s->common, KBD_REPLY_ACK);
> >               break;
> > @@ -592,11 +595,18 @@ void ps2_write_keyboard(void *opaque, int val)
> >                   KBD_REPLY_ACK,
> >                   KBD_REPLY_POR);
> >               break;
> > +        case KBD_CMD_SET_TYPEMATIC:
> > +            ps2_queue(&s->common, KBD_REPLY_ACK);
> 
> I'm not sure, can't this loop?

I don't see how?

> Can you fold it with the '0x00' case?

Ok.

> > +            break;
> >           default:
> >               ps2_queue(&s->common, KBD_REPLY_RESEND);
> >               break;
> >           }
> >           break;
> > +    case KBD_CMD_SET_MAKE_BREAK:
> 
> We can reorder this one in the same case with:
> 
>     case KBD_CMD_SET_LEDS:
>     case KBD_CMD_SET_RATE:

Ok.

> > +        ps2_queue(&s->common, KBD_REPLY_ACK);
> > +        s->common.write_cmd = -1;
> > +        break;
> >       case KBD_CMD_SCANCODE:
> >           if (val == 0) {
> >               if (s->common.queue.count <= PS2_QUEUE_SIZE - 2) {
> > 
> 

Regards
Sven


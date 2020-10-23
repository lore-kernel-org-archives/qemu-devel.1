Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3B5C5517A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 06:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376A22192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 06:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzAJGHRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376A22192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVqZ7-0001gU-8E
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 02:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1kVqXb-0000yV-0B
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 02:27:08 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38123)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1kVqXY-0005Ww-7u
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 02:27:06 -0400
Received: by mail-oi1-x243.google.com with SMTP id h10so749928oie.5
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 23:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WJiT8dsIT18XD5r7+loOKAPJI56mYeE2fKxKZybUnmQ=;
 b=qzAJGHROmqNTeBghQjNu1XNsh7jDy2jO8laNDMHai8MraOBEGBnqh6R3AoNu4KicWs
 i/PquhPwetupwWUvgZgmNKi2ekTi6ZlFwmm6ejnP4rwfzJb0HxY84uvlzD+V2NgnooeV
 AvaTKFUUNmrA1YEA1mKjRvRzc+cXBxgkRJgdOoFMES1L7DHrvsieKoZ8GBAlw9CDIp1i
 E3K6HVhJG6XIUD0D7sDk58r2YpKpRRr3xL0YIzmz50bZaBNL5GN/xdeHssf8ismQUmZp
 PwaigtSkIXgNexf/gk4bO4O+yVAHGytd2X9PqOwxgvPtuHGtV2qgW6mFmpotQNDBrrIy
 nIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WJiT8dsIT18XD5r7+loOKAPJI56mYeE2fKxKZybUnmQ=;
 b=tmL27txhoyUOqvp651Di7/MrfP0o5fC7i/5FVgJJ2Cw8yubdMo2/HJIY/ycxfBAxdT
 c4VZraNqm8lXqJPnEqlFXvpNN95Zt9Z/6A1zA1s0bnNoO0jgQyhjH//WBIDgrTsd6+vz
 hJsrGiXY0rkLlAIcSWtm6Kd8QObKl1zcsQXJk8D2D/9U9uZG/VX+2LkH2fjubWaM/87O
 PeO9vPcyDh169QYMn7WI7/Pue57fDjsxf3OiPukcXNYuEW3v5fsf5xmh1x4oXsiYkfox
 fzPn2pIfWIARprYYyeQ2W8pGWopZ/bGhioziJLQCkAmbFB9tjqdPv3gcy+nKrm4a8Frk
 MyDQ==
X-Gm-Message-State: AOAM531S7dVyCOsHBQZ+s8pYMn43oMlFLCULhGubcl/ngkhaMwRiBOTj
 SCMCJy/eOq5Mx/YuTIqsBmmwakS4Y7g8vCfu5rs=
X-Google-Smtp-Source: ABdhPJwxIPNNMVkVbckY+ZSYVHJgoBqjIkMuA38XBbJwfGFvbpgl/O/0sB87mptcMCOg3vKdUtLg762p/5Lt3mYNJJI=
X-Received: by 2002:aca:c5ce:: with SMTP id v197mr595141oif.93.1603434419817; 
 Thu, 22 Oct 2020 23:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201022114026.31968-1-marcel.apfelbaum@gmail.com>
 <20201022080354-mutt-send-email-mst@kernel.org>
 <20201022235632.7f69ddc9@yekko.fritz.box>
 <CAC_L=vVi6ngD6j0sZ2uLZ-NHF2WGzKfiOvmsHxOZaBRv6FuBug@mail.gmail.com>
 <20201022100028-mutt-send-email-mst@kernel.org>
 <CAC_L=vWctLK0Yjod_Vz=+xzFKFp4UoUdjSVa4jWeDm+g8en6wQ@mail.gmail.com>
 <20201022102857-mutt-send-email-mst@kernel.org>
 <CAC_L=vX0+H-SfQHneVPd-Mc3wFxHBSbkKHt3SpNOBOY_JsYDUA@mail.gmail.com>
 <20201022110016-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201022110016-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Fri, 23 Oct 2020 09:26:48 +0300
Message-ID: <CAC_L=vUgsh=08m8EEuEucRtdX73X5kw5ov4Ekg7jFjbHsU6f2w@mail.gmail.com>
Subject: Re: [PATCH] pci: Refuse to hotplug PCI Devices when the Guest OS is
 not ready
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000003933a05b250ab62"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=marcel.apfelbaum@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: David Gibson <dgibson@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000003933a05b250ab62
Content-Type: text/plain; charset="UTF-8"

Hi Michael,

On Thu, Oct 22, 2020 at 6:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Thu, Oct 22, 2020 at 05:50:51PM +0300, Marcel Apfelbaum wrote:
> >
> >
> > On Thu, Oct 22, 2020 at 5:33 PM Michael S. Tsirkin <mst@redhat.com>
> wrote:
> >
> >     On Thu, Oct 22, 2020 at 05:10:43PM +0300, Marcel Apfelbaum wrote:
> >     >
> >     >
> >     > On Thu, Oct 22, 2020 at 5:01 PM Michael S. Tsirkin <mst@redhat.com
> >
> >     wrote:
> >     >
> >     >     On Thu, Oct 22, 2020 at 04:55:10PM +0300, Marcel Apfelbaum
> wrote:
> >     >     > Hi David, Michael,
> >     >     >
> >     >     > On Thu, Oct 22, 2020 at 3:56 PM David Gibson <
> dgibson@redhat.com>
> >     wrote:
> >     >     >
> >     >     >     On Thu, 22 Oct 2020 08:06:55 -0400
> >     >     >     "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >     >     >
> >     >     >     > On Thu, Oct 22, 2020 at 02:40:26PM +0300, Marcel
> Apfelbaum
> >     wrote:
> >     >     >     > > From: Marcel Apfelbaum <marcel@redhat.com>
> >     >     >     > >
> >     >     >     > > During PCIe Root Port's transition from Power-Off to
> >     Power-ON (or
> >     >     >     vice-versa)
> >     >     >     > > the "Slot Control Register" has the "Power Indicator
> >     Control"
> >     >     >     > > set to "Blinking" expressing a "power transition"
> mode.
> >     >     >     > >
> >     >     >     > > Any hotplug operation during the "power transition"
> mode is
> >     not
> >     >     >     permitted
> >     >     >     > > or at least not expected by the Guest OS leading to
> strange
> >     >     failures.
> >     >     >     > >
> >     >     >     > > Detect and refuse hotplug operations in such case.
> >     >     >     > >
> >     >     >     > > Signed-off-by: Marcel Apfelbaum <
> marcel.apfelbaum@gmail.com
> >     >
> >     >     >     > > ---
> >     >     >     > >  hw/pci/pcie.c | 7 +++++++
> >     >     >     > >  1 file changed, 7 insertions(+)
> >     >     >     > >
> >     >     >     > > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> >     >     >     > > index 5b48bae0f6..2fe5c1473f 100644
> >     >     >     > > --- a/hw/pci/pcie.c
> >     >     >     > > +++ b/hw/pci/pcie.c
> >     >     >     > > @@ -410,6 +410,7 @@ void pcie_cap_slot_pre_plug_cb
> >     (HotplugHandler
> >     >     >     *hotplug_dev, DeviceState *dev,
> >     >     >     > >      PCIDevice *hotplug_pdev =
> PCI_DEVICE(hotplug_dev);
> >     >     >     > >      uint8_t *exp_cap = hotplug_pdev->config +
> >     hotplug_pdev->
> >     >     >     exp.exp_cap;
> >     >     >     > >      uint32_t sltcap = pci_get_word(exp_cap +
> >     PCI_EXP_SLTCAP);
> >     >     >     > > +    uint32_t sltctl = pci_get_word(exp_cap +
> >     PCI_EXP_SLTCTL);
> >     >     >     > >
> >     >     >     > >      /* Check if hot-plug is disabled on the slot */
> >     >     >     > >      if (dev->hotplugged && (sltcap &
> PCI_EXP_SLTCAP_HPC) =
> >     = 0) {
> >     >     >     > > @@ -418,6 +419,12 @@ void pcie_cap_slot_pre_plug_cb
> >     >     (HotplugHandler
> >     >     >     *hotplug_dev, DeviceState *dev,
> >     >     >     > >          return;
> >     >     >     > >      }
> >     >     >     > >
> >     >     >     > > +    if ((sltctl & PCI_EXP_SLTCTL_PIC) ==
> >     >     PCI_EXP_SLTCTL_PWR_IND_BLINK)
> >     >     >     {
> >     >     >     > > +        error_setg(errp, "Hot-plug failed: %s is in
> Power
> >     >     Transition",
> >     >     >     > > +                   DEVICE(hotplug_pdev)->id);
> >     >     >     > > +        return;
> >     >     >     > > +    }
> >     >     >     > > +
> >     >     >     > >
> pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev),
> >     dev,
> >     >     errp);
> >     >     >     > >  }
> >     >     >     >
> >     >     >     > Probably the only way to handle for existing machine
> types.
> >     >     >
> >     >     >
> >     >     > I agree
> >     >     >
> >     >     >
> >     >     >     > For new ones, can't we queue it in host memory
> somewhere?
> >     >     >
> >     >     >
> >     >     >
> >     >     > I am not sure I understand what will be the flow.
> >     >     >   - The user asks for a hotplug operation.
> >     >     >   -  QEMU deferred operation.
> >     >     > After that the operation may still fail, how would the user
> know if
> >     the
> >     >     > operation
> >     >     > succeeded or not?
> >     >
> >     >
> >     >     How can it fail? It's just a button press ...
> >     >
> >     >
> >     >
> >     > Currently we have "Hotplug unsupported."
> >     > With this change we have "Guest/System not ready"
> >
> >
> >     Hotplug unsupported is not an error that can trigger with
> >     a well behaved management such as libvirt.
> >
> >
> >     >
> >     >
> >     >     >
> >     >     >
> >     >     >     I'm not actually convinced we can't do that even for
> existing
> >     machine
> >     >     >     types.
> >     >     >
> >     >     >
> >     >     > Is a Guest visible change, I don't think we can do it.
> >     >     >
> >     >     >
> >     >     >     So I'm a bit hesitant to suggest going ahead with this
> without
> >     >     >     looking a bit closer at whether we can implement a
> >     wait-for-ready in
> >     >     >     qemu, rather than forcing every user of qemu (human or
> machine)
> >     to do
> >     >     >     so.
> >     >     >
> >     >     >
> >     >     > While I agree it is a pain from the usability point of view,
> >     hotplug
> >     >     operations
> >     >     > are allowed to fail. This is not more than a corner case,
> ensuring
> >     the
> >     >     right
> >     >     > response (gracefully erroring out) may be enough.
> >     >     >
> >     >     > Thanks,
> >     >     > Marcel
> >     >     >
> >     >
> >     >
> >     >     I don't think they ever failed in the past so management is
> unlikely
> >     >     to handle the failure by retrying ...
> >     >
> >     >
> >     > That would require some management handling, yes.
> >     > But even without a "retry", failing is better than strange OS
> behavior.
> >     >
> >     > Trying a better alternative like deferring the operation for new
> machines
> >     > would make sense, however is out of the scope of this patch
> >
> >     Expand the scope please. The scope should be "solve a problem xx" not
> >     "solve a problem xx by doing abc".
> >
> >
> >
> > The scope is detecting a hotplug error early instead
> > passing to the Guest OS a hotplug operation that we know it will fail.
> >
>
> Right. After detecting just failing unconditionally it a bit too
> simplistic IMHO.
>
>
Simplistic does not mean wrong or incorrect.
I fail to see why it is not enough.

What QEMU can do better? Wait an unbounded time for the blinking to finish?
What if we have a buggy guest with a kernel stuck in blinking?
Is QEMU's responsibility to emulate the operator itself? Because the
operator
is the one who is supposed to wait.


Thanks,
Marcel

[...]

--00000000000003933a05b250ab62
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+SGkgTWljaGFlbCw8L2Rpdj48YnI+PGRpdiBj
bGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBU
aHUsIE9jdCAyMiwgMjAyMCBhdCA2OjAxIFBNIE1pY2hhZWwgUy4gVHNpcmtpbiAmbHQ7PGEgaHJl
Zj0ibWFpbHRvOm1zdEByZWRoYXQuY29tIj5tc3RAcmVkaGF0LmNvbTwvYT4mZ3Q7IHdyb3RlOjxi
cj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4
IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFk
ZGluZy1sZWZ0OjFleCI+T24gVGh1LCBPY3QgMjIsIDIwMjAgYXQgMDU6NTA6NTFQTSArMDMwMCwg
TWFyY2VsIEFwZmVsYmF1bSB3cm90ZTo8YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyBP
biBUaHUsIE9jdCAyMiwgMjAyMCBhdCA1OjMzIFBNIE1pY2hhZWwgUy4gVHNpcmtpbiAmbHQ7PGEg
aHJlZj0ibWFpbHRvOm1zdEByZWRoYXQuY29tIiB0YXJnZXQ9Il9ibGFuayI+bXN0QHJlZGhhdC5j
b208L2E+Jmd0OyB3cm90ZTo8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoE9uIFRodSwgT2N0
IDIyLCAyMDIwIGF0IDA1OjEwOjQzUE0gKzAzMDAsIE1hcmNlbCBBcGZlbGJhdW0gd3JvdGU6PGJy
Pg0KJmd0O8KgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAg
wqAmZ3Q7IE9uIFRodSwgT2N0IDIyLCAyMDIwIGF0IDU6MDEgUE0gTWljaGFlbCBTLiBUc2lya2lu
ICZsdDs8YSBocmVmPSJtYWlsdG86bXN0QHJlZGhhdC5jb20iIHRhcmdldD0iX2JsYW5rIj5tc3RA
cmVkaGF0LmNvbTwvYT4mZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgd3JvdGU6PGJyPg0KJmd0O8KgIMKg
IMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoE9uIFRodSwgT2N0IDIyLCAyMDIw
IGF0IDA0OjU1OjEwUE0gKzAzMDAsIE1hcmNlbCBBcGZlbGJhdW0gd3JvdGU6PGJyPg0KJmd0O8Kg
IMKgIMKgJmd0O8KgIMKgIMKgJmd0OyBIaSBEYXZpZCwgTWljaGFlbCw8YnI+DQomZ3Q7wqAgwqAg
wqAmZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0OyBPbiBU
aHUsIE9jdCAyMiwgMjAyMCBhdCAzOjU2IFBNIERhdmlkIEdpYnNvbiAmbHQ7PGEgaHJlZj0ibWFp
bHRvOmRnaWJzb25AcmVkaGF0LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmRnaWJzb25AcmVkaGF0LmNv
bTwvYT4mZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgd3JvdGU6PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8Kg
IMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDvCoCDCoCDCoE9uIFRo
dSwgMjIgT2N0IDIwMjAgMDg6MDY6NTUgLTA0MDA8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAg
wqAmZ3Q7wqAgwqAgwqAmcXVvdDtNaWNoYWVsIFMuIFRzaXJraW4mcXVvdDsgJmx0OzxhIGhyZWY9
Im1haWx0bzptc3RAcmVkaGF0LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPm1zdEByZWRoYXQuY29tPC9h
PiZndDsgd3JvdGU6PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0Ozxicj4NCiZndDvC
oCDCoCDCoCZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDsgT24gVGh1LCBPY3QgMjIsIDIwMjAg
YXQgMDI6NDA6MjZQTSArMDMwMCwgTWFyY2VsIEFwZmVsYmF1bTxicj4NCiZndDvCoCDCoCDCoHdy
b3RlOjxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDsgJmd0OyBG
cm9tOiBNYXJjZWwgQXBmZWxiYXVtICZsdDs8YSBocmVmPSJtYWlsdG86bWFyY2VsQHJlZGhhdC5j
b20iIHRhcmdldD0iX2JsYW5rIj5tYXJjZWxAcmVkaGF0LmNvbTwvYT4mZ3Q7PGJyPg0KJmd0O8Kg
IMKgIMKgJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0OyAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKg
Jmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0OyAmZ3Q7IER1cmluZyBQQ0llIFJvb3QgUG9ydCYj
Mzk7cyB0cmFuc2l0aW9uIGZyb20gUG93ZXItT2ZmIHRvPGJyPg0KJmd0O8KgIMKgIMKgUG93ZXIt
T04gKG9yPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgdmljZS12ZXJz
YSk8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7ICZndDsgdGhl
ICZxdW90O1Nsb3QgQ29udHJvbCBSZWdpc3RlciZxdW90OyBoYXMgdGhlICZxdW90O1Bvd2VyIElu
ZGljYXRvcjxicj4NCiZndDvCoCDCoCDCoENvbnRyb2wmcXVvdDs8YnI+DQomZ3Q7wqAgwqAgwqAm
Z3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7ICZndDsgc2V0IHRvICZxdW90O0JsaW5raW5nJnF1
b3Q7IGV4cHJlc3NpbmcgYSAmcXVvdDtwb3dlciB0cmFuc2l0aW9uJnF1b3Q7IG1vZGUuPGJyPg0K
Jmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0OyAmZ3Q7PGJyPg0KJmd0O8Kg
IMKgIMKgJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0OyAmZ3Q7IEFueSBob3RwbHVnIG9wZXJh
dGlvbiBkdXJpbmcgdGhlICZxdW90O3Bvd2VyIHRyYW5zaXRpb24mcXVvdDsgbW9kZSBpczxicj4N
CiZndDvCoCDCoCDCoG5vdDxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDvCoCDCoCDC
oHBlcm1pdHRlZDxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDsg
Jmd0OyBvciBhdCBsZWFzdCBub3QgZXhwZWN0ZWQgYnkgdGhlIEd1ZXN0IE9TIGxlYWRpbmcgdG8g
c3RyYW5nZTxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoGZhaWx1cmVzLjxicj4NCiZndDvC
oCDCoCDCoCZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDsgJmd0Ozxicj4NCiZndDvCoCDCoCDC
oCZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDsgJmd0OyBEZXRlY3QgYW5kIHJlZnVzZSBob3Rw
bHVnIG9wZXJhdGlvbnMgaW4gc3VjaCBjYXNlLjxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDC
oCZndDvCoCDCoCDCoCZndDsgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDvC
oCDCoCDCoCZndDsgJmd0OyBTaWduZWQtb2ZmLWJ5OiBNYXJjZWwgQXBmZWxiYXVtICZsdDs8YSBo
cmVmPSJtYWlsdG86bWFyY2VsLmFwZmVsYmF1bUBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5t
YXJjZWwuYXBmZWxiYXVtQGdtYWlsLmNvbTwvYT48YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0K
Jmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0OyAmZ3Q7IC0tLTxicj4NCiZn
dDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDsgJmd0O8KgIGh3L3BjaS9wY2ll
LmMgfCA3ICsrKysrKys8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAm
Z3Q7ICZndDvCoCAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspPGJyPg0KJmd0O8KgIMKg
IMKgJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0OyAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0
O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0OyAmZ3Q7IGRpZmYgLS1naXQgYS9ody9wY2kvcGNpZS5j
IGIvaHcvcGNpL3BjaWUuYzxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDvCoCDCoCDC
oCZndDsgJmd0OyBpbmRleCA1YjQ4YmFlMGY2Li4yZmU1YzE0NzNmIDEwMDY0NDxicj4NCiZndDvC
oCDCoCDCoCZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDsgJmd0OyAtLS0gYS9ody9wY2kvcGNp
ZS5jPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0OyAmZ3Q7ICsr
KyBiL2h3L3BjaS9wY2llLmM8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAg
wqAmZ3Q7ICZndDsgQEAgLTQxMCw2ICs0MTAsNyBAQCB2b2lkIHBjaWVfY2FwX3Nsb3RfcHJlX3Bs
dWdfY2I8YnI+DQomZ3Q7wqAgwqAgwqAoSG90cGx1Z0hhbmRsZXI8YnI+DQomZ3Q7wqAgwqAgwqAm
Z3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAqaG90cGx1Z19kZXYsIERldmljZVN0YXRlICpkZXYsPGJy
Pg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0OyAmZ3Q7wqAgwqAgwqAg
UENJRGV2aWNlICpob3RwbHVnX3BkZXYgPSBQQ0lfREVWSUNFKGhvdHBsdWdfZGV2KTs8YnI+DQom
Z3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7ICZndDvCoCDCoCDCoCB1aW50
OF90ICpleHBfY2FwID0gaG90cGx1Z19wZGV2LSZndDtjb25maWcgKzxicj4NCiZndDvCoCDCoCDC
oGhvdHBsdWdfcGRldi0mZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0O8KgIMKg
IMKgZXhwLmV4cF9jYXA7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKg
Jmd0OyAmZ3Q7wqAgwqAgwqAgdWludDMyX3Qgc2x0Y2FwID0gcGNpX2dldF93b3JkKGV4cF9jYXAg
Kzxicj4NCiZndDvCoCDCoCDCoFBDSV9FWFBfU0xUQ0FQKTs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7
wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7ICZndDsgK8KgIMKgIHVpbnQzMl90IHNsdGN0bCA9IHBj
aV9nZXRfd29yZChleHBfY2FwICs8YnI+DQomZ3Q7wqAgwqAgwqBQQ0lfRVhQX1NMVENUTCk7PGJy
Pg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0OyAmZ3Q7wqA8YnI+DQom
Z3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7ICZndDvCoCDCoCDCoCAvKiBD
aGVjayBpZiBob3QtcGx1ZyBpcyBkaXNhYmxlZCBvbiB0aGUgc2xvdCAqLzxicj4NCiZndDvCoCDC
oCDCoCZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDsgJmd0O8KgIMKgIMKgIGlmIChkZXYtJmd0
O2hvdHBsdWdnZWQgJmFtcDsmYW1wOyAoc2x0Y2FwICZhbXA7IFBDSV9FWFBfU0xUQ0FQX0hQQykg
PTxicj4NCiZndDvCoCDCoCDCoD0gMCkgezxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZn
dDvCoCDCoCDCoCZndDsgJmd0OyBAQCAtNDE4LDYgKzQxOSwxMiBAQCB2b2lkIHBjaWVfY2FwX3Ns
b3RfcHJlX3BsdWdfY2I8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAoSG90cGx1Z0hhbmRs
ZXI8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAqaG90cGx1Z19kZXYs
IERldmljZVN0YXRlICpkZXYsPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0O8KgIMKg
IMKgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgcmV0dXJuOzxicj4NCiZndDvCoCDCoCDCoCZndDvC
oCDCoCDCoCZndDvCoCDCoCDCoCZndDsgJmd0O8KgIMKgIMKgIH08YnI+DQomZ3Q7wqAgwqAgwqAm
Z3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7ICZndDvCoDxicj4NCiZndDvCoCDCoCDCoCZndDvC
oCDCoCDCoCZndDvCoCDCoCDCoCZndDsgJmd0OyArwqAgwqAgaWYgKChzbHRjdGwgJmFtcDsgUENJ
X0VYUF9TTFRDVExfUElDKSA9PTxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoFBDSV9FWFBf
U0xUQ1RMX1BXUl9JTkRfQkxJTkspPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0O8Kg
IMKgIMKgezxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDsgJmd0
OyArwqAgwqAgwqAgwqAgZXJyb3Jfc2V0ZyhlcnJwLCAmcXVvdDtIb3QtcGx1ZyBmYWlsZWQ6ICVz
IGlzIGluIFBvd2VyPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgVHJhbnNpdGlvbiZxdW90
Oyw8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7ICZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgREVWSUNFKGhvdHBsdWdfcGRldiktJmd0O2lkKTs8
YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7ICZndDsgK8KgIMKg
IMKgIMKgIHJldHVybjs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAm
Z3Q7ICZndDsgK8KgIMKgIH08YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAg
wqAmZ3Q7ICZndDsgKzxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZn
dDsgJmd0O8KgIMKgIMKgIHBjaWVfY2FwX3Nsb3RfcGx1Z19jb21tb24oUENJX0RFVklDRShob3Rw
bHVnX2RldiksPGJyPg0KJmd0O8KgIMKgIMKgZGV2LDxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDC
oCDCoGVycnApOzxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDsg
Jmd0O8KgIH3CoDxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDs8
YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7IFByb2JhYmx5IHRo
ZSBvbmx5IHdheSB0byBoYW5kbGUgZm9yIGV4aXN0aW5nIG1hY2hpbmUgdHlwZXMuPGJyPg0KJmd0
O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZn
dDs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7IEkgYWdyZWU8YnI+DQomZ3Q7wqAg
wqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7IMKgPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0
Ozxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDsgRm9yIG5ldyBv
bmVzLCBjYW4mIzM5O3Qgd2UgcXVldWUgaXQgaW4gaG9zdCBtZW1vcnkgc29tZXdoZXJlPzxicj4N
CiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAg
wqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDC
oCZndDvCoCDCoCDCoCZndDsgSSBhbSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgd2hhdCB3aWxsIGJl
IHRoZSBmbG93Ljxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDsgwqAgLSBUaGUgdXNl
ciBhc2tzIGZvciBhIGhvdHBsdWcgb3BlcmF0aW9uLjxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDC
oCDCoCZndDsgwqAgLcKgIFFFTVUgZGVmZXJyZWQgb3BlcmF0aW9uLjxicj4NCiZndDvCoCDCoCDC
oCZndDvCoCDCoCDCoCZndDsgQWZ0ZXIgdGhhdCB0aGUgb3BlcmF0aW9uIG1heSBzdGlsbCBmYWls
LCBob3cgd291bGQgdGhlIHVzZXIga25vdyBpZjxicj4NCiZndDvCoCDCoCDCoHRoZTxicj4NCiZn
dDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDsgb3BlcmF0aW9uPGJyPg0KJmd0O8KgIMKgIMKgJmd0
O8KgIMKgIMKgJmd0OyBzdWNjZWVkZWQgb3Igbm90Pzxicj4NCiZndDvCoCDCoCDCoCZndDs8YnI+
DQomZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgSG93IGNhbiBp
dCBmYWlsPyBJdCYjMzk7cyBqdXN0IGEgYnV0dG9uIHByZXNzIC4uLjxicj4NCiZndDvCoCDCoCDC
oCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0Ozxicj4NCiZn
dDvCoCDCoCDCoCZndDsgQ3VycmVudGx5IHdlIGhhdmUgJnF1b3Q7SG90cGx1ZyB1bnN1cHBvcnRl
ZC4mcXVvdDs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7IFdpdGggdGhpcyBjaGFuZ2Ugd2UgaGF2ZSAm
cXVvdDtHdWVzdC9TeXN0ZW0gbm90IHJlYWR5JnF1b3Q7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxi
cj4NCiZndDvCoCDCoCDCoEhvdHBsdWcgdW5zdXBwb3J0ZWQgaXMgbm90IGFuIGVycm9yIHRoYXQg
Y2FuIHRyaWdnZXIgd2l0aDxicj4NCiZndDvCoCDCoCDCoGEgd2VsbCBiZWhhdmVkIG1hbmFnZW1l
bnQgc3VjaCBhcyBsaWJ2aXJ0Ljxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAg
wqAmZ3Q7IMKgPGJyPg0KJmd0O8KgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDC
oCDCoCZndDsgwqA8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8Kg
IMKgIMKgJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgSSYjMzk7bSBub3QgYWN0dWFsbHkgY29udmlu
Y2VkIHdlIGNhbiYjMzk7dCBkbyB0aGF0IGV2ZW4gZm9yIGV4aXN0aW5nPGJyPg0KJmd0O8KgIMKg
IMKgbWFjaGluZTxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDvCoCDCoCDCoHR5cGVz
LsKgPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCZn
dDvCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7IElzIGEgR3Vl
c3QgdmlzaWJsZSBjaGFuZ2UsIEkgZG9uJiMzOTt0IHRoaW5rIHdlIGNhbiBkbyBpdC48YnI+DQom
Z3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7IMKgPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKg
IMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDvCoCDCoCDCoFNvIEkmIzM5
O20gYSBiaXQgaGVzaXRhbnQgdG8gc3VnZ2VzdCBnb2luZyBhaGVhZCB3aXRoIHRoaXMgd2l0aG91
dDxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDvCoCDCoCDCoGxvb2tpbmcgYSBiaXQg
Y2xvc2VyIGF0IHdoZXRoZXIgd2UgY2FuIGltcGxlbWVudCBhPGJyPg0KJmd0O8KgIMKgIMKgd2Fp
dC1mb3ItcmVhZHkgaW48YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqBx
ZW11LCByYXRoZXIgdGhhbiBmb3JjaW5nIGV2ZXJ5IHVzZXIgb2YgcWVtdSAoaHVtYW4gb3IgbWFj
aGluZSk8YnI+DQomZ3Q7wqAgwqAgwqB0byBkbzxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDC
oCZndDvCoCDCoCDCoHNvLjxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDs8YnI+DQom
Z3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKg
Jmd0OyBXaGlsZSBJIGFncmVlIGl0IGlzIGEgcGFpbiBmcm9tIHRoZSB1c2FiaWxpdHkgcG9pbnQg
b2Ygdmlldyw8YnI+DQomZ3Q7wqAgwqAgwqBob3RwbHVnPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8Kg
IMKgIMKgb3BlcmF0aW9uczxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCZndDsgYXJlIGFs
bG93ZWQgdG8gZmFpbC4gVGhpcyBpcyBub3QgbW9yZSB0aGFuIGEgY29ybmVyIGNhc2UsIGVuc3Vy
aW5nPGJyPg0KJmd0O8KgIMKgIMKgdGhlPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgcmln
aHQ8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7IHJlc3BvbnNlIChncmFjZWZ1bGx5
IGVycm9yaW5nIG91dCkgbWF5IGJlIGVub3VnaC48YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAg
wqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0OyBUaGFua3MsPGJyPg0KJmd0
O8KgIMKgIMKgJmd0O8KgIMKgIMKgJmd0OyBNYXJjZWw8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAg
wqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCZndDs8YnI+
DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqBJIGRvbiYjMzk7dCB0aGluayB0aGV5IGV2ZXIgZmFp
bGVkIGluIHRoZSBwYXN0IHNvIG1hbmFnZW1lbnQgaXMgdW5saWtlbHk8YnI+DQomZ3Q7wqAgwqAg
wqAmZ3Q7wqAgwqAgwqB0byBoYW5kbGUgdGhlIGZhaWx1cmUgYnkgcmV0cnlpbmcgLi4uPGJyPg0K
Jmd0O8KgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAm
Z3Q7IFRoYXQgd291bGQgcmVxdWlyZSBzb21lIG1hbmFnZW1lbnQgaGFuZGxpbmcsIHllcy48YnI+
DQomZ3Q7wqAgwqAgwqAmZ3Q7IEJ1dCBldmVuIHdpdGhvdXQgYSAmcXVvdDtyZXRyeSZxdW90Oywg
ZmFpbGluZ8KgaXMgYmV0dGVyIHRoYW4gc3RyYW5nZSBPUyBiZWhhdmlvci48YnI+DQomZ3Q7wqAg
wqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0OyBUcnlpbmcgYSBiZXR0ZXIgYWx0ZXJuYXRp
dmUgbGlrZSBkZWZlcnJpbmcgdGhlIG9wZXJhdGlvbiBmb3IgbmV3IG1hY2hpbmVzPGJyPg0KJmd0
O8KgIMKgIMKgJmd0OyB3b3VsZCBtYWtlIHNlbnNlLCBob3dldmVyIGlzIG91dCBvZiB0aGUgc2Nv
cGUgb2YgdGhpcyBwYXRjaDxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgRXhwYW5kIHRoZSBz
Y29wZSBwbGVhc2UuIFRoZSBzY29wZSBzaG91bGQgYmUgJnF1b3Q7c29sdmUgYSBwcm9ibGVtIHh4
JnF1b3Q7IG5vdDxicj4NCiZndDvCoCDCoCDCoCZxdW90O3NvbHZlIGEgcHJvYmxlbSB4eCBieSBk
b2luZyBhYmMmcXVvdDsuPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0
OyBUaGUgc2NvcGUgaXMgZGV0ZWN0aW5nIGEgaG90cGx1ZyBlcnJvciBlYXJseSBpbnN0ZWFkPGJy
Pg0KJmd0OyBwYXNzaW5nIHRvIHRoZSBHdWVzdCBPUyBhIGhvdHBsdWcgb3BlcmF0aW9uIHRoYXQg
d2Uga25vdyBpdCB3aWxsIGZhaWwuPGJyPg0KJmd0OyA8YnI+DQo8YnI+DQpSaWdodC4gQWZ0ZXIg
ZGV0ZWN0aW5nIGp1c3QgZmFpbGluZyB1bmNvbmRpdGlvbmFsbHkgaXQgYSBiaXQgdG9vPGJyPg0K
c2ltcGxpc3RpYyBJTUhPLjxicj48YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+
U2ltcGxpc3RpYyBkb2VzIG5vdCBtZWFuIHdyb25nIG9yIGluY29ycmVjdC48L2Rpdj48ZGl2Pkkg
ZmFpbCB0byBzZWUgd2h5IGl0IGlzIG5vdCBlbm91Z2guPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj5XaGF0IFFFTVUgY2FuIGRvIGJldHRlcj8gV2FpdCBhbiB1bmJvdW5kZWQgdGltZSBmb3IgdGhl
IGJsaW5raW5nIHRvIGZpbmlzaD88L2Rpdj48ZGl2PldoYXQgaWYgd2UgaGF2ZSBhIGJ1Z2d5IGd1
ZXN0IHdpdGggYSBrZXJuZWwgc3R1Y2sgaW4gYmxpbmtpbmc/PC9kaXY+PGRpdj5JcyBRRU1VJiMz
OTtzIHJlc3BvbnNpYmlsaXR5IHRvIGVtdWxhdGUgdGhlIG9wZXJhdG9yIGl0c2VsZj8gQmVjYXVz
ZSB0aGUgb3BlcmF0b3I8YnI+PC9kaXY+PGRpdj5pcyB0aGUgb25lIHdobyBpcyBzdXBwb3NlZCB0
byB3YWl0LjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzLDwv
ZGl2PjxkaXY+TWFyY2VsPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5bLi4uXcKgPC9kaXY+PC9k
aXY+PC9kaXY+DQo=
--00000000000003933a05b250ab62--

